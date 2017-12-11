Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id 105si694042uas.1.2017.12.11.06.33.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 06:33:00 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <3cfaccdb-7424-4077-b05f-a294aaebaecd@googlegroups.com>
In-Reply-To: <3cfaccdb-7424-4077-b05f-a294aaebaecd@googlegroups.com>
Subject: RE: question of ntb_transport dma copy
Date: Mon, 11 Dec 2017 09:32:46 -0500
Message-ID: <000001d3728c$e9a13340$bce399c0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Frank Huang' <tigerinxm@gmail.com>, 'linux-ntb' <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

From: Frank Huang
> 1647 static void ntb_async_tx(struct ntb_transport_qp *qp,
> 1648              struct ntb_queue_entry *entry)
> 1649 {
> 1650     struct ntb_payload_header __iomem *hdr;
> 1651     struct dma_chan *chan =3D qp->tx_dma_chan;
> 1652     void __iomem *offset;
> 1653     int res;
> 1654
> 1655     entry->tx_index =3D qp->tx_index;
> 1656     offset =3D qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> 1657     hdr =3D offset + qp->tx_max_frame - sizeof(struct =
ntb_payload_header);
> 1658     entry->tx_hdr =3D hdr;
> 1659
> 1660     iowrite32(entry->len, &hdr->len);
> 1661     iowrite32((u32)qp->tx_pkts, &hdr->ver);
> 1662
> 1663     if (!chan)
> 1664         goto err;
>
>
> hi,=20
> When I read the ntb source code, I found that ntb_transport support =
two types of coping:using CPU and DMA.=20
> But the ntb_async_tx function will do a dma_chan check ,if fail, it =
will return error(L1663).
> That's say the ntb_transport only support rx CPU copy, and set the tx =
using DMA copy default?

Is it possible that in reading the code, you had been comparing =
ntb_async_rx to ntb_async_tx_submit?  There is a distinction in the =
async functions in this file: ntb_async_tx and ntb_async_tx_submit, =
ntb_async_rx and ntb_async_rx_submit.  See if a second read-through =
clears it up for you, or if there is still a question here.

In the snip in your email, note that the ntb_async_tx return type is =
void.  It does not return an error after L1663.  After `if (!chan)` =
follow `goto err` down to the label end of the function, which does =
memcpy:

err:
	ntb_memcpy_tx(entry, offset);
	qp->tx_memcpy++;

Maybe `if (!chan)` should be moved to the ntb_async_tx/rx_submit =
functions, where chan is actually used.

Allen

