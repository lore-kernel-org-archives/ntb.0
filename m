Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020078.outbound.protection.outlook.com [52.101.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2CF38DC5F
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 05:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944928; cv=fail; b=AMdw8p2DMV0DHMxjL3sl8Cpxj07esCaU9QmtfUexfG74+JVfPUM1cKTU7iimo7sO7Ea1gisqHwOCg2rdjuejbCZoq+ek94WXOmGb8wWRyCJGiVLCSeb7Ou1hbKzNaX53nxwS7aA44zNLweAyiZUu2QLu+62KRkojjsl4GEORRuk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944928; c=relaxed/simple;
	bh=X7vF/Lb4MCRwuDmAAG7QU6V1zs3TURlXvFEBfiaXO+8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KwixbchbSy857DdfmRaSgj3IC1zxQyaIWUxXLecUBRk2UTVqDB8GxM3I/vifjB9EMI9vQVsukmstBN0Al+K+HpQlSZVE8CEsJObqa53tsUciKgqt7hCE7gBvnQtAjuuXWCVsINH4F+2kD42MSt8ZFovCULw9kphso0bg2cLLwJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qqFsruwX; arc=fail smtp.client-ip=52.101.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qqFsruwX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8NWaa6qOznV/PAlvONztELVDBjLLCIbpEf5/rh0uy51GoSyrnguuppEasb1ISrq2S7kjRlmyHqSvOG1uKbSZdEopeGq0fRMNzcY6pbTzQa18tu1+m4Xxg6f+FycSkNRVKqlVlDX3/26VNrRMdq/abEgy5yF/wWINNahvGdOxHGWyZIrGrGM3XIhzs89fnOiJlEHfQglwHX4v6otfwB9H7w9c8CBXmJZND7C5Ms1mHLBiPyZW2BJXxfniDAcwGePtN+U5AhTR0J4L2skJyiMGQcV0+Yx503ZYbo+0AQ/wjQXLWwe5ujtB2VTaSynqjB2+tPiEjOn+vLAGYf0pDJzbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5LcdOFu/gijHhEJTH4v+rSzl4XGgdNHxDQeuSBrzSMk=;
 b=QtytKiM0NTXmHfYAgS4dTSfk03Dfw/eVmnQf/RYM5GiN+GuGWWYvNCY1qGNUOp6G80MPcYYzpWS7UpO1Vpaq+N/BhEHjhgxZLduYm7Jik6DhHO0Fu/82JvfKO3KdOPQooMoZgBpNalcIE+iYttTzC+Bebt+VqNUlzccWfPp2yNBomTx/xe+iNvtIcXfG4oBuXEGxsglyIUzkhdCw/+BBPtg0ipp3I3I6ADn15N1HJSehCq0YhsA/FUFK2XK2QxYOaR6HBdV53U5TJ5h/HTwYVqeJnFvEBtRsvQf/rzIw+WyjRn5U8zYw7EtOd1k8Lr/jWybKGCG+C9lhZ+3uVrR+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LcdOFu/gijHhEJTH4v+rSzl4XGgdNHxDQeuSBrzSMk=;
 b=qqFsruwXkDJKB+9WEfxlL0T7wJAgQJR06adU/fPkr37kIR2JvivuN0yVroerhVR9WJTllSfAOZeOIFy7LG/YEz9wIvziBvT1exSNyiTYPpdPIz1zzcZno8bR2gG+pVHeDK+xAPLnHk/ubbH7XNIATGnMOrnTuvxDop1T8c87BYA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB2996.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:35:22 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:35:22 +0000
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
Subject: [PATCH net 1/4] NTB: ntb_transport: Recycle TX entries before client callbacks
Date: Mon, 17 Aug 2026 14:35:16 +0900
Message-ID: <20260817053519.4135287-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817053519.4135287-1-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0165.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB2996:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c12146-0645-4109-160c-08defc21553a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|6133799003|5023799004|10067099003;
X-Microsoft-Antispam-Message-Info:
	sNUBokaezjm4OIh2bW1/NapJpxpEboilEV6g4KoXEE+tXOT3vUU6ZA07zcfQnen8Xal4jZNYmo8HlhlfMW9sfNwRwUbYig1dI1OxnZ2Cih6dmKYNVmhgh+1V19gIXQLQ43ch10W8TSD0QHO+t++vm1Ah/hDTf/h3efpRZCrZ4ZCEoIeRDm82VzIVQa55Bw14fX9idEMKPmR9Vwa1g5GqM2dRvW5DCovxSoiEbplGOXEDHEJqANHvlhALdI0YUMc8ioq1eutckqQHPnl22BFTzGSvw98roOkKKQHk9wNO4CJyfj9WZQBwNReInpODt1pIdiZmOlZOorQy7MyM41hxtrxZnFU1KTr3vfs05DPc9V3bnx+N+P/4DkjnqKNlxl9gIPeK7YvHtipsQvDvVNCFRcHvBd6E8yHnQcrqGxgri5xfcGDX+fB0f3+7A6Dh8TfQ0c04wGLfqOsOxi0Jt4GJZU4XUZxJxrbTByfNN4Q2IHbXPWlL5T/m+Lc+aSgKCLkGmmqS0WBTEPqNRQuJKn4unaSwhFQQV1uXzlOJ1JhloNpcUjQx/BfkLKd55D9pQf27Yk21zJRA2EQOvT/NhNlE/VIh4Jxagctonzv3+r1Xa/XYFtrZOqEMxFWcpOKpCt9dsjDfvx7RAWGUSm+/rEayvtyztfGJtn7gklNn4EtMhak=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(6133799003)(5023799004)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XPi+rzzg9Rvn4TgZVHtPPymGPwaV2OMYoGQQUZdAsf+lgXFugBOyu4cekIY1?=
 =?us-ascii?Q?kyAR5OUcLO8mAsQ2KRlBNp4DR9rMkD5ZNUMW8cbcy6lp5vKe8hDGWzEIEXGh?=
 =?us-ascii?Q?nOhRF9BmglpLbeFkPWzpSZRBO3gFWFDOOeIYXER/8/K8WxASnkmS46lRyfQa?=
 =?us-ascii?Q?nXwgvWfCi5BhEYquWCp3F3LYrP6EHLN3j4O+JZgGigTgSv6Ce5f8VdlSeDg0?=
 =?us-ascii?Q?p+TPZVBhaLo0/uWTViB/QWhfT/+KRdgJQMimFiZwVnfh/e2LDue/wOQGd2cP?=
 =?us-ascii?Q?VRK18NJglWRCeLqbIXBMamub5HGOEnbnO5IOF6HTjJ4lWI+LnY0MEjKTsn93?=
 =?us-ascii?Q?HZ3T70NYRw2GldCuaoev2aTmqM9UYYhGyMVlHGNVhnCB5ucjUotSEeIZn6YV?=
 =?us-ascii?Q?4fF9KeWoLxZY+DKgKiHi1kuHIxIYSzkZJ/7sHV1q7BRZKtIiLI1XxFoam3zB?=
 =?us-ascii?Q?/XLaubuU+jQL74gHcfnst/BRTg1N2sS3hm/ZUO4IxPpRonAdR9X4kqvEjUoF?=
 =?us-ascii?Q?3qLkxa7tfp00LWUBvxKzcDtCxrs8UVY5WJXunx9CgWbwAmN1qk8pkl1WmmKg?=
 =?us-ascii?Q?mfDNhmCIPVGBmWkLYe+/jCGTxK1Pv5qMSRFkTXEPJBx57hbp2G8OPQjWJoL1?=
 =?us-ascii?Q?+7fhcNsjQphNrRlRIUVpphDFa0fZiFrFYZXaVSckmsd5so763efMWT4n3zJS?=
 =?us-ascii?Q?q5hlk1jJHHe4Vl4mzZldgqdjqAnTGopndIHzFEhwDUsKjaadiENoLOgfZgVk?=
 =?us-ascii?Q?M5AKNar+q/BaqOjnwoM+bp1VK/ZTBpZj2ucBtgLwDt/SfVrGey/9de5s8S0T?=
 =?us-ascii?Q?ntpSprqZahkBJQPyf+ibfYp11IY5MhBaMWnoCxWjZA7d7kqyIZPn5kg3BarN?=
 =?us-ascii?Q?UdCe8yENulFMEEqa8O6ovell3jXzwir+UAVqX36tCSl0J20soUtLE4vDeSCS?=
 =?us-ascii?Q?S7D11UiW2Cj6Xg6uu7wPWzTTmhsZnU5eYjyHs9RotBS+j1McOpfaIMQLXRZF?=
 =?us-ascii?Q?6cYMY7O477YgbhDSV4t8ILXq5VzgKv+Y86boHkgWv1K/blrhtuTOnIiL+rPG?=
 =?us-ascii?Q?IVuhUeZJHhyhyA2AlwWlwCgP9ZcHu5RRTonmRu35JXvpff5QeReJsHQQ4/oU?=
 =?us-ascii?Q?fgB+m6CSUp0+6rK9jNYyHYKjF6pNz6qzQG4si/0nJ2nSkUXBylmezfoJFZa4?=
 =?us-ascii?Q?/yOnFFwPtH3sX7s5jlq/x9vviMZrM0L3UiAbCjLkHYpj6h2AwHIfDaaklHxE?=
 =?us-ascii?Q?DzsuQ7mr1RTtJqwPumgq0Qq/de7TmfAmx8JxfLvD01YXwL8c1qWQ94B+ORah?=
 =?us-ascii?Q?A7+cp7CuTqdCR38Ue8ruEz/6+3c1kMRHHWj+O/yTmTzpTkaVctdExIP/34Ca?=
 =?us-ascii?Q?q2GlJ4JiOGhGzNLTZnYIuFc4tbPSlVIxxIzZxdq6TRrtsU6JqBPJfTkrowpl?=
 =?us-ascii?Q?EYM8hlyYMgu/TklRKY6ZZPWPtrVOwnjx5+VhX04p/yb3LewyT4Oq2P0d4Ohg?=
 =?us-ascii?Q?AuZnm5VR+ovI7MpYvf7YCPZSvqgiiRYQPreb5SlGGMR3TfCoCIC+Atzov36S?=
 =?us-ascii?Q?wAXNP4l0MzyjzTk1jLEluh5zHEdNXRP/9HbycBaotEGHCSQV2s7bkwX3AahD?=
 =?us-ascii?Q?/sOwnzNO7Y/shPeLvF+G6TngT8/BBUqMyEeWxcO2kMeZeFnpzR7nwRvQk/4N?=
 =?us-ascii?Q?q+KSI2ONDBEL+BRcJi+xabGrqDZIMuKcYhnQhaZhXr7LDyvOWyZfQ7Wyz7bO?=
 =?us-ascii?Q?JQh3lqyQ8GR2UERPZihCopWfYu9d8saEVNwhIiif/PsSolSl6SPW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c12146-0645-4109-160c-08defc21553a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:35:22.8347
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B3I8vvWnxxdzhAsvnpL3kY9i3zW1mHcr9wC11nAkN3RQ3TSo57yLLvaQo8F/FbvRHSYyvO4+xae0tmreXXGFyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2996

ntb_tx_copy_callback() invokes the client callback before returning the
entry to tx_free_q. The callback may wake a stopped client queue, only
for the next enqueue to find no local entry and return -EBUSY. The window
is narrow, but the retry is unnecessary.

Save the callback data and length, then return the entry to tx_free_q
before invoking the client. A completion callback then means both the
client buffer and transport entry are ready for reuse.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f59f926d4bfa..e92b96f4afad 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1719,9 +1719,16 @@ static void ntb_transport_rxc_db(unsigned long data)
 static void ntb_tx_copy_callback(void *data,
 				 const struct dmaengine_result *res)
 {
+	struct ntb_payload_header __iomem *hdr;
 	struct ntb_queue_entry *entry = data;
-	struct ntb_transport_qp *qp = entry->qp;
-	struct ntb_payload_header __iomem *hdr = entry->tx_hdr;
+	struct ntb_transport_qp *qp;
+	unsigned int len;
+	void *cb_data;
+
+	qp = entry->qp;
+	hdr = entry->tx_hdr;
+	cb_data = entry->cb_data;
+	len = entry->len;
 
 	/* we need to check DMA results if we are using DMA */
 	if (res) {
@@ -1768,15 +1775,13 @@ static void ntb_tx_copy_callback(void *data,
 	 * "link down" or similar.  Since no payload is being sent in these
 	 * cases, there is nothing to add to the completion queue.
 	 */
-	if (entry->len > 0) {
-		qp->tx_bytes += entry->len;
-
-		if (qp->tx_handler)
-			qp->tx_handler(qp, qp->cb_data, entry->cb_data,
-				       entry->len);
-	}
+	if (len > 0)
+		qp->tx_bytes += len;
 
 	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
+
+	if (len > 0 && qp->tx_handler)
+		qp->tx_handler(qp, qp->cb_data, cb_data, len);
 }
 
 static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)
-- 
2.51.0

