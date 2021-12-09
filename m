Return-Path: <tglx@linutronix.de>
Received: from galois.linutronix.de (Galois.linutronix.de. [2a0a:51c0:0:12e:550::1])
        by gmr-mx.google.com with ESMTPS id e15si512809ljg.0.2021.12.09.00.37.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 00:37:08 -0800 (PST)
From: Thomas Gleixner <tglx@linutronix.de>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
In-Reply-To: <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211126230957.239391799@linutronix.de>
 <20211126232735.547996838@linutronix.de>
 <7daba0e2-73a3-4980-c3a5-a71f6b597b22@deltatee.com> <874k7ueldt.ffs@tglx>
 <6ba084d6-2b26-7c86-4526-8fcd3d921dfd@deltatee.com> <87ilwacwp8.ffs@tglx>
 <d6f13729-1b83-fa7d-3f0d-98d4e3f7a2aa@deltatee.com> <87v909bf2k.ffs@tglx>
 <20211130202800.GE4670@nvidia.com> <87o861banv.ffs@tglx>
 <20211201001748.GF4670@nvidia.com> <87mtlkaauo.ffs@tglx>
 <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com> <87pmqg88xq.ffs@tglx>
 <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com> <87k0go8432.ffs@tglx>
 <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com> <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
Date: Thu, 09 Dec 2021 09:37:06 +0100
Message-ID: <87sfv2yy19.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
To: "Tian, Kevin" <kevin.tian@intel.com>, "Jiang, Dave" <dave.jiang@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 09 2021 at 05:23, Kevin Tian wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> I don't see anything wrong with that. A subdevice is it's own entity and
>> VFIO can chose the most conveniant representation of it to the guest
>> obviously.
>> 
>> How that is backed on the host does not really matter. You can expose
>> MSI-X to the guest with a INTx backing as well.
>> 
>
> Agree with this point. How the interrupts are represented to the guest
> is orthogonal to how the backend resource is allocated. Physically MSI-X 
> and IMS can be enabled simultaneously on an IDXD device. Once 
> dynamic allocation is allowed for both, either one can be allocated for
> a subdevice (with only difference on supported #subdevices). 
>
> When an interrupt resource is exposed to the guest with the same type 
> (e.g. MSI-on-MSI or IMS-on-IMS), it can be also passed through to the 
> guest as long as a hypercall machinery is in place to get addr/data pair 
> from the host (as you suggested earlier).

As I pointed out in the conclusion of this thread, IMS is only going to
be supported with interrupt remapping in place on both host and guest.

As these devices are requiring a vIOMMU on the guest anyway (PASID, User
IO page tables), the required hypercalls are part of the vIOMMU/IR
implementation. If you look at it from the irqdomain hierarchy view:

                         |- PCI-MSI
  VECTOR -- [v]IOMMU/IR -|- PCI-MSI-X
                         |- PCI-IMS

So host and guest use just the same representation which makes a ton of
sense.

There are two places where this matters:

  1) The activate() callback of the IR domain

  2) The irq_set_affinity() callback of the irqchip associated with the
     IR domain

Both callbacks are allowed to fail and the error code is handed back to
the originating call site.

If you look at the above hierarchy view then MSI/MSI-X/IMS are all
treated in exactly the same way. It all becomes the common case.

No?

Thanks,

        tglx


