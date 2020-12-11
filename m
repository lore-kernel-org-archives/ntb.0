Return-Path: <david.laight@aculab.com>
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com. [185.58.86.151])
        by gmr-mx.google.com with ESMTPS id o135si309293wme.3.2020.12.11.14.06.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Dec 2020 14:06:27 -0800 (PST)
From: David Laight <David.Laight@ACULAB.COM>
Subject: RE: [patch 14/30] drm/i915/pmu: Replace open coded kstat_irqs() copy
Date: Fri, 11 Dec 2020 22:06:24 +0000
Message-ID: <6dd2eb7de7ad4a5893f057b90662718f@AcuMS.aculab.com>
References: <20201210192536.118432146@linutronix.de>
 <20201210194043.957046529@linutronix.de>
 <ad05af1a-5463-2a80-0887-7629721d6863@linux.intel.com>
 <87y2i4h54i.fsf@nanos.tec.linutronix.de>
 <d6cbfa118490459bb0671394f00323fc@AcuMS.aculab.com>
 <87eejwgib7.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87eejwgib7.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
To: 'Thomas Gleixner' <tglx@linutronix.de>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, afzal mohammed <afzal.mohd.ma@gmail.com>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, Russell King <linux@armlinux.org.uk>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>, Chris Wilson <chris@chris-wilson.co.uk>, Wambui Karuga <wambui.karugax@gmail.com>, Linus
 Walleij <linus.walleij@linaro.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Michal
 Simek <michal.simek@xilinx.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Tariq
 Toukan <tariqt@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Jakub
 Kicinski <kuba@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Leon
 Romanovsky <leon@kernel.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>
List-ID: <linux-ntb.googlegroups.com>

From: Thomas Gleixner
> Sent: 11 December 2020 21:11
>=20
> On Fri, Dec 11 2020 at 14:19, David Laight wrote:
> > From: Thomas Gleixner
> >> You can't catch that. If this really becomes an issue you need a
> >> sequence counter around it.
> >
> > Or just two copies of the high word.
> > Provided the accesses are sequenced:
> > writer:
> > =09load high:low
> > =09add small_value,high:low
> > =09store high
> > =09store low
> > =09store high_copy
> > reader:
> > =09load high_copy
> > =09load low
> > =09load high
> > =09if (high !=3D high_copy)
> > =09=09low =3D 0;
>=20
> And low =3D 0 is solving what? You need to loop back and retry until it's
> consistent and then it's nothing else than an open coded sequence count.

If it is a counter or timestamp then the high:0 value happened
some time between when you started trying to read the value and
when you finished trying to read it.

As such it is a perfectly reasonable return value.

=09David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1=
PT, UK
Registration No: 1397386 (Wales)

