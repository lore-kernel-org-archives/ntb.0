Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85385464C
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789778207; cv=none; b=hMm8OGS1U1SmNZgvzQJa6c2jD4yPR9R8xzfHRZnq3g25ylMZV2BKciCQWES95H0tjhYjIOUgelMMMoc7yJ2i/7dPotvLZtW2/MErfmjXybWex0+KttIg2+ebFtvKa9WcttDsQUXA3RCfEmACXeTp+0VsV2rHst2dIARG87kTBV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789778207; c=relaxed/simple;
	bh=WOR/ls5zxX5sPZGG/HhWRCdfca5hWsTLk1XL54j9bt0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNOxA1m0WakzTraHvSBU4CVW5RKzniSgRfzqnxSfULF42BnGWNEv5WNEwrZiAjh9Ja6cMO+lm/QyNKosSiAZ+U25o6qPJb3poJmgJxzxKROdsSQW0HtzF5OauLGZYv71+c0kFZIF4ClQ8x0hIK/zJxRq6Y3dCQiScEPb0FZqDjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=wLOvg5Qu; arc=none smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="wLOvg5Qu"
Received: by mail-pz2-f42.google.com with SMTP id d2e1a72fcca58-86efece610cso1110374b3a.0
        for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 17:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789778205; x=1790383005; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=re+BDEbV10G80IR4SJ9J6eVXDiFOVybjLhZAgTxh9Dc=;
        b=wLOvg5QuqrW1KPpwniHvQys97Vt6X6zm6bg++hz/k/ybx86f2m9u9ty2rgey7THjDm
         yaq3mkLEx44fC6kFaoDlMLajGCJj4poFRcV5DwruEKtnARqDMvxOXfuPgkNFCmSqMIgs
         ukn7JNnswsMcFCx4SbNVdQj52DdTUs68HpyrdBOT/MGWGvoYCDzIxyiEqpYDTgOl/uvk
         eYvCWOWG2Mm9EgVcoiuQ8b9T2CSmu8IjjzFDdn+AvAv2loq4ruXwTH35pyFg9IHE7bdW
         Tr8SEFAPFdBCd8Bv2aICxI6k4Z8Qyr7+XL3lQRdmlVJfSNeq8s7GCfo9kunrV0xiSW8I
         fJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789778205; x=1790383005;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=re+BDEbV10G80IR4SJ9J6eVXDiFOVybjLhZAgTxh9Dc=;
        b=C6zC/r5M1SNeLwkL7/E6bCXV4cJDu/FNBDFA62CjPsFwF64oSQJUVNf7iNo9v1Kl4h
         eHLS9/V4USRUvpusYFK1lQRxjJ/BK4z7/nR0Znk3QNjTbZPTSho+JuDBITlHGuIsJ4W1
         kuQpzv23psDB3JCCa+7v7BUVxnymN5AVVLtvmDAkFfqTBuN6hePG68rbzRCXZ6d6z8BL
         eV/pZHeFDyWSBxZer7d6biZ18AxS1D7zc6uiAJPo/BVQng0Gxl9JpsiAYRU0lxGMCx/A
         Avp3ONyMSS8qCYIsT3e3Jq5fGRXPWkiWJPQihrbl1W8hettfm1u2/X3hQO25nQXrwX4a
         A6OA==
X-Forwarded-Encrypted: i=1; AKwUvBxyHA1Jjel5erKpSpGw3Vt3E/1j3m5UW8suDiTvtNi2kClR6QDJzHTpxaUK7JuGnUrGKWI=@lists.linux.dev
X-Gm-Message-State: AFuF++nF+1gzUUycqd6TFum6GDVy4U/oisLnmjpNw86uUNJqLW1LIUJC
	Xd3aH4yR6bh5EvXkFOrynIUBRhTIWALmnEoNAnh4SHrHq0POZ9IC8LPctJ+LWKdA8PM=
X-Gm-Gg: AYBFou1Qc60GzsH1vA2UevxfsWo3+YHP2N6bXCGjh2GcsUlHnUl2LDIY0KEhD1Ftm00
	mR/advWorh69b2SVk2hbo2NAy+OHJv2S9SAGJmYoQBcSMLFKAD+FHFc+Y4Z7XbKUJEh2MZyAXx7
	cqIj7f4zl6RbPGPcRHyzolDoML2OtybQGBGHm+/Xb1xHBOOGyfO8uIteqKNM3ejBmutZVpIb/dZ
	F+MrxHDqS0M/HhuOcwjK/7MkUIcrPnQy2FbHCDPz53iszEip/khn0Ql0kttb1Yb/ORYJhJyhFDO
	0hsztpSaNRP0SrseUeJngeGmiuqcPq6kBKHwRYa0NXT/yYqvRA/gnPG+z+4/LdUfsuhsjnfY2LI
	dYIUy1/PWzfKt5BK5JFWgB7TAJNCljsbncPKVErRlIUXH0Jjx+QuDfIJslHPHHj+V4FRWOxtFDO
	O+zddruCPA6hYnWnFZZEuxH1W+FnYejCu0jKtsnKWwFGsPy75LcqJc
X-Received: by 2002:a05:6a00:44cc:b0:874:708d:b634 with SMTP id d2e1a72fcca58-874df300c71mr8701591b3a.32.1789778204975;
        Fri, 18 Sep 2026 17:36:44 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a6ae7d71sm403389b3a.2.2026.09.18.17.36.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:36:44 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:36:43 -0700
From: Joe Damato <joe@dama.to>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 01/10] NTB: ntb_transport: Order RX
 descriptor reads after completion
Message-ID: <aq3ZG222WqEDp1Je@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-2-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-2-den@valinux.co.jp>

On Mon, Sep 14, 2026 at 05:48:29PM +0900, Koichiro Den wrote:
> The peer writes payloads and descriptors into a DMA-coherent memory
> window. ntb_process_rxc() checks DESC_DONE_FLAG before consuming the
> descriptor and payload, but coherent memory alone does not order those
> reads on weakly ordered CPUs.
> 
> Read the completion word once and issue dma_rmb() after DONE is observed.
> Use the saved word for subsequent transport flag checks.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5..74f4f8c1c7be 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1609,21 +1609,25 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  {
>  	struct ntb_payload_header *hdr;
>  	struct ntb_queue_entry *entry;
> +	unsigned int flags;
>  	void *offset;
>  
>  	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
>  	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
>  
> -	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> -		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
> -
> -	if (!(hdr->flags & DESC_DONE_FLAG)) {
> +	flags = READ_ONCE(hdr->flags);
> +	if (!(flags & DESC_DONE_FLAG)) {
>  		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");

I get why the dev_dbg line above was moved down, but i feel like if this case
is hit, you lose some of the debugability that the debug line intended?

idk maybe this dev_dbg should be something like

dev_dbg(blah->dev, "qp %d: done flag not set, flags %x\n", qp->qp_num, flags)

so that some of the debuggability is still preserved when this case is hit ?

>  		qp->rx_ring_empty++;
>  		return -EAGAIN;
>  	}
>  
> -	if (hdr->flags & LINK_DOWN_FLAG) {
> +	dma_rmb();
> +
> +	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> +		qp->qp_num, hdr->ver, hdr->len, flags);

I guess the above is a nit, so 

Reviewed-by: Joe Damato <joe@dama.to>
