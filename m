Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x235.google.com (mail-qt0-x235.google.com. [2607:f8b0:400d:c0d::235])
        by gmr-mx.google.com with ESMTPS id v22si886106oth.1.2018.01.18.14.31.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 14:31:02 -0800 (PST)
Received: by mail-qt0-x235.google.com with SMTP id m59so34323735qte.11
        for <linux-ntb@googlegroups.com>; Thu, 18 Jan 2018 14:31:02 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 18 Jan 2018 17:30:59 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] [RESEND] ntb_hw_switchtec: fix logic error
Message-ID: <20180118223058.GE25893@kudzu.us>
References: <20180116135116.4065102-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180116135116.4065102-1-arnd@arndb.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Stephen Bates <sbates@raithlin.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 16, 2018 at 02:50:51PM +0100, Arnd Bergmann wrote:
> Newer gcc (version 7 and 8 presumably) warn about a statement mixing
> the << operator with logical and:
> 
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c: In function 'switchtec_ntb_init_sndev':
> drivers/ntb/hw/mscc/ntb_hw_switchtec.c:888:24: error: '<<' in boolean context, did you mean '<' ? [-Werror=int-in-bool-context]
> 
> My interpretation here is that the author must have intended a bitmask
> rather than a comparison, so I'm changing the '&&' to '&', which makes
> a lot more sense in the context.
> 
> Fixes: 1b249475275d ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ----
> Originally sent on Dec 9, but this patch never got picked up

Sorry for missing the patch.  Applied to ntb-next.

Thanks,
Jon

> ---
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> index bcd5b6fb3800..76acb8bba3f2 100644
> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
> @@ -885,7 +885,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
>  		}
>  
>  		sndev->peer_partition = ffs(tpart_vec) - 1;
> -		if (!(part_map && (1 << sndev->peer_partition))) {
> +		if (!(part_map & (1 << sndev->peer_partition))) {
>  			dev_err(&sndev->stdev->dev,
>  				"ntb target partition is not NT partition\n");
>  			return -ENODEV;
> -- 
> 2.9.0
> 
