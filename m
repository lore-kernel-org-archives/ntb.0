Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011055.outbound.protection.outlook.com [52.101.70.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5440A38B7DD;
	Mon, 21 Sep 2026 20:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023164; cv=fail; b=hWi9c6YPq8/Cskr2+ltd6miUf7n2tsc0ShRGq7MliR1uLF9CBIp8L/PjcbavUwKdkaRaC3zz/bDtrQ1opSF3uTE/Kg++pmPDtvb8jncMctvwyagV8A3vjdNCGaUpJMslgm6u/fayUOjCa0qb8BAZMAe+U00tO54PbKj+N1Km3nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023164; c=relaxed/simple;
	bh=NvM1JC+zBTSCW1WIy3aACQ4CDbZYZ5zAvUIos+xPD2U=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m5i0mXjwA2DaOmjwWZvL7oSgA/Zv7QmqctKKxv88ajb5+SwFYEI4TefpkR8zZX5ssO4jB/L32g7t7N9XuAtvE7Q1SSELFVeAQc8oypfLngq6THFsbc0kWXT05+YWqVDJaLKLO2kzs6lQX67YcYjZDW3yDOrVwyroWukLC2USLfE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=P3KSnorf; arc=fail smtp.client-ip=52.101.70.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="P3KSnorf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NEHZqVQoXpgn44CLBzS36LTJOXLg9RfndSBhfw4j1KW95Wzz6YM0lvyZGJuHmyaJtyoOaIsx0eC+1vYN/OA7RM5PDEZTE6YxEPQbRmNbD5oEW0WmiFa4H4kYSzhz01bMiMFVsMHrrmr0f5itUK7viorVuvdj7gQB9ClPZEi35V7C/r5loau5tK/XOF8BobR4rJ0suD5ddWayfyeEd69WQGUxufnQFx0GWFaZPaD3iV/Cl6/Rlvpd4Vqd1HSVh730Wfd0seI390XiEgYNWyp0wy0eD9BR7LrYvgY8nT4+Wf472s+gnImVHW3WNZ0gZOjL9SEEb/B9+Y65GmsYEV/25w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/+yMtpArFz0Ech2CTFkIYEW1KwnOjxCKzycvAquGu0=;
 b=YsKjdbkXZKEIp4WYDqVwzUDkhheh8o6RVe6/iQXJlpgX51L7+XJkDJk5USmR/OZUttFiRQoTOo/0Izn4R5lQMfF190bB/gcNU3j5wAsMWM2tW6koy5SkbgWrjKUM2PCYLDFg+7L3BEUW8Dv/SJI8REgr4COTQIcQfQhHaodRw2t0WhRLU4DzFtZirj3ENGHXAPa2kCLh2TuDBTBrcaualKbvU4T59qwJGbZE41fxm++8rupUwDqgJMDf9XQa8tkLaDdtxsF0JfzfbX+IOxw02GebISZGPSqXyGOU0XEjsxLJa6Na8J48vdRNAeY+oR1wHKEa9YPhiki6WThGNIm0Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r/+yMtpArFz0Ech2CTFkIYEW1KwnOjxCKzycvAquGu0=;
 b=P3KSnorf59l7DPCa1gY4wTeTc2RhhlcCd9rSj6SEipw+Zkva84pgumiAsE6YRiXtHi+nB8FI9o8DsH5vXBaq0Ga/m0HgkMC8Na/GjfTRrqlTPE8I9kNOuGMXy68ir5MZUlI66r0HtH3of/PWdv6Z4NhYG9dXXiKWzl4K4y51JebJyds/4OPS3+QV2t+swLrPag26PqHszBNpNklQo9nN0QKuZYCZCy58mWqLzWwGxlFzW+fdMwbPDVpAyM9MvgY/OgbdP2AZo4tVxmpdP0C01pbvpesdKSQBmbBDAvBoq1GIysf7ust7RjTitmIJjtXZkNBe/yA6J4UZyF9s5LLo6g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by AM9PR04MB7603.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:39:18 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 20:39:18 +0000
From: Frank.Li@oss.nxp.com
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH v2 1/1] ntb: use dmaengine_get_dma_device() instead of chan->device->dev
Date: Mon, 21 Sep 2026 16:39:05 -0400
Message-ID: <20260921203910.1350228-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P221CA0068.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:510:328::17) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|AM9PR04MB7603:EE_
X-MS-Office365-Filtering-Correlation-Id: 98feb579-1777-4f51-4e9e-08df1820686d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	l16gQXNIs31lRQvSr+spILdOMPIpGn4tK27JuPwYW7aGu2eFQ+7Ej7qEHAKjkzLkWX7IQL/i/5Fc6vh8O9yZWsQgGyDXimu5H3YzNfe7mhfpqfs7kHsNlG8vX4EhrTX9iKWgQIPaPHMeSl1VtsMlUOpS4wyDTGnDQRrE1C0z/iBW84iQPESlfZXG9hlo+bV8nStymhOLhdEFZdX6vvymp9+tF6PDnz4KG4vxIoYmgBRk63XKPuw678RvBjS2c+9DuK9U9lmwOZiJQLgUozmhfV94wokmwawjvcgvtt3rVFEcfu8v1gEFE76+M+ighC1hYfCZBo22QIyriUthp/R+wWkkOpmaU5FUMef974sotLTtMpmfnHP7nAcskeyyYjewMdGO6lcs7aXBs698JWUvUr0TJQ1nSOf9Pz0NkYgMy92NLlxhAc2HIiaMUeZAKip0Ws2mQuoP7QTOtkeesfp1XNGMOuPqAX5OSjXLfBCm06SXjJOh8DM8L3TIAlfkl7IIKwFIiRAyVTgOoqdKe/uxyMybeJZKiiPu8kL7gKUpUyfuTzO1F5kNXiu0oQFOu866DVy5jFX6pRRrrewHntAWGVnG6/CPW1LSKZL/PyH+JjUMs6r4w4ll5KJAJFJcCszP220IfumNcomeWnc5umQhNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?T5jBjprv1sgwUbuNbwuH64VWAYdqpZ/R+Pa1tzzZIGB8gOclc4PhfSL1We/T?=
 =?us-ascii?Q?WI0bNarrlDskLxFJvpIzGR+c6AUef1O+uZL9WxoLF5FUAAiAJ4MYtCZbrmsq?=
 =?us-ascii?Q?e8OlPqHNnf0ZHVPEx/fHdynhMwc4E30JuUfoBvINUWS3YJDOTDFLyyMLHqB0?=
 =?us-ascii?Q?gsWkNtS6LBl1WCmgz1OUoWNiRpdXkq09m7UvH90pQ0bjsDLXtAIg/T5h8dHM?=
 =?us-ascii?Q?0BGRfmd9FFuN6JwtRUFAmxhIuGAk/oUicniqVMGGTvUnJBAG2j7NJBtOazjS?=
 =?us-ascii?Q?6Z+SmMncoB1GhrkuYtW9zmUr9245YANjU9qAr7Vvtka3u7LOUXqRWWOsObX4?=
 =?us-ascii?Q?8X4TkznmuN3GBXg/z1JCesh7lck/JWxa9PbFx4UAOp4uSvqtH/4unCh13n7s?=
 =?us-ascii?Q?4nEaION6Xh5f6v9tskSpn0j26hlJjAX2xw/AUFPOkDUoX272MBxcdis8rb3G?=
 =?us-ascii?Q?RDmBQbE2RrUij66fm0FuQT82hYTWxpKgIoMxP7lTOFfVJqtVmg35jXwId5vT?=
 =?us-ascii?Q?srgiztV2Mfk8BookiCRCG3FYdvRWtQ36bYrTXhNObMCY1HlhEZErn9FK8bME?=
 =?us-ascii?Q?0H8m0qGl35a2vZUPwAE/dTL8etF1Bnebx4REk5rzqt3/qo5k6+SUcClY+5Mh?=
 =?us-ascii?Q?XStyOZRNtUMyUT+xCCpmQRDPaVLVVPprLgr/maAdhbeQNZrVBIW+HCODIEpy?=
 =?us-ascii?Q?Ferl9VJu7t+PjbzEmuZo6Wl7PUtc5vQdpFfBgWq9pNI3er4TlVa3DRGXknK0?=
 =?us-ascii?Q?+sVvv0c6dl7WP80lDEPm4pDodjvnSc143yRrLdWrXzLiKzw6cj0ahyTAUZ2h?=
 =?us-ascii?Q?v+REHmGmsuVW9JmnJHKomRPCmq8ZS1Y7MnWL3Eier0mlZZtrrPQEYpOgOMDL?=
 =?us-ascii?Q?jZIqWbTeChFyYVTrBk8ZyUv2qNxS8OLgfVnYrE3hkN0tSPFCUeWtcNVizVxA?=
 =?us-ascii?Q?jBX0+NCnZM4dlTvN+C/LbIMbDc6lR5QRIovd7a16Lof84JAZ3ulURusWPoDQ?=
 =?us-ascii?Q?IA6XYEdNj3UTfGiH3GZv4TXI10LRRVViMrRFfHrXlyhB+WQkFJdN3khnA/aG?=
 =?us-ascii?Q?bye2y6cjb9q2y38ZRjrmGQzJmnORWGrk1Yu65OLsU/3pwpnFB7gMg/JBemxD?=
 =?us-ascii?Q?8rSqhHQxUwVtNbiUQITgZY9GSvhV5B0qOKjMRW+bopQNU60wZvybBlhxxlF4?=
 =?us-ascii?Q?SzApu2BGQuDERV+kM4vuTkLJvgfgP0PD836NjReTxXIkZ6ivbJFGirvTPQub?=
 =?us-ascii?Q?O0a6zERxTTrB2fN+MsHqxRY96yL5mEJvfrwydI+xhjq/CzPMn5ZQ26gd2mLt?=
 =?us-ascii?Q?ZKJ0HUcyUK1PCnIQX9xgQIDD6uLLSkuQpmU/MecNwePN3ySR+KtQ3b30U9o3?=
 =?us-ascii?Q?ba7AQ8hcVRP+o3RIXdNKcbp/On3v0a/ju0oGCbk7NF350SyVEs2u3awJSsig?=
 =?us-ascii?Q?mg2zQlF2YgAWIa1CHqZS9T/KvGir2FIPja/KqFi/ZNNYZGWGLiBYs075KDG7?=
 =?us-ascii?Q?THExtgEcq6UV/6s4V7IQTbwtX1RPDS3K9DvPLtfqMnyi3ZYZwpekTfEa3To6?=
 =?us-ascii?Q?qI1+TT9uY3TxhefwvtOKcBr6lEwkgM4GSUh7nlw1SD8IrWA+NmEwn1p5XCiz?=
 =?us-ascii?Q?Ondmp+MGlezoY3wHG2jtsphcdMQxg7dP994BZfgtKMaDgutgGF8/bMMRf/04?=
 =?us-ascii?Q?arncf8SnWNTJ11C/NVpf5HTvjaBhWa7abz2/wQcZI8MDCKn5fSTusGi/L0qu?=
 =?us-ascii?Q?GtOZEUKvKVz+jap0BlkSAj/W9OhIdSpN4MZGPvEEA1GeCg28ZowF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98feb579-1777-4f51-4e9e-08df1820686d
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:39:18.1615
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +lhlqvLgEvlfBbfNmr7H4MEjGDpUQJ2Zxwry3tJ1aBpengktSiWKGqt1sjwL0bGWDDtQx7SR5wa81kbpvGgFRHeKEZQiHF8fFGwUzXda6vLwGRp24LoFfI/l6PBDyDCk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7603

From: Frank Li <Frank.Li@nxp.com>

Replace direct dma_chan::device::dev access with the proper
dmaengine_get_dma_device() accessor in NTB DMA consumers.

chan->device->dev is not always the device used for DMA mapping.
Some DMA engines support per-channel IOMMU mappings, so different
channels may use different DMA devices.  dmaengine_get_dma_device()
returns the correct device for each channel.

This also prepares for making the DMA engine provider data structures
private. DMA consumers should not access DMA engine internals directly.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- fix commit message wrong mention IIO (copy-parste error). (report by
sashkio)
---
 drivers/ntb/ntb_transport.c | 29 +++++++++++++++++------------
 drivers/ntb/test/ntb_perf.c | 14 ++++++++------
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5b..890697cfc6b96 100644
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

