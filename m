Date: Tue, 10 Oct 2017 08:52:06 -0700 (PDT)
From: Doug Meyer <dmeyer@gigaio.com>
Message-Id: <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
In-Reply-To: <000001d341d2$87574f20$9605ed60$@dell.com>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_8274_1876139600.1507650726287"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_8274_1876139600.1507650726287
Content-Type: multipart/alternative; 
	boundary="----=_Part_8275_876963349.1507650726288"

------=_Part_8275_876963349.1507650726288
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Dear Allen,

Thank you for your reply and additional information.

Two things:
* I've added a verbose comment to your words about messages and 
scratchpads, because it dovetails with a discussion I had over here 
yesterday.

I do need to pursue the crux of my initial post further, which is mostly 
focused on the bottom part (extension of switchtec).

On Tuesday, October 10, 2017 at 7:17:58 AM UTC-7, Allen Hubbe wrote:
>
> From: Doug Meyer 
> > Gents, 
> > 
> [... elided by dmeyer]
> > 
> > But most importantly, I'm wondering about struct shared_mw. Could the 
> Switchtec message registers have 
> > been used? 
>
> About a year ago when Serge joined the team, we spent a while trying to 
> unify the message and scratchpad api.  At the same time, there is a 
> preference to keep ntb.h very light and expose the hardware functionality 
> as directly as possible.  We decided to split the apis for scratchpads and 
> message registers.  For hardware that supports message registers, it should 
> expose those via the message api.  


> What this currently implies is that the next layer up driver needs to work 
> with either scratchpads or message registers.  If a driver only works with 
> spads, then it is not portable.  I would like there to be some library code 
> added to the common ntb bus driver to help with that.  Serge is currently 
> making changes to the ntb_transport driver to support multi-port and 
> message registers on IDT.  It may only work for the transport driver at 
> first, but I have some hope that it could be transformed into library code. 
>

This is a very interesting couple paragraphs. Any my reply here could be 
painful for you and the team because I'm so new to this...

Yesterday I had a discussion about where the switch resources would be 
managed/tracked, versus where the resource requests were coming from. In 
some ways it looks like an MVC architecture (I could really be wrong here). 
To expand on that, ntb.ko exports the abstracted View of the switch as well 
as the Control API. Clients of ntb.ko (e.g. ntb_transport) use that and 
export their own View and Control APIs. In this case, the switch's Model is 
in ntb.ko, with the hardware-specific plug-ins supporting that Model 
directly by any means necessary.

What I *think* that implies is that ntb.c manages the model's resources, 
but the hardware plug-in needs to be sophisticated enough with switch 
hardware resource management strategies (not just message registers and 
scratchpads, but LUTs, direct-mapped windows, doorbells, etc.), a knowledge 
of what can and can't be dynamically configured in the switch, and what has 
been reserved during probe/init for infrastructure, so that it has a decent 
arsenal of ways to try to fulfill whatever is being asked from above.

Given that: whether the configuration is truly static (resources allocated 
and fixed at start-of-day and never changed), or dynamic with hot-plug 
events, application or other fabric management configuring and freeing 
shared memory, perhaps opening and closing windows to large NVMe memory 
space, or who knows what, it is below ntb.ko that has to try to fulfill 
each ask, but it is above ntb,ko to manage the overall PCIe fabric 
presented by the Views on all the connected peers.

The ramifications of this would be that ntb.h (by that I think you mean the 
upward-facing API for all ntb.ko clients) is the View and Control 
abstraction, and it can hopefully stay thin, with the cost being that ntb.c 
and the hardware plug-ins probably get "fat" because they need to not just 
manage the Model, but pick up all the slack between the abstracted API and 
the hardware.

Am I even remotely close?

Also, regarding your portability requirement. On one hand, it sounds like 
messages and scratchpads have distinct properties that make it advantageous 
to expose separately in ntb.h, and yet the portability requirement seems to 
want to abstract them as a single interface. Can you offer up any further 
thoughts on this, please?


 

> > What do people think about how this technique scales when there are more 
> than two peers? Obviously 
>
> That limitation was stated upfront with that driver submission.  The 
> Switchtec driver only works with two nodes for now. 
>

So this section of my email is where I am really hoping to gain 
understanding...

I realize that the Switchtec driver has the two-peer limitation, and I 
apologize that I did not make it clear that the context here is my work to 
remove that limitation (in increments). My current task is to move 
switchtec and ntb-hw-switchtec (by hook or by crook) to support up to four 
peers. 

I can achieve this in a brute-force way, which I may have to do with the 
time allotted for the task, but my hope is to understand what I assume is a 
lot of good thought that went into the current design. By gaining 
understanding, I may be able to choose a near-term approach which is not 
entirely throw-away code, while also having understanding to be careful to 
retain parts of the design which you all have deemed essential (or at least 
preferred). In addition, perhaps some thought had/has already been given to 
how the current design would be extended, and so this design was chosen. I 
don't know, so I'm asking.

This is the only way I know to begin engaging on this. If there is a better 
or preferred approach, please let me know.

All of the following observations were my attempt to have folks give me 
some understanding if this approach is necessary, sufficient, or something 
else, as well as to see what thought has been given to scaling up the 
peers. I should have been explicit (sorry). I'm guessing y'all have thought 
about where you'd like to see the design go and where you see issues.

For now, I'm likely to merely create an array of shared_mw based on 
partition number and restrict the Switchtec configuration to use only the 
first four partitions. But if somebody says "I was thinking that this would 
actually be best done as Y, and it's probably little more work than your 
near-term hack" then I'm sure going to listen!

> LUTs are a precious resource, and a LUT per peer shared_mw is expensive. 
> A LUT broken up into many 
> > shared_mw is a possibility, though there is always risk of trashing 
> stuff. 
> > Also, if the LUTs need to be much larger (for application use), then a 
> large chunk of the BAR space 
> > could be used for a relatively small structure. 
> > I'd love to hear anyone's thoughts on this. 
> > 
> > As an aside, I'm curious why the LUT size is 64 KiB? Was this just a 
> nice number as a starting point? 
> > 
> > Thanks again, folks. 
>

Thanks again (and again).

Blessings,
Doug

------=_Part_8275_876963349.1507650726288
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Allen,<div><br></div><div>Thank you for your reply an=
d additional information.</div><div><br></div><div>Two things:</div><div>* =
I&#39;ve added a verbose comment to your words about messages and scratchpa=
ds, because it dovetails with a discussion I had over here yesterday.</div>=
<div><br></div><div>I do need to pursue the crux of my initial post further=
, which is mostly focused on the bottom part (extension of switchtec).<br><=
br>On Tuesday, October 10, 2017 at 7:17:58 AM UTC-7, Allen Hubbe wrote:<blo=
ckquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-=
left: 1px #ccc solid;padding-left: 1ex;">From: Doug Meyer
<br>&gt; Gents,
<br>&gt;=20
<br>[... elided by dmeyer]<br>&gt;=20
<br>&gt; But most importantly, I&#39;m wondering about struct shared_mw. Co=
uld the Switchtec message registers have
<br>&gt; been used?
<br>
<br>About a year ago when Serge joined the team, we spent a while trying to=
 unify the message and scratchpad api. =C2=A0At the same time, there is a p=
reference to keep ntb.h very light and expose the hardware functionality as=
 directly as possible. =C2=A0We decided to split the apis for scratchpads a=
nd message registers. =C2=A0For hardware that supports message registers, i=
t should expose those via the message api. =C2=A0</blockquote><blockquote c=
lass=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px=
 #ccc solid;padding-left: 1ex;">
<br>What this currently implies is that the next layer up driver needs to w=
ork with either scratchpads or message registers. =C2=A0If a driver only wo=
rks with spads, then it is not portable. =C2=A0I would like there to be som=
e library code added to the common ntb bus driver to help with that. =C2=A0=
Serge is currently making changes to the ntb_transport driver to support mu=
lti-port and message registers on IDT. =C2=A0It may only work for the trans=
port driver at first, but I have some hope that it could be transformed int=
o library code.
<br></blockquote><div><br></div><div>This is a very interesting couple para=
graphs. Any my reply here could be painful for you and the team because I&#=
39;m so new to this...</div><div><br></div><div>Yesterday I had a discussio=
n about where the switch resources would be managed/tracked, versus where t=
he resource requests were coming from. In some ways it looks like an MVC ar=
chitecture (I could really be wrong here). To expand on that, ntb.ko export=
s the abstracted View of the switch as well as the Control API. Clients of =
ntb.ko (e.g. ntb_transport) use that and export their own View and Control =
APIs. In this case, the switch&#39;s Model is in ntb.ko, with the hardware-=
specific plug-ins supporting that Model directly by any means necessary.</d=
iv><div><br></div><div>What I <i>think</i> that implies is that ntb.c manag=
es the model&#39;s resources, but the hardware plug-in needs to be sophisti=
cated enough with switch hardware resource management strategies (not just =
message registers and scratchpads, but LUTs, direct-mapped windows, doorbel=
ls, etc.), a knowledge of what can and can&#39;t be dynamically configured =
in the switch, and what has been reserved during probe/init for infrastruct=
ure, so that it has a decent arsenal of ways to try to fulfill whatever is =
being asked from above.</div><div><br></div><div>Given that: whether the co=
nfiguration is truly static (resources allocated and fixed at start-of-day =
and never changed), or dynamic with hot-plug events, application or other f=
abric management configuring and freeing shared memory, perhaps opening and=
 closing windows to large NVMe memory space, or who knows what, it is below=
 ntb.ko that has to try to fulfill each ask, but it is above ntb,ko to mana=
ge the overall PCIe fabric presented by the Views on all the connected peer=
s.</div><div><br></div><div>The ramifications of this would be that ntb.h (=
by that I think you mean the upward-facing API for all ntb.ko clients) is t=
he View and Control abstraction, and it can hopefully stay thin, with the c=
ost being that ntb.c and the hardware plug-ins probably get &quot;fat&quot;=
 because they need to not just manage the Model, but pick up all the slack =
between the abstracted API and the hardware.</div><div><br></div><div>Am I =
even remotely close?</div><div><br></div><div>Also, regarding your portabil=
ity requirement. On one hand, it sounds like messages and scratchpads have =
distinct properties that make it advantageous to expose separately in ntb.h=
, and yet the portability requirement seems to want to abstract them as a s=
ingle interface. Can you offer up any further thoughts on this, please?</di=
v><div><br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;p=
adding-left: 1ex;">&gt; What do people think about how this technique scale=
s when there are more than two peers? Obviously
<br>
<br>That limitation was stated upfront with that driver submission. =C2=A0T=
he Switchtec driver only works with two nodes for now.
<br></blockquote><div><br></div><div>So this section of my email is where I=
 am really hoping to gain understanding...</div><div><br></div><div>I reali=
ze that the Switchtec driver has the two-peer limitation, and I apologize t=
hat I did not make it clear that the context here is my work to remove that=
 limitation (in increments). My current task is to move switchtec and ntb-h=
w-switchtec (by hook or by crook) to support up to four peers.=C2=A0</div><=
div><br></div><div>I can achieve this in a brute-force way, which I may hav=
e to do with the time allotted for the task, but my hope is to understand w=
hat I assume is a lot of good thought that went into the current design. By=
 gaining understanding, I may be able to choose a near-term approach which =
is not entirely throw-away code, while also having understanding to be care=
ful to retain parts of the design which you all have deemed essential (or a=
t least preferred). In addition, perhaps some thought had/has already been =
given to how the current design would be extended, and so this design was c=
hosen. I don&#39;t know, so I&#39;m asking.</div><div><br></div><div>This i=
s the only way I know to begin engaging on this. If there is a better or pr=
eferred approach, please let me know.</div><div><br></div><div>All of the f=
ollowing observations were my attempt to have folks give me some understand=
ing if this approach is necessary, sufficient, or something else, as well a=
s to see what thought has been given to scaling up the peers. I should have=
 been explicit (sorry). I&#39;m guessing y&#39;all have thought about where=
 you&#39;d like to see the design go and where you see issues.</div><div><b=
r></div><div>For now, I&#39;m likely to merely create an array of shared_mw=
 based on partition number and restrict the Switchtec configuration to use =
only the first four partitions. But if somebody says &quot;I was thinking t=
hat this would actually be best done as Y, and it&#39;s probably little mor=
e work than your near-term hack&quot; then I&#39;m sure going to listen!</d=
iv><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0;marg=
in-left: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;">&gt; LUTs ar=
e a precious resource, and a LUT per peer shared_mw is expensive. A LUT bro=
ken up into many
<br>&gt; shared_mw is a possibility, though there is always risk of trashin=
g stuff.
<br>&gt; Also, if the LUTs need to be much larger (for application use), th=
en a large chunk of the BAR space
<br>&gt; could be used for a relatively small structure.
<br>&gt; I&#39;d love to hear anyone&#39;s thoughts on this.
<br>&gt;=20
<br>&gt; As an aside, I&#39;m curious why the LUT size is 64 KiB? Was this =
just a nice number as a starting point?
<br>&gt;=20
<br>&gt; Thanks again, folks.
<br></blockquote><div><br></div><div>Thanks again (and again).</div><div><b=
r></div><div>Blessings,</div><div>Doug</div></div></div>
------=_Part_8275_876963349.1507650726288--

------=_Part_8274_1876139600.1507650726287--
