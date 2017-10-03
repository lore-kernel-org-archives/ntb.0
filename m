Return-Path: <dave.jiang@intel.com>
Received: from mga07.intel.com (mga07.intel.com. [134.134.136.100])
        by gmr-mx.google.com with ESMTPS id t77si1496427pfi.13.2017.10.03.15.45.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Oct 2017 15:45:44 -0700 (PDT)
From: "Jiang, Dave" <dave.jiang@intel.com>
Subject: Re: GigaIO starting work on Switchtec NTB-based PCI Express fabric
Date: Tue, 3 Oct 2017 22:45:42 +0000
Message-ID: <92E70D5D-21C0-47D9-956C-F7049BAA3E9D@intel.com>
References: <9eef52f7-fdd2-4f9f-a5d9-9c607d406079@googlegroups.com>
In-Reply-To: <9eef52f7-fdd2-4f9f-a5d9-9c607d406079@googlegroups.com>
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_92E70D5D21C047D9956CF7049BAA3E9Dintelcom_"
MIME-Version: 1.0
Return-Path: dave.jiang@intel.com
To: Doug Meyer <dmeyer@gigaio.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--_000_92E70D5D21C047D9956CF7049BAA3E9Dintelcom_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Welcome Doug! Excited about the news and looking forward to you and your te=
am=92s contributions!

On Oct 3, 2017, at 3:04 PM, Doug Meyer <dmeyer@gigaio.com<mailto:dmeyer@gig=
aio.com>> wrote:

On the recommendation of Logan Gunthorpe, this new topic is to let the NTB =
community know that GigaIO Networks has kicked off work to use and expand t=
he existing work on the Switchtec and NTB modules.

GigaIO currently has a small team of software engineers that are just getti=
ng started. For this topic, the key folks are:
Scott Taylor: Fearless director, as well as technical lead for some areas.
Eric Pilmore: Working on DMA/NTRDMA functionality and performance right now=
, and will likely work on various parts of the NTB plumbing a bit later.
Doug Meyer: Working on the stack from switchtec up through ntb_transport.

We've got a couple bench setups, each using some little Intel ITX machines =
(plus other devices) connected through a Switchtec PFX 96xG3. We're running=
 4.13 along with the very current switchtec/NTB code off of github.

In terms of GigaIO's goals, the first goals surrounding NTB are:

  *   near-term: "extend" (aka hack?) the existing module stack to support =
four hosts being able to run ntb_perf and ntb_netdev (not necessarily at th=
e same time).
  *   mid-term: move the modules to support an (nearly) arbitrary number of=
 hosts/devices on a single Switchtec device
  *   longer-term: support a generalized model that supports cascaded switc=
hes

The three of us are excited about joining the community and collaborating. =
We're working through (stumbling up) the learning curves, and recognize tha=
t you folks are the experts. I've no doubt we'll need help, both in underst=
anding the code, APIs, and current plans, but also in how we should present=
 our proposals, go through code reviews, and complete the test/integration =
process.

We're sure that you folks are far down the road compared to us, and we'll d=
o our best to catch up and contribute substantially. Having said that, we a=
lso expect that you already have thoughts and plans where various pieces sh=
ould go, and we don't want to step on toes or just "do our own thing" becau=
se we're oblivious. So, thank you ahead of time for all the help and insigh=
t you can give, and we'll try to be careful to thank you along the way too.

Thanks to Logan, Dave, Allen, and Jon for already sending their welcomes, p=
roviding some initial help, and encouraging us to engaged here. I appreciat=
e it, guys!

Blessings,
Doug

--
You received this message because you are subscribed to the Google Groups "=
linux-ntb" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-ntb+unsubscribe@googlegroups.com<mailto:linux-ntb+unsubscribe=
@googlegroups.com>.
To post to this group, send email to linux-ntb@googlegroups.com<mailto:linu=
x-ntb@googlegroups.com>.
To view this discussion on the web visit https://groups.google.com/d/msgid/=
linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40googlegroups.com<https://g=
roups.google.com/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40g=
ooglegroups.com?utm_medium=3Demail&utm_source=3Dfooter>.
For more options, visit https://groups.google.com/d/optout.

--_000_92E70D5D21C047D9956CF7049BAA3E9Dintelcom_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
</head>
<body dir=3D"auto">
<div></div>
<div>Welcome Doug! Excited about the news and looking forward to you and yo=
ur team=92s contributions!</div>
<div><br>
On Oct 3, 2017, at 3:04 PM, Doug Meyer &lt;<a href=3D"mailto:dmeyer@gigaio.=
com">dmeyer@gigaio.com</a>&gt; wrote:<br>
<br>
</div>
<blockquote type=3D"cite">
<div>
<div dir=3D"ltr">On the recommendation of Logan Gunthorpe, this new topic i=
s to let the NTB community know that GigaIO Networks has kicked off work to=
 use and expand the existing work on the Switchtec and NTB modules.
<div><br>
</div>
<div>GigaIO currently has a small team of software engineers that are just =
getting started. For this topic, the key folks are:</div>
<div>Scott Taylor: Fearless director, as well as technical lead for some ar=
eas.</div>
<div>Eric Pilmore: Working on DMA/NTRDMA functionality and performance righ=
t now, and will likely work on various parts of the NTB plumbing a bit late=
r.</div>
<div>Doug Meyer: Working on the stack from switchtec up through ntb_transpo=
rt.</div>
<div><br>
</div>
<div>We've got a couple bench setups, each using some little Intel ITX mach=
ines (plus other devices) connected through a Switchtec PFX 96xG3. We're ru=
nning 4.13 along with the very current switchtec/NTB code off of github.&nb=
sp;</div>
<div><br>
</div>
<div>In terms of GigaIO's goals, the first goals surrounding NTB are:</div>
<div>
<ul>
<li>near-term: &quot;extend&quot; (aka hack?) the existing module stack to =
support four hosts being able to run ntb_perf and ntb_netdev (not necessari=
ly at the same time).</li><li>mid-term: move the modules to support an (nea=
rly) arbitrary number of hosts/devices on a single Switchtec device</li><li=
>longer-term: support a generalized model that supports cascaded switches</=
li></ul>
<div>The three of us are excited about joining the community and collaborat=
ing. We're working through (stumbling up) the learning curves, and recogniz=
e that you folks are the experts. I've no doubt we'll need help, both in un=
derstanding the code, APIs, and
 current plans, but also in how we should present our proposals, go through=
 code reviews, and complete the test/integration process.</div>
</div>
<div><br>
</div>
<div>We're sure that you folks are far down the road compared to us, and we=
'll do our best to catch up and contribute substantially. Having said that,=
 we also expect that you already have thoughts and plans where various piec=
es should go, and we don't want
 to step on toes or just &quot;do our own thing&quot; because we're oblivio=
us. So, thank you ahead of time for all the help and insight you can give, =
and we'll try to be careful to thank you along the way too.</div>
<div><br>
</div>
<div>Thanks to Logan, Dave, Allen, and Jon for already sending their welcom=
es, providing some initial help, and encouraging us to engaged here. I appr=
eciate it, guys!</div>
<div><br>
</div>
<div>Blessings,</div>
<div>Doug</div>
</div>
<p></p>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-ntb&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to
<a href=3D"mailto:linux-ntb&#43;unsubscribe@googlegroups.com">linux-ntb&#43=
;unsubscribe@googlegroups.com</a>.<br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com">
linux-ntb@googlegroups.com</a>.<br>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40googlegroups.co=
m?utm_medium=3Demail&amp;utm_source=3Dfooter">
https://groups.google.com/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d4=
06079%40googlegroups.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout">http=
s://groups.google.com/d/optout</a>.<br>
</div>
</blockquote>
</body>
</html>

--_000_92E70D5D21C047D9956CF7049BAA3E9Dintelcom_--
