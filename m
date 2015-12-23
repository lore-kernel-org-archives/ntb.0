Return-Path: <allenbh@gmail.com>
Received: from mail-qg0-x235.google.com (mail-qg0-x235.google.com. [2607:f8b0:400d:c04::235])
        by gmr-mx.google.com with ESMTPS id g66si2897205ywf.4.2015.12.23.07.09.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Dec 2015 07:09:02 -0800 (PST)
Received: by mail-qg0-x235.google.com with SMTP id c96so134409390qgd.3
        for <linux-ntb@googlegroups.com>; Wed, 23 Dec 2015 07:09:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20151223092904.GA31797@infradead.org>
References: <1450878175-9300-1-git-send-email-Xiangliang.Yu@amd.com>
	<20151223092904.GA31797@infradead.org>
Date: Wed, 23 Dec 2015 10:09:01 -0500
Message-ID: <CAJ80sat9ocSwGe1UBBHEA0TvDQYCftD1ZVMcyTkAAL_cGwAJTw@mail.gmail.com>
Subject: Re: [PATCH V2 1/3] NTB: Add AMD PCI-Express NTB driver
From: Allen Hubbe <allenbh@gmail.com>
Content-Type: multipart/alternative; boundary=001a11393f0237d02b0527921a91
To: Christoph Hellwig <hch@infradead.org>, Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: SPG_Linux_Kernel@amd.com, dave.jiang@intel.com, jdmason@kudzu.us, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--001a11393f0237d02b0527921a91
Content-Type: text/plain; charset=UTF-8

On Wed, Dec 23, 2015, 3:29 AM Christoph Hellwig <hch@infradead.org> wrote:
>
> Just curious, what do you actually use NTB for?

There is an ethernet driver for ntb in Linux. I believe that has users,
though Dave of John could confirm.

There is an RDMA driver at github.com/ntrdma, waiting for more than one
user and developer before asking to support it in the kernel.

In general, ntb allows peers to write directly into each other's memory to
transfer data, and it provides some additional mechanisms for coordination.

> Seems like we're
> adding a giant subsystem without actual consumers, or did I miss
> something?

It is no surprise that there are few customers. Even with an ntb chip, it
requires a special hardware configuration to connect the systems with Pcie.
This had been done with original design manufactured systems. More
recently, oem systems are becoming available configured for ntb, so there
may be more customers, and more diversity of applications.

Allen

Please pardon me if this email is not plain text as I am on mobile.

--001a11393f0237d02b0527921a91
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<p dir=3D"ltr">On Wed, Dec 23, 2015, 3:29 AM=C2=A0Christoph Hellwig &lt;<a =
href=3D"mailto:hch@infradead.org">hch@infradead.org</a>&gt; wrote:<br>
&gt;<br>
&gt; Just curious, what do you actually use NTB for?</p>
<p dir=3D"ltr">There is an ethernet driver for ntb in Linux. I believe that=
 has users, though Dave of John could confirm.</p>
<p dir=3D"ltr">There is an RDMA driver at <a href=3D"http://github.com/ntrd=
ma">github.com/ntrdma</a>, waiting for more than one user and developer bef=
ore asking to support it in the kernel.</p>
<p dir=3D"ltr">In general, ntb allows peers to write directly into each oth=
er&#39;s memory to transfer data, and it provides some additional mechanism=
s for coordination.</p>
<p dir=3D"ltr">&gt; Seems like we&#39;re<br>
&gt; adding a giant subsystem without actual consumers, or did I miss<br>
&gt; something?</p>
<p dir=3D"ltr">It is no surprise that there are few customers. Even with an=
 ntb chip, it requires a special hardware configuration to connect the syst=
ems with Pcie. This had been done with original design manufactured systems=
. More recently, oem systems are becoming available configured for ntb, so =
there may be more customers, and more diversity of applications.</p>
<p dir=3D"ltr">Allen</p>
<p dir=3D"ltr">Please pardon me if this email is not plain text as I am on =
mobile.</p>

--001a11393f0237d02b0527921a91--
