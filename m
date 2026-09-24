Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506CD4A4F1C
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265296; cv=none; b=riXDb9kRc7S5kCULhaqBrvQ9TY5Bhs29ivtKZrSyo8Ace5bOze8tO0tegVKVQ1tYmAjW9sonGtz143daW5gXvEohAyx5x97RinODnDM273KKnljbWzqGip3VOPjO8mApgR9O9FHYlhVcJ7J1FC8o/YdM6NCl6jzQIO+3UCtohmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265296; c=relaxed/simple;
	bh=pXJFGlYgsCd2k8mKhNQi6G3BY0M0WKNW5AN74Glm3EQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Liw9l+TI25V+EsTriohVKOASuJ3qjFD0Q4OIYXSHBr9cTopoMwO6XOPvPC9ldv4zLK68jnbvjViuSxbkTUGEK7Vc89yYWktXksvzZowqtcoMZt6f5WuIGxK1eqztMkqgvuGZCTrwcdmCrqZuIAZNLvoEDX9KWSF85RSd9nOOER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hBUwyRtt; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hBUwyRtt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265295; x=1821801295;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pXJFGlYgsCd2k8mKhNQi6G3BY0M0WKNW5AN74Glm3EQ=;
  b=hBUwyRtt3kosMlIvSm8GjXyFOTZh//vCodig+pptjs8BR1XLm6UA1yhD
   G7o+uQwWJNN47O2HCHpgFjdz9Ee/4lqLrMrqK8CPdrG55qIa77+aC2UOK
   kYzrl/JbXPbxbRYQRMTkpOFyW1A9aD+mycmuiJSGeRLFfL2Hzc/HWpnIi
   s+lHtpEP8bklmoaIW5xvM4H/K5pfr5+egfo1B2xClsZ/Lo5Wy8DzeDbGt
   ABDQ31R/vJrzQ1ubaaWdWvAJoK6Rs25Zm2E2S/vNjaaPE3eKFoZXiF3QM
   ByxbdTtP14X+a1Msh5jhPC885qugj6XrVGupIhBEGW0D3y5XwBNuyHHka
   w==;
X-CSE-ConnectionGUID: Fg+hBMOXTj+8vx8jahElrg==
X-CSE-MsgGUID: U3voKmnPSeONoSecYhC0hQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="90907018"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="90907018"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:54:54 -0700
X-CSE-ConnectionGUID: U5nVv/qlRCa6z7pOjnVsdg==
X-CSE-MsgGUID: wmc8iIVKQ0iZ3E0sAAjN8g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="303579010"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:54:54 -0700
Message-ID: <380b32d0-f4bf-46e3-b0d2-fc94b6f48e37@intel.com>
Date: Thu, 24 Sep 2026 08:54:53 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] NTB: ntb_transport: Wait for RX completions
 before resetting a QP
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-11-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> Transport link cleanup can free an MW still used by RX DMA or its
> completion path. QP-only cleanup retains the MW, but can restart RX
> on ring slots whose old completion callbacks have not yet cleared
> the headers.
> 
> Wait for rx_post_q to empty before resetting the QP. ntb_complete_rxc()
> finishes its MW accesses before removing each entry under ntb_rx_q_lock,
> so cleanup can free the MW without racing with these RX accesses.
> Using dmaengine_terminate_sync() instead would not work with drivers
> such as IOAT that lack the required ops. Cookie-based waits would
> not work with DMA_COMPLETION_NO_ORDER either.
> 
> DMA teardown in ntb_transport_free_queue() is unchanged.
> 
> Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - New patch (Sashiko).
> 
>  drivers/ntb/ntb_transport.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 36797ea3ff45..7ccba2c04f54 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -949,6 +949,13 @@ static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
>  		schedule_delayed_work(&qp->link_work, delay);
>  }
>  
> +static bool ntb_transport_rx_idle(struct ntb_transport_qp *qp)
> +{
> +	guard(spinlock_irqsave)(&qp->ntb_rx_q_lock);
> +
> +	return list_empty(&qp->rx_post_q);
> +}
> +
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>  {
>  	struct ntb_transport_ctx *nt = qp->transport;
> @@ -959,6 +966,17 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>  	disable_delayed_work_sync(&qp->link_work);
>  	ntb_transport_set_qp_active(qp, false);
>  	tasklet_kill(&qp->rxc_db_work);
> +	/*
> +	 * Some DMA engines lack terminate/synchronize ops (e.g. IOAT), and
> +	 * DMA_COMPLETION_NO_ORDER rules out cookie-based waits.
> +	 *
> +	 * Waiting for rx_post_q to empty suffices: ntb_complete_rxc() finishes
> +	 * its MW accesses before removing each entry under ntb_rx_q_lock.
> +	 * qp->active is false and rxc_db_work is stopped, so no new RX DMA
> +	 * can be submitted.
> +	 */
> +	while (!ntb_transport_rx_idle(qp))
> +		fsleep(1000);
>  
>  	ntb_qp_link_down_reset(qp);
>  

