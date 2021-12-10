Return-Path: <kevin.tian@intel.com>
Received: from mga18.intel.com (mga18.intel.com. [134.134.136.126])
        by gmr-mx.google.com with ESMTPS id c15si145290lfv.8.2021.12.09.23.29.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Dec 2021 23:29:08 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Fri, 10 Dec 2021 07:29:01 +0000
Message-ID: <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <8c2262ba-173e-0007-bc4c-94ec54b2847d@intel.com>
 <87pmqg88xq.ffs@tglx> <df00b87e-00dc-d998-8b64-46b16dba46eb@intel.com>
 <87k0go8432.ffs@tglx> <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
In-Reply-To: <87sfv1xq3b.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, Joerg Roedel <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Friday, December 10, 2021 8:26 AM
>=20
> On Thu, Dec 09 2021 at 23:09, Thomas Gleixner wrote:
> > On Thu, Dec 09 2021 at 16:58, Jason Gunthorpe wrote:
> >> Okay, I think I get it. Would be nice to have someone from intel
> >> familiar with the vIOMMU protocols and qemu code remark what the
> >> hypervisor side can look like.
> >>
> >> There is a bit more work here, we'd have to change VFIO to somehow
> >> entirely disconnect the kernel IRQ logic from the MSI table and
> >> directly pass control of it to the guest after the hypervisor IOMMU IR
> >> secures it. ie directly mmap the msi-x table into the guest
> >
> > That makes everything consistent and a clear cut on all levels, right?
>=20
> Let me give a bit more rationale here, why I think this is the right
> thing to do. There are several problems with IMS both on the host and on
> the guest side:
>=20
>   1) Contrary to MSI/MSI-X the address/data pair is not completely
>      managed by the core. It's handed off to driver writers in the
>      hope they get it right.
>=20
>   2) Without interrupt remapping there is a fundamental issue on x86
>      for the affinity setting case, as there is no guarantee that
>      the magic protocol which we came up with (see msi_set_affinity()
>      in the x86 code) is correctly implemented at the driver level or
>      that the update is truly atomic so that the problem does not
>      arise. My interrest in chasing these things is exactly zero.
>=20
>      With interrupt remapping the affinity change happens at the IRTE
>      level and not at the device level. It's a one time setup for the
>      device.

This is a good rationale for making IMS depend on IR on native.

>=20
>      Just for the record:
>=20
>      The ATH11 thing does not have that problem by pure luck because
>      multi-vector MSI is not supported on X86 unless interrupt
>      remapping is enabled.
>=20
>      The switchtec NTB thing will fall apart w/o remapping AFAICT.
>=20
>   3) With remapping the message for the device is constructed at
>      allocation time. It does not change after that because the affinity
>      change happens at the remapping level, which eliminates #2 above.
>=20
>      That has another advantage for IMS because it does not require any
>      synchronization with the queue or whatever is involved. The next
>      interrupt after the change at the remapping level ends up on the
>      new target.

Yes

>=20
>   4) For the guest side we agreed that we need an hypercall because the
>      host can't trap the write to the MSI[-X] entry anymore.

To be accurate I'd like to not call it "can't trap". The host still traps t=
he=20
MSI/MSI-X entry if the hypercall is not used. This is for current guest=20
OS which doesn't have this hypercall mechanism. For future new guest
OS which will support this machinery then a handshake process from
such guest will disable the trap for MSI-X and map it for direct guest
access in the fly.

MSI has to be always trapped although the guest has acquired the right=20
data/addr pair via the hypercall, since it's a PCI config capability.

>=20
>      Aside of the fact that this creates a special case for IMS which is
>      undesirable in my opinion, it's not really obvious where the
>      hypercall should be placed to work for all scenarios so that it can
>      also solve the existing issue of silent failures.
>=20
>   5) It's not possible for the kernel to reliably detect whether it is
>      running on bare metal or not. Yes we talked about heuristics, but
>      that's something I really want to avoid.

How would the hypercall mechanism avoid such heuristics?

>=20
> When looking at the above I came to the conclusion that the consistent
> way is to make IMS depend on IR both on the host and the guest as this
> solves all of the above in one go.
>=20
> How would that work? With IR the irqdomain hierarchy looks like this:
>=20
>                    |--IO/APIC
>                    |--MSI
>     vector -- IR --|--MIX-X
>                    |--IMS
>=20
> There are several context where this matters:
>=20
>   1) Allocation of an interrupt, e.g. pci_alloc_irq_vectors().
>=20
>   2) Activation of an interrupt which happens during allocation and/or
>      at request_irq() time
>=20
>   3) Interrupt affinity setting
>=20
> #1 Allocation
>=20
>    That allocates an IRTE, which can fail
>=20
> #2 Activation
>=20
>    That's the step where actually a CPU vector is allocated, where the
>    IRTE is updated and where the device message is composed to target
>    the IRTE.
>=20
>    On X86 activation is happening twice:
>=20
>    1) During allocation it allocates a special CPU vector which is
>       handed out to all allocated interrupts. That's called reservation
>       mode. This was introduced to prevent vector exhaustion for two
>       cases:
>=20
>        - Devices allocating tons of MSI-X vectors without using
>          them. That obviously needs to be fixed at the device driver
>          level, but due to the fact that post probe() allocation is not
>          supported, that's not always possible
>=20
>        - CPU hotunplug
>=20
>          All vectors targeting the outgoing CPU need to be migrated to a
>          new target CPU, which can result in exhaustion of the vector
>          space.
>=20
>          Reservation mode avoids that because it just uses a unique
>          vector for all interrupts which are allocated but not
>          requested.
>=20
>     2) On request_irq()
>=20
>        As the vector assigned during allocation is just a place holder
>        to make the MSI hardware happy it needs to be replaced by a
>        real vector.
>=20
>    Both can fail and the error is propagated through the call chain
>=20
> #3 Changing the interrupt affinity
>=20
>    This obviously needs to allocate a new target CPU vector and update
>    the IRTE.
>=20
>    Allocating a new target CPU vector can fail.
>=20
> When looking at it from the host side, then the host needs to do the
> same things:
>=20
>   1) Allocate an IRTE for #1
>=20
>   2) Update the IRTE for #2 and #3
>=20
> But that does not necessarily mean that we need two hypercalls. We can
> get away with one in the code which updates the IRTE and that would be
> the point where the host side has to allocate the backing host
> interrupt, which would replace that allocate on unmask mechanism which
> is used today.
>=20
> It might look awkward on first sight that an IRTE update can fail, but
> it's not that awkward when put into context:
>=20
>   The first update happens during activation and activation can fail for
>   various reasons.
>=20
> The charm is that his works for everything from INTx to IMS because all
> of them go through the same procedure, except that INTx (IO/APIC) does
> not support the reservation mode dance.
>=20
> Thoughts?
>=20

Above sounds the right direction to me. and here is more thought=20
down the road.

First let's look at how the interrupt is delivered to the guest today.

With IR the physical interrupt is first delivered to the host, then=20
converted into a virtual interrupt and finally injected to the guest.
Let's put posted interrupt aside since it's an optional platform capability=
.

    HW interrupt
        vfio_msihandler(): ->irqfd
            kvm_arch_set_irq_inatomic()
                kvm_set_msi_irq()
                kvm_irq_delivery_to_apic_fast()

Virtual interrupt injection is based on the virtual routing information=20
registered by Qemu, via KVM_SET_GSI_ROUTING(gsi, routing_info).=20

GSI is later associated to irqfd via KVM_IRQFD(irqfd, gsi).=20

Qemu composes the virtual routing information based on trapping
of various interrupt storages (INTx, MSI, MSI-X, etc.). When IR is=20
enabled in the vIOMMU, the routing info is composed by combining
the storage entry and vIRTE entry.

Now adding the new hypercall machinery to above flow, obviously
we also want the hypercall to carry the virtual routing information=20
(vIRTE) to the host beside acquiring data/addr pair from the host.=20
Without trap this information is now hidden from Qemu.

Then Qemu needs to find out the GSI number for the vIRTE handle.=20
Again Qemu doesn't have such information since it doesn't know=20
which MSI[-X] entry points to this handle due to no trap.

This implies that we may also need carry device ID, #msi entry, etc.=20
in the hypercall, so Qemu can associate the virtual routing info
to the right [irqfd, gsi].

In your model the hypercall is raised by IR domain. Do you see
any problem of finding those information within IR domain?

Thanks
Kevin
