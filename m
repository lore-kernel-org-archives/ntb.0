Return-Path: <Allen.Hubbe@dell.com>
Received: from esa8.dell-outbound.iphmx.com (esa8.dell-outbound.iphmx.com. [68.232.149.218])
        by gmr-mx.google.com with ESMTPS id c125si184232ybf.3.2017.12.11.06.58.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 06:58:55 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20171209000217.18366-1-logang@deltatee.com> <20171209000217.18366-2-logang@deltatee.com>
In-Reply-To: <20171209000217.18366-2-logang@deltatee.com>
Subject: RE: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer in mw_set_trans()
Date: Mon, 11 Dec 2017 09:58:29 -0500
Message-ID: <000201d37290$81605eb0$84211c10$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> With Switchtec hardware, the buffer used for a memory window must be
> aligned to its size (the hardware only replaces the lower bits). In
> certain circumstances dma_alloc_coherent() will not provide a buffer
> that adheres to this requirement like when using the CMA and
> CONFIG_CMA_ALIGNMENT is set lower than the buffer size.
>=20
> When we get an unaligned buffer mw_set_trans() should return an error.
> We also log an error so we know the cause of the problem.
>=20
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
>=20
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c =
b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index 709f37fbe232..984b83bc7dd3 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -315,6 +315,19 @@ static int switchtec_ntb_mw_set_trans(struct =
ntb_dev *ntb, int pidx, int widx,
>  	if (xlate_pos < 12)
>  		return -EINVAL;
>=20
> +	if (addr & ((1 << xlate_pos) - 1)) {

!IS_ALIGNED(addr, BIT_ULL(xlate_pos))

> +		/*
> +		 * In certain circumstances we can get a buffer that is
> +		 * not aligned to its size. (Most of the time
> +		 * dma_alloc_coherent ensures this). This can happen when
> +		 * using large buffers allocated by the CMA
> +		 * (see CMA_CONFIG_ALIGNMENT)
> +		 */
> +		dev_err(&sndev->stdev->dev,
> +			"ERROR: Memory window address is not aligned to it's size!\n");

This would be the only ntb hw driver that prints an error in this =
situation.  The ntb_mw_get_align() should provide enough information to =
client drivers to determine the alignment requirements before calling =
ntb_mw_set_trans().  IMO no need to print here, but let's see what =
others say.

> +		return -EINVAL;
> +	}
> +
>  	rc =3D switchtec_ntb_part_op(sndev, ctl, NTB_CTRL_PART_OP_LOCK,
>  				   NTB_CTRL_PART_STATUS_LOCKED);
>  	if (rc)
> --
> 2.11.0

