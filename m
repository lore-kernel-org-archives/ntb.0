Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.71
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793716900;
	b=vm5eAUZ/MSEcMy9M5X6iANyFLF3XEl0Zv3+Srd7Wo6n83632sCLNHo4CkTbLx9W4B0c8
	 m959kf69aJeKgQ41tM/exfTQQspsVulsIa9Z66Y7KeADbG6MC22sdEdzKtAcwOqb4iIfd
	 UYziUUidC1rk/jjBowpbYqUjor4ov2bryRcaRCcVcZvaGL1p3OiGnHH2p4Zixe1Td1Zcl
	 w7s7gARbzCa5Epcb6KSnk5L2pi1j4YJ49t8yfIstEQlYAvvpRHKUj2y/fgaIEBKaEveS6
	 Eb9fDGmNjdeF+cccJd9KEoDSObkZVRmYRLdos/xaCu9GBybSHdrNOEV4kcerbREHMDg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793716900;
	h=DMARC-Filter:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:Content-Transfer-Encoding:Content-Type:
	 X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=5yf6UHsAourFz9mRZIl65FrhaX60vIsLLQoygNILX1c=;
	b=Iq37nTM38vdpP81Lt2MXorCgV9MikodeJmPA5YETNHKlwX3GxvQLDOHj8UUDLSwbBW0n
	 1rrjYaH26e810g0Pa+ZeIz5kbxSm31lgvpHoCYq6lHF7h+3RtB18lYY3X6X1AbJcsHJiK
	 NdtCIKACNSrh8DglKK+n5CmKtThArUmwcrC0GOBjGWu5l6mcD5khr79J3TgzhH/uut2tU
	 RfDlNtZrEZYlDuVt77ZfpN49KOKKh0IkKWUafgDKSWiT5KIdok/37xixQbZCf3rKhGOy8
	 xWaYpBMgWXyDXvFSHwemHPgLCGC8K0j5UmcYihVjLzv7MGxKiGFf5vPoQCiTsREEaQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IJ4l0h3P;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.71
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013071.outbound.protection.outlook.com [52.101.72.71])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FA2606A324;
	Tue,  3 Nov 2026 14:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46FA2606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=IJ4l0h3P
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zV77nh6eFU1s1POmh4eN1rRxpw0Gxy9UVMxMnoVitZ0VKaNV7knV6fUY9aApqdMfj20ZO7HmcQB7FaILYyNu/ZkqIy7sGdfepHduW+y6t7pkvfmurFTVUYeKwKNu/kCsqhFoWqIBCrFS/5e72ESmPY5Su2SodVWQCJDCqm15+KqlFSJJELbvfut8xjtgBN6s1yjUdrXQb/sI+yZXinDOMnJnT3NCpCY4Wg/BlKgutoVSVNDZ7NC0brBTp74936Xj1j1BRgjjnMnKWSeTtHwzlZ+viRUa3QzGOyFha7DdYDrI0v3d5k8IuChNhlTZ8MnWomeioNdlDcTz/v/HWz6dWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yf6UHsAourFz9mRZIl65FrhaX60vIsLLQoygNILX1c=;
 b=EV9A1ygPT4H2hQ37Eg/vBbXBCxNrhIV+DpY4P5WIso+6haSiVTMBhHo9Kqv8JAdT9zpC6rMFdWnekEJNWTEa7Zv3W0XoSVX20wWSOTO0tlPAfXI2ASrrdiAAYXhrwQzoEYlwi5qcYXWd39cphM7+qxs4zMPKVSWzKIjc2GNWH9DELIKNX1sf0VUeyBfPYNsnU1GF1hxSbO45PnCU+Zf1bQVVwaByKmEWR0/99Zs94t1PRiBNrzocl/CbNn5TXCh4NZfnhFztZDR3gleRsD4ECQD0xEHZbf5i0ksMo2YyjQdjnSsXZNNpZecg/u+FdPyhwJjeesoMqSoFj03viznyXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yf6UHsAourFz9mRZIl65FrhaX60vIsLLQoygNILX1c=;
 b=IJ4l0h3P711hb609kHM4IHsae5jcvDItJ0zBkzWAuGfDHHih5rvG5TnLaXSg0o5DVK8bGlei//E2ViEdrJQ3GGVenwbQNbc/XempuljtTN4WoN8DAs9dv0ajt7oPpisSC5QzHq39HsSLkTpncf2IR0iNo01ZHFhQp/NcNjaLPIoCbZWVwz+tyPrVm0kTnz+U8lmD//5DfkiWpaDvz114u/BM9oOvSynDICtUzBdAWunp0WHHIhgNnDNSyYU/v5r8hj8WXvBQnx1zRnwWx9l3kYQVibbmSgcXpf5MXrDWKmjOXj/sM9IlwdKjr0r75V9BQykhmuXqWHVik3UnqfsBbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by VI0PR04MB11747.eurprd04.prod.outlook.com (2603:10a6:800:2ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 14:41:36 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 14:41:36 +0000
From: Frank.Li@oss.nxp.com
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH v2 1/1] ntb: use dmaengine_desc_set_callback()
Date: Tue,  3 Nov 2026 09:41:22 -0500
Message-ID: <20261103144125.1172468-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P220CA0023.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:8:44c::16) To MI3PR04MB12438.eurprd04.prod.outlook.com
 (2603:10a6:290:76::14)
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|VI0PR04MB11747:EE_
X-MS-Office365-Filtering-Correlation-Id: d30a0827-6718-4b55-24a8-08df39b89009
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|23010399003|366016|376014|1800799024|261021121427099003|261021123027099003|261022105027099003|261009223027099003|261026140227099003|261028144727099003|11063799006|18002099003|261102123227099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	BFfwFzdAfIWcpbefcGcnhUqe/QYWuqKAyJE4jzu70n0gaU3SwRoCjijkZd5DO0oLyAP4xZSsZe5/bOZRzjp/wpnp5jmQUGyfYQWfUue143HOuHQj0hHvSP7jlsP0tmkuys23RarLzXqmmoQh4Ip7eMjpQDvyrZUctTZzpI/R0fMvkVf2sI0G81w+FpMbY8K+bOj/8TD6Edprbfg0msSXyMFR1tiprb+IXyh276XfTtRp7CwQ1xaomK/XBsBhY713OqyCCXBqdcIZlcQOoSC0UwshDug88fMH+iq3fGfEsm9HetR/Mb/EPNLAzCZXQhPDKx1zqAP2xFZOQZC9x/V3ZWvK3AhhmTi+YmmiYd2vrLvrFuXF0p1vxZkQQKbPNOxovsab12C3JTvdqaSN1szyE8X25bDMt5UktLeIe7Mtk647xVY2RtEFoUQ/XXR5C7VNgMWCxB94OpW2xMiPh6ZSoIfvI4JA4EVZvl4Uvrp7AhCCNtw/6jgLAqxwnXJv/hdAjQx+HqjJhPA2Q9zQ1qJsyQ1RcrwT7cxExU7QVz1GqZLAaYG6jYWNgcfgYKuhyq2CoT8ClayYjKcBt5w6xc5Do5IhQKAdy0YYQvl45ihPzMdgnoqCviAB6Lg89Opl/AbLTvhnc8DEO1l7jzYo+bNBkvYuEyeO0IqgHCrz/E90ZNM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(23010399003)(366016)(376014)(1800799024)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(261026140227099003)(261028144727099003)(11063799006)(18002099003)(261102123227099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O70pHI8KpOLH7Mdz7PviF7ajLx5U9d624DqyKu1P/ziCfUCep6VpLx9eZjLD?=
 =?us-ascii?Q?iS2vDTd0EbZxhvBeMrjTZp3+eki73waAm+6cYvGzmlpELPg3seAZRitet/hU?=
 =?us-ascii?Q?C++YjakVySe3iMeftl8HeF/K963TZUA1S9E1mETYmDOagntYPtguK+KUnXfN?=
 =?us-ascii?Q?Rg6UtxGFWISolIOSsFz1NicSt2zJQ8qQuCM5PBFIO4ncChMfdnvySF/xdMp6?=
 =?us-ascii?Q?hOyS3jk4HBr0XGKewouXL24LwBREFLW1H2uV5O18S5tg3wE56TufJgw+e6P+?=
 =?us-ascii?Q?EYTRhBkCrJpGrjH0S2dsKuZ9T1piqGE86yktxwlNjFcMM+FyEGEnkltEccsR?=
 =?us-ascii?Q?nRpaksbLS/6xbo2UEsCYryzr5hWMzLh9LdfAsoS1wXChuyG2a5+HUVwFx0ww?=
 =?us-ascii?Q?WXQLTEnns+dgPgwcK3v2xysTeNQvttXmNcXeFhk+pxO/SFYEMjiNXpipzC83?=
 =?us-ascii?Q?U6EleFfczKF9/aKbOydNoOSoccOr+Yz3W5mqMMYRIQ/N3ZTlnCHF3lF3EyB5?=
 =?us-ascii?Q?L0rNnkacnAGWB4DvwoSQ9T3v6MLPcfNq7XGKA8/olL34QRg6IPlp/No/DbkU?=
 =?us-ascii?Q?6Q6KNGvUTOoi9DxOCTuPLhgHrPM1rtstsbJSMlMi0RJDKy4j1evw7+urbbiP?=
 =?us-ascii?Q?41ZYFWH3LfS+8KyBf3tGP4DJPgOiIQwXMEZYKgEvgWH0/UD19RPxwarx77Px?=
 =?us-ascii?Q?qynNslo23GLyhFBnY8t8N2mLE5xPMkeUTSa+vXQU+pUNZ+Uj+NA0Ps2m1kyB?=
 =?us-ascii?Q?9u3GAnhysCau9jyjmb7NEN47qIg3dL17YS89KQbRlnnbyBsILjYp0nbTLh0v?=
 =?us-ascii?Q?ApLmDG+se4Ey1O6T4ODnUubw3+VbaWs/wf8tRr93Fy5uL/wlZtgOXWfCV4Ws?=
 =?us-ascii?Q?TPHq9+dHMoIUgxYPtZI+VAIa8WxGX7+kIJ7YggJ8rpYlc/57x6rGImrnTtNy?=
 =?us-ascii?Q?ChAFOHGV4QtRSs8nDeQU5d+OI059+UCtwbY9PmSGoBNE/WBCDCJ1rEnfzLD0?=
 =?us-ascii?Q?shBV890wyTz7q0gI8MoLO42tK1DxxirqKV7pDbNpnLmp0X4D9UiSrzU1kVan?=
 =?us-ascii?Q?3fxSmJmpQz7DPjrrlhxud6zlx1VQwXNF4THIUW8GyXy96ukrvuS9TOj83hJI?=
 =?us-ascii?Q?th+RTNhnblmWAJTIJEOhXQf1UgX0mHZ+YfK+DQ2ygM1DVA+Ts7D3tL7lo4B8?=
 =?us-ascii?Q?XKOVh/SacSWF24Pu8R6tnzwn+g6sKI/gmaxCAxYMPAQiyBSPgoIY/Z1L8JR2?=
 =?us-ascii?Q?nPXeEiag7M/3b94VmrdemGP3zOkoIGVgx01l2NN3NGm/j2ylLiE9F3aFGC/v?=
 =?us-ascii?Q?PFT1ETq7/oX0PuA8gLFwPYyrlMdRfjBiSN7iNM8iWWBRcrtz0r0cRFWgfInn?=
 =?us-ascii?Q?1NSwmwM7n7ckcjazuQDTn2fgndw1gYV87hVAKtWRg+OPeWIw1mOxMmY3ny48?=
 =?us-ascii?Q?j67mY11vSLDO1pWoPuP+fYvmPpmRunG3tRMAjheZcqNzDJ/JrP2mcDhUMztq?=
 =?us-ascii?Q?VrUN4dBSP+rTm517XWLM218vqm/1hYZHcXOhgNwtVQCRJAYd/fR4DtxrFfIg?=
 =?us-ascii?Q?OD1v+OGSybvoG7K9Nv26E5LuoqGHTa611GPw3kG7j6a8CwYCLB7HhkDUuC39?=
 =?us-ascii?Q?5TvM/XCaEi5FZf86njdMUbUlz5TZRDfieI1dk1bfKD5ZJTCaAUCVbO3/0yIg?=
 =?us-ascii?Q?0tnxYsj9O5q3YX4Cxlw/l+lEJcFKk+Yii0MljKCN6u2lUso+DfDp41elIsEq?=
 =?us-ascii?Q?BJBZ7r8s1FRr1pYUoQhn7EdcMmc0iVgN2m6WBo9HmLro1RpsnXfP?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30a0827-6718-4b55-24a8-08df39b89009
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 14:41:36.5012
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/R8CrGciXsH75Y5/0MxBE3B9IqcuDdGG7nfgzKfdPv4aVAQwPXZxa9mezNI+bISJubABAcU2RIJQBHfEYOMT9KfMNvfILq7op8tSpYAq3PzlRMSwMHPsSNHb/Y4wPNh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11747

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across ntb drivers.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Acked-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change in v2
- collect Dave jiang's Ack
- split rapidio part to new patch. This patch only touch ntb part.
---
 drivers/ntb/ntb_transport.c | 6 ++----
 drivers/ntb/test/ntb_perf.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5b..370196ecf8f9d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1557,8 +1557,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 	if (!txd)
 		goto err_get_unmap;
 
-	txd->callback_result = ntb_rx_copy_callback;
-	txd->callback_param = entry;
+	dmaengine_desc_set_callback(txd, NULL, ntb_rx_copy_callback, entry);
 	dma_set_unmap(txd, unmap);
 
 	cookie = dmaengine_submit(txd);
@@ -1889,8 +1888,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	if (!txd)
 		goto err_get_unmap;
 
-	txd->callback_result = ntb_tx_copy_callback;
-	txd->callback_param = entry;
+	dmaengine_desc_set_callback(txd, NULL, ntb_tx_copy_callback, entry);
 	dma_set_unmap(txd, unmap);
 
 	cookie = dmaengine_submit(txd);
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index dfd175f79e8f0..862b3dffa2b17 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -834,8 +834,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
 		goto err_free_resource;
 	}
 
-	tx->callback = perf_dma_copy_callback;
-	tx->callback_param = pthr;
+	dmaengine_desc_set_callback(tx, perf_dma_copy_callback, NULL, pthr);
 	dma_set_unmap(tx, unmap);
 
 	ret = dma_submit_error(dmaengine_submit(tx));
-- 
2.43.0

