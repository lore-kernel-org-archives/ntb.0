Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263A442CAF8
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380729; cv=fail; b=jjvGkvLCVukp0gUHnzjnYWwyqFN5R3KyrzHKBSm606EzgvMEeNbh+FTT2cwlNM6Ay0bcKpvEJYyBHIS0UQ+hfGilvHtzzzqLHlTXmLGGH6F3oAlUqcUjO1+gnAOEpChIXIS4kvbvR5jPW1htzdyhdY0J36KwrT5rT5cdTMPg5Zg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380729; c=relaxed/simple;
	bh=ZYSCK8van3aWdAW/2KCYqYGK7/JYPP3/eVnzRp2OnE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OBmf9FpEPeAjw9CmKWXn5XeHHviFhWMqK0es+rfg4hyrxH6pMzhjqGhCo+R7ceUA2RRRy7pwiBzL9g5A0lJljhfxZ5sIZFaVmvXMsopAhAxuwLywwY7nmtmhzl7QMCexWQ6VXr+VHOiZpXX1He1dsGTUyiYeuoDt/U6NL6/v16g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=YYnallj1; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="YYnallj1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Os2yG4sn9qAH+1LAOCV/mvBv+mElZsvrTFOQZc78NX7ckREWuFQAgttcGa/I0yLfLCaeCu0zOyG1LuHxvRivVrL/L7ZTS9iVJcK6FWQZ97YYf+FnHJmmkkBngI2yqG2INXw3Mg6ZDSj6f72OZQEFXAC2FLjZUNmCFPNpvctlhpuYp+sSq9kGiwXk2uDM4Whd+Z9y0TGAHXB97L0AfmLnYsbDinmOWB2BgccRf/wWQWU1V7EYMJ9Rl+O8jWiM3kJzfVSD8byfeWO477DfYl1+h4x8Ud5teb/1Igft2sPS+9c4dOOz06PSOV+k6sDgZqayOui3YdAcwkOXoU0cSPNfUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/APW5FMD/4wx4Vqy6T5PqK1DqBfwfnrGU8bGaS6dUSQ=;
 b=H/kje95APDB9Z+EP5shV8mTuDyaSVuRfSwkoCcMn6bUQkm7eNz0uRKNHkoN1Flmx8TKQhRQZCv5dlrJub/nIMB8Y7up1nIfRab1pkfNrcXzmpCVjLJwoXUmXyBdKpcBTwKzUvcFzEyr87b4WkVsj0eA5LutF6F5gH2jrbbU3BDogADMih7M/bAY5wTp1A/en+/Hab5HKFhTFsWp8yLcZAlTOgylcaBmiXCfl8PWLgWfTeqVNcQaYeV3reQXlcgGRAG+NSnDRRVW0SIuR5Hol1hM7ivYRO6heWxGrEVeX0Vqk6YEb5t+P++rJkfBoLpWIDx0Bh7r3sSrgZVQ6my2hqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/APW5FMD/4wx4Vqy6T5PqK1DqBfwfnrGU8bGaS6dUSQ=;
 b=YYnallj1/0idNghIjplgHj2HDEYGIEjc/uEyX99rRf8VNv/7XDrXk0YN6/8TOmUqWNgLAIwhP9Ya/2XNCQfxKnpf2aZqdWDFH2TXyDR0x/2yTzuYCkPHha/XBUC4mWaXp4auULTuLSvXfKhPHkk208/AtMnls2JbI/ZWJJV+qCI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:53 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 12/16] NTB: ntb_transport: Implement direct-DMA TX submission
Date: Tue, 11 Aug 2026 01:51:31 +0900
Message-ID: <20260810165136.2292436-13-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0064.jpnprd01.prod.outlook.com
 (2603:1096:405:370::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cbb3cb3-c8e3-4517-3e3b-08def6ffae39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	u2eE/fwfk7tlexexP8r2Y4ysSj/hLYGtwpT6D0o+t2l7eqQaCyVvfJEywLyei0Y0QOVckAfsaMZ8KQn7VIPutlPB0mj26els0yu8WMkcjcszzsSpAwT70Vw42vrGwmffAP156p2kc46nq4A1UV+7gaQSfDzyCSpzg23b1NFLa/i7PE5/SSHoRKIh1TLglP26FDE8STWwVUroAZRlFctuGGRWiUoO/i74Jder23f5HM1REWF2TsSqueFlDfI//1fggDda0OAsN+7dYvk3nNQhyHVySRXx98cHJ93ZrdnNqLOQ2LPtoxFvjwi5QLfgfpsV0NVDBGtkNk5AMsuE8HttipSN+WlEzBAFXTte8DLEK1TfgBFZ+HmWg82c2tA9nYICjC1KHVlwDkVCvK/9CHKhkPtpll/AtZIIFOmASMo9F2ALiEXUO0aTWrr3k2bjhoVQAIVHI54TJ6RWjwLHiV6d/aaj+FK36f8vSpnyi9ZKG8Oj71IAzgKSwV3L5b760yIz2xefPAGVj3HgTWtdplHp3FRBrsuFLEilp3/P8LurgY5CDsRG7NsFFo2Md76QlHnH/VofTL7OYxUMzAsidVZyJNOL2X88tzkVSKWFYhCu9bndUKjnFPZ0ahv5Cl6ufJ/g9GX9ftO9FPpg508XchDcTJKReZQlSuUanFFgSxjVcuU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VxJ8aVvkEQfU7jnXWJ2DJUzre42W8X/1DSmV/DI75MIk3qX8BRxpsEt40HqZ?=
 =?us-ascii?Q?geGCC68HyScx8OGIhYnrLNSyXZb1B83Ij13jIaKNNAyg13o1hgjvkmbi/BkJ?=
 =?us-ascii?Q?k/ujKeTP7LQ8PO2NterZ7jViFuH5x3WuOTuDOHUn4ymSPkxpqbH53ASEgc3h?=
 =?us-ascii?Q?hSnm9XsEOH0Kx+irm8b0T9VD+zG9GLX1Xtn8OZmHtkO3VP/HUQcFGpFPJUK2?=
 =?us-ascii?Q?01tAGx+Qsn7RkJ+3vYsdXTWVLQagFIJj9K8kLnyC920U8ypLfkwXlrPYQN7V?=
 =?us-ascii?Q?ETurD/eQHvuP5KtfLGmdE1HkwmXfXV5jC/GrNo2tkxcN4R2aAnVuUgiL30sg?=
 =?us-ascii?Q?EN5fQjWShPcHIZvNRuxku1KN9lrSc0B5WvY6Smvm/4FlG3LMxEot6ou90E/H?=
 =?us-ascii?Q?L6yOxjt4pWOJkjp0f6zFa/e9ZMJTkOyymD+MuvlKg8TqWAl2mVFN1sz1d0SX?=
 =?us-ascii?Q?rUm9DpAer0AMLmqTxIfxmUO1zNV6O6PmOlbti3sa+uZU7O9kjmnLj12gjw+g?=
 =?us-ascii?Q?LhYe/zVy629CRv7q6kiNx0JJ9LS2tteI8+w0DoBxfxLJBJno2WtQp184ilRt?=
 =?us-ascii?Q?TIQJQf545e2PkcP8o68wmuQAlYCUdiZPQlfxWkhRV29gNEjVB9dllXNxGynU?=
 =?us-ascii?Q?gBxOuVtz1DmEL8kT+O8j9e+0Qe2r8VVh2T5me2mqGJj8YNw0+89pREgsqSim?=
 =?us-ascii?Q?rXgTDlEohvxzMZWNTQs6Qt/yM7LL+3W6Nk1sMtwFvmVij74oUV5cM7fE7d/H?=
 =?us-ascii?Q?iv5TlzlNeubnTYNgWyDXR84na4s6S8U6CT5afJvlBytG/v63Ik3Y9eWoVZNE?=
 =?us-ascii?Q?YfUSfc1Pdx16Cks1yklf9nuskpNdn2rVitKYvMlDo5JHAkZRmH2+DXqmUMSl?=
 =?us-ascii?Q?aAA1kDcgGIN93yC4ZvAWZ1KX2Ulcd3+awjQwQ6AbHEID2SLPkVW5SZXpf/1Z?=
 =?us-ascii?Q?XidG8pncDBf5WoIST4O7vl6sgd6gvddrUTR6oehkPXGy9wwXQBTMb4PxGJPd?=
 =?us-ascii?Q?XVwkAZNa49xMgJvvADiuS1bAMeYlF+3olDLhQogO0YmJkulNNbL+KyW8TKMn?=
 =?us-ascii?Q?RdZb2AoM7Bd4i6tditqXZVYJFGlsL1klp3M/yRSAjNm9eOQ5+7THp1zSxFhj?=
 =?us-ascii?Q?RiRdfxVrED+r8bIFle7orpyMPoC95XfQeo7WeZ5xF2UqsTcIqpQVjERRCLF7?=
 =?us-ascii?Q?wHtQg5VUgWQPlxkXBK546EsP3kVwtLAUqBCARAVG66gX0X9Z4wgb36DtktGl?=
 =?us-ascii?Q?seuEEdrTpBcdKA0he07xyRAzIa1009hE11G74naHCoBrzPBbxH4MJaE8prin?=
 =?us-ascii?Q?Dou3TNKgmOFF6xz1sWTnfP9h8ueve5Oz9OX5xs/exfiZ6N7MMm0a8R0+//yY?=
 =?us-ascii?Q?+D/m8+oImQHyffnZm30iqvZu8nUy0lcWzKawENCaRCwIFKQbDUEwsuYZvfcY?=
 =?us-ascii?Q?H9cBZx5jj9MmGWbJhikNdweYfSDEr0MZYvkJbRTXqfeKhJgADMSHuIkGZaza?=
 =?us-ascii?Q?76jUTdD/Zg3NX/d9lomdGpX+VdLLtEHUsaBURB+GJhvCTnYoo9fvZ7ZOB0rV?=
 =?us-ascii?Q?JXoH3OolmysWdZb8gCWAWRQdTCRZVwX2YtOwM+C1wNZFIqwGf3x6BKTi/dcl?=
 =?us-ascii?Q?3aKCCh4ijS5bT4DH5ka+5h+YyOvESEGUxtYiRKF60r8/bLuyg2ASdQa4H+z0?=
 =?us-ascii?Q?KSqNpGiUldmEP25sq3IdOuu58xWJ6pJodfEx6zEzdgmstMvpahi+AR7JTDl2?=
 =?us-ascii?Q?6rgiE6qhwhDdQcOvE+go685P6U8N4U8diTPtMHNi7sLiugIS/GRE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cbb3cb3-c8e3-4517-3e3b-08def6ffae39
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:53.3753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: klbR1I8SIvtt7KYx2QbFieBZOaEJC79LtfpRIwq8P5sTzJNtQ17gyUBpOmuZBHE2yq1QbwBP655INZQtIVtEfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Completing a payload and then writing its completion from the CPU does
not guarantee that the peer observes those writes in the same order. It
could release the RX buffer while the payload is still in flight.

Submit each payload and its completion word on the same in-order DMA
channel. Track source mappings in ring order, and keep outstanding
mappings owned by the queue after a DMA error so teardown can stop the
channel before releasing them.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 263 +++++++++++++++++++++++++++++++++++-
 1 file changed, 258 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 152400feb6d6..4c4741b8f9b1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -213,6 +213,8 @@ struct ntb_transport_qp {
 	struct list_head direct_rx_q;
 	u32 *direct_rx_cpl;
 	dma_addr_t direct_rx_cpl_dma;
+	/* Entries on the direct RX/TX queues own their DMA mappings. */
+	struct list_head direct_tx_q;
 	u32 *direct_tx_cpl;
 	dma_addr_t direct_tx_cpl_dma;
 	u32 direct_rx_prod;
@@ -222,6 +224,7 @@ struct ntb_transport_qp {
 	u32 direct_session;
 	u32 direct_peer_session;
 	enum ntb_direct_state direct_state;
+	bool direct_tx_failed;
 	void *rx_buff;
 	unsigned int rx_index;
 	unsigned int rx_max_entry;
@@ -707,6 +710,7 @@ static void ntb_direct_session_start(struct ntb_transport_qp *qp)
 	guard(spinlock_bh)(&qp->direct_lock);
 	qp->direct_session = session;
 	qp->direct_peer_session = 0;
+	qp->direct_tx_failed = false;
 	qp->direct_state = NTB_DIRECT_HANDSHAKE;
 }
 
@@ -1452,6 +1456,7 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 	qp->direct_session = 0;
 	qp->direct_peer_session = 0;
 	qp->direct_state = NTB_DIRECT_DOWN;
+	qp->direct_tx_failed = false;
 }
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
@@ -1830,6 +1835,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	INIT_LIST_HEAD(&qp->tx_free_q);
 	INIT_LIST_HEAD(&qp->tx_offl_q);
 	INIT_LIST_HEAD(&qp->direct_rx_q);
+	INIT_LIST_HEAD(&qp->direct_tx_q);
 
 	INIT_WORK(&qp->rxc_db_work, ntb_transport_rxc_db);
 	INIT_DELAYED_WORK(&qp->direct_rx_retry, ntb_direct_rx_retry_work);
@@ -2743,6 +2749,15 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	return -ENXIO;
 }
 
+static unsigned int
+ntb_transport_mw_tx_free_entry(struct ntb_transport_qp *qp)
+{
+	unsigned int head = qp->tx_index;
+	unsigned int tail = qp->remote_rx_info->entry;
+
+	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+}
+
 static void ntb_async_tx(struct ntb_transport_qp *qp,
 			 struct ntb_queue_entry *entry)
 {
@@ -2756,7 +2771,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	hdr = offset + qp->tx_max_frame - sizeof(struct ntb_payload_header);
 	entry->tx_hdr = hdr;
 
-	WARN_ON_ONCE(!ntb_transport_tx_free_entry(qp));
+	WARN_ON_ONCE(!ntb_transport_mw_tx_free_entry(qp));
 	WRITE_ONCE(qp->tx_index, (qp->tx_index + 1) % qp->tx_max_entry);
 
 	iowrite32(entry->len, &hdr->len);
@@ -2780,10 +2795,229 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	qp->tx_memcpy++;
 }
 
+static bool ntb_direct_tx_enabled(struct ntb_transport_qp *qp)
+{
+	return ntb_direct_tx_mode(qp) &&
+	       READ_ONCE(qp->direct_state) == NTB_DIRECT_ACTIVE;
+}
+
+static int ntb_direct_tx_publication(struct ntb_transport_qp *qp, u32 issue,
+				     dma_addr_t *dst, dma_addr_t *cpl_dst,
+				     unsigned int *len)
+{
+	struct ntb_direct_shared *shared = qp->direct_shared;
+	struct ntb_direct_pub *pub;
+	u32 head, idx, used;
+
+	lockdep_assert_held(&qp->direct_lock);
+
+	head = READ_ONCE(shared->pub_head);
+	used = ntb_direct_ring_used(head, issue);
+	if (!used)
+		return -ENOSPC;
+	if (used > qp->direct_ring_entries - 1)
+		return -EPROTO;
+
+	/* pub_head is written after the publication slot. */
+	dma_rmb();
+	idx = ntb_direct_ring_idx(qp, issue);
+	pub = &shared->pub[idx];
+
+	*dst = (u64)READ_ONCE(pub->addr_hi) << 32 |
+	       READ_ONCE(pub->addr_lo);
+	*cpl_dst = ((u64)READ_ONCE(shared->cpl_addr_hi) << 32 |
+		     READ_ONCE(shared->cpl_addr_lo)) + idx * sizeof(u32);
+	*len = READ_ONCE(pub->len);
+
+	return 0;
+}
+
+static void ntb_direct_tx_complete(struct ntb_transport_qp *qp,
+				   struct ntb_queue_entry *entry)
+{
+	int cb_len;
+
+	cb_len = entry->errors ? -EIO : entry->len;
+	if (!entry->errors) {
+		qp->tx_bytes += entry->len;
+		qp->tx_pkts++;
+	}
+
+	if (qp->tx_handler)
+		qp->tx_handler(qp, qp->cb_data, entry->cb_data, cb_len);
+	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
+
+	if (ntb_link_is_up(qp->ndev, NULL, NULL) == 1)
+		ntb_transport_notify_peer(qp);
+}
+
+static bool ntb_direct_tx_fail(struct ntb_transport_qp *qp)
+{
+	bool cleanup = !qp->direct_tx_failed && qp->client_ready;
+
+	lockdep_assert_held(&qp->direct_lock);
+
+	qp->direct_tx_failed = true;
+	qp->direct_state = NTB_DIRECT_QUIESCING;
+
+	return cleanup;
+}
+
+static void ntb_direct_tx_callback(void *data,
+				   const struct dmaengine_result *res)
+{
+	struct ntb_queue_entry *entry = data;
+	struct ntb_transport_qp *qp = entry->qp;
+	struct device *dma_dev = dmaengine_get_dma_device(qp->direct_dma_chan);
+	bool error;
+
+	error = res && res->result != DMA_TRANS_NOERROR;
+	if (error) {
+		bool cleanup;
+
+		scoped_guard(spinlock_bh, &qp->direct_lock) {
+			entry->errors++;
+			cleanup = ntb_direct_tx_fail(qp);
+		}
+
+		ntb_direct_control_progress(qp);
+		if (cleanup && ntb_link_is_up(qp->ndev, NULL, NULL) == 1)
+			schedule_work(&qp->link_cleanup);
+		return;
+	}
+
+	dma_unmap_single(dma_dev, entry->direct_dma_addr, entry->len,
+			 DMA_TO_DEVICE);
+
+	/* The channel filter excludes out-of-order completion. */
+	scoped_guard(spinlock_bh, &qp->direct_lock)
+		list_del(&entry->entry);
+
+	ntb_direct_tx_complete(qp, entry);
+
+	scoped_guard(spinlock_bh, &qp->direct_lock)
+		qp->direct_tx_cons++;
+}
+
+static int ntb_direct_tx_submit(struct ntb_transport_qp *qp,
+				struct ntb_queue_entry *entry)
+{
+	struct dma_async_tx_descriptor *payload, *completion;
+	struct dma_chan *chan = qp->direct_dma_chan;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
+	struct dma_slave_config config = {};
+	dma_addr_t cpl_dma_addr, cpl_dst, dma_addr, dst;
+	unsigned int published_len;
+	bool schedule_cleanup = false;
+	bool terminate = false;
+	u32 issue, idx;
+	int rc;
+
+	if (entry->len > INT_MAX)
+		return -EMSGSIZE;
+
+	dma_addr = dma_map_single(dma_dev, entry->buf, entry->len,
+				  DMA_TO_DEVICE);
+	if (dma_mapping_error(dma_dev, dma_addr))
+		return -EIO;
+
+	scoped_guard(spinlock_bh, &qp->direct_lock) {
+		if (!ntb_direct_tx_enabled(qp)) {
+			rc = -ENOLINK;
+			goto unmap;
+		}
+
+		issue = qp->direct_tx_issue;
+		if (ntb_direct_ring_used(issue, qp->direct_tx_cons) >=
+		    qp->direct_ring_entries - 1) {
+			rc = -ENOSPC;
+			goto unmap;
+		}
+
+		rc = ntb_direct_tx_publication(qp, issue, &dst, &cpl_dst,
+					       &published_len);
+		if (rc)
+			goto unmap;
+		if (entry->len > published_len) {
+			rc = -EMSGSIZE;
+			goto unmap;
+		}
+
+		idx = ntb_direct_ring_idx(qp, issue);
+		entry->direct_dma_addr = dma_addr;
+		entry->direct_cpl_addr = cpl_dst;
+		qp->direct_tx_cpl[idx] = entry->len;
+		dma_wmb();
+
+		config.direction = DMA_MEM_TO_DEV;
+		config.dst_addr = dst;
+		payload = dmaengine_prep_config_single_safe(chan, dma_addr,
+							    entry->len,
+							    DMA_MEM_TO_DEV,
+							    DMA_CTRL_ACK,
+							    &config);
+
+		if (!payload) {
+			rc = -EIO;
+			goto unmap;
+		}
+
+		rc = dma_submit_error(dmaengine_submit(payload));
+		if (rc)
+			goto unmap;
+
+		list_add_tail(&entry->entry, &qp->direct_tx_q);
+		qp->direct_tx_issue = issue + 1;
+
+		config.dst_addr = cpl_dst;
+		cpl_dma_addr = qp->direct_tx_cpl_dma + idx * sizeof(u32);
+		completion = dmaengine_prep_config_single_safe(chan,
+							       cpl_dma_addr,
+							       sizeof(u32),
+							       DMA_MEM_TO_DEV,
+							       DMA_CTRL_ACK |
+							       DMA_PREP_INTERRUPT,
+							       &config);
+		if (!completion) {
+			schedule_cleanup = ntb_direct_tx_fail(qp);
+			terminate = true;
+		} else {
+			completion->callback_result = ntb_direct_tx_callback;
+			completion->callback_param = entry;
+
+			if (dma_submit_error(dmaengine_submit(completion))) {
+				schedule_cleanup = ntb_direct_tx_fail(qp);
+				terminate = true;
+			} else {
+				dma_async_issue_pending(chan);
+			}
+		}
+	}
+
+	if (terminate) {
+		dmaengine_terminate_async(chan);
+		if (schedule_cleanup && ntb_link_is_up(qp->ndev, NULL, NULL) == 1)
+			schedule_work(&qp->link_cleanup);
+	}
+
+	return 0;
+
+unmap:
+	dma_unmap_single(dma_dev, dma_addr, entry->len, DMA_TO_DEVICE);
+	return rc;
+}
+
 static int ntb_process_tx(struct ntb_transport_qp *qp,
 			  struct ntb_queue_entry *entry)
 {
-	if (!ntb_transport_tx_free_entry(qp)) {
+	if (entry->len && ntb_direct_tx_mode(qp)) {
+		if (!ntb_direct_tx_enabled(qp))
+			return -ENOLINK;
+
+		return ntb_direct_tx_submit(qp, entry);
+	}
+
+	if (!ntb_transport_mw_tx_free_entry(qp)) {
 		qp->tx_ring_full++;
 		return -EAGAIN;
 	}
@@ -3377,10 +3611,29 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
-	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	u32 available, capacity, used;
 
-	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
+	if (ntb_direct_tx_mode(qp)) {
+		guard(spinlock_bh)(&qp->direct_lock);
+		if (!ntb_direct_tx_enabled(qp))
+			return 0;
+
+		capacity = qp->direct_ring_entries - 1;
+		used = ntb_direct_ring_used(qp->direct_tx_issue,
+					    qp->direct_tx_cons);
+		if (used >= capacity)
+			return 0;
+
+		available =
+			ntb_direct_ring_used(READ_ONCE(qp->direct_shared->pub_head),
+					     qp->direct_tx_issue);
+		if (available > capacity)
+			return 0;
+
+		return min(available, capacity - used);
+	}
+
+	return ntb_transport_mw_tx_free_entry(qp);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_tx_free_entry);
 
-- 
2.51.0

