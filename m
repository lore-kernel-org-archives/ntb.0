Return-Path: <cruisethai@gmail.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id b78si129130ljf.3.2017.11.27.15.33.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 15:33:44 -0800 (PST)
Received: by mail-wm0-x22f.google.com with SMTP id 124so20626266wmv.1
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 15:33:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPoiz9xvMQC7qJERUW2=mhED9=E6SLSR7g-7-SoLdkTywZhVZQ@mail.gmail.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com> <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
 <e4c00ca2-3d74-5d88-1824-c517250d164f@deltatee.com> <CAPoiz9xvMQC7qJERUW2=mhED9=E6SLSR7g-7-SoLdkTywZhVZQ@mail.gmail.com>
From: ThanhTuThai <cruisethai@gmail.com>
Date: Tue, 28 Nov 2017 07:33:43 +0800
Message-ID: <CAJQW-Q4oji8=TW2sB_fyP7dZAsptWGzwOKK4vOth23CxcodB9w@mail.gmail.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
Content-Type: multipart/alternative; boundary="94eb2c1959fc4dfeab055eff5535"
To: Jon Mason <jdmason@kudzu.us>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--94eb2c1959fc4dfeab055eff5535
Content-Type: text/plain; charset="UTF-8"

No, it doesn't.

I've also thought about this strategy, and implemented it in my setup.
For the soft-reboot, it works well, I can receive the link up event when it
complete rebooting.
But for power-on reset ( in this case, the switchtec is also power-reset ),
I don't receiver any message of linking-up. So the good peer cannot reset
link status as mention above. But if I reload the drivers on the good peer,
they work perfectly.

Thanks !

On Nov 28, 2017 1:38 AM, "Jon Mason" <jdmason@kudzu.us> wrote:

> On Mon, Nov 27, 2017 at 12:09 PM, Logan Gunthorpe <logang@deltatee.com>
> wrote:
> >
> >
> > On 27/11/17 10:00 AM, Jon Mason wrote:
> >>
> >> We can have a SW watchdog timer to poll it (aka heartbeat) to detect
> >> this, but that's going to eat cycles and could allow for a windows
> >> where the link is down and the sender is writing into oblivion.
> >> Thoughts?
> >
> >
> > I think the easiest way is if we get a link up event, and we already
> think
> > the link is up, then we just put the link down before sending a second
> link
> > up event. I can probably look at doing something like that shortly.
> However,
> > unfortunately, my setup isn't suited to test this as I'm actually looping
> > back both partitions to a single host :(. I'll submit a patch that others
> > can test though.
>
> Sounds great.  ThanhTuThai, can you test this?
>
> >
> > Logan
> >
> > --
> > You received this message because you are subscribed to the Google Groups
> > "linux-ntb" group.
> > To unsubscribe from this group and stop receiving emails from it, send an
> > email to linux-ntb+unsubscribe@googlegroups.com.
> > To post to this group, send email to linux-ntb@googlegroups.com.
> > To view this discussion on the web visit
> > https://groups.google.com/d/msgid/linux-ntb/e4c00ca2-3d74-
> 5d88-1824-c517250d164f%40deltatee.com.
> > For more options, visit https://groups.google.com/d/optout.
>

--94eb2c1959fc4dfeab055eff5535
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">No, it doesn&#39;t.=C2=A0<div dir=3D"auto"><br></div><div=
 dir=3D"auto">I&#39;ve also thought about this strategy, and implemented it=
 in my setup.=C2=A0</div><div dir=3D"auto">For the soft-reboot, it works we=
ll, I can receive the link up event when it complete rebooting.</div><div d=
ir=3D"auto">But for power-on reset ( in this case, the switchtec is also po=
wer-reset ), I don&#39;t receiver any message of linking-up. So the good pe=
er cannot reset link status as mention above. But if I reload the drivers o=
n the good peer, they work perfectly.</div><div dir=3D"auto"><br></div><div=
 dir=3D"auto">Thanks !</div></div><div class=3D"gmail_extra"><br><div class=
=3D"gmail_quote">On Nov 28, 2017 1:38 AM, &quot;Jon Mason&quot; &lt;<a href=
=3D"mailto:jdmason@kudzu.us">jdmason@kudzu.us</a>&gt; wrote:<br type=3D"att=
ribution"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bord=
er-left:1px #ccc solid;padding-left:1ex">On Mon, Nov 27, 2017 at 12:09 PM, =
Logan Gunthorpe &lt;<a href=3D"mailto:logang@deltatee.com">logang@deltatee.=
com</a>&gt; wrote:<br>
&gt;<br>
&gt;<br>
&gt; On 27/11/17 10:00 AM, Jon Mason wrote:<br>
&gt;&gt;<br>
&gt;&gt; We can have a SW watchdog timer to poll it (aka heartbeat) to dete=
ct<br>
&gt;&gt; this, but that&#39;s going to eat cycles and could allow for a win=
dows<br>
&gt;&gt; where the link is down and the sender is writing into oblivion.<br=
>
&gt;&gt; Thoughts?<br>
&gt;<br>
&gt;<br>
&gt; I think the easiest way is if we get a link up event, and we already t=
hink<br>
&gt; the link is up, then we just put the link down before sending a second=
 link<br>
&gt; up event. I can probably look at doing something like that shortly. Ho=
wever,<br>
&gt; unfortunately, my setup isn&#39;t suited to test this as I&#39;m actua=
lly looping<br>
&gt; back both partitions to a single host :(. I&#39;ll submit a patch that=
 others<br>
&gt; can test though.<br>
<br>
Sounds great.=C2=A0 ThanhTuThai, can you test this?<br>
<br>
&gt;<br>
&gt; Logan<br>
&gt;<br>
&gt; --<br>
&gt; You received this message because you are subscribed to the Google Gro=
ups<br>
&gt; &quot;linux-ntb&quot; group.<br>
&gt; To unsubscribe from this group and stop receiving emails from it, send=
 an<br>
&gt; email to <a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com">l=
inux-ntb+unsubscribe@<wbr>googlegroups.com</a>.<br>
&gt; To post to this group, send email to <a href=3D"mailto:linux-ntb@googl=
egroups.com">linux-ntb@googlegroups.com</a>.<br>
&gt; To view this discussion on the web visit<br>
&gt; <a href=3D"https://groups.google.com/d/msgid/linux-ntb/e4c00ca2-3d74-5=
d88-1824-c517250d164f%40deltatee.com" rel=3D"noreferrer" target=3D"_blank">=
https://groups.google.com/d/<wbr>msgid/linux-ntb/e4c00ca2-3d74-<wbr>5d88-18=
24-c517250d164f%<wbr>40deltatee.com</a>.<br>
&gt; For more options, visit <a href=3D"https://groups.google.com/d/optout"=
 rel=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>opto=
ut</a>.<br>
</blockquote></div></div>

--94eb2c1959fc4dfeab055eff5535--
