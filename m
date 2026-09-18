Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184094349BF;
	Fri, 18 Sep 2026 18:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755368; cv=none; b=t2RzQtgAgODwTe46WAz01ooRWnlbik1IqgQNE3fTkbTPWabgBtG1zi2sSqwxbkNR3PkzububIBahJYb7eUk4tKZKXvfe/pbu/ZoBNyBwBs5WxjQhcbWdVQsb6H9NthsY5oGQSbUc8r1tZ3uC/3e6J3qgy6cK6iUQGtGDoZCLzCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755368; c=relaxed/simple;
	bh=BKRNCIzv61UEQjisfXTkjoIA40eOmPYQ+44Nnat9fVk=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Qwlp6e4tIrkdCqdTRe81u/CjJ9uxuTxUlGTgFZxkx3qrEnkkWQ2k4LYQ3KldNXllXeJCvJ+Kex9znhQC3dNeBMm/22+MqiM7e9roOHRb3gGeUWMxl+GGDnzjUiTjg0Ql6RWQJosgPyQg3fQkqXlTKUzSLt5nfIXJ7C6+eaqWBPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=ap8HtKOC; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="ap8HtKOC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=l0UqZc6zTcxbAk8O7Zye1NDSa2Do2uZGuk+w65hW3Us=; b=ap8HtKOCgRQ48d78pNhvpxcS7k
	97g+Z7D8z7++2nuO4SQ2cfLfvVIS4FtL6LkPDWROwzjTgk7fVJknQ7JNcwOO0qeF5TcWOIVdGUX6f
	U5k8DqgrJS7E1oy0MFMKLz0we5fClJWHaZJ2LCY4kkQ7qpgm7fxM025k846muBfsQfIJ5WNSz+SuP
	KCNErPSOSFhxrVwWBjp3fCQ0Z6LcdQ7S4X/qxhfJi+Ozx2hxotLVhn9EdTMoTCKzb2KSH0s52moph
	M9M6EcAAnBxAUeLigrxWF2O42FLuNXfHLh76cdAIhkkBOEHiN8PcHDvjsQIbZqFU6yu5E1YJjNsc2
	O5yBLXhw==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7d80-0000000CrBQ-2t7J;
	Fri, 18 Sep 2026 12:16:05 -0600
Message-ID: <6a24a80b-b88d-409d-b93d-1f7e0d0c904c@deltatee.com>
Date: Fri, 18 Sep 2026 12:16:02 -0600
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
 <20260910040836.3792333-13-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-13-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 12/14] NTB: ntb_transport: Clear QP pointers when
 freeing an MW
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
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

Makes sense to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
