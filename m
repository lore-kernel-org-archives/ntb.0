Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020114.outbound.protection.outlook.com [52.101.228.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140C41D64A
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.114
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375742; cv=fail; b=H3T5FSkNYMFX5rW0M1QCLi5l+UXtNaP/9RUb+FZOjPE7c2RS7HGeuiWUgQccuV6hGLGfE3sLViu5qkTlTcXN6wY8/wG0wH5gXRnami+3doOYPf26yMEPy5bJQ/TxtwRacboAN+RAHbmXITkizGeO1K5P1WwDU0EXjC/GC+ZSX+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375742; c=relaxed/simple;
	bh=YkY0srYcp59bnppwGfL9A8b6JRrnWxEUr9bdnmI8y60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nhg3+S+bVwSC3DjhTvzrR2ych+vOSPaLQQRobMQWWzTJQzblH/w61I4AFT6vfbaI6HaQcW9GSKwn2kELxb7Yl7WScovkpdHM//HmeFrRTGbZW771gLNP2xJi3RAVOprSnK3xwovUbWgpG3maVz2tuZMkNhAfE7ecSItK2CQZH5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X+XOzwEP; arc=fail smtp.client-ip=52.101.228.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X+XOzwEP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZMl6HB7HoRZTtYvB/PQq+PhJNI+j03h8zLfVtNxoKj/jIe3+eS9jf2pxBF66nhQ/41m6HPtu3HYDkB9CT6Rg92SuITH6Kj+S94dbjnETP6gKjmrACNXdrVD6znUPVjGYY2ph3KDHuxTGzgLLF3LwiijxHphExq8yjHjrcSFz2Mrb6IbzRwuUQfr1C8rpZ1hb0mquiMdwOF2/A/Av0aGLrDMK1DfU/V7EQ+WiBv+LcKn0NsgOyq2M6JXi+lvlrP7M8AFRYqGMCgxGQzHBeWt1MZ/S1rp3XzjWcI9wMvTrYUUFSSSfmAvErbBtMPdx7OoxlZgqPPLoY1N+VebC1B47mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6j3CPzGkE30anSD7SwfsUj4ESx+O95eIBF+5SAoDaU=;
 b=xFGIXZSEIt0rcL0aM5rp563DFCtGqwAce4dC4wLkSYh3B5VTOvK3dzZiRRxsjwyWGRnmFCYdkGRRqIKxFcLZX6QKWhYLS6jMyXBmDo9dRqAJcScq3b1QAH+TRex0hy0978YWPq40adCGv6cvomcsawyfcMm49BFbkGaXQXc7SAqzA93wvkFUBWzlos76KPPxQIjJVZEdBrzyYihAQiMjQFkmNdrx3Peb8UEQ0xX2G/99ZYvLTyR20FrEQXv9HH4YghyqlQda3VkqZC5s9/nUEeId2xKqsbQWICU94weeHUG2ilFg+EarzYkmFMFzs+3sP1PSS1ldz99j8jIlx/QsBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6j3CPzGkE30anSD7SwfsUj4ESx+O95eIBF+5SAoDaU=;
 b=X+XOzwEPtpJYGrCOFVvpYjsy3xQ0o/Bmh1+UfXB2N/eEDLKMB/1cz3asgolYSilkyOr4tx1z7cvZuJrtxk5+V/4sgB7CgZcy/VX3agKCtT3BSJKg+J+k+LkcKNcIPOZazWjUYCFF4idLUQNQeNg8h6LZXYBuJVkhbc9HSaQK6EI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TYTP286MB4022.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:188::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:51 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:51 +0000
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
Subject: [PATCH net-next v4 10/10] net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB
Date: Mon, 14 Sep 2026 17:48:38 +0900
Message-ID: <20260914084838.2158249-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0294.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c8::6) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TYTP286MB4022:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d32fb6f-f512-4922-9408-08df123d0023
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|3023799007|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	53/EryD23DqDNXtAGdsLBLNtyi2qzcu0AuODDyVbyBj/IGWGWJRs/QoMsve0/9S+l9hJJDA9KWlnZ+G8zDHqZCH5yQIVKnFXzveHXkoTmNDfbOLMyxUNofpjKkXa7gnduaJUFRiDJZjtze4ESZdb8xKXKo2E0Xt4aDyA+GdKZQwH+M9XvpUIJN2iJ1G/JgqHQdPAYBokzkypB3DnuIXa3U7TE33233UvOgRJzHJNIJsrNtBiK2wqFG+jhJV08c1/olDEJ/D6G1SO8kmCZO/FiLJyJR3F4EPFLz+gjdFsY+2KdQ9vIaF7//O0IU4CBlpl6juU1/w0S7pnIsLfDPe+vueEbhmaR7dMfGy2f1JjOqoJat6Ghn3CoI97Ud5PUC1I4i79ae9TZNt9WjijdWRtlTHs4uGVM5clvtKrZJ3xsuaeR2QZAvuAZfqL8qtYVjez/eO97J+s0fVSd6p9o2mV7iC1VbndNZ3bo8PoMbcFpRbm1xCNPOwuEg3pOzJC8shc46D8SzhJeo7Xa/mV2MP9fOysC9Do87Oj38eD+mLNxSMGVcS7/Cbv+W4wFJ8JAMpaYJ+Uw/rYnzeWmg1K+qBTItBWpIBorKCcOE1+9/diSAxb6sx1riYgtH02PCgHt4eyCxsLe5CaVnMbJFVBjzuqw7LPGFfS0YQxxDeX/lh6zPw=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(3023799007)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YjwiTdaXkOPYuVTVUff31+/+Jh5PY8E3KrGN1JR0rFGKAXJjMr1r9gDDhC+Q?=
 =?us-ascii?Q?niW4+kZz0tunu8Zxl7/OcTYblTZ/JqWboKZRZTPJ7t9eUvOKOmXg67qMox7p?=
 =?us-ascii?Q?Zr4wXqqWsgHF1Zm/0ihmcVXsG7/iuZg6UQcWzqLuTIDlVY7P0/9FkDv/Wimw?=
 =?us-ascii?Q?9MgrS2Q4m619lIs4RKEPSpohMH7uh6IPlvCYtPlOKhBaff6LWslSSf0ngWXz?=
 =?us-ascii?Q?++726g33X18oxuR9EatPK81jcFmrjOPU1kSyC7+NVprcRikzPb8T+x+u08gM?=
 =?us-ascii?Q?6KkBpElViXbjZ4ucD0XG+2+nXA0AT5kNjbAbmqt4emJcKG/ypouktGHdaQ7l?=
 =?us-ascii?Q?HgxlK0Fkm/AFjGqwPji0bSKRwdWzx66Z147mHuavsaughI7gPrfhSHACBETW?=
 =?us-ascii?Q?d2Qm/6LYfNncmCyfajEAgXNn55ilUL90ubLDzK+Cpsgn5Vn3S8JWyYrsw3kl?=
 =?us-ascii?Q?paKM7k0jLcolGibVCMebYfS54ZzEe+DP8dvzWc4bHaJETU2BXaxrl43FE98D?=
 =?us-ascii?Q?aQPV+rzPbeSlml+ycop0Rxt/8znMBkjfVTmq+VCzyvS/Ze2gNUIZtg2x/uUy?=
 =?us-ascii?Q?OyGSbbXqA2vFxxCIweHDQmZPDZISc3BEX7at+sR7sn0ej6DiGwPrCKvCjCkD?=
 =?us-ascii?Q?qQaAdrjQUJ9BdWfVPoc0+1jCljjZg+D1QUbZ2mD5+cXbgPI9FuScDFJaOpnQ?=
 =?us-ascii?Q?FRDnGZUyyB/zdYJJT7ymBW6r+TejIbJ8rcakhWpWk0dkQVjJQarGxzbXYDtO?=
 =?us-ascii?Q?DFYFn3cHzbAx5b/WZiFL0933TFBaP/iQi18KMghyGd+0uaqyCI+0/T5qD6LW?=
 =?us-ascii?Q?XLY+EnVupRq/2TNrmrmEpQg6S3+jx88K9y44bN2NFtVhH7x5y/bEE38jeu/X?=
 =?us-ascii?Q?nTTeaiv8YVn4Ib9MWn9FBX/DzHOHy6EivbGzXEU/ZHApdjJXSe+ahnU3ihE+?=
 =?us-ascii?Q?U2p42I0+93s4gq8V7XDvnTWGemIHDXoIABY4aCV9ujUoOQYjYkETxKYd8gWu?=
 =?us-ascii?Q?E64OZK3wXA4quacRQd5+tlnANdyNnKcrfjAqO9PMRJLEYmYslcvVLrRzBNk/?=
 =?us-ascii?Q?RbxWGB+8utYsPgav2K0hPypfZ5uWFQC0ohG65YoA4HXZ8gHDtavz9jBQH0xw?=
 =?us-ascii?Q?o4CCbuHBj/B+nmLt0jpfgACsPBbTqyIiK9KoIDpo23QqrZLlyhz8OGEhTknk?=
 =?us-ascii?Q?lt3m2pAzlnFbe4ywHk/3u0/HihRJ3SonXvQs6hMIYQBKwVuru2glNihNVsDx?=
 =?us-ascii?Q?Qsg++l/MSED2VR9RJzzrd6ypSI/zNO+kdS6xx4Nlpfj8mbVwAboFeQLeZbMK?=
 =?us-ascii?Q?3ObiLgkoZL0vdYGraJ19QpsdjL6C0GujE2kYC5zQopjpc0rmukQvn8v2f7Yf?=
 =?us-ascii?Q?xe9bKHGj4YVdsldn+x2UQ+HeB8PwN+aH1GJGL3bP1Mo0jQjUbKrfSZkLnqJd?=
 =?us-ascii?Q?CxaJYMauiXuFsoz1iszmyBXUhFE0/uK7e2bJBcqlRQzl5LLoqFkJZBMqzprG?=
 =?us-ascii?Q?BZItP5U3dTLez5hsVejkIIgK2jbdqlvsxuLrKG1ZEt4NUapLUYxQtj+7RJMB?=
 =?us-ascii?Q?LXda2grIXFO0qtBSB2wqnUsZU61rHfT+JImvsuMzcr/Uq3sVRQZ9oVkBManG?=
 =?us-ascii?Q?n0lh92qz2eOMd9XUm+ctucrxjtrwBdjDO3Q/2nX0XDasRzjpmatbqBCYSpJE?=
 =?us-ascii?Q?r5D7NKccgM0IvT78IYtPV0k5+TvHCNG7aVpZFa6JxbbuKjJecU4j4OkBDPYj?=
 =?us-ascii?Q?cZOlsmSE5/HPpcDCYSDxUWj1ThBnySi+upUVN0G8wa850NRPQ8Te?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d32fb6f-f512-4922-9408-08df123d0023
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:51.5761
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4AR2FppQdYqgvQ6Sen2D/mK+8OVMGSk2DllaEJxyp/ikcgHAMm0wTuDbdEZS/XDJi0XccKwP4cONh/8Y4zLKOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYTP286MB4022

Calculating L4 checksums can limit ntb_netdev throughput especially on
embedded systems, where CPU resources are often limited. On a trusted PCIe
fabric, we can skip that work.

Use the optional ntb_netdev header to carry CHECKSUM_PARTIAL with its
csum_start and csum_offset.

Exchange receive support at QP link-up and fall back to software if the
peer does not advertise it. This preserves netdev checksum semantics and
interoperability with existing transport version 4 peers.

Keep NETIF_F_RXCSUM unchanged while the interface is up so peers can
rely on the negotiated receive support. Drop partial-checksum frames
when it is disabled.

Leave the TX and RX checksum features disabled by default. Users can
just enable them explicitly for links they trust for lower CPU usage
and/or higher throughput.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - Move offload metadata into an ntb_netdev header (Jakub)
  - Exchange receive support at QP link-up, not on RX (Sashiko)
  - Keep peer checksum state per QP (Sashiko)
  - Advertise receive support only with RXCSUM enabled. Drop
    partial-checksum frames when it is disabled (Sashiko)
  - Keep RXCSUM unchanged while the interface is up

 drivers/net/ntb_netdev.c | 100 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 93 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 67cfe0f1a49a..d889c8538be0 100644
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
@@ -29,12 +30,19 @@ static unsigned int tx_stop = 5;
 #define NTB_NETDEV_MAX_QUEUES		64
 #define NTB_NETDEV_DEFAULT_QUEUES	1
 
+#define NTB_NETDEV_CAP_CSUM		BIT(0)
+
 /* An ntb_netdev_hdr precedes the packet. */
 #define NTB_NETDEV_META_HDR		BIT(0)
 
+#define NTB_NETDEV_HDR_F_CSUM		BIT(0)
+
 struct ntb_netdev_hdr {
 	__le16 len;		/* Header length in bytes, a multiple of 2. */
 	__le16 flags;
+	/* From the packet start, excluding this header. */
+	__le16 csum_start;
+	__le16 csum_offset;
 };
 
 struct ntb_netdev;
@@ -44,6 +52,7 @@ struct ntb_netdev_queue {
 	struct ntb_transport_qp *qp;
 	struct timer_list tx_timer;
 	u16 qid;
+	bool peer_csum;
 };
 
 struct ntb_netdev {
@@ -117,6 +126,7 @@ static void ntb_netdev_event_handler(void *data, int link_is_up, u32 peer_caps)
 	struct net_device *ndev;
 
 	ndev = dev->ndev;
+	WRITE_ONCE(q->peer_csum, link_is_up && (peer_caps & NTB_NETDEV_CAP_CSUM));
 
 	netdev_dbg(ndev, "Event %x, Link %x, qp %u\n", link_is_up,
 		   ntb_transport_link_query(q->qp), q->qid);
@@ -189,16 +199,29 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 	skb_put(skb, len + hdr_len);
 	if (hdr) {
+		u16 offset = le16_to_cpu(hdr->csum_offset);
+		u16 start = le16_to_cpu(hdr->csum_start);
 		u16 flags = le16_to_cpu(hdr->flags);
 
 		skb_pull(skb, hdr_len);
-		if (flags)
+		if (flags & ~NTB_NETDEV_HDR_F_CSUM)
 			goto rx_drop;
+
+		if (flags & NTB_NETDEV_HDR_F_CSUM) {
+			if (!(ndev->features & NETIF_F_RXCSUM)) {
+				ntb_netdev_rx_stats_add(ndev, len);
+				DEV_STATS_INC(ndev, rx_dropped);
+				goto rx_free;
+			}
+
+			if (start < ETH_HLEN ||
+			    !skb_partial_csum_set(skb, start, offset))
+				goto rx_drop;
+		}
 	}
 
 	ntb_netdev_rx_stats_add(ndev, len);
 	skb->protocol = eth_type_trans(skb, ndev);
-	skb->ip_summed = CHECKSUM_NONE;
 	skb_record_rx_queue(skb, q->qid);
 
 	netif_rx(skb);
@@ -216,6 +239,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 
 rx_drop:
 	DEV_STATS_INC(ndev, rx_errors);
+rx_free:
 	dev_kfree_skb_any(skb);
 	skb = new_skb;
 	goto enqueue_again;
@@ -316,6 +340,8 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	struct ntb_netdev *dev = netdev_priv(ndev);
 	u16 qid = skb_get_queue_mapping(skb);
 	struct ntb_netdev_queue *q;
+	unsigned int hdr_len = 0;
+	unsigned int meta = 0;
 	int rc;
 
 	q = &dev->queues[qid];
@@ -323,7 +349,29 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
 		return NETDEV_TX_BUSY;
 
-	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len, 0);
+	if (skb->ip_summed == CHECKSUM_PARTIAL) {
+		if (READ_ONCE(q->peer_csum)) {
+			struct ntb_netdev_hdr hdr = {
+				.len = cpu_to_le16(sizeof(hdr)),
+				.flags = cpu_to_le16(NTB_NETDEV_HDR_F_CSUM),
+			};
+
+			if (skb_cow_head(skb, sizeof(hdr)))
+				goto drop;
+
+			hdr.csum_start = cpu_to_le16(skb_checksum_start_offset(skb));
+			hdr.csum_offset = cpu_to_le16(skb->csum_offset);
+			hdr_len = sizeof(hdr);
+			/* Keep skb->len unchanged for retries and byte accounting. */
+			memcpy(skb->data - hdr_len, &hdr, hdr_len);
+			meta = NTB_NETDEV_META_HDR;
+		} else if (skb_checksum_help(skb)) {
+			goto drop;
+		}
+	}
+
+	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data - hdr_len,
+				      skb->len + hdr_len, meta);
 	if (rc) {
 		if (rc == -EAGAIN || rc == -EBUSY) {
 			netif_stop_subqueue(ndev, q->qid);
@@ -346,6 +394,28 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 	return NETDEV_TX_OK;
 }
 
+static netdev_features_t ntb_netdev_features_check(struct sk_buff *skb,
+						   struct net_device *ndev,
+						   netdev_features_t features)
+{
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    skb_checksum_start_offset(skb) < ETH_HLEN)
+		features &= ~NETIF_F_CSUM_MASK;
+
+	return vlan_features_check(skb, features);
+}
+
+static netdev_features_t ntb_netdev_fix_features(struct net_device *ndev,
+						 netdev_features_t features)
+{
+	/* RX checksum support is exchanged at link-up. */
+	if (netif_running(ndev))
+		features = (features & ~NETIF_F_RXCSUM) |
+			   (ndev->features & NETIF_F_RXCSUM);
+
+	return features;
+}
+
 static void ntb_netdev_tx_timer(struct timer_list *t)
 {
 	struct ntb_netdev_queue *q = timer_container_of(q, t, tx_timer);
@@ -369,6 +439,16 @@ static void ntb_netdev_tx_timer(struct timer_list *t)
 	}
 }
 
+static void ntb_netdev_link_up(struct ntb_netdev_queue *q)
+{
+	u32 caps = 0;
+
+	WRITE_ONCE(q->peer_csum, false);
+	if (q->ntdev->ndev->features & NETIF_F_RXCSUM)
+		caps = NTB_NETDEV_CAP_CSUM;
+	ntb_transport_link_up(q->qp, caps);
+}
+
 static int ntb_netdev_open(struct net_device *ndev)
 {
 	struct ntb_netdev *dev = netdev_priv(ndev);
@@ -391,7 +471,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 	netif_tx_stop_all_queues(ndev);
 
 	for (q = 0; q < dev->num_queues; q++)
-		ntb_transport_link_up(dev->queues[q].qp, 0);
+		ntb_netdev_link_up(&dev->queues[q]);
 
 	return 0;
 
@@ -420,6 +500,9 @@ static int ntb_netdev_close(struct net_device *ndev)
 		timer_delete_sync(&queue->tx_timer);
 	}
 
+	/* Apply RX checksum changes deferred while the interface was up. */
+	netdev_update_features(ndev);
+
 	return 0;
 }
 
@@ -475,7 +558,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	for (q = 0; q < dev->num_queues; q++)
-		ntb_transport_link_up(dev->queues[q].qp, 0);
+		ntb_netdev_link_up(&dev->queues[q]);
 
 	return 0;
 
@@ -496,6 +579,8 @@ static const struct net_device_ops ntb_netdev_ops = {
 	.ndo_open = ntb_netdev_open,
 	.ndo_stop = ntb_netdev_close,
 	.ndo_start_xmit = ntb_netdev_start_xmit,
+	.ndo_features_check = ntb_netdev_features_check,
+	.ndo_fix_features = ntb_netdev_fix_features,
 	.ndo_change_mtu = ntb_netdev_change_mtu,
 	.ndo_set_mac_address = eth_mac_addr,
 };
@@ -583,7 +668,7 @@ static int ntb_inc_channels(struct net_device *ndev,
 
 	if (running)
 		for (q = old; q < new; q++)
-			ntb_transport_link_up(dev->queues[q].qp, 0);
+			ntb_netdev_link_up(&dev->queues[q]);
 
 	return 0;
 
@@ -716,7 +801,8 @@ static int ntb_netdev_probe(struct device *client_dev)
 
 	ndev->priv_flags |= IFF_LIVE_ADDR_CHANGE;
 
-	ndev->hw_features = ndev->features;
+	/* Checksum bypass assumes a trusted NTB link, so keep it opt-in. */
+	ndev->hw_features = ndev->features | NETIF_F_HW_CSUM | NETIF_F_RXCSUM;
 	ndev->watchdog_timeo = msecs_to_jiffies(NTB_TX_TIMEOUT_MS);
 
 	eth_random_addr(ndev->perm_addr);
-- 
2.51.0

