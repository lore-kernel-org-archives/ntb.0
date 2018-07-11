Return-Path: <fancer.lancer@gmail.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com. [2607:f8b0:400d:c0d::241])
        by gmr-mx.google.com with ESMTPS id a82-v6si1318318qkj.1.2018.07.11.10.50.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Jul 2018 10:50:47 -0700 (PDT)
Received: by mail-qt0-x241.google.com with SMTP id h4-v6so21799613qtj.7
        for <linux-ntb@googlegroups.com>; Wed, 11 Jul 2018 10:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20180711163224.30892-1-fancer.lancer@gmail.com> <58db6cb1-c62e-bedd-6542-9a0e40e3dd86@deltatee.com>
In-Reply-To: <58db6cb1-c62e-bedd-6542-9a0e40e3dd86@deltatee.com>
From: "Fancer's opinion" <fancer.lancer@gmail.com>
Date: Wed, 11 Jul 2018 20:50:36 +0300
Message-ID: <CAMPMW8pr6BV7aakqqDCb5sDbzwrdp2A7GpS_Z3mU9Q0KTRDjrw@mail.gmail.com>
Subject: Re: [PATCH] ntb: idt: Set PCIe bus address to BARLIMITx
Content-Type: multipart/alternative; boundary="000000000000edbc050570bce216"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, allenbh@gmail.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

--000000000000edbc050570bce216
Content-Type: text/plain; charset="UTF-8"

Oh, thanks man. I failed to find it.

-Sergey


On Wed, 11 Jul 2018, 19:52 Logan Gunthorpe, <logang@deltatee.com> wrote:

>
>
> On 11/07/18 10:32 AM, Serge Semin wrote:
> > @@ -1320,7 +1321,9 @@ static int idt_ntb_peer_mw_set_trans(struct
> ntb_dev *ntb, int pidx, int widx,
> >               idt_nt_write(ndev, bar->ltbase, (u32)addr);
> >               idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
> >               /* Set the custom BAR aperture limit */
> > -             limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
> > +             pcibios_resource_to_bus(ntb->pdev->bus, &region,
> > +                                     &ntb->pdev->resource[mw_cfg->bar]);
> > +             limit = region.start + size;
>
> You should use the pci_bus_address() helper instead. It's much simpler
> and you don't need to delve into pci_dev internals to use it.
>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/58db6cb1-c62e-bedd-6542-9a0e40e3dd86%40deltatee.com
> .
> For more options, visit https://groups.google.com/d/optout.
>

--000000000000edbc050570bce216
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>Oh, thanks man. I failed to find it.</div><div dir=
=3D"auto"><br></div><div dir=3D"auto">-Sergey</div><div dir=3D"auto"><br><b=
r><div class=3D"gmail_quote" dir=3D"auto"><div dir=3D"ltr">On Wed, 11 Jul 2=
018, 19:52 Logan Gunthorpe, &lt;<a href=3D"mailto:logang@deltatee.com">loga=
ng@deltatee.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" s=
tyle=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 11/07/18 10:32 AM, Serge Semin wrote:<br>
&gt; @@ -1320,7 +1321,9 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_=
dev *ntb, int pidx, int widx,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_nt_write(nde=
v, bar-&gt;ltbase, (u32)addr);<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0idt_nt_write(nde=
v, bar-&gt;utbase, (u32)(addr &gt;&gt; 32));<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* Set the custo=
m BAR aperture limit */<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0limit =3D pci_resourc=
e_start(ntb-&gt;pdev, mw_cfg-&gt;bar) + size;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pcibios_resource_to_b=
us(ntb-&gt;pdev-&gt;bus, &amp;region,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;ntb-&gt=
;pdev-&gt;resource[mw_cfg-&gt;bar]);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0limit =3D region.star=
t + size;<br>
<br>
You should use the pci_bus_address() helper instead. It&#39;s much simpler<=
br>
and you don&#39;t need to delve into pci_dev internals to use it.<br>
<br>
Logan<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;linux-ntb&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:linux-ntb%2Bunsubscribe@googlegroups.com" target=
=3D"_blank" rel=3D"noreferrer">linux-ntb+unsubscribe@googlegroups.com</a>.<=
br>
To post to this group, send email to <a href=3D"mailto:linux-ntb@googlegrou=
ps.com" target=3D"_blank" rel=3D"noreferrer">linux-ntb@googlegroups.com</a>=
.<br>
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/linux-ntb/58db6cb1-c62e-bedd-6542-9a0e40e3dd86%40deltatee.com" r=
el=3D"noreferrer noreferrer" target=3D"_blank">https://groups.google.com/d/=
msgid/linux-ntb/58db6cb1-c62e-bedd-6542-9a0e40e3dd86%40deltatee.com</a>.<br=
>
For more options, visit <a href=3D"https://groups.google.com/d/optout" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://groups.google.com/d/op=
tout</a>.<br>
</blockquote></div></div></div>

--000000000000edbc050570bce216--
