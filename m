Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B5A48AE17
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 16:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158363; cv=none; b=ncCdNi4Ev1HmFELjimLGuEPIlpvXJOPnThpCBTDBnc+imPZhgotVEg7rCjWmjZRKXBAMUNJYAISVze1hcHDhAvCWkhBGQfYw8BgzoFducW1zsS78p9ndTGxdLqO58KBP9JYnXu9HH4rpUiRlEqRKe6PyLltKPjJGsg1DU2w6gBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158363; c=relaxed/simple;
	bh=Cg0yzG3Q+Zzxxvlle6S+x35bJtJ5CU1APBSrbMNjjKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=efNdXcdpWObH/iCa2u3P7BRSou6WP0cgQxE3SqQmm4KhfP4b0jYZJI17+SE2f50u7KRRN6sv/WhVv1/GgfWtf0YUzdm+RaMCi76I6FMLqHg9oJLVdM3c5VWuO7o+85uslehoETEcjVQTKqVM9Ag4Ib81C9i8hB+uTmo6NE3MQD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dj36w9yY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dj36w9yY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787158361; x=1818694361;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Cg0yzG3Q+Zzxxvlle6S+x35bJtJ5CU1APBSrbMNjjKQ=;
  b=dj36w9yYXuJGshegvWrlHv3qwADhDzbzaQ9uRIDgigyl9i8agHTo1gnz
   B+mhdJs99F3BafsCpA4d4vcIDsTo3VnFbPFlVYUrzxWf+hWTcseOxU7Aw
   F1KPuoxGI3a2nm900z8MEC1SxvfFEv0UtXIGmnrGKE35RQC/NVh7p4gs0
   WUveNvRUFQMVLo/DUvhJNQc5DpAoHz3j/jyBB21gWAYGLWHmNcDo3XBL1
   9U29bGSjiGccG1e100HRmOR0q0U9PyO7L3FjslZtzAv9skABmh41ah/PH
   T9BOcP+r1iiAsMEYAIT4/OMpqjcKhwLKvmFXf56Ur8blxo404GK/Lzoce
   g==;
X-CSE-ConnectionGUID: s2oP7BOoQumZwdUw7c8OCQ==
X-CSE-MsgGUID: NctD792TSM2YpzR9h8sbjA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87705543"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87705543"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:52:40 -0700
X-CSE-ConnectionGUID: S4sEUS/ITomOeSdkSU5tKw==
X-CSE-MsgGUID: p+aaaeP0Tw+WPhR9Bdl4NA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303817977"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:52:38 -0700
Message-ID: <822fd9da-fe62-4a99-a111-328f2c9e5f7b@intel.com>
Date: Wed, 19 Aug 2026 09:52:38 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/4] NTB: ntb_transport: Use little-endian
 shared fields
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-3-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817064916.13278-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 11:49 PM, Koichiro Den wrote:
> ntb_transport writes payload headers and the RX ring tail with
> iowrite32(), but reads peer-written copies from coherent memory as native
> integers. The values are therefore byte-swapped when read on a big-endian
> system.
> 
> Mark the shared fields as __le32 and convert coherent-memory accesses
> accordingly.
> 
> Fixes: 74465645cdb4 ("NTB: Fix Sparse Warnings")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - New patch. (Sashiko)
> 
>  drivers/ntb/ntb_transport.c | 47 +++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index d458a8b1de11..967a5ad38164 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -132,7 +132,7 @@ struct ntb_queue_entry {
>  };
>  
>  struct ntb_rx_info {
> -	unsigned int entry;
> +	__le32 entry;
>  };
>  
>  struct ntb_transport_qp {
> @@ -265,9 +265,9 @@ enum {
>  };
>  
>  struct ntb_payload_header {
> -	unsigned int ver;
> -	unsigned int len;
> -	unsigned int flags;
> +	__le32 ver;
> +	__le32 len;
> +	__le32 flags;
>  };
>  
>  enum {
> @@ -514,7 +514,8 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
>  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
>  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	seq_printf(s, "RRI (T) - \t%u\n",
> +		   le32_to_cpu(qp->remote_rx_info->entry));
>  	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
>  	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
>  	seq_putc(s, '\n');
> @@ -633,7 +634,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  		qp->rx_alloc_entry++;
>  	}
>  
> -	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> +	qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
>  
>  	/* setup the hdr offsets with 0's */
>  	for (i = 0; i < qp->rx_max_entry; i++) {
> @@ -919,7 +920,7 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>  {
>  	ntb_qp_link_context_reset(qp);
>  	if (qp->remote_rx_info)
> -		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> +		qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
>  }
>  
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> @@ -1445,7 +1446,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  		if (!(entry->flags & DESC_DONE_FLAG))
>  			break;
>  
> -		entry->rx_hdr->flags = 0;
> +		entry->rx_hdr->flags = cpu_to_le32(0);
>  		iowrite32(entry->rx_index, &qp->rx_info->entry);
>  
>  		cb_data = entry->cb_data;
> @@ -1609,13 +1610,15 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  {
>  	struct ntb_payload_header *hdr;
>  	struct ntb_queue_entry *entry;
> -	unsigned int flags;
>  	void *offset;
> +	u32 flags;
> +	u32 len;
> +	u32 ver;
>  
>  	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
>  	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
>  
> -	flags = READ_ONCE(hdr->flags);
> +	flags = le32_to_cpu(READ_ONCE(hdr->flags));
>  	if (!(flags & DESC_DONE_FLAG)) {
>  		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
>  		qp->rx_ring_empty++;
> @@ -1623,21 +1626,23 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  	}
>  
>  	dma_rmb();
> +	ver = le32_to_cpu(hdr->ver);
> +	len = le32_to_cpu(hdr->len);
>  
>  	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
> -		qp->qp_num, hdr->ver, hdr->len, flags);
> +		qp->qp_num, ver, len, flags);
>  
>  	if (flags & LINK_DOWN_FLAG) {
>  		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
>  		ntb_qp_link_down(qp);
> -		hdr->flags = 0;
> +		hdr->flags = cpu_to_le32(0);
>  		return -EAGAIN;
>  	}
>  
> -	if (hdr->ver != (u32)qp->rx_pkts) {
> +	if (ver != (u32)qp->rx_pkts) {
>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"version mismatch, expected %llu - got %u\n",
> -			qp->rx_pkts, hdr->ver);
> +			qp->rx_pkts, ver);
>  		qp->rx_err_ver++;
>  		return -EIO;
>  	}
> @@ -1652,10 +1657,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  	entry->rx_hdr = hdr;
>  	entry->rx_index = qp->rx_index;
>  
> -	if (hdr->len > entry->len) {
> +	if (len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"receive buffer overflow! Wanted %d got %d\n",
> -			hdr->len, entry->len);
> +			len, entry->len);
>  		qp->rx_err_oflow++;
>  
>  		entry->len = -EIO;
> @@ -1665,12 +1670,12 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  	} else {
>  		dev_dbg(&qp->ndev->pdev->dev,
>  			"RX OK index %u ver %u size %d into buf size %d\n",
> -			qp->rx_index, hdr->ver, hdr->len, entry->len);
> +			qp->rx_index, ver, len, entry->len);
>  
> -		qp->rx_bytes += hdr->len;
> +		qp->rx_bytes += len;
>  		qp->rx_pkts++;
>  
> -		entry->len = hdr->len;
> +		entry->len = len;
>  
>  		ntb_async_rx(entry, offset);
>  	}
> @@ -2492,7 +2497,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
>  unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
>  {
>  	unsigned int head = qp->tx_index;
> -	unsigned int tail = qp->remote_rx_info->entry;
> +	unsigned int tail;
> +
> +	tail = le32_to_cpu(READ_ONCE(qp->remote_rx_info->entry));
>  
>  	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
>  }

