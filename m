Return-Path: <lsun@mellanox.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20068.outbound.protection.outlook.com. [40.107.2.68])
        by gmr-mx.google.com with ESMTPS id i2-v6si1571478ejj.1.2019.01.22.05.36.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 05:36:06 -0800 (PST)
From: Liming Sun <lsun@mellanox.com>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Date: Tue, 22 Jan 2019 13:36:04 +0000
Message-ID: 
 <DB6PR05MB3223778EE7090BBC8744C9F8A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: 
 <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
 <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>,<20190122122022.ipn3jdfnxthhphrs@axis.com>,<DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
In-Reply-To: 
 <DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, David Woods <dwoods@mellanox.com>, Robin Murphy <robin.murphy@arm.com>, arm-soc <arm@kernel.org>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Christoph Hellwig <hch@lst.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>



From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Sent: Tuesday, January 22, 2019 7:20 AM
To: Arnd Bergmann
Cc: Liming Sun; Olof Johansson; David Woods; Robin Murphy; arm-soc; DTML; L=
inux ARM; linux-pci; linux-ntb@googlegroups.com; Christoph Hellwig; virtual=
ization@lists.linux-foundation.org
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side R=
shim driver
=A0=20

On Fri, Jan 18, 2019 at 05:02:21PM +0100, Arnd Bergmann wrote:
>> On Thu, Nov 1, 2018 at 5:49 PM Liming Sun <lsun@mellanox.com> wrote:
>> >
>> > An external host can connect to a Mellanox BlueField SoC via an
>> > interface called Rshim. The Rshim driver provides boot, console,
>> > and networking services over this interface. This commit is
>> > the common driver where the other backend (transport) driver will
>> > use.
>> >
>> > Reviewed-by: David Woods <dwoods@mellanox.com>
>> > Signed-off-by: Liming Sun <lsun@mellanox.com>
>>=20
>> Hi Liming,
>>=20
>> I've taken a new look at your patch series for drivers/soc/ now,
>> thanks for your continued submissions.
>>=20
>> This is again just a set of very high-level comments, but I think we
>> should resolve some of the fundamental questions first.
>> Incidentally, Vincent Whitchurch has recently posted another
>> patch series with a very similar intention, but for other hardware
>> and taking a different approach.
>>=20
>> In both cases, the idea is to use virtio based drivers to provide
>> services from a host machine into another Linux instance running
>> on an embedded system behind a PCIe slot or similar. Your
>> Bluefield SoC patches are well written, but are intentionally
>> kept specific to a particular use case and tied to one piece
>> of hardware. In contrast, Vincent uses the existing code from
>> drivers/misc/mic/vop/ that is equally hardware specific, but he
>> extends it to be applicable to other hardware as well.
>>=20
>> It would be good if you could look at each other's approaches
>> to see where we could take it from here. I think ideally we
>> should have a common driver framework for doing the same
>> thing across both of your devices and as well as others.

> As far as I can see the biggest difference is that Rshim appears to
> support interfaces which do not have shared memory between the host and
> the card, which means that it has to jump through a lot more hoops to
> make virtio work.

> For example, the card side seems to use normal virtio-net and
> virto-console drivers, but the drivers/soc/mellanox/tmfifo.c driver,
> also running on the card, appears to have to actually look inside the
> virtqueues and shuffle the data over the TmFifo interface, and this
> driver has hard-coded support for only network and console, since it
> apparently needs to know the details of how the virtio drivers use their
> virtqueues (see tmfifo_virtio_rxtx()).

> And the host side appears to _also_ run the virtio-net driver and there
> the drivers/soc/mellanox/host/rshim_net.c code instead has to look
> inside the virtqueues and shuffle the data over the other side of the
> TmFifo interface.

> So to me this looks very different from a traditional virtio
> driver/device setup (which is what mic/vop uses).=A0 I may be missing
> something, but I don't quite understand why it's even using virtio in
> the first place.

Thanks  Vincent! This appears to be very good summary of this driver
does on the tmfifo part and the difference between  mic/vop. The fifo is
accessed by=A0register instead of shared memory.

The reason to use virtio framework is that it can be=A0easily used to add
more virtual devices as needed without implementing driver details for
each one. For example, the device side supports console and networking
for now over the FIFO. It only needs to implement function=20
tmfifo_virtio_rxtx() once to take care of the virtqueues=A0Rx/Tx, which are
shared by all virtual devices. With minimum changes, we could easily add
another device over tmfifo, like a virtio block device, since the queue
handling is already there.=20

The host side handles the virtqueues as well in rshim_net.c. It behaves
like a peer-to-peer to the device side while the tmfifo behaves like a
'wire' (transport) to pass data between the host and the device without
worrying about the data details.=
