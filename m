Return-Path: <kevin.tian@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id w5si279954ede.3.2021.12.11.18.14.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Dec 2021 18:14:17 -0800 (PST)
From: "Tian, Kevin" <kevin.tian@intel.com>
Subject: RE: [patch 21/32] NTB/msi: Convert to msi_on_each_desc()
Date: Sun, 12 Dec 2021 02:14:10 +0000
Message-ID: <BL1PR11MB5271BFC6B2218CF7E9151EE88C739@BL1PR11MB5271.namprd11.prod.outlook.com>
References: <f4cc305b-a329-6d27-9fca-b74ebc9fa0c1@intel.com>
 <878rx480fk.ffs@tglx>
 <BN9PR11MB52765F2EF8420C60FD5945D18C709@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87sfv2yy19.ffs@tglx> <20211209162129.GS6385@nvidia.com>
 <878rwtzfh1.ffs@tglx> <20211209205835.GZ6385@nvidia.com>
 <8735n1zaz3.ffs@tglx> <87sfv1xq3b.ffs@tglx>
 <BN9PR11MB527619B099061B3814EB40408C719@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20211210123938.GF6385@nvidia.com>
 <BN9PR11MB5276B2584F928B4BFD4573428C729@BN9PR11MB5276.namprd11.prod.outlook.com>
 <87lf0qvfze.ffs@tglx>
In-Reply-To: <87lf0qvfze.ffs@tglx>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Return-Path: kevin.tian@intel.com
To: Thomas Gleixner <tglx@linutronix.de>, Jason Gunthorpe <jgg@nvidia.com>
Cc: "Jiang, Dave" <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, LKML <linux-kernel@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>, Alex Williamson <alex.williamson@redhat.com>, "Dey, Megha" <megha.dey@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>, "Rodel, Jorg" <jroedel@suse.de>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

Hi, Thomas,

> From: Thomas Gleixner <tglx@linutronix.de>
> Sent: Sunday, December 12, 2021 8:12 AM
>=20
> Kevin,
>=20
> On Sat, Dec 11 2021 at 07:52, Kevin Tian wrote:
> >> From: Jason Gunthorpe <jgg@nvidia.com>
> >> > Then Qemu needs to find out the GSI number for the vIRTE handle.
> >> > Again Qemu doesn't have such information since it doesn't know
> >> > which MSI[-X] entry points to this handle due to no trap.
> >>
> >> No this is already going wrong. qemu *cannot* know the MSI information
> >> because there is no MSI information for IMS.
> >
> > I haven't thought of IMS at this step. The IR approach applies to
> > all types of interrupt storages, thus I'm more interested in how it
> > affect the storages which are already virtualized today (MSI[-X]
> > in my thought practice).
>=20
> They are not any different. As I explained several times now IMS is
> nothing new at all. It existed since the invention of Message Signaled
> interrupts. Why?
>=20
> The principle behind Message Signaled Interrupts is:
>=20
>     Device writes DATA to ADDRESS which raises an interrupt in a CPU
>=20
> Message Signaled Interrupts obviously need some place to store the
> ADDRESS/DATA pair so that the device can use it for raising an
> interrupt, i.e. an
>=20
>    Interrupt Message Store, short IMS.
>=20
> PCI/MSI was the first implementation of this and the storage was defined
> to be at a specified and therefore uniform and device independent place.
>=20
> PCI/MSI-X followed the same approch. While it solved quite some of the
> shortcomings of PCI/MSI it still has a specificed and uniform and device
> independent place to store the message (ADDRESS/DATA pair)
>=20
> Now the PCI wizards figured out that PCI/MSI[-X] is not longer up to the
> task for various reasons and came up with the revolutionary new concept
> of IMS, aka Interrupt Message Store. where the device defines where the
> message is stored.
>=20
> IOW, this is coming back full circle to the original problem of where to
> store the message, i.e. the ADDRESS/DATA pair so that the device can
> raise an interrupt in a CPU, which requires - drum roll - an
>=20
>    Interrupt Message Store, short IMS.
>=20
> So you simply have to look at it from a pure MSI (not PCI/MSI) point
> of view:
>=20
>    MSI at the conceptual level requires storage for the ADDRESS/DATA
>    pair at some place so that the device or the compute unit embedded in
>    the device can write DATA to ADDRESS.
>=20
> That's it. Not more, not less.
>=20
> When you look at it from this perspective, then you'll realize that
>=20
>      PCI/MSI and PCI/MSI-X are just implementations of IMS
>=20
> Not more, not less. The fact that they have very strict rules about the
> storage space and the fact that they are mutually exclusive does not
> change that at all.
>=20
> That's where a lot of the confusion comes from. If you go back to all
> the IDXD/IMS discussions which happened over time then you'll figure out
> that _all_ of us where coming from the same wrong assumption:
>=20
>     IMS is new and it's just another exclusive variant of PCI/MSI and
>     PCi/MSI-X.
>=20
> It took _all_ of us quite some time to realize that we need to look at
> it from the other way around.
>=20
> There was surely some other conceptual confusion vs. subdevices, queues
> and whatever involved which contributed to that. Water under the bridge.
>=20
> Coming back to your initial question:
>=20
> > I haven't thought of IMS at this step. The IR approach applies to
> > all types of interrupt storages, thus I'm more interested in how it
> > affect the storages which are already virtualized today (MSI[-X]
> > in my thought practice).
>=20
> Stop focussing on implementation details. Focus on the general concept
> instead. See above.
>=20

I have no any problem on understanding above relational. This has
been acked multiple times in my previous replies.

I just continue the thought practice along that direction to see what
the host flow will be like (step by step). Looking at the current=20
implementation is just one necessary step in my thought practice to=20
help refine the picture. When I found something which may be=20
worth being aligned then I shared to avoid follow a wrong direction=20
too far.

If both of your think it simply adds noise to this discussion, I can
surely hold back and focus on 'concept' only.

Thanks
Kevin
