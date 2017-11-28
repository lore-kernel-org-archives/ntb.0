Date: Mon, 27 Nov 2017 16:14:50 -0800 (PST)
From: Karl Kao <karl.kao@gmail.com>
Message-Id: <0557295a-c60c-4aff-95ec-cb93296066ce@googlegroups.com>
In-Reply-To: <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_10391_667733538.1511828090361"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_10391_667733538.1511828090361
Content-Type: multipart/alternative; 
	boundary="----=_Part_10392_470989987.1511828090361"

------=_Part_10392_470989987.1511828090361
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Would Microsemi turn off the NTB pcie link once the hardware chip is being 
through a reset?
We can have the chip by default disable NTB link until hardware driver is 
loaded to make sure either reset or power cycle that the NTB link will be 
down.

On Monday, November 27, 2017 at 8:47:25 AM UTC-8, Logan Gunthorpe wrote:
>
>
>
> On 27/11/17 09:39 AM, Jon Mason wrote: 
> > It sounds like the link down/up isn't working properly.  Is the 
> > Microsemi NTB not able to detect a link down? 
>
> It can detect a link down, but the link doesn't actually go down in a 
> lot of cases. If the host is just soft rebooted after a crash, I don't 
> think the link will go down. 
>
> Logan 
>

------=_Part_10392_470989987.1511828090361
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Would Microsemi turn off the NTB pcie link once the hardwa=
re chip is being through a reset?<div>We can have the chip by default disab=
le NTB link until hardware driver is loaded to make sure either reset or po=
wer cycle that the NTB link will be down.<br><br>On Monday, November 27, 20=
17 at 8:47:25 AM UTC-8, Logan Gunthorpe wrote:<blockquote class=3D"gmail_qu=
ote" style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padd=
ing-left: 1ex;">
<br>
<br>On 27/11/17 09:39 AM, Jon Mason wrote:
<br>&gt; It sounds like the link down/up isn&#39;t working properly. =C2=A0=
Is the
<br>&gt; Microsemi NTB not able to detect a link down?
<br>
<br>It can detect a link down, but the link doesn&#39;t actually go down in=
 a=20
<br>lot of cases. If the host is just soft rebooted after a crash, I don&#3=
9;t=20
<br>think the link will go down.
<br>
<br>Logan
<br></blockquote></div></div>
------=_Part_10392_470989987.1511828090361--

------=_Part_10391_667733538.1511828090361--
