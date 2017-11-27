Return-Path: <cruisethai@gmail.com>
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com. [2a00:1450:400c:c09::22c])
        by gmr-mx.google.com with ESMTPS id 191si182663wmq.0.2017.11.27.15.44.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 15:44:19 -0800 (PST)
Received: by mail-wm0-x22c.google.com with SMTP id y82so29854461wmg.1
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 15:44:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1a460ce1-f37e-a4b8-994d-1e20d9f8e19f@deltatee.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com> <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
 <e4c00ca2-3d74-5d88-1824-c517250d164f@deltatee.com> <CAPoiz9xvMQC7qJERUW2=mhED9=E6SLSR7g-7-SoLdkTywZhVZQ@mail.gmail.com>
 <CAJQW-Q4oji8=TW2sB_fyP7dZAsptWGzwOKK4vOth23CxcodB9w@mail.gmail.com> <1a460ce1-f37e-a4b8-994d-1e20d9f8e19f@deltatee.com>
From: ThanhTuThai <cruisethai@gmail.com>
Date: Tue, 28 Nov 2017 07:44:19 +0800
Message-ID: <CAJQW-Q5w0JGJ-TnoLw3pZ5MKj_LVsLxTBb_bPZ4LHFKdBQ+8Vg@mail.gmail.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
Content-Type: multipart/alternative; boundary="94eb2c197ec22b8a78055eff7b3d"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: jdmason@kudzu.us, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

--94eb2c197ec22b8a78055eff7b3d
Content-Type: text/plain; charset="UTF-8"

Ok, sounds good.

Thank Logan !

On Nov 28, 2017 7:35 AM, "Logan Gunthorpe" <logang@deltatee.com> wrote:

>
>
> On 27/11/17 04:33 PM, ThanhTuThai wrote:
>
>> No, it doesn't.
>>
>> I've also thought about this strategy, and implemented it in my setup.
>> For the soft-reboot, it works well, I can receive the link up event when
>> it complete rebooting.
>> But for power-on reset ( in this case, the switchtec is also power-reset
>> ), I don't receiver any message of linking-up. So the good peer cannot
>> reset link status as mention above. But if I reload the drivers on the good
>> peer, they work perfectly.
>>
>
> That's because it's filtering out the link up because it already thinks
> the link is up. Please wait until I send a patch and test that. It'll be in
> the next day or two.
>
> Thanks,
>
> Logan
>

--94eb2c197ec22b8a78055eff7b3d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Ok, sounds good.=C2=A0<div dir=3D"auto"><br></div><div di=
r=3D"auto">Thank Logan !</div></div><div class=3D"gmail_extra"><br><div cla=
ss=3D"gmail_quote">On Nov 28, 2017 7:35 AM, &quot;Logan Gunthorpe&quot; &lt=
;<a href=3D"mailto:logang@deltatee.com">logang@deltatee.com</a>&gt; wrote:<=
br type=3D"attribution"><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 27/11/17 04:33 PM, ThanhTuThai wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex">
No, it doesn&#39;t.<br>
<br>
I&#39;ve also thought about this strategy, and implemented it in my setup.<=
br>
For the soft-reboot, it works well, I can receive the link up event when it=
 complete rebooting.<br>
But for power-on reset ( in this case, the switchtec is also power-reset ),=
 I don&#39;t receiver any message of linking-up. So the good peer cannot re=
set link status as mention above. But if I reload the drivers on the good p=
eer, they work perfectly.<br>
</blockquote>
<br>
That&#39;s because it&#39;s filtering out the link up because it already th=
inks the link is up. Please wait until I send a patch and test that. It&#39=
;ll be in the next day or two.<br>
<br>
Thanks,<br>
<br>
Logan<br>
</blockquote></div></div>

--94eb2c197ec22b8a78055eff7b3d--
