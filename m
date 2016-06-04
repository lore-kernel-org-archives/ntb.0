Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id m78si675667ywd.4.2016.06.04.08.43.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jun 2016 08:43:33 -0700 (PDT)
Received: by mail-yw0-x242.google.com with SMTP id y6so14250105ywe.0
        for <linux-ntb@googlegroups.com>; Sat, 04 Jun 2016 08:43:33 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sat, 4 Jun 2016 11:40:36 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 2/3] ntb_transport: Check the number of spads the
 hardware supports
Message-ID: <20160604154035.GA11597@kudzu.us>
References: <cover.1464986161.git.logang@deltatee.com>
 <efa91cd782ad223cc30eeeda8d2341cc11a8646d.1464986161.git.logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efa91cd782ad223cc30eeeda8d2341cc11a8646d.1464986161.git.logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, John Kading <john.kading@gd-ms.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 03, 2016 at 02:50:32PM -0600, Logan Gunthorpe wrote:
> I'm working on hardware that currently has a limited number of
> scratchpad registers and ntb_ndev fails with no clue as to why. I
> feel it is better to fail early and provide a reasonable error message
> then to fail later on..
> 
> The same is done to ntb_perf, but it doesn't currently require enough
> spads to actually fail.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  drivers/ntb/ntb_transport.c | 9 +++++++--
>  drivers/ntb/test/ntb_perf.c | 8 ++++++--
>  2 files changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 2ef9d913..34e7a7a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1037,6 +1037,13 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  	int node;
>  	int rc, i;
>  
> +	mw_count = ntb_mw_count(ndev);
> +	if (ntb_spad_count(ndev) < (NUM_MWS + 1 + mw_count*2)) {

Nit, please add spaces around '*' (per checkpatch)

> +		dev_err(&ndev->dev, "Not enough scratch pad registers for %s",
> +			NTB_TRANSPORT_NAME);
> +		return -EIO;
> +	}
> +
>  	if (ntb_db_is_unsafe(ndev))
>  		dev_dbg(&ndev->dev,
>  			"doorbell is unsafe, proceed anyway...\n");
> @@ -1052,8 +1059,6 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
>  
>  	nt->ndev = ndev;
>  
> -	mw_count = ntb_mw_count(ndev);
> -
>  	nt->mw_count = mw_count;
>  
>  	nt->mw_vec = kzalloc_node(mw_count * sizeof(*nt->mw_vec),
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 30635c8..1815592 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -143,8 +143,6 @@ enum {
>  	VERSION = 0,
>  	MW_SZ_HIGH,
>  	MW_SZ_LOW,
> -	SPAD_MSG,
> -	SPAD_ACK,

Please explicitly point out that this is being modified in the commit
message.  I don't see them being used, so probably not a big deal
(unless Dave Jiang has something queued that will use it).

>  	MAX_SPAD
>  };
>  
> @@ -698,6 +696,12 @@ static int perf_probe(struct ntb_client *client, struct ntb_dev *ntb)
>  
>  	node = dev_to_node(&pdev->dev);
>  
> +	if (ntb_spad_count(ntb) < MAX_SPAD) {
> +		dev_err(&ntb->dev, "Not enough scratch pad registers for %s",
> +			DRIVER_NAME);
> +		return -EIO;
> +	}

Move this check above the dev_to_node assignment above.

Thanks,
Jon

> +
>  	perf = kzalloc_node(sizeof(*perf), GFP_KERNEL, node);
>  	if (!perf) {
>  		rc = -ENOMEM;
> -- 
> 2.1.4
> 
