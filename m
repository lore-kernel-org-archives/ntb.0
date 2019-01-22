Return-Path: <lsun@mellanox.com>
Received: from EUR02-VE1-obe.outbound.protection.outlook.com (mail-eopbgr20056.outbound.protection.outlook.com. [40.107.2.56])
        by gmr-mx.google.com with ESMTPS id l31si1994928edb.5.2019.01.22.05.27.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Jan 2019 05:27:06 -0800 (PST)
From: Liming Sun <lsun@mellanox.com>
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side
 Rshim driver
Date: Tue, 22 Jan 2019 13:27:03 +0000
Message-ID: 
 <DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980@DB6PR05MB3223.eurprd05.prod.outlook.com>
References: 
 <b143b40446c1870fb8d422b364ead95d54552be9.1527264077.git.lsun@mellanox.com>
 <1541089538-175682-1-git-send-email-lsun@mellanox.com>
 <1541089538-175682-5-git-send-email-lsun@mellanox.com>
 <CAK8P3a2NRbEaS_EJNtBaZ3GCUtRiH2rUDRzJFjvcw2ZacZM1qw@mail.gmail.com>,<20190122122022.ipn3jdfnxthhphrs@axis.com>
In-Reply-To: <20190122122022.ipn3jdfnxthhphrs@axis.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980DB6PR05MB3223eurp_"
MIME-Version: 1.0
To: Vincent Whitchurch <vincent.whitchurch@axis.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, David Woods <dwoods@mellanox.com>, Robin Murphy <robin.murphy@arm.com>, arm-soc <arm@kernel.org>, DTML <devicetree@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-pci <linux-pci@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, Christoph Hellwig <hch@lst.de>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-ID: <linux-ntb.googlegroups.com>

--_000_DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980DB6PR05MB3223eurp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



________________________________
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Sent: Tuesday, January 22, 2019 7:20 AM
To: Arnd Bergmann
Cc: Liming Sun; Olof Johansson; David Woods; Robin Murphy; arm-soc; DTML; L=
inux ARM; linux-pci; linux-ntb@googlegroups.com; Christoph Hellwig; virtual=
ization@lists.linux-foundation.org
Subject: Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host side R=
shim driver

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
>>
>> Hi Liming,
>>
>> I've taken a new look at your patch series for drivers/soc/ now,
>> thanks for your continued submissions.
>>
>> This is again just a set of very high-level comments, but I think we
>> should resolve some of the fundamental questions first.
>> Incidentally, Vincent Whitchurch has recently posted another
>> patch series with a very similar intention, but for other hardware
>> and taking a different approach.
>>
>> In both cases, the idea is to use virtio based drivers to provide
>> services from a host machine into another Linux instance running
>> on an embedded system behind a PCIe slot or similar. Your
>> Bluefield SoC patches are well written, but are intentionally
>> kept specific to a particular use case and tied to one piece
>> of hardware. In contrast, Vincent uses the existing code from
>> drivers/misc/mic/vop/ that is equally hardware specific, but he
>> extends it to be applicable to other hardware as well.
>>
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
> driver/device setup (which is what mic/vop uses).  I may be missing
> something, but I don't quite understand why it's even using virtio in
> the first place.

Thanks Vincent! This appears to be very good summary of this driver
does on the tmfifo part and the difference between mic/vop. The fifo is
accessed by register instead of shared memory.

The reason to use virtio framework is that it can be easily used to add
more virtual devices as needed without implementing driver details for
each one. For example, the device side supports console and networking
for now over the FIFO. It only needs to implement function
tmfifo_virtio_rxtx() once to take care of the virtqueues Rx/Tx, which are
shared by all virtual devices. With minimum changes, we could easily add
another device over tmfifo, like a virtio block device, since the queue
handling is already there.

The host side handles the virtqueues as well in rshim_net.c. It behaves
like a peer-to-peer to the device side while the tmfifo behaves like a
'wire' (transport) to pass data between the host and the device without
worrying about the data details.

--_000_DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980DB6PR05MB3223eurp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"><!-- P {margin-top:0;margi=
n-bottom:0;} --></style>
</head>
<body dir=3D"ltr">
<div id=3D"divtagdefaultwrapper" style=3D"font-size: 12pt; color: rgb(0, 0,=
 0); font-family: Calibri, Helvetica, sans-serif, &quot;EmojiFont&quot;, &q=
uot;Apple Color Emoji&quot;, &quot;Segoe UI Emoji&quot;, NotoColorEmoji, &q=
uot;Segoe UI Symbol&quot;, &quot;Android Emoji&quot;, EmojiSymbols;" dir=3D=
"ltr">
<br>
<br>
<div style=3D"color: rgb(0, 0, 0);">
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font style=3D"font-size:11pt" face=
=3D"Calibri, sans-serif" color=3D"#000000"><b>From:</b> Vincent Whitchurch =
&lt;vincent.whitchurch@axis.com&gt;<br>
<b>Sent:</b> Tuesday, January 22, 2019 7:20 AM<br>
<b>To:</b> Arnd Bergmann<br>
<b>Cc:</b> Liming Sun; Olof Johansson; David Woods; Robin Murphy; arm-soc; =
DTML; Linux ARM; linux-pci; linux-ntb@googlegroups.com; Christoph Hellwig; =
virtualization@lists.linux-foundation.org<br>
<b>Subject:</b> Re: [PATCH v6 5/9] soc: mellanox: host: Add the common host=
 side Rshim driver</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
"></span></font><font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">On Fri, Jan 18, 2019 at 05:02:21PM &#43;0100, Arnd=
 Bergmann wrote:<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; On =
Thu, Nov 1, 2018 at 5:49 PM Liming Sun &lt;lsun@mellanox.com&gt; wrote:<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
;<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; An external host can connect to a Mellanox BlueField SoC via an<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; interface called Rshim. The Rshim driver provides boot, console,<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; and networking services over this interface. This commit is<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; the common driver where the other backend (transport) driver will<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; use.<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
;<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; Reviewed-by: David Woods &lt;dwoods@mellanox.com&gt;<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; &gt=
; Signed-off-by: Liming Sun &lt;lsun@mellanox.com&gt;<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; Hi =
Liming,<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; I'v=
e taken a new look at your patch series for drivers/soc/ now,<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; tha=
nks for your continued submissions.<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; Thi=
s is again just a set of very high-level comments, but I think we<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; sho=
uld resolve some of the fundamental questions first.<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; Inc=
identally, Vincent Whitchurch has recently posted another<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; pat=
ch series with a very similar intention, but for other hardware<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; and=
 taking a different approach.<br>
&gt;<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; In =
both cases, the idea is to use virtio based drivers to provide<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; ser=
vices from a host machine into another Linux instance running<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; on =
an embedded system behind a PCIe slot or similar. Your<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; Blu=
efield SoC patches are well written, but are intentionally<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; kep=
t specific to a particular use case and tied to one piece<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; of =
hardware. In contrast, Vincent uses the existing code from<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; dri=
vers/misc/mic/vop/ that is equally hardware specific, but he<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; ext=
ends it to be applicable to other hardware as well.<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; <br=
>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; It =
would be good if you could look at each other's approaches<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; to =
see where we could take it from here. I think ideally we<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; sho=
uld have a common driver framework for doing the same<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font>&gt; thi=
ng across both of your devices and as well as others.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> As far =
as I can see the biggest difference is that Rshim appears to<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> support=
 interfaces which do not have shared memory between the host and<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> the car=
d, which means that it has to jump through a lot more hoops to<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> make vi=
rtio work.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> For exa=
mple, the card side seems to use normal virtio-net and<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> virto-c=
onsole drivers, but the drivers/soc/mellanox/tmfifo.c driver,<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> also ru=
nning on the card, appears to have to actually look inside the<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> virtque=
ues and shuffle the data over the TmFifo interface, and this<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> driver =
has hard-coded support for only network and console, since it<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> apparen=
tly needs to know the details of how the virtio drivers use their<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> virtque=
ues (see tmfifo_virtio_rxtx()).<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> And the=
 host side appears to _also_ run the virtio-net driver and there<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> the dri=
vers/soc/mellanox/host/rshim_net.c code instead has to look<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> inside =
the virtqueues and shuffle the data over the other side of the<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> TmFifo =
interface.<br>
<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> So to m=
e this looks very different from a traditional virtio<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> driver/=
device setup (which is what mic/vop uses).&nbsp; I may be missing<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> somethi=
ng, but I don't quite understand why it's even using virtio in<br>
<font size=3D"2"><span style=3D"font-size:11pt;">&gt;</span></font> the fir=
st place.</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">Thanks <font style=3D"font-size:11pt" face=3D"Cali=
bri, sans-serif" color=3D"#000000">
Vincent</font>! This appears to be very good summary of this driver</div>
<div class=3D"PlainText">does on the tmfifo part and the difference between=
 <font size=3D"2">
<span style=3D"font-size:11pt;">mic/vop</span></font>. The<font size=3D"2">=
<span style=3D"font-size:11pt;"> fifo</span></font> is</div>
<div class=3D"PlainText">accessed by&nbsp;register instead of <font size=3D=
"2"><span style=3D"font-size:11pt;">shared memory</span></font>.
<br>
</div>
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">The reason to use virtio framework is that it can =
be&nbsp;easily used to add</div>
<div class=3D"PlainText">more virtual devices as needed without implementin=
g driver details for</div>
<div class=3D"PlainText">each one. For example, the device side supports co=
nsole and networking
<br>
</div>
<div class=3D"PlainText">for now over the FIFO. It only needs to implement =
function
<font size=3D"2"><span style=3D"font-size:11pt;"><br>
</span></font></div>
<div class=3D"PlainText"><font size=3D"2"><span style=3D"font-size:11pt;">t=
mfifo_virtio_rxtx() once</span></font> to take care of the
<font size=3D"2"><span style=3D"font-size:11pt;">virtqueues</span></font>&n=
bsp;Rx/Tx, which are</div>
<div class=3D"PlainText">shared by all virtual devices.<font size=3D"2"><sp=
an style=3D"font-size:11pt;"></span></font> With minimum changes, we could =
easily add</div>
<div class=3D"PlainText">another device over tmfifo, like a virtio block de=
vice, since the queue</div>
<div class=3D"PlainText">handling is already there.</div>
</span></font><font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText"><br>
</div>
<div class=3D"PlainText">The host side handles the<font size=3D"2"><span st=
yle=3D"font-size:11pt;"> virtqueues as well in
</span></font><font size=3D"2"><span style=3D"font-size:11pt;">rshim_net.c<=
/span></font>. It behaves</div>
<div class=3D"PlainText">like a peer-to-peer to the device side while the t=
mfifo behaves like a</div>
<div class=3D"PlainText">'wire' (transport) to pass data between the host a=
nd the device without</div>
<div class=3D"PlainText">worrying about the data details.<br>
</div>
<div class=3D"PlainText"><font size=3D"2"><span style=3D"font-size:11pt;"><=
/span></font></div>
</span></font></div>
</div>
</div>
</body>
</html>

--_000_DB6PR05MB32235BE3E5EBCA60ABDEDB13A1980DB6PR05MB3223eurp_--
