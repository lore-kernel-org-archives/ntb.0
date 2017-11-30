Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y25si342829uaa.2.2017.11.30.14.07.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 Nov 2017 14:07:55 -0800 (PST)
References: <20171130213941.21114-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <903ec475-1163-efd8-13ea-6b531210b928@deltatee.com>
Date: Thu, 30 Nov 2017 15:07:52 -0700
MIME-Version: 1.0
In-Reply-To: <20171130213941.21114-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: Fix UB/bug in ntb_mw_get_align()
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 30/11/17 02:39 PM, Serge Semin wrote:
> Simple (1 << pidx) operation causes undefined behaviour when
> pidx >= 32. It must be casted to u64 to match the actual return
> value of ntb_link_is_up() method, so to have all the possible
> peer indexes covered and to get rid of undefined behaviour.
> Additionally there are special macros in "linux/bitops.h" to perform
> the bit-set-shift operations, so it's recommended to have them used
> for proper bit setting.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

> ---
>   include/linux/ntb.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index c1646f2c6344..488e586fb76c 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -764,7 +764,7 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
>   				   resource_size_t *size_align,
>   				   resource_size_t *size_max)
>   {
> -	if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
> +	if (!(ntb_link_is_up(ntb, NULL, NULL) & BIT_ULL(pidx)))
>   		return -ENOTCONN;
>   
>   	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
> 
