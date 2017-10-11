Date: Wed, 11 Oct 2017 09:19:20 -0700 (PDT)
From: lsgunthorpe@gmail.com
Message-Id: <38ffd174-b66f-4077-8cdc-679e412242fc@googlegroups.com>
In-Reply-To: <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
References: <9aa73260-8b02-4e86-b7d4-9bc3afd745a6@googlegroups.com>
 <000001d341d2$87574f20$9605ed60$@dell.com>
 <6107eb07-3889-4f1a-ad50-264256772dae@googlegroups.com>
Subject: Re: Is the Scratchpad Implementation Using a LUT Standard?
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_9720_610386976.1507738760909"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_9720_610386976.1507738760909
Content-Type: multipart/alternative; 
	boundary="----=_Part_9721_1863236805.1507738760910"

------=_Part_9721_1863236805.1507738760910
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



> Obviously LUTs are a precious resource, and a LUT per peer shared_mw is 
> expensive. A LUT broken up into many shared_mw is a possibility, though 
> there is always risk of trashing stuff.


Well, as far as I know, switchtec is the only hardware with LUTs. But they 
aren't that precious a resource. If I remember correctly, switchtec 
supports up to 128 of them and up to 48 separate partitions so you could 
easily have 2 LUTs per peer and still have plenty left over to do other 
things with. And as far as we know now, there is no other use for LUT 
windows. Thus, I would say, using one per peer is perfectly acceptable.
 
On Tuesday, October 10, 2017 at 9:52:06 AM UTC-6, Doug Meyer wrote:
>
> Also, regarding your portability requirement. On one hand, it sounds like 
> messages and scratchpads have distinct properties that make it advantageous 
> to expose separately in ntb.h, and yet the portability requirement seems to 
> want to abstract them as a single interface. Can you offer up any further 
> thoughts on this, please?
>

Yes, scratchpads and messages are distinct enough that you can't shoe-horn 
messages into the scratchpad api (I tried this a long time ago). In the 
end, drivers will really just need some interface to say "transfer this 
information to peer X" and another interface for the peer to receive the 
data. I agree with Allen in that we need a library to accomplish this based 
on what the hardware provides through the NTB api. As it currently is 
there's a lot of duplication in ntb_transport and ntb_perf for this. 


> For now, I'm likely to merely create an array of shared_mw based on 
> partition number and restrict the Switchtec configuration to use only the 
> first four partitions. But if somebody says "I was thinking that this would 
> actually be best done as Y, and it's probably little more work than your 
> near-term hack" then I'm sure going to listen!
>

This was my long term plan too: create one shared_mw per peer. Though, I 
see no reason to restrict the implementation to 4 partitions. Creating an 
N-way mapping shouldn't be much harder than a 4-way mapping.

Thanks for your work on this,

Logan

------=_Part_9721_1863236805.1507738760910
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><blockquote class=3D"gmail_quote" style=3D"margin: 0px=
 0px 0px 0.8ex; border-left: 1px solid rgb(204, 204, 204); padding-left: 1e=
x;">Obviously LUTs are a precious resource, and a LUT per peer shared_mw is=
 expensive. A LUT broken up into many shared_mw is a possibility, though th=
ere is always risk of trashing stuff.</blockquote><div><br></div><div>Well,=
 as far as I know, switchtec is the only hardware with LUTs. But they aren&=
#39;t that precious a resource. If I remember correctly, switchtec supports=
 up to 128 of them and up to 48 separate partitions so you could easily hav=
e 2 LUTs per peer and still have plenty left over to do other things with. =
And as far as we know now, there is no other use for LUT windows. Thus, I w=
ould say, using one per peer is perfectly acceptable.</div><div>=C2=A0</div=
><div>On Tuesday, October 10, 2017 at 9:52:06 AM UTC-6, Doug Meyer wrote:<b=
lockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left: 0.8ex;borde=
r-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr"><div>Also, rega=
rding your portability requirement. On one hand, it sounds like messages an=
d scratchpads have distinct properties that make it advantageous to expose =
separately in ntb.h, and yet the portability requirement seems to want to a=
bstract them as a single interface. Can you offer up any further thoughts o=
n this, please?</div></div></blockquote><div><br></div><div>Yes, scratchpad=
s and messages are distinct enough that you can&#39;t shoe-horn messages in=
to the scratchpad api (I tried this a long time ago). In the end, drivers w=
ill really just need some interface to say &quot;transfer this information =
to peer X&quot; and another interface for the peer to receive the data. I a=
gree with Allen in that we need a library to accomplish this based on what =
the hardware provides through the NTB api. As it currently is there&#39;s a=
 lot of duplication in ntb_transport and ntb_perf for this.=C2=A0</div><div=
><br></div><blockquote class=3D"gmail_quote" style=3D"margin: 0;margin-left=
: 0.8ex;border-left: 1px #ccc solid;padding-left: 1ex;"><div dir=3D"ltr"><d=
iv><br></div><div>For now, I&#39;m likely to merely create an array of shar=
ed_mw based on partition number and restrict the Switchtec configuration to=
 use only the first four partitions. But if somebody says &quot;I was think=
ing that this would actually be best done as Y, and it&#39;s probably littl=
e more work than your near-term hack&quot; then I&#39;m sure going to liste=
n!</div></div></blockquote><div><br></div><div>This was my long term plan t=
oo: create one shared_mw per peer. Though, I see no reason to restrict the =
implementation to 4 partitions. Creating an N-way mapping shouldn&#39;t be =
much harder than a 4-way mapping.</div><div><br></div><div>Thanks for your =
work on this,</div></div><div><br></div><div>Logan</div></div>
------=_Part_9721_1863236805.1507738760910--

------=_Part_9720_610386976.1507738760909--
