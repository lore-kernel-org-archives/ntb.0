Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C48B4195A1
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375737; cv=fail; b=ehcuB2qr1ZJqlJ1RUUvtTNp7B4FvYiLlhwtphFaC/gIIEljUh6t7f8QzzUZs2Ge3xnQ4C/DEZuMitdGOwMOySdXbuZ08rX3bKuCmoPKXtlv+Nf+Ix5hQD/5qpxxpK0HygZJqJQpLrLVdFPgwH9Tpz2ptKOmpT+yJVitadyNNSUk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375737; c=relaxed/simple;
	bh=QGJ41FjwFdPasJToxM9jJl1ASYtqCct4v+bDGvD6ovE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ciAMx2VPwmeLaHUkeUAKUYCE5QWwggfUA8PmYEKRSMrOg0+ftk5rpeJVrdMBzlOx/i7ZBv5Yfv0AoQzhaGgn1CHJxXBlH1waJkfOL5BjJEhHVSDLo0d+wVWBA1lqgA9W7UMssPPWo58BZr7jy+YDWRBh5HN0/ZzH65nOr75bh98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FECojvLh; arc=fail smtp.client-ip=52.101.228.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FECojvLh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cc0JBQnPPkqsLYvbMHOS9mYtqU0WGX1789nAKMFpKde/KPOFjq+dRGufBbqY8FmHW7yb58BbsEZnOjB4v3YDExIK7Ljz3zO1Bcsy85tXk2cIjI+GhHEiEG0wn8QIyDxH164te61ogjIFxT9D/M5pPwuKSoMxIphdu2tlGwDoOodunuhZ4hqYUB11JV1VHxp1ky9FhIbSXcS09Y6rmzYdCu51wRa7jPHkW/f+z0PgH5J2PQeUDI4xEJQceMj2fA8NbotwbrDGMXU4Y/hxD6ozRbRh0tTamx5FWf+HkylF9/3BRW6GSpyRfq29/8jBNSx0r5FywBYINe1CZmcyDGyurA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NaK8YWkRcqqKniPrRlUxo4RS+V3JrL4W0o4qtcdgNws=;
 b=nQr+h07srLiKJDSRgTSVu7Mof9UaGccLRylzAksYrfV+Cjk0xVS3+Ju4xIuanJJcrddbo9WQiE6ANU/5Lo11WWCgHa/RtSCVl3tkRH1U/saQB17LmotizWhcXbSG3qyM2HSn43m4NVtr0oeTAl1eaS0n9TfB5mWZFFrXi/qeJaN8VN++grtydkDadAk+aQRAEBjlnG/oZBCLcEdy1qc9uuWzsDGGijy8pm0R8cCvDniofp/MIpOWhIQwet7VyVh1g2TNYXy60ovFFIc/9JOVpmJJw+ILAlAhv43hLnQIZCTgWfUR0zH9hahcwIRfDmJ3m8I0Qy4ZMxDDZJoERWL/mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NaK8YWkRcqqKniPrRlUxo4RS+V3JrL4W0o4qtcdgNws=;
 b=FECojvLh61gINAWDqGn4wWOZZ0MjpwNwTNuQHmAo61o3W72jTGmbk5dk8MALcMFupelYslMiDNElniXVjjJFuuS6V2brwjKAUkta27m/RwsMkHmq6kLO8suhpi4gnStxEurTW+Zx7q/lTs+ErjvRYk65DYuN0+PB/R2xumyhums=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYTP286MB4022.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:49 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:49 +0000
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
Subject: [PATCH net-next v4 08/10] net: ntb_netdev: Factor out RX statistics update
Date: Mon, 14 Sep 2026 17:48:36 +0900
Message-ID: <20260914084838.2158249-9-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0055.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYTP286MB4022:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d0c8cf6-ebf5-4e5d-c5e9-08df123cfeae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gOImDsmBqhmmnFdySi7WMFCtNFk2Bxp8TVAazvUG1ORod5AaeW3wtaSo2w72t6agCooUiA816ES0fyRCAhFGBt5Ogd8RKREo8IfG+PZfVZJBOWYxC7hl5N2FqkGHhCJShZwE4pRSjQnURePenomOpfKKCMjsZtJJNP831B0EakoAzNURPoQCQrEEwYwqF2DD353579BIndx58inBktU+zwR2yFFL5afQ5+WHDp3TEWo+6gZuA3iCmPqBGEZxRKdY5nbAefQZtVL064BQitjU4w/Dd/GwJA3oPt4TipQtDZiPKFr4yKBDm6A61MBhIQYryCsRLLVY54ytTiIRv+AlJ/LlRHraC3WFNVkZHiT9KpOjI6gAKczIBPjrdFQ0EYY1pGvORDdQixqevHNz1yFras06T96bvOgx2f39dKEl8fn0mVHRogOxAXKAU9Xb00jueS7PDrO9pTlEVAZl5Ej93RSBTjHq3wWVqQVcOuFQ1TiDm7ATMmFJXt/5ycb27bb+lya2LPHYz/rV+JlLEqm+RG4C8Zk326LRVo1elEkDA6j01skcZr0AzUaleiwGf3EBT5cepXGrf0VHfJL7Ei4g0bWybnp9N5UhZKoGZsffKG/3O7kwfz/3s/wAkBAr0z3Wxc/G0MzNyQRs6EInK+VSUyc7QYgT6FWPY81ze3D0vUA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?12VbXTiDcFkkzhnmlz0jhXCsCZiKoZkjHeZfxL2Iz5wPEHQIRUxH9UWpY7fP?=
 =?us-ascii?Q?Ft98Jktm/tfWsKuZ/t+cxZ4DFYd8IJ2RBE7KTq+4yuL+D70Y/ubOlMPGUP5W?=
 =?us-ascii?Q?ikB8zbLH5rsCDaJ3vK1bG32omMY0N/PFOh7jKRbv69p3gg/EmAM09TNCM/j6?=
 =?us-ascii?Q?JzOQDkJn7nKVIqbJBCE+kzoH78aczF9z9Why8TPT+eryD1litX7AnD21IvVR?=
 =?us-ascii?Q?R3U5SbSQ8q2MtZWbNphCzh0hH4Z2bOsOMnP46mkKdcdQFg/gtcaI4TygSeDn?=
 =?us-ascii?Q?e3+FbqG9z4MfrUC2hyKachI2kkIBqFm/PZ+0t8joHgFk7SddDmJHfkuoH2cP?=
 =?us-ascii?Q?Xk4ZRKb0pt+KC5CjXP96GSdLhIcazJO+m9BlJ7DL4WkPkX0i/AV+EGwxiBxu?=
 =?us-ascii?Q?zueeMlhpwwl1ba57wkohZdAZ5/Lu1OQKEVMt1EjMc6iLbg5sFBiBv4ZwoqOo?=
 =?us-ascii?Q?j88zttXKaced5OjefgQ2lSHlKc8HqK3f5MjIovVXs4/NOUjQYxv4R3Tmrw2P?=
 =?us-ascii?Q?38n6Vb/U2j1tJwv3ene8Tw8muTaI0IUgolVWQw9Py8NafOdy9vCmNd4wMVyv?=
 =?us-ascii?Q?mbUUyInRxsvM2LqwOyaLcC/VmrZgQE8QuVlqKax3c3X4NQluoC4w0D2PdlD1?=
 =?us-ascii?Q?gj1GJKGET3NJnKw2CSI6hEnkJQ/8e2/eSrxgqcyqm5Jk+c5lTzQ6LCz1LJs2?=
 =?us-ascii?Q?oCoz+ruDDgcF0qrXwWf53SDPV/ev2cqJ2pRnQyJlTQVBqvzsWsTXJ6KFwMW/?=
 =?us-ascii?Q?sS0Lam4d0SSO5rm53GAKwiR2HzW2p7pHiPWmCqdfeqizQwPCP26e6jTiTzWK?=
 =?us-ascii?Q?oOcgGT79GpIR7DPmNIutnGBrRYbGMpRpcqwwWtSPvjokvOQVgiMky4gOG8Le?=
 =?us-ascii?Q?Hoc6qsVBtyF/nAAY7wXs97SceX/FMOWI5UyOFoLQsw5yhs939jLmfjzHlpvg?=
 =?us-ascii?Q?kL5eJ0YLBqbrzvHF0FKo5giqztv4w3Xym7Dk4/fFCNQELGSss+SCTCoXFfvA?=
 =?us-ascii?Q?RgpQ/t6E9QceUCaLlj6m3YFU0LIaZOO79pDPm2+hN/VtQHnJnohP1dpbWln9?=
 =?us-ascii?Q?BKocOHqUmQQ1ehLlzuiFc8sY81aGJNyzYCIwI44yx7Lnae6+3vnOn5zm93o+?=
 =?us-ascii?Q?SXl708Vsfqm90fPYDwoVPuCyxu/554Nip9Fmlu/TqkCECEpmKxJgcHhWF7No?=
 =?us-ascii?Q?LUiIxb2GSrbFmb6XPsk4WBAyOzarsHHiMLNgaOnVZaWBUx5jMj6sG3FnxHE8?=
 =?us-ascii?Q?2zz0goYL6Kxhtjo/knIUvJy22tpNr1UN51U+P9FaPlYiEQH0WUlCFTjDRE1q?=
 =?us-ascii?Q?4qUzPbTaTgr8yfoG+spzTniV1ThmXe/k750/Zr2BB5NpzhEdooxsbF83+xeK?=
 =?us-ascii?Q?ypTOVOx+NhSdnl1aMRP4l13NjEKPM66s/BVNWXdRnyL3gDQBpZWWED5XxwKz?=
 =?us-ascii?Q?OCYhE1YLBLQOQs1aKi3omWlj1ozSkSqIU9n4n3yU8CNieN4Pg2t4+CT1H0Rx?=
 =?us-ascii?Q?hQegkuqgkb83AkEbkLtB0SrCpFRRGJxHd8iy6+2cfg0REJNMcgfAqhDO9xoK?=
 =?us-ascii?Q?UnymqXDkG/FUnxxxkMovs5drvuNRGBioPdMhYQPzjbwZesxaORSBTi6H8eLg?=
 =?us-ascii?Q?GXR3Wmmr8qLhPZkTxVRWJR8XqslkF6J0H5ZvcswjheaUq6vFC3pfiNBiIGI4?=
 =?us-ascii?Q?kXXxc2FRLJaHhmgjFp5cq2hRUUqD0SM5Tho1w/MbAleyszhMNcidcmMPrcIK?=
 =?us-ascii?Q?grxByud8yR6dJnaCo5T19QWRJJKntmlhBh9J4KKEImVdNbt4/Mou?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d0c8cf6-ebf5-4e5d-c5e9-08df123cfeae
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:49.1350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DTEzIBFCyTCz3MF0xPQWo2Z0YFMj1BrzvEjo6BgU8UjGGAtNmMnEx/Dbr1otT0DiyrGMFc/n/3AboUVnG/n3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4022

Move RX packet and byte accounting into a helper for the packet-header
handling added by the next patch.

No functional change.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch.

For reviewers: I split this out for easier review, but I'm happy to fold
it into the next patch if preferred.

 drivers/net/ntb_netdev.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 84fdd81ebd16..cddfe8d63fc1 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -122,15 +122,25 @@ static void ntb_netdev_event_handler(void *data, int link_is_up, u32 peer_caps)
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
@@ -146,11 +156,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
-	tstats = this_cpu_ptr(ndev->tstats);
-	flags = u64_stats_update_begin_irqsave(&tstats->syncp);
-	u64_stats_inc(&tstats->rx_packets);
-	u64_stats_add(&tstats->rx_bytes, len);
-	u64_stats_update_end_irqrestore(&tstats->syncp, flags);
+	ntb_netdev_rx_stats_add(ndev, len);
 
 	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
 	if (!new_skb) {
-- 
2.51.0

