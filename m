Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.29
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793649480;
	b=gYQhEmP4LBgDyMP2fXhACqIpDbx2kl4sXEGqZcVBaYRWQL1HPIy8LYxFwcyETxuDC10L
	 J2C2L1O+mDCTLat9z8w9BDgvgxjOFO571MoWYz2WwVcnTMwHy7rXHLE+fMLlFssbI7t90
	 P6oRHSTRobePCiCh6HvptglIkhSpMn6nYb135YNm4xvpbzQLwydm8DHx8ZScFB0Nv/Bi5
	 KfT9b35fRToe19t5WAdKPNvG0k9RK4jJqohsdI3sG1OFMHz3HoAJwLfu4WDFaL0BIXps3
	 bn05OjsLfioCxFq9PprlYTV46flodlVBJX8HV2HPJQv9bIuzCMYrq/7++rmliADT4Bw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793649480;
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
	bh=MgWA+/BF/gC+z6m15lUgLousRtnTbEkzXh3LWzXxnl4=;
	b=lApyTtSsa/FZZydb6acTtXBF4V7eWTrw57LRWjwveZtyttnCgj/QR3RjzdN4Z11k2Mvk
	 FBsLUCDELjw8LlgWIfY/6566vD6RMstSegmdeCTegzip+cHlYC9Wvu68x7kmZ6UGlX5Mi
	 ehUlrPG9WsiCApYh+iR/5WS83TT6v1DcBnZI1UFhaExqw/wAdA57tC0QPj75muspH0muO
	 EKswFB6zxD7zjwKHZmgg91zJ1LKyv3D2zX+u1tsBumOKxA8KEv6hdiaULMQ6YM7SvsZxg
	 00EfZeVxyeubLzxh9vx8LuuKOTOS1pGBhnyt/Hmqe0Emp3pohQeSpS3pyEAhk4AQYeA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.nxp.com;
	spf=pass smtp.mailfrom=oss.nxp.com;
	dkim=pass header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GEDccPwo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.29
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010029.outbound.protection.outlook.com [52.101.84.29])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79CB606A324;
	Mon,  2 Nov 2026 19:57:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C79CB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.a=rsa-sha256 header.s=selector1-NXP1-onmicrosoft-com header.b=GEDccPwo
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Il2P+Eoo9rQPbhLJaL5wnI/75h9i6g1gMSQ2EHL18dYNhbNwbtZEL6uy4X8y4Ad/GepzZTkze1a0ocTfU+sgutE83n4sr7347QFGD0SGHSuAOuBFHXaYFPFX0W/WAChdYcKc5SDbge4zRwlUAC9143NU920d4dG2/I84ul8P17a1N9BUuh4pYtarpqOv62wdy9jOS+Utg9vxTyvg1NMIi0wWBgUsaLafbRORgdzYbMPc3IrFvm5fuO59oL3ZeLGjPzrRKfV2/GpBIo3pD37uEkBaNP+e3Ho2FIm1vUvvkDe20pt6tfiEAHcoo/OD4qzNb8gvV1wIbSxhKdDWlh8udQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgWA+/BF/gC+z6m15lUgLousRtnTbEkzXh3LWzXxnl4=;
 b=fGrIgiP5tekjV8nGfvgOFufq4VrFm+T2s/rTkM7gQ4kCReZSS3ath3MCIb8yN4SruwGkWbUa3oL65xQmMvUNlPjhoUIqRTmzXg97xFlbr4r8K5ebVU+/60rXttp7nSVyKHp9zCd5V/GpgQ/Sx1dJbxEDBcNWBHG0QsPAPCmXqiRWCkfNvsU0zi2hwSd14h6+Yb94l9Q8hsATMhpu5GmoUJY5ALg119BRs/vEOuZbyIh2AGVCQ35vGbiMxkpgu63N1UXX2Xb/+1aZmCagQi72rVMUdNwE7pSJm/sBcMlfoPCJ50O0Jjl4KkKGxMmvO0HVFCpq4fIcySHE32a4xzUtaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgWA+/BF/gC+z6m15lUgLousRtnTbEkzXh3LWzXxnl4=;
 b=GEDccPwoZYFlQrmVDaX5IWzDWftlzolpGlBeVCIzdlsS21QtS4NW8fXsVnzYg8t+/jFkRx0xVy9af0J8+lTZKGzCEya5IF0edqRWdyS9LISULPVQOW+K53anO4QC3lhe0EvvTmqIpG85Pi1pbzY8Rv2b65+5LrYJVhHua43o+CYFlHlhDdH0RJv3e5uECuNqXkL1WDO7oKJRq1KPJt2m6+TZKWn7bD6V47R+1u5is5vQ5IZB2LTgrcdSKPfVhKrk44unIVb94JksUF0Wimp0/l4zcsGaHJ9OaXTauLjY6GMuNU8ukkImXjA8OyxZPEayYTnyNiWeGg2zkKbf8kYzLw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com (2603:10a6:290:76::14)
 by BR0PR04MB048570.eurprd04.prod.outlook.com (2603:10a6:2c8:50::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 19:57:56 +0000
Received: from MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b]) by MI3PR04MB12438.eurprd04.prod.outlook.com
 ([fe80::c715:c32:8bb1:b70b%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 19:57:56 +0000
From: Frank.Li@oss.nxp.com
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Matt Porter <mporter@kernel.crashing.org>,
	Alexandre Bounine <alex.bou9@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	James Kim <james010kim@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org
Subject: [PATCH 1/1] ntb: use dmaengine_desc_set_callback()
Date: Mon,  2 Nov 2026 14:57:41 -0500
Message-ID: <20261102195748.4092882-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS1P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:8:453::17) To MI3PR04MB12438.eurprd04.prod.outlook.com
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
X-MS-TrafficTypeDiagnostic: MI3PR04MB12438:EE_|BR0PR04MB048570:EE_
X-MS-Office365-Filtering-Correlation-Id: 797752d5-9cf5-4a0c-b1a0-08df391b967d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|366016|1800799024|23010399003|10067099003|18002099003|921020|261102123227099003|56012099006|11063799006|261021123027099003|261022105027099003|261026140227099003|261026121527099003|261009223027099003|261028144727099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	HnsriIeHjYsJqeHVcZEarhb6uK+ZHAMqGTWgtbWuN74tCwft2fMO566KZkYQK4gSdlt3BWb4Z1QMgVA0u1zQzdOvasXQLG61iI5Aanb5skfCjgbbpbN0n4++m5q6VCfk2HKd+JKNj1cknGU51kQi6irCbnPOrwbpU8JQQrBspr+IwFoGmdIMhMlZJ2nWZTxH9SOSknszk+ZdF9fXiwPlCe1O4XnCLYEpwX43+FwblzYzKClqLcZGUx/+4GkLrJI4XVXB3uu/JLP499DQ6Y/MhI1Kpn6Mcl7g9mvtu26ZV8BU5fw/h8oLc89+Rvw6qnzLOuFm9cVf/g/VGf8F9b5KoPdyQlDixMxAkjIy0KX6/DEMXGrF3KnfZS43+5VI4BY9gk72935k8acuarb0Dd1NbS/CuAAwvF/M4riTrSaXKSJIzfiY2bdyFss9FBqKrF2c0mdgb282h4OYD8pCv5+i+xwlg3RCPw4nYW6dtxlBu/280WOADxdJRHjk2Zj0sAXzbmVpwvtJOKDKdCHMPsS0kMKtm1xy6coJK63v8rkgaYlGlVyO1lj2rIzE4PKlVuBf+y1fkFdx4ij88RnwqXVjAwhHs3x4CJxB73az5/5/DjBp0+/wwOHlA2kiP8MMg1cCT9itxdQfcJPRipAh4dKqgI9Fzp7+ZCZkZeLzsS9PDNA70O3mzs6FQQLnNSIZKC1yqtBsGmyWb7tfSPh3M5F85Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MI3PR04MB12438.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(366016)(1800799024)(23010399003)(10067099003)(18002099003)(921020)(261102123227099003)(56012099006)(11063799006)(261021123027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261009223027099003)(261028144727099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YtKI0m9TLuydJdYVo2/U0kB6K+Et56f1X1mtygoGkdQtrMnOwoIcU6JIQ++y?=
 =?us-ascii?Q?3enDSuXUUkkarw8OTRJifRRWEeb6xJnRaH1m0Smkp4YfwAFB2MbZJ0x9Uv4s?=
 =?us-ascii?Q?MtFhMdFATJmRk5C+Ctm/U1pbZrYRx9RWTN3/xdV0jgS1HMRKx6pWdEbilUXK?=
 =?us-ascii?Q?c06w7q5a5lJC6d8uOp0PtqTWZfyLC/8+8Ie9QdwuOep8pWO5bSuHGdvKGOyi?=
 =?us-ascii?Q?6iqzKErpF+rDBKiErkbTDNlwvqSR04kN/R1ukLbzeWS4qa1OWYiQasZqbpmM?=
 =?us-ascii?Q?PzWu+BL4PfVtuV7tCM7/2E+JF09bwpGAGa6S96VeU5Z714I7NNwxdW6ViYQd?=
 =?us-ascii?Q?b+YFljdlrODpyHdV4VtVNNTGnizwk1zMZ+ILmfzlgotIcyNAiiMnDEZFHZ+3?=
 =?us-ascii?Q?q3Yrd6D7SQfBkrjWQiRq695V3Ynriu3X/bm4EnIyz7/REDRyPJZ/2JnbHW1P?=
 =?us-ascii?Q?CZ5LHjoYwW4oJamiqfvGjH8zCFenqHnWu4u+Os1QW4sqPeki4i6WyO5LzEvi?=
 =?us-ascii?Q?JiO6izx5h5h5WZbLaqcYpLD6VUSEwFxFOs7XmZuuU8hEQvoKNorUtHnp6ULD?=
 =?us-ascii?Q?MauReLvr/Gonu+k/FyvHMHAi14VyCd6gWab2rtdZN9xjIIIUEChVAAsNXcSt?=
 =?us-ascii?Q?A8bqWbnvxYdiITXct5MlssxXHnolxShDzuvuykbyb7BVxj112ad2wqq8Z4tl?=
 =?us-ascii?Q?2BbdvgKXcRf0yMmBlB9Y9P9tVX9VKltr4bAE7kfMCpS+8mR0tReAP9zlvjl1?=
 =?us-ascii?Q?VloFO+Q8L5B2jyfej4fFuTRccvCfqEO9iL8SXjYn0Km/S5dvqxy6qW4Zg+7y?=
 =?us-ascii?Q?EfK3/0bFPOGLpF6JRxIscHS83WlZr5Uva/7vcoruYUeE6+1ySecp7F4CAkyb?=
 =?us-ascii?Q?KlVy2WUuy3NOdZAagS94SB9jifuhRAUAEABAsfNIlBnFJuyzGuZy8s61GQcE?=
 =?us-ascii?Q?xeT0jdu6bY+ph8KsJSw860wWvUMTJtzW5FaApESB6ZKAXjq9jzuyHYm2LPuK?=
 =?us-ascii?Q?4yAGS7LKEp4n3xxXiipessWgl7v0PPmFgFZWonAWcpJX5czuaoq73cF3b8Kr?=
 =?us-ascii?Q?3ZerO7E7cM7I3z8ynQyJBpPKN2ELEWZ/YSNhE67cW//ahaRQLy+TC9lBkOl5?=
 =?us-ascii?Q?1H3eMO5TMhQFNVAbNbS+uG8iaE9oTra2DmCwnkYwr1GMNbfb9/Gl5fPdUyUt?=
 =?us-ascii?Q?akpVsCIR0gvR/HFzfpCXgLwO5W4mqiS+x2Z/xJtCPrQIqT+23PXDkk92un7d?=
 =?us-ascii?Q?SnTAOZUeML53NwMeDDaVytDGxr3wFh+IFze9/vxEmkmCOqKNMwhtet6pepVt?=
 =?us-ascii?Q?xgwGzIGe8xHedaxrng2826VSi+KAcKuqXu8G7yHjl93Lc7F+5dAscTNGrOLS?=
 =?us-ascii?Q?QgkTnLEMSwhF1dLFxRN60oYmEnfDYYSnx2OUFJ/7mal7RfbhnyytxHqYFq+h?=
 =?us-ascii?Q?KuP4qmFxzCK/WSIbyH5ecXOmkTQNUofG0LxCPBWHsT6awsa4NebNDk5lJvTT?=
 =?us-ascii?Q?StTyYcjrgaHq8k/rIDbF5omG0jvYNFgAp+vxywix12l+qEsyKgKrud8hiDhO?=
 =?us-ascii?Q?V5cf4uh0sA7YfdSoWwEcd6kscnluRcO5HRMukGja7UPccfYuscSy1Gjhltlz?=
 =?us-ascii?Q?fUI+OVlusuFkZAQDTtlJzfezPbGk4s74umujgj7aoiPWhYID0XMhj/VRxb+8?=
 =?us-ascii?Q?myoc2KzR1MOo5FsdvcnIkNk1f1aTHF4h6CArRmmAQHSeG7fhtxUbIqNovEgZ?=
 =?us-ascii?Q?AGbBWUpIE3XL5P7h7+umvfppQyiCfbmSjslXZ18riKn/PsPrhOSG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 797752d5-9cf5-4a0c-b1a0-08df391b967d
X-MS-Exchange-CrossTenant-AuthSource: MI3PR04MB12438.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 19:57:56.2218
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iTUvRgMWUn4t9TCEv36vu+6BA2/IZSS/Y0lKCOv8GUc3C/mQSrgOdVlvwoKWJO1F/79ja3N1aHvT8ko+BGSiCl+XrKz+FKHxS8eSRuPVeDrUrpDmBMz6YQS2LsDf+6z5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR0PR04MB048570

From: Frank Li <Frank.Li@nxp.com>

Replace open-coded assignments to callback and callback_param fields
of struct dma_async_tx_descriptor with calls to the
dmaengine_desc_set_callback() helper across ntb drivers.

No functional change intended. Prepare to make struct
dma_async_tx_descriptor private to the DMA engine.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ntb/ntb_transport.c              | 6 ++----
 drivers/ntb/test/ntb_perf.c              | 3 +--
 drivers/rapidio/devices/rio_mport_cdev.c | 3 +--
 3 files changed, 4 insertions(+), 8 deletions(-)

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
diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
index 40d2953a9a7f9..585e3f9ff29ca 100644
--- a/drivers/rapidio/devices/rio_mport_cdev.c
+++ b/drivers/rapidio/devices/rio_mport_cdev.c
@@ -717,8 +717,7 @@ static int do_dma_request(struct mport_dma_req *req,
 		goto err_out;
 	}
 
-	tx->callback = dma_xfer_callback;
-	tx->callback_param = req;
+	dmaengine_desc_set_callback(tx, dma_xfer_callback, NULL, req);
 
 	req->status = DMA_IN_PROGRESS;
 	kref_get(&req->refcount);
-- 
2.43.0

