Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021085.outbound.protection.outlook.com [52.101.125.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44C8D3546F2
	for <ntb@lists.linux.dev>; Mon, 24 Aug 2026 02:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787540253; cv=fail; b=IW+7EWWDnCmGLdyFvDpOjpTEySALEVuDjMFD3tdmVW5Ck/IXdaZ3iYZRSoG8F7M9XR4zilmMNgpYTI611t0OkburLEkv4oWmZBOsi/6OhA1o9SfqGPLz7P8gv1xQFac/DZnVSE45o6griJt77Jm7B4e0cS0ozh2HpFXKaylnHxo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787540253; c=relaxed/simple;
	bh=h3hZolDHy4AlOQWt9b1Oyb49OMLRho11DWXItelsOcY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=tKUwnnTPZGFksNJ8UFekcui0bs7Kzp3SHPWk5qaRUqn2pCorBDHIVn3Z4iFkcr/6m0p7sSbuoXEONoBeTEI6L2UTwkw8ZtJbE2GOCaRa9taDXYHNq3CwGda6tRPfRpe8J8GPcud3tqm8Z0LI/zilR1eegG+FUmDYp0U1N7Qf4Ns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mcMGn9Xr; arc=fail smtp.client-ip=52.101.125.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mcMGn9Xr"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VWjLCMd6vwv6KSQ06HRmouMHDSgKF85qF6JkfnYBV0rSyVc3zYuRoOSws1ND1COGkQK8nG/qW4zzDnEY2mLCmtwlZTlfd1QXCBSD/UpS6dUNxaPyxZvTj0W8lJYtlWi13nFHBv6+MERmBlv/RqTp5PgQy0dIlqhNNtDKU5I+vTzvcYQza2AYlpJBJoYa8R1WnN7i2ecLJrtXxZaQDxOx3lhGupGtYK70ALLSdiLWZvB1p9ga2UaTEVzBL935DpmdP1/DueN/a3DsUhg8vedypZQsVTLHcjA85JQX5zuefZUXSWF/mH8kNvhPOSueeeJLAqWirD4Ii7Wd3gG15hWlaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbxOFuuJLHgSDGhlVMaGVVF4605rOIZkwsHLrxa2jC8=;
 b=UnZR9yADkYDnJ1RUkCfz4axDY6YUSyuAfK4VFg9cSueBN8ToXljo+971qNtWv0JBcNDVTM0ei6x8nN40zVd/CtMBuAmd77b74mGdKEcHCwFE7jaSgcwoc48eIMIfb8ZxUtELR7dDUhF+cvVluu33d9740l4N6JNjcdE+3lPnkY7SVYpgHXl+E2TPhcjS8mB8lmpjMHYun7MWAQVw74TfjM5SXGdc9P7Ei268CrJOL/pXDsLLVMzO4fWbWFUqK8fOQ2edxmNWqKyaLpiHOaVe216ZA7k2UyqdYK0ZbaJhyHp9zCgpccySlERGxFdWC8FHwtTMiFQ5zIIi2VcfE69i8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbxOFuuJLHgSDGhlVMaGVVF4605rOIZkwsHLrxa2jC8=;
 b=mcMGn9XrsisJxNa+xt7KNEZ5aIhhHNZ3L/mvHonEapBLhrKbeAmK89dtHDYt9APDTxOHDg98C8eecYOCxtIZz1S1lEyhPpfGQ1IMhVn6iRAWC50PPhuR1q7wBin7YblvnnVqC0yyRGi1LzqRo6p11u9i4C6nEdrGrlbio+phBaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4188.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:109::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 02:57:27 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 02:57:27 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH net] net: ntb_netdev: Fix statistics races
Date: Mon, 24 Aug 2026 11:57:20 +0900
Message-ID: <20260824025720.3520288-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4188:EE_
X-MS-Office365-Filtering-Correlation-Id: 21a1fe12-9b84-4115-1db4-08df018b6e0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|10070799003|376014|7416014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0dEKW145xYOQYzqpn2z/m4rccKdBms2Yh7TDmvOanSWD9IjzAk9xZ6N/7VO8dytcmWw7VU++XOX2Fkt9agKmlu4P7UM6Iyk6raVjgZ/on46eX4hSbOGnA1ml/GhKebhcOlGRpu8yFnZSKmfOhhKcspHXPxveMchLSWpDlD95vrcxj/egSx9EU2x7O5cmjM9ulgoRw2VgldFAWn43kV0hZekEYvzig4F2crVa4jABKHwYeSaDNOlOtWfTbXTjvlZImk7vOXtvhPaD1r4L3a/DNMMtBmRsANHHwJdpz7BC9xh+t+Zt8On0tB/cnIkl0LwfO9a4JPLT/nVzlgDXfq5/QiNQWXU5tf2UIkrKTcTO3tZ3hbCvEDFKEMUrTBbntRngrFLnhAgjD0jXrIElBsZQN1LUZZaYNGSmexFZpkNBkJr0b+UsXsFDWezEmqasclepy67jSSTjkrZ/HO5UKKgD3rCwtXqqoFQD3W+hHc29WmN0/k5XyTOTYfTiSWtkxnhBsdV+QBBlx/6ZSJnVvGtQP2tYrrgsliondMV3HNT1FBUkQlS2Ef2YS3Lt4evFZLQsFQ8AV9wY9nFXMIYpColv+5HfdYvZQc8GujxVl+hv9+vUKjSUGkwJhDchWI6/Qhguw6WCL8qWZD+Pzui2LIhNBm7r23cj0K97CDcHQZrvHhI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(7416014)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Txhc957PbitMZz11uZFl8w9TqMRgaHdfA0BWm/nefJBNMMoSN76F7aTLbywP?=
 =?us-ascii?Q?hGCpbNtei96pdk5ZUmlXxgPWnSD+iToyrv2HNTrmkWn0tBDo3JP43REmStEz?=
 =?us-ascii?Q?zbm8i1AFhVH/VZReHUlMxfwVuSXNhhfv5qj/FOwbNeDD0N/LUISlUfJ7CO35?=
 =?us-ascii?Q?LFkbs7gQdWDdb7IgQwUyn9BK64aUk/qqPRml0ZXj2WVlkjzX+3yubQ05Rsmx?=
 =?us-ascii?Q?jgSkrK15wsDBPpbCK9Bkw+fIdU1zZei4fSYYNUZn2JRfa2dCwgx/HsOnu5tC?=
 =?us-ascii?Q?INscLAQ/RmEeMaUIve3dYbeqUSsDcJVqwEpIKngFnqLO9NNOr4RSRfZJaMvH?=
 =?us-ascii?Q?RNR5Zri08SH7MBn8GKkoMNhJaDznR6E4B4EO7ptIKE3eZyVnVjHruyAtqLY6?=
 =?us-ascii?Q?RV+6mfGlEotVQ9f6RnByYtkl8JBfwcJZHxNAGSnnGV+yi6+1aZpc2hYB85nU?=
 =?us-ascii?Q?RfQ7tOpLv1WcZE8gr+3XJdsqFxr4iG+H1M4GNnX6U9CbWRFXHH1nSWxEoWs5?=
 =?us-ascii?Q?m5xLAiOXh6OVVCsBvKL39G8ASywkihbCzC5btjXz7pJssiJINNG4MapudLBn?=
 =?us-ascii?Q?Z9y+rBC8CyzZPqNrW2BS+a6gvHuIRC5r6SRUOxyEMaHPmmcWP+bdAZkfNS+V?=
 =?us-ascii?Q?0468U8WnAaKdkc1EbPKij4HeuUXo1rEkPt2zZLruPoxTJkFzplCRPoTCdzWH?=
 =?us-ascii?Q?YFj6wllsYSOw0Xsgv7WWdGNn0CGe477E1ySuQpnCf8JYz77LmIoD+pcj0gsT?=
 =?us-ascii?Q?NBYfm5692lPqQl6PiIMlHlyuiwPNb5Uj5C4ParRUaOPNGisQl+3arfyhKMIj?=
 =?us-ascii?Q?1jljoa6LKL6R1mQsu+EMbzQ6XdhXIwAumbyMa9v82gvbHCvi7onDsa3LWxG5?=
 =?us-ascii?Q?rE1Hd6Q+A0US3+ORxwWK3Eon6fTRoQuSKWHy3BUusqzSR7D1zoYxuKRDkllL?=
 =?us-ascii?Q?VMSU0FvK9HO+xXNBNSkZQy6wdYpEab/FSAPfdcVvkYKjxKan4uiSwl1AXfZ0?=
 =?us-ascii?Q?CXd0HZF6yY2pKpCG/LWAiMic/qHgCURp/S3g9h/EbxivhFufEdhK/WD+qL2O?=
 =?us-ascii?Q?1D7gQHMnoHIYkuUsNb1pylOErORvYvezMzIGk3POPKTVdSf68sz453t/BTKW?=
 =?us-ascii?Q?ps/HHz5bbzbtjGEq4EomDASlrVKtVjHdTHFJ0NCEHkYZlL9qyJRQCBi0nKkZ?=
 =?us-ascii?Q?ffVE7z0g/ycudUo1HYb/lOropzJMATSTu73a6p/nWEw6DrSfGVFMe3mwoXkn?=
 =?us-ascii?Q?rYxPTRk1vgs3odu5jUvp1KmS78Z64Oelx0g0mibn8TMlyq5E9wcmqfbFq+ER?=
 =?us-ascii?Q?0Z+3Sh3IEdU+5dGKu7EvI+1Ys3JQsN/DZGPixSraUCmuVyoQIA7fiEXGIHr/?=
 =?us-ascii?Q?rw01YHEriZObx6+s4Hm9hlUB4j9XV7tsSad3FRvjrwXh3i5bsb5PobKgO/ac?=
 =?us-ascii?Q?2KZRzhSGZP17y4jBpruRehzm9BKphpipfqB83LvNzta7CR/88iEb1pYmQ/qG?=
 =?us-ascii?Q?88S8ZJJd3BMvbZB13mFQiKFrUfmsegyw6frWtIGQ5anLvy87e7GPhYjbp8ec?=
 =?us-ascii?Q?oJ6BtPpRr08kxAq0ETP8Hl1qhHM4m3sM6+i/L1BdOmYMiVV3AZhLWa4occJY?=
 =?us-ascii?Q?JnNp8JEL2ZOq20kZUPymSpx1WvVn1HabjBYY+3v8ZraMizKzdBkt9Uv4ZCnc?=
 =?us-ascii?Q?k4hNW9ZStbQJvGUwlMkLey/1X4Q9L6dsVbW3ZPqE0VI7L9zA0Lg1C3DC1ad6?=
 =?us-ascii?Q?iC6UYg8BOfip/3YJrdMF5SkySdjQi/FW8FcWKn6H1BJhcmjbOtiC?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 21a1fe12-9b84-4115-1db4-08df018b6e0d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 02:57:26.9644
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sqGNsBNzWNo2HpkM7PAvjPiI+K9usuJ/EF6q2/8N7WHpXzMSjSCOglGnsw2qt+p3MD5zZCfLII4gYiLBIlXQCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4188

ntb_netdev updates shared net_device stats from per-QP RX and TX
callbacks. Once multiple queues are enabled, concurrent updates can be
lost.

Use core-managed per-CPU dstats for packet, byte and drop counters.
Keep infrequent error counters in net_device_stats with atomic
DEV_STATS_INC(). The core handles allocation and aggregation.

Transport queues can still complete after ndo_stop. Tear them down from
ndo_uninit before the core frees dstats.

Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi-queue")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
This is the follow-up mentioned here:
https://lore.kernel.org/r/20260819172539.1450821-1-den@valinux.co.jp/
The related TX and RX fixes have now landed in net.

 drivers/net/ntb_netdev.c | 44 ++++++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 9c171697e762..6a1e58d5d7d6 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -139,17 +139,16 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
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
+	dev_dstats_rx_add(ndev, len);
 
 	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
 	if (!new_skb) {
-		ndev->stats.rx_dropped++;
+		dev_dstats_rx_dropped(ndev);
 		goto enqueue_again;
 	}
 
@@ -166,8 +165,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
 	if (rc) {
 		dev_kfree_skb_any(skb);
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_fifo_errors++;
+		DEV_STATS_INC(ndev, rx_errors);
+		DEV_STATS_INC(ndev, rx_fifo_errors);
 	}
 }
 
@@ -219,11 +218,13 @@ static void ntb_netdev_tx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		return;
 
 	if (len > 0) {
-		ndev->stats.tx_packets++;
-		ndev->stats.tx_bytes += skb->len;
+		/* TX completion may run from the memcpy kthread. */
+		local_bh_disable();
+		dev_dstats_tx_add(ndev, skb->len);
+		local_bh_enable();
 	} else {
-		ndev->stats.tx_errors++;
-		ndev->stats.tx_aborted_errors++;
+		DEV_STATS_INC(ndev, tx_errors);
+		DEV_STATS_INC(ndev, tx_aborted_errors);
 	}
 
 	dev_kfree_skb_any(skb);
@@ -277,7 +278,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 drop:
 	dev_kfree_skb_any(skb);
-	ndev->stats.tx_dropped++;
+	dev_dstats_tx_dropped(ndev);
 	return NETDEV_TX_OK;
 }
 
@@ -427,7 +428,19 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	return rc;
 }
 
+static void ntb_netdev_uninit(struct net_device *ndev)
+{
+	struct ntb_netdev *dev = netdev_priv(ndev);
+	unsigned int q;
+
+	for (q = 0; q < dev->num_queues; q++) {
+		ntb_transport_free_queue(dev->queues[q].qp);
+		dev->queues[q].qp = NULL;
+	}
+}
+
 static const struct net_device_ops ntb_netdev_ops = {
+	.ndo_uninit = ntb_netdev_uninit,
 	.ndo_open = ntb_netdev_open,
 	.ndo_stop = ntb_netdev_close,
 	.ndo_start_xmit = ntb_netdev_start_xmit,
@@ -647,6 +660,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	}
 
 	ndev->features = NETIF_F_HIGHDMA;
+	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_DSTATS;
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
@@ -696,8 +710,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 	return 0;
 
 err_free_qps:
-	for (q = 0; q < dev->num_queues; q++)
-		ntb_transport_free_queue(dev->queues[q].qp);
+	ntb_netdev_uninit(ndev);
 
 err_free_queues:
 	kfree(dev->queues);
@@ -711,11 +724,8 @@ static void ntb_netdev_remove(struct device *client_dev)
 {
 	struct net_device *ndev = dev_get_drvdata(client_dev);
 	struct ntb_netdev *dev = netdev_priv(ndev);
-	unsigned int q;
 
 	unregister_netdev(ndev);
-	for (q = 0; q < dev->num_queues; q++)
-		ntb_transport_free_queue(dev->queues[q].qp);
 
 	kfree(dev->queues);
 	free_netdev(ndev);

base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
-- 
2.51.0

