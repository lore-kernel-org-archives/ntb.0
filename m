Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021128.outbound.protection.outlook.com [40.107.74.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1942441A766
	for <ntb@lists.linux.dev>; Fri,  4 Sep 2026 05:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788499306; cv=fail; b=ngMr/fVRso3rI8XB74N9ch6nqvxMhdKMsDlK/ouDlJj277eH6pqxu+jBHD32GhFog/Q5EsFUq2snZ6USlqEui6RjsYtKgHKtzTU8nwy5bHAaTc23CC/44lnWApGJQo3d/iWH9lG2btB/DW+mPvlE0aYY/73Kus1u+bv8uIHRGQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788499306; c=relaxed/simple;
	bh=sego/aoAhqnDYW7TkCVtKr/bG76BAzpr7qSgSe0XLU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kXTvoqEL2yDijAqAFiYJw+kh13udu2oFeFFjvr9rbqwkVraIy4zMoemHt9uIIo7CJzv28y0k2qs7K6+T1NbUI8a1uYpx24QvzTOTokCmiZQUdvt6OWRH5JeqBfnO7hG0t4eEwfA8rkoA1ColJvy5w8oM5ImewYgzsXFU2J5LF3A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pAUbHNVk; arc=fail smtp.client-ip=40.107.74.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pAUbHNVk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FO4oTzoTxsUSqoFRFQa5fZK+8VvEoCfyai/jNWvXfF2E2wD5pHJ4Xs+ukYSr+ru36e3zqDuWKaMXpxmuznBskhV1A3kPhftgbSNAvwi23R3Ac1ftV41S7JYBPctUgkMO8yL9S5dmRG9W0XdIKO8fftsmS4mBwKtSrCwlN7Pik8TiZVWQ/DzRdIN9J0MoKTxdPpvs6MHAmeiqB7uVu/rHuhgktrft7PY3z7PyFKZ+K56aooEvW7zMXnA8bok7azOpPp/AvsLQqKRRYI4zIP0mZmC6aLlxRjXhZVfxgnoBmivUWpxXe4xNigcwfNYh0Zt1EZiCofxz5MpIgLuN6cxtZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xrknvmaxfQU2tbV6QGdggt+2dwWgnpmnL4SpqeWsyzw=;
 b=QFu4tcCzIIVfu7Csmr0Dq1SmZyYXgSQYr9PvFyMrY7G8tHGLEQCFNkEQbQkongqgdGFIDyHNTtOyYpdPmygI1/4YHmkxwO8ODOpcRQww2kH7x2hNs46J8H7Odn/uCipx7upVsTPp8Hp38lBek3bYS5ffqk7AWgrJUSghVOgOoelIVxdHZzKTu7lS2Gv41ih1mtScunOP5/xNDgBqHCETCHaLHDZOjITYy3CqbC2daFOaUeKPvb0zouF1nf5lyEFyX0JZJKHWZEkmWDrz8PgPeipRx78/Oms9H+f1rjsI07RDyh7li0w/bnBD7m2lCRB26NvgQ6mWFDWGcktbTTkoAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xrknvmaxfQU2tbV6QGdggt+2dwWgnpmnL4SpqeWsyzw=;
 b=pAUbHNVkWOvRw8KGjFsoAJXPhNIsrv0QzQ+aP0v8QRPYjwYzOAsUd/pfwy9IoU7PdBi4CoYagbn9Vidzw27M7TsZTgJCqvM6jwJomwI+aXFqwTzS6Mlq2VQvMGQXWdxriiszwbteI14KjTZ540dEQ9oeFW3szA0S1daR/ykoVvk=
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
Subject: [PATCH net-next v3 2/4] NTB: ntb_transport: Use little-endian shared fields
Date: Fri,  4 Sep 2026 14:21:32 +0900
Message-ID: <20260904052134.2970111-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260904052134.2970111-1-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0131.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b6::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 653679e3-931f-4a01-c030-08df0a446504
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|23010399003|10070799003|7416014|376014|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hZMPxQttCoMdFA9cjHZ8/scDO49tAW8nwBnBXw6nuPVwNAK7GkzClsF5UPO2UQl+GvU7hSUAQmyQ53XcXZybFKw3kaapnBquvI+3cMC6qzvjpSXLmwKWVwNsJiVtgJacB9nGKTMJKSkVykPixMbt5ml0g9vSTBgkRQkVY1GksmxkbwaHU1/ZzVoBU1J96aTcG62AOhr4ypJqfZ2UV3eYzqzwnftBINP4mIRRcQ963S6pjcgSzHoVOs7xAPZyLkIl9Hb3zWLqSTVivyJAIqdmcB6VpTGNUjmTPqZw9kOj/SdyYMFbo2Cmefdtz9NKCi6O4OG9ygcEctbPORMWL1JeXc2Gzvyt/jzswcjp9KmjTm1BC7cJraDBvuB2aIaJIZjAVvxQW+0UjbA1TCycDufmfhBqY8R9PPTgOGPvUQR5tJwRioPfUWBEoPMKDOn82cP0PrZfPuKTZZ4PVW72GCXePO3KBdUzM/Fq/ETMycXohTim14UU2n7ro6jRCuEgrHAMbba2KIQyWHmtRASMwMkfF4bwbuJxBzo3A+rb0lcw6s7S1PZQLeWQlcRiC6v6c1vAQv9ItRjjSSi8uLg1LNtD79ZDqV1xvwT5f74AtqqY3tE9s3GkKuxFO554Ol+HJiu1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(23010399003)(10070799003)(7416014)(376014)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5Op4F3YYdFm4OdMZmJsST3o/Gc30M1VSygTo7DiNuctx0Gmw6QJ6oU3jnFv?=
 =?us-ascii?Q?KmPWeSkFHg7/21KJCwxjb4qIFR8cvRbGveBgPH1e37qrwkJVFt+BBrjEg1SW?=
 =?us-ascii?Q?d8da12trPG3qxhVzc3geWcXajgZZBqgTPEhv0KY+AxnBxBq+J0oGRGZPA0T7?=
 =?us-ascii?Q?m7z3w7dGtNzL5a5rueZrtlE5JdEVlMwk3A9n3uLz03hpT7/Xlg+zNERnjRJ8?=
 =?us-ascii?Q?EuFAO5aRwNK1eV+H9QsR6XvhVTa+CzNqMbS8gRWTv8Wm97jDSilFvxfnFg9J?=
 =?us-ascii?Q?FAbY8hwIagtbPYFNoochqqaTxz+EJtHjAcD1Ud/pJlUzil0B2TGgYGez2gWL?=
 =?us-ascii?Q?jf/UfIHfXSgwB2pbBtr4VqtCJsFN8nuzgibRfrVU+SjM2knaFJv5OugKUhTM?=
 =?us-ascii?Q?IIY+U8QgxPJdHUKtDXpSJ5vR0X0UQZWOMWfwP8uXneeMwwzKfDuf9fmpKUnW?=
 =?us-ascii?Q?5a73b/nysWSlQVXqbQu3Uc8A2oPtMptrPjmJzlUYy7McvClF5NErlR2YnKi+?=
 =?us-ascii?Q?LuXscNEDqZ5HDRkGNBtzPz2d/il1K6UGdAmyFVlI71aKNKsA97PKFoNsYvX4?=
 =?us-ascii?Q?jsaCb3t/DX7ircU+TZr2/wirMc0rNt2wQms2zTKeSAMId9PiXTcYtlnU9ZBx?=
 =?us-ascii?Q?VyUZedpAYqEwW3Y9w5BbQL4J+HBRZiepNpQWvmwL0sstpiMwWygOoR1jM2Xf?=
 =?us-ascii?Q?h0IIMGKGFVB7jEUwnEF2TFL9fB1FdL1uoEFmMKilE1SSljYTxThbeuYugj3W?=
 =?us-ascii?Q?Qeguiy3LvUhfv+KgcP+Ky9/TS0fSo7TfSFD2Gjmt3TLfPna+WIiFW+90ZTeS?=
 =?us-ascii?Q?9IjldmSZZIknP82JsLizQE97k9w7cYkH1U8h6+GfwLGXKLNBnqplTv6qz1++?=
 =?us-ascii?Q?bPvhOIRBosMVNM9iY4bSdI9EKxx9ZAbCHwzerCXXQK3/YQuMV0CD7OT6/XfJ?=
 =?us-ascii?Q?oJXiCm7ymHrnkRoVA8GKRTnapLWPn5zd6CN9xPLwSvKCVx6M3GFoXhxIc8dR?=
 =?us-ascii?Q?GRAt7kEg9G87ppJyXq3H+0P10baKCkBTioVkE1Db+FiHi/qgkOS6lmcnFREC?=
 =?us-ascii?Q?8QKzT7Mhh5cAiNc4+eVFYXH8Qb7dQ5jT1AwlJQ3uj9w4xxJ9yu5mR8USuG22?=
 =?us-ascii?Q?j6YLSqg1aBi/36DztL2p6yosWEGXXwH7MLaO7Dumfat9gD+H+f1M8XB4xze5?=
 =?us-ascii?Q?dZmfEEq6NJ6rUCEY8WKAyRRRIqKaXl4ndGLwzI3Du1lRnGzxDpaNmFSa7U8s?=
 =?us-ascii?Q?xCI+zUx9zP6KP027ksgjhJqNM+no54t3t9//0NVmsNo+Kk6wiJaputjhtyIl?=
 =?us-ascii?Q?TUf9NhzULIKa/7BcpUWVBOIAFpXohdZ5IRFgLDvY6FVkYS6WwWQspSd7rBJm?=
 =?us-ascii?Q?TKp5LQk9AeMKeUQjmjzp+iqeqGK34cmISj5X/XoI/g1QNMtLinn6ImvwZ4T8?=
 =?us-ascii?Q?LoO7Uhfv+KcQ1c7WyxU/AAwM8xNNUYnOZPWlWsdgbFRZ7+xHquAHvroJojKA?=
 =?us-ascii?Q?e1/HqZaOVoCzifDc7Bmt7lHZQb6CB1Zg/ctY3YwTgVCkXQsxDgsyZNNqHSr0?=
 =?us-ascii?Q?ZktQipoAezLd+C9qJpjycoZkbeuu+OQkqysoyrSeqKMIwSNKrLA8VhU+j7ry?=
 =?us-ascii?Q?punEK4Gpap9Ma5GK6Gp4yaxYVr6VC+d1sNRWH1Xt4Z+p7ZA4DbkoMjss33RO?=
 =?us-ascii?Q?8XybkJwL9ZARJtJSdTsprhoY1r33uhPyRj9n0BLoHYKfo5arOBUJ2mb2Ki42?=
 =?us-ascii?Q?0OYTnTShRFZbONydbDMfPd54WwlAIBT/Wj45LA6Vb0q0HG8XuKaJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 653679e3-931f-4a01-c030-08df0a446504
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 05:21:37.9533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hYSnUWqLjxu5CCX21uvEwrEVhQgskhRodm4MCE2szntvl61TlmjSGlQejGuexSykwqm+qkz6i9Cn/eSPMkpwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB6378

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
Changes in v3:
  - Use READ_ONCE() for hdr->ver and hdr->len (Sashiko)
  - Add Dave's Reviewed-by tag.

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

