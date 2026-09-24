Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFBC4A8432
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265601; cv=none; b=FTHfCdi2CSKu/NeREKNbrg44UFa34oMzQZzgu2Atg/SMP68ROCLqOgMSuPYgsh5jsVAuNZAXRUODqa5bBKGkh8WYj/cIBlQrVFv+WdwEG2kqWJg4CgdVqZm8b1zNc3NmjpHuL4Evaa2MaYW3yCSS9NEnufNqpuqAQRFjbqkdqXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265601; c=relaxed/simple;
	bh=Np5u7jfQJ2J3heMRPJOtrJQLifA9bnQekYmEyIc//do=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Eo2dBiinAp+PACtUOaAITYn3sBjaI60oErW/jhLRd8PvGHfstHdOsyf+QZwM2rg8oGCUe1i3W9A0UYRB+qlNqB2gtBU1yIigUhkbOjZz7ve6hfOJXMmpYQUGGq7ySOOfh8ZYUMTqD2482cfttDGhtnczaIpMOMF/FIdcR6vld6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nNNwK8v3; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nNNwK8v3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265599; x=1821801599;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Np5u7jfQJ2J3heMRPJOtrJQLifA9bnQekYmEyIc//do=;
  b=nNNwK8v3g1UPJjoOaXRPF2v5bZQH4+qGuFls81aWXK8gIySDfo3L/tNX
   aI4SFW/oZVckNxdYKohXaYCMyK/qHpqUBVT1BVnBy5CVLxaoVxlPn2xrp
   fuID9IyRm4T94SdrDd++gxc98K8ao+lxeJknniyFjHLk8tCLf4JogqsA9
   9hHg5U6IeICeTucXkwHfzdKYP+azKchbvbt5gXG7vaYP7iMAvPmzGB/oy
   Wm19BQxSpnllRPDWRnXtVC71b8yQf8qUfhyLz1Jf+ZmbAEae54Q1eCsaN
   br34zcaXVeKgAj14h3RRMshndf+KPpK5qXApak20SalRHDm4ZnsaXwpQn
   w==;
X-CSE-ConnectionGUID: /pR+UXn2SVyqdaseWNHPAQ==
X-CSE-MsgGUID: uKHbmqOhSsSaDAZixfPHww==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="112825184"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="112825184"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:59:58 -0700
X-CSE-ConnectionGUID: vY14jFNVQhmjp/MpIosyWQ==
X-CSE-MsgGUID: OzZ73iThRQWs7kjwGbhRFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="273179932"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:59:58 -0700
Message-ID: <f1da1904-a05c-4fe0-95a2-9abdc44bfebe@intel.com>
Date: Thu, 24 Sep 2026 08:59:56 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] NTB: ntb_transport: Clear QP pointers when
 freeing an MW
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-13-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-13-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> ntb_transport_link_cleanup() frees MW buffers but leaves rx_buff and
> remote_rx_info pointing into them. With a QP still allocated, another
> link-down notification or transport unbind before MW setup runs again
> can make ntb_qp_link_down_reset() write to freed memory through
> remote_rx_info.
> 
> Clear both pointers in ntb_free_mw() for all QPs using that MW,
> including those without a client. This also covers link-setup failures.
> 
> How to reproduce:
> 
>   1. Load ntb_transport and ntb_netdev on both sides and establish the
>      transport/QP links once. Stop traffic, but leave ntb_netdev loaded
>      on VHOST so its QPs remain allocated throughout the test.
> 
>   2. On HOST, unload ntb_netdev and ntb_transport, leaving ntb_hw_epf
>      bound:
> 
>      modprobe -r ntb_netdev ntb_transport
> 
>      Transport removal sends COMMAND_LINK_DOWN to VHOST. Wait for
>      ntb_transport_link_cleanup_work() to return on VHOST, using a
>      function-graph trace. The "Link Cleanup" message is printed before
>      MW release and is not sufficient to establish completion. Do not
>      bring the link back up before the next step.
> 
>   3-(A). UAF via repeated link-down notification
> 
>      Use ntb_tool on HOST to send another link-down request:
> 
>      HOST# modprobe ntb_tool
>      HOST# echo N > "/sys/kernel/debug/ntb_tool/$ntb_host_dev/link"
> 
>      ==================================================================
>      BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
>      ...
>      Call trace:
>       ...
>       __asan_report_store4_noabort+0x1c/0x28
>       ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
>       ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
>       ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
>       ntb_transport_link_cleanup_work+0x2c/0x50 [ntb_transport]
>       process_one_work+0x5b8/0x12f0
>       ...
> 
>   3-(B). UAF via transport removal after link-down
> 
>      VHOST# echo "$ntb_vhost_dev" > \
>          /sys/bus/ntb/drivers/ntb_transport/unbind
> 
>      ==================================================================
>      BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
>      ...
>      Call trace:
>       ...
>       __asan_report_store4_noabort+0x1c/0x28
>       ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
>       ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
>       ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
>       ntb_transport_free+0x68/0x588 [ntb_transport]
>       ntb_remove+0x5c/0xa0 [ntb]
> 
> Verified that neither test triggers a KASAN report with this patch.
> 
> Fixes: cc79bd2738c2 ("ntb: Clean up tx tail index on link down")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I would move the full reproduce details under ---

> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index b949f36a4f2d..096be87e5ede 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -781,10 +781,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
>  {
>  	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
>  	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
> +	unsigned int i;
>  
>  	if (!mw->virt_addr)
>  		return;
>  
> +	/* Drop references from every QP using this MW. */
> +	for (i = num_mw; i < nt->qp_count; i += nt->mw_count) {
> +		nt->qp_vec[i].rx_buff = NULL;
> +		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
> +	}
> +
>  	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
>  	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
>  		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);

