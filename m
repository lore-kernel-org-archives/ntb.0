Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD53548CD7A
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787158804; cv=none; b=POnDcAbLuhOAxBfdENT8Lh+6a7364tCcdrIL5+jMhIN4zbg5AQqzxdqDoIziYSp+9ZsOL3rNVKRtdx2DPcN7+iiqmlIdRrntTwceQfI7lwhmPvyP8kbAhJqafRFlEVBttO5beFeun6H65BVh7p7QtaoJG9f8cERMWVBVr+bpojY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787158804; c=relaxed/simple;
	bh=rRma67xnWdLThyCbVr5967PlO9v6CaBagls2mWkZ+Bo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVcUtO3zwdFeVEbw4sy3UIWeHqRzid0ST0vXu8gF+M/5Gh575HGT/rqiIygJSkwWXsiL6WAPcT77j8ZnrENSzpsYRmauVvFyFLcdjjCzrsWhFF1Z1h62lcGz6tGCu5AZxH3YqBB7lWVZSPOx9IWry3FC0PuFwzt6guqIVqNg4Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TvvQjVQR; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TvvQjVQR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787158801; x=1818694801;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rRma67xnWdLThyCbVr5967PlO9v6CaBagls2mWkZ+Bo=;
  b=TvvQjVQR4jRK9Gk73nscmO6lYmuirUbICuKYUUteBIrPT1/kWw6eZXJ1
   r4VwHNgXkk/bC1i/vcsHEpYjvcABzcehDG3bfM/lEDRXxmb+ZD1FTIoPZ
   4XVLwiu5sl/Dw97x9ufqyl3uifY+JiMw2NDE4sBG6cFrzJy4tJz3VLo6Y
   YFTJcpcy89fC8d/N/Hh/PId2bAuMDWZpjb37Zi50K97n1/QbWs8Lghdvk
   z0nDN7VmRR9mEmjwCfsfahtAMgRHV0PEYP1LExmJtNtfG+EJEHJzybalW
   baF+be/RsJYY/IxTC0goY4O6WnAjWNx98+qjUJsf9qKPgNzfyr88YkDUm
   A==;
X-CSE-ConnectionGUID: 0Ynr1t1NTxm2bsPAtpG4Bg==
X-CSE-MsgGUID: 3MWtpaWVQhWAADfoj+cFGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="87706428"
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="87706428"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:59:59 -0700
X-CSE-ConnectionGUID: Ao6wb4t9Q6SJ2CQNVOkHLA==
X-CSE-MsgGUID: pY6AMBrYSCm33GRy9uR3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,231,1779174000"; 
   d="scan'208";a="303818942"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 09:59:58 -0700
Message-ID: <fafc64b4-7fda-4a64-b3c1-480ae67a004a@intel.com>
Date: Wed, 19 Aug 2026 09:59:56 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 3/4] NTB: ntb_transport: Add per-payload
 client metadata
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817064916.13278-1-den@valinux.co.jp>
 <20260817064916.13278-4-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817064916.13278-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 11:49 PM, Koichiro Den wrote:
> ntb_transport currently carries only payload bytes, with no way for clients
> to associate metadata with an individual payload.
> 
> The payload header has a 32-bit flags field, with only BIT(0) and BIT(1) in
> use. Carry opaque client metadata in the upper 24 bits. Expose it through
> the transmit enqueue interface and receive callback. Reject values that do
> not fit. Keep the low byte for transport flags so future flags can continue
> from BIT(2).
> 
> No protocol version bump is needed. Existing Linux version 4 peers ignore
> the upper bits on receive and always transmit them as zero.
> 
> Adapt ntb_netdev to the new interfaces without using metadata.
> 
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
> Changes in v2:
>   - No changes.
> 
>  drivers/net/ntb_netdev.c      |  4 ++--
>  drivers/ntb/ntb_transport.c   | 18 +++++++++++++-----
>  include/linux/ntb_transport.h |  6 ++++--
>  3 files changed, 19 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 029a4a532a10..5c7fe6883cb9 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -123,7 +123,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
>  }
>  
>  static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
> -				  void *data, int len)
> +				  void *data, int len, unsigned int meta)
>  {
>  	struct ntb_netdev_queue *q = qp_data;
>  	struct ntb_netdev *dev = q->ntdev;
> @@ -258,7 +258,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
>  
>  	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
>  
> -	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
> +	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
>  	if (rc)
>  		goto err;
>  
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 967a5ad38164..70be06a42201 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -167,7 +167,7 @@ struct ntb_transport_qp {
>  	unsigned int tx_max_frame;
>  
>  	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
> -			   void *data, int len);
> +			   void *data, int len, unsigned int meta);
>  	struct list_head rx_post_q;
>  	struct list_head rx_pend_q;
>  	struct list_head rx_free_q;
> @@ -264,6 +264,10 @@ enum {
>  	LINK_DOWN_FLAG = BIT(1),
>  };
>  
> +/* Reserve the low byte for transport flags. */
> +#define DESC_META_SHIFT		8
> +#define DESC_META_MASK		(~0U << DESC_META_SHIFT)
> +
>  struct ntb_payload_header {
>  	__le32 ver;
>  	__le32 len;
> @@ -1436,6 +1440,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  	struct ntb_queue_entry *entry;
>  	void *cb_data;
>  	unsigned int len;
> +	unsigned int meta;
>  	unsigned long irqflags;
>  
>  	spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
> @@ -1451,13 +1456,14 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  
>  		cb_data = entry->cb_data;
>  		len = entry->len;
> +		meta = entry->flags >> DESC_META_SHIFT;
>  
>  		list_move_tail(&entry->entry, &qp->rx_free_q);
>  
>  		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
>  
>  		if (qp->rx_handler && qp->client_ready)
> -			qp->rx_handler(qp, qp->cb_data, cb_data, len);
> +			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);
>  
>  		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
>  	}
> @@ -1656,6 +1662,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  
>  	entry->rx_hdr = hdr;
>  	entry->rx_index = qp->rx_index;
> +	entry->flags = flags & DESC_META_MASK;
>  
>  	if (len > entry->len) {
>  		dev_dbg(&qp->ndev->pdev->dev,
> @@ -2341,6 +2348,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
>   * @cb: per buffer pointer for callback function to use
>   * @data: pointer to data buffer that will be sent
>   * @len: length of the data buffer
> + * @meta: client metadata to send with the buffer
>   *
>   * Enqueue a new transmit buffer onto the transport queue from which a NTB
>   * payload will be transmitted.  This assumes that a lock is being held to
> @@ -2349,12 +2357,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
>   * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
>   */
>  int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
> -			     unsigned int len)
> +			     unsigned int len, unsigned int meta)
>  {
>  	struct ntb_queue_entry *entry;
>  	int rc;
>  
> -	if (!qp || !len)
> +	if (!qp || !len || meta > NTB_TRANSPORT_MAX_META)
>  		return -EINVAL;
>  
>  	/* If the qp link is down already, just ignore. */
> @@ -2370,7 +2378,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  	entry->cb_data = cb;
>  	entry->buf = data;
>  	entry->len = len;
> -	entry->flags = 0;
> +	entry->flags = meta << DESC_META_SHIFT;
>  	entry->errors = 0;
>  	entry->tx_index = 0;
>  
> diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
> index 7243eb98a722..9e807542b6c4 100644
> --- a/include/linux/ntb_transport.h
> +++ b/include/linux/ntb_transport.h
> @@ -50,6 +50,8 @@
>  
>  struct ntb_transport_qp;
>  
> +#define NTB_TRANSPORT_MAX_META	0x00ffffffU
> +
>  struct ntb_transport_client {
>  	struct device_driver driver;
>  	int (*probe)(struct device *client_dev);
> @@ -63,7 +65,7 @@ void ntb_transport_unregister_client_dev(char *device_name);
>  
>  struct ntb_queue_handlers {
>  	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
> -			   void *data, int len);
> +			   void *data, int len, unsigned int meta);
>  	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
>  			   void *data, int len);
>  	void (*event_handler)(void *data, int status);
> @@ -78,7 +80,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp);
>  int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  			     unsigned int len);
>  int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
> -			     unsigned int len);
> +			     unsigned int len, unsigned int meta);
>  void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
>  void ntb_transport_link_up(struct ntb_transport_qp *qp);
>  void ntb_transport_link_down(struct ntb_transport_qp *qp);

