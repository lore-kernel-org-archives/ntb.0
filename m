Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F56453A22
	for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787928468; cv=none; b=dC17SMIC1oNkr20SP2JJDw5Zql8l28c5eZlljzIAjEc/JJr/0QZennPqh/0NrGFH8T5/zjT/vVUvIQA2FqEm9jC7DAV+sENpwfBrwlzj7i9HxZX+6flqrtHo0pCraXI6BMBJjvIZToRFlZKyR0d4wGhSbN7+31aBVz+o8Vbwp+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787928468; c=relaxed/simple;
	bh=7+8RIYPwH/ZJ5ltKaO0AKbwKqkwUb5AuHvKzRXk6c4E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aoQ4gM8YiMrIW97JFn4Xl0T2QvpXzJE2R0853PgwLqICLFsP5hubKMUbS0ucqFW9FcpSC3Jkxv2xqNe86qt7KLvPpioyLLlQDInaisSBMJoD7085pRcHkNAZq5WaSWw/8+SAEOX4MWAmhPik4DGeYdV2rm8CnpE47PfytYJW/iQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WJKQ5R6Y; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WJKQ5R6Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787928466; x=1819464466;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=7+8RIYPwH/ZJ5ltKaO0AKbwKqkwUb5AuHvKzRXk6c4E=;
  b=WJKQ5R6YX6uj5eiyxMd8s6rNX/OUc13JidLOZfzsldEPxOrAx7LDjS6o
   pWCe0RDexyZeWL82x1nk2H4d//mZSolV8Fj8j76ZNw2x+L6zM41YYVwIF
   k/T5HME1rB4mz/i+XNQXarkO2bnBpoUDKMrNrLNL0VlaVvx6VyzNj9ftz
   iEUo5XbUuo410xSdty2TBzKGylf7IK1YeE3nhwLPHp2XUHOFAkMmnHi2h
   bHX00+Qf1H/Rzm3K1llv9ouuqdy8xFCnedntuelvq++0sZq5i/7k2L3IK
   5RK1A7zVV3mnLQi+x0Dxszn8QC846E0Y8nWbmd/UHvNXfgPCCbXF6zaBT
   g==;
X-CSE-ConnectionGUID: Kr9Fg22ySwy8QuwJuObiLQ==
X-CSE-MsgGUID: IricerddQe20yz1g2KlTyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11889"; a="88489354"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="88489354"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 07:47:45 -0700
X-CSE-ConnectionGUID: rE6bKDyhSPWXrDYeqdTpMw==
X-CSE-MsgGUID: NXCy/gKxQwCOHErNpVPkoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; 
   d="scan'208";a="264940163"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.180]) ([10.125.109.180])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2026 07:47:38 -0700
Message-ID: <51d2fe16-4a71-481c-a32e-b258cd3be10d@intel.com>
Date: Fri, 28 Aug 2026 07:47:35 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] NTB: ntb_transport: Implement direct-DMA QP session
 handshake
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Frank Li <Frank.Li@kernel.org>,
 Allen Hubbe <allenbh@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Niklas Cassel <cassel@kernel.org>, Nicholas Bellinger <nab@linux-iscsi.org>,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260810165136.2292436-1-den@valinux.co.jp>
 <20260810165136.2292436-11-den@valinux.co.jp>
 <4ce6682d-526b-4d78-8bff-1dd26422496a@intel.com>
 <jmc2p5uc4bpdxbigmbojwz3p2q47tqjzzhrqrpogmelb6qttlz@yeb73mwowvut>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <jmc2p5uc4bpdxbigmbojwz3p2q47tqjzzhrqrpogmelb6qttlz@yeb73mwowvut>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/27/26 6:32 PM, Koichiro Den wrote:
> On Thu, Aug 27, 2026 at 09:03:42AM -0700, Dave Jiang wrote:
>>
>>
>> On 8/10/26 9:51 AM, Koichiro Den wrote:
>>> A logical QP can be reused while its shared memory still contains RX
>>> addresses and completions from the previous instance. Without a session
>>> ID, the new QP could accept that stale state.
>>>
>>> Give each QP instance a fresh session ID and enable direct DMA only
>>> after both peers acknowledge it. Teardown also exchanges the final
>>> issued boundary so RX mappings remain valid until all outstanding
>>> transfers have completed.
>>>
>>> Signed-off-by: Koichiro Den <den@valinux.co.jp>
>>> ---
>>>  drivers/ntb/ntb_transport.c | 275 ++++++++++++++++++++++++++++++++++--
>>
>> Will you considered moving most of the ntb_direct code to ntb_transport_direct.c instead of increasing the size of ntb_transport.c? Just from an organization perspective this may be better for maintenance and reading in the future.
> 
> Thanks for the comment. Let me rethink how best to split it out.
> 
> (For v1, I thought it would be fine to keep it in ntb_transport.c, because,
> compared to the previous ntb_transport_edma RFC, it can now fall back to the
> standard MW memcpy path, and the vendor-specific parts are gone after moving
> them under the standard dmaengine API. I had thought keeping it together would
> be simpler, so thanks for the feedback.)

I just mean a different C source file with a shared private header file. Still same module.

DJ> 
> Best regards,
> Koichiro
> 
>>
>> DJ
>>
>>>  1 file changed, 267 insertions(+), 8 deletions(-)
>>>
>>> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
>>> index 67044d0ea0ff..ca08cb690311 100644
>>> --- a/drivers/ntb/ntb_transport.c
>>> +++ b/drivers/ntb/ntb_transport.c
>>> @@ -58,6 +58,7 @@
>>>  #include <linux/limits.h>
>>>  #include <linux/module.h>
>>>  #include <linux/pci.h>
>>> +#include <linux/random.h>
>>>  #include <linux/slab.h>
>>>  #include <linux/seq_file.h>
>>>  #include <linux/types.h>
>>> @@ -153,6 +154,14 @@ struct ntb_rx_info {
>>>  	unsigned int entry;
>>>  };
>>>  
>>> +enum ntb_direct_state {
>>> +	NTB_DIRECT_DOWN,
>>> +	NTB_DIRECT_HANDSHAKE,
>>> +	NTB_DIRECT_ACTIVE,
>>> +	NTB_DIRECT_QUIESCING,
>>> +	NTB_DIRECT_QUIESCED,
>>> +};
>>> +
>>>  struct ntb_transport_qp {
>>>  	struct ntb_transport_ctx *transport;
>>>  	struct ntb_dev *ndev;
>>> @@ -195,6 +204,8 @@ struct ntb_transport_qp {
>>>  	struct ntb_direct_shared *direct_shared;
>>>  	struct ntb_direct_shared __iomem *peer_direct_shared;
>>>  	unsigned int direct_ring_entries;
>>> +	/* Serialize direct session, TX ring, and RX publication state. */
>>> +	spinlock_t direct_lock;
>>>  	u32 *direct_rx_cpl;
>>>  	dma_addr_t direct_rx_cpl_dma;
>>>  	u32 *direct_tx_cpl;
>>> @@ -203,6 +214,9 @@ struct ntb_transport_qp {
>>>  	u32 direct_rx_cons;
>>>  	u32 direct_tx_issue;
>>>  	u32 direct_tx_cons;
>>> +	u32 direct_session;
>>> +	u32 direct_peer_session;
>>> +	enum ntb_direct_state direct_state;
>>>  	void *rx_buff;
>>>  	unsigned int rx_index;
>>>  	unsigned int rx_max_entry;
>>> @@ -509,6 +523,228 @@ static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
>>>  #define QP_TO_MW(nt, qp)	((qp) % nt->mw_count)
>>>  #define NTB_QP_DEF_NUM_ENTRIES	100
>>>  #define NTB_LINK_DOWN_TIMEOUT	10
>>> +#define NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS	10
>>> +
>>> +static bool ntb_direct_rx_mode(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_transport_ctx *nt = qp->transport;
>>> +
>>> +	return (nt->direct_features & NTB_DIRECT_FEAT_RX) &&
>>> +	       (nt->peer_direct_features & NTB_DIRECT_FEAT_TX);
>>> +}
>>> +
>>> +static bool ntb_direct_tx_mode(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_transport_ctx *nt = qp->transport;
>>> +
>>> +	return (nt->direct_features & NTB_DIRECT_FEAT_TX) &&
>>> +	       (nt->peer_direct_features & NTB_DIRECT_FEAT_RX);
>>> +}
>>> +
>>> +static bool ntb_direct_link_capable(struct ntb_transport_qp *qp)
>>> +{
>>> +	return ntb_direct_rx_mode(qp) || ntb_direct_tx_mode(qp);
>>> +}
>>> +
>>> +static void ntb_transport_notify_peer(struct ntb_transport_qp *qp)
>>> +{
>>> +	if (qp->use_msi)
>>> +		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
>>> +	else
>>> +		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
>>> +}
>>> +
>>> +static bool ntb_direct_tx_idle(struct ntb_transport_qp *qp)
>>> +{
>>> +	return qp->direct_tx_issue == qp->direct_tx_cons;
>>> +}
>>> +
>>> +static bool ntb_direct_rx_drained(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_direct_shared *shared = qp->direct_shared;
>>> +	u32 session = qp->direct_session;
>>> +
>>> +	if (!shared || !session || READ_ONCE(shared->quiesce) != session)
>>> +		return false;
>>> +
>>> +	/* quiesce is written after its final issue boundary. */
>>> +	dma_rmb();
>>> +	return READ_ONCE(qp->direct_rx_cons) ==
>>> +	       READ_ONCE(shared->quiesce_issue);
>>> +}
>>> +
>>> +static bool ntb_direct_tx_acked(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_direct_shared *shared = qp->direct_shared;
>>> +	u32 session = qp->direct_session;
>>> +
>>> +	return shared && session &&
>>> +	       READ_ONCE(shared->quiesce_ack) == session;
>>> +}
>>> +
>>> +static bool ntb_direct_control_pending(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_direct_shared *shared = qp->direct_shared;
>>> +	enum ntb_direct_state state = READ_ONCE(qp->direct_state);
>>> +	u32 peer_session = READ_ONCE(qp->direct_peer_session);
>>> +	u32 session = READ_ONCE(qp->direct_session);
>>> +
>>> +	if (!shared)
>>> +		return false;
>>> +	if (state == NTB_DIRECT_HANDSHAKE)
>>> +		return READ_ONCE(shared->session) != peer_session ||
>>> +		       READ_ONCE(shared->session_ack) == session;
>>> +	if (state != NTB_DIRECT_ACTIVE)
>>> +		return false;
>>> +
>>> +	return READ_ONCE(shared->session) != peer_session ||
>>> +	       READ_ONCE(shared->quiesce) == session;
>>> +}
>>> +
>>> +static void ntb_direct_control_publish_locked(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_direct_shared __iomem *peer = qp->peer_direct_shared;
>>> +	u32 peer_session = qp->direct_peer_session;
>>> +
>>> +	lockdep_assert_held(&qp->direct_lock);
>>> +
>>> +	/* Publish the completion array address before its session. */
>>> +	iowrite32(lower_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_lo);
>>> +	iowrite32(upper_32_bits(qp->direct_rx_cpl_dma), &peer->cpl_addr_hi);
>>> +
>>> +	iowrite32(qp->direct_session, &peer->session);
>>> +	if (!peer_session)
>>> +		return;
>>> +
>>> +	iowrite32(peer_session, &peer->session_ack);
>>> +	if (qp->direct_state == NTB_DIRECT_QUIESCING) {
>>> +		/* Publish the final exclusive TX boundary before its marker. */
>>> +		iowrite32(qp->direct_tx_issue, &peer->quiesce_issue);
>>> +		iowrite32(peer_session, &peer->quiesce);
>>> +	}
>>> +	if (ntb_direct_rx_drained(qp))
>>> +		iowrite32(peer_session, &peer->quiesce_ack);
>>> +}
>>> +
>>> +/*
>>> + * Accept the peer session during HANDSHAKE. In ACTIVE or QUIESCING, a
>>> + * replacement peer session or quiesce request enters the local teardown path.
>>> + */
>>> +static bool ntb_direct_control_progress(struct ntb_transport_qp *qp)
>>> +{
>>> +	struct ntb_direct_shared *shared = qp->direct_shared;
>>> +	u32 peer_session, session_ack, quiesce;
>>> +	bool published = false;
>>> +	bool cleanup = false;
>>> +	bool ready = false;
>>> +
>>> +	if (!qp->transport->link_is_up || !shared ||
>>> +	    !qp->peer_direct_shared ||
>>> +	    !ntb_direct_link_capable(qp) ||
>>> +	    ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
>>> +		return true;
>>> +
>>> +	peer_session = READ_ONCE(shared->session);
>>> +	session_ack = READ_ONCE(shared->session_ack);
>>> +	quiesce = READ_ONCE(shared->quiesce);
>>> +
>>> +	scoped_guard(spinlock_bh, &qp->direct_lock) {
>>> +		if (!qp->direct_session)
>>> +			goto out;
>>> +
>>> +		if (qp->direct_state == NTB_DIRECT_HANDSHAKE && peer_session) {
>>> +			qp->direct_peer_session = peer_session;
>>> +		} else if (qp->direct_state == NTB_DIRECT_ACTIVE && peer_session &&
>>> +			   peer_session != qp->direct_peer_session) {
>>> +			qp->direct_state = NTB_DIRECT_QUIESCING;
>>> +		}
>>> +
>>> +		if (quiesce == qp->direct_session &&
>>> +		    (qp->direct_state == NTB_DIRECT_HANDSHAKE ||
>>> +		     qp->direct_state == NTB_DIRECT_ACTIVE)) {
>>> +			qp->direct_state = NTB_DIRECT_QUIESCING;
>>> +			cleanup = qp->client_ready;
>>> +		}
>>> +
>>> +		ntb_direct_control_publish_locked(qp);
>>> +		published = true;
>>> +		if (qp->direct_state == NTB_DIRECT_HANDSHAKE &&
>>> +		    qp->direct_peer_session &&
>>> +		    session_ack == qp->direct_session)
>>> +			qp->direct_state = NTB_DIRECT_ACTIVE;
>>> +		ready = qp->direct_state == NTB_DIRECT_ACTIVE;
>>> +	}
>>> +
>>> +out:
>>> +	if (published)
>>> +		ntb_transport_notify_peer(qp);
>>> +	if (cleanup)
>>> +		schedule_work(&qp->link_cleanup);
>>> +
>>> +	return ready;
>>> +}
>>> +
>>> +static void ntb_direct_session_start(struct ntb_transport_qp *qp)
>>> +{
>>> +	u32 session;
>>> +
>>> +	if (!ntb_direct_link_capable(qp) || !qp->direct_shared)
>>> +		return;
>>> +
>>> +	session = get_random_u32_above(0);
>>> +
>>> +	memset(qp->direct_shared, 0, sizeof(*qp->direct_shared));
>>> +	/* Complete local shared-state reset before publishing the new session. */
>>> +	dma_wmb();
>>> +
>>> +	guard(spinlock_bh)(&qp->direct_lock);
>>> +	qp->direct_session = session;
>>> +	qp->direct_peer_session = 0;
>>> +	qp->direct_state = NTB_DIRECT_HANDSHAKE;
>>> +}
>>> +
>>> +static void ntb_direct_quiesce(struct ntb_transport_qp *qp)
>>> +{
>>> +	bool done;
>>> +
>>> +	if (!ntb_direct_link_capable(qp))
>>> +		return;
>>> +
>>> +	scoped_guard(spinlock_bh, &qp->direct_lock) {
>>> +		if (qp->direct_state == NTB_DIRECT_DOWN ||
>>> +		    qp->direct_state == NTB_DIRECT_QUIESCED)
>>> +			return;
>>> +		if (!qp->direct_peer_session) {
>>> +			/*
>>> +			 * No peer session means RX publication and TX
>>> +			 * submission never became active.
>>> +			 */
>>> +			qp->direct_state = NTB_DIRECT_QUIESCED;
>>> +			return;
>>> +		}
>>> +		qp->direct_state = NTB_DIRECT_QUIESCING;
>>> +	}
>>> +
>>> +	/*
>>> +	 * Keep the mappings until the peer acknowledges the final boundaries,
>>> +	 * or until the link is down or the peer starts a new session.
>>> +	 */
>>> +	for (;;) {
>>> +		ntb_direct_control_progress(qp);
>>> +
>>> +		scoped_guard(spinlock_bh, &qp->direct_lock)
>>> +			done = ntb_direct_tx_idle(qp) &&
>>> +			       ntb_direct_tx_acked(qp) &&
>>> +			       ntb_direct_rx_drained(qp);
>>> +		if (done || ntb_link_is_up(qp->ndev, NULL, NULL) != 1)
>>> +			break;
>>> +
>>> +		msleep(NTB_DIRECT_TEARDOWN_RETRY_INTERVAL_MS);
>>> +	}
>>> +
>>> +	guard(spinlock_bh)(&qp->direct_lock);
>>> +	qp->direct_state = NTB_DIRECT_QUIESCED;
>>> +}
>>>  
>>>  /**
>>>   * ntb_transport_rx_queue_size - Query the RX queue depth
>>> @@ -1204,6 +1440,9 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
>>>  	qp->direct_rx_cons = 0;
>>>  	qp->direct_tx_issue = 0;
>>>  	qp->direct_tx_cons = 0;
>>> +	qp->direct_session = 0;
>>> +	qp->direct_peer_session = 0;
>>> +	qp->direct_state = NTB_DIRECT_DOWN;
>>>  }
>>>  
>>>  static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>>> @@ -1221,6 +1460,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
>>>  	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
>>>  
>>>  	cancel_delayed_work_sync(&qp->link_work);
>>> +	ntb_direct_quiesce(qp);
>>>  	ntb_qp_link_down_reset(qp);
>>>  
>>>  	if (qp->event_handler)
>>> @@ -1457,6 +1697,7 @@ static void ntb_qp_link_work(struct work_struct *work)
>>>  						   link_work.work);
>>>  	struct pci_dev *pdev = qp->ndev->pdev;
>>>  	struct ntb_transport_ctx *nt = qp->transport;
>>> +	bool direct_ready;
>>>  	int val;
>>>  
>>>  	if (!qp->client_ready)
>>> @@ -1466,13 +1707,17 @@ static void ntb_qp_link_work(struct work_struct *work)
>>>  
>>>  	val = ntb_spad_read(nt->ndev, QP_LINKS);
>>>  
>>> +	if (qp->direct_state == NTB_DIRECT_DOWN)
>>> +		ntb_direct_session_start(qp);
>>> +
>>>  	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
>>> +	direct_ready = ntb_direct_control_progress(qp);
>>>  
>>>  	/* query remote spad for qp ready bits */
>>>  	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
>>>  
>>>  	/* See if the remote side is up */
>>> -	if (val & BIT(qp->qp_num)) {
>>> +	if ((val & BIT(qp->qp_num)) && direct_ready) {
>>>  		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
>>>  		qp->link_is_up = true;
>>>  		qp->active = true;
>>> @@ -1559,6 +1804,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
>>>  	spin_lock_init(&qp->ntb_rx_q_lock);
>>>  	spin_lock_init(&qp->ntb_tx_free_q_lock);
>>>  	spin_lock_init(&qp->ntb_tx_offl_q_lock);
>>> +	spin_lock_init(&qp->direct_lock);
>>>  
>>>  	INIT_LIST_HEAD(&qp->rx_post_q);
>>>  	INIT_LIST_HEAD(&qp->rx_pend_q);
>>> @@ -2054,6 +2300,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
>>>  	dev_dbg(&qp->ndev->pdev->dev, "%s: doorbell %d received\n",
>>>  		__func__, qp->qp_num);
>>>  
>>> +	if (ntb_direct_control_pending(qp))
>>> +		ntb_direct_control_progress(qp);
>>> +	if (!qp->active)
>>> +		goto clear_db;
>>> +
>>>  	/* Limit the number of packets processed in a single interrupt to
>>>  	 * provide fairness to others
>>>  	 */
>>> @@ -2070,7 +2321,11 @@ static void ntb_transport_rxc_db(struct work_struct *work)
>>>  		/* there is more work to do */
>>>  		if (qp->active)
>>>  			queue_work(system_dfl_wq, &qp->rxc_db_work);
>>> -	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
>>> +		return;
>>> +	}
>>> +
>>> +clear_db:
>>> +	if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
>>>  		/* the doorbell bit is set: clear it */
>>>  		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
>>>  		/* ntb_db_read ensures ntb_db_clear write is committed */
>>> @@ -2080,7 +2335,9 @@ static void ntb_transport_rxc_db(struct work_struct *work)
>>>  		 * ntb_process_rxc and clearing the doorbell bit:
>>>  		 * there might be some more work to do.
>>>  		 */
>>> -		if (qp->active)
>>> +		if (qp->active ||
>>> +		    (qp->client_ready &&
>>> +		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
>>>  			queue_work(system_dfl_wq, &qp->rxc_db_work);
>>>  	}
>>>  }
>>> @@ -2128,10 +2385,7 @@ static void ntb_tx_copy_callback(void *data,
>>>  	dma_mb();
>>>  	ioread32(&hdr->flags);
>>>  
>>> -	if (qp->use_msi)
>>> -		ntb_msi_peer_trigger(qp->ndev, PIDX, &qp->peer_msi_desc);
>>> -	else
>>> -		ntb_peer_db_set(qp->ndev, BIT_ULL(qp->qp_num));
>>> +	ntb_transport_notify_peer(qp);
>>>  
>>>  	/* The entry length can only be zero if the packet is intended to be a
>>>  	 * "link down" or similar.  Since no payload is being sent in these
>>> @@ -2586,6 +2840,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>>>  
>>>  	cancel_work_sync(&qp->link_cleanup);
>>>  	cancel_delayed_work_sync(&qp->link_work);
>>> +	ntb_direct_quiesce(qp);
>>>  	qp->active = false;
>>>  
>>>  	if (qp->tx_offload_thread) {
>>> @@ -2636,6 +2891,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
>>>  	/* Catch cleanup queued while draining RX processing. */
>>>  	cancel_work_sync(&qp->link_cleanup);
>>>  	cancel_delayed_work_sync(&qp->link_work);
>>> +	ntb_qp_link_context_reset(qp);
>>>  
>>>  	qp->cb_data = NULL;
>>>  	qp->rx_handler = NULL;
>>> @@ -2822,6 +3078,7 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
>>>  		return;
>>>  
>>>  	qp->client_ready = false;
>>> +	ntb_direct_quiesce(qp);
>>>  
>>>  	val = ntb_spad_read(qp->ndev, QP_LINKS);
>>>  
>>> @@ -2927,7 +3184,9 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
>>>  		qp_num = __ffs(db_bits);
>>>  		qp = &nt->qp_vec[qp_num];
>>>  
>>> -		if (qp->active)
>>> +		if (qp->active ||
>>> +		    (qp->client_ready &&
>>> +		     READ_ONCE(qp->direct_state) == NTB_DIRECT_HANDSHAKE))
>>>  			queue_work(system_dfl_wq, &qp->rxc_db_work);
>>>  
>>>  		db_bits &= ~BIT_ULL(qp_num);
>>

