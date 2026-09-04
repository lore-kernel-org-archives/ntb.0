Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C2A41A766
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 05:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499308; cv=fail; b=bDSnq9antXT/qqwe8Bc4Zr4HOO1cDSEP7UMYdQ+zLm58Uju+SKiupSmGCwaj2zEkbLjXXQssya3DHwG41cknqdFErVGOpY+fx1AJzZGIjM/TZBRX3W763j5KRwBmKkX+C2yHbrkcFjcJSvVwB7OmjIPAAUhBlUtWEAwjfIiN3Pg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499308; c=relaxed/simple;
	bh=vhnQ8aYuLPxS3VV/DXkOfSNUafw8BOxewj5lzY++Kpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ahpr4W1hWTukPweF8qRtUvx0KQPUHd3CM7Zs+/G4vMH7I354gDr5uRBuskXq4RdESkngt8z4y7Cx401vKMOLSSg1A00M8yWMxQp5SU0TfvXBoQ28EXvgY9BuqNxbjEWo7EqxAynN3HQuW4j3PNzcTf5BonbEu8nTEATGepD0s30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Nc7RQ7wB; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Nc7RQ7wB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V9rcijvQ63rxCVxIl6xL578dimenf8d8PqF/QPhb46vYWoOEMQWLsBrAoFBXLkyUUKV4ZwmuqZAJWYmWIIXmwbW/oa/Vi17rQETSWqDuKQvl5Z928nLYz/4UV2FPRNEbiyLmMKsE/MLevA5Nx0JL+gFx+vR3sr6BgWOI7fSrwggOjclRZqDESbdrsMeAoxQ/dQoP7Vt1D+eUDXr63BAASYcs16YeAJF7jU5/wi9GABUD1kN8VFL/Yss7rH9euoK/1A/g4GD0JY3CsCiH66MEsjjMoYiUykKAK3Vuw4+9f7328cSuYdnztSLdP8dkmLdoDXb6pNqahSTV/sgJRgzAsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QABbSYfGHvAAeHitmHr0+IyTlvCuFawD12Zq6KyOoT8=;
 b=g/EGFVdIc4zMFlSCfLeIYdcl+ER8BdK8AAT0IuM1XFx5DH/WG8krS2NihM+dxAsgI20HU1qI3LJeSSd0qrmbrU8GjSts77qzEC9WPehSIBpcLl/kXf5sMHy70xAE3foT02gDSvDLdVFcfxADAEILD2rVbo5kvyXQ5fax1HiZPkjjelCZbR7p05biPHLzlYZn92YNM4y9Df11PJ8S05BOz6Q3p+Wh2IaSbAW3gN60ElBmLBlBqhx0Rany2Y7hYr0yJikkmAa6lcRf90D0T3NoXzVPnrZU+u09sSq6P3Z/VhwrnkZwt8soce3YjIa8pJRn4H2BExmHztntNc40Uoo92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QABbSYfGHvAAeHitmHr0+IyTlvCuFawD12Zq6KyOoT8=;
 b=Nc7RQ7wBXMfG2uYdjVdxX+p+BgOqBvaJpmYfWFwbnk2GT0F7NeakN9e/fkuAhBqkEpaeR/Pf8Mbkvinas+gbXOS1valQnBJzizic+Yq2eNC1Cmg7yc/dbYx3ZCbKHGO2qvgbcmDqUThk3CNW30Gqsx1ZgKfbjGbbvQFcgsSHiuo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB6378.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:339::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 05:21:38 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 05:21:38 +0000
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
Subject: [PATCH net-next v3 3/4] NTB: ntb_transport: Add per-payload client metadata
Date: Fri,  4 Sep 2026 14:21:33 +0900
Message-ID: <20260904052134.2970111-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260904052134.2970111-1-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0117.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 255fc232-0db3-4228-df1c-08df0a44658b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|6133799003|3023799007|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wzqT7BgNtLVmnSfSqgtL7Glwq30oO7+proiL67UDEG8YL6sQI/zWegueuYEuD5HfrrQ4eP/a+QRDLDlUVoHys389P5JwBMb4S44yuv2kqLaosjqwLkwQ+TpPzV2/UIF8ZgG1R/adCi6/yXWS/pQIh3lOAL27pMzD4dVPD3dfkwLwcFCt46rVlx/HThiHPK7KqiSU0NuzDx59rURilfBPSk6taMe9NSBTiBSYutNArd2Y23on5o4ejM4DKZZ2Ufg61cKXSNMcAbOk4YidxBP+WcNb+PVOW4BCfGWbX8KVsFyh5u0pwZr7BthzKdgVPZk/m4ORW7obtbeEArC/f9VaZRLAXXTR2rkHAgfx2P7b/ytfmi6O1JUyKskTq+epXc7tdeO6Z6XpxnNYDiHD+HdM0fBOH7ZbWEvEl/Xt8PxSkgzHTQlat0cVu82MB1uCXm1pX1E8FWjTQ8yfs/CaM9KtsJc9sIBXsxA/zi5+z+WoEGyFxJvHrsMDybZQ9mUjkGoXxBqCam4i3THTdEJJiFBih+fobcIg/KTiIRLEOjt5Yb14PqxxjEdtP+J2EarhlrSL8Wn0dYY/vavFFJqhY6qbiITUJgiMSwudn/pTh7lOFozeL03ek1/vvivAQHpbGKqitSqoSDbtOf267MaTEnOK3kb/Kp1M74nfnaQjAWCnyf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(6133799003)(3023799007)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DPk/3I/HA3G4liSpB9pil2waH57kngBZJhnaKNUnd1q7r/sdwRJ3H3KYFvDB?=
 =?us-ascii?Q?Au48cWFAn95CHf8+15h1SgeRHl/d/1KmNdB4yoxufDk28WyX1lnWl/oUsOHe?=
 =?us-ascii?Q?MhTJKyxZnfWldda0zQwP6wugmiulz8zMmZAAV4NO3LBZ+JSbG1VUL3Wqb3SA?=
 =?us-ascii?Q?YVpQB/Jm1xuYZId16HOBxm8scU7BLwmkfMz/EfOw6ZzHC2XuQyqV4+lR52l7?=
 =?us-ascii?Q?vFGTZ534scvmEv+CL/sbeu7PjqKaIEAwtip0OzCO8A0KR1YHokL0DP21IpnT?=
 =?us-ascii?Q?lRDnj2USyN00B5gwmAMuXfLuf5ZifZ+UdS/R2yr1vBFR8nsb7/MEIodxlMRH?=
 =?us-ascii?Q?lF760tWh/9DmXepOmrh6mhF7WkWHzOlLR3QSlOvmJRnWBjGIP0nzrD7DG3GZ?=
 =?us-ascii?Q?SNTemAB9C4DJb22GNTslfSfy2aZ07aarDRnYciwuNFADcMrc5CpbgCi5WWUU?=
 =?us-ascii?Q?VoQkxWmkdRQn987w5BuNkjCMvDG9l7v/yv+RnCp1z7n8uq5o75gfDNFzw9WI?=
 =?us-ascii?Q?e3kw8bvFN4Ihoix41em5ZzZzMMoRozNCMLFpUx24NmjuFQRnWmjBA2+mbXhe?=
 =?us-ascii?Q?ow2aDsxB0foCuGdoPxoHmORo/TRck/hTjFbiWs1uHEDbaQlUcGM8ouz/6+D4?=
 =?us-ascii?Q?KeRGtoxyUJwUOp9c9pnQjwYTITP55NzshqKPZGVeAVhIDudDYX4akt3IdS3g?=
 =?us-ascii?Q?rlQsDi8pMHivsiXeCjE+7sv7RhK+5sypuEXf+4/eAW7cqQbHTUnTYr+X00c1?=
 =?us-ascii?Q?HRDt50Rbr3TSVb8tLTQWxN+glxAkDfFhibtYMVBgSu4ctW4EXmyu4uBTrI96?=
 =?us-ascii?Q?VOjfikI2mbZzm6jy+AepMlmKNnuGVC1awabGh9lT35eQ00ksT67ANND6/MNC?=
 =?us-ascii?Q?L3iJatt4vUrXu65x0G3/0+pQhzwe6Pc95sBVNJk/nRx/OK/lNbyWRJLa2pLx?=
 =?us-ascii?Q?8GXDZNpztseY8gMCB2GJ7K+AYYBhKiS3hGAvUBf5gshCABGVlC2qhBFd5vt1?=
 =?us-ascii?Q?ftG930Y5KUf/I/fqfbOHtvdm5XtwTJwOnL9cIWDSLZ2gBKEO7RE1lUVuO3/2?=
 =?us-ascii?Q?OPKp5N6p0OROVOEPRRC1nmSxhigmrREyEdyestPvwL8e40eHIe2hBk89QRHz?=
 =?us-ascii?Q?5LBMmL9/v80p8aim6141kYEpFVAIJuqe8Jn3I/y/jbc1aN0RueBlOgmmNYoH?=
 =?us-ascii?Q?jO1ysfJWFvf30IeTtqkGVFk2EMLp/92JFQRdKdVkOl+UKv66MXZM3rKr3FVh?=
 =?us-ascii?Q?FDS0tSXK5BflALvuHbp0LWe551WJSdhHZsRHMCHcdcMWYnC/oetgwBlwv6hn?=
 =?us-ascii?Q?Q8qQS7mg16xstZdAv3OOb0y4eGCCz0fj2nDeGVYq9ehN1eoZXwtie3yuBPN2?=
 =?us-ascii?Q?b12TEbuAUyhaBHXCTlTrhc82I0+wWe4y2jTRDiKfozhyndYaKnsNuIGka8ou?=
 =?us-ascii?Q?qYjL1YuKP+U30i02QYcClVOYSQAqvIaqbgKGC30DMH8ltzgE2WbOw98Xfxuv?=
 =?us-ascii?Q?SBua97E6pQ9Jx18J+4mQd/k6dG2+Spt/FZ2RayVKsMh+w6pbxvz8lSSM3vPm?=
 =?us-ascii?Q?7VZW2yC0b5hAUChq1P20egf3ehir53HAr323Ez4zMlYFQEuZCWQaxXnrGoMK?=
 =?us-ascii?Q?uau9QNHg+buRbJZO681xHMsLAmy4gUX5PzEXYJWorNTbmYvhK3sDtfDODLSn?=
 =?us-ascii?Q?EKSo+Oc1gy0PP8+92AvBaSKZSet7wYIAxfoPDiFkQHCLNoqTenED/oarHqr6?=
 =?us-ascii?Q?SJF/IUe8Hd+Ecnxmjm084tXaQ/FO+5lCR8pBHobO8XrnNgmRGMZz?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 255fc232-0db3-4228-df1c-08df0a44658b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:21:38.8220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cg4ERNewltYmqlHajj0YTbzVYt8G2rgIpvc19gaHKFx43aYwkSLKENq496W+7tQ5CBIClYbtj9x9y33NAPa+SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6378

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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v3:
  - Add Dave's Reviewed-by tag.

 drivers/net/ntb_netdev.c      |  4 ++--
 drivers/ntb/ntb_transport.c   | 18 +++++++++++++-----
 include/linux/ntb_transport.h |  6 ++++--
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 2c04be6d61a8..d03cbda1637d 100644
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
@@ -278,7 +278,7 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
 		return NETDEV_TX_BUSY;
 
-	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
 	if (rc) {
 		if (rc == -EAGAIN || rc == -EBUSY) {
 			netif_stop_subqueue(ndev, q->qid);
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3f497a62673f..197376376bff 100644
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
@@ -2337,6 +2344,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
  * @cb: per buffer pointer for callback function to use
  * @data: pointer to data buffer that will be sent
  * @len: length of the data buffer
+ * @meta: client metadata to send with the buffer
  *
  * Enqueue a new transmit buffer onto the transport queue from which a NTB
  * payload will be transmitted.  This assumes that a lock is being held to
@@ -2345,12 +2353,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_rx_enqueue);
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
 
 	if (!qp->link_is_up)
@@ -2368,7 +2376,7 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
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

