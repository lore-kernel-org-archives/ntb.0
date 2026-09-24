Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE7449BD93
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265748; cv=none; b=MNszK6Xh24/a5+Gw+gu2GblH2Lql/PF6wvjaLt9IadL2fnArC/+GACpPE4ooT7afSAMVyEy//dQqg7WvbVfb7pT6bLY501ZysHfX1b9vAaFKsFavDz+SbVrHE5M8OROZ4couWy3TmUellHJc+JB0945Zl/TBJb8TOj3DMNn0pVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265748; c=relaxed/simple;
	bh=TXz6OkWKCPgdfur/y51D/Sk3SIxm4t6Rb3OFK4/1Bbg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PoY/ae81jlSAqfx15ncss7N9sN0623f9xuYgV6vTywucaafaft8pTc1mA7xQDXMQqHeMjt3u9reVy5+j/rmPLsQSQnqTZl6KVD/dnO+/rzlTDVW59FiouNi5X5D2ZQY4UzVKwmG508cN9NO3rM5LKWkeEujZnojPsvKY3MFoH5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dIuqkapB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dIuqkapB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265747; x=1821801747;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=TXz6OkWKCPgdfur/y51D/Sk3SIxm4t6Rb3OFK4/1Bbg=;
  b=dIuqkapBJE2tFl0aNGDZ0KQiDT9Y9Cv/tTapU/9N0uQF6USydSXCfy9+
   QoTeXXdy5pOU0790j/iJMiZES9EQ7ArIj/2bqsRLLx0ZLhQ8vYvgTqwHr
   DLPkl3aGLa4Cy7N3iqzc5mez4vBhkgP1vcEa4eDgJcX9BkcRQuV/PnWc5
   B8/QHMsy8dYAwGtz0IMXVhhs3KJSbzMjd5GLOOXv/wL/DVNreMF5UtcGn
   lxU8xudqbv0smgYe0C87+WRi+zYky/mK9pHtM8L1jpacTWSe08qWOTWym
   r01dVWY8pcTJ4ajDH64Qj9BSC+giJrV9tGMTzWPPma9XIhrrIbw2v2Nxc
   A==;
X-CSE-ConnectionGUID: EfXXRTmiSZKbVAyqUj/v7A==
X-CSE-MsgGUID: xHg2v1CiS5GtxYpYrQBUjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="89998942"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="89998942"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:02:26 -0700
X-CSE-ConnectionGUID: w2fUz9t6RR2jXNqazIUL5A==
X-CSE-MsgGUID: EzC0GjcmS6qW8ddq5GwR0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="274252027"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 09:02:24 -0700
Message-ID: <db6d83a0-1ba5-4cab-b652-d239e348942a@intel.com>
Date: Thu, 24 Sep 2026 09:02:22 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-15-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
> is still bound. The transport frees MWs and QP resources before
> unregistering the clients, so the netdev's transmit path and timer can
> access freed memory. Its remove callback also calls
> ntb_transport_free_queue() on a QP whose resources have already been
> released. This teardown order is unsafe and somewhat unintuitive.
> 
> The crash can be reproduced with an intensive TX load, during which you
> unbind the NTB device. The following is a KASAN report from my
> VHOST/HOST setup using vNTB.
> 
>   VHOST# sudo iperf3 -ub0 -c $HOST -l 100 -P 100 &
>   VHOST# echo $VHOST_NTB_DEV > /sys/bus/ntb/drivers/ntb_transport/unbind
> 
>   ==================================================================
>   BUG: KASAN: vmalloc-out-of-bounds in ntb_transport_tx_free_entry+0xf0
>   ...
>   Call trace:
>    ...
>    __asan_report_load4_noabort+0x1c/0x30
>    ntb_transport_tx_free_entry+0xf0/0x130 [ntb_transport]
>    ntb_netdev_tx_timer+0x78/0x260 [ntb_netdev]
>    ...
> 
> Disable and drain transport link work first, then unregister the clients
> so they stop using and release their QPs. After that, free any QPs left
> over before running transport link cleanup. Disabling the work keeps
> link events from restarting setup or cleanup during client removal.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - New patch.
> 
>  drivers/ntb/ntb_transport.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index c1e3a077c45e..f24555b38d1b 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  
>  	debugfs_remove_recursive(nt->debugfs_node_dir);
>  
> -	ntb_transport_link_cleanup(nt);
> -	cancel_work_sync(&nt->link_cleanup);
> -	cancel_delayed_work_sync(&nt->link_work);
> +	/* Stop transport work before clients release their QPs. */
> +	disable_delayed_work_sync(&nt->link_work);
> +	disable_work_sync(&nt->link_cleanup);
> +
> +	ntb_bus_remove(nt);
>  
>  	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
>  
> @@ -1500,11 +1502,10 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
>  			ntb_transport_free_queue(qp);
>  	}
>  
> +	ntb_transport_link_cleanup(nt);
>  	ntb_link_disable(ndev);
>  	ntb_clear_ctx(ndev);
>  
> -	ntb_bus_remove(nt);
> -
>  	for (i = nt->mw_count; i--; ) {
>  		ntb_free_mw(nt, i);
>  		iounmap(nt->mw_vec[i].vbase);

