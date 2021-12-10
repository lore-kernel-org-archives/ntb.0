Return-Path: <jgg@nvidia.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2054.outbound.protection.outlook.com. [40.107.223.54])
        by gmr-mx.google.com with ESMTPS id f38si614972qtb.3.2021.12.10.04.39.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 04:39:42 -0800 (PST)
Date: Fri, 10 Dec 2021 08:39:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Message-ID: <20211210123938.GF6385@nvidia.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx>
 <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx>
 <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
Return-Path: jgg@nvidia.com
MIME-Version: 1.0
To: "Tian, Kevin" <kevin.tian@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Dec 10, 2021 at 07:29:01AM +0000, Tian, Kevin wrote:
> >   5) It's not possible for the kernel to reliably detect whether it is
> >      running on bare metal or not. Yes we talked about heuristics, but
> >      that's something I really want to avoid.
> 
> How would the hypercall mechanism avoid such heuristics?

It is clever, we don't have an vIOMMU that supplies vIR today, so by
definition all guests are excluded and only bare metal works.

> > The charm is that his works for everything from INTx to IMS because all
> > of them go through the same procedure, except that INTx (IO/APIC) does
> > not support the reservation mode dance.

Do we even have vIOAPIC?

> > Thoughts?

It seems reasonable - do you have any idea how this all would work on
ARM too? IMS on baremetal ARM is surely interesting. I assume they
have a similar issue with trapping the MSI

> Then Qemu needs to find out the GSI number for the vIRTE handle. 
> Again Qemu doesn't have such information since it doesn't know 
> which MSI[-X] entry points to this handle due to no trap.

No this is already going wrong. qemu *cannot* know the MSI information
because there is no MSI information for IMS.

All qemu should get is the origin device information and data about
how the guest wants the interrupt setup.

Forget about guests and all of this complexity, design how to make
VFIO work with IMS in pure userspace like DPDK.

We must have a VFIO ioctl to acquire a addr/data pair and link it to
an event fd.

I'm not sure exactly how this should be done, it is 90% of what IMS
is, except the VFIO irq_chip cannot touch any real HW and certainly
cannot do mask/unmask..

Maybe that is OK now that it requires IR?

Jason
