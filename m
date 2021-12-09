Return-Path: <jgg@nvidia.com>
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com. [40.107.236.81])
        by gmr-mx.google.com with ESMTPS id pi11si995038pjb.2.2021.12.09.08.21.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 08:21:31 -0800 (PST)
Date: Thu, 9 Dec 2021 12:21:29 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211209162129.GS6385@nvidia.com>
References: <20211201001748.GF4670@nvidia.com>
 <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfv2yy19.ffs@tglx>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> On Thu, Dec 09 2021 at 05:23, Kevin Tian wrote:
> >> From: Thomas Gleixner <tglx@linutronix.de>
> >> I don't see anything wrong with that. A subdevice is it's own entity and
> >> VFIO can chose the most conveniant representation of it to the guest
> >> obviously.
> >> 
> >> How that is backed on the host does not really matter. You can expose
> >> MSI-X to the guest with a INTx backing as well.
> >> 
> >
> > Agree with this point. How the interrupts are represented to the guest
> > is orthogonal to how the backend resource is allocated. Physically MSI-X 
> > and IMS can be enabled simultaneously on an IDXD device. Once 
> > dynamic allocation is allowed for both, either one can be allocated for
> > a subdevice (with only difference on supported #subdevices). 
> >
> > When an interrupt resource is exposed to the guest with the same type 
> > (e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the 
> > guest as long as a hypercall machinery is in place to get addr/data pair 
> > from the host (as you suggested earlier).
> 
> As I pointed out in the conclusion of this thread, IMS is only going to
> be supported with interrupt remapping in place on both host and guest.
> 
> As these devices are requiring a vIOMMU on the guest anyway (PASID, User
> IO page tables), the required hypercalls are part of the vIOMMU/IR
> implementation. If you look at it from the irqdomain hierarchy view:

It is true for IDXD, but mlx5 will work without a PASID or vIOMMU in a
guest today, and there is no reason to imagine some future IMS would
have any different device requirements from MSI-X.

Though, vIOMMU operating in bypass mode seems like it is fine if it
helps the solution.

> If you look at the above hierarchy view then MSI/MSI-X/IMS are all
> treated in exactly the same way. It all becomes the common case.

Unfortunately in a guest they are not all the same - it is like the
PPC code I saw messing with MSI today - MSI setup is a hypercall,
either explicitly or implicitly by trapping device registers.

So MSI is special compared to everything else because MSI has that
hypervisor intrusion.

My ideal outcome would be to have the guest negotiate some new
capability with the hypervisor where the guest promises to use new
hypecalls to get addr/data pairs and the hypervisor removes all the
emulation around the PCI MSI. Then MSI == IMS again and we can have
everything treated in exactly the same way. Hypervisor doesn't care
how the guest tells the origin device what the addr/data pair is.

This moves the hypervisor trap to setup the interrupt remapping from
the MSI emulation to the new hypercall.

If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
MSI code needs to write a addr/data pair compatible with the emulation
and the IMS code needs to write an addr/data pair from the
hypercall. Seems like this scenario is best avoided!

From this perspective I haven't connected how virtual interrupt
remapping helps in the guest? Is this a way to provide the hypercall
I'm imagining above?

Jason
