Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D893A8FE9
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 06:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949380; cv=fail; b=WFoBu5AQ4hK3QY0juk4IYcnw1bC1zkhO3eESo82F5eLE6gIsyG9hXDX5STmCrbHwV6tcDSDrl/nj9c77kfxYhHoJ+0giN0BmEq7QLQzQ0tzdQmxBFLDn7crg2pQwpZzAjFVG+/v+PuVWfgdV3Rdnh2rSjMGL+Nqql8JpUPHsb+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949380; c=relaxed/simple;
	bh=mwP8TrVS4HXuTBkoDkjGOvt3xYn9sXPvYRYfJrMr068=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QaKvLmX7uuxMsBrr5nkVWwkDwKDZGWBHqnKEhP2ew+OHpgCBigNjrozZPxU6izWXJOHNNoRHmDAgaTt/CdZ5bmor7K5LDVw4ULd4DCQpIUoYADB7qrBqMOM6GhNIhpnJirmYiRVU2mPQd2hMAxp+SzAiTnvTun/r5lkhfbl2P0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OrnB7exg; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OrnB7exg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YrxgD7cTNDkX7cYLoqUFCiHcIJGc1BVe5w9JnE6NtMDJ5R5WYz67zx4Py/8EM5cS/wwTnB4AIQ6fyRdQp1njM6d4GwNZF9lzkdpPLLhuUMi6bMcjUpISJeITBqh74+oXGaOcQt9Yz/zNGIec8hT5OcYLV87MLPpUcQfWOGcRvhMiRffhVQZK1bRo82gqVclkrSC9s1sG9FOhn1AuQO9NQ15r/kEEHu3fm1d2ANg33WK2rHHbwQZxBZ5xmgOz5xO+dJ9k0r9FhukS3HpkxirZgrkD9Gn9LaFpTym9NdmY33bjecnCAzOjuZDI+f2mNpveQPoosFdndtGvKse08gkigQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zNESACeKbN/8Bj+b2HJ9wVuBKkiwBzWUuxpXajsl3HU=;
 b=K4wxcHi447B+XFSivtjDArzaxJ1nFThrypM2RcvTNxT0m8S7FSkHTalX8ThIbgINOL3VjmFlix1/C8bE5/NGz0RVlRGucdkUNDP/y+6g62UKzlDbM4r5+fxGZZLjAgfumLhJGTZ0nRJqrTRMvVCZnij1wAvA1TwKmVEfAnDZ5710mcY/eRYWULPXNsRrADOF190anxzB19nfn6LdE5dv2/ePEM4ndEaTxMiZONhPnA0OWFhJ3FjY6QCx0kczfyEQPS7Si8ttldsk5S9UtXjmVRmbCOMlyFLRrDUOIxgK82VEqeOxZTomnNXwS9nl7/7rj/uLb7wegAoWU5YZCNKKHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zNESACeKbN/8Bj+b2HJ9wVuBKkiwBzWUuxpXajsl3HU=;
 b=OrnB7exgmbyqnnH5db2uDhrodCnb7wRxGh3CayoM5kEskplBfKbMJUbgflMuULTt/3ts4UUqbKBf81rcvcrc/+cfVQISHAzTasUTm3eUJTUWf3RItfxG0aOiWy2MAcuPqcjGhmfMluWhskxnD3nvApKCyhDY1NC5OhXHFE4NwjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3805.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:49:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:49:25 +0000
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
Subject: [PATCH net-next v2 3/4] NTB: ntb_transport: Add per-payload client metadata
Date: Mon, 17 Aug 2026 15:49:15 +0900
Message-ID: <20260817064916.13278-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817064916.13278-1-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0163.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: ee61d75c-7352-4c1f-0185-08defc2bad51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|18002099003|22082099003|56012099006|3023799007|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info:
	p3CjqglfBm2itdsMUVp9k7vnnOULCukV6nCs1osVwz4YCGRUqIz6na69HNK7jvOg6OHG7MSuKiLZ0a92XWXnQk4l0fE5Me7vQ2NdU3iunBMrtyaldZsJzdqq/YFs0931c0jg88QgRinpCVyLsfZgYswc0wEwPuA2sC4QR/3+454PC/aPr2H6Q2skAf/OyP3i1VaRcUd4hbNsR/Vs35t9Mcozbanyy8H0AY7vAt5ZVJelD1U7uhU/oNP5Jcgvaw+zM4A5DZcmHfqySaUdiiQXp7ZyKAy/Xr6I9Jo3cgTrWXZPV0OrJ6PgH9OgHppvJWnlcQJn6luFvAcXlOCBoT8xI4aXuM50mZ/yMuXKzrSPUcqACL/jhq8sCp2RwyQGiD1TAAk/qCQKFOCsF+Mjin3NyP/TuzBFonLOZmhdw8CyvwMFsN9tRbWKNU2vaSuov+YiX57olj5C1qbfG47YCl/k323QaUQ1t6SOp6kKU7ciAQZOIvIGbilQWB9mqtN5J+WbsnpSXY57bCRSib1CkzXkaaDL3XPEAd3dVLGLggZKdwdakM+dPOo0X0fdCwUB9c2JrPyDExuZRySHVzpQEJhD5fixxVf1Fbp3eeSt8f4CzrI0abiYZm2kNOMzKEuRIr8sk3j83jaoKK5B83mJyhQNYeAV1g/Kxd1qv/32N4dIg6k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(22082099003)(56012099006)(3023799007)(6133799003)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AUhu90Z/AacYIT+OJfZElYTezXgLcpuMX8yFDIgh9Rw5f3NdEefQJxPjvjlH?=
 =?us-ascii?Q?lBUWmasKuDCcaHfiXugRMJb40Lph9eY5s9WlvjJ48Orlsr9gvomL/loOutqZ?=
 =?us-ascii?Q?hMMUgmaOY85OeF+3KkUuElRBi6V2YPbw/a12h3MYIkompOFNQ/lGkOgO+WZk?=
 =?us-ascii?Q?kjUz4FZWlBxII0NtmUBaFKN2T9FeODywwUqjUbMqCYXhJkK0PqeF19Ibkrtd?=
 =?us-ascii?Q?FRiL69FDqXlMDhHwvyEoTWa2vgi6f9zgMBsQ+CitcUtSwAYk5ffay7pDpHKN?=
 =?us-ascii?Q?yKck6XyZGdnzrq/cn/23u8yMwqJhOuQXrWt7p+Pfq9kzX32Gg36WNqvpNUEK?=
 =?us-ascii?Q?xfKP5zr1ltCc8AFVsPh25AnLD/CA+hTyHtYKD/KLHFrnb7qHEdfWD5qL+2V5?=
 =?us-ascii?Q?e7tbJnbqMwmq9o4LDLVmrf81QxOTiZGsq3W6VvZXo5xvsEIjM7E4pTU9hYx7?=
 =?us-ascii?Q?fc2uYOH7aNqyLBHRBg0qUxnFNftx44ZyUVOmlslkRNNPU/gXim83rMfu/+9H?=
 =?us-ascii?Q?h0RsXqxXPnIBnC8umj8WaQaga6dcaDGSYItt2oYmEg/2hLpeO+mUE7slLXeF?=
 =?us-ascii?Q?8yP1s3pLSrSrFiEioxk676pezFxRGeiHrWaAo86/NJ0u4xq7xbTm2JmdnTme?=
 =?us-ascii?Q?Lw7fmVsHTJhNpXbvL7plDtMp4B5m4yCwW4DcCoE5n+f3Kxoqgg+yW56WqH6u?=
 =?us-ascii?Q?sm2obkp9q4fUORsRvP7dHxkL+SpzyBz9FedAi9Qpw8/XQO0tNF7cLO471uxB?=
 =?us-ascii?Q?9E5GkQiyzMskdGXOyxCPH+y6tX8KftuKtwHIjK89qV9c+zweM39uY017Ofgh?=
 =?us-ascii?Q?4PAW1vAUUGfT54IkdtosECwfQCGbxZr9t6WhZrfFd187zR2JKKeajhXC69gb?=
 =?us-ascii?Q?Pxznjlez6iMeNveW/sWx2Ede2TGDnaT5vZyUOb/TSa5m+fa9hBpVtdbanwOx?=
 =?us-ascii?Q?leq9D5x7XaVO38YLkQWERry6iqYxyrE7xPIZUs39BLJasH6mxOCq/7gRBsqW?=
 =?us-ascii?Q?z871ZJXjJclS77vLrTU9B8v2pUSDwP6fHa7NObR189nZd6kIRmmCj6oCppUi?=
 =?us-ascii?Q?HTgFgs9n1pcwDnHxtAOkP2gKzylHQFrCCLuLOq1K+IagPP654FyeJmEDDxPf?=
 =?us-ascii?Q?9IwZrbINEteyUMQarRmm/xpdCY0t/BRZrawP8UEpZCKSBx0/EyVsdKpkGqMG?=
 =?us-ascii?Q?9aXT10UVuZ5f1xUMYWK0ReTpnAFMfEHs7TISn48b82hdSRt+jz/Pil0muT56?=
 =?us-ascii?Q?SGNmP+68KUHHJksHbFIxEWnikN/Mc3F3om0up2HFVLf5uTCgst5IIa3jVwtB?=
 =?us-ascii?Q?qHhAsbKEU7HZ5yJtg3l//V6Hi/EXvxfaFgwVYE+7lRQh3FdVqsnHMCRLFVCk?=
 =?us-ascii?Q?74xkXa5FBdO6D6l94W+Xfh6pT6zWFwFPJr/rdZPh6aZVZDSPCm/JUbnDOGok?=
 =?us-ascii?Q?eVpbXwrIUhShcn2P9YzLH1pAlPRmZZRaxmEEeDAPymNBN26mHfOHqFVw6PXd?=
 =?us-ascii?Q?yK4TMiUe4NdWeaIqXxf/3/b/xAgsBGMd6tq4BpSfWpvLiLNOUXmqtf6XQYJr?=
 =?us-ascii?Q?X4Bkdld6XG9X/J4vj9W6w/11j+SSLXWiFXyVltx2KtGNzqq4PhsUHL0+UIsw?=
 =?us-ascii?Q?LwwKFIHC6rNYiOPkYcVBP1aHaMeynaPdIrNuAbusR0khACnujrFzGyZimFNn?=
 =?us-ascii?Q?fZZiZcSGb9vF3/q1R0XbfuRBtu7hjkRtJMYzrI5E3j/6A+9950746/NGIbRi?=
 =?us-ascii?Q?o3ODxKVJeJwGSEeU+fTVoqzp3dSIvDwgKidOaHO7OEr94cmsfvJy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ee61d75c-7352-4c1f-0185-08defc2bad51
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:49:25.5561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d0G0k/BIIkuraIAZusPv/rx+3Yr4lXhSIcnv4tb+aKpsEgie33CYwrssKAh/CAOITv4rR0wLaaojnrRZWTb7ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3805

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
Changes in v2:
  - No changes.

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
index 967a5ad38164..70be06a42201 100644
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
 	__le32 ver;
 	__le32 len;
@@ -1436,6 +1440,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 	struct ntb_queue_entry *entry;
 	void *cb_data;
 	unsigned int len;
+	unsigned int meta;
 	unsigned long irqflags;
 
 	spin_lock_irqsave(&qp->ntb_rx_q_lock, irqflags);
@@ -1451,13 +1456,14 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 
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
@@ -1656,6 +1662,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 
 	entry->rx_hdr = hdr;
 	entry->rx_index = qp->rx_index;
+	entry->flags = flags & DESC_META_MASK;
 
 	if (len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
@@ -2341,6 +2348,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
  * @cb: per buffer pointer for callback function to use
  * @data: pointer to data buffer that will be sent
  * @len: length of the data buffer
+ * @meta: client metadata to send with the buffer
  *
  * Enqueue a new transmit buffer onto the transport queue from which a NTB
  * payload will be transmitted.  This assumes that a lock is being held to
@@ -2349,12 +2357,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
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
@@ -2370,7 +2378,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
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

