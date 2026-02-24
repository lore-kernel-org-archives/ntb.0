Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6EB23AB87
	for <ntb@lists.linux.dev>; Tue, 24 Feb 2026 14:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771944144; cv=none; b=cC36sHbXQ9ZXzQHv/5DaBIo6e/949F4+wYZU7a46LVIQDQFT55/aqA8MuOLv/2lSvijWCTJ5TDEVOio5oKnukOfcNGvTwMAtargNwVBSA3rahj2iGVMgcgzS5Ih4fr0psMCT3GzRRb2bA5c2NY6HprCuhuDgIpMqVw1dOfJbQgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771944144; c=relaxed/simple;
	bh=5ZNIZoIJym+AaiB5vhhF5rYP9sCgmaJ6czhporeCOVk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YHyIZp2z6jPM4gj/qwlU+XkvDCRv7RAMEnNjsONLhgFZtxmpV4YMWogu9p4c+ZwMWVNLmqNe9y2e4J4VqgKlWAxlaZaR81iWpT6pVWeodlMeFoJSlw09sL5lZYEVN8zufHwYga5tvKsTjt7pPGiamcz7Gh+UlJiqSF1Iwab2KSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GnR3powK; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GnR3powK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1771944142; x=1803480142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5ZNIZoIJym+AaiB5vhhF5rYP9sCgmaJ6czhporeCOVk=;
  b=GnR3powKfQHYZLWUu+N3mATZZMmVKysMwtAK5i30CstVVZ1ZUXrYaccH
   yagS/jnxgQABCI90z4TjH9CC6aTcORrA2bOS94vkFFZydgJS8yoU91XJZ
   4ghqv5IbRg7P4jlIq29dfrDmx/IKWpiOucWHX9r3prAMwymlyEU201j/w
   ydSjRdpMmlDTWerzod9ndUu6f/PMmwXXCxrLTYfarhTHwvo3jxI3EcJWb
   TUQj+EZ8rni/vzSiJnxdykneyHePXN75BTDoPSceW2jGek0oCfqurH3nV
   IuOCYlyFjTwqMucnprljvUL57pfWW67cEff0AWdwWlGYsjbDu2NgI8Ea0
   Q==;
X-CSE-ConnectionGUID: 1JvgMQZCTny4z7nNAF35gA==
X-CSE-MsgGUID: /DFvAwa1Rb2Xqt6UH6kpjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11711"; a="76821450"
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="76821450"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:42:21 -0800
X-CSE-ConnectionGUID: ZJUn7VEURY6APU6E/zr+vg==
X-CSE-MsgGUID: WSZ2pWV5SyWiQdtr0gwnNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,308,1763452800"; 
   d="scan'208";a="220507571"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.111.19]) ([10.125.111.19])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2026 06:42:20 -0800
Message-ID: <07904415-19a8-4381-9292-2f0625fd69ca@intel.com>
Date: Tue, 24 Feb 2026 07:42:18 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: ntb_netdev: Fix NULL check ordering in TX
 handler
To: Alok Tiwari <alok.a.tiwari@oracle.com>, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 andrew+netdev@lunn.ch, jdmason@kudzu.us, allenbh@gmail.com,
 ntb@lists.linux.dev, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com
References: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260224130458.1355686-1-alok.a.tiwari@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/26 6:04 AM, Alok Tiwari wrote:
> ntb_netdev_tx_handler() calls netdev_priv(ndev) before checking
> whether ndev is NULL. Although qp_data is expected to always be
> valid in normal operation, dereferencing the pointer before the
> NULL check is logically incorrect.
> 
> Move netdev_priv() after validating ndev.
> 
> No functional change intended.
> 
> Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ntb_netdev.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index fbeae05817e9..6792b3b1f253 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -177,13 +177,15 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
>  				  void *data, int len)
>  {
>  	struct net_device *ndev = qp_data;
> +	struct ntb_netdev *dev;
>  	struct sk_buff *skb;
> -	struct ntb_netdev *dev = netdev_priv(ndev);
>  
>  	skb = data;
>  	if (!skb || !ndev)
>  		return;
>  
> +	dev = netdev_priv(ndev);
> +
>  	if (len > 0) {
>  		ndev->stats.tx_packets++;
>  		ndev->stats.tx_bytes += skb->len;

