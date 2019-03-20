Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc43.google.com (mail-yw1-xc43.google.com. [2607:f8b0:4864:20::c43])
        by gmr-mx.google.com with ESMTPS id u185si113892oib.2.2019.03.20.08.17.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 08:17:31 -0700 (PDT)
Received: by mail-yw1-xc43.google.com with SMTP id v127so2235845ywe.13
        for <linux-ntb@googlegroups.com>; Wed, 20 Mar 2019 08:17:31 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 20 Mar 2019 11:17:29 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Message-ID: <20190320151728.GA19781@kudzu.us>
References: <20190320140812.5952-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190320140812.5952-1-yuehaibing@huawei.com>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Mar 20, 2019 at 10:08:12PM +0800, Yue Haibing wrote:
> From: YueHaibing <yuehaibing@huawei.com>
> 
> Fix sparse warning:
> 
> drivers/ntb/hw/intel/ntb_hw_gen3.c:535:5: warning:
>  symbol 'intel_ntb3_peer_db_addr' was not declared. Should it be static?
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Looks good to me.  Added to the ntb branch,

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen3.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> index f475b56..c339716 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
> @@ -532,9 +532,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  	return 0;
>  }
>  
> -int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> -				resource_size_t *db_size,
> -				u64 *db_data, int db_bit)
> +static int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
> +				   resource_size_t *db_size,
> +				   u64 *db_data, int db_bit)
>  {
>  	phys_addr_t db_addr_base;
>  	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
> -- 
> 2.7.0
> 
> 
