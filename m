Date: Tue, 10 Oct 2017 05:57:09 -0700 (PDT)
From: Doug Meyer <dmeyer@gigaio.com>
Message-Id: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
Subject: Is the Scratchpad Implementation Using a LUT Standard?
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_4347_473635242.1507640229217"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_4347_473635242.1507640229217
Content-Type: multipart/alternative; 
	boundary="----=_Part_4348_1661350510.1507640229218"

------=_Part_4348_1661350510.1507640229218
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Gents,

As I continue to gain understanding about the NTB code, I am wondering 
about the use and requirements surrounding scratchpads, at least as I see 
things in the Switchtec code.

In there, I see that a LUT (LUT0) is used, the size of the LUTs apparently 
being hard-coded to 64 KiB, for a shared memory window (struct shared_mw) 
which contains an array of 128 u32 for the scratchpad. Also, it appears 
that this is what is used both to determine link status and to pass memory 
address/size information between hosts (ports, peers). I apologize if I 
have that wrong. Please correct me.

The goal here is just to gain understanding... learn about required APIs vs 
philosophical decisions vs convenience, etc.

My questions are whether this is a fixture of the NTB architecture, or if 
this is a convenience to support something else (the latter being a 
requirement)?

In particular,

But most importantly, I'm wondering about struct shared_mw. Could the 
Switchtec message registers have been used?
What do people think about how this technique scales when there are more 
than two peers? Obviously LUTs are a precious resource, and a LUT per peer 
shared_mw is expensive. A LUT broken up into many shared_mw is a 
possibility, though there is always risk of trashing stuff.
Also, if the LUTs need to be much larger (for application use), then a 
large chunk of the BAR space could be used for a relatively small structure.
I'd love to hear anyone's thoughts on this.

As an aside, I'm curious why the LUT size is 64 KiB? Was this just a nice 
number as a starting point?

Thanks again, folks.

Blessings,
Doug

------=_Part_4348_1661350510.1507640229218
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Gents,<div><br></div><div>As I continue to gain understand=
ing about the NTB code, I am wondering about the use and requirements surro=
unding scratchpads, at least as I see things in the Switchtec code.</div><d=
iv><br></div><div>In there, I see that a LUT (LUT0) is used, the size of th=
e LUTs apparently being hard-coded to 64 KiB, for a shared memory window (s=
truct shared_mw) which contains an array of 128 u32 for the scratchpad. Als=
o, it appears that this is what is used both to determine link status and t=
o pass memory address/size information between hosts (ports, peers). I apol=
ogize if I have that wrong. Please correct me.</div><div><br></div><div>The=
 goal here is just to gain understanding... learn about required APIs vs ph=
ilosophical decisions vs convenience, etc.</div><div><br></div><div>My ques=
tions are whether this is a fixture of the NTB architecture, or if this is =
a convenience to support something else (the latter being a requirement)?</=
div><div><br></div><div>In particular,</div><div><br></div><div>But most im=
portantly, I&#39;m wondering about struct shared_mw. Could the Switchtec me=
ssage registers have been used?</div><div>What do people think about how th=
is technique scales when there are more than two peers? Obviously LUTs are =
a precious resource, and a LUT per peer shared_mw is expensive. A LUT broke=
n up into many shared_mw is a possibility, though there is always risk of t=
rashing stuff.</div><div>Also, if the LUTs need to be much larger (for appl=
ication use), then a large chunk of the BAR space could be used for a relat=
ively small structure.</div><div>I&#39;d love to hear anyone&#39;s thoughts=
 on this.</div><div><br></div><div><div>As an aside, I&#39;m curious why th=
e LUT size is 64 KiB? Was this just a nice number as a starting point?</div=
></div><div><br></div><div>Thanks again, folks.</div><div><br></div><div>Bl=
essings,</div><div>Doug</div></div>
------=_Part_4348_1661350510.1507640229218--

------=_Part_4347_473635242.1507640229217--
