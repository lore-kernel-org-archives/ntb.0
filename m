Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010004.outbound.protection.outlook.com [52.101.229.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335901D86DC
	for <ntb@lists.linux.dev>; Mon, 27 Oct 2025 00:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761525826; cv=fail; b=HpRYX7Rm+nbY7vuDUAyKnapp3UD01cihcgaSBvIUb1F3fpzsk6QGp0pPOzaMqbZOCFE/daQqZmfzLuyi2sxQnPtFpeYlbxDTpC8eBMi1F71dY7ohe70I3sQrfKp/RRnxmFi8SMh+x/dPVyD0rvjjXIoWE5K3GTgrMpRNPSAgZZ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761525826; c=relaxed/simple;
	bh=zadNKUlkXnCyHgCtNGuLV+IrAYjQjD4WONOObgiQnn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BEVjyx5PoOcwhgGhg8qDQ7kIfmTJpxqQVgXFo5TGXLyAJHFgg0W5a0OmMLk2o/+mZ/QHvbwog88kjU7OYG4SlgslJZ2o8U62BFTzeRbYMmBjSFjlskCVIvA0RukvijCH4T5hh88kH1jzhpvPxVlzYp4FxGRi4tWozLgtmQ3Bko8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=rTps8Mb4; arc=fail smtp.client-ip=52.101.229.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="rTps8Mb4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCFAGkYJ4XmFAGAsBzDh6L8x2UIKitMJvMd3KqHourUwh1I5bpniU7pXTyR5kUXBxuOMnatUu32Kx+fhWG+DeYm6r2Bn5BOxozqkUfZ5/9z8yd/82ow2LU4qjXLkW0AxuPGETvopbg/7MaRXWt6x4jJ6cOuVTb00uWMcsGbu3nDQbQ2+nVckRyJaP4nc8ghUdOdnHhFKpNIaWtO2ySmiZXlEiP3dMbZk4JbxzTBUj4j70fyUH9mR8E9Amt4Z/d49A8Q0zppEU7d2+rUBZvRSx7pCE7NTFp4Euwv5gWKUjZDK36DEo7simVHbmJsohRb+5v3znm/GWSGIV+mwuxs0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RQO43BLZLVUeTCWJQE4IGlJ+u/bzb1xmx2HOgJqO+oc=;
 b=T41H2KMVI5Y28edy7NdwdSSezoiYCjiEwAC1JeR/b7WEU2t2tasXEFnkJa8XEUXATTOvHGovVrMlsDMurPMwGYuqxZrGFClJEYt0XsLAle+yLQovYFWuE56OOGnJFSZA2Phj7rgyTwbQ56wGV6OYF4w3OeqHjqGzLOYTc5TCckBprPuS8mphCAz9ev7EvFw135RvLvPL4EUq8ZSwyR9xYU27COEsTJn90ruPV69Mc0kYrDvd6eXTzRhoOmUoOqmTLKTP3b+V/kjHL1YYxHoKr7E7XoEtKm6/hG8K6fxYKrM4A0y0xHibD1yT5Ky/gQniceO1hHZVCfkXJ5uyahU/cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RQO43BLZLVUeTCWJQE4IGlJ+u/bzb1xmx2HOgJqO+oc=;
 b=rTps8Mb4UjJgjF01vJN22ZUrC/3CYGuYNvoJODG6mUw4lOG8STOJ3Fr3IGhT1CEPBox+QKoLlv4YDG0jxHy7UsjGgezK6452eU6jRNwBQF4xzc1e98ahGVxavpdNao59Rk0GY2UbYdAHK7xrSqrhAssisiHBW2P0QS69IGl2Y4Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYTP286MB3461.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:39f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Mon, 27 Oct
 2025 00:43:40 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.017; Mon, 27 Oct 2025
 00:43:40 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 3/4] NTB: ntb_transport: Add module parameters use_tx_dma/use_rx_dma
Date: Mon, 27 Oct 2025 09:43:30 +0900
Message-ID: <20251027004331.562345-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251027004331.562345-1-den@valinux.co.jp>
References: <20251027004331.562345-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::7) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYTP286MB3461:EE_
X-MS-Office365-Filtering-Correlation-Id: d88a21c7-33a6-4620-51d0-08de14f1df78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|10070799003|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YX8RKR17PlEUqWtEhsxl/+QiaoUSnlMmVz173/id5R+LeSJJfgx5y0dFvXTk?=
 =?us-ascii?Q?DB0jVHtxnk/CN2wisZDlNdmjmAKf2yV32gDdaMXmXbVkMOp+S+gJch0Xy7z9?=
 =?us-ascii?Q?MHvDxe0tEdlzVEH6xgjLqw7LV7+nYf2wTcdHd8gwaEww9lNSm9gWk6WpjrZ0?=
 =?us-ascii?Q?gyq0ifD08iXfBOkcN+KhOlTY4VRrKvqWxaGuHPa3k/mwvfxhYKt/uDzJ9TQ2?=
 =?us-ascii?Q?l2oadUYtOEsmJ0xU8oBhZeJQh8dROpHzTkyJ7uIVS7hg8NTmsNu/Vv++f9Cc?=
 =?us-ascii?Q?KT9hR0ykMQFNrkCgRuw9RuCfmuUzvLIxaEyJ2ECfz6/p1FWQcywYRYU66kY2?=
 =?us-ascii?Q?FI9FF9gQjDA3Yfcr6d9kYG7DQfhp63Rv/tG8cLkW6sXgSXUInVxg+EdRlnCw?=
 =?us-ascii?Q?ESxm3U3Q+5Ah6lKWIUimoZgrkR0rZe2lTYgTfXs+Wmwtdy1e5HbKQJC0wGaS?=
 =?us-ascii?Q?5ANsg55KpddlSukRipsIDTiwFQRxyocplcwwKVwAggkk2aW86zKz2IXEmEtW?=
 =?us-ascii?Q?LWWBPXRJRAGdgpmUb/hJChQjumuHhfULjPQyT2hp7VXBG6Sp3VIoSPidCjLE?=
 =?us-ascii?Q?KdaTtDqDnN3gIBh4qi6votQypIaS7TtkgxcO9j5xQPqtZAl+CKfZYeKm/Ei5?=
 =?us-ascii?Q?nMpuaaE5RQLxUI/QkABsh5GGAS4iQ3reFqOFhOkjCFoglqFlIp+oz0nAalGS?=
 =?us-ascii?Q?xP0qGD6rj0c+kC8CFz/C93J8P1pVeRAEiI4Fc8M5snEvlZCMEHO7F8L+QYWE?=
 =?us-ascii?Q?6M8eyFgUWdODufMTUClfeCLypiWiiSNp06ikZDgV8GpfXx//PFu5uVMSeoBN?=
 =?us-ascii?Q?iKwvQJsNnbNuP5kp5fvx1xr4bu9JKYj/piciVO0VkunpUGfb5fC00n7XAT+o?=
 =?us-ascii?Q?RzVmih/q2BTCgr4SFez9EId0oxwBiL1bWNMBpv0EI8rlNA8vBJIZZk9TZDdH?=
 =?us-ascii?Q?825L5qaaIJI84MNF62JciuyW+DlEE5NShWbhTqYcPtfyg3Es0LFAV5lstBa9?=
 =?us-ascii?Q?U84JTaEi5LyMAQ8z8ySP+8hPMREzL0+uQOlNGAjTaaq1gB5Y0LgiVTCMh9EE?=
 =?us-ascii?Q?AJeSXw4gxXcoisxgXkkJuLn3Mb0i+8+0hEKBVr7wNa1v7lAYaazHkKI34JAA?=
 =?us-ascii?Q?38vgfQNdZQcdUh5f6wK4rRU08VAz6VrQKUvbT3+DuGUzuvEW26n/l+VVRXxL?=
 =?us-ascii?Q?aUDpVN+Tbyu61cQVXfl6Vua+yZequ7bMH1WskY5UEauVrgE8cw+w85dlXHjb?=
 =?us-ascii?Q?oKuz/lEIZOwAVOEqGSu4uClYZEtkGFYoPe6kVfI9jJTGOrQB/pLobCSjcJ5U?=
 =?us-ascii?Q?l96WVkN16eYP+Ibd6XZOOW6Q6F6OIVdvzk+l49cgiyHaZPRpHqMvFBGBXtOh?=
 =?us-ascii?Q?gXYq3HelNCju+B1gt045F9t8On4dMWUHtwBKzELO1QZhECcJN1YSzyEFmYH/?=
 =?us-ascii?Q?M4hjUtmW9u2+wA5l38afINFUD0kIHVI5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kXqcNpDiP3pI9k74Du6jrYGWTw3Uu2s5vQzk8PXmJO9hvoTxLYsH+2LbwCWp?=
 =?us-ascii?Q?vE9ZGeu1ocsLJMxl8aio9HNVDMBwwrQ9fyqtxc9vtnEupyDdWzUA2hGGjbBP?=
 =?us-ascii?Q?7Rrog4K/0H4pSC9d+k4C77hv/hIc43wiUX1Sa0ydqTfjVR2KoRc1Hc+LiTlF?=
 =?us-ascii?Q?3FrpfxGVBWGIOecAlIBbj677oJC8GSor4aYv3YnhvbmFP4Mupc0UTJ/7/jCx?=
 =?us-ascii?Q?92kc1kJ6ju8/trbDOzj01v7IHaxjfpadsovuBck7ymrHWbbeyBvfJFq1nd8Q?=
 =?us-ascii?Q?vzH/5xAxBBrZll7htvk9sppSlgFW136dWr05bVrPMGoxituMwhPpSWfNl9yX?=
 =?us-ascii?Q?F8cS4HC5yl6qJ0XJ6a9PG8/PaUoX/ZX4mIi4Xa5A45o5dISvPVSpj0jjOh4e?=
 =?us-ascii?Q?6PnSabzjJYZ3ZKwt8cA/AgP6muGHIQpMoJFjX7oaXTmWruMFH6+LqA5kQifN?=
 =?us-ascii?Q?IwtcE2oGozbvwlIF8ojdkPOtgf7/HZkTiQdUX9Ho6RtFjIhhOSqNM+fmw0UD?=
 =?us-ascii?Q?oJjtDe6ylcsEz1KvpQ2qKLQTkrmH5OKW0o+vCH4ZKkeVWvNdwjbtm+O7kZ/D?=
 =?us-ascii?Q?tVhIqmLJNXQVyMiGutgMVUbWgs10YbPCiYlNqFfdpVSEvHELyBFaV5jldZcq?=
 =?us-ascii?Q?NUEklHBaWwHP3jdke1bGeuDjWisdSG3A5A5TLgqoluUmEQuZ6LznH02B1/kO?=
 =?us-ascii?Q?rn+WV4Yl1btT0stccOyQDVR1FYGpFNkuouyFzUNuiQZixyYKX3XG2iCjNEQI?=
 =?us-ascii?Q?r/ldiMVvqTwEtRAKIRM/+GRKRCppcgE1//HDogqpPqJnBwzclaaHoz+uGI7f?=
 =?us-ascii?Q?PYny0Ewzn6nknBr6Rx71iySxBuBc5OK8CCDwg2Vo7eB8eTc2FLsjqYvN//j1?=
 =?us-ascii?Q?CyFqXgYaxShs8vvMHYbNjgUDjg9vurVABCp98FepjbFsDm4WkRS4h3UWIwMx?=
 =?us-ascii?Q?tN7EZLzIiZQuKGtaLjGk+mBDRRNEJH/qjRG5WHMApGpFHaNtshg8UvkdvHkS?=
 =?us-ascii?Q?31epIzmERVvc6R97jU2fNpybBYNfJ95n8tgFnDyAHuee7Dkd0N9lVMhwiVss?=
 =?us-ascii?Q?Kyz9oL6CADtYe7iIRxj+BDdtJwHZqfS26o7HF5aui/mVW58iuURrCMepT+7A?=
 =?us-ascii?Q?wiefMe6KFM2dAOog2GHrmqxBslihlxYJFoLyLm65M/5ZfJVt1t34AksTYsSB?=
 =?us-ascii?Q?lEQosMf+PPdl1BtGCwNvtVtfwkr67jHkaHxehJ5YV8GPQKqZmeAyNLZmuHVq?=
 =?us-ascii?Q?F2QHSa3sjRRcpC+rq6tKBP2yedytsexNxColHqldtAkvxp5xCTlckLw28vAB?=
 =?us-ascii?Q?L7LUAyIIVgF+bIJ9nHa0dTWi+uy7CX3q5LyCLNv/eVhNcfYA038Q87EVU2jl?=
 =?us-ascii?Q?f08DsiYkm/S7WIWOKyHAKrrWz5xvPnw5GY2OmfjznrWPavJk5Osb14yavvAN?=
 =?us-ascii?Q?BRWh09TX9o0MjllPnB75mVolfdWJRkTz76xK7WvuEcjq91h+WnKGLAy7tP3U?=
 =?us-ascii?Q?4YyRKFtjY9qNLDp7dGUgmkhr4Ztl4tZQNHeP/46rQ3w9xtin4LeAH7tqgBDa?=
 =?us-ascii?Q?3spmXLfrkRNwrP+5UFMyM1vPFReVyld8Nw/vSIfCVwCIntiG1ZSBMKSsA10h?=
 =?us-ascii?Q?56CCB7wNmKVKmkBQwgpAVP0=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d88a21c7-33a6-4620-51d0-08de14f1df78
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2025 00:43:40.3317
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QTxvXCxN+24IpC4cv7LAKin9j2Oh8OTlk5dZ6iN2RVBRhG8110EeyrySMKwnTSDVJ7FVi8w6CjowxQ1JCAedUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB3461

Allow enabling or disabling DMA separately for TX and RX to optimize
performance depending on the environment. The existing use_dma option is
retained for backward compatibility. Setting it to 1 enables DMA for
both directions.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index a447eca27d0f..aee6793812bc 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -92,7 +92,15 @@ MODULE_PARM_DESC(copy_bytes, "Threshold under which NTB will use the CPU to copy
 
 static bool use_dma;
 module_param(use_dma, bool, 0644);
-MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
+MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy on both TX and RX");
+
+static bool use_tx_dma;
+module_param(use_tx_dma, bool, 0644);
+MODULE_PARM_DESC(use_tx_dma, "Use DMA engine to perform large data copy on TX");
+
+static bool use_rx_dma;
+module_param(use_rx_dma, bool, 0644);
+MODULE_PARM_DESC(use_rx_dma, "Use DMA engine to perform large data copy on RX");
 
 static bool use_msi;
 #ifdef CONFIG_NTB_MSI
@@ -2047,21 +2055,26 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
 	if (use_dma) {
+		use_tx_dma = true;
+		use_rx_dma = true;
+	}
+	if (use_tx_dma) {
 		qp->tx_dma_chan =
 			dma_request_channel(dma_mask, ntb_dma_filter_fn,
 					    (void *)(unsigned long)node);
 		if (!qp->tx_dma_chan)
 			dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
+	} else
+		qp->tx_dma_chan = NULL;
 
+	if (use_rx_dma) {
 		qp->rx_dma_chan =
 			dma_request_channel(dma_mask, ntb_dma_filter_fn,
 					    (void *)(unsigned long)node);
 		if (!qp->rx_dma_chan)
 			dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
-	} else {
-		qp->tx_dma_chan = NULL;
+	} else
 		qp->rx_dma_chan = NULL;
-	}
 
 	qp->tx_mw_dma_addr = 0;
 	if (qp->tx_dma_chan) {
-- 
2.48.1

