Return-Path: <cruisethai@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com. [2a00:1450:400c:c09::242])
        by gmr-mx.google.com with ESMTPS id k11si480893wmi.1.2017.12.04.19.34.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 19:34:17 -0800 (PST)
Received: by mail-wm0-x242.google.com with SMTP id n138so9414309wmg.2
        for <linux-ntb@googlegroups.com>; Mon, 04 Dec 2017 19:34:17 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0f0a4d34-ed0b-99cf-8f7d-d47e62235a3b@deltatee.com>
References: <20171204175721.10322-1-logang@deltatee.com> <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com>
 <0f0a4d34-ed0b-99cf-8f7d-d47e62235a3b@deltatee.com>
From: ThanhTuThai <cruisethai@gmail.com>
Date: Tue, 5 Dec 2017 11:34:16 +0800
Message-ID: <CAJQW-Q733PvoghsDMiRwp7w34h+oXVwxr_g45Z-_Wu4=NQCMuA@mail.gmail.com>
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before initializing
Content-Type: multipart/alternative; boundary="94eb2c197ec2772bff055f8f82fc"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--94eb2c197ec2772bff055f8f82fc
Content-Type: text/plain; charset="UTF-8"

Dear Logan,

The evidence is the "printk" in interrupt routine.
For software-reboot, the "printk" printed out perfectly.
For power-reset, it didn't, is it enough ?

I actually try your patch, and I even wrote the solution you suggested, I
also implemented it myself before, but no message received from the crashed
peer, I said that to you many times.

I didn't send you the log, b/c nothing there, it doesn't receive any
message, so it didn't log anything.

Anyway, thanks for you support !!!

On 5 December 2017 at 11:00, Logan Gunthorpe <logang@deltatee.com> wrote:

>
>
> On 04/12/17 06:47 PM, ThanhTuThai wrote:
> > The problem is that the good host even didn't receive any message when
> > the crashed peer come up, so your  "re-init scheduled work" will not be
> > activated.
> > Because the good peer didn't receive any interrupt to activate the
> > scheduled work.
>
> What's your evidence here? You haven't really sent me anything to go on.
> Did you actually try the patch or did you just assume it doesn't work?
>
> In any case, if your assertion is correct, then it's a firmware issue
> and you'll have to contact Microsemi and get them to look at it.
>
> Logan
>

--94eb2c197ec2772bff055f8f82fc
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Logan,<div><br></div><div>The evidence is the &quot;p=
rintk&quot; in interrupt routine.</div><div>For software-reboot, the &quot;=
printk&quot; printed out perfectly.</div><div>For power-reset, it didn&#39;=
t, is it enough ?</div><div><br></div><div>I actually try your patch, and I=
 even wrote the solution you suggested, I also implemented it myself before=
, but no message received from the crashed peer, I said that to you many ti=
mes.</div><div><br></div><div>I didn&#39;t send you the log, b/c nothing th=
ere, it doesn&#39;t receive any message, so it didn&#39;t log anything.</di=
v><div><br></div><div>Anyway, thanks for you support !!!</div></div><div cl=
ass=3D"gmail_extra"><br><div class=3D"gmail_quote">On 5 December 2017 at 11=
:00, Logan Gunthorpe <span dir=3D"ltr">&lt;<a href=3D"mailto:logang@deltate=
e.com" target=3D"_blank">logang@deltatee.com</a>&gt;</span> wrote:<br><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex"><span class=3D""><br>
<br>
On 04/12/17 06:47 PM, ThanhTuThai wrote:<br>
&gt; The problem is that the good host even didn&#39;t receive any message =
when<br>
&gt; the crashed peer come up, so your=C2=A0 &quot;re-init scheduled work&q=
uot; will not be<br>
&gt; activated.<br>
&gt; Because the good peer didn&#39;t receive any interrupt to activate the=
<br>
&gt; scheduled work.<br>
<br>
</span>What&#39;s your evidence here? You haven&#39;t really sent me anythi=
ng to go on.<br>
Did you actually try the patch or did you just assume it doesn&#39;t work?<=
br>
<br>
In any case, if your assertion is correct, then it&#39;s a firmware issue<b=
r>
and you&#39;ll have to contact Microsemi and get them to look at it.<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Logan<br>
</font></span></blockquote></div><br></div>

--94eb2c197ec2772bff055f8f82fc--
