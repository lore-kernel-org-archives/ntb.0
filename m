Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l76si190083oih.3.2019.12.10.09.32.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 09:32:07 -0800 (PST)
References: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <fd958d1b-5abc-b936-2f21-429326a6e5de@deltatee.com>
Date: Tue, 10 Dec 2019 10:31:59 -0700
MIME-Version: 1.0
In-Reply-To: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_perf: pass correct struct device to
 dma_alloc_coherent
To: Sanjay R Mehta <Sanju.Mehta@amd.com>, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, will@kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>


On 2019-12-10 6:07 a.m., Sanjay R Mehta wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Currently, ntb->dev is passed to dma_alloc_coherent
> and dma_free_coherent calls. The returned dma_addr_t
> is the CPU physical address. This works fine as long
> as IOMMU is disabled. But when IOMMU is enabled, we
> need to make sure that IOVA is returned for dma_addr_t.
> So the correct way to achieve this is by changing the
> first parameter of dma_alloc_coherent() as ntb->pdev->dev
> instead.
> 
> Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>

Yes, I did the same thing as one of the patches in my fix-up series that
never got merged. See [1].

Hopefully you can make better progress than I did.

While you're at it I think it's worth doing the same thing in ntb_tool
as well as removing the dma_coerce_mask_and_coherent() calls that are in
the NTB drivers which are meaningless once we get back to using the
correct DMA device.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/

> ---
>  drivers/ntb/test/ntb_perf.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index f5df33a..8729838 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
>  		return;
>  
>  	(void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
> -	dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
> +	dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
>  			  peer->inbuf, peer->inbuf_xlat);
>  	peer->inbuf = NULL;
>  }
> @@ -588,8 +588,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
>  
>  	perf_free_inbuf(peer);
>  
> -	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
> -					 &peer->inbuf_xlat, GFP_KERNEL);
> +	peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
> +					 peer->inbuf_size, &peer->inbuf_xlat,
> +					 GFP_KERNEL);
>  	if (!peer->inbuf) {
>  		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
>  			&peer->inbuf_size);
> 
