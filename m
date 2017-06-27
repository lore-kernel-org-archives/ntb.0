Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id u9si246898ywe.2.2017.06.27.09.05.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Jun 2017 09:05:17 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170626195041.6190-1-logang@deltatee.com>
In-Reply-To: <20170626195041.6190-1-logang@deltatee.com>
Subject: RE: [PATCH] ntb: use correct mw_count function in ntb_tool and ntb_transport
Date: Tue, 27 Jun 2017 12:04:54 -0400
Message-ID: <000001d2ef5f$1ed1e750$5c75b5f0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> After converting to the new API, both ntb_tool and ntb_transport are
> using ntb_mw_count to iterate through ntb_peer_get_addr when they
> should be using ntb_peer_mw_count.
> 
> This probably isn't an issue with the Intel and AMD drivers but
> this will matter for any future driver with asymetric memory window
> counts.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> Cc: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
> 
> Hi Guys,
> 
> I caught this issue while finishing up the switchtec rebase. (Which is
> now working again and I'll send the updated series after doing a bit more
> testing.)
> 
> However, seeing this is a bug in the new api patches I feel it should
> be applied to ntb-next tree before it's merged upstream.
> 
> Thanks,
> 
> Logan
> 
>  drivers/ntb/ntb_transport.c | 2 +-
>  drivers/ntb/test/ntb_tool.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9a03c5871efe..b29558ddfe95 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1059,7 +1059,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	int node;
>  	int rc, i;
> 
> -	mw_count = ntb_mw_count(ndev, PIDX);
> +	mw_count = ntb_peer_mw_count(ndev);
> 
>  	if (!ndev->ops->mw_set_trans) {
>  		dev_err(&ndev->dev, "Inbound MW based NTB API is required\n");
> diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
> index f002bf48a08d..a69815c45ce6 100644
> --- a/drivers/ntb/test/ntb_tool.c
> +++ b/drivers/ntb/test/ntb_tool.c
> @@ -959,7 +959,7 @@ static int tool_probe(struct ntb_client *self, struct ntb_dev *ntb)
>  	tc->ntb = ntb;
>  	init_waitqueue_head(&tc->link_wq);
> 
> -	tc->mw_count = min(ntb_mw_count(tc->ntb, PIDX), MAX_MWS);
> +	tc->mw_count = min(ntb_peer_mw_count(tc->ntb), MAX_MWS);
>  	for (i = 0; i < tc->mw_count; i++) {
>  		rc = tool_init_mw(tc, i);
>  		if (rc)
> --
> 2.11.0

