Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x236.google.com (mail-yw0-x236.google.com. [2607:f8b0:4002:c05::236])
        by gmr-mx.google.com with ESMTPS id w69si2085056ywa.3.2016.03.21.16.54.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Mar 2016 16:54:28 -0700 (PDT)
Received: by mail-yw0-x236.google.com with SMTP id h129so234170002ywb.1
        for <linux-ntb@googlegroups.com>; Mon, 21 Mar 2016 16:54:28 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 21 Mar 2016 19:52:38 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: test: fix pointer size warning
Message-ID: <20160321235237.GA17910@kudzu.us>
References: <1458321080-42873-1-git-send-email-computersforpeace@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1458321080-42873-1-git-send-email-computersforpeace@gmail.com>
To: Brian Norris <computersforpeace@gmail.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Fri, Mar 18, 2016 at 10:11:20AM -0700, Brian Norris wrote:
> drivers/ntb/test/ntb_perf.c: In function ‘perf_copy’:
> drivers/ntb/test/ntb_perf.c:213:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> drivers/ntb/test/ntb_perf.c:214:14: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> On 32-bit systems, we are casting a 32-bit pointer to a 64-bit value.
> This shouldn't cause functional problems, but we might as well fix the
> warning and allow 32-bit arithmetic for 32-bit systems.

This was already addressed by a patch from Arnd Bergmann, which is
queued in the ntb git tree.

Thanks,
Jon

> 
> Signed-off-by: Brian Norris <computersforpeace@gmail.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> ---
>  drivers/ntb/test/ntb_perf.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index c8a37ba4b4f9..835e2686998d 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -189,7 +189,7 @@ static ssize_t perf_copy(struct pthr_ctx *pctx, char *dst,
>  	dma_cookie_t cookie;
>  	size_t src_off, dst_off;
>  	struct perf_mw *mw = &perf->mw;
> -	u64 vbase, dst_vaddr;
> +	uintptr_t vbase, dst_vaddr;
>  	dma_addr_t dst_phys;
>  	int retries = 0;
>  
> @@ -210,8 +210,8 @@ static ssize_t perf_copy(struct pthr_ctx *pctx, char *dst,
>  	if (!is_dma_copy_aligned(device, src_off, dst_off, size))
>  		return -ENODEV;
>  
> -	vbase = (u64)(u64 *)mw->vbase;
> -	dst_vaddr = (u64)(u64 *)dst;
> +	vbase = (uintptr_t)(u64 *)mw->vbase;
> +	dst_vaddr = (uintptr_t)(u64 *)dst;
>  	dst_phys = mw->phys_addr + (dst_vaddr - vbase);
>  
>  	unmap = dmaengine_get_unmap_data(device->dev, 1, GFP_NOWAIT);
> -- 
> 2.8.0.rc3.226.g39d4020
> 
