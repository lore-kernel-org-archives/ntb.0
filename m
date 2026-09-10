Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD213AEF24
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013342; cv=fail; b=lFTy3UeFL1b/XPtZAFdCG2PFYKkV3siIS8vv1pWsijkMpvyLtB57X4PL380sWA8BUr1vY46ubl/5K1ueC8ekl8CxvOh9MjctT9ozjy767dajlSu5PYmfY8x1KCsu572kSnJhj0/vBLiKS48z2KzVgemdNDomanCUlU5P3D0P74c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013342; c=relaxed/simple;
	bh=LzZ/S6fr4pq6Vx0UFFs9OqTCzGf8Phd4I1o606otv9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kJ8atSeH4523G8bB0dqcFRQrZro2Qx6YmY33vIz64nue3Yhtu0bp0CAMmLv2xBzYrsb5jjdBzg+ROUVbtRsncWhwV5kAJpmxTFbrLTEsLZ+S704jVn0CgC+D3kph0C3T9zpdptrtqnBJzVnRwX7pegSouWPJw11cJFzHNb++RCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UX5RiT9N; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UX5RiT9N"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qbcam9GXvJTc3dspTZGkrF63RiDiGfkTxnq++Y7qfmcLENn/n9QefHAlXKJ8JykwRoy7BjVyfoZaD+wYWWYZVEdrCjHM+kJox479qC9lITHENmE19kM/5RclqDAIHIWSoXKKjH6GqIArEigpWxEf/Z62s8hDf66I6TxzSbSBHbhihxTFgk6GwU0ZHBJ0QE53/3DRVZ8GjVh8mAIHsTy4WHOSRo1R5zcF4gn32H7wJ4WomjMeYICmJTLL39e0DYCcHH7+tCKfi8Tm6WqGnWhIfJP0NGajTr0Hz5+0sYADAxAtcGrCfheiQoZ8zO94Mo510roTvILoiAG4IwQ/IpglAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q0lt+/dAMi/3+qZQpvfWj7KiwEM6ly8S8r1Gz1hTEr8=;
 b=iLsOV2+Bah+kY8hMO/iz7Ok8ebg6Ycfj3UsK+L7xY8/zOMTNx+CAbhDzqvk5OMS6jgagIGyeWzs7PrxaWbdVw2jR8LRLOw+KahoYc40G2ukE8hNlV1kPVl6ffmqltaJYXeIpUfHVr6Q+1hqiv9hDUvluwnVwMOQcI8uexuNiZy0hOaXIt0QGOSANwL/IgI0B17EieYcjY2LMKwrMymHPTtxnswyDnSvPQM2M1evy62WbjiacWNiuxyxxhP8f76pwThc1FI1E7YaSFoUDn92O5wwhG7o29xOggW+Tj+pbRj9L+iQMLApOUeh/cGHJtCCdie/cxZ4Y3r7A5Dp8SmQc1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q0lt+/dAMi/3+qZQpvfWj7KiwEM6ly8S8r1Gz1hTEr8=;
 b=UX5RiT9N8v4ZSPt+dfZyP6pCUopxoYJhuCJmBSyuu8LjDiNxYER96kEzyGk7XzrgsFGB9jp4vwZgo+Qd5ID/aSDx21ROQmfb1rPhTVfgGF+zMuKcg3Y8++vXM3G93/3aiK3Q8GccnuBatxfgYwEDeU0+93L9ch91583TLzJDyRs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:49 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/14] NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
Date: Thu, 10 Sep 2026 13:08:30 +0900
Message-ID: <20260910040836.3792333-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: b36fc92a-0afa-4d22-9b62-08df0ef13711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	shZkw4clLpTRLjI7Yh0eMZ8O9lgCJnMtaXVoEeSTraVUKvHP9REb5IOYQ7IzW9gBHEskBsUEkna3smvPPYNRJ0ur4uMOrefJJrrpeeebHwsCHv4M9Owp7scCskGElVSIfv9xCM3cwLuyK1+hy/TPOvnX9K9Q7SzfcSuph8bmou6L9lcN/80LwEEqos8nKSc05QF/pO+8opB0LNLSz2HDF+8tkmSSBpySPyQqFlcvFXQWN6c3Xx8j36c+cVHH82IlKOg+qN+4uWoQrJmYbAldamEeJnwTxy2zxEt7zVZD5DtIQB6negtXIlFcTUyCpAzqi1JWW7ZeIAI3s1o8Wbjtv9NLltJV4i0q2VBxGqnx2xE9s7wFKJM/1FyYgsqq/aq/hYOf0lSXJvztB9P08+93JDtHPs3sy/JRTOJ3ql3nOitsZ4jITiIynlt5ELAZ5rTmZb8Z25TR7MJEdIPw65a91MEA+H9tox0fMe1PLCqlrhtTsDYG0hI0TCFw/roYZ7JemzqldXSmYmW4JgRgw84iVo9zFPUmjV8k0xYPhR2wwH82yJTZsCxMCjwc051EDbmS9zTgKuNMjrv0Hg1TXmfJCmVG8HZPUPp8bsQcMq1bWLajtDpXvYtHso1uhWZLzOMoJzLtpBPvHK7fVc6Rl3WfYued2PHbaLVBDfePZxQ/oJc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XN26zlKeR2mOf7iBTDv8JxkgRju3yJUZzl9CPo5aNC+EQQj3E+eXHHeXsp4s?=
 =?us-ascii?Q?5p4xpmfIpRaiUJCa+nPJmkGXH0jG0ZBhPfTQKKfuexyQ1hrLQd0k5noibkab?=
 =?us-ascii?Q?Z+LqCdmOw0MGXeIr1VxZVSJYRp9oCySPsVN4EVGj9N/yvbYNoirTTHlUZ8aF?=
 =?us-ascii?Q?t6IwDa/7s+Pu4MmxCUBvEQRGxuoJZMgysq5XndX30HtfVRnf5eOTCVeJpM0O?=
 =?us-ascii?Q?gp8LafErzMFE6HocKsdW9vZRjyRyyC9gOs5ILq7N/7EhdJM99mNr+LQ7278g?=
 =?us-ascii?Q?l8gib3z9XGAQ3xOKcgKOY0rzJ/qnm+jeOjFhG+ShrFuWRjsVuSaW0bmsoDjE?=
 =?us-ascii?Q?rH9rSZapxFbHPLO3MriQADCsw58OtpSA9gjCsLtFyghdh71bXxj0/GCFSEvF?=
 =?us-ascii?Q?YohVvkmEluW5yHbBALfNPyDMOc6NpMVM7OixketDzBtqMwmMNq1h/U+kztHI?=
 =?us-ascii?Q?o7OVRPMQiofFhpg2Ao+upKY4gm3Lu/x+DEVQVrkPOK1VS4VB8kAhRy2Wc6dM?=
 =?us-ascii?Q?45ZfmhQCH3HcXO8zU4OVj2HWHwxdLKhhFIAJCvt7xwuOt7r/4YyTVpnr3qXd?=
 =?us-ascii?Q?vuDIu5ZRf496MOiqtQ6U6VPjHrzWFyVIaOlGNrlI1mgyoaOLdYYL6AQZ5rLg?=
 =?us-ascii?Q?hy+uNxsxhkYF/zabTdWx/014Is+tXmUiPa/4vnlQEn7fua+7ZTzOLfzb1yOj?=
 =?us-ascii?Q?Fx6JzT2Y660Dq5lAOLDRgl7FfjRtfJfjhViM8Nz/QGxFG08rDA0PMDEqb6BA?=
 =?us-ascii?Q?cHdGL4u/8/JocJqRna0WWjGKwxWieub77lEhwmqgJqXp0lCxGB0ZJNXn/5v/?=
 =?us-ascii?Q?PXNIMdXlxtOmndHC8wyN/2w7rjOvoa38hWvV+7Up1Orl1p9MD2H1cqdKZUPh?=
 =?us-ascii?Q?QJGPd3gXOexPW9RVhBiha5UolXu8dBe5Ua68lzjjP/FRNMEIAfLEUS2yohVu?=
 =?us-ascii?Q?qtHMSCEC4NPfajR3rD7M2QUF9Ck8D/6p+XP6MWoKHXkA/icccJqn+PZqATcT?=
 =?us-ascii?Q?EAPELJftDqPpA3JV72Yy8cZxpj5CKqS5PB9vVxwd0YWFTIANkga20rn9yol5?=
 =?us-ascii?Q?04kH3JvB4iEN3bH3CqRMozNrkVXnrbD2uH/O7U1Q/5JQsYcNfGyqeP/dvSBI?=
 =?us-ascii?Q?fnz5isQWG2bUH8Bzimos3nBxe/Qjuz6ltaa0YVDAzdW+nv6iAgXRjGk3m1iU?=
 =?us-ascii?Q?V9NuMa1Xp73eYEdHDHrNiTpYwdbSoXRpuI5BPWkpcyIFq8w6GjJqyEO9Dc6O?=
 =?us-ascii?Q?5NDCHbQ5UIZRs06tLUI3GMoXZvMnS7yagvhajqRTzlKEWNYn8RtjC37UKCEH?=
 =?us-ascii?Q?Ato3yai2uEJidEbXJ1l9x7lhCUkGwPmcEg3/w97ZAViQ3UtmYwTvuKTfsTMy?=
 =?us-ascii?Q?DyHL09OlezVIT54tWLOlXS1it6uU8cCbWK9NTeszheIiY+YzCPN5qO9O+1Rz?=
 =?us-ascii?Q?AU+7kkxAQKq+tPP62BfDVylUv3crmeSSYyT3tlV2vGtA4sTzv0cS0cjWs8Vb?=
 =?us-ascii?Q?Xu+8ROzzG05TUO5AvYPzrE8jJhoC3xKXyFriu648UN/cj0YkrwgqtNRd32Wp?=
 =?us-ascii?Q?kpMxDyPEGFnpG/cgZSmPOXEVjpZNRKxgWcu+XkFM3WUXY2RwTLdD4nsloFAW?=
 =?us-ascii?Q?K0luv5mDnW7whDjnOlA22BC0DnO/xfVtkRv0DCRNc9L+wq+17WVs8MuldGV+?=
 =?us-ascii?Q?gsXKVyuzgEyy8Y/LlST44UBty4yCFn6NnPLJlDWZMXstR1w6Jrk32PdoBut4?=
 =?us-ascii?Q?IU8PT/tt8L7XR/TnaTAZ9Ekbz3U0JD+shJ+xstBWsY8vIZNtk4BS?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b36fc92a-0afa-4d22-9b62-08df0ef13711
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:48.4574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eaoZ2P51BZzW8pQLea2tp4kKkx5+fzZkquyXkAd0UGAC2RTn70n3HBgSczY3E+VgmvP5c5OPfVN/zmEPuBuVig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

A caller can read qp->active before teardown clears it, then schedule
the RX tasklet after tasklet_kill() returns. The MSI handler does not
check active at all. Teardown also releases DMA channels before
draining the tasklet.

Protect active updates and the check-and-schedule sequence with
rx_sched_lock, including the MSI path. Clear active under the lock,
then drain the tasklet before releasing DMA channels or queue entries.
QP link work is already disabled, so it cannot reactivate RX. Use a
separate lock to avoid contention with RX list operations.

Fixes: e902133162af ("ntb: stop tasklet from spinning forever during shutdown.")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 50 +++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index e5599c7ca93f..45d4365becac 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -179,6 +179,8 @@ struct ntb_transport_qp {
 	unsigned int rx_max_frame;
 	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
+	/* Protect active and RX tasklet scheduling. */
+	spinlock_t rx_sched_lock;
 	struct tasklet_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
@@ -649,11 +651,26 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static void ntb_transport_set_qp_active(struct ntb_transport_qp *qp, bool active)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	qp->active = active;
+}
+
+static void ntb_transport_schedule_rxc(struct ntb_transport_qp *qp)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+}
+
 static irqreturn_t ntb_transport_isr(int irq, void *dev)
 {
 	struct ntb_transport_qp *qp = dev;
 
-	tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return IRQ_HANDLED;
 }
@@ -895,7 +912,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
 
 	qp->tx_index = 0;
 	qp->rx_index = 0;
@@ -1159,13 +1176,12 @@ static void ntb_qp_link_work(struct work_struct *work)
 	if (val & BIT(qp->qp_num)) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
-		qp->active = true;
+		ntb_transport_set_qp_active(qp, true);
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else {
 		ntb_transport_schedule_qp_link(qp,
 					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1193,6 +1209,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
+	spin_lock_init(&qp->rx_sched_lock);
 	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
@@ -1729,8 +1746,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
@@ -1741,8 +1757,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 		 * ntb_process_rxc and clearing the doorbell bit:
 		 * there might be some more work to do.
 		 */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	}
 }
 
@@ -2209,7 +2224,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	disable_work_sync(&qp->link_cleanup);
 	disable_delayed_work_sync(&qp->link_work);
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
+
+	qp_bit = BIT_ULL(qp->qp_num);
+	ntb_db_set_mask(qp->ndev, qp_bit);
+	tasklet_kill(&qp->rxc_db_work);
 
 	if (qp->tx_offload_thread) {
 		kthread_stop(qp->tx_offload_thread);
@@ -2251,11 +2270,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		dma_release_channel(chan);
 	}
 
-	qp_bit = BIT_ULL(qp->qp_num);
-
-	ntb_db_set_mask(qp->ndev, qp_bit);
-	tasklet_kill(&qp->rxc_db_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
@@ -2350,8 +2364,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return 0;
 }
@@ -2548,8 +2561,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp_num = __ffs(db_bits);
 		qp = &nt->qp_vec[qp_num];
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 
 		db_bits &= ~BIT_ULL(qp_num);
 	}
-- 
2.51.0

