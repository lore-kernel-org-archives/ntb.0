Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3003B3D75D3
	for <ntb@lists.linux.dev>; Fri, 14 Aug 2026 03:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786678175; cv=fail; b=GDlEra6widq97+Wed/KFh069wKW8mVbjGzf2WRMHOTm8pbQvdZ/eM740It3S+zyMa3LNzjZO6y+Szr+ioORCzkhXfZpX2PyT/FLusY5jKKd6tRh5Y97mpqjmlYidF9cukydIGeJiU3m3AX3Ubol07isQ54dK9YiJttZWRErI6jI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786678175; c=relaxed/simple;
	bh=khevk2wkb1Z3XJG2KtdNNPZfU9BDIQOoMCd/sLfgdHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DazoAEsdPVRaf8wjQiTb2yMRdKaKiunaWUH/GwcbV6UDy63cxQzg9ZYS6hcPoauiSECY/2/ZjigscKeLGulOyFasQKDPPixf67tjpcvZw0KmxGgubv+Cl6zNQyVNrcHQ9Iq3v9SVUVktH1t3H4ynEYhRWs+Ux2q+N4jlX1isD1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PWaPNtJY; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PWaPNtJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PZOOQJ06YKVKN22PWCXmJafAsgJBeL8zM2Jfv1ofK6PEI6vYW3AeFl4gXBGbuZB3op6cOqNa4y/5rclmoaqlMlsffIYuf9fg8x9Kt7kg/yEd13TbLvcPHXNS8HwYaYMhAYVaYFqujipIChT8Q1pHih+okyKP7hsgHmHhwFatrlaWzkRVgf6fMCZXt9EqMtO5RejNTRZcIrQh9k50uOROMrwhyhTsnhcAMX5TFQGmgoXAIfl4+zWkJJwSGfmhEFPkh0FoB+woNR+4ijvy1s4jfoxuQlI6enVvkz0C8YtMF7GxLZw+733C7IPffR2jK92zhSOKTFtdyIsy/EprlZ1jvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9qBls4CZDiGWeNf8ztI/8BeMeAYDPGfQ9rCsrwVzyco=;
 b=EePJQgt1kiKAbgBuNUD6ulFaLQord6fGhgxIawQG+s3yjMlk9jqidRuNDLNPGccE2PXwrFiKBA/dsCWoZ+Y4V0Hfkb0CsJC9TWLwcXoPDSYJ5qHSJzArCOIuY7+lEXhvGhTp8Fth5AdNqthP0bye8bB2uVXQ66ijGo7q5QdJzFzGEjrQgtnB5tI+e2JSSWd3YJqKqArNqNLh8doUdMuzFTvXjy1jKa5tM3eOI+Zu65ytTimWCmaTq+rvXC7qbyIxEfD0atLfsXf+L3m7VY1D0ygmQZPO4V0MUJSWOyKMZhL4vbSeaC66WW5Ru9svs1tZLbhNfdqzDwIbQQXlsz2FFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9qBls4CZDiGWeNf8ztI/8BeMeAYDPGfQ9rCsrwVzyco=;
 b=PWaPNtJYHZgfyBb6KgqFTvVS2va4NVpA38ActrqJ1ILLSmpJyjTNNa6Jty/SLQZDbLGNazVZxWmCObROJXXH7wIiwVj6M5bNVny99zEVGAiKtNTmi5gggV8YBZm9meii9SNz/Lti+BsaI1E2yAHNuRkUa0TncbTWU4TvNpA+DAE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7404.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 03:29:18 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 03:29:17 +0000
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
Subject: [PATCH net-next 2/2] net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
Date: Fri, 14 Aug 2026 12:29:13 +0900
Message-ID: <20260814032913.3558500-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260814032913.3558500-1-den@valinux.co.jp>
References: <20260814032913.3558500-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0121.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: 3664d3f1-8cc6-4b90-8446-08def9b438f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10070799003|7416014|3023799007|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T0YCEO3NtaFnqmSw+ANIKLFNyezJN+Ue3HULH93JccH6N32MQteD9/KpT7f9G5F23s4Ks1jgX3SX7Kb1+5epA0eWYuqcG9ebU5EUB0IxPqTx4HBjM54JvHQJG0aThCn/PzkTq5QBU1urzkkc4xxBe2NAm1QNZsH3ZuSrlslHuLGxsHIPWKDvVgI4s+lNMJQuvcpTkeDHYfJSg7XdpQRxE015LvUqYVj8ruhYn2qx6uowGbWRh9aWsHEuTX5rxIZlYPeu+Jbwnt7AdU6QN51IC4EPUmCzwRVeUtpxurvazuzzXWA8I9DDkRRGnD/ErR6aYXk3oIfv4nmC8lF3ZptYRItEMgABPUkMfg5cGMzwo7b9vdXJqXeL32nasi4t25hakoV/v6MCDlJB2PRY5HFrUCF5aHeTrUwmVedRDfTFVWPZUGIrns+Ks6hq3q4H5+wtYZD24aTz52qluDccLCO5ij9eZwdRWSoxk8ZLCBWdzuc/5zF/lRPaXejb2Kjr4iMeQDVb3WQGAh5abEQN3LYC8P5Rn/EKNaB1b3qrJ+DxRn3vzaFawjlTiasYUbMktUyyGbtOdhYNjmEFlzk6npeySMXt6EJJB7c4jrRnGV0iieQmG5rdHT7+yNZmVedsH3cC2dRee1e3qZMoxTUlbuq09d0p+C+HzuNyQxmM/lakkVk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(7416014)(3023799007)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?10X4vg6tBvjxE1kcijScfMfPaKJZOCUwat5SgAZaVU+bSrnCtZO2CdTfKOBx?=
 =?us-ascii?Q?u97njuFBQi/CsViFOCTKO3JmcgCXux2DDWE9FQDdBREMEszelX3tiQiLKedm?=
 =?us-ascii?Q?R8Zc0LuqNYZ2pLZ+6mQvyHmxpP+oMLB1CSH3wVhPZrcJ/NlZpi+g4psGJxUl?=
 =?us-ascii?Q?RLTSaY+iDvsVfwdPJI3NeyBNDplxcTvE5vz3/uiq75jl10rSDBaNvXh89aAW?=
 =?us-ascii?Q?8ntVicB87VK2CnOJI2S+9acntpPphJBE2AkpnAlgVjJ9kIs2xKc5stvPHus+?=
 =?us-ascii?Q?C9XtUW9ABwhbMld1bV6lZ3QV1P4Kx8r23k4gbOz8/+/ZJ4wLD+RyTKb5ur12?=
 =?us-ascii?Q?sIf2W1Qm9InQLIJUDglDu07eTxNzJBH8Fl+CMbUulzqUky6VsuIqIe+PLPqs?=
 =?us-ascii?Q?ucH9VlNXeokCoK5CgSlkKkwqJA6Pij7tkfSGkSUV9WKHSboyIiBHVNhx5XMh?=
 =?us-ascii?Q?s3YB/4Emjwy8g0YHUkRAD3J5i0xL75nxl8MaGNlNbWGbDClvEU9k1YD+Sm/P?=
 =?us-ascii?Q?NlacaRuYo9JukAA4Qey5FOlNxtU8/33imbKG5I79F0hQzURkXsAAwouo/lD5?=
 =?us-ascii?Q?ZeOEo8C+fxVgXoUUez8SUEgxt/51KRhBGbtni/d+QdF9ShA66F+LPj8a+L/B?=
 =?us-ascii?Q?ZKdkdTAoKIsQBefoY+JxagAc6Mgj2YbHhmEfJT491/TT0ywSXHWbol2sp/Cq?=
 =?us-ascii?Q?b7RY28w6e8i5AibMapC5jEvxRzjTCRrpEF8Zx89JazCQWFE4prM/vR6M6t1Z?=
 =?us-ascii?Q?9l0hLv1WY+lIUQTZGE/oQKWhpV8tioO5UtD7bzguIBvZ6mZKJHxCu4E2Cml0?=
 =?us-ascii?Q?dy6mfIUomuwFDd8hQbkSsTCSxWumfYdgbUtRUNy/7ukPuVBdrDctG1rQ25Jk?=
 =?us-ascii?Q?g5VqZBgm/oozh6l8Fna26ZnBWP+ukEv7p6bHVnu6kxKESTfEe5FJHg+/+0DZ?=
 =?us-ascii?Q?YDMy6IgwosG9vmZ1rt5ESTUMqEuOdXF8isd9sexd5hDZKdxgpnTx9of67PMi?=
 =?us-ascii?Q?m8PApDHj7izJmYQRZznSq8o9bOXMoz2jGUH2H/Gzx7LOiAcx5jVp3kvoaS6N?=
 =?us-ascii?Q?LXhvpzHCzydLu7XPHnohK5FYfeJ/h4e3TZq29d1Qsd1RIwH51oUtqdeBa4Rn?=
 =?us-ascii?Q?GGGTRIfoYKuosHQNz0UD4kT3d2vrxu/YXAM/ACF8jkaAc/ZMK4ThHd2JUbK9?=
 =?us-ascii?Q?wVHHGuGj3s/03cSMMM73nkuBTjFRRLhbp86QfNMTyBAw3ZnvR2315nfJpfLU?=
 =?us-ascii?Q?mEbU9A7GAWS3PABZ343SEp3gG+K2Z/oRA3JB9yHWn8CO5hiqPSe07WWhYP23?=
 =?us-ascii?Q?vxwS2aN+UZ3J5NxhJSn7/XvJuZBZipRVUQjX+6H5yeaep6AdK1DcguqmMhN+?=
 =?us-ascii?Q?kYB+0ivSRdmd8rxGjv9zNeKrPchSXLOqa2fOBkhbFNVft/4dHmPSayMWEcg+?=
 =?us-ascii?Q?k25UOUmN548peOifbCFWQsg7jWUnjZ6j+xZnsys//CxflflEjPrczX9ALu2R?=
 =?us-ascii?Q?dZRXReSR1frRiYAwFdhrlhr4R/GITS0a9UCL6OUsN6sS7dJIeEuap57WNiEk?=
 =?us-ascii?Q?0m1zMrssigkDIHnEp/PiVCtp71g4z1Xnk3JE0F3N3D9jsA8R2p/DtCXDMQP7?=
 =?us-ascii?Q?4d7rRjahCbxyM0dIFx7GpSpYgIqO1eNMsQMeFzBcsCtENu2mK3u9LjUqO371?=
 =?us-ascii?Q?mvUdW7vj8Ev4SebsT3tLvRJnzequZV2DVJkBeoq8sWru8QOmjWb/+ceRgYSp?=
 =?us-ascii?Q?4tVbHv1Avu+y5QOjT6J6qsh3yKdxVXL3dOTHzTmFDEO+kCPLkRi5?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3664d3f1-8cc6-4b90-8446-08def9b438f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:29:17.8619
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +Z3AhC/iAe+LWzXkLz3056U0ViOXCWUDufv+A42YM3iJonY0DNoP2SMmAN1uLXbuNsN9Vr9Rz0JOrqN1K4d2Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7404

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
 drivers/net/ntb_netdev.c | 76 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 5c7fe6883cb9..b9a78ff695c8 100644
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
@@ -108,6 +125,8 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 	struct net_device *ndev;
 
 	ndev = dev->ndev;
+	if (!link_is_up)
+		WRITE_ONCE(dev->peer_csum, false);
 
 	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
 		   ntb_transport_link_query(q->qp), q->qid);
@@ -151,8 +170,21 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
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
@@ -172,6 +204,14 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
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
@@ -252,13 +292,24 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	u16 qid = skb_get_queue_mapping(skb);
 	struct ntb_netdev_queue *q;
+	unsigned int meta = NTB_NETDEV_META_CAP_CSUM;
 	int rc;
 
 	q = &dev->queues[qid];
 
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
 
@@ -267,12 +318,29 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
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
@@ -423,6 +491,7 @@ static const struct net_device_ops ntb_netdev_ops = {
 	.ndo_open = ntb_netdev_open,
 	.ndo_stop = ntb_netdev_close,
 	.ndo_start_xmit = ntb_netdev_start_xmit,
+	.ndo_features_check = ntb_netdev_features_check,
 	.ndo_change_mtu = ntb_netdev_change_mtu,
 	.ndo_set_mac_address = eth_mac_addr,
 };
@@ -642,7 +711,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
-	ndev->hw_features = ndev->features;
+	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
+	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
 
 	eth_random_addr(ndev->perm_addr);
-- 
2.51.0

