Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E58477992
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 16:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787157667; cv=none; b=S18IojE7cGWPPMoDyBUNXRDvj2w2vuJViF3qHDiFC2kLV9rOX53OKMFZHfi/xgCOU2PzGeQ/3DX+LVHsAjrGwqh+RH2BoOdshrBNvUqkjCIQNZP2DkaBOGkhYm1fvMuLA3riRDBVB96zuhElD8Igm4+kZJp5QxWoQYVCdkA2d10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787157667; c=relaxed/simple;
	bh=4uoQqXNpHZskqO+5UYKlWoYYALr/ajY5Wh8qGJJ81dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iNrHKK8ViWWexTavt97NsppVNR7LjnDDP+aaJYSYEjWMOGZp1W8YzA9FldPKAiQrk+IYhslG49/Nb3u7QbgE5uoq2IdFqdMcQ4nCmFdEgK4ScsEgKJWIGMQwHmzYBX/UhyIo64fFLl37tzLUqgjY/RNC1AvWDd28bpr73BcjsKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Du37PUGG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Du37PUGG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787157666; x=1818693666;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4uoQqXNpHZskqO+5UYKlWoYYALr/ajY5Wh8qGJJ81dg=;
  b=Du37PUGGAvBhRWHpgPbCZvMGGY7F6kjv1eSl7CHVvLImwD+jIjOdaRKZ
   byWBCF7FhZGh5m0ZVBGeDzkMVEtPm+QEvIw1Lbh1axk5ZGvufYjtZctqP
   F7jSKxiXcQik/BMkglTJ3GqOjK6t6uUsGhp98VZ5s2qYOErAUfYvQ2GKK
   N/qJeaIgqGAc1JX7HM6O0YgEcbWc6mIsIvomogpFnOgpaC38FXvOBjVdy
   b6vy6twAEt3rKc72kzuqa5TtsMXWISpHO+euX+2OWr76OF34s4YH6rpVe
   dPlMNa2aV7atVKrlKPHLdfpTFLPEDS4PzMSCBiI6KbCP02vNBpEMt7UQK
   Q==;
X-CSE-ConnectionGUID: XeBG+SqjS8Kg0FVqPW5PwQ==
X-CSE-MsgGUID: tT/5h3gAS6+HD3NvdXujDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87539775"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87539775"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:41:06 -0700
X-CSE-ConnectionGUID: OH7e2fInSzudER3gw/QKkg==
X-CSE-MsgGUID: +LNiNNfxTz+4j/zpCUeEgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="259449713"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:41:03 -0700
Message-ID: <37ccbe71-10f9-47e2-8426-5efa8b39dd02@intel.com>
Date: Wed, 19 Aug 2026 09:41:02 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/4] NTB: ntb_transport: Order RX descriptor
 reads after completion
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-2-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817064916.13278-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 11:49 PM, Koichiro Den wrote:
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
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - New patch. (Sashiko)
> 
>  drivers/ntb/ntb_transport.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfa..d458a8b1de11 100644
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
>  		qp->rx_ring_empty++;
>  		return -EAGAIN;
>  	}
>  
> -	if (hdr->flags & LINK_DOWN_FLAG) {
> +	dma_rmb();
> +
> +	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> +		qp->qp_num, hdr->ver, hdr->len, flags);
> +
> +	if (flags & LINK_DOWN_FLAG) {
>  		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
>  		ntb_qp_link_down(qp);
>  		hdr->flags = 0;

