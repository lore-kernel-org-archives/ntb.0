Date: Tue, 3 Oct 2017 15:04:14 -0700 (PDT)
From: Doug Meyer <dmeyer@gigaio.com>
Message-Id: <9eef52f7-fdd2-4f9f-a5d9-9c607d406079@googlegroups.com>
Subject: GigaIO starting work on Switchtec NTB-based PCI Express fabric
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_7294_415605769.1507068254914"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_7294_415605769.1507068254914
Content-Type: multipart/alternative; 
	boundary="----=_Part_7295_52298597.1507068254914"

------=_Part_7295_52298597.1507068254914
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On the recommendation of Logan Gunthorpe, this new topic is to let the NTB 
community know that GigaIO Networks has kicked off work to use and expand 
the existing work on the Switchtec and NTB modules.

GigaIO currently has a small team of software engineers that are just 
getting started. For this topic, the key folks are:
Scott Taylor: Fearless director, as well as technical lead for some areas.
Eric Pilmore: Working on DMA/NTRDMA functionality and performance right 
now, and will likely work on various parts of the NTB plumbing a bit later.
Doug Meyer: Working on the stack from switchtec up through ntb_transport.

We've got a couple bench setups, each using some little Intel ITX machines 
(plus other devices) connected through a Switchtec PFX 96xG3. We're running 
4.13 along with the very current switchtec/NTB code off of github. 

In terms of GigaIO's goals, the first goals surrounding NTB are:

   - near-term: "extend" (aka hack?) the existing module stack to support 
   four hosts being able to run ntb_perf and ntb_netdev (not necessarily at 
   the same time).
   - mid-term: move the modules to support an (nearly) arbitrary number of 
   hosts/devices on a single Switchtec device
   - longer-term: support a generalized model that supports cascaded 
   switches

The three of us are excited about joining the community and collaborating. 
We're working through (stumbling up) the learning curves, and recognize 
that you folks are the experts. I've no doubt we'll need help, both in 
understanding the code, APIs, and current plans, but also in how we should 
present our proposals, go through code reviews, and complete the 
test/integration process.

We're sure that you folks are far down the road compared to us, and we'll 
do our best to catch up and contribute substantially. Having said that, we 
also expect that you already have thoughts and plans where various pieces 
should go, and we don't want to step on toes or just "do our own thing" 
because we're oblivious. So, thank you ahead of time for all the help and 
insight you can give, and we'll try to be careful to thank you along the 
way too.

Thanks to Logan, Dave, Allen, and Jon for already sending their welcomes, 
providing some initial help, and encouraging us to engaged here. I 
appreciate it, guys!

Blessings,
Doug

------=_Part_7295_52298597.1507068254914
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">On the recommendation of Logan Gunthorpe, this new topic i=
s to let the NTB community know that GigaIO Networks has kicked off work to=
 use and expand the existing work on the Switchtec and NTB modules.<div><br=
></div><div>GigaIO currently has a small team of software engineers that ar=
e just getting started. For this topic, the key folks are:</div><div>Scott =
Taylor: Fearless director, as well as technical lead for some areas.</div><=
div>Eric Pilmore: Working on DMA/NTRDMA functionality and performance right=
 now, and will likely work on various parts of the NTB plumbing a bit later=
.</div><div>Doug Meyer: Working on the stack from switchtec up through ntb_=
transport.</div><div><br></div><div>We&#39;ve got a couple bench setups, ea=
ch using some little Intel ITX machines (plus other devices) connected thro=
ugh a Switchtec PFX 96xG3. We&#39;re running 4.13 along with the very curre=
nt switchtec/NTB code off of github.=C2=A0</div><div><br></div><div>In term=
s of GigaIO&#39;s goals, the first goals surrounding NTB are:</div><div><ul=
><li>near-term: &quot;extend&quot; (aka hack?) the existing module stack to=
 support four hosts being able to run ntb_perf and ntb_netdev (not necessar=
ily at the same time).</li><li>mid-term: move the modules to support an (ne=
arly) arbitrary number of hosts/devices on a single Switchtec device</li><l=
i>longer-term: support a generalized model that supports cascaded switches<=
/li></ul><div>The three of us are excited about joining the community and c=
ollaborating. We&#39;re working through (stumbling up) the learning curves,=
 and recognize that you folks are the experts. I&#39;ve no doubt we&#39;ll =
need help, both in understanding the code, APIs, and current plans, but als=
o in how we should present our proposals, go through code reviews, and comp=
lete the test/integration process.</div></div><div><br></div><div>We&#39;re=
 sure that you folks are far down the road compared to us, and we&#39;ll do=
 our best to catch up and contribute substantially. Having said that, we al=
so expect that you already have thoughts and plans where various pieces sho=
uld go, and we don&#39;t want to step on toes or just &quot;do our own thin=
g&quot; because we&#39;re oblivious. So, thank you ahead of time for all th=
e help and insight you can give, and we&#39;ll try to be careful to thank y=
ou along the way too.</div><div><br></div><div>Thanks to Logan, Dave, Allen=
, and Jon for already sending their welcomes, providing some initial help, =
and encouraging us to engaged here. I appreciate it, guys!</div><div><br></=
div><div>Blessings,</div><div>Doug</div></div>
------=_Part_7295_52298597.1507068254914--

------=_Part_7294_415605769.1507068254914--
