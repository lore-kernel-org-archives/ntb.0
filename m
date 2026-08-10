Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021142.outbound.protection.outlook.com [40.107.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CDD4307B7
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380720; cv=fail; b=iPranXunHER14XNdAz8CnRoGqY7hxbUYaeu+j2gdWULMQFfHmzxcN33xWP/2kADL7JQX+2KCH5RqRwChAb5y6Y2qL80dTVNojLIUKXJM0v9z6cOgPfZythXYrdmeevgPcpYuhyQs/pvtF27tUDe6YIT3SHbAwPu+noQHPgpF9eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380720; c=relaxed/simple;
	bh=8KP5IfrBivGTEEtqMvHG6IQCxy9j8Vw5m3uWp0HbzoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=S8ZdSgtq5TxBx7q85Rdcgopsdx1DDl0sjNZE+VtXcsXMFGzUYfI3V4j4SYHTZJDoNTyXfKeTZIGWb3n0W36EFYY4Sa0tu+O05y1WhEI1rchA+A+on/EwpCrbduMzIqZHeSe5QC9nE89mKUo3xDapGr+JNY6rrdlcYFhcsw2/5ts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ngbUp/cA; arc=fail smtp.client-ip=40.107.74.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ngbUp/cA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IpIR3Xl3CRFMYcs2CgwfByNfvDM5ziFdydEg/GaibBrzgnB1ghv9gWKrHU3FYEnjnWxwpLAevMFUnasYNE69X2hI0Z7xdOO4w5kDuUdgk5xpJn7ASj8/J1LKvJ+xlK/vib7+Mc0puWJBTfc8hEhdNAOH6fDgEfBqerPKsBiEpjgMomKQbDm2YFyOxDLNn9H1+4hbkt19wQXGK+SvBoKrl5+m8FFKwINYLcMHItZRHeikDLs0bm8EVl9wwaub3ZZSrviexWjf5w+7piSJcCJTcIpMGo39v+ZMtj4i3JRSYbL/VYh3PZ44ji9B057WOhdE2kBo+W6PHF74RCUBGjRSkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY80pfjVMLEM7gNDioM3DgPKrGvkqwmU1NhF/Ocgfv8=;
 b=BUXDBFUvX1pe9I6Qz/vzXeOgqRs+hsQeqjwtGrDMypzTWmo2CZFcC883tjkYVnW/nvc+dvZeWwQaCV5bDHeFCbJsNttTdb9VNppDNzXq5PQYZr5y6VKFOgW5fI3nhN/MpTrP3N10ru0t5bn5m7WBjeiEaJ3gCBim7+ecRn2CkwNzFTIv+pQgwIU3RAVGN9glX875QiJndq91y0BAi6kM6RU1FR9mF1DUeSZ0GzULOVFU+oqCuUttvK/gBSp+fN+vxh14YW8+XZKYzDEDYJy19ziUMAcz4aPeFHq8bpXHmTTDSpwWOIESsmhTOqivDEvH0BA72MrMJACmSgWHq8Ng2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY80pfjVMLEM7gNDioM3DgPKrGvkqwmU1NhF/Ocgfv8=;
 b=ngbUp/cA6cShN2GxxCnbSd5ZRdVg1TzmdqZ8gJVujNZ4YeDwBWQD0HeILnkM1/lDDiodniGuwsfiVMGmR/1weNcyI7OHxtc1PXxBt2+k3494wUrCbY7ccVUyEUOTEcln0VBnZmpEfFDq6u5Fgfa3vAO289y6pCpdI7b3albp9Dg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:50 +0000
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
Subject: [PATCH 09/16] NTB: ntb_transport: Allocate direct-DMA queue state
Date: Tue, 11 Aug 2026 01:51:28 +0900
Message-ID: <20260810165136.2292436-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0369.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: c768dfdd-d03b-4df3-8980-08def6ffacc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	8jIrtOsrFczzZITc7wzuEMTS+7fBdR24Xs+nHj3LogiElcQ+GvLhsiAWedGrKy+OGb4T6HGWfmr2ovgZNzVu5FY4VxGBct1BjirwHunGU1nkRSeMjFVUfOZWYjR1Rt8h6JgajSYI0zD7dKx3kYuR8biTP8nxLZCIiohlawjLQVgvlDRVWLWyz1a4GHtj51XKYm0hpfnTxvg0YzmlkQe8NC3981UJH7hA08peVc/HZD7MdKBqDzUQKbppd614GLhgnLAGHNW9Z019o1mWHt1pUkMZQp2fJumGdzNUSzmkyhJDDTqwNqgLlecOzrjP1Jk+ebz2AB9bE9CNRffOjgMy5YumtHBPtlkps9XkmLinZsKcMJAH9+gUGFyqSNAFBeirVxNrvSCP6vj0qkCViBFyto6BCVFAXpHyJC010dgQLy3iyLUewoNy8h0/oHQfjOOpEqCXJqozx4QQgy7f70mN0L51XYvrxTNKdM43IbfRvx2tL0cg9XTJA5HGqg3zXij2By3XS3ZhB69Xe0fOXRp4g/OL605qBbmEZB4wmynvvsl8WOddN2EmWHd9y4qDDKlf2eputE4kkxJpqgPTqY+Z3D9TOmVGFui8//gJ3Yj2nNQtHURNp3IRaHvhJAkzk2L63ZlgzFM8MtC16xQKpGnpgXbX6Pl0VFXfE000Rzg5yOg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?smG0l+OmvQy6aZ/7sAe3yRHPrJtVdUcowlrppNqN9hdQnEFkTCVZZnI4j9xs?=
 =?us-ascii?Q?FmLZ3fkD93z4XX/GjQ+oN1Pqt/9Tt8EA9JhaclnBu1Hf/tvCwY6F3uCMOI5A?=
 =?us-ascii?Q?/rnziRFqnS0L6k8OdKZOidjrjzcvQfCatWx7gaX4INzh2utlLWssrcLd+BXn?=
 =?us-ascii?Q?mEOp98N7Vvs1YsKdIU5PEYKMjlYxlnMQSoK7t7I3V9AUA913TkdIaJKEr86X?=
 =?us-ascii?Q?if+EvYbTbPZpw+//hM5WG1ItKjuV7NeB04FAe2S5towO17T3NCJ0qGXUvoXY?=
 =?us-ascii?Q?k7mdv/3e1myL+Aw4OzQMDrmL41KAaT0p1iS81TIGdkkutMQ3MFP+sZLx9JCP?=
 =?us-ascii?Q?51XQEZySNgPWYGA2a/IZ6b7HcmdhGNWJUFmiRaLUJ513WlrQNDmD5t/qFraS?=
 =?us-ascii?Q?Gev0hsy2ny8nmsVwj6msm8HkGEryfbd3bhYSOfHOMwy3Ng8MEAFScgKqPBPB?=
 =?us-ascii?Q?V8oVZzmr1ubRcOvBMLz4sUBP65YsWuYYY1PqBU8r1DF0OsWPmJsdYhcm0/vb?=
 =?us-ascii?Q?lLJxvraU3S6DD2+01q28uORv2BdeJ0D+3Yi19HjjiJp/mxHaksgCzCtncAeI?=
 =?us-ascii?Q?eVS9+mxifMKTjZf+AVDYGtyNyxObOKnrFgpgVlwkE7lpGKivtpHW+q/b9N20?=
 =?us-ascii?Q?PQkskh4TycIzTZFEmA8CYzFQu9o8uw7nAlkilfV8gQK3JcjC/3xTYs0O+hjv?=
 =?us-ascii?Q?X6CAL31sFajqfPb+QkoTPvuCN7ecorVZCtO9Pq79k2/Ic2hWDNQ0wPIpoSEJ?=
 =?us-ascii?Q?eEDsCf05XttYopVcJF/KNRxorXu529XboZg5xsJtDSH2luhXOtrzOGvqhi5s?=
 =?us-ascii?Q?dBL6QyxkuqH7G5wa3gAbLUNX8obdCfF85znSZ6X4u+CoCbjicqgwV2/x7qLe?=
 =?us-ascii?Q?31JLkTnBMhRWUTGyl3lh3Veug3RZdd9ludVWhRm8QQFdTLAq9QAll3HvwGCS?=
 =?us-ascii?Q?fuv+cwliLwJx6VNyE8gVDBYIm3doxHlKgbsabxUDAw6hI0zWtpHET80IsWBX?=
 =?us-ascii?Q?zKgkC8qTUOVX8lysREH55ot3dwgAFqTBT1ZWyhbtqkR/sF4f49d4Zj7hemV4?=
 =?us-ascii?Q?qfEY0s+8U+x+Y4PcxtkYw7ICU1QDjGIlmKyy8Vqp1197QeTlLzPu3joSHjvM?=
 =?us-ascii?Q?FYTzf2ngn/UtD18iOp7IdriA8FJ7+oqHtC5IO7jq80JBkxAWAIZs8+ghjR9f?=
 =?us-ascii?Q?1jRafcG/a1s3DeXATGBT20pN+OGfkI6SD4fAeyMZNMfoEigkDAmteQ57A9KN?=
 =?us-ascii?Q?a3Tq4io1sE1DY41hJEmYuztdXKgRysOwZikv7fHfV+tV6R1VxEzCzera8r2H?=
 =?us-ascii?Q?QqKptgFCkxhb+6sGX/mK2cedwOnStCpN5UhsPOJaPVgiOO0Gd9ewFnQ9Py9E?=
 =?us-ascii?Q?at5Vm2VOX6b6VDqP5+pOlKif540Gx/MHRtTt2BrhQyNQtv0XkIeZegXeZxmw?=
 =?us-ascii?Q?ciy4DU1ETTrH8AoUsrxAfnqE/jHS4GdpZA6+15gnU51o+yFs2qzvBgZW7H67?=
 =?us-ascii?Q?MCwPld59p2HCTBnVVRbAqJ2R3g+s4GhT2aPqeaeV9ez5Cw4o4VZACb1KTEG6?=
 =?us-ascii?Q?9kkyz1jvcSk3NKBSIx1RUeqF7hreiArZmyDmUnd0fIce0WFCh1toPeoRjeCp?=
 =?us-ascii?Q?ybNCmZ32Iqj4JRJK3uMl59ONNupK30WMsa0a4g3YSGV8HOvyY9uCK1Mo0l53?=
 =?us-ascii?Q?lumVPh7bVzw8nx8ojcXuf+ZPgEFq5cDwTswt/3mwAocNiCEOb4gnhsqbq/Jd?=
 =?us-ascii?Q?WxiIXy8Synv2Y42A6Pq/mQ86QayYi4qRa3aXN5vsC0VDRLfybgWN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c768dfdd-d03b-4df3-8980-08def6ffacc4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:50.9276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pHpxvSRiDWwOw2h+5R7vGrB9WKKpAW62GeTeAKvScQ77zMCiIfWRLSP264SmZOUNLVMdYIXZy091PTvyGZmiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

A direct-DMA ring can be deeper than the existing queue pools, and each
slot needs DMA-visible completion storage.

Allocate the completion arrays with the QP and size its software entries
for the larger ring. Expose the RX queue depth so clients can post
enough buffers.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c      |  4 +-
 drivers/ntb/ntb_transport.c   | 78 +++++++++++++++++++++++++++++++++--
 include/linux/ntb_transport.h |  1 +
 3 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index c3a6ba96fc8a..62c5a5c1dfed 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -47,7 +47,6 @@ struct ntb_netdev {
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
-#define	NTB_RXQ_SIZE		100
 
 static void ntb_netdev_update_carrier(struct ntb_netdev *dev)
 {
@@ -82,10 +81,11 @@ static void ntb_netdev_queue_rx_drain(struct ntb_netdev_queue *queue)
 static int ntb_netdev_queue_rx_fill(struct net_device *ndev,
 				    struct ntb_netdev_queue *queue)
 {
+	unsigned int rxq_size = ntb_transport_rx_queue_size(queue->qp);
 	struct sk_buff *skb;
 	int rc, i;
 
-	for (i = 0; i < NTB_RXQ_SIZE; i++) {
+	for (i = 0; i < rxq_size; i++) {
 		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
 		if (!skb)
 			return -ENOMEM;
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 6051d8abfc0d..67044d0ea0ff 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -139,6 +139,8 @@ struct ntb_queue_entry {
 	int errors;
 	unsigned int tx_index;
 	unsigned int rx_index;
+	dma_addr_t direct_dma_addr;
+	dma_addr_t direct_cpl_addr;
 
 	struct ntb_transport_qp *qp;
 	union {
@@ -193,6 +195,8 @@ struct ntb_transport_qp {
 	struct ntb_direct_shared *direct_shared;
 	struct ntb_direct_shared __iomem *peer_direct_shared;
 	unsigned int direct_ring_entries;
+	u32 *direct_rx_cpl;
+	dma_addr_t direct_rx_cpl_dma;
 	u32 *direct_tx_cpl;
 	dma_addr_t direct_tx_cpl_dma;
 	u32 direct_rx_prod;
@@ -506,6 +510,23 @@ static bool ntb_direct_layout(struct ntb_transport_ctx *nt)
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 
+/**
+ * ntb_transport_rx_queue_size - Query the RX queue depth
+ * @qp: NTB transport layer queue to be queried
+ *
+ * Return: Number of RX buffers the client should allocate
+ */
+unsigned int ntb_transport_rx_queue_size(struct ntb_transport_qp *qp)
+{
+	if (!qp)
+		return 0;
+
+	return qp->transport->direct_dma_dev ?
+		max(NTB_QP_DEF_NUM_ENTRIES, qp->direct_ring_entries - 1) :
+		NTB_QP_DEF_NUM_ENTRIES;
+}
+EXPORT_SYMBOL_GPL(ntb_transport_rx_queue_size);
+
 static void ntb_transport_rxc_db(struct work_struct *work);
 static const struct ntb_ctx_ops ntb_transport_ops;
 static struct ntb_client ntb_transport_client;
@@ -1179,6 +1200,10 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 	qp->tx_err_no_buf = 0;
 	qp->tx_memcpy = 0;
 	qp->tx_async = 0;
+	qp->direct_rx_prod = 0;
+	qp->direct_rx_cons = 0;
+	qp->direct_tx_issue = 0;
+	qp->direct_tx_cons = 0;
 }
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
@@ -2343,6 +2368,23 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
 	return dev_to_node(&chan->dev->device) == (int)(unsigned long)node;
 }
 
+static void ntb_direct_free_queue(struct ntb_transport_qp *qp)
+{
+	size_t cpl_size = array_size(qp->direct_ring_entries, sizeof(u32));
+
+	if (qp->direct_tx_cpl) {
+		dma_free_coherent(dmaengine_get_dma_device(qp->direct_dma_chan),
+				  cpl_size,
+				  qp->direct_tx_cpl, qp->direct_tx_cpl_dma);
+		qp->direct_tx_cpl = NULL;
+	}
+	if (qp->direct_rx_cpl) {
+		dma_free_coherent(qp->transport->direct_dma_dev, cpl_size,
+				  qp->direct_rx_cpl, qp->direct_rx_cpl_dma);
+		qp->direct_rx_cpl = NULL;
+	}
+}
+
 /**
  * ntb_transport_create_queue - Create a new NTB transport layer queue
  * @data: pointer for callback data
@@ -2368,7 +2410,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	struct ntb_transport_qp *qp;
 	u64 qp_bit;
 	unsigned int free_queue;
+	unsigned int tx_entries;
 	dma_cap_mask_t dma_mask;
+	size_t direct_cpl_size;
 	int node;
 	int i;
 
@@ -2415,6 +2459,28 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		qp->rx_dma_chan = NULL;
 	}
 
+	if (nt->direct_dma_dev) {
+		direct_cpl_size = array_size(qp->direct_ring_entries,
+					     sizeof(*qp->direct_rx_cpl));
+		qp->direct_rx_cpl =
+			dma_alloc_coherent(nt->direct_dma_dev, direct_cpl_size,
+					   &qp->direct_rx_cpl_dma, GFP_KERNEL);
+		if (!qp->direct_rx_cpl)
+			goto err1;
+	}
+
+	if (qp->direct_dma_chan) {
+		direct_cpl_size = array_size(qp->direct_ring_entries,
+					     sizeof(*qp->direct_tx_cpl));
+
+		qp->direct_tx_cpl =
+			dma_alloc_coherent(dmaengine_get_dma_device(qp->direct_dma_chan),
+					   direct_cpl_size,
+					   &qp->direct_tx_cpl_dma, GFP_KERNEL);
+		if (!qp->direct_tx_cpl)
+			goto err1;
+	}
+
 	qp->tx_mw_dma_addr = 0;
 	if (qp->tx_dma_chan) {
 		qp->tx_mw_dma_addr =
@@ -2434,7 +2500,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
 		qp->rx_dma_chan ? "DMA" : "CPU");
 
-	for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
+	for (i = 0; i < ntb_transport_rx_queue_size(qp); i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			goto err1;
@@ -2443,9 +2509,12 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
 			     &qp->rx_free_q);
 	}
-	qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
+	qp->rx_alloc_entry = i;
 
-	for (i = 0; i < qp->tx_max_entry; i++) {
+	tx_entries = qp->tx_max_entry;
+	if (qp->direct_dma_chan)
+		tx_entries = max(tx_entries, qp->direct_ring_entries - 1);
+	for (i = 0; i < tx_entries; i++) {
 		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			goto err2;
@@ -2480,6 +2549,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
 		kfree(entry);
 err1:
+	ntb_direct_free_queue(qp);
 	qp->rx_alloc_entry = 0;
 	while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
 		kfree(entry);
@@ -2591,6 +2661,8 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	while ((entry = ntb_list_rm(&qp->ntb_tx_offl_q_lock, &qp->tx_offl_q)))
 		kfree(entry);
 
+	ntb_direct_free_queue(qp);
+
 	qp->transport->qp_bitmap_free |= qp_bit;
 
 	dev_info(&pdev->dev, "NTB Transport QP %d freed\n", qp->qp_num);
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 7243eb98a722..41ba7c51cf75 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -71,6 +71,7 @@ struct ntb_queue_handlers {
 
 unsigned char ntb_transport_qp_num(struct ntb_transport_qp *qp);
 unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp);
+unsigned int ntb_transport_rx_queue_size(struct ntb_transport_qp *qp);
 struct ntb_transport_qp *
 ntb_transport_create_queue(void *data, struct device *client_dev,
 			   const struct ntb_queue_handlers *handlers);
-- 
2.51.0

