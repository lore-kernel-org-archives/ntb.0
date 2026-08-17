Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C8A53A8FE9
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 06:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949382; cv=fail; b=UM2aolem/D63FONO59++ypB0xjkNgibZ2XycN8GaaVvoPR9Wp+3vL6h6OGittMPnvyE8Q7kMFbZMBRXtX5GWrJ5j4mb0gkbOzLnzzH/ELz1G4g2Y5TvEcNEyfvdbBxUdw3Vq8sV9CtaB59iGvfHoaZDvebIMIPasntMfca4O1iQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949382; c=relaxed/simple;
	bh=ZPjElbBSiIdyqw7euQPM3925YeOD7VtGHB1rKMJqvJU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MM0yGhsKbIts2MQwUHaX5PEcJ9o4KR8XQQsgFuLGbayzE0wy4GVTNY6J/5PUmoeIVD8IscX1aiqAq1CNk7qJUmJjgNqvGhSc0kuFkC9I/Gofhyqw5JuNBBBSSXNnp8OzjzwhJgGfyRSDGE3EkgGqJR+zggYlf7Zq6YVwwQ/U+ok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=tNpIPJ9v; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="tNpIPJ9v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u+p2l6pWDzqpZbkKSsYjVGNsROb1H3lzQgT0HklO3adCFl7CYj1ryFw6mCivY4b3cTx55xhVOibS83kVu/3nhjONu6XOdUjjdmmZynyBC3YLt52Gh5qMrNjeUuy28dLgO1jSuBefOjTyv0ReacKaN7MiMio7avIgZu/leTH5VgkplZi1ljkbLSzTeZW7F/m0FoUFD1kBEaoFikJkX1JZRlrHCvDrdWpIKySrqwE9xLtGJ0KodEpmnKnoU0aJfTHYMzhCiuSzjUWQf/2rqwuZ0f0Yxgade8mWGBzmMQ2QGwMGI4dBiYeA6Q9Fc0g5Zglce+lyisIGC4uFHSMTj4AgvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/s3k9RWmfcNKUKnZ837QhTepXWhxe7W+fcbXGzgoWgg=;
 b=dsGNW6P9zFtFdnD+5IjLhjLbkHB8nxEPlA8wTqU9mu9mlMA1Pysw9RmEk+8SfiM4B/iplp8QwEOPahdeJ93qvMLIwNxNsbiJAaOxxUd1wHioGfdMTKXATtdiztYNYM8n27omLe7oESlD8klExEKTyoSux7ch89J3RbmyK+tYvW4N1h5u/M5BRZtlYpfd5Wws54iqxyA3KM6y4BDRw32ZB9SXnAwwNXwHbVQocM69JhJrIrW218kh0zSmp1+t+w9ROh/+WA80bl+pZKpRcCh9NdBHuuYKv2PBUcUHtcTsGGJVCl2YBsAVgvmX2vgw1oGHvgUWWEH5R54w6QrHqxL/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/s3k9RWmfcNKUKnZ837QhTepXWhxe7W+fcbXGzgoWgg=;
 b=tNpIPJ9v1Z5MRkd7NLpKaTFbjEALoGI6MZYdupOsEFnYHQX1B3IgS9p+6IiTSr2HRXyb+uzVXo9PsHH0/QjXSdPnJ8jskkGTRQgzFIJlqLqCkDlxgVPc56trF+3VttoaYzyh/OF470fE6LCaeG3EUudlmFWzQgZs8cLHg5lirPs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3805.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:49:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:49:26 +0000
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
Subject: [PATCH net-next v2 4/4] net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
Date: Mon, 17 Aug 2026 15:49:16 +0900
Message-ID: <20260817064916.13278-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817064916.13278-1-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: 89dc5cf8-63cb-461f-1fa0-08defc2bade2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|18002099003|22082099003|56012099006|3023799007|10067099003;
X-Microsoft-Antispam-Message-Info:
	017+6mykGbeiTEVZFXVnsIuS85nuQ5D2myeBva6p/2t8oZr4M4wUxjt+ktDq4O2MT240g4xmxMVIhVFGug3vXA63+b/v+gN+KSa+g0nqm3kn+/o0T4VWZfwAf0kzrKELYNZAGDwtOOj5/AEHvMG/2d3tWHqvaFizt34eUYpIdvNkNukq4jOE5k501Lbb15Eyek7xv+aboLASDkBebIzqRXKwHbTBx6O5Q12Fxd7pXfgD5c7wPKisF10DCxxflcTDIhQSjmFY7XAKXIn/4bT5jzvOp81bEGmLl5rkpKi/+V/xbdKIkOm5sMt+jzHBHf0nGbu/K1X+MgHWE2DPcpIVH+qxAsuG9+pdm7+5mg5WVpI/vPgRifY+V6NopGEfb26BtVYzpu47b4Q0CbPgSXyhuUaF2fJ/l95g3AMPeXkXm5LsQrMZ5YHb+POULRojo8qT4npCKlwu3agtT91a2ksV86RaCLbTIN+fHFt/kmOCRjlj8NQt7+PLriM7lI5Ua+n7RwcnEdhAP5nz+S1cHv815kKRRoIAr5z/YKDdQYU+p1ucyGhXSzsd2I91JPj/XGPszsjnHehZ91mRuzYS0PIbJM0kIpUhUBl+hymFcOEOBKxVQ2sDOp44JwsmQjimD5JhzGXvvnOWYlh7AXYqKcnnoA9Jaw+bk/12AeML//66QcU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(3023799007)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QiFGRrcoF9js15NTs2JOPWwf1ncQFLq7ILELTJbF71JCa/sqjMkmII1JUuBX?=
 =?us-ascii?Q?QodcFKehSq3vDBLrko8Oouj+jz8HEZmkyavXZRs1RYRUtXtbnNwKuSAfGzKI?=
 =?us-ascii?Q?MIXXw1aJlReeQGArxMJqMM0miiPnDklV/C4NpBC52CZWKaqsywaBLCLYoSB1?=
 =?us-ascii?Q?QGoY3gUgPRwqN48DlFT4wafvOB6SUcVMDmhdalB49sVkVdfOt9BR+troHILV?=
 =?us-ascii?Q?GFt3LWuoupfAV+h9gCpqPrWBbfo7qUem83zB/0dKnr1HKTz3BWKfXSE2XwkT?=
 =?us-ascii?Q?L4uW/4ARW90FdYybP1HM0eu1BQBmDusz1njoEbrq3KpMBMueZgiXkpOPPvCQ?=
 =?us-ascii?Q?8JRZSq4fHeYFn9D/4Hhn4l8CzxA+dnGcig0SSAkQNcBBpByLdxddw4IM9PZe?=
 =?us-ascii?Q?PbbTIErYVYhtCXiZvMpQksZUPt+/7t8uZWbUMHHGVxe3dZZsxF+HHviEu4ar?=
 =?us-ascii?Q?42U41+OMN0MG5R8k51b2xLO2jC/2FDnz7Y9yipicxf5wHJhowTK6an1eeR5M?=
 =?us-ascii?Q?FuE6izBNb45qncEA7+v72+XRJ7bnIdAljfshcr0++w7XKlXm16O8oa8kKqgD?=
 =?us-ascii?Q?CWZY0BUvRIhxkv3yNGv5Ql08SuaWxnOIW0FsnftgEQQo3uPZTGu+7m2e7ZM9?=
 =?us-ascii?Q?l+iYJGytGNPzYnyLwBDOCejkN7nMXMJbhJDy9FIt+gQeC2dDObxE+cAGstLO?=
 =?us-ascii?Q?JIllHwpWwUj5hayudeFz1zRywPrOjUEM5hIt0N/8kR+FNKyC7IiUuESEWCj2?=
 =?us-ascii?Q?ByksBJV3x/LDKzhXz8yWFu/vOMBGtewQnDY+mVL4kVy2j0vZroV5L7V+VYtD?=
 =?us-ascii?Q?hQgHBeCTKzQ4DXRCqtE+9Mv5FNZKusIQGbiRpJ6zn9fG1kDeLfcBQ7GnezTI?=
 =?us-ascii?Q?IP7PB6wNQsiJ5E+faHvJGjI1utGkMDhY+TXmyyO+2J1shDVgy6n02JOTyyq8?=
 =?us-ascii?Q?NvSXQgMM50RFF9rCd23e2VtYIuhJw8qI5k5g2YMXOgzNd5k3iDM5QdnorL/4?=
 =?us-ascii?Q?xMLYTezRZ/3FfIlGfbNcLunBclhjF+wpGbNNXdgbrYubmh0DPavnQ58GDDNX?=
 =?us-ascii?Q?unU3PeMbtJY/HGEid9Sii56xFBJD4TKx2SIl8C9IKBz6dClY27UTG+MB/nGa?=
 =?us-ascii?Q?fEidxX32q+A4k1ilv9LnRF0vKEbxD0SFItodI7lW2Knutn9ruRL1n2+WkR7X?=
 =?us-ascii?Q?ofYp+8eU/0BzBUg2ZpRZ06U52nwfdZAWKd2bQxBtp4+hC+DXaO95sTJuQpL8?=
 =?us-ascii?Q?8um9dpomVe9cWYX3tmYq3XripO7n2Zin2tDOnh8EF3Nlc+3nPtXqTUuD4huN?=
 =?us-ascii?Q?7txWEqWIohC1OsWduAm/VsDo86N4cCNUwOGEoIkJ893JHAsBIqCiLQuD0liG?=
 =?us-ascii?Q?2wAf7j8uXVRWFPyzY5M5bIkLwy8zVE7GIydEFVhGgTenPpoHfpUo8YLdfGRh?=
 =?us-ascii?Q?Zv8utQ9sj7UN0D5z95swpGq7+RMp1GItLJ7GM04cCsoS7nD8pXHf8wDqdEFK?=
 =?us-ascii?Q?kOWwN788KPoQY+n5jPOZc5PNAhLuNUaq2St/yAz8C6dygGlteFwBBcceacXt?=
 =?us-ascii?Q?KD3rhLduoQxBNqhBkThQBwcKPI4NRQICv5DFeb9kRxqVM7iHPp4EAWSxSORR?=
 =?us-ascii?Q?d3YCnPo6Jewvs2pQBOLrl2nzrbUYbHFvVsAim+qgP3Xsi00cNIcw+UlWnis7?=
 =?us-ascii?Q?nIdoXBKa87nhYXWE2wE6ADCn8imes8w0GNpXb6Yniig51aL7IjWxTBCnl6sU?=
 =?us-ascii?Q?ACpIDY1ps6vkDetuzAIhLoMdUdwprnLhY+NSv+eRkt7u7/BFbmXc?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89dc5cf8-63cb-461f-1fa0-08defc2bade2
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:49:26.5384
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBonk/Ejemt1dU1Dhb7NjVwei0HdiM7Wf4+wOHPnv/mio7LpPd8gbfC9qBdez16AN6sp//NY3JavPIvwpvBMqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3805

Calculating L4 checksums can limit ntb_netdev throughput especially on
embedded systems, where CPU resources are often limited. A trusted PCIe
fabric can avoid that work.

Carry CHECKSUM_PARTIAL with csum_start and csum_offset across the NTB link.
Advertise support in every frame and fall back to software until the peer
capability is seen. This preserves netdev checksum semantics and
interoperability with existing transport version 4 peers.

Leave the TX and RX checksum features disabled by default. Users can
just enable them explicitly for links they trust for lower CPU usage
and/or higher throughput.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Reset peer checksum capability on every link event (Sashiko)
  - Keep local variable declarations in reverse Christmas tree order

 drivers/net/ntb_netdev.c | 75 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 72 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 5c7fe6883cb9..9cfb463e472c 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -4,6 +4,7 @@
  */
 #include <linux/etherdevice.h>
 #include <linux/ethtool.h>
+#include <linux/if_vlan.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/ntb.h>
@@ -29,6 +30,21 @@ static unsigned int tx_stop = 5;
 #define NTB_NETDEV_MAX_QUEUES		64
 #define NTB_NETDEV_DEFAULT_QUEUES	1
 
+/*
+ * Checksum metadata layout:
+ *   bit 23     capability, advertised on every packet
+ *   bit 22     per-packet CHECKSUM_PARTIAL flag
+ *   bit 21..6  skb_checksum_start_offset() (16 bits)
+ *   bit 5..0   skb->csum_offset (6 bits)
+ *
+ * Until the capability is observed, complete partial checksums in software.
+ * Six offset bits cover TCP/UDP. Larger offsets use software checksumming.
+ */
+#define NTB_NETDEV_META_CAP_CSUM		BIT(23)
+#define NTB_NETDEV_META_CSUM			BIT(22)
+#define NTB_NETDEV_META_CSUM_START_SHIFT	6
+#define NTB_NETDEV_META_CSUM_OFFSET_MASK	GENMASK(5, 0)
+
 struct ntb_netdev;
 
 struct ntb_netdev_queue {
@@ -44,6 +60,7 @@ struct ntb_netdev {
 	struct net_device *ndev;
 	unsigned int num_queues;
 	struct ntb_netdev_queue *queues;
+	bool peer_csum;
 };
 
 #define	NTB_TX_TIMEOUT_MS	1000
@@ -108,6 +125,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 	struct net_device *ndev;
 
 	ndev = dev->ndev;
+	WRITE_ONCE(dev->peer_csum, false);
 
 	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
 		   ntb_transport_link_query(q->qp), q->qid);
@@ -151,8 +169,21 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	}
 
 	skb_put(skb, len);
+	if (meta & NTB_NETDEV_META_CAP_CSUM)
+		WRITE_ONCE(dev->peer_csum, true);
+
+	if (meta & NTB_NETDEV_META_CSUM) {
+		u16 csum_start = (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MAX;
+		u16 csum_offset = meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
+
+		if (!skb_partial_csum_set(skb, csum_start, csum_offset))
+			goto rx_drop;
+
+		if (!(ndev->features & NETIF_F_RXCSUM) &&
+		    skb_checksum_help(skb))
+			goto rx_drop;
+	}
 	skb->protocol = eth_type_trans(skb, ndev);
-	skb->ip_summed = CHECKSUM_NONE;
 	skb_record_rx_queue(skb, q->qid);
 
 	if (netif_rx(skb) == NET_RX_DROP) {
@@ -172,6 +203,14 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_errors++;
 		ndev->stats.rx_fifo_errors++;
 	}
+	return;
+
+rx_drop:
+	ndev->stats.rx_errors++;
+	ndev->stats.rx_dropped++;
+	dev_kfree_skb_any(skb);
+	skb = new_skb;
+	goto enqueue_again;
 }
 
 static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
@@ -249,6 +288,7 @@ static const struct ntb_queue_handlers ntb_netdev_handlers = {
 static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
+	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	u16 qid = skb_get_queue_mapping(skb);
 	struct ntb_netdev_queue *q;
@@ -258,7 +298,17 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
 
-	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (READ_ONCE(dev->peer_csum))
+			meta |= NTB_NETDEV_META_CSUM |
+				(skb_checksum_start_offset(skb) <<
+				 NTB_NETDEV_META_CSUM_START_SHIFT) |
+				skb->csum_offset;
+		else if (skb_checksum_help(skb))
+			goto drop;
+	}
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, meta);
 	if (rc)
 		goto err;
 
@@ -267,12 +317,29 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 	return NETDEV_TX_OK;
 
+drop:
+	dev_kfree_skb_any(skb);
+	ndev->stats.tx_dropped++;
+	ndev->stats.tx_errors++;
+	return NETDEV_TX_OK;
+
 err:
 	ndev->stats.tx_dropped++;
 	ndev->stats.tx_errors++;
 	return NETDEV_TX_BUSY;
 }
 
+static netdev_features_t ntb_netdev_features_check(struct sk_buff *skb,
+						   struct net_device *ndev,
+						   netdev_features_t features)
+{
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    skb->csum_offset > NTB_NETDEV_META_CSUM_OFFSET_MASK)
+		features &= ~NETIF_F_CSUM_MASK;
+
+	return vlan_features_check(skb, features);
+}
+
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
 	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
@@ -423,6 +490,7 @@ static const struct net_device_ops ntb_netdev_ops = {
 	.ndo_open = ntb_netdev_open,
 	.ndo_stop = ntb_netdev_close,
 	.ndo_start_xmit = ntb_netdev_start_xmit,
+	.ndo_features_check = ntb_netdev_features_check,
 	.ndo_change_mtu = ntb_netdev_change_mtu,
 	.ndo_set_mac_address = eth_mac_addr,
 };
@@ -642,7 +710,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
-	ndev->hw_features = ndev->features;
+	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
+	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
 
 	eth_random_addr(ndev->perm_addr);
-- 
2.51.0

