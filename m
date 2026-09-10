Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA73A4F4A
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013348; cv=fail; b=dSij+/qVdMXkACeGJNiceaPpAGHQ4PDgTt2EAUqMw102cDyvKUkJrEJB3axlLGUXpnCYbiPjeik+BRtbuZSqkym0Z26qWMTvS4YzSU6TlQJS5exkxDPrRWH6C3SqT4hZlqlhpn8Or+BVaeSDhSPYIfkB/gBkwVR+6LOfN5f/lHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013348; c=relaxed/simple;
	bh=BQT4/IeSg28atVGD5gn7ZYLF/vshVxHSBoN9BWmk9ZU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gyKmwgurQ0iD5CUTsqFogsYHINygyKk0LTQm9s5UiRnGCHXqvtsTEZJmGv5fIgCFkWGw9L6dlD7lQRqJ1HbLEWUro0xnGHECW1O5cUMRdMt3uAWyAkBnFx882Vm/YzNmMkcvEBos3uVjsAP8dFSqFiOjcQ0hRrnQfFcE8ck9QBA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=lazeGhSy; arc=fail smtp.client-ip=52.101.125.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="lazeGhSy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6hpewVlzEmuC4XwmGEVrP45KX0HOGSM+LGXsiNuX7bVl4L+ihvxTkfhJxXTJhPEWuvhCWtPd/9k3jcms5054iRljSqelBU6IfCPoJ9ifT3lIN+TGLDL7InHOuRaDS3kdHmYTZISfsvvYUXQkkcPVjYvjf9YFXDfNFziSp3g9SeDRDBUnsrnB5zbxLFiBQlekIAkzZM+en43sD0xFiEMWzt92GiJUy9bgG7n73vPyhvN+hTSv852K3X3/T5C1S8TFz20GMHPij3fVY3/R9Nl5wtuUcS7IUwC0fYBonAKU25PXNr7Y7ebWNmQ3iXjEuFdbx1uSxPy2EeTANZEb/3yDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=udYWRA5Hy6rUy5vjeDMRq33/15VR+Q6fkmg4jbsTvOk=;
 b=tV2P+00vX9iWP0JqfmLaOSaeoK49N/XGd/sLE2R8bzHUHmuksH5Z2OHD75qUnzCLHiEds0KE6+zIKRpTSrXjgUUcvV6LetLNwbB6gurQRGrdoV/Wdfe4omihJByEJGZRH5NhNaNIoVB8gChqSM+qFl9j4d/F7gFnsNpGIaQ132ArriWKl8TwfEHVOMSK1tQhY93tjyzvkTDfPLwbrgszP98tCiBd5Yp+0QM4c0avYUdBkABss675lO7YPuoU973XbnQ1hX+ZY2oaURtObbIYUEABxaX59nCC7xTGvq++kVRcWsbdmc/FxaCF8xcYcpS8N61u6eu5VpT/EnZhliqgWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=udYWRA5Hy6rUy5vjeDMRq33/15VR+Q6fkmg4jbsTvOk=;
 b=lazeGhSyNFn/gtuwT9pCxIxK1kOkMXGkrQeRfavNI9z84HGJGlCPiYpwcamECEDTRFuGdhbPckCF7xOyZed8UVeJu3fXnjuvUQNqSQxdLYB1DJ9F/C6tUeojCPCeKEKarfeGgTFCxZOXCiCBseUroV0zj37hHwVzzp6c6qGYRgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:51 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	fuyuanli <fuyuanli0722@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Joey Zhang <joey.zhang@microchip.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 11/14] NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
Date: Thu, 10 Sep 2026 13:08:33 +0900
Message-ID: <20260910040836.3792333-12-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0178.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: 983169bc-9f7c-4a94-9b08-08df0ef138a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	lhTPriVTyQJRLQ7UB7k1/AZ/x7xqiHaXFJl/1XJkxRDY6g86q32F1Nd1geU3yjuI1PKSafagCuf9AoGFlIKaE/icMfhnJQRHXSCFaO427f/balwQW6vlJzA3tS89kyucIs6Bfugf8wNxtra3NlOUK+9+kFhQhU1fZ7te5ywN81v2Pv6VHeOFK2Tqc4Pwlc3F01QskT1le8O549nyWJVm7puPeS5S/sWQVn4Fbt1vNKdQPgN+xO5ZmJQIfwZwacwglhcoM/dtdRhOC7ENe5jczxahg56L9hwHfpnwCgcHux+E4JVzeAbmFz3Iyjizto+6KKOsTmimnEI2fEDit6lKtma2DIAfBTVgb2+0SoI0EH9ogGzM09y82Ac+qJ+dvChY0k2Vbg9uSb25m5mobRUY/UuYaiDw/WxcosrXxKaaM/xpfrq5AETwgSU3EtzVBi1kAxQ4Fs/X8mI68KY50vnabZDOlcTqKaHiSi6ToRRem6HEv3xmFovt5WFbOZgi1c3dvZRm5pgwqlv+CVspYt+Fv9kcdN7t6pdaQ707eYniGN3ryWVg4oyXKtgT3EnbJtoJuBZLeIjDyDXxNoIinrClNaRUQR4X7AVkIIX6r/ELDARiFqYb3EYXNLLvAIhD/eeAkLgReM/sWyaHnGLX+Ga9K9ris2zeR9N4i3z9fS5ZqRA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1ozaEcbTiHODgXJ0owOVN3eLNaImKIaGPDjZid6Lmy4evePxClyv7yT2yaIp?=
 =?us-ascii?Q?zrzGJUNQN6+KkVHISW8824dNnKVsFXsr1AE7jBwj6AIGZYK7S8pqhpxONJlQ?=
 =?us-ascii?Q?WZ5CuN6NDdTSx5SBY81w4+mGSkTHt7GINg95It3PeFMu961PrfQW2LZdpQty?=
 =?us-ascii?Q?CAcB/fuQ4p1ofz2YFu8xVk0lk0I9nEX3Kr+f/l7MvyejSv4nILpUOR3qAO3O?=
 =?us-ascii?Q?sLJioW3yNzUgQLfVIcpVbZA+F6qf3bYcDqOG0bjDK2w5hpTgT8Nj+aCjmJ2y?=
 =?us-ascii?Q?LTbNVjYxzbfHeUTF98vnfOUUo5aVgJ2l4w7NMexy5h0joT5qJvQcWxSO4noj?=
 =?us-ascii?Q?xlrfjDnqAwZRavA4lruvhC/WaFH3QnsgskOoZcgzgdkL3uS+rd4LM31slAPJ?=
 =?us-ascii?Q?diBOscn/zKcad7u4tUtx2IQ9MbjL171Khlb2rJmCmlNCZztQpdl6p2fhrHMm?=
 =?us-ascii?Q?BdK7xodMtOP6Cu14w45P/cMDzf8o6AyLnJkNnB9xEc/3qmndS2oRlwZ+Rn3f?=
 =?us-ascii?Q?CV9s0HFziacUZAUsscOdDXuuOrYnDiPqdKNa8XENdrCkRz6QBE1yl2fxhh9X?=
 =?us-ascii?Q?aAgTm6XQasAMuD0LYwPJr31+2nnXlzCcG+Mfl6155q71NOPUOM9pq+asUr05?=
 =?us-ascii?Q?fKbuuLW6HFa6iQYSWhlhb4X4G2N4kI9sMNQpS7mEmqVO071jAJee0kFPYvZ4?=
 =?us-ascii?Q?miC6XxBpEwnuplluA5sHZDtKzqyLbhc8Vmap3T/JE+3KHyoXzh/ZihGho8cv?=
 =?us-ascii?Q?kSzF4SVCrpynbvEtUfoBcnzkZxcZ30Zs7V0gtBhN+gj5eTnhRo6mpnuDCieH?=
 =?us-ascii?Q?ACZHsAX05R4UOee46NVrCJKlXPn9K+qNERUmfgraK42Sx5GMOchFZ2f/vkaX?=
 =?us-ascii?Q?FjCAJfnFNUc0YJZXO7qq75nSeY00UjXauVWqrMLaZ6lsCgnWTAvWmbCQfryF?=
 =?us-ascii?Q?U98Y0ayau+Q9zT1iZyA4j7+ZsCR1HLvvvrBN2vYua7gfGdePxUxgJN/wDngd?=
 =?us-ascii?Q?u9BEqZN5pFi/autCl6ZdkMHP36I5nl6Z7d30kj4fme1SxDmMFmvl1OI1nUs4?=
 =?us-ascii?Q?wsEU0gfDuQa/yObn/LKzW1+YWrlcP1AeiDOuWpkhRKebDD+tv0ydrL9gu+3T?=
 =?us-ascii?Q?b8e86btUKryaK4cZgZfeoBYGxrpX9COg7UaW3cKW6rHXjS8G436XHBM6Fn4W?=
 =?us-ascii?Q?vF0aWc1mKLpamp/plg5SSbeQ0u+Ji0bs0x94GSe9A0moqTHIVau8Tvfomx1g?=
 =?us-ascii?Q?tOjwH3FV/Vyli20eQVWgzMIZXjug6otaA/hcKLnfc9E5mJecI+5R+bcepNeG?=
 =?us-ascii?Q?fP/wB8CR9zf9zbvNWaxczryp4mDPunjjrbfH5D/00EDn9pVHdEhDyNPseFrt?=
 =?us-ascii?Q?UT1vOjpxQmQsRlTFVHmGv6Y0olTS+ZHc4/Il/qXuOrnrOrsMuX0MBZq36ZBV?=
 =?us-ascii?Q?cRJD6Ttslp3P7jyTC5svYXRf/l08q9eGkfhKg63kbt6busRrJrTkFXBm7kJu?=
 =?us-ascii?Q?juTha3NQe17eGRuWmmi6r4HGjl5T4IzFz/bBcNF5IWCYjctVEvmw3E+ZOL2O?=
 =?us-ascii?Q?vkQzxTcEBdpQniAp92uogbSBpXDVJApk/ZJAUU10H/E7+TyDf90gph/PgWWi?=
 =?us-ascii?Q?3Jhmlpu/HmQ64+hvLQRRq6ld7mYbtaborJ+UhexJtDrOfSrcUDFqRcY6lidj?=
 =?us-ascii?Q?2Msk+3p2Oce2qk3Y7L5/Cltr0coB592XuQypxcqXVTYw6Lj4mDHBgtZaseXf?=
 =?us-ascii?Q?nX2sFH+xLnjP5hlOZiF2PpdkspUB+gbNkBz9i0mSKS997hSvb8wE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 983169bc-9f7c-4a94-9b08-08df0ef138a1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:51.0941
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iu8VtnuQ6eIRwL021tVAGfRBQz6TRT8adNAngKL7KYa2paXlW249M6Q0pFsKJzm0RmWqRmoj4K8bIuFMmChUkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

The next patch clears remote_rx_info when freeing its MW.
ntb_transport_tx_free_entry() and debugfs stats reads can run during
link cleanup, so make them handle a NULL pointer.

The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
to prevent compiler-induced tearing, and retain the read value so
the NULL check and dereference use the same pointer.

Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 7ccba2c04f54..b949f36a4f2d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -489,6 +489,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 {
 	struct ntb_transport_qp *qp = s->private;
+	struct ntb_rx_info *remote_rx_info;
 
 	if (!qp || !qp->link_is_up)
 		return 0;
@@ -516,7 +517,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
 	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
 	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
-	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	remote_rx_info = READ_ONCE(qp->remote_rx_info);
+	if (remote_rx_info)
+		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);
 	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
 	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
 	seq_putc(s, '\n');
@@ -611,7 +614,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
 	rx_size -= sizeof(struct ntb_rx_info);
 
-	qp->remote_rx_info = qp->rx_buff + rx_size;
+	WRITE_ONCE(qp->remote_rx_info, qp->rx_buff + rx_size);
 
 	/* Due to housekeeping, there must be atleast 2 buffs */
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
@@ -934,9 +937,12 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
+	struct ntb_rx_info *remote_rx_info;
+
 	ntb_qp_link_context_reset(qp);
-	if (qp->remote_rx_info)
-		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+	remote_rx_info = READ_ONCE(qp->remote_rx_info);
+	if (remote_rx_info)
+		remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
 static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
@@ -2558,8 +2564,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
+	struct ntb_rx_info *remote_rx_info = READ_ONCE(qp->remote_rx_info);
 	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	unsigned int tail;
+
+	if (!remote_rx_info)
+		return 0;
+
+	tail = remote_rx_info->entry;
 
 	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
-- 
2.51.0

