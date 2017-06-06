Return-Path: <Allen.Hubbe@dell.com>
Received: from esa3.dell-outbound.iphmx.com (esa3.dell-outbound.iphmx.com. [68.232.153.94])
        by gmr-mx.google.com with ESMTPS id x190si2030374ywg.13.2017.06.06.06.09.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 06:09:02 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170605200053.6912-1-logang@deltatee.com> <20170605200053.6912-3-logang@deltatee.com>
In-Reply-To: <20170605200053.6912-3-logang@deltatee.com>
Subject: RE: [PATCH] ntb_transport: fix bug calculating num_qps_mw
Date: Tue, 6 Jun 2017 09:08:43 -0400
Message-ID: <000101d2dec6$0648f060$12dad120$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> A divide by zero error occurs if qp_count is less than mw_count because
> num_qps_mw is calculated to be zero. The calculation appears to be
> incorrect.
> 
> The requirement is for num_qps_mw to be set to qp_count / mw_count
> with any remainder divided among the earlier mws.
> 
> For example, if mw_count is 5 and qp_count is 12 then mws 0 and 1
> will have 3 qps per window and mws 2 through 4 will have 2 qps per window.
> Thus, when mw_num < qp_count % mw_count, num_qps_mw is 1 higher
> than when mw_num >= qp_count.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/ntb/ntb_transport.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 0a778d2cab94..5b6b00ea6ed9 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -623,7 +623,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	if (!mw->virt_addr)
>  		return -ENOMEM;
> 
> -	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
> +	if (mw_num < qp_count % mw_count)
>  		num_qps_mw = qp_count / mw_count + 1;
>  	else
>  		num_qps_mw = qp_count / mw_count;
> @@ -1000,7 +1000,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->event_handler = NULL;
>  	ntb_qp_link_down_reset(qp);
> 
> -	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
> +	if (mw_num < qp_count % mw_count)
>  		num_qps_mw = qp_count / mw_count + 1;
>  	else
>  		num_qps_mw = qp_count / mw_count;
> --
> 2.11.0


