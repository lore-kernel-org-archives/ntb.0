Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97EB5481235
	for <ntb@lists.linux.dev>; Thu,  6 Aug 2026 16:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786032823; cv=none; b=JnIxUB4Ks8mwsAelGD1MdZPn/s9n9bea/Ep6TkL5vCkl15zd4WWnAfGiczUGOf6mhxUxDf0MrkKcYvg252yTOrDzVg9e0r8ueflrT08joJNRopXo9dKJLEb8a43kEvatMvKdaPnRAxPERxrR2GplDo3w6Axv+tjC8jKTfBsoAF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786032823; c=relaxed/simple;
	bh=G4Jf55pJTnxM+8U6Ce5+pMWPcNCfyJQmy8zPH8oPSsg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=quNNWsDb0GltErdnh5zAjAA0eW9IThK9MtxAiKos9SQRpQxuGvp+1wFdliVOsXitgyF9Pvoy+h67hU//HItweEn6g7bL8q/v+2NEKqYggRM+nZIU3bzyqBnk3KZ4RwohnB/tfTXgNn7PZxqKG9flhN0azi/GxWSxMUl45FAJWBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fjwo4fga; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fjwo4fga"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786032821; x=1817568821;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G4Jf55pJTnxM+8U6Ce5+pMWPcNCfyJQmy8zPH8oPSsg=;
  b=Fjwo4fgaJb2/Munv4yDybUxYWi3SUzRTIqyrTNCg9cY8VsHgGciYJri9
   y0INAn0tJA/U/rhycpdHBrZSx5sLeE+rHe8ERGBGrvQrMMaBkag7LRNGu
   CZlceArrXpKsNpZcKjejS5o9564rXF5k1hNbiI/XvyPG8z3DOfkVGE8IS
   UvyhrgwqmvMFUtFIaTrfe6jpnfIAQ18tXHCT3fRs593HRPz6evYsVBviz
   K9SXrnQ345okWs7P+cc4iA8mZLJnYRzyecO0MP/rGV6QJoUoxO2kP073L
   s7eECaiMaAWdGhRX6qZR6sZ765zX4QG4xP9SVOunnVTlTE4RpKBeJ7xzV
   w==;
X-CSE-ConnectionGUID: QRT+HT/wTyaJZDvCuEu/LA==
X-CSE-MsgGUID: MwX29JF/RXOEZIkVLX0DgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="85755462"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="85755462"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:13:41 -0700
X-CSE-ConnectionGUID: 7gdadwCoQFCVgY8JraL4Ow==
X-CSE-MsgGUID: MNCGFfyRSJitnBkEYdFdbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
   d="scan'208";a="261625052"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.117]) ([10.125.109.117])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 09:13:40 -0700
Message-ID: <8fff7c7b-726a-4d9b-b950-6968d07f54ca@intel.com>
Date: Thu, 6 Aug 2026 09:13:38 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] NTB: ntb_netdev: Preserve RX queue depth on
 allocation failure
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260806032537.3526498-1-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260806032537.3526498-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/5/26 8:25 PM, Koichiro Den wrote:
> ntb_netdev_rx_handler() hands the received skb to the network stack
> before allocating its replacement. If the allocation fails, nothing is
> reposted. Every failure therefore takes one buffer out of the RX queue
> while the interface remains up, and enough failures eventually stall
> reception.
> 
> A retry path could refill the queue later, but ntb_netdev has none.
> Allocate the replacement first instead. If that fails, drop the packet
> and repost the same skb. This keeps the queue full and lets packet
> delivery resume as soon as memory is available again.
> 
> Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index c3a6ba96fc8a..029a4a532a10 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -127,8 +127,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  {
>  	struct ntb_netdev_queue *q = qp_data;
>  	struct ntb_netdev *dev = q->ntdev;
> +	struct sk_buff *skb, *new_skb;
>  	struct net_device *ndev;
> -	struct sk_buff *skb;
>  	int rc;
>  
>  	ndev = dev->ndev;
> @@ -144,6 +144,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  		goto enqueue_again;
>  	}
>  
> +	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
> +	if (!new_skb) {
> +		ndev->stats.rx_dropped++;
> +		goto enqueue_again;
> +	}
> +
>  	skb_put(skb, len);
>  	skb->protocol = eth_type_trans(skb, ndev);
>  	skb->ip_summed = CHECKSUM_NONE;
> @@ -157,12 +163,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  		ndev->stats.rx_bytes += len;
>  	}
>  
> -	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
> -	if (!skb) {
> -		ndev->stats.rx_errors++;
> -		ndev->stats.rx_frame_errors++;
> -		return;
> -	}
> +	skb = new_skb;
>  
>  enqueue_again:
>  	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);

