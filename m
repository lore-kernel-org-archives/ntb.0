Date: Tue, 5 Jun 2018 00:05:11 -0700 (PDT)
From: vk en <yato.iacs@gmail.com>
Message-Id: <85bd27cf-3802-4a44-8fc0-829e9b562680@googlegroups.com>
In-Reply-To: <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com> <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com> <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
 <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_24182_1683629901.1528182311512"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_24182_1683629901.1528182311512
Content-Type: multipart/alternative; 
	boundary="----=_Part_24183_1332860415.1528182311513"

------=_Part_24183_1332860415.1528182311513
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On Monday, 4 June 2018 18:31:14 UTC+3, Allen Hubbe wrote:
>
> On Mon, Jun 4, 2018 at 10:50 AM, vk en <yato...@gmail.com <javascript:>> 
> wrote: 
> > He wrote that he did not find dma. 
> > It turns out I should already have a dma, or should he create a virtual 
> dma 
> > himself? 
> > Or do I lack some module for dma? 
>
> modprobe ioatdma 
>

[  142.410353] ioatdma: Intel(R) QuickData Technology Driver 4.00    
<--------
[  180.957289] ntb_hw_intel: unknown parameter 'no_msix' ignored
[  180.957410] Intel(R) PCI-E Non-Transparent Bridge Driver kkk  3.0
[  180.957622] ntb_hw_intel 0000:00:03.0: enabling bus mastering
[  180.957933] ntb_hw_intel 0000:00:03.0: NTB device registered.
[  217.011155] ntc: NTC Driver Framework 0.2
[  217.016905] ntc_ntb: NTC Non Transparent Bridge 0.3
[  217.016928] probe ntb 0000:00:03.0
[  217.016930] no dma for new device 0000:00:03.0

https://github.com/ntrdma/ntrdma/wiki#module-loading-1 
>
> And also check that there is at least one channel not in use: 
> cat /sys/class/dma/*/in_use 
>
 
The dma directory is empty.
root@ENGINE-1:~# ls -l /sys/class/dma/
total 0





 

------=_Part_24183_1332860415.1528182311513
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Monday, 4 June 2018 18:31:14 UTC+3, Allen Hubbe=
  wrote:<blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0=
.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">On Mon, Jun 4, 2018 at=
 10:50 AM, vk en &lt;<a href=3D"javascript:" target=3D"_blank" gdf-obfuscat=
ed-mailto=3D"xdfuUDODAQAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39=
;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39=
;;return true;">yato...@gmail.com</a>&gt; wrote:
<br>&gt; He wrote that he did not find dma.
<br>&gt; It turns out I should already have a dma, or should he create a vi=
rtual dma
<br>&gt; himself?
<br>&gt; Or do I lack some module for dma?
<br>
<br>modprobe ioatdma
<br></blockquote><div><br></div><div><div>[=C2=A0 142.410353] ioatdma: Inte=
l(R) QuickData Technology Driver 4.00=C2=A0 =C2=A0 &lt;--------</div><div>[=
=C2=A0 180.957289] ntb_hw_intel: unknown parameter &#39;no_msix&#39; ignore=
d</div><div>[=C2=A0 180.957410] Intel(R) PCI-E Non-Transparent Bridge Drive=
r kkk=C2=A0 3.0</div><div>[=C2=A0 180.957622] ntb_hw_intel 0000:00:03.0: en=
abling bus mastering</div><div>[=C2=A0 180.957933] ntb_hw_intel 0000:00:03.=
0: NTB device registered.</div><div>[=C2=A0 217.011155] ntc: NTC Driver Fra=
mework 0.2</div><div>[=C2=A0 217.016905] ntc_ntb: NTC Non Transparent Bridg=
e 0.3</div><div>[=C2=A0 217.016928] probe ntb 0000:00:03.0</div><div>[=C2=
=A0 217.016930] no dma for new device 0000:00:03.0</div></div><div><br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;b=
order-left: 1px #ccc solid;padding-left: 1ex;"><a href=3D"https://github.co=
m/ntrdma/ntrdma/wiki#module-loading-1" target=3D"_blank" rel=3D"nofollow" o=
nmousedown=3D"this.href=3D&#39;https://www.google.com/url?q\x3dhttps%3A%2F%=
2Fgithub.com%2Fntrdma%2Fntrdma%2Fwiki%23module-loading-1\x26sa\x3dD\x26sntz=
\x3d1\x26usg\x3dAFQjCNGqHeALmDvoF5cLcPPpkRtbMdsFjg&#39;;return true;" oncli=
ck=3D"this.href=3D&#39;https://www.google.com/url?q\x3dhttps%3A%2F%2Fgithub=
.com%2Fntrdma%2Fntrdma%2Fwiki%23module-loading-1\x26sa\x3dD\x26sntz\x3d1\x2=
6usg\x3dAFQjCNGqHeALmDvoF5cLcPPpkRtbMdsFjg&#39;;return true;">https://githu=
b.com/ntrdma/<wbr>ntrdma/wiki#module-loading-1</a>
<br>
<br>And also check that there is at least one channel not in use:
<br>cat /sys/class/dma/*/in_use
<br></blockquote><div>=C2=A0<br>The dma directory is empty.<br></div><div><=
div>root@ENGINE-1:~# ls -l /sys/class/dma/</div><div>total 0<br><br><br><br=
><br></div></div><div><br></div><div>=C2=A0</div></div>
------=_Part_24183_1332860415.1528182311513--

------=_Part_24182_1683629901.1528182311512--
