Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2424A64C9
	for <ntb@lists.linux.dev>; Thu, 24 Sep 2026 15:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790265374; cv=none; b=Skxh/quBdSVWFfdqQGAcWo9rMGLAkxb1Sd2Qq3nCSrPpuQu5T34OlkSGeANpIWN8dXU3+NbbGAIBY37cl0xSnq2xiQPCjOi4NB2aOB5UUjNDsmChRCXmNQyTCrGtzQWJd3dVEVBL2kGYgu4WPDXFVM8fTEptPXJSzgtXNpVDuI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790265374; c=relaxed/simple;
	bh=sqSjv1jtFC/fKem3pWuWpi74ihvJ8i8C+gG3QvxJGW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XD9uh8Kf4vQNg0wO6twBkURZ6BmjnGApGafRBpxDyW+Pjg62/kwCYu/Lyk7yC2lD0a1Nixm/prSoIMDSlOLWiyWTX+R3gvjB2Ir6VbenbOAG9+Dm3qAFPe9ggcBEOToOlVmJwsdRZV7bYIsNVoO4ryOfguTT6JgXIbUkLio5TJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SP8jxg6w; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SP8jxg6w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790265373; x=1821801373;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sqSjv1jtFC/fKem3pWuWpi74ihvJ8i8C+gG3QvxJGW8=;
  b=SP8jxg6wG5jOHLMe9kuJpgcPe4YG0pMMgawz6MCzKx1ZuN35jIbMp8AG
   IN/sFKr9i4EIBiTnyasS6PXsnWZj/zjHVtPpFJ0WCP1gz64s3KB0Z/Uzg
   JsWu+xOWe7CfGGqvu3ZJC5w16LRhjjm2WLJos7xlvos5Emlx7VDf/bkCq
   41zELM2ks7Ll+PFJfzsXaOzYyW9mXI62AiyoCb/Iy7J0mDaG2Y2QlbEx5
   C5ympqZS9wNlrLpuLWZENQwnpn6ssLUxTAjRJrz9zR2+eb1U0WWhMYwef
   Oh6UEsGD0mg7JguBaaAe2sNgOEcltzpX33HO5XJVqOqDCPuafnXzBR03F
   Q==;
X-CSE-ConnectionGUID: TZWsB5WvQUunq3FvY0h39g==
X-CSE-MsgGUID: e5V33WLCRiusuTW9r/1Pow==
X-IronPort-AV: E=McAfee;i="6800,10657,11915"; a="91061817"
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="91061817"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:56:12 -0700
X-CSE-ConnectionGUID: 2mqJb/YxQBWFCOKS6NKmNg==
X-CSE-MsgGUID: 6rP4VIe4Sp2t7lGyxJuyhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,120,1787036400"; 
   d="scan'208";a="278802939"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.110.186]) ([10.125.110.186])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2026 08:56:11 -0700
Message-ID: <11a47b77-b140-46df-bee6-3484e18ad62e@intel.com>
Date: Thu, 24 Sep 2026 08:56:10 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/14] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-12-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910040836.3792333-12-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/9/26 9:08 PM, Koichiro Den wrote:
> The next patch clears remote_rx_info when freeing its MW.
> ntb_transport_tx_free_entry() and debugfs stats reads can run during
> link cleanup, so make them handle a NULL pointer.
> 
> The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
> to prevent compiler-induced tearing, and retain the read value so
> the NULL check and dereference use the same pointer.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 22 +++++++++++++++++-----
>  1 file changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 7ccba2c04f54..b949f36a4f2d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -489,6 +489,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
>  static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  {
>  	struct ntb_transport_qp *qp = s->private;
> +	struct ntb_rx_info *remote_rx_info;
>  
>  	if (!qp || !qp->link_is_up)
>  		return 0;
> @@ -516,7 +517,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
>  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
>  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	remote_rx_info = READ_ONCE(qp->remote_rx_info);
> +	if (remote_rx_info)
> +		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);
>  	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
>  	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
>  	seq_putc(s, '\n');
> @@ -611,7 +614,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
>  	rx_size -= sizeof(struct ntb_rx_info);
>  
> -	qp->remote_rx_info = qp->rx_buff + rx_size;
> +	WRITE_ONCE(qp->remote_rx_info, qp->rx_buff + rx_size);
>  
>  	/* Due to housekeeping, there must be atleast 2 buffs */
>  	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
> @@ -934,9 +937,12 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
>  
>  static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>  {
> +	struct ntb_rx_info *remote_rx_info;
> +
>  	ntb_qp_link_context_reset(qp);
> -	if (qp->remote_rx_info)
> -		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> +	remote_rx_info = READ_ONCE(qp->remote_rx_info);
> +	if (remote_rx_info)
> +		remote_rx_info->entry = qp->rx_max_entry - 1;
>  }
>  
>  static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
> @@ -2558,8 +2564,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
>  
>  unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
>  {
> +	struct ntb_rx_info *remote_rx_info = READ_ONCE(qp->remote_rx_info);
>  	unsigned int head = qp->tx_index;
> -	unsigned int tail = qp->remote_rx_info->entry;
> +	unsigned int tail;
> +
> +	if (!remote_rx_info)
> +		return 0;
> +
> +	tail = remote_rx_info->entry;
>  
>  	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
>  }

