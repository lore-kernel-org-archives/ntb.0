Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id c21si740795qkg.1.2017.12.11.06.55.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Dec 2017 06:55:49 -0800 (PST)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20171209000217.18366-1-logang@deltatee.com>
In-Reply-To: <20171209000217.18366-1-logang@deltatee.com>
Subject: RE: [PATCH 1/2] ntb_transport: Fix bug with max_mw_size parameter
Date: Mon, 11 Dec 2017 09:55:25 -0500
Message-ID: <000101d37290$148f0250$3dad06f0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> When using the max_mw_size parameter of ntb_transport to limit the size of
> the Memory windows, communication cannot be established and the queues
> freeze.
> 
> This is because the mw_size that's reported to the peer is correctly
> limited but the size used locally is not. So the MW is initialized
> with a buffer smaller than the window but the TX side is using the
> full window. This means the TX side will be writing to a region of the
> window that points nowhere.
> 
> This is easily fixed by applying the same limit to tx_size in
> ntb_transport_init_queue().
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/ntb_transport.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 045e3dd4750e..9878c48826e3 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1003,6 +1003,9 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	mw_base = nt->mw_vec[mw_num].phys_addr;
>  	mw_size = nt->mw_vec[mw_num].phys_size;
> 
> +	if (max_mw_size && mw_size > max_mw_size)
> +		mw_size = max_mw_size;
> +
>  	tx_size = (unsigned int)mw_size / num_qps_mw;
>  	qp_offset = tx_size * (qp_num / mw_count);
> 
> --
> 2.11.0

