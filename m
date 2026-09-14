Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FB940BCAD
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375738; cv=fail; b=Xhqj3st0hh2pR3sENku7qxBIDWTdFjTOn4LK4XHtOSwJ7l+A9GLDynN9+ma7MK9lxmC5kKp1Zh81A2WRwAvB/5uJdBx5XsZZXWg65KuA4uNXnSfBNAmpWjTd+j//k7+YW6/ILyD75XnR3T9nFe1ngMcv2GvF7jzSa3c5a/RR9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375738; c=relaxed/simple;
	bh=E1IMZ7jSk/5Ukcv8hz4MO9T8TIkkt24vbrRmbjuuVhk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u98dHhIAMK50XzP91hVBncHOdBwccR4itFTwhElZ4H/+RqdiMc3d4hxFSuZPBcrTswo5ONBnR5diDlxNru2H+66vi9cXgLmGUxtZ0pGlIKz3x38NK5oIB91GNR4poCIR/76A9KK4fwcMWMpBAdK9iUMDalu2yBaU64GqDVZwJs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=iDwr1zko; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="iDwr1zko"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NldfIsSxny85zN9WTKbeq4CHe6GLTWDZBeKWNg7a3AAMUFRDq28qr0TDHLNy+wrY2lb0gfaK09rE8fxgx3uhWiDzEzXNYJnkGp5/0oyvPmOqMwS5RojjrAhIKtg7nGIujXPoGPQ+NnqpPFuDP8jnKPtPcMoGukJ0dl8N2xyePVq9JzjxQQd81C/6MT3xujmc1sb8Oo69IHJtSNo/0ZYIDZJQyAhVFQA9XoDLdQsNg+rU1G1ahB5zlHQtt2ftk+mzddpQJd3Kg8uX2rL7boQUwkNXswqNPoWwdjYC8lqqJNOh/fG+FVbDl8Ohvy5M1LFLi1s8r5qspzEDJ/fkngcN9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SN9JisR/Uw31EEe8kLFDJmajw0Tzuu8SMbKcgH+BwA=;
 b=UUOJh43zbkdZHa6zoSFcSUJl+zwn/8VQGxj0VJRGGrwCGFDF7TJaxFFVA6JkuM3KmhlOtlqB3n9GwIJ+7J+pbl/ieyevnKFUrfCKQ8oJUaO9KwxAQph2EmWnrdMcUS9tSndXKJ4iLUWjceaUtmmmnIi/GVN2+oOgj+Qe63RLBjgZ1uOSC2s6VJo2Ons5x4ud7DcsnuAf2/X2kThzC/vpLkGozdczSUC/9S3K9hZ1r3duJL6jiqyT8bmqMeWI5PnxWML8N/wTNQt7UhnkXmuPCNOmOrrpFrlkW9m0MukfokauI4TrlWClHnUePF+0q0QBrV69S3YP0xb7C5dXEEH1sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SN9JisR/Uw31EEe8kLFDJmajw0Tzuu8SMbKcgH+BwA=;
 b=iDwr1zkob+YvqKFQnGCMSXKePx+eoMqkdzAlOBpORhlxN4ak1KaHWwxm7ehljsXmh9fSxleUcShsIzYxRMN4iKqvjNfe23Jlae582ioOo0aoNdyKaRox+n0NLSLrMe0SOjrdAyPowHhV937kXFMjwz7MA4Wf98J5sDF7961iVXI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:47 +0000
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
Subject: [PATCH net-next v4 06/10] NTB: ntb_transport: Add per-payload client metadata
Date: Mon, 14 Sep 2026 17:48:34 +0900
Message-ID: <20260914084838.2158249-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0078.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36d::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 76113446-f803-43f7-5320-08df123cfd78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|6133799003|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	PGwWMNbZ8fMSqbFL5S4rfBGrZVjtwLvHkwLC1ATVTyeR3nLI3kKNVCovkMAIxEnF+umHkiH7DefWQTvNeuPgRYAJrDz1o9tIyMmZBPjWIGmL+tl40F1M9LRwMoJ2P/ui6d+u+T7jf3J0SLLvUJ3gnWfjXWO6UuGYZBkQvlYD7WkdahaaOrIWbWyhknv7VICkDuSS630ZnlKSLsRDLCtSzNYNxstgTHWs6IrC+wv3XgynEnHDNv670LUPnbx+1x398kniYa1Ciym8dRhmDZWEj4njiqE991Jdzai34+Swo2SK5Bm6kOskQCGNLPoWalWz5TNKeLdb5xitaBLORY8JmMl0+pXpLYZEl8WkjzE9Ly5vP7yS6sHcKuoAbjQ2eUfP2UkDPow6zWhRkKku/9ETC3s5q5kGbdCKCcQVJccB9zhpm7oZOlpH1VGk92I3Y1xBJUqBwHo0mF4B/AKpaaYNZ5Yc4s0fEpG83EkLZne2mIs/wE7DWRL5yirHmU/7jdzD1eOTTLdgck4XyMDDRSt7HUbWoyBUIjucx9cMwzCy9jUOgsuikORh1+e2ffr762VU7NPEnf1PKE4xnfWsDPk5SYIkMWlh0DM/S46gDyG1FXwZ416p3CdHjtd3xCuPAdqCYse0uqomHJreRud9N0ZY//V9tjt++vRahSoau3YKZ9Q=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(6133799003)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZJJA87uE+SSk4JlGPaOWluYKCnwjrxmd+h4t/IWke/tP/GoHY+lgSo9+sLwY?=
 =?us-ascii?Q?14vooRzKeYDWchPenH3bVFkQ/yiGWoRLy6WHUXhX30PBS88sMAmuL2StXO4s?=
 =?us-ascii?Q?OuJ/d+JUyKJ4BazSREdy+Ma8mEM6bdX6J1fyfZblKmshnvRxymubjAvluHl1?=
 =?us-ascii?Q?idE8UM0TiVz/wnb0C68N7wH3CkI8+eHEH3HXyg+OYpo3KCY93Q07CfYS8m2r?=
 =?us-ascii?Q?61HjHyWx7aBEVbxfe2htkQQ8vBEnZfo10vUmqG0xK4dYbdqm+JDknge+i1Cy?=
 =?us-ascii?Q?sqAhOMJeiovYP/Ti4QqsrAPUzCX8fVJg0Mp3Lk5esEZRvKcem7jJPPh0vO5a?=
 =?us-ascii?Q?3UuvOtn4Ph2/DGfnSl7rqHrsWaM+WXMUXa6UqpJ9pRc3Ii+4r6bYRmDOGc59?=
 =?us-ascii?Q?W10sTi2mbmmp/85xX6PiacmuXp2H7VjvE8lqOlgOjOxJpKhjf0cx0JLlgFAf?=
 =?us-ascii?Q?vntvJVcutrIVJ/4hctN5pONdsO/9CZnRmjxM5Byf7fwt/How3nfRrZjD5wkY?=
 =?us-ascii?Q?m8duOOJtvMgUGKREMInL3eABgX43zdXSGU9nue000uIx5v5xp8W48tP1Z0vi?=
 =?us-ascii?Q?wkhQtgTj1aBcRSGnC9g3SrE+m7h4311FBHdM7CA21nwhBJj0LJilR0lp/O2X?=
 =?us-ascii?Q?UNV+Xdgl1dkgPIjnS33B38p011tgj4g1JsDnXwznLN2PrDGua3KvbZ07hHWW?=
 =?us-ascii?Q?BQJLcsu2ZQ7TkD0Gf/UO2Gg69LaBeYTb3GwijCvsOvkvfeC29DD0gTzAZYuH?=
 =?us-ascii?Q?jOE0YNnTRc8K2ncbXIL7gtP9cYueXJlkgTsJvBSL1LtofCIQNC84hlyAX8pH?=
 =?us-ascii?Q?jslUtc4YyoVw2fb9GmjtlPAFmmmKQ+BidlQo9MvytqQToM6EsHJ+EL6dSY3P?=
 =?us-ascii?Q?axuXNzAlXvyuEEAm8UFn+jaJVFPo7qIm9HpyWOapLpLnd+acpy1yglVtFwxA?=
 =?us-ascii?Q?v1i1xhZChZ2Vqq/F1DA2ROq4/Qs2BVuL4kEcrnWEX9khGFVOJtwj2Tkn6wsL?=
 =?us-ascii?Q?yXz9/J8y2/9lF9581D1+ZqP/AZHkJsXNh+334t0fBQK1FcL223OEHqLeQoiP?=
 =?us-ascii?Q?Talpk7+l5MHkUfZE0ZjSDaz3QOyxondKPBvJ/Pl1ia3vHaKyiVGKA+2rWMRP?=
 =?us-ascii?Q?p6zXdOzgphiuWUvm4Xjq4bQUtPagMVY2AUW7x4ZbP3f/3CszyqsqzIultkJP?=
 =?us-ascii?Q?YoH7q5sKtxfmxDtcxaYosocot1ZJli4zLqNX2CQOMHuMjcU4ZZOkjHudw4gE?=
 =?us-ascii?Q?Pc60eH+u2a2VhC+lGBfVBQPL4cy4JdDnL4g9DRAiwxvCjvy+UJNNyBTtcLvv?=
 =?us-ascii?Q?PELfvfFKsf6j8UJpQSYfcyARXW2e46rlON1eExGtI6r9CzLeXT9n01UviN8T?=
 =?us-ascii?Q?Ch0JHeg6DwKfX1Jy75O32wovC1ffwN2ysqY/nPNddyDHypl4h2p5aOXcAkoR?=
 =?us-ascii?Q?L6WKkoxqq3uQ88MqKvOzPLKN+joB0MBBTQDyJOVjAZumH56hZvDSu6Bd9uL2?=
 =?us-ascii?Q?vjrIuwIwg9dnc/w3Z2gUaejXVIJ8h1N8KM2LjJEw7Id+NvSlep7rOhbd1ZWk?=
 =?us-ascii?Q?gQ8uPyj4HMbYhlXnK/Rzxwcfa59WNQQsge8LccQrZWGKS3s3tZ26yLcfGohr?=
 =?us-ascii?Q?xosXfea3o0IlOjRVkE2hyiK8EQilf7/s3VBFWLcn9mbOiheq4ITCd2pwv2/P?=
 =?us-ascii?Q?3uP765x2lYlIslEx0iItrruXANsNymFoJGvdRokmy439cmrvgIuFN0KKT9hs?=
 =?us-ascii?Q?Z4K2CoFLCoIAgBvTvfpKsZd+Y8LY4QT0yH/RdPnsNYrpRb8WkhRo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 76113446-f803-43f7-5320-08df123cfd78
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:47.1737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tfWX9NAVSlDmxE5QUQnF0xw6R4QB7Sy44VIb+bawa4VFCEiYhLFWXVPn1mMBoiIbtwes0XuaY5ULb8kzYBDCFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

ntb_transport currently carries only payload bytes, with no way for clients
to associate metadata with an individual payload.

The payload header has a 32-bit flags field, with only BIT(0) and BIT(1) in
use. Carry opaque client metadata in the upper 24 bits. Expose it through
the transmit enqueue interface and receive callback. Reject values that do
not fit. Keep the low byte for transport flags so future flags can continue
from BIT(2).

No protocol version bump is needed. Existing Linux peers using
transport version 4 ignore the upper bits on receive and always
transmit them as zero.

Adapt ntb_netdev to the new interfaces without using metadata.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Use the acquire-loaded flags for RX metadata and WRITE_ONCE() when
    initializing entry->flags (Sashiko)
  - Document the metadata range and legacy RX behavior (Sashiko)
  - Use GENMASK() and FIELD_*() helpers for metadata (Jakub)
  - Did not carry over Dave's R-b tag due to the changes. Would
    appreciate another look.

 drivers/net/ntb_netdev.c      |  4 ++--
 drivers/ntb/ntb_transport.c   | 29 ++++++++++++++++++++---------
 include/linux/ntb_transport.h |  5 +++--
 3 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 869fc9a7f9e8..78df47659d45 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -123,7 +123,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up, u32 peer_caps)
 }
 
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
-				  void *data, int len)
+				  void *data, int len, unsigned int meta)
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
@@ -278,7 +278,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
 		return NETDEV_TX_BUSY;
 
-	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
 	if (rc) {
 		if (rc == -EAGAIN || rc == -EBUSY) {
 			netif_stop_subqueue(ndev, q->qid);
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index ea89eb336472..8ec798893ac4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -47,6 +47,7 @@
  * Contact Information:
  * Jon Mason <jon.mason@intel.com>
  */
+#include <linux/bitfield.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
 #include <linux/dmaengine.h>
@@ -169,7 +170,7 @@ struct ntb_transport_qp {
 	unsigned int tx_max_frame;
 
 	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
+			   void *data, int len, unsigned int meta);
 	struct list_head rx_post_q;
 	struct list_head rx_pend_q;
 	struct list_head rx_free_q;
@@ -269,6 +270,9 @@ enum {
 	LINK_DOWN_FLAG = BIT(1),
 };
 
+/* Reserve the low byte for transport flags. */
+#define DESC_META_MASK		GENMASK(31, 8)
+
 struct ntb_payload_header {
 	__le32 ver;
 	__le32 len;
@@ -1490,17 +1494,20 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_queue_entry *entry;
-	void *cb_data;
-	unsigned int len;
 	unsigned long irqflags;
+	unsigned int flags;
+	unsigned int meta;
+	unsigned int len;
+	void *cb_data;
 
 	spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
 
 	while (!list_empty(&qp->rx_post_q)) {
 		entry = list_first_entry(&qp->rx_post_q,
 					 struct ntb_queue_entry, entry);
-		/* DONE publishes the entry fields and copied data. */
-		if (!(smp_load_acquire(&entry->flags) & DESC_DONE_FLAG))
+		/* DONE publishes the entry, payload and client metadata. */
+		flags = smp_load_acquire(&entry->flags);
+		if (!(flags & DESC_DONE_FLAG))
 			break;
 
 		entry->rx_hdr->flags = cpu_to_le32(0);
@@ -1508,13 +1515,14 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 
 		cb_data = entry->cb_data;
 		len = entry->len;
+		meta = FIELD_GET(DESC_META_MASK, flags);
 
 		list_move_tail(&entry->entry, &qp->rx_free_q);
 
 		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
 
 		if (qp->rx_handler && qp->client_ready)
-			qp->rx_handler(qp, qp->cb_data, cb_data, len);
+			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);
 
 		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
 	}
@@ -1714,6 +1722,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 
 	entry->rx_hdr = hdr;
 	entry->rx_index = qp->rx_index;
+	WRITE_ONCE(entry->flags, flags & DESC_META_MASK);
 
 	if (len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
@@ -2396,6 +2405,8 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
  * @cb: per buffer pointer for callback function to use
  * @data: pointer to data buffer that will be sent
  * @len: length of the data buffer
+ * @meta: 24-bit client metadata to send.
+ *        Out-of-range values return -EINVAL.
  *
  * Enqueue a new transmit buffer onto the transport queue from which a NTB
  * payload will be transmitted.  This assumes that a lock is being held to
@@ -2404,12 +2415,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
-			     unsigned int len)
+			     unsigned int len, unsigned int meta)
 {
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || !len)
+	if (!qp || !len || meta > FIELD_MAX(DESC_META_MASK))
 		return -EINVAL;
 
 	if (!qp->link_is_up)
@@ -2427,7 +2438,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->cb_data = cb;
 	entry->buf = data;
 	entry->len = len;
-	entry->flags = 0;
+	entry->flags = FIELD_PREP(DESC_META_MASK, meta);
 	entry->errors = 0;
 	entry->tx_index = 0;
 
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 685dde629a48..2eafb53c2c8d 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -64,8 +64,9 @@ int ntb_transport_register_client_dev(char *device_name);
 void ntb_transport_unregister_client_dev(char *device_name);
 
 struct ntb_queue_handlers {
+	/* meta is 24-bit client metadata, zero from legacy peers. */
 	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
+			   void *data, int len, unsigned int meta);
 	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
 			   void *data, int len);
 	/* peer_caps is 31-bit, zero on link-down or without peer support. */
@@ -81,7 +82,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp);
 int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len);
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
-			     unsigned int len);
+			     unsigned int len, unsigned int meta);
 void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
 void ntb_transport_link_up(struct ntb_transport_qp *qp, u32 local_caps);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
-- 
2.51.0

