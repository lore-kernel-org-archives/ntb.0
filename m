Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011013.outbound.protection.outlook.com [52.101.70.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E70522695;
	Fri, 18 Sep 2026 20:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789764123; cv=fail; b=IFLUFuCwcJk6J+E81H8OnW+tIpYIkR/x8BOoGHg/QwiseMYT41XY7dnxHKh0Lc9RqUNOTk711Ak8hXkf8FwAw8YEwJI1QHjbdXGwLVKEBZnGvWYxKnecHbXL6Xt5q89Q56TWSWp/P5BKKgpMNHc7mBUedhyINHYen0CmSGLh1L8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789764123; c=relaxed/simple;
	bh=4/fADVhRuHTZ2KE+oKKrboirjDBxsJq3zoNzZEIxDxo=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D1lttfQ2THQawK9VVNehsIZU1lDci6WCARWX9xv0SKsvrywi/PrL+Xgx0YHejaKzAV/Nu4m5CUf65A+gBYPtEGcE+/Z94F5uWjQob8enEFCSu+UQiD0D00r4B67rF2XpaPWc3L0SVK1nGZPCmJRM+L5wRtfegGO4cjaJFi7Pj98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YiZvxnyJ; arc=fail smtp.client-ip=52.101.70.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YiZvxnyJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ITLOll+7hjdbnAvEo42RnPVr7N98VB5RnsdfDiQ+jFHfgPQL5Z/e4xOeoFO34daBgY/BJGBkxfOXcC0dWCW6gljpr0BAsuwrz5lXqlGeTUvT95cZVB6blmKW4cJK+36FDAqKk7Y7u7mAlz/ibEJPM7zzGbyEgXdQkxcOQOGz1O5rkdIBZrCwf1nq7L4xhm5zYn0jHrqGFXxNVlz6fgEGzp0zlAa64eLfFleOtG7A/7dV4yEacJzPg90rGlqXw1Cz9GXgicPR5sg0826gG4ywu5V8z0ub1tuLDNl7USuOpYUJCKIPozJiYb9BUVU2t2o62kPtmxRYpkFOlq8pJh/dxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PoCLmnvN9/Gv03dJN01jJX9SZp2d/GxsNGSYOfEsSG8=;
 b=vcNqZEFvGirDrWB+XqulrDJCuzxp1/Znc+KTBxPRNphYGtXhdpgnB2cA15aVctHtPAHhrp1JFv2WF3iY2HD0phPGXtxe+F59UiCl26biwd6gKrtCLmYvKpnFt1w9Onl7fSR2CRW+ibTV5g5p1BgeWqfj/BSxQlX0SOB4cHOLO6yV+xamIQi06jd9OOt/zjE/G0RICuJ7QPlAZhakN/9+Ou9xiUTOZgTT3XKLgV3VAaqG1Y/lAXa7GOgkil+0pxr4W931E9d0/U+LvAnecSK5eXhB8F9rfrvDzai1o9Vic1q5a+fk3g8++7ka269WM0nq5YhQor7YmOp6mD9T6CdGfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PoCLmnvN9/Gv03dJN01jJX9SZp2d/GxsNGSYOfEsSG8=;
 b=YiZvxnyJ7yS6TxGmm3xyUQ9rBvsaTFMDq//+qtlDqIwulBhhXZN86giieWnmjZ+ivkzKBTv487P1dz7rWg1YAvfRzt6n8aMYSTX5BQg/wQMZz5YAOt3JEGE+SGWOu+ONacNBoTsp6G8usz6Y0Fv74rkp6exwcPpZoFVR7t8GaprYOl4mcNaI+v+KVoZhNzDfyfhvr+BepZpF0iGuVlbrrg47j/vNq39MvTC1c1prvPjUaOlQAOO3QfH9boyPd3O/EnW7ypiCyQCcEc1ZB1wO4hgCK0hxvtUZFO2PRhiHAB62nLeGr9J9YZpDtnT/8vYYkl+rOjGn0DgTWH5I1Xe/xg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM8PR04MB7236.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 20:41:58 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 20:41:58 +0000
From: Frank.Li@oss.nxp.com
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] ntb: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Fri, 18 Sep 2026 16:41:48 -0400
Message-ID: <20260918204152.2364336-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYZPR11CA0010.namprd11.prod.outlook.com
 (2603:10b6:930:8d::26) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM8PR04MB7236:EE_
X-MS-Office365-Filtering-Correlation-Id: 0952c5da-1de4-4515-9c43-08df15c548b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|376014|1800799024|11063799006|10067099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	eJM6rCH2vxzpE+blc6yzr1ypSNYGrUtS/sR2AUgzsfEhQGC112IPnrE0f70D5sYQ81HlElpKOC+sZgG0VYQPb3AwyRDOX0tTcrhLgDpmeVqkHCeg6wen8fCfDhMKJg6+xb+lLiRz0ZkwUhRC8bOnpdYMAcaI5AZfhS0HJDwq2ma29NPWNRESoDKZf81tOneTCfHWeMM3zs4LiwcpYtm6ZWVHxM5L/BdxaJDpa9LcDm2+F/WZCcgoqOnsvQlSkh4jAPqQ9aAtB1fXozHRYOzKmfu6XZbjkXlH2Sk+75VzjJfJAgsbOqT73Zt7eqkBLztHHBsJlLWAh73e7NbPhGVE+mnqZtE4FH0TDQSg4/bQ/vjg0TYNqtRBYCLKF4eaWJS3rW3tGHUWzCaa8V8TWqxovqkByZt1XC2UG0PKyYgvhal9mCICHrJ5P/6UAUn3GWPGubbc9KxJxW+8DgY1rwwUbeoOul4Ka1ORq3plL6p/204YK8O/yIywdooaigkn3EKfDSSgJr0RBE5ADuRtM+MASL0aPwDOO0/Yq06QqqrKzGEVuAF60VgmMJlbplp4NWNHtsdELSH/MNPaFNgdNTsYkr8QqfvOB4NatqK6cIGbd//YYEwaxb5W/qF8xDiK/TVdUU8U7anULu3qYwkwQ+4Pkg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(376014)(1800799024)(11063799006)(10067099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pQmqg4IKZnhJOmk+tFEweqW5YYzWKYG5m7kz6LZdwzIDy5K5fjRHSBRFqOlb?=
 =?us-ascii?Q?+Id3K4ZXQVwb/CqbjfPZhH0PDRWOtbwlUy4BSKuFL40LYF8TOkg5cre6XJwz?=
 =?us-ascii?Q?sSgDLfJEmXok8qPbxcRnD7D1JpHleC3FOqK8va3L438corLPj3B2YBR19p+Y?=
 =?us-ascii?Q?zsGTEto/PH+3nH/Cdw0sfw8Y5KTLpuFW8+q9kCWHTC+o9oCDQi9rugJtFuAg?=
 =?us-ascii?Q?6jeushBEkr/F7pWqzffxe2Uf0yz86fIzoBOQoYa5nSs13UpBRo3peNREJ0fJ?=
 =?us-ascii?Q?PIYKVom8cwS9jMNer7TCGpJGr7eOIzU7x5DyZnmqPrRIarwQRJdtFha2IHZD?=
 =?us-ascii?Q?VvG4OLVF3GgoY68Ug9jTVLhqmYMNfOlAMu1rECmY0sVvyg59Dw6n72QgWb5o?=
 =?us-ascii?Q?dDTrVCbjnfliUwfYclgxQ10MjyGSBOcKCxeoOF2vh/VyxJI4CT+dHB5WBQ46?=
 =?us-ascii?Q?7cZbZDE06hkEIY6MS1aDpzVq4KGBx/CCq+64kb4mrsf6WNjWfIplsFrAJmrM?=
 =?us-ascii?Q?s3r74q+WiDgp/sx8oAjSN7FmpzHgw8g0nESBbuY6h6WwwXOiT6+FGTjYtTYy?=
 =?us-ascii?Q?NQD4eLcdVm1U4yDuHPVZ3IduAHmtmoc0RvHXvNuDNOCO5L9bHoRAM6HkmgOm?=
 =?us-ascii?Q?vSeCyIbJDBq9BTB04SZBw7IVfO57oxvnX7pTgFydWnL5csLC+Nr7dzh+/WLg?=
 =?us-ascii?Q?FfePO2wCU/NQcGW0YotYpIKv9BK0oKWzn/VLWsRXnUv998s8DPTyGqhiWb1N?=
 =?us-ascii?Q?OGIvCQTdfGA1M0/xkmosSpoPMu4X0G7DLklEPkJTpNyBT0n2ZbPswxZ4K738?=
 =?us-ascii?Q?xE6zvmfMu4RQ3XSiLhlAsGvsLS5NHj/zvHJ86QElMDRT58vJaMj2m88jtEi9?=
 =?us-ascii?Q?wb2Fd9z+Oc3K7OrGhk+RvD5CRupnRWhuvpp5NE/Otv0egrpHDcuSnFhbCFR2?=
 =?us-ascii?Q?Xd4jfasN2oDxnLRlxUDtnZlrUw1LTL9uUCavQPNRE0ZWXiywpbQ06w7U6iXA?=
 =?us-ascii?Q?XCNjr7nj9BZKbKZBds0+TqhUL8QPcORT9Il1/IvrZsjCeI4eDZT9bZ0lYl+A?=
 =?us-ascii?Q?XbII9DYfElHBpRIuhEhFhnVS52tNGXUjwH2xuU8BiPd0Vol20YblYMNoYI0q?=
 =?us-ascii?Q?9ypVBgScYpUzK+9AUduIJabiw43o4cQgmb90vvkVjU5eK9eaWNHwb+wl3Rzh?=
 =?us-ascii?Q?SQQZtJf/4t/r6jkFnC0fFi39eeHxhn5b0AGsgrH+mfDlHOVNoynW0q0+CK45?=
 =?us-ascii?Q?S0vUw36euGuAgXhdFQ2jY7iL2quzkzCdDMR2S/grdvT8a6zOPBMT7fVegOXZ?=
 =?us-ascii?Q?qEhdwnNTRX5iZJOJvzW8GI/NQ6+lQ1CtVH21aTKwtG2MTXo2RJBnLO+XOOLK?=
 =?us-ascii?Q?2PRkofXsLLvFuqzWQSbW31fyZkFwgS68XXnHQ5cg7IP8L0M3Z8Xjg5XEykmo?=
 =?us-ascii?Q?pOSrNnb9PXzm0z4PBLN2UImF37eKWuIWt14U4fQ3VZsKVZpcnzKhJ93+gNfy?=
 =?us-ascii?Q?P2ukwkB8YuNSavKqJrogyWin3uUCl+ORbbA9Qgn7BUnR4OlAMinT4rZym0I6?=
 =?us-ascii?Q?a3g/yHNt50Chri9XbfY2AU3eQHX/upC69v1CKNDLAMwpCE91SaXMxvXgA9Ur?=
 =?us-ascii?Q?/YRRXF2WNqnasocuvrfBKrwZmILQpBRjaN41uCEXiUzz251SnDM0Mna6UKzb?=
 =?us-ascii?Q?Bih1qrRGsmhyAPbOOrO/3oSr2Y66Ly3jSDQsX9mEB+iVexi2bzrf7bFYUPlR?=
 =?us-ascii?Q?vHkhXriMzsgMjbsVx7uVQaGPWyUL4s22KFGeAnK5P34W/u0V9OUH?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0952c5da-1de4-4515-9c43-08df15c548b8
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 20:41:58.4820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udwiiZV8ub2fo0zBtZAsYH2dHnSRvMw/nIAaTGT0NBY4QIAxx8gFXVPXGkUXfX2pwhXKUfq4dZ/2wSi4v2HZ1L0lMYuUB9QnbVa13iisXfkJNlbaq3qiLw0hPu1bZY+f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7236

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() accessor in IIO DMA consumers.

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ntb/ntb_transport.c | 29 +++++++++++++++++------------
 drivers/ntb/test/ntb_perf.c | 14 ++++++++------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 45144abfb7aad..895418c243642 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1519,6 +1519,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 	struct ntb_transport_qp *qp = entry->qp;
 	struct dma_chan *chan = qp->rx_dma_chan;
 	struct dma_device *device;
+	struct device *dma_dev;
 	size_t pay_off, buff_off, len;
 	struct dmaengine_unmap_data *unmap;
 	dma_cookie_t cookie;
@@ -1526,27 +1527,28 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 
 	len = entry->len;
 	device = chan->device;
+	dma_dev = dmaengine_get_dma_device(chan);
 	pay_off = (size_t)offset & ~PAGE_MASK;
 	buff_off = (size_t)buf & ~PAGE_MASK;
 
 	if (!is_dma_copy_aligned(device, pay_off, buff_off, len))
 		goto err;
 
-	unmap = dmaengine_get_unmap_data(device->dev, 2, GFP_NOWAIT);
+	unmap = dmaengine_get_unmap_data(dma_dev, 2, GFP_NOWAIT);
 	if (!unmap)
 		goto err;
 
 	unmap->len = len;
-	unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(offset),
+	unmap->addr[0] = dma_map_phys(dma_dev, virt_to_phys(offset),
 				      len, DMA_TO_DEVICE, 0);
-	if (dma_mapping_error(device->dev, unmap->addr[0]))
+	if (dma_mapping_error(dma_dev, unmap->addr[0]))
 		goto err_get_unmap;
 
 	unmap->to_cnt = 1;
 
-	unmap->addr[1] = dma_map_phys(device->dev, virt_to_phys(buf),
+	unmap->addr[1] = dma_map_phys(dma_dev, virt_to_phys(buf),
 				      len, DMA_FROM_DEVICE, 0);
-	if (dma_mapping_error(device->dev, unmap->addr[1]))
+	if (dma_mapping_error(dma_dev, unmap->addr[1]))
 		goto err_get_unmap;
 
 	unmap->from_cnt = 1;
@@ -1856,6 +1858,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 {
 	struct dma_async_tx_descriptor *txd;
 	struct dma_chan *chan = qp->tx_dma_chan;
+	struct device *dma_dev = dmaengine_get_dma_device(chan);
 	struct dma_device *device;
 	size_t len = entry->len;
 	void *buf = entry->buf;
@@ -1872,14 +1875,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	if (!is_dma_copy_aligned(device, buff_off, dest_off, len))
 		goto err;
 
-	unmap = dmaengine_get_unmap_data(device->dev, 1, GFP_NOWAIT);
+	unmap = dmaengine_get_unmap_data(dma_dev, 1, GFP_NOWAIT);
 	if (!unmap)
 		goto err;
 
 	unmap->len = len;
-	unmap->addr[0] = dma_map_phys(device->dev, virt_to_phys(buf),
+	unmap->addr[0] = dma_map_phys(dma_dev, virt_to_phys(buf),
 				      len, DMA_TO_DEVICE, 0);
-	if (dma_mapping_error(device->dev, unmap->addr[0]))
+	if (dma_mapping_error(dma_dev, unmap->addr[0]))
 		goto err_get_unmap;
 
 	unmap->to_cnt = 1;
@@ -2026,6 +2029,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	struct ntb_transport_qp *qp;
 	u64 qp_bit;
 	unsigned int free_queue;
+	struct device *tx_dev;
 	dma_cap_mask_t dma_mask;
 	int node;
 	int i;
@@ -2089,11 +2093,12 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 
 	qp->tx_mw_dma_addr = 0;
 	if (qp->tx_dma_chan) {
+		tx_dev = dmaengine_get_dma_device(qp->tx_dma_chan);
 		qp->tx_mw_dma_addr =
-			dma_map_resource(qp->tx_dma_chan->device->dev,
+			dma_map_resource(tx_dev,
 					 qp->tx_mw_phys, qp->tx_mw_size,
 					 DMA_FROM_DEVICE, 0);
-		if (dma_mapping_error(qp->tx_dma_chan->device->dev,
+		if (dma_mapping_error(tx_dev,
 				      qp->tx_mw_dma_addr)) {
 			qp->tx_mw_dma_addr = 0;
 			goto err1;
@@ -2142,7 +2147,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
 	if (qp->tx_mw_dma_addr)
-		dma_unmap_resource(qp->tx_dma_chan->device->dev,
+		dma_unmap_resource(tx_dev,
 				   qp->tx_mw_dma_addr, qp->tx_mw_size,
 				   DMA_FROM_DEVICE, 0);
 	if (qp->tx_dma_chan)
@@ -2192,7 +2197,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		dma_sync_wait(chan, qp->last_cookie);
 		dmaengine_terminate_all(chan);
 
-		dma_unmap_resource(chan->device->dev,
+		dma_unmap_resource(dmaengine_get_dma_device(chan),
 				   qp->tx_mw_dma_addr, qp->tx_mw_size,
 				   DMA_FROM_DEVICE, 0);
 
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f0..b936f15079df2 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -799,7 +799,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 		goto ret_check_tsync;
 	}
 
-	dma_dev = pthr->dma_chan->device->dev;
+	dma_dev = dmaengine_get_dma_device(pthr->dma_chan);
 
 	if (!is_dma_copy_aligned(pthr->dma_chan->device, offset_in_page(src),
 				 offset_in_page(dst), len))
@@ -869,6 +869,7 @@ static bool perf_dma_filter(struct dma_chan *chan, void *data)
 static int perf_init_test(struct perf_thread *pthr)
 {
 	struct perf_ctx *perf = pthr->perf;
+	struct device *dma_dev;
 	dma_cap_mask_t dma_mask;
 	struct perf_peer *peer = pthr->perf->test_peer;
 
@@ -890,19 +891,20 @@ static int perf_init_test(struct perf_thread *pthr)
 			pthr->tidx);
 		goto err_free;
 	}
+	dma_dev = dmaengine_get_dma_device(pthr->dma_chan);
 	peer->dma_dst_addr =
-		dma_map_resource(pthr->dma_chan->device->dev,
+		dma_map_resource(dma_dev,
 				 peer->out_phys_addr, peer->outbuf_size,
 				 DMA_FROM_DEVICE, 0);
-	if (dma_mapping_error(pthr->dma_chan->device->dev,
+	if (dma_mapping_error(dma_dev,
 			      peer->dma_dst_addr)) {
-		dev_err(pthr->dma_chan->device->dev, "%d: Failed to map DMA addr\n",
+		dev_err(dma_dev, "%d: Failed to map DMA addr\n",
 			pthr->tidx);
 		peer->dma_dst_addr = 0;
 		dma_release_channel(pthr->dma_chan);
 		goto err_free;
 	}
-	dev_dbg(pthr->dma_chan->device->dev, "%d: Map MMIO %pa to DMA addr %pad\n",
+	dev_dbg(dma_dev, "%d: Map MMIO %pa to DMA addr %pad\n",
 			pthr->tidx,
 			&peer->out_phys_addr,
 			&peer->dma_dst_addr);
@@ -1003,7 +1005,7 @@ static void perf_clear_test(struct perf_thread *pthr)
 	 */
 	(void)dmaengine_terminate_sync(pthr->dma_chan);
 	if (pthr->perf->test_peer->dma_dst_addr)
-		dma_unmap_resource(pthr->dma_chan->device->dev,
+		dma_unmap_resource(dmaengine_get_dma_device(pthr->dma_chan),
 				   pthr->perf->test_peer->dma_dst_addr,
 				   pthr->perf->test_peer->outbuf_size,
 				   DMA_FROM_DEVICE, 0);
-- 
2.43.0

