Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4A1415F28
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 05:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499310; cv=fail; b=DoMDxSBZRtcR6PlpSru/4lRCMizXQMF3ApzEm+cFHYYCFCwl2BbgQ5RZcNFMP/mJYN3znqaEWI+QES019uOWpQmV8ForZz+lZl+MOk+/UzfhlQqNrHiLrAoAVk4izxrNpEIwc6IK2Yi+ctijtjt5aJemdADVm4A8JxVq/2+W8Gg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499310; c=relaxed/simple;
	bh=xv/EQtOAeTGC15KjitTvrdY6ZsKXvNdkMuVxAvDtd8A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=l7LyyjovZbY25CINPn6/OYpp48Xd2Vg2IkOr/gheP13jV0OmRczZiLw4OJU0TZyR5Kb48w1sBbJ2VTK0eyUbNf3b+B6e/mGrOyfnDyGetqNeR+9kgCD6+pGZYzXn31X/xrb3bAqL3jK4ujLutHk9QH2CPO0AkWJhOF9UIX8a5cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qI73+Wud; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qI73+Wud"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ivheb0hQ9xWruDKp7To13sKt/QVEWBAZCN6B2hEEdwuNz52gieUel8oolembhPGsfLu4Pk3NIlZIUORd8prRrx3+tWDy5OXKv5/CeJxfesQFGEj1Dj8ccfZpWRsY07gg/f0flLJ4OJs4e6T6b7bXJ6Yo25L7TuEMD+qQ0pbB2tMdUtxIMORtdzZjDN68Obr6Z3illnHQymRm7lDb7WmbDyJqNFYV5Ga9Dq1U+Hn/+dKvwqxcuUey7vn87H6Zp6cxewNfj6pA9ZjbzoRd56F85pWrG5viNj+db3vSxfI9OTu9bMhEmB5i8hFGbaJiM0aHh++oLx5pInrym/e0cIF2Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8F9a6OZYu5Saf2GomBaWcXaI5E1WvAvx79TyNXdpE80=;
 b=tidLsdP4eKGmR+GK4SPj6W/D1MrTMesHZXlrlMnYPOR0vwd/aUmziN4nwVUZg6paQoNpcUrsMEmCMnWXm3FQFCgXulk++ZLLyv7qjj2tIBm35oOahlOfgJVtHidejoLVMWDabWN14Q+Kfqxi75lfyRe1zB7ftbPLU/ZYXBX2x7CLF0w0xvc4Ed7P//W+iqO4MfQQFiMYb7nlwIz1TQpFrUu71ZeAAOo39dH+t4lrBz1+p4d6RD8ypn4O0QhBGa6TkoppeYZk2vP5Z5LxHQVhsbrcbPj1vSHZ6c2H72MVUjJKL7Plx9BHcSwOQ9btxUqx34ZI/n7cMuXgxcKLiXwAyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8F9a6OZYu5Saf2GomBaWcXaI5E1WvAvx79TyNXdpE80=;
 b=qI73+WudklRLFOEZituefOJH8z601ro+1HvxG2WAiMePvkZXwubUsZ74qfHjl5a6kVDkKqdj63BCGeXrGj5fbQM2B17rTvqFoL7oMxgr4+A3wEz2qUbYbh3e2NUHbgEL2Tb5pvNxTTmUFFVzDB2o6hmxlwI+dKtrxBgDH0GdA+c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6378.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:21:39 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:21:39 +0000
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
Subject: [PATCH net-next v3 4/4] net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
Date: Fri,  4 Sep 2026 14:21:34 +0900
Message-ID: <20260904052134.2970111-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260904052134.2970111-1-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0125.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: b6ff861d-25ef-46b3-1739-08df0a446608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	y3+i/i2H4FJY8L3BWUYjedALJaVLotzs+/FFxuhzIlD8dZXtx2nokd5fOTJAI59T/anNYtctRlJ0spKlzR+WWPc2KlJBAyxYx7XFEa50kdsWhY/tqvzM9Tud+Bbr3voPpVwgmR0Mdyd/73iYA1IDCWS7K8Rvkv2GeROgJXrBpzWqmGh5oPRAwnE5C0qXhRMxNxDiXCtQfxJonvgkobqwjdmzthZw1Fg8l33cdLTuz2jxGpRt8n2bS3zqfTHeSiS5oR389XdJQZRDg5lHrlEKgqirA5fJxbguBoPkbhsG1tgHq/X1iu5VqrvFgcXrvVzX/KRvyujMj41wJHooLbyHAETzMrT40zHyXaqnsVmPg/sY4TfdDYxaJIlHzWyrg0kjQf2UWACy30iZiiUvQITI4S5s4oxt1TOYg42aMCu2Q2rg1m4/3dZQy02MQsaTIA52kod+m5/LfAmG/N+8FnYznD5M9NTJ33gEs69+dXRUf5j/mACPVaHjQ87eXK0uQkVvxfQRzxikXLULaVgkygVRSNRHOslCxuQXEBrk8Bv9hiJw3Po275YK7ocwWi5bb7msfsUVrBwtK89C6x9+kr8PVDgP3HKzi66BjSGdvE9Ahvk1a3f5H7pk7yllT310U0ZB7ibXvp2Dak7gWesqBR4zSox5Rcz5tcj7G6yZLn/P6Fk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+6Q3kiM+bIhPHBOG5/mNcBei1EbXuZSBXzWKct4pv+VNO4i8UkQywEsTuKdu?=
 =?us-ascii?Q?pjwpdM6T/IkjSyZcXcAeolC161IAwYGtEqPsxqifLNkIx87G2Jybl1i7/vPO?=
 =?us-ascii?Q?ZhM8GhDkOrCbZo2uFQjW7/Qq6Au5beHjLRuIRe4HtuHv073NmI8RWHSG38Mc?=
 =?us-ascii?Q?5SFDI63/QLg+etkWIA02QFxGJHuCVefmtpRy+gGGcT+Oh5updJn+wp9JPcmQ?=
 =?us-ascii?Q?KxbpfyeCyEiipC+j7Nr54Z2Vd610m2dVWu5w5gsthyYJHzlGo9tzSH4cO7Zw?=
 =?us-ascii?Q?++gyuVcYZdZdN/WLMGqbwwMKO2UVp6wV+wC7HQUgUqphXDFDlkxmyTwR6KQg?=
 =?us-ascii?Q?pEB/UvzrtrqvO7r3u0v1E1cEfgZfBwJYc7eDgf5ZwLW+L3F4jCmZNX1cJQWU?=
 =?us-ascii?Q?wcXYlWUctNIyI26ZqxiSCiX8l5nzCp+DgX+ZHSDubLXe4DQGBC6tb9i3tNss?=
 =?us-ascii?Q?sKgnURWhWurcxfRtF694izr9OpBwD25z2XZm8HzYic3K6BLO0UFYloJTz/5Q?=
 =?us-ascii?Q?g4lls8GnmBnaPUmtO/I0WR2MNaJXTMArS+Oe6L6mw77ObGabhhCr14IE6c3w?=
 =?us-ascii?Q?IMR/hIF+UzsmC5GfvU3qpexNUol7a/LVE4Ep9qlo8GVM4LQnowVGUXWig6OO?=
 =?us-ascii?Q?mYR2BNW8G/fLkfsInVTogbhIfM+byn1ctWL4ZhRYSYQS7HR6Gp5/zMXE74sJ?=
 =?us-ascii?Q?dCy82k2lzIg9o0kU9kjrS5PeJbIAwaR+8i3p0qokHRBvWNso39ExMaL4S3Pr?=
 =?us-ascii?Q?xr6o1JdHCRiZF52Q04Lp3iRx6on5pq6W5AWouHdEfBuzLRp0H6NMfDbvP3zA?=
 =?us-ascii?Q?+vknZUhHvJg97Z94rigiOi+OVmMHusH5o9PNycnsYdq4aH45Ni2oV7NUSfqa?=
 =?us-ascii?Q?IA0fHtb8S4zeE7o/5B9fNVoM0DnHbLuV2lxbzhJ7WtiAbPoKbFCtS9ZRD6Bw?=
 =?us-ascii?Q?dHxiQORdkAzMoHBHD9JVD7zc5ZgCikhBBEr1INhpRt4EJr94Fub054hqCO/Y?=
 =?us-ascii?Q?bGj1MjhcqyDgz+neQtKPRDwIyYMjNtiqfpdgN3Qb+NXGVnZkrryvIR+93/m4?=
 =?us-ascii?Q?BavM0iwtqIhFEPC/ANyY3W2ABZtQE677jxNlUhqCKLyQh318g1IC3HR7zO7k?=
 =?us-ascii?Q?56HSX5rloyMdQ+EdZGeFQfX+WiXpMNhinxc5Usp8zg0Bg+HDcSfCRVmGUwRl?=
 =?us-ascii?Q?q+yMYmFrQfk8aAK1sfIRJoFVPn3jk/1iFiOMdzrrExMRdX+bnLHMR97j3VcV?=
 =?us-ascii?Q?Atg0PFZxUXS3JYXR9O196TKlWJI8RQbctWUlj1lXJe62l63+I872XIbap9tJ?=
 =?us-ascii?Q?PPPwhxJfpM+gFZUf+0Gp2Tg0MdI66VbFH7AFNQdE9yDCNeEvepQj7kxNTX2V?=
 =?us-ascii?Q?W3+DnuErnpfulHYInpJK2jH6IySHVLzFKOW+G5SdwyPGoc7mcnnfdGyzbi1U?=
 =?us-ascii?Q?ATIyXBVIv+f9np2Krx8puPmcgXphUIpIyH/0//NX84vat9mtK2gM0Lq9GPN4?=
 =?us-ascii?Q?b2Y60tuQbDQ6vychL6uEAuqxy+CqutIWelmljtK4nZaidHlNOL7e9dM7dwCV?=
 =?us-ascii?Q?zmRnx7ZZtZW73aC0pieB+r80iI+dBq2DzzrVuO9kTbjbZ+6xvUqDMTjPE6DA?=
 =?us-ascii?Q?Qka+41P+uVWsZSnkEkxM1UdjFjmWn9UFNQ1JIQyLngLVPbXsWxQfEWzSI7md?=
 =?us-ascii?Q?0hKQwoN+ZKRC2yoS5z2xbSCCzYHsFNNuQ9qSMantJuVxj9BW2FLbUvqpjhdB?=
 =?us-ascii?Q?PGk7hvE6K9QoOWIDjf6m/9UDyqvw59Y3HusqKyfufjIzarsVrp5a?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b6ff861d-25ef-46b3-1739-08df0a446608
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:21:39.6335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tIEs14e96wrSGahMMLypgu55/jMOwafhVjUv81Be65alke01t5DcL2nN4Q3M89t5pcAngXoITFzwwo8fRbqVYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6378

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
Changes in v3:
  - Count RX checksum failures as errors only (Jakub)
  - Reject csum_start below ETH_HLEN on RX and fall back to software on
    TX (Jakub, Sashiko)

 drivers/net/ntb_netdev.c | 93 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 82 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index d03cbda1637d..de8c4f320614 100644
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
@@ -122,15 +140,25 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 	ntb_netdev_update_carrier(dev);
 }
 
+static void ntb_netdev_rx_stats_add(struct net_device *ndev,
+				    unsigned int len)
+{
+	struct pcpu_sw_netstats *tstats = this_cpu_ptr(ndev->tstats);
+	unsigned long flags;
+
+	flags = u64_stats_update_begin_irqsave(&tstats->syncp);
+	u64_stats_inc(&tstats->rx_packets);
+	u64_stats_add(&tstats->rx_bytes, len);
+	u64_stats_update_end_irqrestore(&tstats->syncp, flags);
+}
+
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len, unsigned int meta)
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
-	struct pcpu_sw_netstats *tstats;
 	struct sk_buff *skb, *new_skb;
 	struct net_device *ndev;
-	unsigned long flags;
 	int rc;
 
 	ndev = dev->ndev;
@@ -146,21 +174,32 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
-	tstats = this_cpu_ptr(ndev->tstats);
-	flags = u64_stats_update_begin_irqsave(&tstats->syncp);
-	u64_stats_inc(&tstats->rx_packets);
-	u64_stats_add(&tstats->rx_bytes, len);
-	u64_stats_update_end_irqrestore(&tstats->syncp, flags);
-
 	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
 	if (!new_skb) {
+		ntb_netdev_rx_stats_add(ndev, len);
 		DEV_STATS_INC(ndev, rx_dropped);
 		goto enqueue_again;
 	}
 
 	skb_put(skb, len);
+	if (meta & NTB_NETDEV_META_CAP_CSUM)
+		WRITE_ONCE(dev->peer_csum, true);
+
+	if (meta & NTB_NETDEV_META_CSUM) {
+		u16 csum_start = (meta >> NTB_NETDEV_META_CSUM_START_SHIFT) & U16_MAX;
+		u16 csum_offset = meta & NTB_NETDEV_META_CSUM_OFFSET_MASK;
+
+		if (csum_start < ETH_HLEN ||
+		    !skb_partial_csum_set(skb, csum_start, csum_offset))
+			goto rx_drop;
+
+		if (!(ndev->features & NETIF_F_RXCSUM) &&
+		    skb_checksum_help(skb))
+			goto rx_drop;
+	}
+
+	ntb_netdev_rx_stats_add(ndev, len);
 	skb->protocol = eth_type_trans(skb, ndev);
-	skb->ip_summed = CHECKSUM_NONE;
 	skb_record_rx_queue(skb, q->qid);
 
 	netif_rx(skb);
@@ -174,6 +213,13 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		DEV_STATS_INC(ndev, rx_errors);
 		DEV_STATS_INC(ndev, rx_fifo_errors);
 	}
+	return;
+
+rx_drop:
+	DEV_STATS_INC(ndev, rx_errors);
+	dev_kfree_skb_any(skb);
+	skb = new_skb;
+	goto enqueue_again;
 }
 
 static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
@@ -268,6 +314,7 @@ static const struct ntb_queue_handlers ntb_netdev_handlers = {
 static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 					 struct net_device *ndev)
 {
+	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	u16 qid = skb_get_queue_mapping(skb);
 	struct ntb_netdev_queue *q;
@@ -278,7 +325,17 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
 		return NETDEV_TX_BUSY;
 
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
 	if (rc) {
 		if (rc == -EAGAIN || rc == -EBUSY) {
 			netif_stop_subqueue(ndev, q->qid);
@@ -301,6 +358,18 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static netdev_features_t ntb_netdev_features_check(struct sk_buff *skb,
+						   struct net_device *ndev,
+						   netdev_features_t features)
+{
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    (skb_checksum_start_offset(skb) < ETH_HLEN ||
+	     skb->csum_offset > NTB_NETDEV_META_CSUM_OFFSET_MASK))
+		features &= ~NETIF_F_CSUM_MASK;
+
+	return vlan_features_check(skb, features);
+}
+
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
 	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
@@ -451,6 +520,7 @@ static const struct net_device_ops ntb_netdev_ops = {
 	.ndo_open = ntb_netdev_open,
 	.ndo_stop = ntb_netdev_close,
 	.ndo_start_xmit = ntb_netdev_start_xmit,
+	.ndo_features_check = ntb_netdev_features_check,
 	.ndo_change_mtu = ntb_netdev_change_mtu,
 	.ndo_set_mac_address = eth_mac_addr,
 };
@@ -671,7 +741,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
-	ndev->hw_features = ndev->features;
+	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
+	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
 
 	eth_random_addr(ndev->perm_addr);
-- 
2.51.0

