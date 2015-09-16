Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id ch7si156652wib.2.2015.09.16.07.42.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2015 07:42:02 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <20150916141253.GA7674@mwanda>
In-Reply-To: <20150916141253.GA7674@mwanda>
Subject: RE: NTB: Use unique DMA channels for TX and RX
Date: Wed, 16 Sep 2015 10:41:50 -0400
Message-ID: <005701d0f08d$d2c58780$78509680$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: dave.jiang@intel.com
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: linux-ntb@googlegroups.com On Behalf Of Dan Carpenter
> Subject: re: NTB: Use unique DMA channels for TX and RX
>=20
> drivers/ntb/ntb_transport.c:2008 ntb_transport_max_size()
> 	 error: we previously assumed 'qp->tx_dma_chan' could be null (see
> line 2005)
>=20
> drivers/ntb/ntb_transport.c
>   2004
>   2005		if (!qp->tx_dma_chan && !qp->rx_dma_chan)

I seem to recall commenting on this in patch v1:

>> -	if (!qp->dma_chan)
>> +	if (!qp->tx_dma_chan && !qp->rx_dma_chan)
>
> Unusual to see "if (not && not)" in code, but it looks correct in this =
case.
>
> if (no dma at all)
>	return without any alignment restriction;
>
> Is that right?

Maybe I was wrong to say "looks correct" because this static checker =
warning sure looks real.

>=20
> Patch adds new checks for NULL.  Was || intended here perhaps?
>=20
>   2006			return qp->tx_max_frame - sizeof(struct
> ntb_payload_header);
>   2007
>   2008		copy_align =3D max(qp->tx_dma_chan->device->copy_align,
>   2009				 qp->rx_dma_chan->device->copy_align);

I think this is the part that actually needs to be fixed.  Maybe this =
whole function should be:

copy_align =3D max(dma_copy_align(qp->tx_dma_chan),
                 dma_copy_align(qp->rx_dma_chan));

where dma_copy_align is:

if (!chan)
        return 1;
return chan->device->copy_align;

>=20
> Patch adds unchecked dereferences.
>=20
>   2010
>=20

