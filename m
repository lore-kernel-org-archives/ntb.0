Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68539415F23
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 05:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499304; cv=fail; b=V0bSZXHL7hfH+4TaWU09B3RfFL27+LVWostaadFKdkuSNhkm7p7EMbSe2+8KG02A+AZ5J6+Pu8nKNQqz2+yK+DTjpEMOZ8QcU/LnkhVLGhSfWZNqfSOKB/m9OfGy6PGERj8zwGpeq4qc6KYBc7ruExEYTVoQtXIK1s9ZZPpTfG8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499304; c=relaxed/simple;
	bh=cdbl5Y3nfDGF+oK/i9KjOGbFK6M2/iIm4Y4F/yFrZCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HpFgPEaAsABKfEZ6rqqOTSB/yIpnkZZUrUyK5zETB1BQpCk94M5PX5XSe4ugVPNDZ3T6Q6yv+n096ADPyfMEgy/JEvXAWHuCe7NiroIuEcVnvN9T5SpwhVl8LOG8TRLy+ImD4m+6M6KuoABYUhmFmzeNdgQQ8JtkzC7oiSfQCgE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FRExhgoW; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FRExhgoW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ksvYiil9sArvZlWKmdrjtmaEgbcZAwYgILacisezKTt6TBNX9S9PLM6JY3JHJCi3cFhFXDFS6XVGfBFINqOepMhdcbqSfLD0nG8RFNx97kaxibLgbGR5SqTGlHAzJgbxft/z5/Yc2YY3YxBHjJN4URzlsZIbVAXP8Y7ugLxbCM+xYyOzX2ul22Bz0jR9lqsg29gulcG+mIz2z9jxVq6uCCmTMXC12AF7CM32JJ3GbqvaPkOFPIqNkvkeEI7yRCgNAJmZzI1f2MKdvU94xzyVqOXD3Lq7B2gC6f7UiNRdIMQnGd/L8JaIJMWCVknNnv5yKNSWaIeSGmqug0szdc7kug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sHwUt1o0grqB2iFrdvyHAd9gD3sUMw226msh5VDt7kQ=;
 b=pMiqe0by0u7hEg77zBLqliMk89XeXZs8t2A/r7VPlsRv+VluEvOV7mco5YJ+WqkqUN38ahjA0iexlTgwgxYNCrJUA7SFZWthxQOtexJXNgjYBJds1vB40Udat92XL1O8aeuROTvJoHmObkL6JYlOA22uq3dF+tz/xZywv+JgxSfXtv6wwVky61jIaCkTCcPtBuMwB9nj0/pl2CcrKekWDYb8nngs/+9GSGATe8zv26XnIGjkrcmpN/ooHFimQzQl4rou/9WdeIPbe9TVZAf4m4IMPCdYjGhb9bnOkONi2vPXcoAlB+I/REuOIItvBZ9+IgTgnyhZp3H17wl3ZrP6nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sHwUt1o0grqB2iFrdvyHAd9gD3sUMw226msh5VDt7kQ=;
 b=FRExhgoWB6EaM4q+e7cup3sLNfaMqw7FwB/J9uK+8tzvBiDrQPFEn1qneTP8sBbvKtU6Pgm2pdPp5KNMHiMWXRx5OS027RX9yPj5JDNSy7J3EPat18l/w6uybkDNC1xOUYCbxuhWde+xbPju2sL9CG6RB5dUa7Om3H1wPVkZGYQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6378.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:21:37 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:21:37 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/4] NTB: ntb_transport: Order RX descriptor reads after completion
Date: Fri,  4 Sep 2026 14:21:31 +0900
Message-ID: <20260904052134.2970111-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260904052134.2970111-1-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0026.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: b69059be-78eb-44e8-adbf-08df0a44647a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	FIqtjjYuJc3Vk3O2jTrwzNXPi5HmdGP+B0C4aYn59+qlG9uUeAwlHYqFwk0Jy8u2J7loDNtJOhasudexpNo9b3g6LDbDjykN09AzXcZM1wzS4ic8h5hktF30MAf+1MQRUxJM2aL40L5OSRsT6JUuUHerqz6+8iknwuqCFXhdgyDV/kLu7F8v2Fz/2Jtzu13ew4ghdpffOs4k0etKoblf9kP00b7hjyx9O3WF9hMSD7Jp3Tkl/LH6CB7MoLyyhVzblsvJvFZRRHkkqrFmT0UXoR9daB6/plR7DSm2RSmOGz2JsLiSpEY2wuN/BMisvFyoedKDgbjrUAO3zZwWwiJojr0aEzaKgO/iS3rzjcbxnUy2Hs3AzUM8TAc+I+PxiEYCzUDWAKGTWuBX045hmNSzsLIM2e6gYx/q6FlbRQs6ekZyQvZyf4ZaJegMquZbXoGqGR37bMTgk+nMkLaQNZmyuLIa3h7r+NByCeUGDme+PmC7YKPu48oDivEXZg6uJwnG2TWSZ8tZwlPWV8kHkl5p4p9N8tRYTEFaiklklUu4cLZsW5n1Z5qGqPsOs3v6tflWYZkyViLGkHIyLmc9Z81fJcEl5c6SMiOLLlD1eSl8Xtb8Kd5sbEBdZiaOfPUZir0H
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Sep307ruW2NP+Dth7ZxWDGXGuMxKik+bmRzabjDvU9RqK7xwuD7NHIxtD1bP?=
 =?us-ascii?Q?yY0iYFjLDVkqxm4bKbtydAmU+g6zcubi4AMc9EzOJDoeXN7k7CPPikFZLE1r?=
 =?us-ascii?Q?Nt0FMUv5Z8bq2NSyjyMArgOkcgoKkPiCXh+ehQcmwwzd0SCzj9lCx2regLrM?=
 =?us-ascii?Q?wEpyGvYTZPNpoClKZeVUbGUgxLo3+ECNf+MaTd5TPpycmw746ytNUrRkVUac?=
 =?us-ascii?Q?u1QsNx9OAnnXCy8IyYQMIsC268g19Mi2pS10uOkLfElSYT9ksmZBDGNYRYCw?=
 =?us-ascii?Q?ntrXf57KmqpdCbLOSPPZlsoEaHHa3a5NhPB75niMvs7ck9HedOJH9XDVMoh6?=
 =?us-ascii?Q?M1lKlQKlqAUQt1w+PcFJLIICzk1L/wCUaW5ETvtRJR8sVnTKP+zsapXTowUA?=
 =?us-ascii?Q?ZzJsZ9sAz7x3HTOlJj0lQnR7tQBwroE7b15UHwE0H+EXR9P6xQjebufMwZku?=
 =?us-ascii?Q?klIykMcFeq3nMDrqAhySKBQ5Yj6hg/rCt8zfqnnjj0truX3mPUw5wvPuYk3H?=
 =?us-ascii?Q?lpHxWneZ5hcPyXxgZwWcYEfXHI69P1J8As9CPkIPOMVFpxPQtv/y+gx7iN7T?=
 =?us-ascii?Q?CT/3DM9pzqg1FQLYoVEZCwz69nw+71XknuYolUXdARAndI5lFlrbhRvr91lA?=
 =?us-ascii?Q?tnNwAggBomHSm/K7S9iTb6J70I0HMjzk3ihZTTMufZdpzqCjQlBWTxoClVmr?=
 =?us-ascii?Q?px2vfG9rbKFjwM7uF7QuHw1CPgwO2KUTXkZYhcSZ0loyK4JnshjchN4OESm0?=
 =?us-ascii?Q?51VvJPG4/LklNiZlROUSiQoWHafoYNwBTdgjHos2nD3jE866DIEhlsAHpMb9?=
 =?us-ascii?Q?VQiW5DdD121uZMqfQVFIJNFjWBLZJhpZrwCTet45R3MHhXBuvC9cq/jj1DXI?=
 =?us-ascii?Q?hQMRUKV73TgeViMFOu70leA2bIPYT72/SG/MrJo+ymov8yCzcTwctDiCZx8q?=
 =?us-ascii?Q?jpJ24BChO6CbEuCok3vT2NruRheWk2t6CFQzVDKO+EOdj+F9L6uXNvaFWRm+?=
 =?us-ascii?Q?fKsW+cvB96dVqZtovIzKUEwgU1uj8EHUwHvM3wjE1cE6Cc42yatuQh+ueamh?=
 =?us-ascii?Q?7MHvipKVFE7W0LPOx76YfXJ0xmSqFm3xysg55ftEXmNvt0oLkV1ISx4CLPUv?=
 =?us-ascii?Q?pfC+to23+rwrrA1aUmslEdNlJaNNym7zHJZzZwfyJLKbgVGTe7t3hLfqmerB?=
 =?us-ascii?Q?Re9gwR/gdp3LY5m6Dg5t4EnJ3iImUgJe8IZTEtWhErCT5xSSiUTr/88Gj66Y?=
 =?us-ascii?Q?/E/2N08a7n5gqniP0iXxgz52J7/zY9wtj5GvVQfBmnkuqWpKMCjLlTrV6ifP?=
 =?us-ascii?Q?dI7S8IyRMAK+WC4pcOdrSjOZX97aUDQQlolCbIUT7e3IHw39HsNgKnq6gXsY?=
 =?us-ascii?Q?c94r5irefGOl1q0nUq+a2z795QHXJtq0Bj89GabMGPFzXBIkyFAtnGbsrkJy?=
 =?us-ascii?Q?ZGc9dCln5RHIJ0HHHjUTc7Z3UvbaSV9kQfXla4q1ku8xbvxnayYeYUBX6UFR?=
 =?us-ascii?Q?ZWJ/cuPjx/U6BIjRYxxiSMWsfcI6e1ZLmmsGBiwP3K+bw4YPg25+Loy0bv0k?=
 =?us-ascii?Q?g6sIdrHc49HQXAy3u58nM0JepZ1vsCHlJDPdbEg+3nGIm8Y5SbrelnjQtP+r?=
 =?us-ascii?Q?VwjXnMld5ztjYJ/YgqG4pzXxcehi0EY1yOe7Z11WhalOO0RVlA4ool4ti5/M?=
 =?us-ascii?Q?8Y5uBd8UXYAsIy4BeERf/c1HVj+OVxe0Y/PtvzYXvUKU2ktV84fSlzadWzsu?=
 =?us-ascii?Q?EGxpRYskJV/w0XYTg/tA1gDlMxCM+QVdrSPMsHa9/JiPLCmhWGVm?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b69059be-78eb-44e8-adbf-08df0a44647a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:21:37.0443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DfXUdyJ0WLoTPXr3dr4LTOVTD/CivjWZsdOGMQGF1hvKSdb4TGMB8LmEknlBjMwGN/ILwo2cLsAv5o1Uc2r/nQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6378

The peer writes payloads and descriptors into a DMA-coherent memory
window. ntb_process_rxc() checks DESC_DONE_FLAG before consuming the
descriptor and payload, but coherent memory alone does not order those
reads on weakly ordered CPUs.

Read the completion word once and issue dma_rmb() after DONE is observed.
Use the saved word for subsequent transport flag checks.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Dave's Reviewed-by tag.

 drivers/ntb/ntb_transport.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5..74f4f8c1c7be 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1609,21 +1609,25 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_payload_header *hdr;
 	struct ntb_queue_entry *entry;
+	unsigned int flags;
 	void *offset;
 
 	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
 	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
 
-	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
-		qp->qp_num, hdr->ver, hdr->len, hdr->flags);
-
-	if (!(hdr->flags & DESC_DONE_FLAG)) {
+	flags = READ_ONCE(hdr->flags);
+	if (!(flags & DESC_DONE_FLAG)) {
 		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
 		qp->rx_ring_empty++;
 		return -EAGAIN;
 	}
 
-	if (hdr->flags & LINK_DOWN_FLAG) {
+	dma_rmb();
+
+	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
+		qp->qp_num, hdr->ver, hdr->len, flags);
+
+	if (flags & LINK_DOWN_FLAG) {
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
 		hdr->flags = 0;
-- 
2.51.0

