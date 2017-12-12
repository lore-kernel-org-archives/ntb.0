Date: Mon, 11 Dec 2017 17:26:49 -0800 (PST)
From: Frank Huang <tigerinxm@gmail.com>
Message-Id: <35d8105b-4f14-4c06-b8ea-4fad9a6f1b74@googlegroups.com>
In-Reply-To: <000001d3728c$e9a13340$bce399c0$@dell.com>
References: <3cfaccdb-7424-4077-b05f-a294aaebaecd@googlegroups.com>
 <000001d3728c$e9a13340$bce399c0$@dell.com>
Subject: Re: question of ntb_transport dma copy
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_491_78645165.1513042009335"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_491_78645165.1513042009335
Content-Type: multipart/alternative; 
	boundary="----=_Part_492_2108927432.1513042009335"

------=_Part_492_2108927432.1513042009335
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Allen,=20
Thank you, it is clear to me now. I was misled by the 'goto err'.

=E5=9C=A8 2017=E5=B9=B412=E6=9C=8811=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 UT=
C+8=E4=B8=8B=E5=8D=8810:33:00=EF=BC=8CAllen Hubbe=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From: Frank Huang=20
> > 1647 static void ntb_async_tx(struct ntb_transport_qp *qp,=20
> > 1648              struct ntb_queue_entry *entry)=20
> > 1649 {=20
> > 1650     struct ntb_payload_header __iomem *hdr;=20
> > 1651     struct dma_chan *chan =3D qp->tx_dma_chan;=20
> > 1652     void __iomem *offset;=20
> > 1653     int res;=20
> > 1654=20
> > 1655     entry->tx_index =3D qp->tx_index;=20
> > 1656     offset =3D qp->tx_mw + qp->tx_max_frame * entry->tx_index;=20
> > 1657     hdr =3D offset + qp->tx_max_frame - sizeof(struct=20
> ntb_payload_header);=20
> > 1658     entry->tx_hdr =3D hdr;=20
> > 1659=20
> > 1660     iowrite32(entry->len, &hdr->len);=20
> > 1661     iowrite32((u32)qp->tx_pkts, &hdr->ver);=20
> > 1662=20
> > 1663     if (!chan)=20
> > 1664         goto err;=20
> >=20
> >=20
> > hi,=20
> > When I read the ntb source code, I found that ntb_transport support two=
=20
> types of coping:using CPU and DMA.=20
> > But the ntb_async_tx function will do a dma_chan check ,if fail, it wil=
l=20
> return error(L1663).=20
> > That's say the ntb_transport only support rx CPU copy, and set the tx=
=20
> using DMA copy default?=20
>
> Is it possible that in reading the code, you had been comparing=20
> ntb_async_rx to ntb_async_tx_submit?  There is a distinction in the async=
=20
> functions in this file: ntb_async_tx and ntb_async_tx_submit, ntb_async_r=
x=20
> and ntb_async_rx_submit.  See if a second read-through clears it up for=
=20
> you, or if there is still a question here.=20
>
> In the snip in your email, note that the ntb_async_tx return type is void=
.=20
>  It does not return an error after L1663.  After `if (!chan)` follow `got=
o=20
> err` down to the label end of the function, which does memcpy:=20
>
> err:=20
>         ntb_memcpy_tx(entry, offset);=20
>         qp->tx_memcpy++;=20
>
> Maybe `if (!chan)` should be moved to the ntb_async_tx/rx_submit=20
> functions, where chan is actually used.=20
>
> Allen=20
>
>
------=_Part_492_2108927432.1513042009335
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Allen,=C2=A0<div>Thank you, it is clear to me now. I was m=
isled by the &#39;goto err&#39;.<br><br>=E5=9C=A8 2017=E5=B9=B412=E6=9C=881=
1=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 UTC+8=E4=B8=8B=E5=8D=8810:33:00=EF=BC=
=8CAllen Hubbe=E5=86=99=E9=81=93=EF=BC=9A<blockquote class=3D"gmail_quote" =
style=3D"margin: 0;margin-left: 0.8ex;border-left: 1px #ccc solid;padding-l=
eft: 1ex;">From: Frank Huang
<br>&gt; 1647 static void ntb_async_tx(struct ntb_transport_qp *qp,
<br>&gt; 1648 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0struct ntb_qu=
eue_entry *entry)
<br>&gt; 1649 {
<br>&gt; 1650 =C2=A0 =C2=A0 struct ntb_payload_header __iomem *hdr;
<br>&gt; 1651 =C2=A0 =C2=A0 struct dma_chan *chan =3D qp-&gt;tx_dma_chan;
<br>&gt; 1652 =C2=A0 =C2=A0 void __iomem *offset;
<br>&gt; 1653 =C2=A0 =C2=A0 int res;
<br>&gt; 1654
<br>&gt; 1655 =C2=A0 =C2=A0 entry-&gt;tx_index =3D qp-&gt;tx_index;
<br>&gt; 1656 =C2=A0 =C2=A0 offset =3D qp-&gt;tx_mw + qp-&gt;tx_max_frame *=
 entry-&gt;tx_index;
<br>&gt; 1657 =C2=A0 =C2=A0 hdr =3D offset + qp-&gt;tx_max_frame - sizeof(s=
truct ntb_payload_header);
<br>&gt; 1658 =C2=A0 =C2=A0 entry-&gt;tx_hdr =3D hdr;
<br>&gt; 1659
<br>&gt; 1660 =C2=A0 =C2=A0 iowrite32(entry-&gt;len, &amp;hdr-&gt;len);
<br>&gt; 1661 =C2=A0 =C2=A0 iowrite32((u32)qp-&gt;tx_pkts, &amp;hdr-&gt;ver=
);
<br>&gt; 1662
<br>&gt; 1663 =C2=A0 =C2=A0 if (!chan)
<br>&gt; 1664 =C2=A0 =C2=A0 =C2=A0 =C2=A0 goto err;
<br>&gt;
<br>&gt;
<br>&gt; hi,=20
<br>&gt; When I read the ntb source code, I found that ntb_transport suppor=
t two types of coping:using CPU and DMA.=20
<br>&gt; But the ntb_async_tx function will do a dma_chan check ,if fail, i=
t will return error(L1663).
<br>&gt; That&#39;s say the ntb_transport only support rx CPU copy, and set=
 the tx using DMA copy default?
<br>
<br>Is it possible that in reading the code, you had been comparing ntb_asy=
nc_rx to ntb_async_tx_submit? =C2=A0There is a distinction in the async fun=
ctions in this file: ntb_async_tx and ntb_async_tx_submit, ntb_async_rx and=
 ntb_async_rx_submit. =C2=A0See if a second read-through clears it up for y=
ou, or if there is still a question here.
<br>
<br>In the snip in your email, note that the ntb_async_tx return type is vo=
id. =C2=A0It does not return an error after L1663. =C2=A0After `if (!chan)`=
 follow `goto err` down to the label end of the function, which does memcpy=
:
<br>
<br>err:
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0ntb_memcpy_tx(entry, of=
fset);
<br>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0qp-&gt;tx_memcpy++;
<br>
<br>Maybe `if (!chan)` should be moved to the ntb_async_tx/rx_submit functi=
ons, where chan is actually used.
<br>
<br>Allen
<br>
<br></blockquote></div></div>
------=_Part_492_2108927432.1513042009335--

------=_Part_491_78645165.1513042009335--
