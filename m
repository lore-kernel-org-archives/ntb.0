Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC90261B83
	for <ntb@lists.linux.dev>; Tue,  6 Jan 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767717431; cv=none; b=Lk8UWwPaIJ9CdD3qtMBM+Qp0BUl8WgDfxGF/Vn/IU1vN0VydmwWDh7O8fx1nQFyCB2PpYgqPgLh/I+P4daV73+321Ysf+SkaeVgrV+k2QwkgRPcvAUt/HrtIsJW/DtDafKgRZDNEPa5P+E7a4KuL7TtqCHAQS6RCJ0PItEOwIys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767717431; c=relaxed/simple;
	bh=V1ZZwM0U2HYiYMCorujVTPvoxXMRYVvQx11YTL+uAtU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nHPXBbO1fmogf4CJWLzNRNPXB5E6cCVgpHLnEVX04txbmE1nEvYEn1jJh4F/QLckJX0UgjX8S79/ZbEtv1bKfTm9n734Di2GRmq5DTxv9FyjEhmpiwCdTK3BNKec6z/IYQBMZA/C3xXimmbOfp5cUocMU0IR7pgfK7BwPiHwxjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HNKd7UxG; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HNKd7UxG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767717429; x=1799253429;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=V1ZZwM0U2HYiYMCorujVTPvoxXMRYVvQx11YTL+uAtU=;
  b=HNKd7UxGya7lF6Lnrn/uFIqWyUAYpsAd0uw1+zaelJJKtt9uHlOVI9/G
   VSYFc25w7H1BSf1wjkMZlGBen62ng6QP1pMAMDfQ9njxF3cgaD4RVr3Bw
   FcTffwp1NrSzs7l4s4hhAa2p2ZP+HdatIYsCv3COBRSmylmWE4jG2tHdk
   pCemDlwVBBmHNhsoO+066KkBbSxIP3soaTuZmn6EaGJvNx7iMYPDs/mMz
   MV8KOmkSUGTvwhLuHCi54EfUaHFXD7Hh/nKHQK+hWu4I0fmTnx5Jlob94
   dOR0tDlwDgM6sx0ja0/B6U+kpSUnXhQzGmQLrF0UAbyxd1HToqOScXDwG
   Q==;
X-CSE-ConnectionGUID: 4ZFwCr4qSYiqJA5uccl1Ig==
X-CSE-MsgGUID: qhh4Ph3iRyKCG32iaxudKw==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="79718444"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="79718444"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 08:37:08 -0800
X-CSE-ConnectionGUID: E6WvdJVJRIuiOw9mdJDFfw==
X-CSE-MsgGUID: U9bZCm5NQK2lCWAKFuMOKQ==
X-ExtLoop1: 1
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.109.101]) ([10.125.109.101])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 08:37:07 -0800
Message-ID: <95093ebd-d641-44b3-9858-58997dc92cee@intel.com>
Date: Tue, 6 Jan 2026 09:37:06 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NTB: ntb_transport: Use seq_file for QP stats debugfs
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, allenbh@gmail.com, Frank.Li@nxp.com
References: <20251217081955.3137163-1-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20251217081955.3137163-1-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/17/25 1:19 AM, Koichiro Den wrote:
> The ./qp*/stats debugfs file for each NTB transport QP is currently
> implemented with a hand-crafted kmalloc() buffer and a series of
> scnprintf() calls. This is a pre-seq_file style pattern and makes future
> extensions easy to truncate.
> 
> Convert the stats file to use the seq_file helpers via
> DEFINE_SHOW_ATTRIBUTE(), which simplifies the code and lets the seq_file
> core handle buffering and partial reads.
> 
> While touching this area, fix a bug in the per-QP debugfs directory
> naming: the buffer used for "qp%d" was only 4 bytes, which truncates
> names like "qp10" to "qp1" and causes multiple queues to share the same
> directory. Enlarge the buffer and use sizeof() to avoid truncation.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Thanks for the improvement!

Can you please split out the bug fix and add a Fixes tag so it can go to stable kernels? Thanks!

> ---
> Note: This patch is split out from the following series, where it was
> originally included as a preparatory change (refactor + small fix):
> https://lore.kernel.org/all/aS3xe0CNHeIMUu7P@lizhi-Precision-Tower-5810/
> ---
>  drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
>  1 file changed, 41 insertions(+), 95 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index eb875e3db2e3..d5a544bf8fd6 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -57,6 +57,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
> +#include <linux/seq_file.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/mutex.h>
> @@ -466,104 +467,49 @@ void ntb_transport_unregister_client(struct ntb_transport_client *drv)
>  }
>  EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
>  
> -static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
> -			    loff_t *offp)
> +static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  {
> -	struct ntb_transport_qp *qp;
> -	char *buf;
> -	ssize_t ret, out_offset, out_count;
> -
> -	qp = filp->private_data;
> +	struct ntb_transport_qp *qp = s->private;
>  
>  	if (!qp || !qp->link_is_up)
>  		return 0;
>  
> -	out_count = 1000;
> -
> -	buf = kmalloc(out_count, GFP_KERNEL);
> -	if (!buf)
> -		return -ENOMEM;
> +	seq_puts(s, "\nNTB QP stats:\n\n");
> +
> +	seq_printf(s, "rx_bytes - \t%llu\n", qp->rx_bytes);
> +	seq_printf(s, "rx_pkts - \t%llu\n", qp->rx_pkts);
> +	seq_printf(s, "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> +	seq_printf(s, "rx_async - \t%llu\n", qp->rx_async);
> +	seq_printf(s, "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> +	seq_printf(s, "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> +	seq_printf(s, "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> +	seq_printf(s, "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> +	seq_printf(s, "rx_buff - \t0x%p\n", qp->rx_buff);
> +	seq_printf(s, "rx_index - \t%u\n", qp->rx_index);
> +	seq_printf(s, "rx_max_entry - \t%u\n", qp->rx_max_entry);
> +	seq_printf(s, "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> +
> +	seq_printf(s, "tx_bytes - \t%llu\n", qp->tx_bytes);
> +	seq_printf(s, "tx_pkts - \t%llu\n", qp->tx_pkts);
> +	seq_printf(s, "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> +	seq_printf(s, "tx_async - \t%llu\n", qp->tx_async);
> +	seq_printf(s, "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> +	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> +	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
> +	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> +	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
> +	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
> +	seq_putc(s, '\n');
> +
> +	seq_printf(s, "Using TX DMA - \t%s\n", qp->tx_dma_chan ? "Yes" : "No");
> +	seq_printf(s, "Using RX DMA - \t%s\n", qp->rx_dma_chan ? "Yes" : "No");
> +	seq_printf(s, "QP Link - \t%s\n", qp->link_is_up ? "Up" : "Down");
> +	seq_putc(s, '\n');
>  
> -	out_offset = 0;
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\nNTB QP stats:\n\n");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_bytes - \t%llu\n", qp->rx_bytes);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_pkts - \t%llu\n", qp->rx_pkts);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_async - \t%llu\n", qp->rx_async);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_buff - \t0x%p\n", qp->rx_buff);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_index - \t%u\n", qp->rx_index);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
> -
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_bytes - \t%llu\n", qp->tx_bytes);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_pkts - \t%llu\n", qp->tx_pkts);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_async - \t%llu\n", qp->tx_async);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_mw - \t0x%p\n", qp->tx_mw);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_index (H) - \t%u\n", qp->tx_index);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "RRI (T) - \t%u\n",
> -			       qp->remote_rx_info->entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "free tx - \t%u\n",
> -			       ntb_transport_tx_free_entry(qp));
> -
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\n");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "Using TX DMA - \t%s\n",
> -			       qp->tx_dma_chan ? "Yes" : "No");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "Using RX DMA - \t%s\n",
> -			       qp->rx_dma_chan ? "Yes" : "No");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "QP Link - \t%s\n",
> -			       qp->link_is_up ? "Up" : "Down");
> -	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
> -			       "\n");
> -
> -	if (out_offset > out_count)
> -		out_offset = out_count;
> -
> -	ret = simple_read_from_buffer(ubuf, count, offp, buf, out_offset);
> -	kfree(buf);
> -	return ret;
> -}
> -
> -static const struct file_operations ntb_qp_debugfs_stats = {
> -	.owner = THIS_MODULE,
> -	.open = simple_open,
> -	.read = debugfs_read,
> -};
> +	return 0;
> +}
> +DEFINE_SHOW_ATTRIBUTE(ntb_qp_debugfs_stats);
>  
>  static void ntb_list_add(spinlock_t *lock, struct list_head *entry,
>  			 struct list_head *list)
> @@ -1236,15 +1182,15 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  	qp->tx_max_entry = tx_size / qp->tx_max_frame;
>  
>  	if (nt->debugfs_node_dir) {
> -		char debugfs_name[4];
> +		char debugfs_name[8];
>  
> -		snprintf(debugfs_name, 4, "qp%d", qp_num);
> +		snprintf(debugfs_name, sizeof(debugfs_name), "qp%d", qp_num);
>  		qp->debugfs_dir = debugfs_create_dir(debugfs_name,
>  						     nt->debugfs_node_dir);
>  
>  		qp->debugfs_stats = debugfs_create_file("stats", S_IRUSR,
>  							qp->debugfs_dir, qp,
> -							&ntb_qp_debugfs_stats);
> +							&ntb_qp_debugfs_stats_fops);
>  	} else {
>  		qp->debugfs_dir = NULL;
>  		qp->debugfs_stats = NULL;

