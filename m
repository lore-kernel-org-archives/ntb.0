Date: Wed, 6 Jun 2018 02:06:48 -0700 (PDT)
From: vk en <yato.iacs@gmail.com>
Message-Id: <b6723ca5-2f8b-4fcf-812e-20c4f40c73c2@googlegroups.com>
In-Reply-To: <0fe77341-d309-479f-177c-c18b0193926e@intel.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
 <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com>
 <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
 <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
 <b05ac043-38ab-7439-1ede-7348f1b7e3bd@intel.com>
 <9058dedf-ec3a-42d4-9eaa-40d95740fcc0@googlegroups.com>
 <0fe77341-d309-479f-177c-c18b0193926e@intel.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_45607_872798031.1528276008246"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_45607_872798031.1528276008246
Content-Type: multipart/alternative; 
	boundary="----=_Part_45608_1761644684.1528276008246"

------=_Part_45608_1761644684.1528276008246
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 5 =D0=B8=D1=8E=D0=BD=D1=8F 2018=
 =D0=B3., 19:16:48 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=D0=B0=
=D1=82=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=BB:
>
> On 06/05/2018 01:21 AM, vk en wrote:=20
> > 1. I did not find the CBDMA in BIOS, it's not there.=20
> > But we wrote to the manufacturer to find out where to find CBDMA.=20
>
> That is pretty unusual. All Intel E5 or higher based Xeon (or whatever=20
> the equivalent is now, thanks marketing) has ioatdma (CBDMA). It's a=20
> matter of whether your BIOS enable it or not. Of course if your platform=
=20
> has NTB, then you should have the DMA engine as well as they are part of=
=20
> the platform storage extension features. Which Xeon platform are you on=
=20
> and who is your supplier?=20
>
 System Gooxi, Intel=C2=AE Xeon=C2=AE E5-2603 v4


------=_Part_45608_1761644684.1528276008246
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<br><br>=D0=B2=D1=82=D0=BE=D1=80=D0=BD=D0=B8=D0=BA, 5 =D0=B8=D1=8E=D0=BD=D1=
=8F 2018 =D0=B3., 19:16:48 UTC+3 =D0=BF=D0=BE=D0=BB=D1=8C=D0=B7=D0=BE=D0=B2=
=D0=B0=D1=82=D0=B5=D0=BB=D1=8C dave.jiang =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=BB:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left:=
 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On 06/05/2018 01:21 =
AM, vk en wrote:
<br>&gt; 1.=C2=A0I did not find the CBDMA=C2=A0in BIOS, it&#39;s not there.
<br>&gt; But we wrote to the manufacturer to find out where to find CBDMA.
<br>
<br>That is pretty unusual. All Intel E5 or higher based Xeon (or whatever
<br>the equivalent is now, thanks marketing) has ioatdma (CBDMA). It&#39;s =
a
<br>matter of whether your BIOS enable it or not. Of course if your platfor=
m
<br>has NTB, then you should have the DMA engine as well as they are part o=
f
<br>the platform storage extension features. Which Xeon platform are you on
<br>and who is your supplier?
<br></blockquote><div>=C2=A0<font face=3D"arial, sans-serif"><span style=3D=
"font-size: 12.8px;">System Gooxi, Intel=C2=AE Xeon=C2=AE E5-2603 v4</span>=
</font></div><div><br></div>
------=_Part_45608_1761644684.1528276008246--

------=_Part_45607_872798031.1528276008246--
