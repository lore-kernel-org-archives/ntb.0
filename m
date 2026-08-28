Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020138.outbound.protection.outlook.com [52.101.229.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F9346FBC
	for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 15:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931694; cv=fail; b=VS/lTN2xpHIZfBEfCeutxzqOEnNmILPNSk8WQtVJ9pxrryr6yulCYpjH7l9U5jWegpPgjc8hQf+8hdfa0oNvZEyjH8Z+rG3oRrXn2+ltP8MV6kdRHaeKRRwnAr0m5/ONwxBfT2KuW4dnSq67/RkgO12KsMx2TCa6hfO6/dF1TPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931694; c=relaxed/simple;
	bh=yA509vJlqP87kWVXy/b/L8lmP9SCPYAOf6e8cXddR/E=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fweTQu9fj7BvmggxreNAdUnZTCp6zF3zRGw9DYJPIzaoE54MtH01whJfBNNmwiw319AUgoULwLUblHI6FvxSe247J5RwST2c3p9zUGMpUA8CEHXAXWJeIffbaC6xxTuslX+wUUB0WCOtiifkvI0fYz3krmQ3JFg8zX4iPZIIy7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=F1Woc97t; arc=fail smtp.client-ip=52.101.229.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="F1Woc97t"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJTCzp0TBmXAm7nN5mKj6uFks+04ReMHNiG0tGSjSy3Av/r+HDFpUEBhxeSz5Mtb9qsXquQCTcb1NQUZU6PCEOQiqtdxbhQa5WshWC3pn3i9Ki7hw74vlkh0x2SiXbHRZYXoSEnrVUj20K7kgD8Y3rsVpuPlvRuyrXCtydpezwFuHRDo+JjtKL/s21kSIwIClzby39UJuYvelw1FVNticG8M8Xn5PcnPBzyhHGP46vabfdRpPwH93TJbW5DmpH9HrQiYed+SQwmS+LLO8NYe/kliRmvsT1UWD1NytL1o1lZfi+CJ764ir7CIw4eS4A5eb5UNL9uQJCM2kiwBBjmXMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yLX7lFVdD3B7J3F/uwgAKYo/ZPic63OP89vdWa6tsSY=;
 b=LR/v2yOFkAVEx9aLt8KuKCrxLXI/SWjvRh4izQmVuarQkIv08xGnaHNCUPnVFZ4fKrIfxF81908gYTS9un7MlvMHaIwNhr04K1KjU1JRXqVWJ6wYSrCv0rSh78oVUZ0XCk+ZXVED1+nBr4Tjj4HRCnIAdWQlo4jIHNtbAcrlrdeahSrDO8tmXyFF867+M4QE0gI759amCHaxO5bfXkgiXt78pW1sTolOeYOXU9UwyADAfdNcochiq5x4C1MHb8JLSZvPHhLp9FqsLFdpNgnhK4PLZr1zq7EbCW/NRlJEtgmf6/k+G4dbWxHwkYKEsLaOLUypH/0GguOc1WWe/ua6jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yLX7lFVdD3B7J3F/uwgAKYo/ZPic63OP89vdWa6tsSY=;
 b=F1Woc97tg9sXGWxCx1UVFYbFgEL84TgQ/yTzSfdp6HbhFSLUXUCLNznl5Fe+tV9w45gjTMt5LnFce5hQs+NdZRhi+EzTX9bGzVLquUKOjWcXaHMMwlWTv+Pst0sx+NPd0KS4neNeZvd+LMvbcjWjtftKGbRTBL/TUt5m2hQHEIk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OSOP286MB4240.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:303::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.11; Fri, 28 Aug
 2026 15:41:26 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 28 Aug 2026
 15:41:26 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ntb_netdev: Fix statistics races
Date: Sat, 29 Aug 2026 00:41:22 +0900
Message-ID: <20260828154122.2643578-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0208.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OSOP286MB4240:EE_
X-MS-Office365-Filtering-Correlation-Id: 5beca80e-7d2a-4697-44d0-08df051ad225
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|7416014|23010399003|5023799004|56012099006|10067099003|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info:
	qOZ7+fyC4+YNb56FPZCsoTlCDiS7I6KHFlWsu06XOdhIRc6HZ3ysf6x3Kurq+7qAJDgSjG5aksHZnqLc8MjjfVo397R5GzTf1j9kT/roMfpCjNC5J9kxEMwoxNl9vjX+sRbxryhUXp5/2G0E+0Ogyo+SxPwd4X84nN40nzWZKclOphWAYyquKWm4qbB456AFmg2ueba1WmvDfvi8vMxKBzu+sS8PVhNz7P55Un2ma+csVumovkquQOaMCVt7YOFozFY/bclYyupM4D/LUokRWAFbGXyXLiPvJM/N53O9o1lbHmKdFggHmIDDpYevt7Qk4sXLYXU+FNeJe74vx5xWlQHvcFh8YpEXAFLCQ9AIonFys/dV7R0nIqo+ZL0tgO762z4LKXazQXZ3kQJnqavcoyn0czYCCE+/O9ciPLDoVv/yLQBUMCR5c8d0WBl59aJtUVXGQ5mNL+VkNb986/H/FaoZtOfAORBp0oYBan0Rdak3AoPziqfzVQ2HolDfFXH15CuRslcE5QIFj0NPRgcBL4dGJHCC7IOxZk20Yi+r6yc8r5d6a+FXGTCnA03eRulRMpAzZlRkdgCWyKVyY12qvpIupRSvs5d9d/oqEpqGJDHUBIEPsN90L+HvNjrObHhU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(7416014)(23010399003)(5023799004)(56012099006)(10067099003)(6133799003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9bz56dsVGXzyPDTwhA8/Xjyxv2yei/P1QueDffDMDNOE6cN1wlY+hFD8VNAY?=
 =?us-ascii?Q?7qP/pBLucouLSLbQmZcLkOR3NRH1nzYagLl87tERaxueBPpqj437eI6awFEv?=
 =?us-ascii?Q?e9J6Cd6qUCZuIqqjTXtReWMuN6nXXn9AT+C3I/JNaFEq1pXDha+jEYIKd218?=
 =?us-ascii?Q?g2iEVd+Mi1fnjkau1NYGtwDz1gzrUdcNS3V6GuDSIhNbRwc3kH1kJGyOxohr?=
 =?us-ascii?Q?PvHznyLUJuxRcotm/nBFEObmWTJ2PIYAvewXWuMB9RzfH9dD9Jvg2OCsIWi4?=
 =?us-ascii?Q?K6I7mjlUkXXYITeslLJExQFgXzxpyp1FSiyiL/V9XFiOGDf+v0jAISBoxE1f?=
 =?us-ascii?Q?A6LJ+E784PYgztUyw0VXkcV2BLHTcOvqIFIMfE04WpC4qB52W1ddd3XHtWoQ?=
 =?us-ascii?Q?zNwkCKexle4a+CyOroePOJd1F9TsDQzB6yTCgPO9bgr4wPEIsVPNAxK9WlC6?=
 =?us-ascii?Q?/qCzxVESVyxFuv5+SvlUqDptRrKu+p1n4RazydGNHQ/Yf0RvHgSRu0GNsJEa?=
 =?us-ascii?Q?jJ1ggzcM+UvOoWKMmja0CTN4oHYizkMz3xCZ/hZU3Vengkq17FsMNpdMy7DP?=
 =?us-ascii?Q?vP7sxk3PQAQeOT3RyIlBoyEA06tDKYv820bx/l7bRF0KE8RMcrS/kaQstJY1?=
 =?us-ascii?Q?VMQaS1k4AhkdxT06Z0TCPrbinLAUK6SBI55cd3gtf44TM4+GQGOdOjvwNl4R?=
 =?us-ascii?Q?KP5U9m+YpVUtppKds68IGpO16gSuFZDTkbDnWUECkhn1LTSQ8Zg4pJ9jRTpe?=
 =?us-ascii?Q?9KrDGvAABjZuY3qDBlodciMkQ6yJoYMTvuq2b9F8tZeHqYZ0YxhkNab2AXGf?=
 =?us-ascii?Q?VqZKKRNzj3jnpCLWAuX5xQkwZJkQNj7MDV+bAH/hoyHEc2vkqKjI6LQWEMPD?=
 =?us-ascii?Q?LB1o809kAnonh/iITdBoZ/h36ljzAbgIFQMZc2HJAWipH7x4Veg6OE/Su33N?=
 =?us-ascii?Q?ohXVP8J8n1cjxVNQmVFwymgA0LgKIjMdNXH5SUu2a/UykzquBgftrz6usDZ1?=
 =?us-ascii?Q?wAgpnvru9eHFqgcD02TeqVW1KBcL+Dn8IO+6zY14RtXEX9xZ+QZXNbLI485i?=
 =?us-ascii?Q?cvAoboTCiF5TaSOP/CLKQTyNT9VNKBnlOEoreePsmDND/z57ARiW1m4malGu?=
 =?us-ascii?Q?3pJ1NmTIOOOrR+QJOpCvSq955XcOBJHh4ilDHtiovoAy2jO+WEM8tIQYn3w5?=
 =?us-ascii?Q?qYSQpmXX1g53Qbghvtbd0+LHqQJgORwBVOp9QZXdzg7BjGxdYRItoPa52yw2?=
 =?us-ascii?Q?l9rkP8Gi8e9Bl+1y15X4GjEHdHPeRzGbQBCPkpmkXIFtFJ9xBUat3cvlE2PD?=
 =?us-ascii?Q?o57hdvNf4tCDQIIs3+s0p+w1Z3O5an0kF3JlUbHML2dX525/4RpgOqECEknK?=
 =?us-ascii?Q?KKVpfzzD1nzo8hsQp4jDzTHPQDfLyg+Bgcq6Q6u1G+Xq73xw37QY8XmoGXIb?=
 =?us-ascii?Q?wxrc5n2M1vVucPIlhKuBYx5OsiyjwXx84tpixD/C4dBY0VMahsK1h9rReeGz?=
 =?us-ascii?Q?iTkRVehX1xUtLNWuh1Y29yLEq7faUaqOMynlQf33ZcO7+XxGy3SXMYAKghEQ?=
 =?us-ascii?Q?9V45y57NTsGtb/bdvABCOadrczpWD+OFB69OQP6NTH1JRKvPPVMR+y05NJHh?=
 =?us-ascii?Q?v/HG7j2TBEJk/T7KWXmVt8qk08tTgZNc0iKZZSKF9/G8x/Uok8bLGRHZpUQ2?=
 =?us-ascii?Q?4QreAC3/wE69jZVgHvlvBrtwHA5I0O6WuRIcQblOfPiQnDbHuj8okXi23iiz?=
 =?us-ascii?Q?gjPvSXcBsiIKb0gb68iT7maCQ2YuFVHWahiLr9NUbEkQ1TedpKGs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 5beca80e-7d2a-4697-44d0-08df051ad225
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2026 15:41:26.3399
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uPDUH1VWNZ/WM3D54y4kemXg7llHvD6QnTfVnI628LkA/u4hTAMHfoq1EU2vf8DdhC+Rwlf8u2fBZSI5qeiPkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSOP286MB4240

ntb_netdev updates shared net_device stats from per-QP RX and TX
callbacks. Once multiple queues are enabled, concurrent updates can be
lost.

Use per-CPU tstats for packet and byte counters and DEV_STATS_INC() for
less frequent drop and error counters. Callbacks can run synchronously
in the xmit path or asynchronously from a tasklet or the memcpy kthread.
Pin TX updates against migration in the kthread path. Use the IRQ-safe
u64_stats helpers because netpoll can invoke the synchronous path with
IRQs disabled.

Note that transport callbacks may still complete after
unregister_netdev(), so tie the tstats lifetime to the client device.

Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi-queue")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - Make packet and byte updates IRQ-safe in netpoll context (Simon, Sashiko)
  - Use device-managed tstats and restore the original teardown order

This is the follow-up mentioned here:
https://lore.kernel.org/r/20260819172539.1450821-1-den@valinux.co.jp/
The related TX and RX fixes have now landed in net.
---
 drivers/net/ntb_netdev.c | 44 +++++++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 9c171697e762..ccbafad8f650 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -125,10 +125,12 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
+	struct pcpu_sw_netstats *tstats;
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
 	struct sk_buff *skb, *new_skb;
 	struct net_device *ndev;
+	unsigned long flags;
 	int rc;
 
 	ndev = dev->ndev;
@@ -139,17 +141,20 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	netdev_dbg(ndev, "%s: %d byte payload received\n", __func__, len);
 
 	if (len < 0) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_length_errors++;
+		DEV_STATS_INC(ndev, rx_errors);
+		DEV_STATS_INC(ndev, rx_length_errors);
 		goto enqueue_again;
 	}
 
-	ndev->stats.rx_packets++;
-	ndev->stats.rx_bytes += len;
+	tstats = this_cpu_ptr(ndev->tstats);
+	flags = u64_stats_update_begin_irqsave(&tstats->syncp);
+	u64_stats_inc(&tstats->rx_packets);
+	u64_stats_add(&tstats->rx_bytes, len);
+	u64_stats_update_end_irqrestore(&tstats->syncp, flags);
 
 	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
 	if (!new_skb) {
-		ndev->stats.rx_dropped++;
+		DEV_STATS_INC(ndev, rx_dropped);
 		goto enqueue_again;
 	}
 
@@ -166,8 +171,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_fifo_errors++;
+		DEV_STATS_INC(ndev, rx_errors);
+		DEV_STATS_INC(ndev, rx_fifo_errors);
 	}
 }
 
@@ -208,10 +213,12 @@ static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
 static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len)
 {
+	struct pcpu_sw_netstats *tstats;
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
 	struct net_device *ndev;
 	struct sk_buff *skb;
+	unsigned long flags;
 
 	ndev = dev->ndev;
 	skb = data;
@@ -219,11 +226,16 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		return;
 
 	if (len > 0) {
-		ndev->stats.tx_packets++;
-		ndev->stats.tx_bytes += skb->len;
+		/* The memcpy kthread can migrate, so pin the per-CPU update. */
+		tstats = get_cpu_ptr(ndev->tstats);
+		flags = u64_stats_update_begin_irqsave(&tstats->syncp);
+		u64_stats_inc(&tstats->tx_packets);
+		u64_stats_add(&tstats->tx_bytes, skb->len);
+		u64_stats_update_end_irqrestore(&tstats->syncp, flags);
+		put_cpu_ptr(ndev->tstats);
 	} else {
-		ndev->stats.tx_errors++;
-		ndev->stats.tx_aborted_errors++;
+		DEV_STATS_INC(ndev, tx_errors);
+		DEV_STATS_INC(ndev, tx_aborted_errors);
 	}
 
 	dev_kfree_skb_any(skb);
@@ -277,7 +289,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 drop:
 	dev_kfree_skb_any(skb);
-	ndev->stats.tx_dropped++;
+	DEV_STATS_INC(ndev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -433,6 +445,7 @@ static const struct net_device_ops ntb_netdev_ops = {
 	.ndo_start_xmit = ntb_netdev_start_xmit,
 	.ndo_change_mtu = ntb_netdev_change_mtu,
 	.ndo_set_mac_address = eth_mac_addr,
+	.ndo_get_stats64 = dev_get_tstats64,
 };
 
 static void ntb_get_drvinfo(struct net_device *ndev,
@@ -646,6 +659,13 @@ static int ntb_netdev_probe(struct device *client_dev)
 		goto err_free_netdev;
 	}
 
+	ndev->tstats = devm_netdev_alloc_pcpu_stats(client_dev,
+						    struct pcpu_sw_netstats);
+	if (!ndev->tstats) {
+		rc = -ENOMEM;
+		goto err_free_queues;
+	}
+
 	ndev->features = NETIF_F_HIGHDMA;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;

base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.51.0

