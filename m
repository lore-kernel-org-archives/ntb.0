Return-Path: <cruisethai@gmail.com>
Received: from mail-wm0-x22f.google.com (mail-wm0-x22f.google.com. [2a00:1450:400c:c09::22f])
        by gmr-mx.google.com with ESMTPS id b123si218790wmf.1.2017.12.04.17.47.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2017 17:47:29 -0800 (PST)
Received: by mail-wm0-x22f.google.com with SMTP id g130so17010463wme.0
        for <linux-ntb@googlegroups.com>; Mon, 04 Dec 2017 17:47:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171204175721.10322-1-logang@deltatee.com>
References: <20171204175721.10322-1-logang@deltatee.com>
From: ThanhTuThai <cruisethai@gmail.com>
Date: Tue, 5 Dec 2017 09:47:28 +0800
Message-ID: <CAJQW-Q6DXi4ipyc_cKfa=HYAqcu1sstJXU1mJmqvWH1c1aGePA@mail.gmail.com>
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before initializing
Content-Type: multipart/alternative; boundary="94eb2c0d99de86259e055f8e040e"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

--94eb2c0d99de86259e055f8e040e
Content-Type: text/plain; charset="UTF-8"

Dear Logan,

The problem is that the good host even didn't receive any message when the
crashed peer come up, so your  "re-init scheduled work" will not be
activated.
Because the good peer didn't receive any interrupt to activate the
scheduled work.

Thank you !

On 5 December 2017 at 01:57, Logan Gunthorpe <logang@deltatee.com> wrote:

> If one host crashes and soft reboots, the other host may not see a
> link down event. Then when the crashed host comes back up, the
> surviving host may not know the link was reset and the NTB clients
> may not work without being reset.
>
> To solve this, we send a LINK_FORCE_DOWN message to each peer every
> time we come up, before we register the NTB device. If a surviving
> host still thinks the link is up it will take it down immediately.
> In this way, once the crashed host comes up fully, it will send a
> regular link up event as per usual and the link will be properly
> restarted.
>
> While we are in the area, this also fixes the MSG_LINK_UP message that
> was in the link down function that was reported by Doug Meyers.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reported-by: ThanhTuThai <cruisethai@gmail.com>
> ---
>
> I had a small epiphany over the weekend as to why the link still was
> not coming up after a hard reboot. I think this will fix it.
>
> @Thai Thu: Can you please retest?
>
> Changes in v2:
>  * Reinitialize the shared memory window on a forced link down
>
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 57
> +++++++++++++++++++++++++++++-----
>  1 file changed, 50 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 709f37fbe232..6bc213cf7bf6 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -118,6 +118,7 @@ struct switchtec_ntb {
>         bool link_is_up;
>         enum ntb_speed link_speed;
>         enum ntb_width link_width;
> +       struct work_struct link_reinit_work;
>  };
>
>  static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)
> @@ -463,18 +464,43 @@ static void switchtec_ntb_set_link_speed(struct
> switchtec_ntb *sndev)
>         sndev->link_width = min(self_width, peer_width);
>  }
>
> -enum {
> +enum switchtec_msg {
>         LINK_MESSAGE = 0,
>         MSG_LINK_UP = 1,
>         MSG_LINK_DOWN = 2,
>         MSG_CHECK_LINK = 3,
> +       MSG_LINK_FORCE_DOWN = 4,
>  };
>
> -static void switchtec_ntb_check_link(struct switchtec_ntb *sndev)
> +static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev);
> +
> +static void link_reinit_work(struct work_struct *work)
> +{
> +       struct switchtec_ntb *sndev;
> +
> +       sndev = container_of(work, struct switchtec_ntb, link_reinit_work);
> +
> +       switchtec_ntb_reinit_peer(sndev);
> +}
> +
> +static void switchtec_ntb_check_link(struct switchtec_ntb *sndev,
> +                                    enum switchtec_msg msg)
>  {
>         int link_sta;
>         int old = sndev->link_is_up;
>
> +       if (msg == MSG_LINK_FORCE_DOWN) {
> +               schedule_work(&sndev->link_reinit_work);
> +
> +               if (sndev->link_is_up) {
> +                       sndev->link_is_up = 0;
> +                       ntb_link_event(&sndev->ntb);
> +                       dev_info(&sndev->stdev->dev, "ntb link forced
> down\n");
> +               }
> +
> +               return;
> +       }
> +
>         link_sta = sndev->self_shared->link_sta;
>         if (link_sta) {
>                 u64 peer = ioread64(&sndev->peer_shared->magic);
> @@ -500,7 +526,7 @@ static void switchtec_ntb_link_notification(struct
> switchtec_dev *stdev)
>  {
>         struct switchtec_ntb *sndev = stdev->sndev;
>
> -       switchtec_ntb_check_link(sndev);
> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>  }
>
>  static u64 switchtec_ntb_link_is_up(struct ntb_dev *ntb,
> @@ -528,7 +554,7 @@ static int switchtec_ntb_link_enable(struct ntb_dev
> *ntb,
>         sndev->self_shared->link_sta = 1;
>         switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
>
> -       switchtec_ntb_check_link(sndev);
> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>
>         return 0;
>  }
> @@ -540,9 +566,9 @@ static int switchtec_ntb_link_disable(struct ntb_dev
> *ntb)
>         dev_dbg(&sndev->stdev->dev, "disabling link\n");
>
>         sndev->self_shared->link_sta = 0;
> -       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_UP);
> +       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_DOWN);
>
> -       switchtec_ntb_check_link(sndev);
> +       switchtec_ntb_check_link(sndev, MSG_CHECK_LINK);
>
>         return 0;
>  }
> @@ -785,6 +811,8 @@ static void switchtec_ntb_init_sndev(struct
> switchtec_ntb *sndev)
>         sndev->ntb.topo = NTB_TOPO_SWITCH;
>         sndev->ntb.ops = &switchtec_ntb_ops;
>
> +       INIT_WORK(&sndev->link_reinit_work, link_reinit_work);
> +
>         sndev->self_partition = sndev->stdev->partition;
>
>         sndev->mmio_ntb = sndev->stdev->mmio_ntb;
> @@ -1062,7 +1090,7 @@ static irqreturn_t switchtec_ntb_message_isr(int
> irq, void *dev)
>                         iowrite8(1, &sndev->mmio_self_dbmsg->imsg[
> i].status);
>
>                         if (i == LINK_MESSAGE)
> -                               switchtec_ntb_check_link(sndev);
> +                               switchtec_ntb_check_link(sndev, msg);
>                 }
>         }
>
> @@ -1123,6 +1151,14 @@ static void switchtec_ntb_deinit_db_msg_irq(struct
> switchtec_ntb *sndev)
>         free_irq(sndev->message_irq, sndev);
>  }
>
> +static int switchtec_ntb_reinit_peer(struct switchtec_ntb *sndev)
> +{
> +       dev_info(&sndev->stdev->dev, "peer reinitialized\n");
> +       switchtec_ntb_deinit_shared_mw(sndev);
> +       switchtec_ntb_init_mw(sndev);
> +       return switchtec_ntb_init_shared_mw(sndev);
> +}
> +
>  static int switchtec_ntb_add(struct device *dev,
>                              struct class_interface *class_intf)
>  {
> @@ -1160,6 +1196,13 @@ static int switchtec_ntb_add(struct device *dev,
>         if (rc)
>                 goto deinit_shared_and_exit;
>
> +       /*
> +        * If this host crashed, the other host may think the link is
> +        * still up. Tell them to force it down (it will go back up
> +        * once we register the ntb device).
> +        */
> +       switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG_LINK_FORCE_DOWN);
> +
>         rc = ntb_register_device(&sndev->ntb);
>         if (rc)
>                 goto deinit_and_exit;
> --
> 2.11.0
>

--94eb2c0d99de86259e055f8e040e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Dear Logan,<div><br></div><div>The problem is that the goo=
d host even didn&#39;t receive any message when the crashed peer come up, s=
o your=C2=A0 &quot;re-init scheduled work&quot; will not be activated.</div=
><div>Because the good peer didn&#39;t receive any interrupt to activate th=
e scheduled work.</div><div><br></div><div>Thank you !</div></div><div clas=
s=3D"gmail_extra"><br><div class=3D"gmail_quote">On 5 December 2017 at 01:5=
7, Logan Gunthorpe <span dir=3D"ltr">&lt;<a href=3D"mailto:logang@deltatee.=
com" target=3D"_blank">logang@deltatee.com</a>&gt;</span> wrote:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">If one host crashes and soft reboots, the other hos=
t may not see a<br>
link down event. Then when the crashed host comes back up, the<br>
surviving host may not know the link was reset and the NTB clients<br>
may not work without being reset.<br>
<br>
To solve this, we send a LINK_FORCE_DOWN message to each peer every<br>
time we come up, before we register the NTB device. If a surviving<br>
host still thinks the link is up it will take it down immediately.<br>
In this way, once the crashed host comes up fully, it will send a<br>
regular link up event as per usual and the link will be properly<br>
restarted.<br>
<br>
While we are in the area, this also fixes the MSG_LINK_UP message that<br>
was in the link down function that was reported by Doug Meyers.<br>
<br>
Signed-off-by: Logan Gunthorpe &lt;<a href=3D"mailto:logang@deltatee.com">l=
ogang@deltatee.com</a>&gt;<br>
Reported-by: ThanhTuThai &lt;<a href=3D"mailto:cruisethai@gmail.com">cruise=
thai@gmail.com</a>&gt;<br>
---<br>
<br>
I had a small epiphany over the weekend as to why the link still was<br>
not coming up after a hard reboot. I think this will fix it.<br>
<br>
@Thai Thu: Can you please retest?<br>
<br>
Changes in v2:<br>
=C2=A0* Reinitialize the shared memory window on a forced link down<br>
<br>
=C2=A0drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c | 57 ++++++++++++++++++++=
+++++++++-<wbr>----<br>
=C2=A01 file changed, 50 insertions(+), 7 deletions(-)<br>
<br>
diff --git a/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c b/drivers/ntb/hw/m=
scc/ntb_hw_<wbr>switchtec.c<br>
index 709f37fbe232..6bc213cf7bf6 100644<br>
--- a/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c<br>
+++ b/drivers/ntb/hw/mscc/ntb_hw_<wbr>switchtec.c<br>
@@ -118,6 +118,7 @@ struct switchtec_ntb {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 bool link_is_up;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum ntb_speed link_speed;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 enum ntb_width link_width;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct work_struct link_reinit_work;<br>
=C2=A0};<br>
<br>
=C2=A0static struct switchtec_ntb *ntb_sndev(struct ntb_dev *ntb)<br>
@@ -463,18 +464,43 @@ static void switchtec_ntb_set_link_speed(<wbr>struct =
switchtec_ntb *sndev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;link_width =3D min(self_width, peer_w=
idth);<br>
=C2=A0}<br>
<br>
-enum {<br>
+enum switchtec_msg {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 LINK_MESSAGE =3D 0,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG_LINK_UP =3D 1,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG_LINK_DOWN =3D 2,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 MSG_CHECK_LINK =3D 3,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0MSG_LINK_FORCE_DOWN =3D 4,<br>
=C2=A0};<br>
<br>
-static void switchtec_ntb_check_link(<wbr>struct switchtec_ntb *sndev)<br>
+static int switchtec_ntb_reinit_peer(<wbr>struct switchtec_ntb *sndev);<br=
>
+<br>
+static void link_reinit_work(struct work_struct *work)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct switchtec_ntb *sndev;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0sndev =3D container_of(work, struct switchtec_n=
tb, link_reinit_work);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_reinit_peer(<wbr>sndev);<br>
+}<br>
+<br>
+static void switchtec_ntb_check_link(<wbr>struct switchtec_ntb *sndev,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 enum switchtec_msg msg=
)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int link_sta;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int old =3D sndev-&gt;link_is_up;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (msg =3D=3D MSG_LINK_FORCE_DOWN) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0schedule_work(&amp;=
sndev-&gt;link_<wbr>reinit_work);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (sndev-&gt;link_=
is_up) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0sndev-&gt;link_is_up =3D 0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0ntb_link_event(&amp;sndev-&gt;ntb);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0dev_info(&amp;sndev-&gt;stdev-&gt;dev, &quot;ntb link forced down=
\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 link_sta =3D sndev-&gt;self_shared-&gt;link_sta=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (link_sta) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 u64 peer =3D ioread=
64(&amp;sndev-&gt;peer_shared-&gt;<wbr>magic);<br>
@@ -500,7 +526,7 @@ static void switchtec_ntb_link_<wbr>notification(struct=
 switchtec_dev *stdev)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 struct switchtec_ntb *sndev =3D stdev-&gt;sndev=
;<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev, MSG_CHECK_=
LINK);<br>
=C2=A0}<br>
<br>
=C2=A0static u64 switchtec_ntb_link_is_up(<wbr>struct ntb_dev *ntb,<br>
@@ -528,7 +554,7 @@ static int switchtec_ntb_link_enable(<wbr>struct ntb_de=
v *ntb,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;self_shared-&gt;link_sta =3D 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG=
_LINK_UP);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev, MSG_CHECK_=
LINK);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -540,9 +566,9 @@ static int switchtec_ntb_link_disable(<wbr>struct ntb_d=
ev *ntb)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 dev_dbg(&amp;sndev-&gt;stdev-&gt;dev, &quot;dis=
abling link\n&quot;);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;self_shared-&gt;link_sta =3D 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG=
_LINK_UP);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG=
_LINK_DOWN);<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev, MSG_CHECK_=
LINK);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;<br>
=C2=A0}<br>
@@ -785,6 +811,8 @@ static void switchtec_ntb_init_sndev(<wbr>struct switch=
tec_ntb *sndev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;ntb.topo =3D NTB_TOPO_SWITCH;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;ntb.ops =3D &amp;switchtec_ntb_ops;<b=
r>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0INIT_WORK(&amp;sndev-&gt;link_reinit_<wbr>work,=
 link_reinit_work);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;self_partition =3D sndev-&gt;stdev-&g=
t;partition;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sndev-&gt;mmio_ntb =3D sndev-&gt;stdev-&gt;mmio=
_ntb;<br>
@@ -1062,7 +1090,7 @@ static irqreturn_t switchtec_ntb_message_isr(int irq,=
 void *dev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 iowrite8(1, &amp;sndev-&gt;mmio_self_dbmsg-&gt;imsg[<wbr>i].stat=
us);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 if (i =3D=3D LINK_MESSAGE)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev);=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_check_link(<wbr>sndev, =
msg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
@@ -1123,6 +1151,14 @@ static void switchtec_ntb_deinit_db_msg_<wbr>irq(str=
uct switchtec_ntb *sndev)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 free_irq(sndev-&gt;message_irq, sndev);<br>
=C2=A0}<br>
<br>
+static int switchtec_ntb_reinit_peer(<wbr>struct switchtec_ntb *sndev)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dev_info(&amp;sndev-&gt;stdev-&gt;dev, &quot;pe=
er reinitialized\n&quot;);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_deinit_shared_<wbr>mw(sndev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_init_mw(sndev);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return switchtec_ntb_init_shared_mw(<wbr>sndev)=
;<br>
+}<br>
+<br>
=C2=A0static int switchtec_ntb_add(struct device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct class_interface *class_intf)<br>
=C2=A0{<br>
@@ -1160,6 +1196,13 @@ static int switchtec_ntb_add(struct device *dev,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto deinit_shared_=
and_exit;<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * If this host crashed, the other host may thi=
nk the link is<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * still up. Tell them to force it down (it wil=
l go back up<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * once we register the ntb device).<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switchtec_ntb_send_msg(sndev, LINK_MESSAGE, MSG=
_LINK_FORCE_DOWN);<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 rc =3D ntb_register_device(&amp;sndev-&gt;<wbr>=
ntb);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (rc)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto deinit_and_exi=
t;<br>
--<br>
2.11.0<br>
</blockquote></div><br></div>

--94eb2c0d99de86259e055f8e040e--
