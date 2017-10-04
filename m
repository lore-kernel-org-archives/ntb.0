Date: Wed, 4 Oct 2017 07:19:08 -0700 (PDT)
From: Doug Meyer <dmeyer@gigaio.com>
Message-Id: <d8d79017-6480-41ec-b1a9-5b37491b5856@googlegroups.com>
In-Reply-To: <CAMPMW8qb3vPqZOh++D=R7T708xg2U2o-FnTkQJffFPvP6T3agg@mail.gmail.com>
References: <9eef52f7-fdd2-4f9f-a5d9-9c607d406079@googlegroups.com> <92E70D5D-21C0-47D9-956C-F7049BAA3E9D@intel.com>
 <CAMPMW8qb3vPqZOh++D=R7T708xg2U2o-FnTkQJffFPvP6T3agg@mail.gmail.com>
Subject: Re: GigaIO starting work on Switchtec NTB-based PCI Express fabric
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8310_279124649.1507126748944"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_8310_279124649.1507126748944
Content-Type: multipart/alternative; 
	boundary="----=_Part_8311_1205802559.1507126748945"

------=_Part_8311_1205802559.1507126748945
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On Wednesday, October 4, 2017 at 12:35:08 AM UTC-7, Fancer's opinion wrote:
>
> Hello Doug.
> Glad to see you and your team joining the NTB-community and willing to=20
> contribute to this undoubtedly interesting project. As Dave, Jon and Alle=
n=20
> already pointed out, it's always welcome to have more heads and hands=20
> working on this.
>

Dear Sergey,

First, I apologize for misspelling your name in my first communication with=
=20
you.

Thank you (and everybody) for the kind welcomes. It sure helps, as I'm=20
coming into this so green.

=20

> Regarding your team intentions of making ntb_transport to support a=20
> muti-host topology. It seems to me at the moment, that we could follow on=
e=20
> of two possible design implementations:
> 1) Point-to-point base design
> This approach means, that each NTB-port would be backend of only one=20
> network interface. In this way we'd have a point-to-point topology, since=
=20
> each host would have as many network interfaces as there are possible pee=
rs=20
> in the system in accordance with NTB port count configuration. Particular=
ly=20
> Intel/AMD would have just one interface, IDT-based devices - at most eigh=
t=20
> interfaces and Switchtec - just one interface at the moment. This is the=
=20
> easiest approach of ones I currently have in mind.
>
> 2) Broadcast base design
> In this case ntb_transport driver would allocate memory windows to=20
> communicate with all the available NTB peers over just single network=20
> interface. This approach would be much more preferable to develop, but it=
's=20
> much harder way, as Allen already pointed out, due to the good possibilit=
y=20
> to stuck with routing/switching problems. The thing like broadcast would =
be=20
> easy to implement, but point-to-point communications may lead to some=20
> difficulties. The difficulty is in analyzing outbound packets so to=20
> properly select a target peer device. The workaround would be to just=20
> broadcast packets to all the possible peers so each of them would decide=
=20
> with packet is addressed to them and which is not. But in this way, since=
=20
> all the peers would need to handle an interrupt for each incoming packet,=
=20
> we may get to hosts overloading in case of heavy network traffic. Again a=
s=20
> Allen already pointed out, we couldn't come up with a good design of one=
=20
> memory region sharing between multiple peers. Due to this, the only way w=
e=20
> see is to allocate as many memory windows as there are peers available.
>

It will take me a great deal of time to come up to speed on the network=20
architecture issues that you and Allen have opened my eyes to.=20

What strikes me as a first impression is that the schedule I'm working=20
against is so short that the multi-host demo will have to be done as a=20
point-to-point design, as you've pointed out. Therefore, unless there is=20
something unavoidable (please let me know) I'm going to have to defer those=
=20
issues for the sake of the demo, and then come back to address them. I=20
agree with you that ntb_hw_switchtec currently supports a single peer. As a=
=20
hack, I can extend this to support up to four peers (or exactly four peers)=
=20
merely to meet the demo schedule. That's not work that I would want to=20
upstream, but it would be a decent education for me. Having it support up=
=20
to 48 peers (the Switchtec 96xG3 maximum) would be better, and more=20
flexible still would be to read up the chip's capabilities and handle=20
whatever the connected Switchtec part can do.

Regarding your roadmap. If I were you I'd start with NTB API studying=20
> (drivers/ntb/ntb.c + include/linux/ntb.h). It is the basis of the=20
> subsystem, so in order to be aware of what is done and why it's done in t=
he=20
> drivers, you need to have a good understanding of the API first.
>

Excellent! Thank you for this recommendation, Sergey. I will give ntb.[ch]=
=20
much greater attention. I've spent a fair amount of time studying the=20
switchtec code (though there are parts I don't yet understand), but only in=
=20
the last couple days started pushing up through the ntb/ntb_transport parts=
.

>> near-term: "extend" (aka hack?) the existing module stack to support=20
> four hosts being able to run ntb_perf and ntb_netdev (not necessarily at=
=20
> the same time).
>
> As Logan may have already told you, you can't communicate with those four=
=20
> hosts over just one Switchtec device, since current Switchtec-driver=20
> supports just single port configuration (if I'm not wrong). So the primar=
y=20
> task would be to redesign the Switchet NTB driver to have multi-port=20
> support in there.
> Ragarding the ntb_perf driver. You may have already seen in the mailing=
=20
> list, that I've already refactored the driver for multi-port NTB API. We=
=20
> are currently in the progress of debugging it on Intel hardware, so soon=
=20
> enough we'll have ntb_perf, ntb_tools and ntb_pingpong drivers fully=20
> supporting the NTB multi-port API.
>

I did see those changes late yesterday, but it didn't click until I read=20
this. I didn't recall seeing multi-port support in the NTB code, and now I=
=20
see why... ntb.c indicates version 1.0 released "24 March 2015", and the=20
git log shows the most recent update was 20 Dec 2016. So what I pulled out=
=20
of our local repo is very out-of-date. There's task #1 this morning. I'm=20
glad you talked about this!

Regarding ntb_perf, ntb_tools, and ntb_pingpong, I've yet to look at a=20
single line of that source.

JSYK: I will have more hardware here in a couple days so I will have a=20
complete four-host system built in order to be able to test the changes.
=20

> >> mid-term: move the modules to support an (nearly) arbitrary number of=
=20
> hosts/devices on a single Switchtec device
>
> I think that this task is almost the same as to develop the ntb_transport=
=20
> driver for just four peers. You'll only need to select a proper design fr=
om=20
> the ones described earlier in this letter (or some up with something=20
> better).
>

It would be great if I didn't have to do two implementations. It's going to=
=20
be a matter of schedule and what I can get done. It will probably be faster=
=20
to hardcode a four peer configuration than to do an arbitrary number, but=
=20
perhaps not that different (you know, and you're saying they're almost the=
=20
same). I need to get into it once I have a solid understanding of the NTB=
=20
multi-port API.=20
=20

> >> longer-term: support a generalized model that supports cascaded=20
> switches
>
> Yeah, it would be awesome to have this supported in the Switchtec driver.=
=20
> Personally I have the same intention for the IDT driver, but had no time=
=20
> and hardware at the moment to work on it.
>

If you have put any architectural thoughts down on paper for this, I would=
=20
be interested (in a few weeks) just so we could start to see your thinking=
=20
and join in on the fun.

Also, at some point this feature moves into the realm of subnet/fabric=20
management software as well. To really do this completely starts to feel=20
very much like an analog to an IB subnet manager sitting on top of a fabric=
=20
of switches. This is a large discussion for another day (month), but I=20
added the bullet because it's in our roadmap.
=20

> As guys already said, it's much more effective to use IRC chat to ask som=
e=20
> quick questions. Even though it doesn't have much members at the moment,=
=20
> there is almost always someone available for communications. Still if you=
=20
> got some bigger questions or something to declare you may want to use the=
=20
> linux-ntb mailing list so to involve as many community members as possibl=
e.
>

Great advice. I responded here for continuity and because of the length.=20
I'll go to IRC for quick stuff.
=20

>
> Welcome aboard man and good luck with your developments.
> Regards,
> -Sergey
>
>
> On Wed, Oct 4, 2017 at 1:45 AM, Jiang, Dave <dave....@intel.com=20
> <javascript:>> wrote:
>
>> Welcome Doug! Excited about the news and looking forward to you and your=
=20
>> team=E2=80=99s contributions!
>>
>> On Oct 3, 2017, at 3:04 PM, Doug Meyer <dme...@gigaio.com <javascript:>>=
=20
>> wrote:
>>
>> On the recommendation of Logan Gunthorpe, this new topic is to let the=
=20
>> NTB community know that GigaIO Networks has kicked off work to use and=
=20
>> expand the existing work on the Switchtec and NTB modules.=20
>>
>> GigaIO currently has a small team of software engineers that are just=20
>> getting started. For this topic, the key folks are:
>> Scott Taylor: Fearless director, as well as technical lead for some area=
s.
>> Eric Pilmore: Working on DMA/NTRDMA functionality and performance right=
=20
>> now, and will likely work on various parts of the NTB plumbing a bit lat=
er.
>> Doug Meyer: Working on the stack from switchtec up through ntb_transport=
.
>>
>> We've got a couple bench setups, each using some little Intel ITX=20
>> machines (plus other devices) connected through a Switchtec PFX 96xG3.=
=20
>> We're running 4.13 along with the very current switchtec/NTB code off of=
=20
>> github.=20
>>
>> In terms of GigaIO's goals, the first goals surrounding NTB are:
>>
>>    - near-term: "extend" (aka hack?) the existing module stack to=20
>>    support four hosts being able to run ntb_perf and ntb_netdev (not=20
>>    necessarily at the same time).
>>    - mid-term: move the modules to support an (nearly) arbitrary number=
=20
>>    of hosts/devices on a single Switchtec device
>>    - longer-term: support a generalized model that supports cascaded=20
>>    switches
>>
>> The three of us are excited about joining the community and=20
>> collaborating. We're working through (stumbling up) the learning curves,=
=20
>> and recognize that you folks are the experts. I've no doubt we'll need=
=20
>> help, both in understanding the code, APIs, and current plans, but also =
in=20
>> how we should present our proposals, go through code reviews, and comple=
te=20
>> the test/integration process.
>>
>> We're sure that you folks are far down the road compared to us, and we'l=
l=20
>> do our best to catch up and contribute substantially. Having said that, =
we=20
>> also expect that you already have thoughts and plans where various piece=
s=20
>> should go, and we don't want to step on toes or just "do our own thing"=
=20
>> because we're oblivious. So, thank you ahead of time for all the help an=
d=20
>> insight you can give, and we'll try to be careful to thank you along the=
=20
>> way too.
>>
>> Thanks to Logan, Dave, Allen, and Jon for already sending their welcomes=
,=20
>> providing some initial help, and encouraging us to engaged here. I=20
>> appreciate it, guys!
>>
>> Blessings,
>> Doug
>>
>> --=20
>> You received this message because you are subscribed to the Google Group=
s=20
>> "linux-ntb" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n=20
>> email to linux-ntb+...@googlegroups.com <javascript:>.
>> To post to this group, send email to linu...@googlegroups.com=20
>> <javascript:>.
>> To view this discussion on the web visit=20
>> https://groups.google.com/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c60=
7d406079%40googlegroups.com=20
>> <https://groups.google.com/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c6=
07d406079%40googlegroups.com?utm_medium=3Demail&utm_source=3Dfooter>
>> .
>> For more options, visit https://groups.google.com/d/optout.
>>
>> --=20
>> You received this message because you are subscribed to the Google Group=
s=20
>> "linux-ntb" group.
>> To unsubscribe from this group and stop receiving emails from it, send a=
n=20
>> email to linux-ntb+...@googlegroups.com <javascript:>.
>> To post to this group, send email to linu...@googlegroups.com=20
>> <javascript:>.
>> To view this discussion on the web visit=20
>> https://groups.google.com/d/msgid/linux-ntb/92E70D5D-21C0-47D9-956C-F704=
9BAA3E9D%40intel.com=20
>> <https://groups.google.com/d/msgid/linux-ntb/92E70D5D-21C0-47D9-956C-F70=
49BAA3E9D%40intel.com?utm_medium=3Demail&utm_source=3Dfooter>
>> .
>>
>> For more options, visit https://groups.google.com/d/optout.
>>
>
>
------=_Part_8311_1205802559.1507126748945
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><br>On Wednesday, October 4, 2017 at 12:35:08 AM UTC-7=
, Fancer&#39;s opinion wrote:<blockquote class=3D"gmail_quote" style=3D"mar=
gin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><=
div dir=3D"ltr">Hello Doug.<div>Glad to see you and your team joining the N=
TB-community and willing to contribute to this undoubtedly interesting proj=
ect. As Dave, Jon and Allen already pointed out, it&#39;s always welcome to=
 have more heads and hands working on this.</div></div></blockquote><div><b=
r></div><div>Dear Sergey,</div><div><br></div><div>First, I apologize for m=
isspelling your name in my first communication with you.</div><div><br></di=
v><div>Thank you (and everybody) for the kind welcomes. It sure helps, as I=
&#39;m coming into this so green.</div><div><br></div><div>=C2=A0</div><blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-=
left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr"><div>Regarding yo=
ur team intentions of making ntb_transport to support a muti-host topology.=
 It seems to me at the moment, that we could follow one of two possible des=
ign implementations:<br></div><div>1) Point-to-point base design</div><div>=
This approach means, that each NTB-port would be backend of only one networ=
k interface. In this way we&#39;d have a point-to-point topology, since eac=
h host would have as many network interfaces as there are possible peers in=
 the system in accordance with NTB port count configuration. Particularly I=
ntel/AMD would have just one interface, IDT-based devices - at most eight i=
nterfaces and Switchtec - just one interface at the moment. This is the eas=
iest approach of ones I currently have in mind.</div><div><br></div><div>2)=
 Broadcast base design</div><div>In this case ntb_transport driver would al=
locate memory windows to communicate with all the available NTB peers over =
just single network interface. This approach would be much more preferable =
to develop, but it&#39;s much harder way, as Allen already pointed out, due=
 to the good possibility to stuck with routing/switching problems. The thin=
g like broadcast would be easy to implement, but point-to-point communicati=
ons may lead to some difficulties. The difficulty is in analyzing outbound =
packets so to properly select a target peer device. The workaround would be=
 to just broadcast packets to all the possible peers so each of them would =
decide with packet is addressed to them and which is not. But in this way, =
since all the peers would need to handle an interrupt for each incoming pac=
ket, we may get to hosts overloading in case of heavy network traffic. Agai=
n as Allen already pointed out, we couldn&#39;t come up with a good design =
of one memory region sharing between multiple peers. Due to this, the only =
way we see is to allocate as many memory windows as there are peers availab=
le.</div></div></blockquote><div><br></div><div>It will take me a great dea=
l of time to come up to speed on the network architecture issues that you a=
nd Allen have opened my eyes to.=C2=A0<br></div><div><br></div><div>What st=
rikes me as a first impression is that the schedule I&#39;m working against=
 is so short that the multi-host demo will have to be done as a point-to-po=
int design, as you&#39;ve pointed out. Therefore, unless there is something=
 unavoidable (please let me know) I&#39;m going to have to defer those issu=
es for the sake of the demo, and then come back to address them. I agree wi=
th you that ntb_hw_switchtec currently supports a single peer. As a hack, I=
 can extend this to support up to four peers (or exactly four peers) merely=
 to meet the demo schedule. That&#39;s not work that I would want to upstre=
am, but it would be a decent education for me. Having it support up to 48 p=
eers (the Switchtec 96xG3 maximum) would be better, and more flexible still=
 would be to read up the chip&#39;s capabilities and handle whatever the co=
nnected Switchtec part can do.</div><div><br></div><blockquote class=3D"gma=
il_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid=
;padding-left: 1ex;"><div dir=3D"ltr"><div>Regarding your roadmap. If I wer=
e you I&#39;d start with NTB API studying (drivers/ntb/ntb.c + include/linu=
x/ntb.h). It is the basis of the subsystem, so in order to be aware of what=
 is done and why it&#39;s done in the drivers, you need to have a good unde=
rstanding of the API first.<br></div></div></blockquote><div><br></div><div=
>Excellent! Thank you for this recommendation, Sergey. I will give ntb.[ch]=
 much greater attention. I&#39;ve spent a fair amount of time studying the =
switchtec code (though there are parts I don&#39;t yet understand), but onl=
y in the last couple days started pushing up through the ntb/ntb_transport =
parts.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margi=
n: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><di=
v dir=3D"ltr"><div></div><div>&gt;&gt;=C2=A0<span style=3D"font-size: 12.8p=
x;">near-term: &quot;extend&quot; (aka hack?) the existing module stack to =
support four hosts being able to run ntb_perf and ntb_netdev (not necessari=
ly at the same time).</span><br></div><div><br></div><div>As Logan may have=
 already told you, you can&#39;t communicate with those four hosts over jus=
t one Switchtec device, since current Switchtec-driver supports just single=
 port configuration (if I&#39;m not wrong). So the primary task would be to=
 redesign the Switchet NTB driver to have multi-port support in there.</div=
><div>Ragarding the ntb_perf driver. You may have already=C2=A0seen in the =
mailing list, that I&#39;ve already refactored the driver for multi-port NT=
B API. We are currently in the progress of debugging it on Intel hardware, =
so soon enough we&#39;ll have ntb_perf, ntb_tools and ntb_pingpong drivers =
fully supporting the NTB multi-port API.</div></div></blockquote><div><br><=
/div><div>I did see those changes late yesterday, but it didn&#39;t click u=
ntil I read this. I didn&#39;t recall seeing multi-port support in the NTB =
code, and now I see why... ntb.c indicates version 1.0 released &quot;24 Ma=
rch 2015&quot;, and the git log shows the most recent update was 20 Dec 201=
6. So what I pulled out of our local repo is very out-of-date. There&#39;s =
task #1 this morning. I&#39;m glad you talked about this!</div><div><br></d=
iv><div>Regarding ntb_perf, ntb_tools, and ntb_pingpong, I&#39;ve yet to lo=
ok at a single line of that source.</div><div><br></div><div>JSYK: I will h=
ave more hardware here in a couple days so I will have a complete four-host=
 system built in order to be able to test the changes.</div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;b=
order-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr"><div>&gt;&g=
t;=C2=A0<span style=3D"font-size: 12.8px;">mid-term: move the modules to su=
pport an (nearly) arbitrary number of hosts/devices on a single Switchtec d=
evice</span><br></div><div><br></div><div>I think that this task is almost =
the same as to develop the ntb_transport driver for just four peers. You&#3=
9;ll only need to select a proper design from the ones described earlier in=
 this letter (or some up with something better).</div></div></blockquote><d=
iv><br></div><div>It would be great if I didn&#39;t have to do two implemen=
tations. It&#39;s going to be a matter of schedule and what I can get done.=
 It will probably be faster to hardcode a four peer configuration than to d=
o an arbitrary number, but perhaps not that different (you know, and you&#3=
9;re saying they&#39;re almost the same). I need to get into it once I have=
 a solid understanding of the NTB multi-port API.=C2=A0</div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;=
border-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr"><div>&gt;&=
gt;=C2=A0<span style=3D"font-size: 12.8px;">longer-term: support a generali=
zed model that supports cascaded switches</span><br></div><div><br></div><d=
iv>Yeah, it would be awesome to have this supported in the Switchtec driver=
. Personally I have the same intention for the IDT driver, but had no time =
and hardware at the moment to work on it.</div></div></blockquote><div><br>=
</div><div>If you have put any architectural thoughts down on paper for thi=
s, I would be interested (in a few weeks) just so we could start to see you=
r thinking and join in on the fun.</div><div><br></div><div>Also, at some p=
oint this feature moves into the realm of subnet/fabric management software=
 as well. To really do this completely starts to feel very much like an ana=
log to an IB subnet manager sitting on top of a fabric of switches. This is=
 a large discussion for another day (month), but I added the bullet because=
 it&#39;s in our roadmap.</div><div>=C2=A0</div><blockquote class=3D"gmail_=
quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;pa=
dding-left: 1ex;"><div dir=3D"ltr"><div>As guys already said, it&#39;s much=
 more effective to use IRC chat to ask some quick questions. Even though it=
 doesn&#39;t have much members at the moment, there is almost always someon=
e available for communications. Still if you got some bigger questions or s=
omething to declare you may want to use the linux-ntb mailing list so to in=
volve as many community members as possible.<br></div></div></blockquote><d=
iv><br></div><div>Great advice. I responded here for continuity and because=
 of the length. I&#39;ll go to IRC for quick stuff.</div><div>=C2=A0</div><=
blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;bord=
er-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr"><div><br></div=
><div>Welcome aboard man and good luck with your developments.</div><div>Re=
gards,</div><div>-Sergey</div><div><br></div><div><br><div class=3D"gmail_q=
uote">On Wed, Oct 4, 2017 at 1:45 AM, Jiang, Dave <span dir=3D"ltr">&lt;<a =
href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"VLZex3ytCAA=
J" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&#39;;return=
 true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true;">dave....=
@intel.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">



<div dir=3D"auto">
<div></div>
<div>Welcome Doug! Excited about the news and looking forward to you and yo=
ur team=E2=80=99s contributions!</div><div><div>
<div><br>
On Oct 3, 2017, at 3:04 PM, Doug Meyer &lt;<a href=3D"javascript:" target=
=3D"_blank" gdf-obfuscated-mailto=3D"VLZex3ytCAAJ" rel=3D"nofollow" onmouse=
down=3D"this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.hre=
f=3D&#39;javascript:&#39;;return true;">dme...@gigaio.com</a>&gt; wrote:<br=
>
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
<a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"VLZex3yt=
CAAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&#39;;ret=
urn true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true;">linux=
-ntb+...@<wbr>googlegroups.com</a>.<br>
To post to this group, send email to <a href=3D"javascript:" target=3D"_bla=
nk" gdf-obfuscated-mailto=3D"VLZex3ytCAAJ" rel=3D"nofollow" onmousedown=3D"=
this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39=
;javascript:&#39;;return true;">
linu...@googlegroups.com</a>.<br>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40googlegroups.co=
m?utm_medium=3Demail&amp;utm_source=3Dfooter" target=3D"_blank" rel=3D"nofo=
llow" onmousedown=3D"this.href=3D&#39;https://groups.google.com/d/msgid/lin=
ux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c607d406079%40googlegroups.com?utm_medium\x=
3demail\x26utm_source\x3dfooter&#39;;return true;" onclick=3D"this.href=3D&=
#39;https://groups.google.com/d/msgid/linux-ntb/9eef52f7-fdd2-4f9f-a5d9-9c6=
07d406079%40googlegroups.com?utm_medium\x3demail\x26utm_source\x3dfooter&#3=
9;;return true;">
https://groups.google.com/d/<wbr>msgid/linux-ntb/9eef52f7-fdd2-<wbr>4f9f-a5=
d9-9c607d406079%<wbr>40googlegroups.com</a>.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" targ=
et=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;https://grou=
ps.google.com/d/optout&#39;;return true;" onclick=3D"this.href=3D&#39;https=
://groups.google.com/d/optout&#39;;return true;">https://groups.google.com/=
d/<wbr>optout</a>.<br>
</div>
</blockquote>
</div></div></div><div><div>


<p></p>

-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-ntb&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"javascript:" target=3D"_blank" gdf-obfuscated-mailto=3D"=
VLZex3ytCAAJ" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;javascript:&=
#39;;return true;" onclick=3D"this.href=3D&#39;javascript:&#39;;return true=
;">linux-ntb+...@<wbr>googlegroups.com</a>.<br>
To post to this group, send email to <a href=3D"javascript:" target=3D"_bla=
nk" gdf-obfuscated-mailto=3D"VLZex3ytCAAJ" rel=3D"nofollow" onmousedown=3D"=
this.href=3D&#39;javascript:&#39;;return true;" onclick=3D"this.href=3D&#39=
;javascript:&#39;;return true;">linu...@googlegroups.com</a>.<br></div></di=
v>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/92E70D5D-21C0-47D9-956C-F7049BAA3E9D%40intel.com?utm_m=
edium=3Demail&amp;utm_source=3Dfooter" target=3D"_blank" rel=3D"nofollow" o=
nmousedown=3D"this.href=3D&#39;https://groups.google.com/d/msgid/linux-ntb/=
92E70D5D-21C0-47D9-956C-F7049BAA3E9D%40intel.com?utm_medium\x3demail\x26utm=
_source\x3dfooter&#39;;return true;" onclick=3D"this.href=3D&#39;https://gr=
oups.google.com/d/msgid/linux-ntb/92E70D5D-21C0-47D9-956C-F7049BAA3E9D%40in=
tel.com?utm_medium\x3demail\x26utm_source\x3dfooter&#39;;return true;">http=
s://groups.google.com/d/<wbr>msgid/linux-ntb/92E70D5D-21C0-<wbr>47D9-956C-F=
7049BAA3E9D%<wbr>40intel.com</a>.<div><div><br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" targ=
et=3D"_blank" rel=3D"nofollow" onmousedown=3D"this.href=3D&#39;https://grou=
ps.google.com/d/optout&#39;;return true;" onclick=3D"this.href=3D&#39;https=
://groups.google.com/d/optout&#39;;return true;">https://groups.google.com/=
d/<wbr>optout</a>.<br>
</div></div></blockquote></div><br></div></div>
</blockquote></div>
------=_Part_8311_1205802559.1507126748945--

------=_Part_8310_279124649.1507126748944--
