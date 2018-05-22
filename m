Return-Path: <dmeyer@gigaio.com>
Received: from mail-ua0-x22e.google.com (mail-ua0-x22e.google.com. [2607:f8b0:400c:c08::22e])
        by gmr-mx.google.com with ESMTPS id x3-v6si1368920ybp.5.2018.05.22.14.02.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 May 2018 14:02:15 -0700 (PDT)
Received: by mail-ua0-x22e.google.com with SMTP id f22-v6so13295901uam.1
        for <linux-ntb@googlegroups.com>; Tue, 22 May 2018 14:02:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com> <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
From: Doug Meyer <dmeyer@gigaio.com>
Date: Tue, 22 May 2018 14:02:15 -0700
Message-ID: <CA+GK6enroS==oadiOTBfz9DiC6Pc-VJks3Mg7reaSzQzAigc7w@mail.gmail.com>
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
Content-Type: multipart/alternative; boundary="000000000000a2c986056cd1bbea"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-ntb <linux-ntb@googlegroups.com>, Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, "Jiang, Dave" <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

--000000000000a2c986056cd1bbea
Content-Type: text/plain; charset="UTF-8"

On Thu, May 17, 2018 at 8:48 AM, Logan Gunthorpe <logang@deltatee.com>
wrote:

> Thanks for your hard work on this Doug!
>
> On 17/05/18 06:00 AM, dmeyer@gigaio.com wrote:
>
> > +     if (pci_enable_device(pdev)) {
> > +             dev_err(&pdev->dev, "Cannot enable Switchtec device\n");
> > +             return;
> > +     }
>
> I suspect we should probably cass pci_disable_device() before leaving
> this function so it's in the same state we started. Just like we unmap
> the mmio.
>

Dear Logan,

I agree. I'll add it.

Blessings,
Doug



>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/
> msgid/linux-ntb/a0997fec-ba06-0d1d-a43d-fcc1600484f5%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
>

--000000000000a2c986056cd1bbea
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Thu, May 17, 2018 at 8:48 AM, Logan Gunthorpe <span dir=3D"ltr">&lt;=
<a href=3D"mailto:logang@deltatee.com" target=3D"_blank">logang@deltatee.co=
m</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margi=
n:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Thanks for your h=
ard work on this Doug!<br>
<span class=3D""><br>
On 17/05/18 06:00 AM, <a href=3D"mailto:dmeyer@gigaio.com">dmeyer@gigaio.co=
m</a> wrote:<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0if (pci_enable_device(pdev)) {<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0dev_err(&amp;pdev-&gt=
;dev, &quot;Cannot enable Switchtec device\n&quot;);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0}<br>
<br>
</span>I suspect we should probably cass pci_disable_device() before leavin=
g<br>
this function so it&#39;s in the same state we started. Just like we unmap<=
br>
the mmio.<br></blockquote><div><br></div><div>Dear Logan,</div><div><br></d=
iv><div>I agree. I&#39;ll add it.</div><div><br></div><div>Blessings,</div>=
<div>Doug</div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1e=
x">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
Logan<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-ntb&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com">linux-n=
tb+unsubscribe@<wbr>googlegroups.com</a>.<br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com">linux-ntb@googlegroups.com</a>.<br>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/a0997fec-ba06-0d1d-a43d-fcc1600484f5%40deltatee.com" r=
el=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>msgid/=
linux-ntb/a0997fec-ba06-<wbr>0d1d-a43d-fcc1600484f5%<wbr>40deltatee.com</a>=
.<br>
For more options, visit <a href=3D"https://groups.google.com/d/optout" rel=
=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/<wbr>optout</=
a>.<br>
</font></span></blockquote></div><br></div></div>

--000000000000a2c986056cd1bbea--
