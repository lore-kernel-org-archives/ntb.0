Date: Mon, 11 Dec 2017 01:36:25 -0800 (PST)
From: Frank Huang <tigerinxm@gmail.com>
Message-Id: <3cfaccdb-7424-4077-b05f-a294aaebaecd@googlegroups.com>
Subject: question of ntb_transport dma copy
MIME-Version: 1.0
Content-Type: multipart/mixed; 
	boundary="----=_Part_6878_1665225643.1512984985507"
To: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

------=_Part_6878_1665225643.1512984985507
Content-Type: multipart/alternative; 
	boundary="----=_Part_6879_950775521.1512984985507"

------=_Part_6879_950775521.1512984985507
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


>
> 1647 static void ntb_async_tx(struct ntb_transport_qp *qp,
> 1648              struct ntb_queue_entry *entry)
> 1649 {
> 1650     struct ntb_payload_header __iomem *hdr;
> 1651     struct dma_chan *chan = qp->tx_dma_chan;
> 1652     void __iomem *offset;
> 1653     int res;
> 1654
> 1655     entry->tx_index = qp->tx_index;
> 1656     offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> 1657     hdr = offset + qp->tx_max_frame - sizeof(struct 
> ntb_payload_header);
> 1658     entry->tx_hdr = hdr;
> 1659
> 1660     iowrite32(entry->len, &hdr->len);
> 1661     iowrite32((u32)qp->tx_pkts, &hdr->ver);
> 1662
> 1663     if (!chan)
> 1664         goto err;



hi, 
When I read the ntb source code, I found that ntb_transport support two 
types of coping:using CPU and DMA. 
But the ntb_async_tx function will do a dma_chan check ,if fail, it will 
return error(L1663).
That's say the ntb_transport only support rx CPU copy, and set the tx using 
DMA copy default?

------=_Part_6879_950775521.1512984985507
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<blockquote class=3D"gmail_quote" style=3D"margin: 0px 0px 0px 0.8ex; borde=
r-left: 1px solid rgb(204, 204, 204); padding-left: 1ex;">1647 static void =
ntb_async_tx(struct ntb_transport_qp *qp,<br>1648=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 struct ntb_queue_entry *entry)<br>1649 {<br>1650=
=C2=A0 =C2=A0 =C2=A0struct ntb_payload_header __iomem *hdr;<br>1651=C2=A0 =
=C2=A0 =C2=A0struct dma_chan *chan =3D qp-&gt;tx_dma_chan;<br>1652=C2=A0 =
=C2=A0 =C2=A0void __iomem *offset;<br>1653=C2=A0 =C2=A0 =C2=A0int res;<br>1=
654<br>1655=C2=A0 =C2=A0 =C2=A0entry-&gt;tx_index =3D qp-&gt;tx_index;<br>1=
656=C2=A0 =C2=A0 =C2=A0offset =3D qp-&gt;tx_mw + qp-&gt;tx_max_frame * entr=
y-&gt;tx_index;<br>1657=C2=A0 =C2=A0 =C2=A0hdr =3D offset + qp-&gt;tx_max_f=
rame - sizeof(struct ntb_payload_header);<br>1658=C2=A0 =C2=A0 =C2=A0entry-=
&gt;tx_hdr =3D hdr;<br>1659<br>1660=C2=A0 =C2=A0 =C2=A0iowrite32(entry-&gt;=
len, &amp;hdr-&gt;len);<br>1661=C2=A0 =C2=A0 =C2=A0iowrite32((u32)qp-&gt;tx=
_pkts, &amp;hdr-&gt;ver);<br>1662<br>1663=C2=A0 =C2=A0 =C2=A0if (!chan)<br>=
1664=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;</blockquote><div><br></div>=
<div><br></div><div>hi,=C2=A0</div><div>When I read the ntb source code, I =
found that ntb_transport support two types of coping:using CPU and DMA.=C2=
=A0</div><div>But the ntb_async_tx function will do a dma_chan check ,if fa=
il, it will return error(L1663).</div><div>That&#39;s say the ntb_transport=
 only support rx CPU copy, and set the tx using DMA copy default?</div>
------=_Part_6879_950775521.1512984985507--

------=_Part_6878_1665225643.1512984985507--
