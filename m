Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1193A8FE9
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949379; cv=fail; b=SMuszn8uJyfmCE4a5DmIfSlKnM0ZtgMF4llkgaGxDgygRBkrq1qJLL0nBFX6NvPpMvews2PqFsQDD+BEyFFSvjan0c3LrvKfJybDIdIYpo4nQDWV1ho4C97lrO4YimtQSVgAVsmKXa+xLpckjLCtvALZhCIWxF9Y4kRKgrJkfYU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949379; c=relaxed/simple;
	bh=houoln4VW+0sG8gaTDuOKjpB9IjSBU58XxKMEJxIBLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtLoPY7A4EKMg7GhYCoNCNt0yoDQb2NoA1vy222xVAKcTv2h6O7uAZyBPzNSuJ5Lg/AAC9M9jjiOEaK08pPPFHWgFz08ihw2FZn++RzcBHJsuFzn2K9TthAxAdNDoPr0kab7IU5KQYHp2ryD+th94M5bsQt45yjWwG/+hNiGsXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=IRbAIQzK; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="IRbAIQzK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e0N8AkqlgF81mvt1+CZHpMNJ2nI0kKCwVHdv03TH8g2owLdNiUrkDu/mKI4rV2GJ7epd8IG604gkgKpayciOb7jJ8SWXxQVL/Dj3K6zMCAaaSRkpy1EmNZEjBCsKbenjqz5t0YQaB66pPWhNVV/36M+ld7AxlhqpG9wO36myLOgtIpYbx1Uo/RErGmm3ZauY4Xf0tJT9Kll69EMeT96ZqGVOsTMLryNZQe9erhW0jLJOWMBYT87u+v6WXWWX9COQOoAK5paLsOQ9hU5UGYVKJuZ+Zut3s8Jcr+niGFUwCJGCcW+dV7VK4lBk5dOvPE4myt9IT7NrOEHYHy1x847qDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aQSieOZmKnkcnnNsfmxm2BhE3XQ9Gt7lVKNgCdkGr9E=;
 b=kC8RGN94ayjBmUAcryVhQia1gFnHLfntwcZF7sL90dkQ8t0RZDpGUUC8dyuS9cIPIre0RZNQiLnJbcoCmtjG8/WuaTesh9qrQrX54OXyDa5t6p9zCNKXWRDZw05AahxQGuWL9lkXrxPpG7kHsEM196GQNNyIzSJa3hN9UzmKEK5aJ/7kegob4NOT+DmrWwYiBUtk3huYt528QoGGX4Clf5EpzgVU1b6+xuDUQOHILOos0BXWghxVNBwwgW4CnCNoXdAQiohgkqobDGTH67/M03zy+fha9K+EVn57jx0PQei+jmT7/yX7WVxhTHlIPf1gpLxkOP+2XzmSw8draH7qfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aQSieOZmKnkcnnNsfmxm2BhE3XQ9Gt7lVKNgCdkGr9E=;
 b=IRbAIQzKlFYLaqsnr55p2iSYlC0M8cigDpRfAMyRXvfe9Lyi8KEWM7T+KFH7/8buPVoMqJrvj930kZIc13/D+8sIu0axAh+A53ngE38y2QuJNJzrkUB50DFPhfdiV1PM9Y64v7kcLgihij00mvEHEIeZCInnBYOSgBf8K3mDbCE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3805.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:49:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:49:24 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/4] NTB: ntb_transport: Use little-endian shared fields
Date: Mon, 17 Aug 2026 15:49:14 +0900
Message-ID: <20260817064916.13278-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817064916.13278-1-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6PR01CA0032.jpnprd01.prod.outlook.com
 (2603:1096:405:3bd::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: 7279d635-9456-499c-3d60-08defc2bacb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	j//u25L+ee4bRJFnngDZcLcx7ZTZdU7OYvTYvIDqKhO+BpgM4hBAmDJxANBGoZdj6/WzveKL4+SrMuxALxwvoDPzVj7wKu4WkDA4yVcAxXc/htNjQ8iE6ImnLfaJxt6PSswy4dtpyeETR6A/I0QkC/Y/ZFHuewTLt/zUmFwQPq2VhgiPV8ZQzh3GVag1+o3TokIDoywU8vJLmfqpcTMH7oIy9csjGzwo6tG7NUTGFgCYMpwxaZ8wvi98RShbXS0jrtKZ0Si2a8h3Gf3bnPC6qE8XO8X+1/DupMeY5j4CitW4ELz2BlKzEiJklxVNt2C6p9CQETdklC0DDBKofl+FmE6yUsjQzNCY1e8Avy8ui+PpSmsWT3B4wkuf9Xn5wPbrGUrQN1P4ctf7OWSwwtjABJoFdOG3TKQ55JbYNuUJwqZPKcU46i2/PB+UzbNL7t5vsQkXxcgoLjY7eF5dTrWXp10KKYc7TRMQEs3cpYxD9AjthlbCSVztLnx0goV/4+bfvevCVoMj3NDNXOGcufBQ521uSHmKjtUr+G/DqsWkyWufAnbjPWPggi9IKeGLKvXumtDBOgu5cO1SFCjlZIsJ6uNuA1k2ewqlpA+qkWYke4yP2kLiqKeU9YKSISUZzj8XWIrzFdmS2i2facZXwBt+b2IreLmut4J4hl89umwVtzs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rsd8CyN0lnULlGa51co4DHc+T2E1M7HdxDsQ9S6v648Edl2JYvUErAUEDgpU?=
 =?us-ascii?Q?/mMUGB0cPW8ltV4V+nEHH884x16h/0u5HNaDsTGGF5TwrpXTPkmXaG3LmmX+?=
 =?us-ascii?Q?B6OyVo3wcExyoKhBagyYu4NgtNfu1pkGgXsPYIuMfc+az92MEaTDOj06s9HV?=
 =?us-ascii?Q?gqyN3ck+gX7QcLutZGIaVl94nGx7+ihBN0FZegMknlyg2iIedKNCp2ExumB+?=
 =?us-ascii?Q?eWGf0OWxLrvlY3lTjk07CPXDztb4+9wuvy67Ftfbk0UOCZ6BTGC7bL4XMG7t?=
 =?us-ascii?Q?UGjzoPtZxnaTtliP+lajsOFfs2o6meWgyhyX+FL5h+0X+zm0U63X6oeDfLrg?=
 =?us-ascii?Q?edsPM9slbMDr/KNXrUUeSPf4g1D81L4xdMUaEJlAkE1nUYwh1Wu452hIVvn0?=
 =?us-ascii?Q?6W9PHVHpnvtAfZu9j9wdsk1YYAUHeQnStxLVVLbc+61bVS63GrhnhE1chhvW?=
 =?us-ascii?Q?3hAbFKucR6p/YPwPd28df7+HS++cwCPWwvPRSfBRFHqAC0vYoJd7bifIrXEI?=
 =?us-ascii?Q?gp7o2v8uUdBzVckkpvV9MK6iWkdgVPwc4geYnoHXRVbFOZA6ui1Cad5ZWJSC?=
 =?us-ascii?Q?iyPWZpSsTM6tPo3vZuGwwwlwIDh22CYhBQ1G5Qi6mqRyAP1Sn/j/vnGEWs2C?=
 =?us-ascii?Q?4l4tJ30t1DhZkd2Ar5gfSSCZvL8m3oQLqTfFxM5m31AEEW5GLVbEmISEs6Oj?=
 =?us-ascii?Q?WbkrASJs1xXTSAoTa+WhNXK7gVgpRu4WNgFxOkgv+sukL1TvlTfqNAqNP2NH?=
 =?us-ascii?Q?Nvww+bYRekDBmTbzOw2O1uKmEsAi0HE6tejQ2P52jZFt3Lr+Oq22fVjdSmLj?=
 =?us-ascii?Q?Krlh0qxdunYLZaMdzSRHkHemO7z/RuAApb2ZRduQ6sljaxXFAHfDiyj67zUi?=
 =?us-ascii?Q?6ND21bxZucEpXDoBnDdvs5d1Xj7rHvo60rCiJC0fmKn8kuVCdFo4fzXZcCq3?=
 =?us-ascii?Q?0oikFn6bo9V724XJCLUbLEy10fEGvE/eq51poV1ThhAlbQO5FLFP2ro8fY3b?=
 =?us-ascii?Q?ZfprNCWA0yFfRUEsU9eN+XIGRKRr3G+n9wcqC2e7iWHv/kObOgK1kLAbylVX?=
 =?us-ascii?Q?U/ui80oiSU7qpS9J65ltUZp4bm1Jwq1DFr1Lo+9iAwCWNyFUd1S7/OJRF3hH?=
 =?us-ascii?Q?+vcpiXGsI7YJF6S9G/ollotcEIe3XFIxzs0s3eqZkZvVs+B8k1AWKbe4+7/v?=
 =?us-ascii?Q?38pv8InVZNm0SGJAOwv4O87F5t63c8TG7NQrJZfl+V5iNr+kJ+IAQZk7WTKm?=
 =?us-ascii?Q?orm7bY23tevbw4dnRyErLAH9Axe7b9Lp/SPPUayvI2qZVfA5tttGKEeTdLbY?=
 =?us-ascii?Q?wyEH/BLgsy/sagR5Ppelmhv4gFxwpSpXubIN+JkM4SXimDvtdXSj3yagPbsC?=
 =?us-ascii?Q?a77mXjSfWq5nPeDU8mOkFveZIL3p9zsFgsWdZdjfjVRHAVqyW+F7ajzw6b7K?=
 =?us-ascii?Q?osCqEheWiBY9gvBYs/cBGGjUv+sRxs5dD9ckA1BRgHmt1P8FSVHMCZIpdygK?=
 =?us-ascii?Q?Fzx2/jCDkdmkwC2cHTFx51d3n9IwWRqBDxf0WsldZL9fuxGAtF98HgCCoj3q?=
 =?us-ascii?Q?LM6L7ojGuzSjDaFme1UXEilTG0JRtPmHoT7pyE4ruFq4raIA0FY78n4ZqX7J?=
 =?us-ascii?Q?CyLW6ZfR6wWxE73AA3qim7xjFo+w5PTPXOGSqrHuqD5ktY1c6KuduEejXY8E?=
 =?us-ascii?Q?TQk76ZAkuh1ts6QggghiqRT6BWMGai5EM1Sbr6t+U4j3ZHqZHJVLAAyhG4+f?=
 =?us-ascii?Q?xbFiGNdH3WffBqVxOE7n32HCTm4mAVUeMzlJtV0eErsxy9dUg3IQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 7279d635-9456-499c-3d60-08defc2bacb8
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:49:24.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JhyZyoQoW8aeaksg6qSNdszrp8gY7SzY39Ysl7phP9mQJH9tDtYkb1y+dwR/iRkWomDVtZ9fZW0F3yOvSrinVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3805

ntb_transport writes payload headers and the RX ring tail with
iowrite32(), but reads peer-written copies from coherent memory as native
integers. The values are therefore byte-swapped when read on a big-endian
system.

Mark the shared fields as __le32 and convert coherent-memory accesses
accordingly.

Fixes: 74465645cdb4 ("NTB: Fix Sparse Warnings")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch. (Sashiko)

 drivers/ntb/ntb_transport.c | 47 +++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d458a8b1de11..967a5ad38164 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -132,7 +132,7 @@ struct ntb_queue_entry {
 };
 
 struct ntb_rx_info {
-	unsigned int entry;
+	__le32 entry;
 };
 
 struct ntb_transport_qp {
@@ -265,9 +265,9 @@ enum {
 };
 
 struct ntb_payload_header {
-	unsigned int ver;
-	unsigned int len;
-	unsigned int flags;
+	__le32 ver;
+	__le32 len;
+	__le32 flags;
 };
 
 enum {
@@ -514,7 +514,8 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
 	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
 	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
-	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	seq_printf(s, "RRI (T) - \t%u\n",
+		   le32_to_cpu(qp->remote_rx_info->entry));
 	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
 	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
 	seq_putc(s, '\n');
@@ -633,7 +634,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 		qp->rx_alloc_entry++;
 	}
 
-	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+	qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
 
 	/* setup the hdr offsets with 0's */
 	for (i = 0; i < qp->rx_max_entry; i++) {
@@ -919,7 +920,7 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
 	ntb_qp_link_context_reset(qp);
 	if (qp->remote_rx_info)
-		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+		qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
 }
 
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
@@ -1445,7 +1446,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 		if (!(entry->flags & DESC_DONE_FLAG))
 			break;
 
-		entry->rx_hdr->flags = 0;
+		entry->rx_hdr->flags = cpu_to_le32(0);
 		iowrite32(entry->rx_index, &qp->rx_info->entry);
 
 		cb_data = entry->cb_data;
@@ -1609,13 +1610,15 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_payload_header *hdr;
 	struct ntb_queue_entry *entry;
-	unsigned int flags;
 	void *offset;
+	u32 flags;
+	u32 len;
+	u32 ver;
 
 	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
 	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
 
-	flags = READ_ONCE(hdr->flags);
+	flags = le32_to_cpu(READ_ONCE(hdr->flags));
 	if (!(flags & DESC_DONE_FLAG)) {
 		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
 		qp->rx_ring_empty++;
@@ -1623,21 +1626,23 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	}
 
 	dma_rmb();
+	ver = le32_to_cpu(hdr->ver);
+	len = le32_to_cpu(hdr->len);
 
 	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
-		qp->qp_num, hdr->ver, hdr->len, flags);
+		qp->qp_num, ver, len, flags);
 
 	if (flags & LINK_DOWN_FLAG) {
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
-		hdr->flags = 0;
+		hdr->flags = cpu_to_le32(0);
 		return -EAGAIN;
 	}
 
-	if (hdr->ver != (u32)qp->rx_pkts) {
+	if (ver != (u32)qp->rx_pkts) {
 		dev_dbg(&qp->ndev->pdev->dev,
 			"version mismatch, expected %llu - got %u\n",
-			qp->rx_pkts, hdr->ver);
+			qp->rx_pkts, ver);
 		qp->rx_err_ver++;
 		return -EIO;
 	}
@@ -1652,10 +1657,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	entry->rx_hdr = hdr;
 	entry->rx_index = qp->rx_index;
 
-	if (hdr->len > entry->len) {
+	if (len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
 			"receive buffer overflow! Wanted %d got %d\n",
-			hdr->len, entry->len);
+			len, entry->len);
 		qp->rx_err_oflow++;
 
 		entry->len = -EIO;
@@ -1665,12 +1670,12 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	} else {
 		dev_dbg(&qp->ndev->pdev->dev,
 			"RX OK index %u ver %u size %d into buf size %d\n",
-			qp->rx_index, hdr->ver, hdr->len, entry->len);
+			qp->rx_index, ver, len, entry->len);
 
-		qp->rx_bytes += hdr->len;
+		qp->rx_bytes += len;
 		qp->rx_pkts++;
 
-		entry->len = hdr->len;
+		entry->len = len;
 
 		ntb_async_rx(entry, offset);
 	}
@@ -2492,7 +2497,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
 	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	unsigned int tail;
+
+	tail = le32_to_cpu(READ_ONCE(qp->remote_rx_info->entry));
 
 	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
-- 
2.51.0

