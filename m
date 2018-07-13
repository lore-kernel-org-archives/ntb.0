Return-Path: <gzhuang@celestica.com>
Received: from mail-ua0-x235.google.com (mail-ua0-x235.google.com. [2607:f8b0:400c:c08::235])
        by gmr-mx.google.com with ESMTPS id j14-v6si263628uap.0.2018.07.13.01.25.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 01:25:37 -0700 (PDT)
Received: by mail-ua0-x235.google.com with SMTP id p22-v6so9559210uao.7
        for <linux-ntb@googlegroups.com>; Fri, 13 Jul 2018 01:25:37 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <88bbdd2f-ac2f-058e-1beb-5e6bcbfcf258@intel.com>
References: <CAM+4PA3A-eL9uSVvrgf_RV+qoLi8CLd0qE4Ru7LWgdFSqQBsBg@mail.gmail.com>
 <88bbdd2f-ac2f-058e-1beb-5e6bcbfcf258@intel.com>
From: Grace Zhuang <gzhuang@celestica.com>
Date: Fri, 13 Jul 2018 16:25:17 +0800
Message-ID: <CAM+4PA2SQ+=F47-SrmrbeOTsFhw0OihtbpFsXq-pkUOHvht8MA@mail.gmail.com>
Subject: Re: AER event in NTB
Content-Type: multipart/alternative; boundary="000000000000764a130570dd3932"
To: Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

--000000000000764a130570dd3932
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Dave.
I studied Intel documents these days.
I found In SKX_EDS_vol2B_546833_Rev1_7.pdf :

In Figure 4-1 NTB Internal Endpoint
    There is Vendor-Specific Advanced Error Reporting Capability.
But in Figure 4-4 NTB External Endpoint
    There is standard Advanced Error Reporting Capability.


Grace Zhuang(=E5=BA=84=E7=87=95=E5=AD=90=EF=BC=89
Diagnostics Engineer
+86-21-61006028 ext:7637
13917171202
gzhuang@celestica.com
www.celestica.com

On Tue, Jul 3, 2018 at 12:09 AM, Dave Jiang <dave.jiang@intel.com> wrote:

>
>
> On 07/01/2018 09:33 PM, Grace Zhuang wrote:
> > On Purley platform, have any AER event/msi will be reported in dmesg?
> > I found there was a ntb-aer branch, but it was maintained before 2015.
>
> Intel NTB does not support standard PCIe AER. Support was never added
> for it. I think that branch was Jon playing around with the proprietary
> support. I don't believe it ties into the Linux standard PCIe AER
> framework.
>

--000000000000764a130570dd3932
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Dave.=C2=A0<div>I studied Intel documents these day=
s.</div><div>I found In SKX_EDS_vol2B_546833_Rev1_7.pdf :</div><div><br></d=
iv><div>In Figure 4-1 NTB Internal Endpoint=C2=A0<br></div><div>=C2=A0 =C2=
=A0 There is Vendor-Specific Advanced Error Reporting Capability.</div><div=
>But in Figure 4-4 NTB External Endpoint=C2=A0<br></div><div>=C2=A0 =C2=A0 =
There is standard Advanced Error Reporting Capability.</div></div><div clas=
s=3D"gmail_extra"><br clear=3D"all"><div><div class=3D"gmail_signature" dat=
a-smartmail=3D"gmail_signature"><div dir=3D"ltr"><div><div dir=3D"ltr"><div=
><div style=3D"font-size:12.8px"><br></div><span style=3D"font-size:12.8px"=
>Grace Zhuang(=E5=BA=84=E7=87=95=E5=AD=90=EF=BC=89</span></div><div>Diagnos=
tics Engineer<br><span style=3D"font-size:12.8px">+86-21-61006028 ext:7637<=
/span><br style=3D"color:rgb(35,31,32);font-family:Arial,&quot;Helvetica Ne=
ue&quot;,Helvetica,sans-serif;font-size:14px"><span style=3D"color:rgb(35,3=
1,32);font-family:Arial,&quot;Helvetica Neue&quot;,Helvetica,sans-serif;fon=
t-size:14px">13917171202</span><br style=3D"color:rgb(35,31,32);font-family=
:Arial,&quot;Helvetica Neue&quot;,Helvetica,sans-serif;font-size:14px"><spa=
n style=3D"color:rgb(35,31,32);font-family:Arial,&quot;Helvetica Neue&quot;=
,Helvetica,sans-serif;font-size:14px"><a href=3D"mailto:gzhuang@celestica.c=
om" target=3D"_blank">gzhuang@celestica.com</a></span><br style=3D"color:rg=
b(35,31,32);font-family:Arial,&quot;Helvetica Neue&quot;,Helvetica,sans-ser=
if;font-size:14px"><span style=3D"color:rgb(35,31,32);font-family:Arial,&qu=
ot;Helvetica Neue&quot;,Helvetica,sans-serif;font-size:14px"><a href=3D"htt=
p://www.celestica.com" target=3D"_blank">www.celestica.com</a>=C2=A0</span>=
</div></div></div></div></div></div>
<br><div class=3D"gmail_quote">On Tue, Jul 3, 2018 at 12:09 AM, Dave Jiang =
<span dir=3D"ltr">&lt;<a href=3D"mailto:dave.jiang@intel.com" target=3D"_bl=
ank">dave.jiang@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex"><span class=3D""><br>
<br>
On 07/01/2018 09:33 PM, Grace Zhuang wrote:<br>
&gt; On Purley platform, have any AER event/msi=C2=A0will=C2=A0be reported =
in dmesg?<br>
&gt; I found there was a ntb-aer=C2=A0branch, but it was maintained before =
2015.<br>
<br>
</span>Intel NTB does not support standard PCIe AER. Support was never adde=
d<br>
for it. I think that branch was Jon playing around with the proprietary<br>
support. I don&#39;t believe it ties into the Linux standard PCIe AER<br>
framework.<br>
</blockquote></div><br></div>

--000000000000764a130570dd3932--
