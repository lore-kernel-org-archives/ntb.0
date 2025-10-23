Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9599A1474CC
	for <ntb@lists.linux.dev>; Thu, 23 Oct 2025 15:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761232691; cv=none; b=olE28vKRvUllheU0REgvvS48qOyEZaq1jvpaAoqYMrV4INpKaTlEHMo2F3oft11SDeU1OkGaHhOIWBMmOmFcln6PWzZtJcs4eWEZkOJAHMnuuRtVfIbA2m1IKAQgf29C6Px2bNXuC3yAyBBNIEeD1y3tZFVwCLTrxpMfYBNX9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761232691; c=relaxed/simple;
	bh=3qQgMnT6JPedpaZTnPxUQDY/BjXnSoJ1vogwY152k60=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kUXYCkFXT45Pfgvjv5WvFWsa9mrlgTHNHMHGulQNYELbKvxrrrDoUbnf23kMf0EBybaQxKbszDJyoDlx6fCGxVJxtJ290Cq/SzL2ZU7afPKtDm1tBPqd9FiwgR0eay3LZXkTdQoSy0DP4Hl/02rw5qYd7UAg2K3VKKxyfY0vgTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kqGxAcco; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kqGxAcco"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761232689; x=1792768689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=3qQgMnT6JPedpaZTnPxUQDY/BjXnSoJ1vogwY152k60=;
  b=kqGxAccoPrWxBJH7yvVi3V5eSBLZ8pBAUxXOfifxK1herejItbJzCPPw
   WOKAkx9q55G8aOXzX0PYxheXE++KmJUpen9S7EAEiv0Q4ZiAzFYLcVtRi
   FjTck9cJwEclLneUPaTL7eRr9Kd0kE5RvNiYQ7ytct9j4sxqaPTKeGJu2
   SDxxxcSfVblmiZjybPJZTeBLbLq5TO0BVcUN91RbUvmhttptuJNGwjAeS
   IJUD4Gt7xdib0/oTxtNPToLWs4h/z55gccRr9GBtXxDnI3huF+CsFalHM
   h66vJwS/3m4IjfyuA87eRP7L2kYkGZmzAZgoJoZ9lixw2ZCvXgmmONHLk
   g==;
X-CSE-ConnectionGUID: +j8lb7D7Qne4lY0Bc+OEQA==
X-CSE-MsgGUID: XOQ3cxsqQMSxqGwl/+q9xA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63499823"
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="63499823"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:18:08 -0700
X-CSE-ConnectionGUID: eGEPROWZSWKqi2r2OLb5Hw==
X-CSE-MsgGUID: c+gT1GsmRTykGUwjdfC5pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,250,1754982000"; 
   d="scan'208";a="183355021"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.109.4]) ([10.125.109.4])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2025 08:18:08 -0700
Message-ID: <b7a5ed5e-f4ca-4045-a956-73594a286fee@intel.com>
Date: Thu, 23 Oct 2025 08:18:07 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] NTB: ntb_transport: Add 'tx_memcpy_offload' module
 option
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, allenbh@gmail.com
References: <20251023072105.901707-1-den@valinux.co.jp>
 <20251023072105.901707-3-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251023072105.901707-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/23/25 12:21 AM, Koichiro Den wrote:
> Some platforms (e.g. R-Car S4) do not gain from using a DMAC on TX path
> in ntb_transport and end up CPU-bound on memcpy_toio(). Add a module
> parameter 'tx_memcpy_offload' that moves the TX memcpy_toio() and
> descriptor writes to a per-QP kernel thread. It is disabled by default.

please add comments by the module parameter that if this is set, tx DMA is disabled (right?).> 
> This change also fixes a rare ordering hazard in ntb_tx_copy_callback(),
> that was observed on R-Car S4 once throughput improved with the new
> module parameter: the DONE flag write to the peer MW, which is WC
> mapped, could be observed after the DB/MSI trigger. Both operations are
> posted PCIe MWr (often via different OB iATUs), so WC buffering and
> bridges may reorder visibility. Insert dma_mb() to enforce store->load
> ordering and then read back hdr->flags to flush the posted write before
> ringing the doorbell / issuing MSI.

Can you please split out the fix to this issue so it can be backported to stable?

> 
> While at it, update tx_index with WRITE_ONCE() at the earlier possible
> location to make ntb_transport_tx_free_entry() robust.

Please also split out this change if the intention is to address an existing issue and accompany with appropriate justification.

> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
>  drivers/ntb/ntb_transport.c | 104 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 100 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 39b2398b95a6..f4ed616c6ab8 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -54,12 +54,14 @@
>  #include <linux/errno.h>
>  #include <linux/export.h>
>  #include <linux/interrupt.h>
> +#include <linux/kthread.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include <linux/slab.h>
>  #include <linux/types.h>
>  #include <linux/uaccess.h>
>  #include <linux/mutex.h>
> +#include <linux/wait.h>
>  #include "linux/ntb.h"
>  #include "linux/ntb_transport.h"
>  
> @@ -100,6 +102,10 @@ module_param(use_msi, bool, 0644);
>  MODULE_PARM_DESC(use_msi, "Use MSI interrupts instead of doorbells");
>  #endif
>  
> +static bool tx_memcpy_offload;
> +module_param(tx_memcpy_offload, bool, 0644);
> +MODULE_PARM_DESC(tx_memcpy_offload, "Offload TX memcpy_toio() to a kernel thread");

Offload typically points to moving an operation to an independent piece of hardware like DMA engine. The naming can cause confusion. May I suggest something like 'tx_threaded_copy' instead to make it more clearer?

Also to make it easier for people to understand what this parameter is used for, please include a comment block explaining why this parameter is needed.

> +
>  static struct dentry *nt_debugfs_dir;
>  
>  /* Only two-ports NTB devices are supported */
> @@ -148,7 +154,9 @@ struct ntb_transport_qp {
>  	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
>  			   void *data, int len);
>  	struct list_head tx_free_q;
> +	struct list_head tx_offl_q;
>  	spinlock_t ntb_tx_free_q_lock;
> +	spinlock_t ntb_tx_offl_q_lock;
>  	void __iomem *tx_mw;
>  	phys_addr_t tx_mw_phys;
>  	size_t tx_mw_size;
> @@ -199,6 +207,9 @@ struct ntb_transport_qp {
>  	int msi_irq;
>  	struct ntb_msi_desc msi_desc;
>  	struct ntb_msi_desc peer_msi_desc;
> +
> +	struct task_struct *tx_offload_thread;
> +	wait_queue_head_t tx_offload_wq;
>  };
>  
>  struct ntb_transport_mw {
> @@ -284,7 +295,13 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset);
>  static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset);
>  static void ntb_memcpy_rx(struct ntb_queue_entry *entry, void *offset);
> +static int ntb_tx_memcpy_kthread(void *data);
> +
>  
> +static inline bool ntb_tx_offload_enabled(struct ntb_transport_qp *qp)
> +{
> +	return tx_memcpy_offload && qp && qp->tx_offload_thread;
> +}
>  
>  static int ntb_transport_bus_match(struct device *dev,
>  				   const struct device_driver *drv)
> @@ -1254,11 +1271,13 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>  
>  	spin_lock_init(&qp->ntb_rx_q_lock);
>  	spin_lock_init(&qp->ntb_tx_free_q_lock);
> +	spin_lock_init(&qp->ntb_tx_offl_q_lock);
>  
>  	INIT_LIST_HEAD(&qp->rx_post_q);
>  	INIT_LIST_HEAD(&qp->rx_pend_q);
>  	INIT_LIST_HEAD(&qp->rx_free_q);
>  	INIT_LIST_HEAD(&qp->tx_free_q);
> +	INIT_LIST_HEAD(&qp->tx_offl_q);
>  
>  	tasklet_init(&qp->rxc_db_work, ntb_transport_rxc_db,
>  		     (unsigned long)qp);
> @@ -1784,6 +1803,13 @@ static void ntb_tx_copy_callback(void *data,
>  
>  	iowrite32(entry->flags | DESC_DONE_FLAG, &hdr->flags);
>  
> +	/*
> +	 * Make DONE flag visible before DB/MSI. WC + posted MWr may reorder
> +	 * across iATU/bridge (platform-dependent). Order and flush here.
> +	 */
> +	dma_mb();
> +	ioread32(&hdr->flags);

Is dma_mb() needed if you are also doing an mmio read? Read can't pass write with PCI ordering rule and the ioread32() alone should be sufficient that the data has reached the destination host.

DJ

> +
>  	if (qp->use_msi)
>  		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
>  	else
> @@ -1804,7 +1830,7 @@ static void ntb_tx_copy_callback(void *data,
>  	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
>  }
>  
> -static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> +static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)
>  {
>  #ifdef ARCH_HAS_NOCACHE_UACCESS
>  	/*
> @@ -1822,6 +1848,54 @@ static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
>  	ntb_tx_copy_callback(entry, NULL);
>  }
>  
> +static int ntb_tx_memcpy_kthread(void *data)
> +{
> +	struct ntb_transport_qp *qp = data;
> +	struct ntb_queue_entry *entry, *tmp;
> +	const int resched_nr = 64;
> +	LIST_HEAD(local_list);
> +	void __iomem *offset;
> +	int processed = 0;
> +
> +	while (!kthread_should_stop()) {
> +		spin_lock_irq(&qp->ntb_tx_offl_q_lock);
> +		wait_event_interruptible_lock_irq_timeout(qp->tx_offload_wq,
> +				kthread_should_stop() ||
> +				!list_empty(&qp->tx_offl_q),
> +				qp->ntb_tx_offl_q_lock, 5*HZ);
> +		list_splice_tail_init(&qp->tx_offl_q, &local_list);
> +		spin_unlock_irq(&qp->ntb_tx_offl_q_lock);
> +
> +		list_for_each_entry_safe(entry, tmp, &local_list, entry) {
> +			list_del(&entry->entry);
> +			offset = qp->tx_mw + qp->tx_max_frame * entry->tx_index;
> +			ntb_memcpy_tx_on_stack(entry, offset);
> +			if (++processed >= resched_nr) {
> +				cond_resched();
> +				processed = 0;
> +			}
> +		}
> +		cond_resched();
> +	}
> +
> +	return 0;
> +}
> +
> +static void ntb_memcpy_tx(struct ntb_queue_entry *entry, void __iomem *offset)
> +{
> +	struct ntb_transport_qp *qp = entry->qp;
> +
> +	if (WARN_ON_ONCE(!qp))
> +		return;
> +
> +	if (ntb_tx_offload_enabled(qp)) {
> +		ntb_list_add(&qp->ntb_tx_offl_q_lock, &entry->entry,
> +			     &qp->tx_offl_q);
> +		wake_up(&qp->tx_offload_wq);
> +	} else
> +		ntb_memcpy_tx_on_stack(entry, offset);
> +}
> +
>  static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  			       struct ntb_queue_entry *entry)
>  {
> @@ -1894,6 +1968,9 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
>  	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
>  	entry->tx_hdr = hdr;
>  
> +	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
> +	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
> +
>  	iowrite32(entry->len, &hdr->len);
>  	iowrite32((u32)qp->tx_pkts, &hdr->ver);
>  
> @@ -1934,9 +2011,6 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
>  
>  	ntb_async_tx(qp, entry);
>  
> -	qp->tx_index++;
> -	qp->tx_index %= qp->tx_max_entry;
> -
>  	qp->tx_pkts++;
>  
>  	return 0;
> @@ -2033,6 +2107,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
>  	qp->tx_handler = handlers->tx_handler;
>  	qp->event_handler = handlers->event_handler;
>  
> +	init_waitqueue_head(&qp->tx_offload_wq);
> +	if (tx_memcpy_offload) {
> +		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
> +						    "ntb-txcpy/%s/%u",
> +						    pci_name(ndev->pdev), qp->qp_num);
> +		if (IS_ERR(qp->tx_offload_thread)) {
> +			dev_warn(&nt->ndev->dev,
> +				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
> +				 PTR_ERR(qp->tx_offload_thread));
> +			qp->tx_offload_thread = NULL;
> +		}
> +	} else
> +		qp->tx_offload_thread = NULL;
> +
>  	dma_cap_zero(dma_mask);
>  	dma_cap_set(DMA_MEMCPY, dma_mask);
>  
> @@ -2140,6 +2228,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  
>  	qp->active = false;
>  
> +	if (qp->tx_offload_thread) {
> +		kthread_stop(qp->tx_offload_thread);
> +		qp->tx_offload_thread = NULL;
> +	}
> +
>  	if (qp->tx_dma_chan) {
>  		struct dma_chan *chan = qp->tx_dma_chan;
>  		/* Putting the dma_chan to NULL will force any new traffic to be
> @@ -2203,6 +2296,9 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>  	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
>  		kfree(entry);
>  
> +	while ((entry = ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
> +		kfree(entry);
> +
>  	qp->transport->qp_bitmap_free |= qp_bit;
>  
>  	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);

