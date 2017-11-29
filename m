Return-Path: <cruisethai@gmail.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com. [2a00:1450:400c:c09::233])
        by gmr-mx.google.com with ESMTPS id h45si46556eda.2.2017.11.28.22.57.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Nov 2017 22:57:44 -0800 (PST)
Received: by mail-wm0-x233.google.com with SMTP id g130so34914432wme.0
        for <linux-ntb@googlegroups.com>; Tue, 28 Nov 2017 22:57:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAJQW-Q5yGaS21iAjL3e4GULDu5jBH1pXmGHm=SXDN6GGG0jV2Q@mail.gmail.com>
References: <20171128220144.13294-1-logang@deltatee.com> <f30f393f-3efd-d720-154e-a54bbad89238@deltatee.com>
 <CAPoiz9zxTgMsRJpQ+fkdsrdREmAA0BcvQd6OJHsv6ErLUU_cSw@mail.gmail.com> <CAJQW-Q5yGaS21iAjL3e4GULDu5jBH1pXmGHm=SXDN6GGG0jV2Q@mail.gmail.com>
From: ThanhTuThai <cruisethai@gmail.com>
Date: Wed, 29 Nov 2017 14:57:43 +0800
Message-ID: <CAJQW-Q5a_Xk5SURf6v4hGnR3GGe6BH9r6h2LCUN6hpBnrRzK4Q@mail.gmail.com>
Subject: Re: [PATCH] ntb_hw_switchtec: Force down the peer's link before initializing
Content-Type: multipart/alternative; boundary="94eb2c197ec2015eca055f19a78a"
To: Jon Mason <jdmason@kudzu.us>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--94eb2c197ec2015eca055f19a78a
Content-Type: text/plain; charset="UTF-8"

The good peer didn't receive any message, the interrupt routine is not
asserted.

Thanks !

On 29 November 2017 at 13:28, ThanhTuThai <cruisethai@gmail.com> wrote:

> Dear Logan,
>
> It works only for soft-reboot, but for power-on reset, it doesn't.
> I saw the problem is: with the power-on reset, the good peer didn't
> receive any message from the crashed peer even the crashed peer already
> sent out the message.
>
> Do you think that after power-in reset, the memory-window is modified ?
> So it cannot translate the message from the crashed peer to the good peer.
>
> Thanks !
>
>
> On 29 November 2017 at 11:09, Jon Mason <jdmason@kudzu.us> wrote:
>
>> On Tue, Nov 28, 2017 at 5:05 PM, Logan Gunthorpe <logang@deltatee.com>
>> wrote:
>> > Hey Thai Thu,
>> >
>> > Please test with this patch and report back if it fixes your issue.
>>
>> I'll wait on the ack before applying this patch and I'll add the
>> "tested-by" line (assuming it works).
>>
>> Thanks,
>> Jon
>>
>> >
>> > If it doesn't, can you please send the dmesg output of the two hosts?
>> >
>> > Thanks,
>> >
>> > Logan
>> >
>> >
>> > On 28/11/17 03:01 PM, Logan Gunthorpe wrote:
>> >>
>> >> If one host crashes and soft reboots, the other host may not see a
>> >> link down event. Then when the crashed host comes back up, the
>> >> surviving host may not know the link was reset and the ntb clients
>> >> may not work without being reset.
>> >>
>> >> To solve this, we send a LINK_FORCE_DOWN message to each peer every
>> >> time we come up, before we register the ntb device. If a surving
>> >> host still thinks the link is up it will take it down immediately.
>> >> In this way, once the crashed host comes up fully, it will send a
>> >> regular link up event as per usual and the link will be properly
>> >> restarted.
>> >>
>> >> While we are in the area, this also fixes the MSG_LINK_UP message that
>> >> was in the link down function that was reported by Doug Meyers.
>> >>
>> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>> >> Reported-by: ThanhTuThai <cruisethai@gmail.com>
>> >> ---
>> >>   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 33
>> >> ++++++++++++++++++++++++++-------
>> >>   1 file changed, 26 insertions(+), 7 deletions(-)
>> >>
>> >> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >> index d71744904b19..5cfcd4deadaf 100644
>> >> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> >> @@ -463,18 +463,30 @@ static void switchtec_ntb_set_link_speed(struct
>> >> switchtec_ntb *sndev)
>> >>         sndev->link_width = min(self_width, peer_width);
>> >>   }
>> >>
>> >> -enum {
>> >> +enum switchtec_msg {
>> >>         LINK_MESSAGE = 0,
>> >>         MSG_LINK_UP = 1,
>> >>         MSG_LINK_DOWN = 2,
>> >>         MSG_CHECK_LINK = 3,
>> >> +       MSG_LINK_FORCE_DOWN = 4,
>> >>   };
>> >>
>> >> -static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
>> >> +static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
>> >> +                                    enum switchtec_msg msg)
>> >>   {
>> >>         int link_sta;
>> >>         int old = sndev->link_is_up;
>> >>
>> >> +       if (msg == MSG_LINK_FORCE_DOWN) {
>> >> +               if (sndev->link_is_up) {
>> >> +                       sndev->link_is_up = 0;
>> >> +                       ntb_link_event(&sndev->ntb);
>> >> +                       dev_info(&sndev->stdev->dev, "ntb link forced
>> >> down\n");
>> >> +               }
>> >> +
>> >> +               return;
>> >> +       }
>> >> +
>> >>         link_sta = sndev->self_shared->link_sta;
>> >>         if (link_sta) {
>> >>                 u64 peer = ioread64(&sndev->peer_shared->magic);
>> >> @@ -500,7 +512,7 @@ static void switchtec_ntb_link_notification(struct
>> >> switchtec_dev *stdev)
>> >>   {
>> >>         struct switchtec_ntb *sndev = stdev->sndev;
>> >>
>> >> -       switchtec_ntb_check_link(sndev);
>> >> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>> >>   }
>> >>
>> >>   static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
>> >> @@ -528,7 +540,7 @@ static int switchtec_ntb_link_enable(struct
>> ntb_dev
>> >> *ntb,
>> >>         sndev->self_shared->link_sta = 1;
>> >>         switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
>> >>
>> >> -       switchtec_ntb_check_link(sndev);
>> >> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>> >>
>> >>         return 0;
>> >>   }
>> >> @@ -540,9 +552,9 @@ static int switchtec_ntb_link_disable(struct
>> ntb_dev
>> >> *ntb)
>> >>         dev_dbg(&sndev->stdev->dev, "disabling link\n");
>> >>
>> >>         sndev->self_shared->link_sta = 0;
>> >> -       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
>> >> +       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_DOWN);
>> >>
>> >> -       switchtec_ntb_check_link(sndev);
>> >> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>> >>
>> >>         return 0;
>> >>   }
>> >> @@ -1061,7 +1073,7 @@ static irqreturn_t switchtec_ntb_message_isr(int
>> >> irq, void *dev)
>> >>                         iowrite8(1,
>> >> &sndev->mmio_self_dbmsg->imsg[i].status);
>> >>
>> >>                         if (i == LINK_MESSAGE)
>> >> -                               switchtec_ntb_check_link(sndev);
>> >> +                               switchtec_ntb_check_link(sndev, msg);
>> >>                 }
>> >>         }
>> >>
>> >> @@ -1159,6 +1171,13 @@ static int switchtec_ntb_add(struct device *dev,
>> >>         if (rc)
>> >>                 goto deinit_shared_and_exit;
>> >>
>> >> +       /*
>> >> +        * If this host crashed, the other host may think the link is
>> >> +        * still up. Tell them to force it down (it will go back up
>> >> +        * once we register the ntb device).
>> >> +        */
>> >> +       switchtec_ntb_send_msg(sndev, LINK_MESSAGE,
>> MSG_LINK_FORCE_DOWN);
>> >> +
>> >>         rc = ntb_register_device(&sndev->ntb);
>> >>         if (rc)
>> >>                 goto deinit_and_exit;
>> >> --
>> >> 2.11.0
>> >>
>> >
>>
>
>

--94eb2c197ec2015eca055f19a78a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">The good peer didn&#39;t receive any message, the interrup=
t routine is not asserted.<div><br></div><div>Thanks !</div></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On 29 November 2017 at 13:=
28, ThanhTuThai <span dir=3D"ltr">&lt;<a href=3D"mailto:cruisethai@gmail.co=
m" target=3D"_blank">cruisethai@gmail.com</a>&gt;</span> wrote:<br><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc s=
olid;padding-left:1ex"><div dir=3D"ltr">Dear Logan,<div><br></div><div>It w=
orks only for soft-reboot, but for power-on reset, it doesn&#39;t.</div><di=
v>I saw the problem is: with the power-on reset, the good peer didn&#39;t r=
eceive any message from the crashed peer even the crashed peer already sent=
 out the message.</div><div><br></div><div>Do you think that after power-in=
 reset, the memory-window is modified ?</div><div>So it cannot translate th=
e message from the crashed peer to the good peer.</div><div><br></div><div>=
Thanks !</div><div><br></div></div><div class=3D"HOEnZb"><div class=3D"h5">=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On 29 November 20=
17 at 11:09, Jon Mason <span dir=3D"ltr">&lt;<a href=3D"mailto:jdmason@kudz=
u.us" target=3D"_blank">jdmason@kudzu.us</a>&gt;</span> wrote:<br><blockquo=
te class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc so=
lid;padding-left:1ex"><span>On Tue, Nov 28, 2017 at 5:05 PM, Logan Gunthorp=
e &lt;<a href=3D"mailto:logang@deltatee.com" target=3D"_blank">logang@delta=
tee.com</a>&gt; wrote:<br>
&gt; Hey Thai Thu,<br>
&gt;<br>
&gt; Please test with this patch and report back if it fixes your issue.<br=
>
<br>
</span>I&#39;ll wait on the ack before applying this patch and I&#39;ll add=
 the<br>
&quot;tested-by&quot; line (assuming it works).<br>
<br>
Thanks,<br>
Jon<br>
<div class=3D"m_-8369982989466025419HOEnZb"><div class=3D"m_-83699829894660=
25419h5"><br>
&gt;<br>
&gt; If it doesn&#39;t, can you please send the dmesg output of the two hos=
ts?<br>
&gt;<br>
&gt; Thanks,<br>
&gt;<br>
&gt; Logan<br>
&gt;<br>
&gt;<br>
&gt; On 28/11/17 03:01 PM, Logan Gunthorpe wrote:<br>
&gt;&gt;<br>
&gt;&gt; If one host crashes and soft reboots, the other host may not see a=
<br>
&gt;&gt; link down event. Then when the crashed host comes back up, the<br>
&gt;&gt; surviving host may not know the link was reset and the ntb clients=
<br>
&gt;&gt; may not work without being reset.<br>
&gt;&gt;<br>
&gt;&gt; To solve this, we send a LINK_FORCE_DOWN message to each peer ever=
y<br>
&gt;&gt; time we come up, before we register the ntb device. If a surving<b=
r>
&gt;&gt; host still thinks the link is up it will take it down immediately.=
<br>
&gt;&gt; In this way, once the crashed host comes up fully, it will send a<=
br>
&gt;&gt; regular link up event as per usual and the link will be properly<b=
r>
&gt;&gt; restarted.<br>
&gt;&gt;<br>
&gt;&gt; While we are in the area, this also fixes the MSG_LINK_UP message =
that<br>
&gt;&gt; was in the link down function that was reported by Doug Meyers.<br=
>
&gt;&gt;<br>
&gt;&gt; Signed-off-by: Logan Gunthorpe &lt;<a href=3D"mailto:logang@deltat=
ee.com" target=3D"_blank">logang@deltatee.com</a>&gt;<br>
&gt;&gt; Reported-by: ThanhTuThai &lt;<a href=3D"mailto:cruisethai@gmail.co=
m" target=3D"_blank">cruisethai@gmail.com</a>&gt;<br>
&gt;&gt; ---<br>
&gt;&gt;=C2=A0 =C2=A0drivers/ntb/hw/mscc/ntb_hw_sw<wbr>itchtec.c | 33<br>
&gt;&gt; ++++++++++++++++++++++++++----<wbr>---<br>
&gt;&gt;=C2=A0 =C2=A01 file changed, 26 insertions(+), 7 deletions(-)<br>
&gt;&gt;<br>
&gt;&gt; diff --git a/drivers/ntb/hw/mscc/ntb_hw_s<wbr>witchtec.c<br>
&gt;&gt; b/drivers/ntb/hw/mscc/ntb_hw_s<wbr>witchtec.c<br>
&gt;&gt; index d71744904b19..5cfcd4deadaf 100644<br>
&gt;&gt; --- a/drivers/ntb/hw/mscc/ntb_hw_s<wbr>witchtec.c<br>
&gt;&gt; +++ b/drivers/ntb/hw/mscc/ntb_hw_s<wbr>witchtec.c<br>
&gt;&gt; @@ -463,18 +463,30 @@ static void switchtec_ntb_set_link_speed(s<w=
br>truct<br>
&gt;&gt; switchtec_ntb *sndev)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sndev-&gt;link_width =3D min(self=
_width, peer_width);<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; -enum {<br>
&gt;&gt; +enum switchtec_msg {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0LINK_MESSAGE =3D 0,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MSG_LINK_UP =3D 1,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MSG_LINK_DOWN =3D 2,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0MSG_CHECK_LINK =3D 3,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0MSG_LINK_FORCE_DOWN =3D 4,<br>
&gt;&gt;=C2=A0 =C2=A0};<br>
&gt;&gt;<br>
&gt;&gt; -static void switchtec_ntb_check_link(struc<wbr>t switchtec_ntb *s=
ndev)<br>
&gt;&gt; +static void switchtec_ntb_check_link(struc<wbr>t switchtec_ntb *s=
ndev,<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum switcht=
ec_msg msg)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int link_sta;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int old =3D sndev-&gt;link_is_up;=
<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0if (msg =3D=3D MSG_LINK_FORCE_DOWN) {<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sndev-=
&gt;link_is_up) {<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0sndev-&gt;link_is_up =3D 0;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ntb_link_event(&amp;sndev-&gt;ntb);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0dev_info(&amp;sndev-&gt;stdev-&gt;dev, &quot;ntb link f=
orced<br>
&gt;&gt; down\n&quot;);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br=
>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0link_sta =3D sndev-&gt;self_share=
d-&gt;link_sta;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (link_sta) {<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0u64 p=
eer =3D ioread64(&amp;sndev-&gt;peer_shared-&gt;<wbr>magic);<br>
&gt;&gt; @@ -500,7 +512,7 @@ static void switchtec_ntb_link_notificatio<wbr=
>n(struct<br>
&gt;&gt; switchtec_dev *stdev)<br>
&gt;&gt;=C2=A0 =C2=A0{<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct switchtec_ntb *sndev =3D s=
tdev-&gt;sndev;<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(snde<wbr>v);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(snde<wbr>v, M=
SG_CHECK_LINK);<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0static u64 switchtec_ntb_link_is_up(struc<wbr>t ntb_de=
v *ntb,<br>
&gt;&gt; @@ -528,7 +540,7 @@ static int switchtec_ntb_link_enable(stru<wbr>=
ct ntb_dev<br>
&gt;&gt; *ntb,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sndev-&gt;self_shared-&gt;link_st=
a =3D 1;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LIN=
K_MESSAGE, MSG_LINK_UP);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(snde<wbr>v);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(snde<wbr>v, M=
SG_CHECK_LINK);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt; @@ -540,9 +552,9 @@ static int switchtec_ntb_link_disable(str<wbr>=
uct ntb_dev<br>
&gt;&gt; *ntb)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_dbg(&amp;sndev-&gt;stdev-&gt;=
dev, &quot;disabling link\n&quot;);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0sndev-&gt;self_shared-&gt;link_st=
a =3D 0;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LINK_MES=
SAGE, MSG_LINK_UP);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LINK_MES=
SAGE, MSG_LINK_DOWN);<br>
&gt;&gt;<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(snde<wbr>v);<=
br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(snde<wbr>v, M=
SG_CHECK_LINK);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 0;<br>
&gt;&gt;=C2=A0 =C2=A0}<br>
&gt;&gt; @@ -1061,7 +1073,7 @@ static irqreturn_t switchtec_ntb_message_isr=
(int<br>
&gt;&gt; irq, void *dev)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0iowrite8(1,<br>
&gt;&gt; &amp;sndev-&gt;mmio_self_dbmsg-&gt;imsg[<wbr>i].status);<br>
&gt;&gt;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (i =3D=3D LINK_MESSAGE)<br>
&gt;&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(sn=
de<wbr>v);<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(sn=
de<wbr>v, msg);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;&gt;<br>
&gt;&gt; @@ -1159,6 +1171,13 @@ static int switchtec_ntb_add(struct device =
*dev,<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
deinit_shared_and_exit;<br>
&gt;&gt;<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If this host crashed, the other hos=
t may think the link is<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * still up. Tell them to force it dow=
n (it will go back up<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 * once we register the ntb device).<b=
r>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
&gt;&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LINK_MES=
SAGE, MSG_LINK_FORCE_DOWN);<br>
&gt;&gt; +<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rc =3D ntb_register_device(&amp;s=
ndev-&gt;nt<wbr>b);<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (rc)<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto =
deinit_and_exit;<br>
&gt;&gt; --<br>
&gt;&gt; 2.11.0<br>
&gt;&gt;<br>
&gt;<br>
</div></div></blockquote></div><br></div>
</div></div></blockquote></div><br></div>

--94eb2c197ec2015eca055f19a78a--
