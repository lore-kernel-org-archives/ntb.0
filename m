Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D628A4195A1
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375740; cv=fail; b=Ej1Ozz2XYOdouBvjhvJWJt74Kz9usNlvP4prEwZBBbI1nVtPIyzcUK0JGqdcH3vWM6g0qrfFsatgmTN6JH6U3YXOe6uXaLI/wSSdoxhRLlRO2ZK9q6Vbd4p8M+hccpQPdBjj8IODQVOctiaMuL6zu6MZCz4wsMX1a1HHXwWF7QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375740; c=relaxed/simple;
	bh=540ftUe3kPNqKo3fY2svr3HqyoWuIgIMC3Tr4745vrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jVkR5BCU2LHtOnBPQz5UpXQ677C09k45RudfiE2Kmr9HDinXybikNzKABaOMraeSB1sETq7ZfR14aXufklCAKIBDksl9ffJVBOFfPO5iPQomZEDZQvFt+LsOXj5RK4JRjQs5/jpST0WAR/SBitHZkJkke35SvKLWOfEBAL9T2Jk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XTnSQK19; arc=fail smtp.client-ip=52.101.228.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XTnSQK19"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vbBQn9kqLO0SHGVKmhAdmcZ3/EiSn2jDiP3NNm+uS/2ID13HdeAcpGTZ0QQ0mqSneNjsNdn+oSpzZXOWJDFX+9qbEZTnwy012xpFIMwmd/m2P/qA1E2v10sex/W64mc7BN1otUrICrv4aojSA2aMsc+Ezm0aQroSeQOXwpCwabzfJTsNQ3C5HhGXyWv8traH+0uIyTLeLEoDaTbQcSVQNItUojd1KLcD1Ovr0hZFfVcSeh5hbIBUOmSmoqgpT4YEVlq2ScQ9ZhT/2suhKm59Rts2zeGikplmbhR3fGuF577p6l1PRIpb21rEYyz6oEEq1x2KumdoYNfdXnW7Oor9XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjiUpbMW23BJUv9Yh7+Ca0FVgvVTErwlLBaaPa2PPWs=;
 b=WZ2Rz+CYc2MDMT37GSlxJ2iZRQ7D3xMK5FHc6oH6Sm10cS2aExYU0NHy8xzk1Ud8+YcNzI7zCVa7F9miXy+wdVJIJnV77nyDgpuU2zImlVd/z0S8S1fgpsIgf8dPEer5B6bCDt08pWssbdwGNt6EvTwVtZxhsVniXn8EHfj4eLU8XWa2xmJ/Z6Y6Kf9XgC28u4OcBRrw+q4aNDvbmvEatskXIIHRVvczuLRf0scn+Ro8kpAYuvRz5rmj02oVn6RUEOR49mnvTOmBpk01Cw4y/IeaWPSm0vu1scG0ojfwfsvMos1wn+usB4rI48x0Bds9PW6xhR5MoqemMClpzx94Zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjiUpbMW23BJUv9Yh7+Ca0FVgvVTErwlLBaaPa2PPWs=;
 b=XTnSQK19KGlHiPk9gaqvcCzaGtxz0bIBYoyOMz1F31IzpvhHpDMbMrzq6Dm+lngpZg8NmCvaxU30hhIBZENpZUFNzQYmqhHdcHu363RT99gWzTc0wkbTri2OaoGGuYb6bvWA4T1+j6z/ZwOCokjdwSjZlpCDT2cpg1gkDodvf28=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYTP286MB4022.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:50 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:50 +0000
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
Subject: [PATCH net-next v4 09/10] net: ntb_netdev: Introduce an optional packet header, ntb_netdev_hdr
Date: Mon, 14 Sep 2026 17:48:37 +0900
Message-ID: <20260914084838.2158249-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0076.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::10) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYTP286MB4022:EE_
X-MS-Office365-Filtering-Correlation-Id: d95b9fd6-2e75-4f6e-655d-08df123cff87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/aGl6hkEi9Dti590Vfz6Fgo4wWwAxZktkfSrS1+TpFJ2W8C9qScsclHvOjGGWNH7AbkekyFJ47mG8pcz/eDVCo7VM/gWPR+vK87LkPKK3vsKJp7c4mwNRMEGsNDZLV/mscedA3OB7dcdasqfHLiGlA+CaIWZkORDvFHrGKYfVWVZprSnnA1ry292Ks535LlnXtURzQJRU2+LOZbJRquMz4Agx43ChJKCmXnW8iQ3J0jPrKKXYjmK7BWhcDbLYcd0tfxqSQ06WMCULVKc2StmMFE7u6eyTgQp0pSUr6AUIPV7M9Xm7DP55oDrXwdvUp0hU1GiMTlE2Oma76LN4ldW/cXnNTnQVuwf/OCRFiRs5wFTOZwky6OMHke+HQDRv6YS+aNoF/uJ1hB0ZkL/XtIScvQ9/44JNgHqLBXTyiCR/+JUFsIGruOd9hifyYtm0BMOja5PzGc7MPHeYydNYuzUY914B2D5tWL0M5y5KNLasct62NRA68dunh3B3SSWbCNDbFXm/GgGNy/9fR2Xj8t+rOstAaBvjk9qPyCbCsO7cWrSdoCZhQq+7RE0QJr9ZoP2lmV/1FNhD6Ung0ykt1pebTy+Kv4e1VoBF52a397xzKw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AgBaSJo2ciEL+CBTEO6zXHDdNE9nnqQ+/Zj/Va5c9p7irIfG3tgqLtHkVKgr?=
 =?us-ascii?Q?HXy4h9bGhyS8kGOIoIJpJDKnHxJfZS9r8qgGJDuJDzw4dQRnFrcBSlqXVseV?=
 =?us-ascii?Q?614PRNDo7ofyi05L8Rv7Z9uQm0FbjkhHv1gAGUyoIGPuW/qqWtQkk2aIP45K?=
 =?us-ascii?Q?Y8jgaHUju83v3CwP91juTIgdwl0Sy83H310C1T13HjW4DXWgsetyZo4fdFaF?=
 =?us-ascii?Q?I3VS97Pbxz2p5isshJ5tiYwbun43lTrg2te4WYO6ytvudSySiA4KYrvEoR82?=
 =?us-ascii?Q?lCnK0jSKE8J5qV8MDtfSHVRyrGtTb7NpXv/bkTxGpBBQHVyGgJ2/nRTLVs3a?=
 =?us-ascii?Q?krGWbF1FtWaWDc0UEFNodgAbnLLbG3i3qH0CeiyH/gpb23vmP+FrF2YOoVrL?=
 =?us-ascii?Q?+cKWoPMCsu63JIKAJB2hI33IyUX8zv89lghoWNnVKfLnp9lxBl28V23tG98R?=
 =?us-ascii?Q?FFz8FEK0kuSoW3j+Z3rEm7bKTkvQVtpWJD5HbIivDONfZd9hWWl66CXPN1mM?=
 =?us-ascii?Q?PRngDYk285wzRBPVcbuAWmYXsjd+wQ9JQpQyd5oV653bpzHoSz59EbCzcdzA?=
 =?us-ascii?Q?2vcpRmYtdBWerPCWFRRmRk/jKm3KDGEHhUsUUIQngncRbPwQOhhlPwPPaMx2?=
 =?us-ascii?Q?VOh41BFtiGRv5Qal4vgl+rgpJMsN0k3clENeWc4RxYOJ4NcL1bkbFn9Eahdd?=
 =?us-ascii?Q?VHr9VFCudS6djIGk3C5HR7WS04dYnRZfFm3JW7v6AHRGhqzluvpFt8iyb/0r?=
 =?us-ascii?Q?bELt5FI93P/8K6yfGQ9fJmvkSCcul2pSwLFrMerSIT2aTHsq5j+wgH2c8vuq?=
 =?us-ascii?Q?s6a1cJTtRzF/v3Hf3CkWsQqkJ/2P0fQtV+rBpoaqa/zTMTu9mBtvDuRs6UgI?=
 =?us-ascii?Q?z1LJplkIepYyJSrYx3d9T4YxptmOUmgoN7hPl4+ZGtJgqUHdss2e/ryzIaJT?=
 =?us-ascii?Q?EHwXHDVihmtkPIzGQKzWqOFm9dLrTqcDtKxo2o7UPlN8CT+FK/it5gR251ch?=
 =?us-ascii?Q?A90B/NWWxt3cxYwXN96qgw+V0hEtxVAy7eJOEGeqQcNxhhPUgSBS2jYndll7?=
 =?us-ascii?Q?eoHhZh7KuhjXMaZiovkQsD3yuHOMwZBaHQWlQIeZgK3TFX1wAWjOQYwaz3KW?=
 =?us-ascii?Q?76x0vjVcZNy9rJEffz+xKN2ZdI2sjH0viWsmbueoZTgEH4igtlLLpyDuF8JG?=
 =?us-ascii?Q?+1O2ahSgYC3pnyx6torbOSvy+hIydKa+CUoGLmPEO7+IIe2m5qDfOwo4yWoT?=
 =?us-ascii?Q?8tbuMnG6jDpHnp7SxEK8PVGrPCeMo48pCb9eRsKzxUkBHD9ZQ5Hh6PN0xY73?=
 =?us-ascii?Q?+JCnKaMkW7jd8ROfxKdhjBcwyFxpr/RsRvBrtHObotzcQJQ376FvuHAXXHQ5?=
 =?us-ascii?Q?E7jWFL/XH+vI8f9z9mmJq9Va/l5ZiDnYjKCNzn3RDRzpBqVHcni3J6z5ortH?=
 =?us-ascii?Q?xsAguMEVmHnm0MhxzQWQ9qhr6eO0Nx6kOizXElYPUfREStNYj7+vEPUzIQ6G?=
 =?us-ascii?Q?0TM5e/kyV+J3syfpbdRxthkD8eRX+0gF5O/INDiQCoS1bhdKpWDha+Utmw0T?=
 =?us-ascii?Q?+F9BZS8PyZiKoe7wqHT99zkLkhYQf7bwYY3XL80IK/GGTgMW7hYRYeCnSytO?=
 =?us-ascii?Q?sudX/CJhupdPpN4uhEj1E8BsvxczwLpk2xuhA+KULbnD85e1EzvO9f6WJpI2?=
 =?us-ascii?Q?qGvnYcwvfgUAaSRsNpepSay1MJFFvOIc6T2GcaU804R/Egr27SKpD7q2BzXW?=
 =?us-ascii?Q?aOLmtVGHFW8ylwHd7UApWZleCZBasghFt4VoXZ5m+F2IeEsDsPxs?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d95b9fd6-2e75-4f6e-655d-08df123cff87
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:50.5972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/53MzntuRKCQziBoyQaBCRo5tDKFJTWsQ1LlgpMRcg6XymeGzMgM75MU6sMq5EkXTKz+gjS/ul1FHtbF02ayA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4022

Add an optional ntb_netdev_hdr for per-packet metadata, with a length
field for future extensions. One client metadata bit marks its presence.
Account for it in TX headroom, the MTU and RX buffers.

The flags field must be zero for now. The next patch adds checksum
metadata.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch. (Jakub)
    https://lore.kernel.org/r/20260910172047.167225eb@kernel.org/

 drivers/net/ntb_netdev.c | 69 ++++++++++++++++++++++++++++++++--------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index cddfe8d63fc1..67cfe0f1a49a 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -29,6 +29,14 @@ static unsigned int tx_stop = 5;
 #define NTB_NETDEV_MAX_QUEUES		64
 #define NTB_NETDEV_DEFAULT_QUEUES	1
 
+/* An ntb_netdev_hdr precedes the packet. */
+#define NTB_NETDEV_META_HDR		BIT(0)
+
+struct ntb_netdev_hdr {
+	__le16 len;		/* Header length in bytes, a multiple of 2. */
+	__le16 flags;
+};
+
 struct ntb_netdev;
 
 struct ntb_netdev_queue {
@@ -83,15 +91,16 @@ static int ntb_netdev_queue_rx_fill(struct net_device *ndev,
 				    struct ntb_netdev_queue *queue)
 {
 	struct sk_buff *skb;
+	unsigned int size;
 	int rc, i;
 
+	size = ndev->mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr);
 	for (i = 0; i < NTB_RXQ_SIZE; i++) {
-		skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+		skb = netdev_alloc_skb(ndev, size);
 		if (!skb)
 			return -ENOMEM;
 
-		rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data,
-					      ndev->mtu + ETH_HLEN);
+		rc = ntb_transport_rx_enqueue(queue->qp, skb, skb->data, size);
 		if (rc) {
 			dev_kfree_skb(skb);
 			return rc;
@@ -137,34 +146,57 @@ static void ntb_netdev_rx_stats_add(struct net_device *ndev,
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 				  void *data, int len, unsigned int meta)
 {
+	const struct ntb_netdev_hdr *hdr = NULL;
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
+	unsigned int size, hdr_len = 0;
 	struct sk_buff *skb, *new_skb;
 	struct net_device *ndev;
 	int rc;
 
 	ndev = dev->ndev;
+	size = ndev->mtu + ETH_HLEN + sizeof(*hdr);
 	skb = data;
 	if (!skb)
 		return;
 
 	netdev_dbg(ndev, "%s: %d byte payload received\n", __func__, len);
 
+	/* Validate the frame and optional header lengths. */
 	if (len < ETH_HLEN) {
 		DEV_STATS_INC(ndev, rx_errors);
 		DEV_STATS_INC(ndev, rx_length_errors);
 		goto enqueue_again;
 	}
+	if (meta & NTB_NETDEV_META_HDR) {
+		hdr = (void *)skb->data;
+		hdr_len = le16_to_cpu(hdr->len);
+		if (hdr_len < sizeof(*hdr) || !IS_ALIGNED(hdr_len, 2) ||
+		    hdr_len > len - ETH_HLEN) {
+			DEV_STATS_INC(ndev, rx_errors);
+			DEV_STATS_INC(ndev, rx_length_errors);
+			goto enqueue_again;
+		}
+		len -= hdr_len;
+	}
 
-	ntb_netdev_rx_stats_add(ndev, len);
-
-	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	new_skb = netdev_alloc_skb(ndev, size);
 	if (!new_skb) {
+		ntb_netdev_rx_stats_add(ndev, len);
 		DEV_STATS_INC(ndev, rx_dropped);
 		goto enqueue_again;
 	}
 
-	skb_put(skb, len);
+	skb_put(skb, len + hdr_len);
+	if (hdr) {
+		u16 flags = le16_to_cpu(hdr->flags);
+
+		skb_pull(skb, hdr_len);
+		if (flags)
+			goto rx_drop;
+	}
+
+	ntb_netdev_rx_stats_add(ndev, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
 	skb_record_rx_queue(skb, q->qid);
@@ -174,12 +206,19 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb = new_skb;
 
 enqueue_again:
-	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
+	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, size);
 	if (rc) {
 		dev_kfree_skb_any(skb);
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
@@ -390,9 +429,11 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	struct ntb_netdev_queue *queue;
 	struct sk_buff *skb;
 	unsigned int q, i;
+	unsigned int size;
 	int len, rc = 0;
 
-	if (new_mtu > ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN)
+	size = new_mtu + ETH_HLEN + sizeof(struct ntb_netdev_hdr);
+	if (size > ntb_transport_max_size(dev->queues[0].qp))
 		return -EINVAL;
 
 	if (!netif_running(ndev)) {
@@ -414,8 +455,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 				dev_kfree_skb(skb);
 
 			for (; i; i--) {
-				skb = netdev_alloc_skb(ndev,
-						       new_mtu + ETH_HLEN);
+				skb = netdev_alloc_skb(ndev, size);
 				if (!skb) {
 					rc = -ENOMEM;
 					goto err;
@@ -423,8 +463,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 
 				rc = ntb_transport_rx_enqueue(queue->qp, skb,
 							      skb->data,
-							      new_mtu +
-							      ETH_HLEN);
+							      size);
 				if (rc) {
 					dev_kfree_skb(skb);
 					goto err;
@@ -673,6 +712,7 @@ static int ntb_netdev_probe(struct device *client_dev)
 
 	ndev->features = NETIF_F_HIGHDMA;
 	ndev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
+	ndev->needed_headroom = sizeof(struct ntb_netdev_hdr);
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
@@ -710,7 +750,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 	if (rc)
 		goto err_free_qps;
 
-	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN;
+	ndev->mtu = ntb_transport_max_size(dev->queues[0].qp) - ETH_HLEN -
+		    sizeof(struct ntb_netdev_hdr);
 
 	rc = register_netdev(ndev);
 	if (rc)
-- 
2.51.0

