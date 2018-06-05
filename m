Date: Tue, 5 Jun 2018 01:21:23 -0700 (PDT)
From: vk en <yato.iacs@gmail.com>
Message-Id: <9058dedf-ec3a-42d4-9eaa-40d95740fcc0@googlegroups.com>
In-Reply-To: <b05ac043-38ab-7439-1ede-7348f1b7e3bd@intel.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
 <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com>
 <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
 <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
 <b05ac043-38ab-7439-1ede-7348f1b7e3bd@intel.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_38885_1967504325.1528186883880"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_38885_1967504325.1528186883880
Content-Type: multipart/alternative; 
	boundary="----=_Part_38886_427637699.1528186883881"

------=_Part_38886_427637699.1528186883881
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

1. I did not find the CBDMA in BIOS, it's not there.
But we wrote to the manufacturer to find out where to find CBDMA.
2. Empty



On Monday, 4 June 2018 19:36:43 UTC+3, dave.jiang wrote:
>
>
> ^ So he has the ioatdma driver already loaded. 
>
> 1. Please make sure CBDMA is enabled in your BIOS options? Probably 
> under IIO section. 
> 2. Please provide lspci and show if the DMA shows up? i.e. 
>
> 00:04.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core 
> i7 DMA Channel 0 (rev 02) 
>         Subsystem: Intel Corporation Device 35c8 
>         Flags: bus master, fast devsel, latency 0, IRQ 52, NUMA node 0 
>         Memory at 383ffff2c000 (64-bit, non-prefetchable) [size=16K] 
>         Capabilities: [80] MSI-X: Enable+ Count=1 Masked- 
>         Capabilities: [90] Express Root Complex Integrated Endpoint, MSI 
> 00 
>         Capabilities: [e0] Power Management version 3 
>         Kernel driver in use: ioatdma 
>         Kernel modules: ioatdma 
>
>
>
------=_Part_38886_427637699.1528186883881
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">1.=C2=A0I did not find the CBDMA=C2=A0in BIOS, it&#39;s no=
t there.<br>But we wrote to the manufacturer to find out where to find CBDM=
A.<br>2. Empty<br><br><br><br>On Monday, 4 June 2018 19:36:43 UTC+3, dave.j=
iang  wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-lef=
t: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><br>^ So he has th=
e ioatdma driver already loaded.
<br>
<br>1. Please make sure CBDMA is enabled in your BIOS options? Probably
<br>under IIO section.
<br>2. Please provide lspci and show if the DMA shows up? i.e.
<br>
<br>00:04.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
<br>i7 DMA Channel 0 (rev 02)
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Subsystem: Intel Corporation Device 35c8
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Flags: bus master, fast devsel, latency 0, =
IRQ 52, NUMA node 0
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Memory at 383ffff2c000 (64-bit, non-prefetc=
hable) [size=3D16K]
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [80] MSI-X: Enable+ Count=3D1=
 Masked-
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [90] Express Root Complex Int=
egrated Endpoint, MSI 00
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Capabilities: [e0] Power Management version=
 3
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel driver in use: ioatdma
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 Kernel modules: ioatdma
<br>
<br><br></blockquote></div>
------=_Part_38886_427637699.1528186883881--

------=_Part_38885_1967504325.1528186883880--
