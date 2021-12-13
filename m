Return-Path: <kevin.tian@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id e2si556353wre.5.2021.12.12.23.50.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 23:50:57 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Mon, 13 Dec 2021 07:50:50 +0000
Message-ID: <BN9PR11MB52766327C636245CFA8C9E248C749@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20211209205835.GZ6385@nvidia.com> <8735n1zaz3.ffs@tglx>
 <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com> <87fsr0xp31.ffs@tglx>
 <BN9PR11MB527625E8A9BB854F3C0D19AE8C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <875yrvwavf.ffs@tglx>
 <BL1PR11MB5271326D39DAB692F07587768C739@BL1PR11MB5271.namprd11.prod.outlook.com>
 <87fsqxv8zf.ffs@tglx> <20211212233711.GN6385@nvidia.com>
In-Reply-To: <20211212233711.GN6385@nvidia.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Jason Gunthorpe <jgg@nvidia.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Monday, December 13, 2021 7:37 AM
>=20
> On Sun, Dec 12, 2021 at 09:55:32PM +0100, Thomas Gleixner wrote:
> > Kevin,
> >
> > On Sun, Dec 12 2021 at 01:56, Kevin Tian wrote:
> > >> From: Thomas Gleixner <tglx@linutronix.de>
> > >> All I can find is drivers/iommu/virtio-iommu.c but I can't find anyt=
hing
> > >> vIR related there.
> > >
> > > Well, virtio-iommu is a para-virtualized vIOMMU implementations.
> > >
> > > In reality there are also fully emulated vIOMMU implementations (e.g.
> > > Qemu fully emulates Intel/AMD/ARM IOMMUs). In those configurations
> > > the IR logic in existing iommu drivers just apply:
> > >
> > > 	drivers/iommu/intel/irq_remapping.c
> > > 	drivers/iommu/amd/iommu.c
> >
> > thanks for the explanation. So that's a full IOMMU emulation. I was mor=
e
> > expecting a paravirtualized lightweight one.
>=20
> Kevin can you explain what on earth vIR is for and how does it work??
>=20
> Obviously we don't expose the IR machinery to userspace, so at best
> this is somehow changing what the MSI trap does?
>=20

Initially it was introduced for supporting more than 255 vCPUs. Due to=20
full emulation this capability can certainly support other vIR usages
as observed on bare metal.

vIR doesn't rely on the physical IR presence.

First if the guest doesn't have vfio device then the physical capability
doesn't matter.

Even with vfio device, IR by definition is just about remapping instead
of injection (talk about this part later). The interrupts are always routed
to the host handler first (vfio_msihandler() in this case), which then=20
triggers irqfd to call virtual interrupt injection handler (irqfd_wakeup())
in kvm.

This suggests a clear role split between vfio and kvm:

  - vfio is responsible for irq allocation/startup as it is the device driv=
er;
  - kvm takes care of virtual interrupt injection, being a VMM;

The two are connected via irqfd.

Following this split vIR information is completely hidden in userspace.
Qemu calculates the routing information between vGSI and vCPU
(with or without vIR, and for whatever trapped interrupt storages)=20
and then registers it to kvm.

When kvm receives a notification via irqfd, it follows irqfd->vGSI->vCPU
and injects a virtual interrupt into the target vCPU.

Then comes an interesting scenario about IOMMU posted interrupt (PI).
This capability allows the IR engine directly converting a physical
interrupt into virtual and then inject it into the guest. Kinda offloading=
=20
the virtual routing information into the hardware.

This is currently achieved via IRQ bypass manager, which helps connect=20
vfio (IRQ producer) to kvm (IRQ consumer) around a specific Linux irq=20
number. Once the connection is established, kvm calls=20
irq_set_vcpu_affinity() to update IRTE with virtual routing information=20
for that irq number.

With that design Qemu doesn't know whether IR or PI is enabled=20
physically. It always talks to vfio for having IRQ resource allocated and
to kvm for registering virtual routing information.

Then adding the new hypercall machinery into this picture:

  1) The hypercall needs to carry all necessary virtual routing=20
     information due to no-trap;

  2) Before querying IRTE data/pair, Qemu needs to complete necessary
     operations as of today to have IRTE ready:

	a) Register irqfd and related GSI routing info to kvm
	b) Allocates/startup IRQs via vfio;

     When PI is enabled, IRTE is ready only after both are completed.

  3) Qemu gets IRTE data/pair from kernel and return to the guest.

Thanks
Kevin
