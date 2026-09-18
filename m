Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD14D51C07B;
	Fri, 18 Sep 2026 18:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755598; cv=none; b=j82hzo1PHi5bG3UveaVq1vGN/+QKszOgL3ERHJVS6cC7w1RLH8tWy9yY1NB/9rb+x67roLpae5inZfvACroWuKGEvzMc0fYfDJkYFpwNmnCxqkBIxWDsAdUBoHQOzGfZ3BPlN1DA28V+mCMdcicmym5LqM43eMzmv3ert4+EqYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755598; c=relaxed/simple;
	bh=UzJV6MN3ZQqlxiFa7rLww7DFYbcPIzAmo/x3JI8Z/Aw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=fjOCJfWhG1SV3wvR/rTY2CnUCuFjU7l3T00XnA3csimvWlV/Vy/NfV6brFTWel3AHadVmynP2AsCbAgssq1VeojkWGKCJ9xe/8hET+IRZ1/1tjRh9825w3bzj4NI5n7l/s0XTWOyEBc7It+nvLRduDsXlFRTKUjjqgk46X6lloU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ha5x21tZ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ha5x21tZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=I7P/ywqua5y0GmUytlh1b1pksB/QDX+370dgfblA6P4=; b=ha5x21tZ4zAS8KjxBsC1HHLB6P
	Gpy4K8ui9+DIEMOL6JCFJCHmTWVW1d68rPZk2zYeMmVF5iGvW1tCyCjKSY0Mr51mYi9gPyOWGdOZ+
	1wQl+Fbon0xT3TafHbWUM4GpJhAaeUPCanyMPikzMcyMWsVwoT6rxye1Pr58uJhAkzyRmJ5c1WgEz
	Nr4Y9m4BcYbm5WGfcj/zbs/ZLXEbqItMeJE/HW6rI7w0Zyzsm1Dv5qGbhbYz0rGbjNZwxxoZ0PrNs
	en0yAzf4oyW0llM9KlKZMcgQG6eXVo/l//oyVGiUz0tl70rXd0omTHfwGpDdGLlQPEQ2X7XVxp6A0
	+JMiLnoQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7dBi-0000000CrCj-0fBi;
	Fri, 18 Sep 2026 12:19:54 -0600
Message-ID: <4e6c29d0-8fa8-4ea0-9672-ac78760374d8@deltatee.com>
Date: Fri, 18 Sep 2026 12:19:52 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-15-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-15-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before
 freeing transport resources
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
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

Looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
