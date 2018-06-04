Date: Mon, 4 Jun 2018 06:23:29 -0700 (PDT)
From: Ka Vi <yato.iacs@gmail.com>
Message-Id: <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
In-Reply-To: <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24843_1228033981.1528118609295"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_24843_1228033981.1528118609295
Content-Type: multipart/alternative; 
	boundary="----=_Part_24844_911459626.1528118609295"

------=_Part_24844_911459626.1528118609295
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi, Allen! Thanks for answering!

1. Was the ntb_transport driver unloaded before loading ntc_ntb_msi? =20
No, I want to create a bridge using NTRDMA over PCIe NTB, bypassing the TCP=
=20
/ IP protocol

I watched the wiki=20
<https://github.com/ntrdma/ntrdma/wiki#quick-start-ntrdma-over-pcie-ntb>,=
=20
and I did everything as indicated. And there is no usage of the=20
ntb_transport module.

After editing the configuration file=20
(https://github.com/ntrdma/ntrdma/wiki#module-loading-1), I load the module=
=20
and get an error: [ 1273.099294] ntb_hw_intel: unknown parameter 'no_msix'=
=20
ignored
All the necessary output in dmesg:
[ 1252.681245] ioatdma: Intel(R) QuickData Technology Driver 4.00
[ 1273.099294] ntb_hw_intel: unknown parameter 'no_msix' ignored
[ 1273.099420] Intel(R) PCI-E Non-Transparent Bridge Driver kkk  3.0
[ 1273.099624] ntb_hw_intel 0000:00:03.0: enabling bus mastering
[ 1273.100007] ntb_hw_intel 0000:00:03.0: NTB device registered.
[ 1325.970171] ntc: NTC Driver Framework 0.2
[ 1325.974509] ntc_ntb: NTC Non Transparent Bridge 0.3

What is the parameter no_msix ?

Based on this, and having spent a lot of time figuring out the problem, I=
=20
decided to go back to the beginning, and see if there is any connection=20
between the controllers without loading ntb_transport. Due to the fact that=
=20
I went to a dead end, I felt that I was wrong somewhere in the beginning=20
and therefore asked about (Problem with the connection status (Link-status)=
=20
after loading the driver ntb_hw_intel)

Maybe I'm looking for a solution in the wrong direction, and if you know or=
=20
can help me, I'll be very glad.


On Monday, 4 June 2018 15:08:42 UTC+3, Allen Hubbe wrote:
>
> On Mon, Jun 4, 2018 at 7:07 AM, Ka Vi <yato...@gmail.com <javascript:>>=
=20
> wrote:=20
> >=20
> > Hi=20
> >=20
> > After loading the ntb.ko and ntb_hw_intel drivers, the=20
> > /sys/kernel/debug/ntb_hw_intel/0000:00:03.0/info file appears,=20
> indicating=20
> > that Link-Status is Down.=20
> > When the ntb_transport driver is loaded, the Link-Status state goes to=
=20
> Up.=20
> > When the ntb_netdev driver is loaded, the eth0 device appears. When=20
> > assigning ip-addressing to both devices eth0, we have a ping between=20
> them.=20
> >=20
> > After downloading the ntc_ntb_msi driver, the folders by / sys / kernel=
=20
> /=20
> > debug / ntc_ntb_msi, / sys / kernel / debug / ntrdma, / sys / class /=
=20
> > infiniband are empty. In the / sys / class / infiniband_verbs folder=20
> there=20
> > is only one "abi_version" file containing one "6" character.=20
>
> Was the ntb_transport driver unloaded before loading ntc_ntb_msi?=20
>
> > Why does not the link go into UP status when loading ntb_hw_intel?=20
>
> The hw driver only provides an interface for the hardware.=20
>
> > And it=20
> > appears only after ntb_transport, it's kind of like different things.=
=20
>
> The transport driver tells the hw driver to bring up the interface.=20
>
> > Also what it is necessary to make, what the link would pass in status U=
P=20
> at=20
> > loading ntb_hw_intel?=20
>
> If the link is allowed to go up before the transport driver is loaded,=20
> then some other signal would be needed to indicate when the transport=20
> driver becomes ready for communication.  Doing it this way, the link=20
> up signal not only indicates that the link is physically up, but also=20
> that the peer is ready for communication over the link.=20
>
> > All did according to the instructions=20
> > https://github.com/jonmason/ntb/wiki/Linux-NTB-HOWTO-build-and-install=
=20
> >=20
> > //---------------------------------------------------------------=20
> > Spread spectrum clock is turned off by default.=20
> >=20
> > NTB Window Size:=20
> > PBAR23SZ 22=20
> > PBAR45SZ 20=20
> > SBAR23SZ 20=20
> > SBAR45SZ 20=20
> >=20
> > System Gooxi, Debian 4.9, 16Gb RAM. Intel=C2=AE Xeon=C2=AE E5-2603 v4=
=20
>

------=_Part_24844_911459626.1528118609295
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi, Allen!=C2=A0Thanks for answering!<br><br>1. Was the nt=
b_transport driver unloaded before loading ntc_ntb_msi?=C2=A0=C2=A0<br>No,=
=C2=A0I want to create a bridge using NTRDMA over PCIe NTB, bypassing the T=
CP / IP protocol<br><br>I watched the <a href=3D"https://github.com/ntrdma/=
ntrdma/wiki#quick-start-ntrdma-over-pcie-ntb">wiki</a>, and I did everythin=
g as indicated.=C2=A0And there is no usage of the ntb_transport module.<br>=
<br>After editing the configuration file (https://github.com/ntrdma/ntrdma/=
wiki#module-loading-1), I load the module and get an error: [ 1273.099294] =
ntb_hw_intel: unknown parameter &#39;no_msix&#39; ignored<br>All the necess=
ary output in dmesg:<br><div>[ 1252.681245] ioatdma: Intel(R) QuickData Tec=
hnology Driver 4.00</div><div>[ 1273.099294] ntb_hw_intel: unknown paramete=
r &#39;no_msix&#39; ignored</div><div>[ 1273.099420] Intel(R) PCI-E Non-Tra=
nsparent Bridge Driver kkk=C2=A0 3.0</div><div>[ 1273.099624] ntb_hw_intel =
0000:00:03.0: enabling bus mastering</div><div>[ 1273.100007] ntb_hw_intel =
0000:00:03.0: NTB device registered.</div><div>[ 1325.970171] ntc: NTC Driv=
er Framework 0.2</div><div>[ 1325.974509] ntc_ntb: NTC Non Transparent Brid=
ge 0.3</div><div><br></div>What is the parameter=C2=A0<span style=3D"color:=
 rgb(3, 47, 98); background-color: rgb(246, 248, 250); font-family: SFMono-=
Regular, Consolas, &quot;Liberation Mono&quot;, Menlo, Courier, monospace; =
font-size: 13.6px;">no_msix ?</span><br><br><div>Based on this, and having =
spent a lot of time figuring out the problem, I decided to go back to the b=
eginning, and see if there is any connection between the controllers withou=
t loading ntb_transport. Due to the fact that I went to a dead end, I felt =
that I was wrong somewhere in the beginning and therefore asked about=C2=A0=
<span style=3D"color: rgb(136, 136, 136);">(</span><font color=3D"#888888">=
Problem with the connection status (Link-status) after loading the driver n=
tb_hw_intel</font><span style=3D"color: rgb(136, 136, 136);">)</span></div>=
<div><br>Maybe I&#39;m looking for a solution in the wrong direction, and i=
f you know or can help me, I&#39;ll be very glad.<br><br><br>On Monday, 4 J=
une 2018 15:08:42 UTC+3, Allen Hubbe  wrote:<blockquote class=3D"gmail_quot=
e" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;paddin=
g-left: 1ex;">On Mon, Jun 4, 2018 at 7:07 AM, Ka Vi &lt;<a href=3D"javascri=
pt:" target=3D"_blank" gdf-obfuscated-mailto=3D"jUV6GSZ4AQAJ" rel=3D"nofoll=
ow" onmousedown=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=
=3D"this.href=3D&#39;javascript:&#39;;return true;">yato...@gmail.com</a>&g=
t; wrote:
<br>&gt;
<br>&gt; Hi
<br>&gt;
<br>&gt; After loading the ntb.ko and ntb_hw_intel drivers, the
<br>&gt; /sys/kernel/debug/ntb_hw_<wbr>intel/0000:00:03.0/info file appears=
, indicating
<br>&gt; that Link-Status is Down.
<br>&gt; When the ntb_transport driver is loaded, the Link-Status state goe=
s to Up.
<br>&gt; When the ntb_netdev driver is loaded, the eth0 device appears. Whe=
n
<br>&gt; assigning ip-addressing to both devices eth0, we have a ping betwe=
en them.
<br>&gt;
<br>&gt; After downloading the ntc_ntb_msi driver, the folders by / sys / k=
ernel /
<br>&gt; debug / ntc_ntb_msi, / sys / kernel / debug / ntrdma, / sys / clas=
s /
<br>&gt; infiniband are empty. In the / sys / class / infiniband_verbs fold=
er there
<br>&gt; is only one &quot;abi_version&quot; file containing one &quot;6&qu=
ot; character.
<br>
<br>Was the ntb_transport driver unloaded before loading ntc_ntb_msi?
<br>
<br>&gt; Why does not the link go into UP status when loading ntb_hw_intel?
<br>
<br>The hw driver only provides an interface for the hardware.
<br>
<br>&gt; And it
<br>&gt; appears only after ntb_transport, it&#39;s kind of like different =
things.
<br>
<br>The transport driver tells the hw driver to bring up the interface.
<br>
<br>&gt; Also what it is necessary to make, what the link would pass in sta=
tus UP at
<br>&gt; loading ntb_hw_intel?
<br>
<br>If the link is allowed to go up before the transport driver is loaded,
<br>then some other signal would be needed to indicate when the transport
<br>driver becomes ready for communication. =C2=A0Doing it this way, the li=
nk
<br>up signal not only indicates that the link is physically up, but also
<br>that the peer is ready for communication over the link.
<br>
<br>&gt; All did according to the instructions
<br>&gt; <a href=3D"https://github.com/jonmason/ntb/wiki/Linux-NTB-HOWTO-bu=
ild-and-install" target=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.hre=
f=3D&#39;https://www.google.com/url?q\x3dhttps%3A%2F%2Fgithub.com%2Fjonmaso=
n%2Fntb%2Fwiki%2FLinux-NTB-HOWTO-build-and-install\x26sa\x3dD\x26sntz\x3d1\=
x26usg\x3dAFQjCNFLhR9X__P3xdXB5OhoSRyrVo4CEg&#39;;return true;" onclick=3D"=
this.href=3D&#39;https://www.google.com/url?q\x3dhttps%3A%2F%2Fgithub.com%2=
Fjonmason%2Fntb%2Fwiki%2FLinux-NTB-HOWTO-build-and-install\x26sa\x3dD\x26sn=
tz\x3d1\x26usg\x3dAFQjCNFLhR9X__P3xdXB5OhoSRyrVo4CEg&#39;;return true;">htt=
ps://github.com/jonmason/<wbr>ntb/wiki/Linux-NTB-HOWTO-<wbr>build-and-insta=
ll</a>
<br>&gt;
<br>&gt; //----------------------------<wbr>------------------------------<=
wbr>-----
<br>&gt; Spread spectrum clock is turned off by default.
<br>&gt;
<br>&gt; NTB Window Size:
<br>&gt; PBAR23SZ 22
<br>&gt; PBAR45SZ 20
<br>&gt; SBAR23SZ 20
<br>&gt; SBAR45SZ 20
<br>&gt;
<br>&gt; System Gooxi, Debian 4.9, 16Gb RAM. Intel=C2=AE Xeon=C2=AE E5-2603=
 v4
<br></blockquote></div></div>
------=_Part_24844_911459626.1528118609295--

------=_Part_24843_1228033981.1528118609295--
