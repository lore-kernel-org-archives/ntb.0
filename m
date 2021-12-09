Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [193.142.43.55])
        by gmr-mx.google.com with ESMTPS id r6si48594wrj.2.2021.12.09.12.32.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:32:43 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <20211209162129.GS6385@nvidia.com>
References: <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
Date: Thu, 09 Dec 2021 21:32:42 +0100
Message-ID: <878rwtzfh1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 09 2021 at 12:21, Jason Gunthorpe wrote:
> On Thu, Dec 09, 2021 at 09:37:06AM +0100, Thomas Gleixner wrote:
> If we keep the MSI emulation in the hypervisor then MSI != IMS.  The
> MSI code needs to write a addr/data pair compatible with the emulation
> and the IMS code needs to write an addr/data pair from the
> hypercall. Seems like this scenario is best avoided!
>
> From this perspective I haven't connected how virtual interrupt
> remapping helps in the guest? Is this a way to provide the hypercall
> I'm imagining above?

That was my thought to avoid having different mechanisms.

The address/data pair is computed in two places:

  1) Activation of an interrupt
  2) Affinity setting on an interrupt

Both configure the IRTE when interrupt remapping is in place.

In both cases a vector is allocated in the vector domain and based on
the resulting target APIC / vector number pair the IRTE is
(re)configured.

So putting the hypercall into the vIRTE update is the obvious
place. Both activation and affinity setting can fail and propagate an
error code down to the originating caller.

Hmm?

Thanks,

        tglx


