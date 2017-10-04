Return-Path: <fancer.lancer@gmail.com>
Received: from mail-oi0-x22e.google.com (mail-oi0-x22e.google.com. [2607:f8b0:4003:c06::22e])
        by gmr-mx.google.com with ESMTPS id l203si833762ywe.23.2017.10.04.00.35.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 00:35:08 -0700 (PDT)
Received: by mail-oi0-x22e.google.com with SMTP id v9so6024387oif.13
        for <linux-ntb@googlegroups.com>; Wed, 04 Oct 2017 00:35:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <92E70D5D-21C0-47D9-956C-F7049BAA3E9D@intel.com>
References: <9eef52f7-fdd2-4f9f-a5d9-9c607d406079@googlegroups.com> <92E70D5D-21C0-47D9-956C-F7049BAA3E9D@intel.com>
From: "Fancer's opinion" <fancer.lancer@gmail.com>
Date: Wed, 4 Oct 2017 10:34:47 +0300
Message-ID: <CAMPMW8qb3vPqZOh++D=R7T708xg2U2o-FnTkQJffFPvP6T3agg@mail.gmail.com>
Subject: Re: GigaIO starting work on Switchtec NTB-based PCI Express fabric
Content-Type: multipart/alternative; boundary="001a1141bb669d141a055ab3a520"
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: Doug Meyer <dmeyer@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--001a1141bb669d141a055ab3a520
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Doug.
Glad to see you and your team joining the NTB-community and willing to
contribute to this undoubtedly interesting project. As Dave, Jon and Allen
already pointed out, it's always welcome to have more heads and hands
working on this.

Regarding your team intentions of making ntb_transport to support a
muti-host topology. It seems to me at the moment, that we could follow one
of two possible design implementations:
1) Point-to-point base design
This approach means, that each NTB-port would be backend of only one
network interface. In this way we'd have a point-to-point topology, since
each host would have as many network interfaces as there are possible peers
in the system in accordance with NTB port count configuration. Particularly
Intel/AMD would have just one interface, IDT-based devices - at most eight
interfaces and Switchtec - just one interface at the moment. This is the
easiest approach of ones I currently have in mind.

2) Broadcast base design
In this case ntb_transport driver would allocate memory windows to
communicate with all the available NTB peers over just single network
interface. This approach would be much more preferable to develop, but it's
much harder way, as Allen already pointed out, due to the good possibility
to stuck with routing/switching problems. The thing like broadcast would be
easy to implement, but point-to-point communications may lead to some
difficulties. The difficulty is in analyzing outbound packets so to
properly select a target peer device. The workaround would be to just
broadcast packets to all the possible peers so each of them would decide
with packet is addressed to them and which is not. But in this way, since
all the peers would need to handle an interrupt for each incoming packet,
we may get to hosts overloading in case of heavy network traffic. Again as
Allen already pointed out, we couldn't come up with a good design of one
memory region sharing between multiple peers. Due to this, the only way we
see is to allocate as many memory windows as there are peers available.


Regarding your roadmap. If I were you I'd start with NTB API studying
(drivers/ntb/ntb.c + include/linux/ntb.h). It is the basis of the
subsystem, so in order to be aware of what is done and why it's done in the
drivers, you need to have a good understanding of the API first.

>> near-term: "extend" (aka hack?) the existing module stack to support
four hosts being able to run ntb_perf and ntb_netdev (not necessarily at
the same time).

As Logan may have already told you, you can't communicate with those four
hosts over just one Switchtec device, since current Switchtec-driver
supports just single port configuration (if I'm not wrong). So the primary
task would be to redesign the Switchet NTB driver to have multi-port
support in there.
Ragarding the ntb_perf driver. You may have already seen in the mailing
list, that I've already refactored the driver for multi-port NTB API. We
are currently in the progress of debugging it on Intel hardware, so soon
enough we'll have ntb_perf, ntb_tools and ntb_pingpong drivers fully
supporting the NTB multi-port API.

>> mid-term: move the modules to support an (nearly) arbitrary number of
hosts/devices on a single Switchtec device

I think that this task is almost the same as to develop the ntb_transport
driver for just four peers. You'll only need to select a proper design from
the ones described earlier in this letter (or some up with something
better).

>> longer-term: support a generalized model that supports cascaded switches

Yeah, it would be awesome to have this supported in the Switchtec driver.
Personally I have the same intention for the IDT driver, but had no time
and hardware at the moment to work on it.

As guys already said, it's much more effective to use IRC chat to ask some
quick questions. Even though it doesn't have much members at the moment,
there is almost always someone available for communications. Still if you
got some bigger questions or something to declare you may want to use the
linux-ntb mailing list so to involve as many community members as possible.

Welcome aboard man and good luck with your developments.
Regards,
-Sergey


On Wed, Oct 4, 2017 at 1:45 AM, Jiang, Dave <dave.jiang@intel.com> wrote:

> Welcome Doug! Excited about the news and looking forward to you and your
> team=E2=80=99s contributions!
>
> On Oct 3, 2017, at 3:04 PM, Doug Meyer <dmeyer@gigaio.com> wrote:
>
> On the recommendation of Logan Gunthorpe, this new topic is to let the NT=
B
> community know that GigaIO Networks has kicked off work to use and expand
> the existing work on the Switchtec and NTB modules.
>
> GigaIO currently has a small team of software engineers that are just
> getting started. For this topic, the key folks are:
> Scott Taylor: Fearless director, as well as technical lead for some areas=
.
> Eric Pilmore: Working on DMA/NTRDMA functionality and performance right
> now, and will likely work on various parts of the NTB plumbing a bit late=
r.
> Doug Meyer: Working on the stack from switchtec up through ntb_transport.
>
> We've got a couple bench setups, each using some little Intel ITX machine=
s
> (plus other devices) connected through a Switchtec PFX 96xG3. We're runni=
ng
> 4.13 along with the very current switchtec/NTB code off of github.
>
> In terms of GigaIO's goals, the first goals surrounding NTB are:
>
>    - near-term: "extend" (aka hack?) the existing module stack to support
>    four hosts being able to run ntb_perf and ntb_netdev (not necessarily =
at
>    the same time).
>    - mid-term: move the modules to support an (nearly) arbitrary number
>    of hosts/devices on a single Switchtec device
>    - longer-term: support a generalized model that supports cascaded
>    switches
>
> The three of us are excited about joining the community and collaborating=
.
> We're working through (stumbling up) the learning curves, and recognize
> that you folks are the experts. I've no doubt we'll need help, both in
> understanding the code, APIs, and current plans, but also in how we shoul=
d
> present our proposals, go through code reviews, and complete the
> test/integration process.
>
> We're sure that you folks are far down the road compared to us, and we'll
> do our best to catch up and contribute substantially. Having said that, w=
e
> also expect that you already have thoughts and plans where various pieces
> should go, and we don't want to step on toes or just "do our own thing"
> because we're oblivious. So, thank you ahead of time for all the help and
> insight you can give, and we'll try to be careful to thank you along the
> way too.
>
> Thanks to Logan, Dave, Allen, and Jon for already sending their welcomes,
> providing some initial help, and encouraging us to engaged here. I
> appreciate it, guys!
>
> Blessings,
> Doug
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/ms
> gid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40googlegroups.com
> <https://groups.google.com/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c60=
7d406079%40googlegroups.com?utm_medium=3Demail&utm_source=3Dfooter>
> .
> For more options, visit https://groups.google.com/d/optout.
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/ms
> gid/linux-ntb/92E70D5D-21C0-47D9-956C-F7049BAA3E9D%40intel.com
> <https://groups.google.com/d/msgid/linux-ntb/92E70D5D-21C0-47D9-956C-F704=
9BAA3E9D%40intel.com?utm_medium=3Demail&utm_source=3Dfooter>
> .
>
> For more options, visit https://groups.google.com/d/optout.
>

--001a1141bb669d141a055ab3a520
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello Doug.<div>Glad to see you and your team joining the =
NTB-community and willing to contribute to this undoubtedly interesting pro=
ject. As Dave, Jon and Allen already pointed out, it&#39;s always welcome t=
o have more heads and hands working on this.</div><div><br></div><div>Regar=
ding your team intentions of making ntb_transport to support a muti-host to=
pology. It seems to me at the moment, that we could follow one of two possi=
ble design implementations:</div><div>1) Point-to-point base design</div><d=
iv>This approach means, that each NTB-port would be backend of only one net=
work interface. In this way we&#39;d have a point-to-point topology, since =
each host would have as many network interfaces as there are possible peers=
 in the system in accordance with NTB port count configuration. Particularl=
y Intel/AMD would have just one interface, IDT-based devices - at most eigh=
t interfaces and Switchtec - just one interface at the moment. This is the =
easiest approach of ones I currently have in mind.</div><div><br></div><div=
>2) Broadcast base design</div><div>In this case ntb_transport driver would=
 allocate memory windows to communicate with all the available NTB peers ov=
er just single network interface. This approach would be much more preferab=
le to develop, but it&#39;s much harder way, as Allen already pointed out, =
due to the good possibility to stuck with routing/switching problems. The t=
hing like broadcast would be easy to implement, but point-to-point communic=
ations may lead to some difficulties. The difficulty is in analyzing outbou=
nd packets so to properly select a target peer device. The workaround would=
 be to just broadcast packets to all the possible peers so each of them wou=
ld decide with packet is addressed to them and which is not. But in this wa=
y, since all the peers would need to handle an interrupt for each incoming =
packet, we may get to hosts overloading in case of heavy network traffic. A=
gain as Allen already pointed out, we couldn&#39;t come up with a good desi=
gn of one memory region sharing between multiple peers. Due to this, the on=
ly way we see is to allocate as many memory windows as there are peers avai=
lable.</div><div><br></div><div><br></div><div>Regarding your roadmap. If I=
 were you I&#39;d start with NTB API studying (drivers/ntb/ntb.c + include/=
linux/ntb.h). It is the basis of the subsystem, so in order to be aware of =
what is done and why it&#39;s done in the drivers, you need to have a good =
understanding of the API first.</div><div><br></div><div>&gt;&gt;=C2=A0<spa=
n style=3D"font-size:12.8px">near-term: &quot;extend&quot; (aka hack?) the =
existing module stack to support four hosts being able to run ntb_perf and =
ntb_netdev (not necessarily at the same time).</span></div><div><br></div><=
div>As Logan may have already told you, you can&#39;t communicate with thos=
e four hosts over just one Switchtec device, since current Switchtec-driver=
 supports just single port configuration (if I&#39;m not wrong). So the pri=
mary task would be to redesign the Switchet NTB driver to have multi-port s=
upport in there.</div><div>Ragarding the ntb_perf driver. You may have alre=
ady=C2=A0seen in the mailing list, that I&#39;ve already refactored the dri=
ver for multi-port NTB API. We are currently in the progress of debugging i=
t on Intel hardware, so soon enough we&#39;ll have ntb_perf, ntb_tools and =
ntb_pingpong drivers fully supporting the NTB multi-port API.</div><div><br=
></div><div>&gt;&gt;=C2=A0<span style=3D"font-size:12.8px">mid-term: move t=
he modules to support an (nearly) arbitrary number of hosts/devices on a si=
ngle Switchtec device</span></div><div><br></div><div>I think that this tas=
k is almost the same as to develop the ntb_transport driver for just four p=
eers. You&#39;ll only need to select a proper design from the ones describe=
d earlier in this letter (or some up with something better).</div><div><br>=
</div><div>&gt;&gt;=C2=A0<span style=3D"font-size:12.8px">longer-term: supp=
ort a generalized model that supports cascaded switches</span></div><div><b=
r></div><div>Yeah, it would be awesome to have this supported in the Switch=
tec driver. Personally I have the same intention for the IDT driver, but ha=
d no time and hardware at the moment to work on it.</div><div><br></div><di=
v>As guys already said, it&#39;s much more effective to use IRC chat to ask=
 some quick questions. Even though it doesn&#39;t have much members at the =
moment, there is almost always someone available for communications. Still =
if you got some bigger questions or something to declare you may want to us=
e the linux-ntb mailing list so to involve as many community members as pos=
sible.</div><div><br></div><div>Welcome aboard man and good luck with your =
developments.</div><div>Regards,</div><div>-Sergey</div><div><br></div><div=
 class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Wed, Oct 4, 2017 a=
t 1:45 AM, Jiang, Dave <span dir=3D"ltr">&lt;<a href=3D"mailto:dave.jiang@i=
ntel.com" target=3D"_blank">dave.jiang@intel.com</a>&gt;</span> wrote:<br><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">



<div dir=3D"auto">
<div></div>
<div>Welcome Doug! Excited about the news and looking forward to you and yo=
ur team=E2=80=99s contributions!</div><div><div class=3D"gmail-m_7288181320=
413688170m_7397521112991571352m_4264584405780097187h5">
<div><br>
On Oct 3, 2017, at 3:04 PM, Doug Meyer &lt;<a href=3D"mailto:dmeyer@gigaio.=
com" target=3D"_blank">dmeyer@gigaio.com</a>&gt; wrote:<br>
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
<div>We&#39;ve got a couple bench setups, each using some little Intel ITX =
machines (plus other devices) connected through a Switchtec PFX 96xG3. We&#=
39;re running 4.13 along with the very current switchtec/NTB code off of gi=
thub.=C2=A0</div>
<div><br>
</div>
<div>In terms of GigaIO&#39;s goals, the first goals surrounding NTB are:</=
div>
<div>
<ul>
<li>near-term: &quot;extend&quot; (aka hack?) the existing module stack to =
support four hosts being able to run ntb_perf and ntb_netdev (not necessari=
ly at the same time).</li><li>mid-term: move the modules to support an (nea=
rly) arbitrary number of hosts/devices on a single Switchtec device</li><li=
>longer-term: support a generalized model that supports cascaded switches</=
li></ul>
<div>The three of us are excited about joining the community and collaborat=
ing. We&#39;re working through (stumbling up) the learning curves, and reco=
gnize that you folks are the experts. I&#39;ve no doubt we&#39;ll need help=
, both in understanding the code, APIs, and
 current plans, but also in how we should present our proposals, go through=
 code reviews, and complete the test/integration process.</div>
</div>
<div><br>
</div>
<div>We&#39;re sure that you folks are far down the road compared to us, an=
d we&#39;ll do our best to catch up and contribute substantially. Having sa=
id that, we also expect that you already have thoughts and plans where vari=
ous pieces should go, and we don&#39;t want
 to step on toes or just &quot;do our own thing&quot; because we&#39;re obl=
ivious. So, thank you ahead of time for all the help and insight you can gi=
ve, and we&#39;ll try to be careful to thank you along the way too.</div>
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
<a href=3D"mailto:linux-ntb+unsubscribe@googlegroups.com" target=3D"_blank"=
>linux-ntb+unsubscribe@googlegr<wbr>oups.com</a>.<br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com" target=3D"_blank">
linux-ntb@googlegroups.com</a>.<br>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40googlegroups.co=
m?utm_medium=3Demail&amp;utm_source=3Dfooter" target=3D"_blank">
https://groups.google.com/d/ms<wbr>gid/linux-ntb/9eef52f7-fdd2-4f<wbr>9f-a5=
d9-9c607d406079%40googleg<wbr>roups.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" targ=
et=3D"_blank">https://groups.google.com/d/op<wbr>tout</a>.<br>
</div>
</blockquote>
</div></div></div><div><div class=3D"gmail-m_7288181320413688170m_739752111=
2991571352m_4264584405780097187h5">


<p></p>

-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-ntb&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-ntb+unsubscribe@googlegroups.com" target=3D=
"_blank">linux-ntb+unsubscribe@googlegr<wbr>oups.com</a>.<br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com" target=3D"_blank">linux-ntb@googlegroups.com</a>.<br></div></div>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/92E70D5D-21C0-47D9-956C-F7049BAA3E9D%40intel.com?utm_m=
edium=3Demail&amp;utm_source=3Dfooter" target=3D"_blank">https://groups.goo=
gle.com/d/ms<wbr>gid/linux-ntb/92E70D5D-21C0-47<wbr>D9-956C-F7049BAA3E9D%40=
intel.c<wbr>om</a>.<div class=3D"gmail-m_7288181320413688170m_7397521112991=
571352m_4264584405780097187HOEnZb"><div class=3D"gmail-m_728818132041368817=
0m_7397521112991571352m_4264584405780097187h5"><br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" targ=
et=3D"_blank">https://groups.google.com/d/op<wbr>tout</a>.<br>
</div></div></blockquote></div><br></div></div>

--001a1141bb669d141a055ab3a520--
