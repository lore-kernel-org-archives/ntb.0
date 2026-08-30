Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021081.outbound.protection.outlook.com [52.101.125.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A0F3B38B4
	for <ntb@lists.linux.dev>; Sun, 30 Aug 2026 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788102986; cv=fail; b=DOaSp2kfbnwJomfjLyiy4tOoQnqI8Av0I+9F6n0O2oR2ODyfJKT1T3CgoH1hn/CD4d5ttZr/oThANV+Jpb18IBC3ARNPSaArS7V+fcopWfxKP9HswOKLrAhryFSMZrMyoYqnPuwv+2wdSnXHY3VRlnp3N7dC735IPgvbmpozatk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788102986; c=relaxed/simple;
	bh=CCskFYLKABGBo1quF/7CbJ8+PT+dq6O9f7UXrVS0mB8=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Op33USvqGDlTUNVU4fecS0Gbi4ivlH4/JxRjQaWHC/bVr4Zv9hOUTU5AYMGT6fO/Ubn11RU8yXGB6Ip8ynPYkOz62Ck5dFOLWluSeT1L4R7O/srE1w5OmI9j/2WxTfJhSAgFxTtiPeR0ZBcKVKoRA0c5no97jN9ZVLPxJuBdkSw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=wQHa+NuZ; arc=fail smtp.client-ip=52.101.125.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="wQHa+NuZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KcUr/0SVfsUdJUeuTZKC/r3A2MhAS17O6I1+httFQ813ISBLLGeRwv/PBXWxL0F3zMlSVTA/MNJcZphkazv57OSZOfFKagRjZixEiQAIpw9zFCm5XLw/edcj0s1AJjz5iUycvi13GaY0b+CfmWh7MDGxtt1UfsIns1fRo86BBd1+VVQrz0M8tmxghm7VB5C6h3cbvqCow+E9cViDgfd052JJZPyirKXOKC+ytt5Js4S8WEM+CJxf32+QkSCY0aZQl8by1pO7DrGlaNrvdmPk7+lRrx+dCeHevDF+0z1/xSK1vlybM121cOAfET0p2dvEzSiULyrxK92WjjKZ0pUNDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=irwZuEEqpW9dvFqtDtt1qSor/Wbeq+QTWgJd5C5Xk9U=;
 b=DyiMKqJG47ikfKAg74YeIlV1ZEi9/mrRsxoM1ilUpFKfJIpgC9ZqKKLOV8GGDv9wV3RS2DbpzpeGv8uB7J3PVY5Pp+Xx1P87+clTAI0bMx7THgGSIZ/5gTdrDXgkPS5C7zfloxHnoWEA+UjQwnYiuKsGrxXOF7Qsz3BfBcvMfJDQRFlxdLwBIqjc0Lj2d7bZFGRaACsPvPBi7FLlwJvKZGbU9RHikATnsC+eq61UuJ0h1kYaHcGy3hH21JY3MXePvtRW2Pt2a8ugEOTG8evA22JV+lgICo8f96MK5SoZZ2gZ6Hq+BY+oDya/zYztG34kwnwHuigRmqdlMW5nA5kMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=irwZuEEqpW9dvFqtDtt1qSor/Wbeq+QTWgJd5C5Xk9U=;
 b=wQHa+NuZF6RLbRkoopMcHOwcr9Df68hWzgNj+UYOQlNwPMucPZe5bRlopJhOuokhfMTC5RAls4kYehcyw7To7x2EJkxWOm8RWXgFGRhTm/YQICBn12Z88helEm0yiYkv1hh2x2HOw7xPVrZcqDeHEiZ8eWrbS/L1XnN3ajOvRJ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS3P286MB3211.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:214::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Sun, 30 Aug
 2026 15:16:19 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Sun, 30 Aug 2026
 15:16:19 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Simon Horman <horms@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3] net: ntb_netdev: Fix statistics races
Date: Mon, 31 Aug 2026 00:16:17 +0900
Message-ID: <20260830151617.3546585-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0048.jpnprd01.prod.outlook.com
 (2603:1096:405:372::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS3P286MB3211:EE_
X-MS-Office365-Filtering-Correlation-Id: 0eba807a-63cd-4cf4-ba90-08df06a9a4d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|7416014|1800799024|10070799003|366016|6133799003|10067099003|5023799004|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	RXgitMqt8n+mmCcNTePkAwzx/PQEH6xXZOvHm4oZCCVnO6Xg2vq4pmG9V0/C3dI/qvZ7KVg56SotlwxmhfFmMHwSLU7Tn4DofHlzKLL3Oijr6b5TVU5qcB5404Q/YD1GPqa/yM3NUKImicy1CP3ctSutj38IUlm9bYGR3vW8vmmADVyNtF6HJho7/t2zSWjcVHeYUFOOhRKGtwtHnYyUKy4H6+yAy5UUf4H40peV9xnCzlxo4Q1gQJT0fdbgA0bVwjsQoOayNasNNptV3WX4MW22M958WaWdJG46ciyS99JiHzDFWJsqKf1aVmWe2kiY3cKEdL6W78pWTTlNgcwp3wnbVdZnKwXiTqgwm1vIM5httXa5PegLFN9NLAlSrv4+ucXHhkMZ3SMOOLLuM+YHkZzP+VLrAhKUhWZMep6946tDRT37mqqpRwpEc1p9vCFAlEmFPR9soR5Zi0eZd8YfpXA2iXQUyep6oXWveccS2wNbED+OfUQA73W1AWInlfQ6r6g4TVWLuj1Ymksj2K2YUSb1ptf7uIpc6cpI3k9i4GxOgZuKbLBWRasgPHXgqyB5TlQWahQrsHAls0ZIIdABTyA839ee1ExrZ0zUldRKOR+BSydTIeU7tsQryayAYyvH
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(10070799003)(366016)(6133799003)(10067099003)(5023799004)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BGrpwrq5RepYnrqhBckuO5Tm/2dMj1m0XjqHbB/nFJ0e/+R0MSE0atEtkt/m?=
 =?us-ascii?Q?N8ipa+QR1A+q+eMtv7ppZj3ARGSAcMYJosVwK4ZjS3gkr6OdAgpVlgCLZUe4?=
 =?us-ascii?Q?rGa2PsaeHnu8PAMtSh/eZMAxM35w37QRVB7z9KV4NfYEdQpv8y0T9G+yWQxN?=
 =?us-ascii?Q?diTx5r0Z97HVRuzlK7c7GVSLffbZbts5BJEikWw9sHKwbJ74dTOKm+r76V/0?=
 =?us-ascii?Q?kxWHsKF1QKx9Hu5zKgsta3zQ3kL37egGdKUU5fQTHdaQKxY3bnaON4y2tPir?=
 =?us-ascii?Q?j5IXKLWJ4G9ndkM5QJWW2Qp+VfIsTJBmfcDdg+00cjmfIUXPxIzPbnuGBi6I?=
 =?us-ascii?Q?UPmEbMQb7Ruweck9W5+aZGV0HGTwlfeEZIAcPds2yTQXsGZwI5VCuXJbVjfP?=
 =?us-ascii?Q?UR3TzyirVmoN3qtjge/C7AbfXW47DsSHxh4NYiDo5S2pWfVc07temdA5rLK/?=
 =?us-ascii?Q?5BNoNmtzgNmq4Ocm/CIRMtZwsq2DnIYe1R1J762ZP8P6X4kPYidd/Q5ZeZkv?=
 =?us-ascii?Q?PIO+efwkp8zfnoh0P75aZrzYM45Osxmg1X5N45tOkQ4v4RT9VhCcy/k2BGhg?=
 =?us-ascii?Q?QCRZTaSQ4izUG+o9u0RitqoQNi3JZx7XD/lvhsmvYSHfaIcN7GnulMaeHMlP?=
 =?us-ascii?Q?tBdOES1XPJE1vqDYGU80xJfvZMeG/RQJHagFDq9EqKCCFzDindteKZUL8Yr5?=
 =?us-ascii?Q?qLHicuBGJ8pIZBN6GyxH9gdd4HJQN6NnwtoRlVVAkN7SsgljdcffOYczGsv/?=
 =?us-ascii?Q?a5U5CADQUZTEn0U+STI38iH+KTZBE5xhBZ/kLVr747Db5FeFfb2Nn7tINaXl?=
 =?us-ascii?Q?0LmOa7kU6l6/Sfbjcc46LpgjHdLFQ7mARbpapnQcfkf/2ee3q5/NqArujglP?=
 =?us-ascii?Q?8+FhXjy3whugzVmT7kklUzxZF83BQ3oLNXvWwyZ2u41tYS7GUX4vourmT1PX?=
 =?us-ascii?Q?zyWaPJHM10hguTjg2WdsoxQtNB5vSHxLnmnCvCZ5qVjCqhNkJGJ5YHjTO051?=
 =?us-ascii?Q?t7rpf9EJgcMWKSAxKFxYOSGoHOF4jfszmvTGfbE9P3aju+PUuCr9BU7IYZpP?=
 =?us-ascii?Q?CeE8RD9spcsYvDQc3quOgYUAEvFrbQqqePK+xAQtE5LcSy4sjKNPiF7WX7QR?=
 =?us-ascii?Q?phs/2wJugBkSlxsHqqxPT8cxt6r++846SEaCz7QPJiavg1xp45EIF2DS7NQh?=
 =?us-ascii?Q?hhCI+vOh6G14FYflcTVsWXE8ED4Kz47D2M0j5x81jbjrf2E097ujANF3jmMZ?=
 =?us-ascii?Q?WPYiugv4sp3usMWhH8ot0G3KrBwosFl40+PyIOAW+x9A68lmdJqPSvUIvqqA?=
 =?us-ascii?Q?jUA59PKHyEV3D2dOvy+SRWRRtsABPtBGY98pObkf47PxAW2+SP+pFnfivH7P?=
 =?us-ascii?Q?vhKsvmCmXfwIJKHAT98RZatbxqLvW2dY2lFdmJU+V7MOqJXT00bsss4x0sNv?=
 =?us-ascii?Q?pnFkyk/R40Bk1KuxzUOuV/OB1CU1KpmoYNr49/06gfq2X+6sWHCfPItmG57A?=
 =?us-ascii?Q?F/R8W3mvKknyDrXP0YVjmI03FdtyCgwV72w/3fvVtXG0CFEMWsWbX5WUrlIx?=
 =?us-ascii?Q?Uh3jmxThf04h7wNetIiCN3H2lifgqvaFpOlKU9la21toJUWKh4/RIhe21IXt?=
 =?us-ascii?Q?2MW8uiHBwQtYqdXbJQ86nvZV8JKhLjQw0O9VD4QnvmqM1nblKw0vHjBnlnN/?=
 =?us-ascii?Q?9cCz0Q3KVytkF7wgkl31MikAhexM1LT7Vmyl6l0gnGsfxGO3zndWWfOcfXi7?=
 =?us-ascii?Q?Ki60EnueTm+4kGqaGAXjvsiQJ36IjJ0B9N4LUEa0wMbxItaXPYB+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eba807a-63cd-4cf4-ba90-08df06a9a4d4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2026 15:16:19.5575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pSc5jwLFeP9nraNhanHPRwh01VzxkrukODUyF1NhJ79zxXlFaAwdwpqedn7HDTadPbc+XQBPz6O/Z1jpWyhBcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3P286MB3211

ntb_netdev updates shared net_device stats from per-QP RX and TX
callbacks. Once multiple queues are enabled, concurrent updates can be
lost.

Use per-CPU tstats for packet and byte counters and DEV_STATS_INC() for
less frequent drop and error counters. Callbacks can run synchronously
in the xmit path or asynchronously from a tasklet or the memcpy kthread.
Pin TX updates against migration in the kthread path. Use the IRQ-safe
u64_stats helpers because netpoll can invoke the synchronous path with
IRQs disabled.

Let the core manage tstats while keeping transport teardown after
unregister_netdev(), outside RTNL. RCU lets unregister wait for TX
completions already updating stats, while later completions only consume
the skb and skip accounting and queue wake.

Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi-queue")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Use core-managed tstats and gate TX callback work under RCU (Jakub)
  - Fix reverse xmas tree ordering overlooked in v2

Changes in v2:
  - Make packet and byte updates IRQ-safe in netpoll context (Simon, Sashiko)
  - Use device-managed tstats and restore the original teardown order

@Eric, thanks for reviewing v2. v3 moves tstats management back to the
core and adds RCU protection following Jakub's suggestion, so I did not
carry your R-b tag. Would appreciate another look when you have cycles.

v1: https://lore.kernel.org/r/20260824025720.3520288-1-den@valinux.co.jp/
v2: https://lore.kernel.org/r/20260828154122.2643578-1-den@valinux.co.jp/

Note: this is the follow-up mentioned here:
https://lore.kernel.org/r/20260819172539.1450821-1-den@valinux.co.jp/
The related TX and RX fixes already landed in net.
---
 drivers/net/ntb_netdev.c | 47 +++++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 9c171697e762..2c04be6d61a8 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -127,8 +127,10 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
+	struct pcpu_sw_netstats *tstats;
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
 
@@ -210,25 +215,39 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
+	struct pcpu_sw_netstats *tstats;
 	struct net_device *ndev;
 	struct sk_buff *skb;
+	unsigned long flags;
+	bool registered;
 
 	ndev = dev->ndev;
 	skb = data;
 	if (!skb || !ndev)
 		return;
 
+	rcu_read_lock();
+	registered = READ_ONCE(ndev->reg_state) == NETREG_REGISTERED;
+	if (!registered)
+		goto free_skb;
+
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
 
+free_skb:
 	dev_kfree_skb_any(skb);
 
-	if (ntb_transport_tx_free_entry(qp) >= tx_start) {
+	if (registered && ntb_transport_tx_free_entry(qp) >= tx_start) {
 		/* Make sure anybody stopping the queue after this sees the new
 		 * value of ntb_transport_tx_free_entry()
 		 */
@@ -237,6 +256,7 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		    ntb_transport_link_query(q->qp))
 			netif_wake_subqueue(ndev, q->qid);
 	}
+	rcu_read_unlock();
 }
 
 static const struct ntb_queue_handlers ntb_netdev_handlers = {
@@ -277,7 +297,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 drop:
 	dev_kfree_skb_any(skb);
-	ndev->stats.tx_dropped++;
+	DEV_STATS_INC(ndev, tx_dropped);
 	return NETDEV_TX_OK;
 }
 
@@ -647,6 +667,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	}
 
 	ndev->features = NETIF_F_HIGHDMA;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 

base-commit: 2188569e7e1b0bc3f3b557dc97ab7a02befc11c8
-- 
2.51.0

