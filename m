Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C42C3D75D3
	for <ntb@lists.linux.dev>; Fri, 14 Aug 2026 03:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786678164; cv=fail; b=rhW0XasgYID9Fvg5ttdZBNKCOUB66WZCjBHPDSB4aFtLi5S9ZY4tOFxDyYiQm26CWjJEoILMutKfFarlMivkTYJ39YTUlQlCWAm6z8tfq02M7WWnfmmZ7kxfjznHLIzhOY+GEt/nk/NXJ8MhjGvNWcWH/kRMvFZwUuRkszeLTvY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786678164; c=relaxed/simple;
	bh=D77YFvYsA9N+57eS7bBESy0Pgbs5n6zuL2svsvugaE4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aN1ABC/CAlNAl69AZn+L8M3SKAci6F+jwbsIJ3oMLV7Lh8KcyBamAcMf0INJyhwTog9IXicQValh7V26mFlCUwwE2Xr322LeA9DUAKvXF3beKDJO4nN/etwjSiMhhsibiqKO+zTdwS6Gy0MLcuYFtyiSqzzmWVuhI+DHRm18g7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SMoi85bj; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SMoi85bj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OM8TZgtAjbpEl0wkiF8gf4ORI1mwbyCwssMNJ10z1Vv3N+XjgVfRQblpUjE3CyK2TZAAfbZJ8D0rrW1UrFJ5Ac7vUE3xN8YlS58Kkf2pTWA5nP5NfgfOqmhiK4hD0l+DrHp4GBvd85upAojSMzkT3pU1b9qSg8s1+asBdvhbv1o/bv3N8WGVFAJUVxHNKN+C2JtF4eabRzqCw50XLq5AiOY3IG5LMwwKWNFcJ2fRYOU1yVxYslKK7vcF41sOWR7VZj9o840cUplFjBkwQzW6DhuN2T2qZ4X3akWRqaMTramKek7qIr2IA/G9K7Y73B51Ec3kryIoNNFzcrdCz+ehpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X97anQGZOkM28gNiEvuNie9VnRB4GFXp4NaHPwGnX6w=;
 b=dkuPdqUPs2f6ZVXoN2AXMwKpAB53Bm0skc3xTKyXvPN63JDV/JVPwlFYxzewWSwhdcjnFfeeKg8ndV3NhzB9NLrjJUkGj5PB7kxFrZVu0qtxuuavUeowHaML9Ba3UpuKG1F8Lj+NxIUenFUyqZtkK93JI67btJRNYhZ4ZqbmvmZk/dXlDG0h3EqwPoOXzsRcjQGHNVJ6eamAPr6AU/totjv5IVPE7+S+yho4yhIbCR17rGYom+aqK9HVWqma4KOH5XXuLA37gIeRbzjhlH1muym949V/NpG/vZL8rJe0jIbB9DP+r80OGsJ1dPBeVDIaQOsNJdSm/1fErIBp8W/c2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X97anQGZOkM28gNiEvuNie9VnRB4GFXp4NaHPwGnX6w=;
 b=SMoi85bjvDylv5NIhzMak5c3KM0sWChcV4X71e94hoLHtppHODbtjZrwhbc4i6yxXGNTSdssPkAh5zCJjoL2fdwIi+k9DpcDH1xRUvnJyevMz9NEf36ZDmowE41Sd+1pfto0UMNyfbZTtsmvTRD0BRiHyyz8YH+ibM9by2J/NK8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7404.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 03:29:17 +0000
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
Subject: [PATCH net-next 1/2] NTB: ntb_transport: Add per-payload client metadata
Date: Fri, 14 Aug 2026 12:29:12 +0900
Message-ID: <20260814032913.3558500-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260814032913.3558500-1-den@valinux.co.jp>
References: <20260814032913.3558500-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0060.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b5::15) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: db7f36b8-5b91-452a-b200-08def9b4386e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10070799003|7416014|3023799007|6133799003|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	u+D1EGWONnuxxqIWBG2kTANpxmg+LHpbBgc4VBQ7u+bndGglG/H0xVQvpQvab4lqm7oDTFHLqS4LLc3FTQDmL0OX6xkbl9d3ol8JCFMcGy2hmAfDN1JKeuA9tTCKz5eh2JO3eXRtYeUYKqrMYqwrfF8drVvQTWOzoF6KTXQx8IqgANQlGL/+IV0rUdC598Wyey3I//3o+aNDgfM1tAbnOwYUkZIJZjs+ssoYuwN/hTLpSz0OUaB83aSYzY+SgGDMTCAHFMnTXg/tag1DEWXgTzBOVYZUvBMaYA3OaZd1iVlDCx+V0i41tIPtKbbviDZmUK9cnj+JYEFljbmDELPvghOTQrRG7gAuXZjOBoGwNGfVEKoCJ8hhbjdzOR/5yE4zjTDE9JvB7U7oAZ/pNV0MO7hIQePWqyo4geRPtqBe5FYZ4yjo4db0h1fPd/AYxqNjnVBsjJPehp2hIi12sRB5n/EEjxqcPRtM7m6Oahw4HD9MP8rROrdEx1UcKbeIGESGazjXR10sfRDEeJgchE+jf7TvEXNjGE2jv6BtNakA7+iIqhH2KWM5wa5fqeqJWYw0uEyvkfg4M0DMC6mdooj9sqjzmT3FlCRH76vpvmnUHGq+lZs3rApfCxrgqnXuB3pKHGzeeqoyCec5G6taHNB3EkFxnCWxDeJX5fDE3DQ+8/0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(7416014)(3023799007)(6133799003)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uLamIEEIRE+D8OKse06XUyRI0+rXVHygEMTDUt2j2yQw+y+tcSfipQ/BlR3E?=
 =?us-ascii?Q?q84EQcrSexPeDJQ3yEOD3K+nC6gM6kIgV7ujxBa3zpBnzQuI/f11gGpk5HN5?=
 =?us-ascii?Q?YiCZNn9cpTXiGiZj1iWRKJRjKkOqQNA8Ty8UVLEnbKmXnQ8Qityi3XWLeCbG?=
 =?us-ascii?Q?djIHNyzIQ1D/OrDiDCh/9nQwUOqloOUvSGWbtnuLNSTenuOlYOdM0PMrixY9?=
 =?us-ascii?Q?NOKs2JUSGELozdyHZ8CAIUnyj9t/JaGVxXx7ZMP00ApWu8cyXrXYL94unQD5?=
 =?us-ascii?Q?mxNaF9m/YYQoOilunev0yPsDkB7VON+R71Yr0syvLuaJNq40sn6wCe6/bFc5?=
 =?us-ascii?Q?bGduTaWUeRQHB6xBTnChWOB7Dvm5DY0rzpbMqiDheyDziZrQ+iFRDb9D33nG?=
 =?us-ascii?Q?g/WrPJV9Jb4oGCRmgRbo/2y6+2FtfRlWbE/r0MUdzNCbAWKP0uhihJixAO/H?=
 =?us-ascii?Q?obJWB6X5UrqvOhnGDvyoTdM8avU2UJR/Sp186bN/BbE2a7gG6kOK5mbvJzro?=
 =?us-ascii?Q?53/zj+8VDZx3MhFr/eymlKuVtloub/PnK0KKb09il+Flx2owHQ+EakgiHZks?=
 =?us-ascii?Q?3WwHVrXROCe+nX7oxkRmrZtckxeWsGVJCS65MhyRWQWudHghqz7srGBMzYdw?=
 =?us-ascii?Q?IysCYAgFZqj3+iulupw4eES5PUR1+l2wT8Oh7LLGSv3UieZD5uP6MbgCV9SA?=
 =?us-ascii?Q?oeQsjoEJ2C2XfAfm0Osg5A79c+UzBCH5Xv6nDqfzba5Qrco8u3s4ZYp3EeBJ?=
 =?us-ascii?Q?rSnQXo8h35bI/BtvASdva4Mh6BJ3aNZGMz71HLEo/sXGzcWz9UuizQZZoJ3N?=
 =?us-ascii?Q?5wHamVsloibuBA8DK48yGo9Fgt8Dn86nhbht948T7vMUKbGhMVQplFcf7Fxc?=
 =?us-ascii?Q?heZS652eZgFaU9u3RtCvUYvr/81dQ6J5YaBqefh2H1BfRTTdCvv2Np1Fpqom?=
 =?us-ascii?Q?n0GRXqunz6L0rjXGRJbOjfa3b/6TG8NKjmTYP5CcUonuHxdhjOwFZgqxoCJa?=
 =?us-ascii?Q?I5CH7Y3dx50pj3MPbsTlzrTldGJfzfm45U83IZTpvSA1gBtBz/c52ows3YVN?=
 =?us-ascii?Q?DX1srGh5lEBdZalCe9gtVUwAwgNjgK4mOHimDnpz8nhd3bEPR2WFzZA4s+rN?=
 =?us-ascii?Q?7Ssh4lsJHnNudhW27BywF4cwfQBpxOYz96TOXwENKSgmanLVIWF61rXhkhVr?=
 =?us-ascii?Q?ntXfBa6SZD/FznPFuh6ZTzhPZ9znXpWs2rUHDEfaIsGTSxSii3Lon6+YK0It?=
 =?us-ascii?Q?E9HKyWsFUqwPn7vQFdcFOPgMb/oes7avyfwoLwgS2Qs6Jh6OgqhBrefJBFp8?=
 =?us-ascii?Q?4WoaDTWbtbJzQQjNmtQdISV5EkVww5s6/MstGkGxelS3zm488c06mivz4nTC?=
 =?us-ascii?Q?Mo4ugFu3qCVDutIYhiolnwtZqw9H1AjozxWzz9xcstI2bPslqz/ulm7Abu51?=
 =?us-ascii?Q?3ojNkm6iCIA/06/b7c77nyhsd7V1KFDkBCIo/+QUO2nghqGA8Iy5smpE7I6l?=
 =?us-ascii?Q?QSh2YC3ajfndDAjS6NItsC3XV2CWxp4s/IHqmN0vHa0IPL2QkhazTIGT67Co?=
 =?us-ascii?Q?gwjJZKbahMAZwmpn+pOfbt6L/fkAiS10IkyNgnkwiZZTnRqoCi3eHDR/e/uT?=
 =?us-ascii?Q?ZDFAo73UInRhg/aKp1gVklanZh1oGLHJ58lq4mvspMSDApyeTRGXpbr7ycNl?=
 =?us-ascii?Q?DniHhcJyv+/m2K/YocE0Vaptv2ssVh8umOT6nPov4NL1nP9Hx88OqFNOjiAw?=
 =?us-ascii?Q?YSvXHSWSGCv93LxHaOrG7aF01p5DQ1MTQGteFbn1z1EefQ08OCbN?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: db7f36b8-5b91-452a-b200-08def9b4386e
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:29:17.0561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +t5rv5N3cCErjxT/0WT0ZPQey8dL+gQyMof0Om/MfROElbswPx+CL3xxRrUpPm8xYibYV3IcpO0uVyBL1oMDQA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7404

ntb_transport currently carries only payload bytes, with no way for clients
to associate metadata with an individual payload.

The payload header has a 32-bit flags field, with only BIT(0) and BIT(1) in
use. Carry opaque client metadata in the upper 24 bits. Expose it through
the transmit enqueue interface and receive callback. Reject values that do
not fit. Keep the low byte for transport flags so future flags can continue
from BIT(2).

No protocol version bump is needed. Existing Linux version 4 peers ignore
the upper bits on receive and always transmit them as zero.

Adapt ntb_netdev to the new interfaces without using metadata.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c      |  4 ++--
 drivers/ntb/ntb_transport.c   | 18 +++++++++++++-----
 include/linux/ntb_transport.h |  6 ++++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 029a4a532a10..5c7fe6883cb9 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -123,7 +123,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up)
 }
 
 static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
-				  void *data, int len)
+				  void *data, int len, unsigned int meta)
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
@@ -258,7 +258,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
 
-	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
 	if (rc)
 		goto err;
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f59f926d4bfa..ea97460c118a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -167,7 +167,7 @@ struct ntb_transport_qp {
 	unsigned int tx_max_frame;
 
 	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
+			   void *data, int len, unsigned int meta);
 	struct list_head rx_post_q;
 	struct list_head rx_pend_q;
 	struct list_head rx_free_q;
@@ -264,6 +264,10 @@ enum {
 	LINK_DOWN_FLAG = BIT(1),
 };
 
+/* Reserve the low byte for transport flags. */
+#define DESC_META_SHIFT		8
+#define DESC_META_MASK		(~0U << DESC_META_SHIFT)
+
 struct ntb_payload_header {
 	unsigned int ver;
 	unsigned int len;
@@ -1435,6 +1439,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 	struct ntb_queue_entry *entry;
 	void *cb_data;
 	unsigned int len;
+	unsigned int meta;
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
@@ -1450,13 +1455,14 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 
 		cb_data = entry->cb_data;
 		len = entry->len;
+		meta = entry->flags >> DESC_META_SHIFT;
 
 		list_move_tail(&entry->entry, &qp->rx_free_q);
 
 		spin_unlock_irqrestore(&qp->ntb_rx_q_lock, irqflags);
 
 		if (qp->rx_handler && qp->client_ready)
-			qp->rx_handler(qp, qp->cb_data, cb_data, len);
+			qp->rx_handler(qp, qp->cb_data, cb_data, len, meta);
 
 		spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
 	}
@@ -1647,6 +1653,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 
 	entry->rx_hdr = hdr;
 	entry->rx_index = qp->rx_index;
+	entry->flags = hdr->flags & DESC_META_MASK;
 
 	if (hdr->len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
@@ -2332,6 +2339,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
  * @cb: per buffer pointer for callback function to use
  * @data: pointer to data buffer that will be sent
  * @len: length of the data buffer
+ * @meta: client metadata to send with the buffer
  *
  * Enqueue a new transmit buffer onto the transport queue from which a NTB
  * payload will be transmitted.  This assumes that a lock is being held to
@@ -2340,12 +2348,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
  * RETURNS: An appropriate -ERRNO error value on error, or zero for success.
  */
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
-			     unsigned int len)
+			     unsigned int len, unsigned int meta)
 {
 	struct ntb_queue_entry *entry;
 	int rc;
 
-	if (!qp || !len)
+	if (!qp || !len || meta > NTB_TRANSPORT_MAX_META)
 		return -EINVAL;
 
 	/* If the qp link is down already, just ignore. */
@@ -2361,7 +2369,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->cb_data = cb;
 	entry->buf = data;
 	entry->len = len;
-	entry->flags = 0;
+	entry->flags = meta << DESC_META_SHIFT;
 	entry->errors = 0;
 	entry->tx_index = 0;
 
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 7243eb98a722..9e807542b6c4 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -50,6 +50,8 @@
 
 struct ntb_transport_qp;
 
+#define NTB_TRANSPORT_MAX_META	0x00ffffffU
+
 struct ntb_transport_client {
 	struct device_driver driver;
 	int (*probe)(struct device *client_dev);
@@ -63,7 +65,7 @@ void ntb_transport_unregister_client_dev(char *device_name);
 
 struct ntb_queue_handlers {
 	void (*rx_handler)(struct ntb_transport_qp *qp, void *qp_data,
-			   void *data, int len);
+			   void *data, int len, unsigned int meta);
 	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
 			   void *data, int len);
 	void (*event_handler)(void *data, int status);
@@ -78,7 +80,7 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp);
 int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len);
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
-			     unsigned int len);
+			     unsigned int len, unsigned int meta);
 void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
 void ntb_transport_link_up(struct ntb_transport_qp *qp);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
-- 
2.51.0

