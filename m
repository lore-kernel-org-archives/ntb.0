Date: Mon, 4 Jun 2018 07:50:51 -0700 (PDT)
From: vk en <yato.iacs@gmail.com>
Message-Id: <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
In-Reply-To: <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com>
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com> <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
 <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com>
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_33225_1728587657.1528123851381"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_33225_1728587657.1528123851381
Content-Type: multipart/alternative; 
	boundary="----=_Part_33226_224798717.1528123851381"

------=_Part_33226_224798717.1528123851381
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

He wrote that he did not find dma.
It turns out I should already have a dma, or should he create a virtual dma 
himself?
Or do I lack some module for dma?



On Monday, 4 June 2018 17:43:01 UTC+3, vk en wrote:
>
>
>
> On Monday, 4 June 2018 17:00:46 UTC+3, Allen Hubbe wrote:
>>
>> On Mon, Jun 4, 2018 at 9:23 AM, Ka Vi <yato...@gmail.com> wrote: 
>> > Hi, Allen! Thanks for answering! 
>> > 
>> > 1. Was the ntb_transport driver unloaded before loading ntc_ntb_msi? 
>> > No, I want to create a bridge using NTRDMA over PCIe NTB, bypassing the 
>> TCP 
>> > / IP protocol 
>> > 
>> > I watched the wiki, and I did everything as indicated. And there is no 
>> usage 
>> > of the ntb_transport module. 
>> > 
>> > After editing the configuration file 
>> > (https://github.com/ntrdma/ntrdma/wiki#module-loading-1), I load the 
>> module 
>> > and get an error: [ 1273.099294] ntb_hw_intel: unknown parameter 
>> 'no_msix' 
>> > ignored 
>> > All the necessary output in dmesg: 
>> > [ 1252.681245] ioatdma: Intel(R) QuickData Technology Driver 4.00 
>> > [ 1273.099294] ntb_hw_intel: unknown parameter 'no_msix' ignored 
>> > [ 1273.099420] Intel(R) PCI-E Non-Transparent Bridge Driver kkk  3.0 
>> > [ 1273.099624] ntb_hw_intel 0000:00:03.0: enabling bus mastering 
>> > [ 1273.100007] ntb_hw_intel 0000:00:03.0: NTB device registered. 
>> > [ 1325.970171] ntc: NTC Driver Framework 0.2 
>> > [ 1325.974509] ntc_ntb: NTC Non Transparent Bridge 0.3 
>>
>> Please load ntc_ntb_msi with module parameter dyndbg=+p 
>>
>  
> [  190.999503] ioatdma: Intel(R) QuickData Technology Driver 4.00
> [  239.385371] ntc: NTC Driver Framework 0.2
> [  239.390995] ntc_ntb: NTC Non Transparent Bridge 0.3
> [  239.391018] probe ntb 0000:00:03.0
> [  239.391020] no dma for new device 0000:00:03.0
>  
>
>> Can you also please provide the output of: 
>> ls -ld /sys/bus/ntb/*/driver 
>>
>>   root@ENGINE-1:~# ls -ld /sys/bus/ntb/*
> drwxr-xr-x 2 root root    0 Jun  4 10:28 /sys/bus/ntb/devices
> drwxr-xr-x 3 root root    0 Jun  4 10:16 /sys/bus/ntb/drivers
> -rw-r--r-- 1 root root 4096 Jun  4 10:28 /sys/bus/ntb/drivers_autoprobe
> --w------- 1 root root 4096 Jun  4 10:28 /sys/bus/ntb/drivers_probe
> --w------- 1 root root 4096 Jun  4 10:28 /sys/bus/ntb/uevent
>  
>
>> If it was loaded with dyndbg, and that is the last thing in dmesg, 
>> then it looks like the probe function was never called. 
>>
>>
------=_Part_33226_224798717.1528123851381
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>He wrote that he did not find dma.</div><div>It =
turns out I should already have a dma, or should he create a virtual dma hi=
mself?</div><div>Or do I lack some module for dma?<br><br><br><br></div></d=
iv>On Monday, 4 June 2018 17:43:01 UTC+3, vk en  wrote:<blockquote class=3D=
"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc s=
olid;padding-left: 1ex;"><div dir=3D"ltr"><br><br>On Monday, 4 June 2018 17=
:00:46 UTC+3, Allen Hubbe  wrote:<blockquote class=3D"gmail_quote" style=3D=
"margin:0;margin-left:0.8ex;border-left:1px #ccc solid;padding-left:1ex">On=
 Mon, Jun 4, 2018 at 9:23 AM, Ka Vi &lt;<a rel=3D"nofollow">yato...@gmail.c=
om</a>&gt; wrote:
<br>&gt; Hi, Allen! Thanks for answering!
<br>&gt;
<br>&gt; 1. Was the ntb_transport driver unloaded before loading ntc_ntb_ms=
i?
<br>&gt; No, I want to create a bridge using NTRDMA over PCIe NTB, bypassin=
g the TCP
<br>&gt; / IP protocol
<br>&gt;
<br>&gt; I watched the wiki, and I did everything as indicated. And there i=
s no usage
<br>&gt; of the ntb_transport module.
<br>&gt;
<br>&gt; After editing the configuration file
<br>&gt; (<a href=3D"https://github.com/ntrdma/ntrdma/wiki#module-loading-1=
" rel=3D"nofollow" target=3D"_blank" onmousedown=3D"this.href=3D&#39;https:=
//www.google.com/url?q\x3dhttps%3A%2F%2Fgithub.com%2Fntrdma%2Fntrdma%2Fwiki=
%23module-loading-1\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNGqHeALmDvoF5cLc=
PPpkRtbMdsFjg&#39;;return true;" onclick=3D"this.href=3D&#39;https://www.go=
ogle.com/url?q\x3dhttps%3A%2F%2Fgithub.com%2Fntrdma%2Fntrdma%2Fwiki%23modul=
e-loading-1\x26sa\x3dD\x26sntz\x3d1\x26usg\x3dAFQjCNGqHeALmDvoF5cLcPPpkRtbM=
dsFjg&#39;;return true;">https://github.com/ntrdma/<wbr>ntrdma/wiki#module-=
loading-1</a>), I load the module
<br>&gt; and get an error: [ 1273.099294] ntb_hw_intel: unknown parameter &=
#39;no_msix&#39;
<br>&gt; ignored
<br>&gt; All the necessary output in dmesg:
<br>&gt; [ 1252.681245] ioatdma: Intel(R) QuickData Technology Driver 4.00
<br>&gt; [ 1273.099294] ntb_hw_intel: unknown parameter &#39;no_msix&#39; i=
gnored
<br>&gt; [ 1273.099420] Intel(R) PCI-E Non-Transparent Bridge Driver kkk =
=C2=A03.0
<br>&gt; [ 1273.099624] ntb_hw_intel 0000:00:03.0: enabling bus mastering
<br>&gt; [ 1273.100007] ntb_hw_intel 0000:00:03.0: NTB device registered.
<br>&gt; [ 1325.970171] ntc: NTC Driver Framework 0.2
<br>&gt; [ 1325.974509] ntc_ntb: NTC Non Transparent Bridge 0.3
<br>
<br>Please load ntc_ntb_msi with module parameter dyndbg=3D+p
<br></blockquote><div>=C2=A0</div><div>[=C2=A0 190.999503] ioatdma: Intel(R=
) QuickData Technology Driver 4.00</div><div>[=C2=A0 239.385371] ntc: NTC D=
river Framework 0.2</div><div>[=C2=A0 239.390995] ntc_ntb: NTC Non Transpar=
ent Bridge 0.3</div><div>[=C2=A0 239.391018] probe ntb 0000:00:03.0</div><d=
iv>[=C2=A0 239.391020] no dma for new device 0000:00:03.0</div><div>=C2=A0<=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0;margin-left:0.8ex;=
border-left:1px #ccc solid;padding-left:1ex">Can you also please provide th=
e output of:
<br>ls -ld /sys/bus/ntb/*/driver
<br>
<br></blockquote><div>=C2=A0 root@ENGINE-1:~# ls -ld /sys/bus/ntb/*</div><d=
iv>drwxr-xr-x 2 root root=C2=A0 =C2=A0 0 Jun=C2=A0 4 10:28 /sys/bus/ntb/dev=
ices</div><div>drwxr-xr-x 3 root root=C2=A0 =C2=A0 0 Jun=C2=A0 4 10:16 /sys=
/bus/ntb/drivers</div><div>-rw-r--r-- 1 root root 4096 Jun=C2=A0 4 10:28 /s=
ys/bus/ntb/drivers_autoprobe</div><div>--w------- 1 root root 4096 Jun=C2=
=A0 4 10:28 /sys/bus/ntb/drivers_probe</div><div>--w------- 1 root root 409=
6 Jun=C2=A0 4 10:28 /sys/bus/ntb/uevent</div><div>=C2=A0</div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0;margin-left:0.8ex;border-left:1px #c=
cc solid;padding-left:1ex">If it was loaded with dyndbg, and that is the la=
st thing in dmesg,
<br>then it looks like the probe function was never called.
<br><br></blockquote></div></blockquote></div>
------=_Part_33226_224798717.1528123851381--

------=_Part_33225_1728587657.1528123851381--
