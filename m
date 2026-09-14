Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021133.outbound.protection.outlook.com [40.107.74.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E8F412BFB
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375733; cv=fail; b=VrlyvBC4jPnqHPw/HLOGgY3iOolGcWGWxDILBiiEqMDsVguZiKxjPHiZcL6ypNh5EBYBTcGZPi6kEVrwfjYXf/gs/vavoEktcmZDRS/uelTL/myFBEbZ4Yg3V7Z8qwniJ3WxOvSbMNlQeIXDz2bQcH3cbqbLqYwzMAe0Y8mMzMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375733; c=relaxed/simple;
	bh=ActISJ+VSOp3vcteG/+vsMs0dv/Er/RH0iSnL4AXCz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G+l8mzZ/wPDXCTR3leD/Udi0BfRA8Rpi6RAxmwTigFh8NKJK9oH7itF1Hiyj/Pq2Q0s0pwaBfTtlWk+t5t9u0WfhNHrEbwfhn7EFZNhkXgn/D5kpRcwHGqihzuc0j22vpG+z8fdj0rMnbIbbubYSbC+ot9twrflAzLFosyky8+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=DBrbG2qt; arc=fail smtp.client-ip=40.107.74.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="DBrbG2qt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yzlweBo+XUix6BnaMqish5emMn84lXytvwdCK99WWrr0X93ptETwogZtjcXpRVx+38EnS42rHpac/niQfnR8gRd6E78sg7yCj3pAfnuiIcNlMegEjCT2lO+Fu6kW2ZA1e5OT1rpKBw18tBROkz69dsX2Op+/LFjc6v9R8YxB1qRCI0ERnTb1WPbLUXeW/wIh26sufhB/IzK7upxDlMWywi85Qcs+rCJSNVuaJybSPQ8KHvuMS99hFjtZhjY7nvcV0KJwv92U7JP3pXlBUfmKExwy+rvVlRdIebDSf4Z2+rhbU/3W0IL1TjaT0hVNYUzVl76ZNjuOTCpIHMq3alFY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4/vV09gA9jPjDsbtO8S5MwaAUakVh4jO7IfBirUJv64=;
 b=IAdcDXQvrL62uUxTm0tc64eCNNIfbiintmpYTVNRMm0fr4uV863kEA9eNQsTUa4mHZudxoXpv0SqcIDNDCB4lX0XvUJnJI0KxllRIv9UhySxMx+Z4F4b06pCcn2TEvpEgrQS+o2QfJmCrzXc/myrfhE9Jum++5oaUvGQwmMTsftZdnaCzceZlcc85GBgIorkmkUf72E1L/Kbd1eu7N3qS4rPD3RDdt0Zobqi2fsrwTRiFdHi+wEZgsKB0JmTFwyreUJxVQcS/oDURzWcqfOXEueo54Xeo5Ht3jMi8HD7WThJjgyJXp/GFpGiaKm6G7TlNYtzCmaGVhwmkPXVuuS2xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4/vV09gA9jPjDsbtO8S5MwaAUakVh4jO7IfBirUJv64=;
 b=DBrbG2qtlxWOywDk3M4YoyNflglg5p/sbMaqijtjaCtZ0Jalkbc+2xrq2G6+66/4p2NyJCBZ+lkpeNgQ3Osbm57W1kPglWiKPxTByxDoEOJ8HRfStR4TccCc4153QhoGlieUbzvHKunIx7tHTlTaSPloAhcy7SnxuHgQie7aswU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:43 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:43 +0000
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
Subject: [PATCH net-next v4 02/10] NTB: ntb_transport: Use little-endian shared fields
Date: Mon, 14 Sep 2026 17:48:30 +0900
Message-ID: <20260914084838.2158249-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0029.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::12) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a2b42d-9863-410e-3441-08df123cfb30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gB08wKslX/7oPz3Zbo4m7uzm9bfaKn+IV7vQ8svqC4AApYjXJaGwItAC7LaPopxTQUfiJMEf4wWuY6HA1yDMtGb7pLhf6VuipoeooYcFFM5RhPljUKcp+YNHH71YsQXI8lvjTYK60lRp7nGlMsJ7qaraj5H9ZgTrbGduXJtkTPfoku5HstoAies8LmjL7e6Al5PxyAoVatNk/y+xON5PKATgok+c1U6IePQ8RtxjjWTmFKa/HeqE5OVUK4EqavSgOvZAi3lc1JT7TC2JjFfS3t/iqGmNQgiFmV497wEascCh10llCa/N7qoL8kDzdZu9wUdxT/VdMsggyFTm7gfnahzqsGw3MTihcR7xy/TxrCVXlTjH/pZDYGhLHSeqOajJciSJf2xlVKopqvmUevxoQVT0r27WzeW3e+A8vZBXBLbI8oC5sb0Q6JXIEvp/Its5jrGM/ElcDnG/zU96fONpX6Jolz3MQznB4l+iP6XP+sRW3PeVYsJXi/RW6QnObH3AdlakPDg1M9QC4inRop0zSLa1iqtmPUrXXyrNboGgcJ97HdV+/ZudHR1k8lA8laOIUY+uR1ZVx6iL3IOJIcPAi/rNfDrjuZ2XDqd0RdqnAfQh94fY5PcF7PaaKD8Y0XM0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DVzcze3tgSUAQDi4wddLADnfi6BRP/qGyWM2vxQRRZjc7JIcF+oF+SkWS2FJ?=
 =?us-ascii?Q?bT+DcBMcD+LGeajQp37vFC/L8d1tv/W6OKpc3p9heRce0iFzuLN42is9opH4?=
 =?us-ascii?Q?HItam1JZlFSplDX0eUKazr6BcX+vOE+THYmg6PiTVnjSQrnwIFn8rikdYKDl?=
 =?us-ascii?Q?Q/bzp2UGmQn6pLF36veiWaIxNM9FQ9NkVrObjPgnElaHzHLPG0o9gpz695Tv?=
 =?us-ascii?Q?RM7FluASKrnGgbtFgGhJ4ZaH/3Vik4387LMYjvs79CdtflMBliLAUOwS/rsW?=
 =?us-ascii?Q?N1RUE/rao5mavrwj1qJ3PK4ydYHSxSeJbbSryp59fyygdoZZw3HV8JCZxFXS?=
 =?us-ascii?Q?zW/XyToc6zr5tG1tDiU7YpFPcxRSuPQ0N/iu9vrN/ablmY3WkLvPRupFgOrF?=
 =?us-ascii?Q?JURsKuUrEllAWYFgfvD5BqLl6Ka5U1oFCAjsNIIbc+WpI8L7iakzTF0N8t6j?=
 =?us-ascii?Q?uPgFs+7EFfAxSSST+Cr3BN3Fd4Z9xz6CCctlDlrT1jUvh5FORVu5LUTHQfOx?=
 =?us-ascii?Q?nJVOI5ydeuCHzMKsKaBcD9J0UiIeVdrs8vwlgfAIhNo0jJKJzoxDytmYb0+k?=
 =?us-ascii?Q?BoRPZAplGeVuVmISd45FD4OG04KP4Nb7woBLrBraRQ5/ITKNlb3p7L4R4vs7?=
 =?us-ascii?Q?7mFfSyOmQLQ+dYC0gxGW3NYrNmvkcXIA6plyALT5Hl5BoP/TQF6x1tHxzqTD?=
 =?us-ascii?Q?EEvPwlABYKNrDFFadBcNttKUXRP52ngs+H+Od6WMl99z6NxZyg7YQyQ5Bqnj?=
 =?us-ascii?Q?la1gYntpqR9WPNfzuTjP4hnKKrQQr7OnN9oNpBXXQ38CNbdFUzEqyDpd+UC3?=
 =?us-ascii?Q?47ZliZ4jkgSiwyDzZ67aBxG4Fr9sgaLKpAedtzciMeIZ6z0q7bcdCMSZW8g0?=
 =?us-ascii?Q?Vi1Ma6CM9CWWtRJ1EbuhrNwUa7RzuMaFYbA1iLiMIwvI3uX7U/Ck9lQ3jR/D?=
 =?us-ascii?Q?AN4Vz3KUAPlDUcUF+4d0l/fi6+sUiJtYJC4tzC2y3Jlj1tZR15t75I5RC0+A?=
 =?us-ascii?Q?6Z8xRkYr0sAQt/u8W2tW8doLA+nQ6ZGV1LBDQIpBOn6vzA3D84BEG2lvGBMT?=
 =?us-ascii?Q?AdKWb0bTZZh9wW/+LfjYuoAexDDI/IVBoRH/pX7k8M9R0VyDDK3tx9MboxpK?=
 =?us-ascii?Q?T5TL9Oy8iJPAAvHQVgBPVhog3UU8fuAc5WC+hI94YK45MFwXO78VjNQFgWxF?=
 =?us-ascii?Q?mZx+GVrauylzKc61n7HOUK/zz0xMIwUn7Oy/1wgrgGslpZyO6DawHRr9i6w5?=
 =?us-ascii?Q?pRT0rQV65yNDtL03JiRF7fl03bVIxErNkZmQO5zdlWigWYbHCIkd74/tjYSf?=
 =?us-ascii?Q?9fqUn4YEOd59GjQwlQD4jssawU3PmKg3w08DKN/XgajfhV90/7ois6yXLXCG?=
 =?us-ascii?Q?UcnawWOZsXO9QAb6QlpKn0Mz/hSObO8gtqQKf4c9y3Ee1guIrLP12XsoOB+e?=
 =?us-ascii?Q?MmBfJmrU/OgnFTmpToa2XSRKDlpuiqiOU0cTcCo1R8l7KaYyCLKA0XfJGqgL?=
 =?us-ascii?Q?dic6Kdj7KzJRn9pcJibFCN02BK4+kq8gQIppp8UgKHAm5KEucsdRD/SXa/gJ?=
 =?us-ascii?Q?nRPMZPKId/8MI7z1rbNLDzWCocVw7C1xXeOMJ+GTFwxXpkQlCsiUDcigqaew?=
 =?us-ascii?Q?2R8+5e3f9SzQwyrfD9xdTsXVeNtxMFbeo9vHiRoVf4k0MeFLCcjOZANEnmyQ?=
 =?us-ascii?Q?6zsDF9NCex29zycD0i6kqhKC5Duex+oGQRsahLU2uKwUZl9qsEBVj+wijPyY?=
 =?us-ascii?Q?yQLAwyh4Z84KYkdb6F15FDU2KSKsao4BDrI8RzBLUKllJE+dwZ16?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a2b42d-9863-410e-3441-08df123cfb30
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:43.2905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tv5XQn7/KpmEW5KLyD22NUc+V/ame4EC9v/cas+LRxUkcbGRlb44ruKbn1Ivqy++yDevLA1hgktpG8R1X8qGag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

ntb_transport writes payload headers and the RX ring tail with
iowrite32(), but reads peer-written copies from coherent memory as native
integers. The values are therefore byte-swapped when read on a big-endian
system.

Mark the shared fields as __le32 and convert coherent-memory accesses
accordingly. Read hdr->ver and hdr->len once so their checks and later
uses see the same values.

Fixes: 74465645cdb4 ("NTB: Fix Sparse Warnings")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
Link: https://lore.kernel.org/r/20260818064951.7EA231F000E9@smtp.kernel.org/
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - No changes.

 drivers/ntb/ntb_transport.c | 47 +++++++++++++++++++++----------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 74f4f8c1c7be..3f497a62673f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -132,7 +132,7 @@ struct ntb_queue_entry {
 };
 
 struct ntb_rx_info {
-	unsigned int entry;
+	__le32 entry;
 };
 
 struct ntb_transport_qp {
@@ -265,9 +265,9 @@ enum {
 };
 
 struct ntb_payload_header {
-	unsigned int ver;
-	unsigned int len;
-	unsigned int flags;
+	__le32 ver;
+	__le32 len;
+	__le32 flags;
 };
 
 enum {
@@ -514,7 +514,8 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
 	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
 	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
-	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	seq_printf(s, "RRI (T) - \t%u\n",
+		   le32_to_cpu(qp->remote_rx_info->entry));
 	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
 	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
 	seq_putc(s, '\n');
@@ -633,7 +634,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 		qp->rx_alloc_entry++;
 	}
 
-	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+	qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
 
 	/* setup the hdr offsets with 0's */
 	for (i = 0; i < qp->rx_max_entry; i++) {
@@ -919,7 +920,7 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
 	ntb_qp_link_context_reset(qp);
 	if (qp->remote_rx_info)
-		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+		qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);
 }
 
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
@@ -1445,7 +1446,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 		if (!(entry->flags & DESC_DONE_FLAG))
 			break;
 
-		entry->rx_hdr->flags = 0;
+		entry->rx_hdr->flags = cpu_to_le32(0);
 		iowrite32(entry->rx_index, &qp->rx_info->entry);
 
 		cb_data = entry->cb_data;
@@ -1609,13 +1610,15 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 {
 	struct ntb_payload_header *hdr;
 	struct ntb_queue_entry *entry;
-	unsigned int flags;
 	void *offset;
+	u32 flags;
+	u32 len;
+	u32 ver;
 
 	offset = qp->rx_buff + qp->rx_max_frame * qp->rx_index;
 	hdr = offset + qp->rx_max_frame - sizeof(struct ntb_payload_header);
 
-	flags = READ_ONCE(hdr->flags);
+	flags = le32_to_cpu(READ_ONCE(hdr->flags));
 	if (!(flags & DESC_DONE_FLAG)) {
 		dev_dbg(&qp->ndev->pdev->dev, "done flag not set\n");
 		qp->rx_ring_empty++;
@@ -1623,21 +1626,23 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	}
 
 	dma_rmb();
+	ver = le32_to_cpu(READ_ONCE(hdr->ver));
+	len = le32_to_cpu(READ_ONCE(hdr->len));
 
 	dev_dbg(&qp->ndev->pdev->dev, "qp %d: RX ver %u len %d flags %x\n",
-		qp->qp_num, hdr->ver, hdr->len, flags);
+		qp->qp_num, ver, len, flags);
 
 	if (flags & LINK_DOWN_FLAG) {
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
-		hdr->flags = 0;
+		hdr->flags = cpu_to_le32(0);
 		return -EAGAIN;
 	}
 
-	if (hdr->ver != (u32)qp->rx_pkts) {
+	if (ver != (u32)qp->rx_pkts) {
 		dev_dbg(&qp->ndev->pdev->dev,
 			"version mismatch, expected %llu - got %u\n",
-			qp->rx_pkts, hdr->ver);
+			qp->rx_pkts, ver);
 		qp->rx_err_ver++;
 		return -EIO;
 	}
@@ -1652,10 +1657,10 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	entry->rx_hdr = hdr;
 	entry->rx_index = qp->rx_index;
 
-	if (hdr->len > entry->len) {
+	if (len > entry->len) {
 		dev_dbg(&qp->ndev->pdev->dev,
 			"receive buffer overflow! Wanted %d got %d\n",
-			hdr->len, entry->len);
+			len, entry->len);
 		qp->rx_err_oflow++;
 
 		entry->len = -EIO;
@@ -1665,12 +1670,12 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 	} else {
 		dev_dbg(&qp->ndev->pdev->dev,
 			"RX OK index %u ver %u size %d into buf size %d\n",
-			qp->rx_index, hdr->ver, hdr->len, entry->len);
+			qp->rx_index, ver, len, entry->len);
 
-		qp->rx_bytes += hdr->len;
+		qp->rx_bytes += len;
 		qp->rx_pkts++;
 
-		entry->len = hdr->len;
+		entry->len = len;
 
 		ntb_async_rx(entry, offset);
 	}
@@ -2490,7 +2495,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
 	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	unsigned int tail;
+
+	tail = le32_to_cpu(READ_ONCE(qp->remote_rx_info->entry));
 
 	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
-- 
2.51.0

