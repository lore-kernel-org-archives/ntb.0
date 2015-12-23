Return-Path: <raghunath88@gmail.com>
Received: from mail-lb0-x22b.google.com (mail-lb0-x22b.google.com. [2a00:1450:4010:c04::22b])
        by gmr-mx.google.com with ESMTPS id rw5si1433738lbb.2.2015.12.23.07.52.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2015 07:52:07 -0800 (PST)
Received: by mail-lb0-x22b.google.com with SMTP id pv2so62777271lbb.1
        for <linux-ntb@googlegroups.com>; Wed, 23 Dec 2015 07:52:07 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJ80sat9ocSwGe1UBBHEA0TvDQYCftD1ZVMcyTkAAL_cGwAJTw@mail.gmail.com>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
 <20151223092904.GA31797@infradead.org> <CAJ80sat9ocSwGe1UBBHEA0TvDQYCftD1ZVMcyTkAAL_cGwAJTw@mail.gmail.com>
From: Raghu <raghunath88@gmail.com>
Date: Wed, 23 Dec 2015 09:51:48 -0600
Message-ID: <CAKNCVj+S=dar59sWe9Z7CPeifV2Ey3U_h-KouG8Kf=q9JGz=yA@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
Content-Type: multipart/alternative; boundary=089e0118295454c2b6052792b47e
To: Allen Hubbe <allenbh@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, Xiangliang Yu <Xiangliang.Yu@amd.com>, SPG_Linux_Kernel@amd.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--089e0118295454c2b6052792b47e
Content-Type: text/plain; charset=UTF-8

Christoph, Allen,

I am currently a serious consumer of the NTB subsystem as well. Both the
ntb_netdev (ethernet) driver, as well as the basic NTB transport framework.
I am fairly certain that there are several others who are yet to come
forward and declare that they are a consumer.


Raghu

On Wed, Dec 23, 2015 at 9:09 AM, Allen Hubbe <allenbh@gmail.com> wrote:

> On Wed, Dec 23, 2015, 3:29 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > Just curious, what do you actually use NTB for?
>
> There is an ethernet driver for ntb in Linux. I believe that has users,
> though Dave of John could confirm.
>
> There is an RDMA driver at github.com/ntrdma, waiting for more than one
> user and developer before asking to support it in the kernel.
>
> In general, ntb allows peers to write directly into each other's memory to
> transfer data, and it provides some additional mechanisms for coordination.
>
> > Seems like we're
> > adding a giant subsystem without actual consumers, or did I miss
> > something?
>
> It is no surprise that there are few customers. Even with an ntb chip, it
> requires a special hardware configuration to connect the systems with Pcie.
> This had been done with original design manufactured systems. More
> recently, oem systems are becoming available configured for ntb, so there
> may be more customers, and more diversity of applications.
>
> Allen
>
> Please pardon me if this email is not plain text as I am on mobile.
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/CAJ80sat9ocSwGe1UBBHEA0TvDQYCftD1ZVMcyTkAAL_cGwAJTw%40mail.gmail.com
> <https://groups.google.com/d/msgid/linux-ntb/CAJ80sat9ocSwGe1UBBHEA0TvDQYCftD1ZVMcyTkAAL_cGwAJTw%40mail.gmail.com?utm_medium=email&utm_source=footer>
> .
>
> For more options, visit https://groups.google.com/d/optout.
>

--089e0118295454c2b6052792b47e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Christoph, Allen,<br><br></div>I am currently a serio=
us consumer of the NTB subsystem as well. Both the ntb_netdev (ethernet) dr=
iver, as well as the basic NTB transport framework. I am fairly certain tha=
t there are several others who are yet to come forward and declare that the=
y are a consumer.<br></div><div class=3D"gmail_extra"><br clear=3D"all"><di=
v><div class=3D"gmail_signature"><br>Raghu</div></div>
<br><div class=3D"gmail_quote">On Wed, Dec 23, 2015 at 9:09 AM, Allen Hubbe=
 <span dir=3D"ltr">&lt;<a href=3D"mailto:allenbh@gmail.com" target=3D"_blan=
k">allenbh@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_qu=
ote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex=
"><span class=3D""><p dir=3D"ltr">On Wed, Dec 23, 2015, 3:29 AM=C2=A0Christ=
oph Hellwig &lt;<a href=3D"mailto:hch@infradead.org" target=3D"_blank">hch@=
infradead.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Just curious, what do you actually use NTB for?</p>
</span><p dir=3D"ltr">There is an ethernet driver for ntb in Linux. I belie=
ve that has users, though Dave of John could confirm.</p>
<p dir=3D"ltr">There is an RDMA driver at <a href=3D"http://github.com/ntrd=
ma" target=3D"_blank">github.com/ntrdma</a>, waiting for more than one user=
 and developer before asking to support it in the kernel.</p>
<p dir=3D"ltr">In general, ntb allows peers to write directly into each oth=
er&#39;s memory to transfer data, and it provides some additional mechanism=
s for coordination.</p><span class=3D"">
<p dir=3D"ltr">&gt; Seems like we&#39;re<br>
&gt; adding a giant subsystem without actual consumers, or did I miss<br>
&gt; something?</p>
</span><p dir=3D"ltr">It is no surprise that there are few customers. Even =
with an ntb chip, it requires a special hardware configuration to connect t=
he systems with Pcie. This had been done with original design manufactured =
systems. More recently, oem systems are becoming available configured for n=
tb, so there may be more customers, and more diversity of applications.</p>
<p dir=3D"ltr">Allen</p>
<p dir=3D"ltr">Please pardon me if this email is not plain text as I am on =
mobile.</p><span class=3D"">

<p></p>

-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-ntb&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-ntb+unsubscribe@googlegroups.com" target=3D=
"_blank">linux-ntb+unsubscribe@googlegroups.com</a>.<br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com" target=3D"_blank">linux-ntb@googlegroups.com</a>.<br></span>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/CAJ80sat9ocSwGe1UBBHEA0TvDQYCftD1ZVMcyTkAAL_cGwAJTw%40=
mail.gmail.com?utm_medium=3Demail&amp;utm_source=3Dfooter" target=3D"_blank=
">https://groups.google.com/d/msgid/linux-ntb/CAJ80sat9ocSwGe1UBBHEA0TvDQYC=
ftD1ZVMcyTkAAL_cGwAJTw%40mail.gmail.com</a>.<div class=3D"HOEnZb"><div clas=
s=3D"h5"><br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" targ=
et=3D"_blank">https://groups.google.com/d/optout</a>.<br>
</div></div></blockquote></div><br></div>

--089e0118295454c2b6052792b47e--
