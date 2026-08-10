Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846474334AF
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380736; cv=fail; b=ooTfnC4J4uKdnNQlhIzjjfIuZg2QqgncO/1I2+5+ssei8JfdhVK2ZDku5NMhYqzwBIUTpMWKjTaVrcB57X6xwohLHrTiHdMZSXeQdErckoZ2dR92c+x3NNvieBfBf2+WxM9VGkPS7Z0SBsFSnUD2iSzECtSk5U9DSuIkbjkda8M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380736; c=relaxed/simple;
	bh=8YWkWA4MaDPhSv0mSCaqIq1KBD01csge8CjO08BRPes=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EP9uhJgOcZbtlZPPJR7lMJ3xvO8KjZXBFXie3EqDoChmzIK1C+dhabq1p1mYG/7n0xIF/iZuEARJf9CPYoEZuw6cWa1nHX+1thRpuEnGUE66o1LK6bxNO4hZqirgRTqwG0lebfxXgmmqHZnyhuvsMlRmTX3fOMaroUNGF3HQxfc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UN3i/PP5; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UN3i/PP5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsN5KHBdj+bNKC7C/XfmKsljb226ji/xaWhHyPU7EULSRo0tVVQoUA9OUx/Q2ujBkpDXqkM6xZAQnS52uoLNkqwKzFi/QjCUH3EmaENWqw2cjIjn57qgVR4VtbFS93J1LmSCVJTH2oqNL2e/xnzFYG70f5DHYvA3lSZY87Xre309zyIhom3vy79QLIZ2SxxW2XYYIN4Gb1Oh3bUpIVuD6HvXqc8Ibns7U16wf2jlusbFEu/WgIMTZsMuNtOMyfjbTT+cFQJMCB9HKchgdounsR9MJoR+SeUcRBb0QuWTTi4kYpUlY9vffA+dFY5zYVVswjltSZUGKFOtx3wPpIyqpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iF62hONaQn4t7rqOMRi8RUKGGPpU7L2fc3dH3If2XmM=;
 b=evD5uIk4N2Pl0JCgxoHG+N3/RqzGRvpB7h6/YtZIsaJbyQ6wc9J9QWMq2x+3ae3UWacDkz0hkaZWLyBbK/QdxiTTn8pqw4dZxjzAfMkA6H+XnWuz6IY20jC3hxH055edpG+WSPdBr8dmuZU0mDALJl2YiNxGQY09bIm1yHkdwxRK2T6+FJunSw8hgpitTEd2q1gw6w66FgarNcoh0qPoJCgNZOplL6Ut9ZWB/p+mzI1caqcFmFr1CGV1XPcUnQ9zTNQ8s7V3pCvnjNDu3wX34UtndAHuIjBaTEwHNb+6d4vQwKY3xQN0D6a9gMSN3ayAqul5Ltno9JjyW+LV5AB9QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iF62hONaQn4t7rqOMRi8RUKGGPpU7L2fc3dH3If2XmM=;
 b=UN3i/PP5EPYWbSGOZnlYWYqO307U552PQUnJL1jWQfFYCOovv0PuFCw77AByV8r5xRbizW4Swwgp0cgnxgn8tE7sUF20FDiy1UqK6/IoGTLMXgGOPn/g1EfgvZ81rrAq5ee7KpvvgXQz7O3nkgLRjxz3PpDVw5S+BnrNzDV3LLk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:56 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:56 +0000
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
Subject: [PATCH 16/16] NTB: ntb_transport: Add optional polling for direct-DMA RX
Date: Tue, 11 Aug 2026 01:51:35 +0900
Message-ID: <20260810165136.2292436-17-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0022.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: ef047b7f-b105-42f6-1907-08def6ffb01d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Gq3vthl1d++7/PxzNNRDVdUdyDG2AGYfFi3MdWm3OAWgrSwbi3R2hFccuXs4okLEYxynZXHL4GIqQ8VuJ/ucdpxAjJ7Zpswh7dAhkP7i5psCzIBk/LjcYmHgMOJVhNoPN30sVV6yk6OxLmJf6+7tHlnlOPQQk5XxMMwtXuidO2yx+ZpyTRSzlLl0a9pjxPLKA5vodSeZaxpiZQINyMEaIy0iSfaXX24tIuKVC/1Y5HwXUABZ8Xsgfv0p6r7pSGtju5Qg1Bzv2RcVWR9u8T7wCR1PhDjbnoiLczTFaoX8CXW45qUaAreA2x8I2aVpKZCOn89EXoXR2RnmtTBENlUxOXPttAPGQBSRfIvsuey5aTreGHdU5cSR7WMuxytsB8bhER+qxJ8OPbQs0EPJj5oBphMvf2xq/Vo4ZhI7SnKJEdZs3vZffaH3zzdKjQmHGdm36RGtyWinxexqckLPvAogebgdlXZ4ShfFM5YYPI9hwZlSw99vUFToJrxqYal8A/XbhuIkOYnkY6NVxXaksQa9G+7R90bWKFMMvelyv7TyjOKg9NiZ9JAq8vOO52lRzAD1D5drpbud0oH0BHpGy5Gin56UiaTd1bDlWEOaW3GGYOydKmqPXWk2qgiPanV8nkGZStFuO9cAtj4uE6qnrO0VpsUmD5fh+tf9keNFQjui9Nk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RkkoAV3FcOKxAK5t4+FZn1RjwZ1l310WOIHo1hX8225JjJSIibeii2vPMP1u?=
 =?us-ascii?Q?9TypW7gIh7BOMUQHn5BnliXoSxfwt2TkBaih++EVHpj+hbUEmHQ+RKBHzdTJ?=
 =?us-ascii?Q?H7cn7z3OgeMHgBx7iqrsBpH+BtKSA57a7ckwfJW2vql/63wLMyyqp6MziL4+?=
 =?us-ascii?Q?pn1Ev6bC9kiBZJJBmBkeKvf8UdXzpWNBXQoGvCLzYArPtXXWqNbMIvFQa7pM?=
 =?us-ascii?Q?jKIDiATGrSnCbwwI2W8AB0l6GBMi39TPNpuvaw56IDobTE8E2tVUNT61mYtz?=
 =?us-ascii?Q?8e6qRFrzCTWolQhIPnOJlwFyvzSFhUvqJgF/MjViFaDsfnCg+jpPOS7i2wJx?=
 =?us-ascii?Q?g4LQ9sLgmfrDjIPBpmr1y0RrC1v0SmhnRhqzrAofPBwTbL3SmicGsJ6dQZoH?=
 =?us-ascii?Q?ISBDpbkaWqyJshf3wkXi+1yHGFRX1BemG4A+DQV77t4ctuzYOxDFwlRFESig?=
 =?us-ascii?Q?cx9IW3eAbWZhvUE7whsK/+kCfyhp4qVlueGewvlRQL5nER2jL1GWgZ9CUyXp?=
 =?us-ascii?Q?CDkCW8VR2zph4tZA1U0ZakPMyjAjKY+DYYcra+5dXv7yFxLHFc8rxkcak6SJ?=
 =?us-ascii?Q?iETZQjqqz5kX62hxuxrg8t+ZVsl7jiFh0nxbP7TH+V70iTiHB7CASAY7uI5J?=
 =?us-ascii?Q?8HPPaMSyxmTwaoKdEtytUln5gHF/LeFQqmPlSu3buWdDbTQNNHjLmf2JYNdW?=
 =?us-ascii?Q?7m1RT6nFh5H/JpTsDBoXRy4i47JqQMRpAz0k7jhXz7iPy4ZZl97y5a6F6Y1f?=
 =?us-ascii?Q?JGRj8HqpG9nluL0RJb53Z0nOsxrzV4tAlR1MhOSZDuIKeZgH+oYYIncp83DM?=
 =?us-ascii?Q?vPdyb8D7FB1YlKGf1ylMh0Cghpj7kYiKumtlW5OBVsZAeausEZ1ddwabLX9P?=
 =?us-ascii?Q?Za7yGojF8sHANF+bXTndis1YyCpPxkpHwjVgeoxtVDnRyEf7y/GhH3bURaEv?=
 =?us-ascii?Q?Dg7Pm4H4WGX1QadIUEeKyYHOxp/izYTgprZTtg9HutQnFIAi0cPoTWsHiHwc?=
 =?us-ascii?Q?JOx8YMgq0HI5sk6k+wOexhTgxP8lyosSxKTY3Ttqg544xzheWHvmfaKgLvRU?=
 =?us-ascii?Q?oJci4I4FcCHbj5DXS+qH3gr8N5dszIKjPKWaW6Uo8jRGalSqBOYMutCdmMd/?=
 =?us-ascii?Q?CTuib7IzGyzxv4yOU6T6o7eGIJD2SdGQO0P3tQ3TVfo3HZpryfx9rtZngQO9?=
 =?us-ascii?Q?bOMU8e2ZewFbmOKPyQd2VWeKct/dkPxQ/jZmDO1nppiPK5p645vKicDOwdiN?=
 =?us-ascii?Q?whmEthIoZZT+g7x0+UKC4iYufd7oACCi78JsMIDfJSVzzXYgyu9LCw7JV8Ud?=
 =?us-ascii?Q?A3+AYIUMzM44cuyGdSc0ynoqVZWJaSiD7sy0S747mjPVOTdt7N53X248EPwr?=
 =?us-ascii?Q?sUkvMBj0mFhPzunoBjQ5GSl7QHqtmpy0sdEfAqjml+qjOS7j/I3LTsqH15v3?=
 =?us-ascii?Q?kQZFQdnE9v137LdAAhYyIKNpnZD7Ghkrr8P2FnjB4dBBJ9xPS/dVkTVPjJXU?=
 =?us-ascii?Q?hxWbWAD5UxeMnW6p5OorRJ+SAK1ZBPmx/pa0wdBfQD3mxENyh0Oo54l7jqhN?=
 =?us-ascii?Q?uND8R2I2sVi6Kc629Mxf3/gSOnimS1XLdyA4lfkPRuabxNs7j7lfpfYVqKp4?=
 =?us-ascii?Q?oDjpXtSDqkLDCFeWpfZBD+ZYkZQTrK8iSz4jGVHasZ9bZKeE6/oBKPXvGhWg?=
 =?us-ascii?Q?/iqCsYX+E99ao93x2Wk3QoY/thVRzKveqqXR68B+FfQx+Z6wdJu6hBc1fIAl?=
 =?us-ascii?Q?S2FIoqdsPOFHOPbocJDO9d2FBDPXLxNNA8KZIdyBsbhFoQcsWMIn?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ef047b7f-b105-42f6-1907-08def6ffb01d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:56.5478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XU3DtQEtVL/VYIP7ejCKeISQp+yEGYtPjTD6l8zrCRa62NGGj7vCB2tQrQIWxbNdAmlxmjfs1myPu4YKa3BpFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Direct RX normally relies on peer MSI or doorbell notifications.
Polling the completion state once per jiffy lets RX buffers be recycled
sooner, keeps the DMA engine saturated, and raises the throughput
ceiling.

Add an opt-in direct_dma_poll parameter. Notification-driven operation
remains the default, so continuous polling is enabled only when
requested.

The poll continues even after all currently visible completions are
consumed. The posted MWr transactions carrying data and completion can
theoretically be overtaken by the CPU MMIO write used for peer
notification. The notification may go through another PCI function and
ordering domain. Without polling, the last completion could remain
pending if no later notification arrives. This has not been observed.

Reading back each completion destination would close this window, but
the non-posted PCIe round trip significantly lowers throughput.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2f69328d5201..d3eb4e2106b0 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -104,6 +104,11 @@ module_param(use_direct_dma, bool, 0644);
 MODULE_PARM_DESC(use_direct_dma,
 		 "Use PCI endpoint DMA to transfer directly to peer RX buffers");
 
+static bool direct_dma_poll;
+module_param(direct_dma_poll, bool, 0444);
+MODULE_PARM_DESC(direct_dma_poll,
+		 "Poll direct-DMA RX completion state once per jiffy");
+
 static unsigned int direct_dma_func;
 module_param(direct_dma_func, uint, 0644);
 MODULE_PARM_DESC(direct_dma_func,
@@ -234,6 +239,7 @@ struct ntb_transport_qp {
 	dma_cookie_t last_cookie;
 	struct work_struct rxc_db_work;
 	struct delayed_work direct_rx_retry;
+	struct delayed_work rxc_poll;
 
 	void (*event_handler)(void *data, int status);
 	struct delayed_work link_work;
@@ -835,6 +841,8 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_queue_size);
 
 static void ntb_transport_rxc_db(struct work_struct *work);
 static void ntb_direct_rx_retry_work(struct work_struct *work);
+static void ntb_transport_rxc_poll(struct work_struct *work);
+static bool ntb_direct_rx_can_complete(struct ntb_transport_qp *qp);
 static void ntb_direct_rx_reclaim(struct ntb_transport_qp *qp);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
@@ -1523,6 +1531,7 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 	if (ntb_direct_link_capable(qp)) {
 		qp->active = false;
 		cancel_delayed_work_sync(&qp->direct_rx_retry);
+		cancel_delayed_work_sync(&qp->rxc_poll);
 		cancel_work_sync(&qp->rxc_db_work);
 		/* Catch a retry armed while draining RX work. */
 		cancel_delayed_work_sync(&qp->direct_rx_retry);
@@ -1808,8 +1817,11 @@ static void ntb_qp_link_work(struct work_struct *work)
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
-		if (qp->active)
+		if (qp->active) {
+			if (direct_dma_poll && ntb_direct_rx_can_complete(qp))
+				queue_delayed_work(system_dfl_wq, &qp->rxc_poll, 1);
 			queue_work(system_dfl_wq, &qp->rxc_db_work);
+		}
 	} else if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1900,6 +1912,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	INIT_WORK(&qp->rxc_db_work, ntb_transport_rxc_db);
 	INIT_DELAYED_WORK(&qp->direct_rx_retry, ntb_direct_rx_retry_work);
+	INIT_DELAYED_WORK(&qp->rxc_poll, ntb_transport_rxc_poll);
 
 	return 0;
 }
@@ -2629,6 +2642,25 @@ static void ntb_transport_rxc_db(struct work_struct *work)
 	}
 }
 
+static void ntb_transport_rxc_poll(struct work_struct *work)
+{
+	struct ntb_transport_qp *qp =
+		container_of(work, struct ntb_transport_qp, rxc_poll.work);
+	bool completion, control;
+
+	if (!qp->active || !ntb_direct_rx_can_complete(qp))
+		return;
+
+	control = ntb_direct_control_pending(qp);
+	completion = ntb_direct_rx_completion_word(qp);
+
+	if (completion || control)
+		queue_work(system_dfl_wq, &qp->rxc_db_work);
+
+	/* keep checking completion and control state */
+	queue_delayed_work(system_dfl_wq, &qp->rxc_poll, 1);
+}
+
 static void ntb_tx_copy_callback(void *data,
 				 const struct dmaengine_result *res)
 {
@@ -3517,6 +3549,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	ntb_db_set_mask(qp->ndev, qp_bit);
 	cancel_delayed_work_sync(&qp->direct_rx_retry);
+	cancel_delayed_work_sync(&qp->rxc_poll);
 	cancel_work_sync(&qp->rxc_db_work);
 	/* Catch a retry armed while draining RX work. */
 	cancel_delayed_work_sync(&qp->direct_rx_retry);
-- 
2.51.0

