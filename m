Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021084.outbound.protection.outlook.com [52.101.125.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8903A48CE
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791092; cv=fail; b=E4G76jrYYcRUPa1JpefCBE18DI+7jALz/zisl9wS8hLQYTSKznb5MlNNu9CqIIXz3MidBoFlgcOhTblHfAKASPffmZkCsxFMJQD9ho/g6ZGTxQbiy0R/Gtm0PcSAs3qLG9TX8r3wbfjwuyXVg1c3Jdd2dzafkInhYHXmuZ2ablo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791092; c=relaxed/simple;
	bh=YYPiuM6wE5imGU3zOdHkc9CVvczm8s1ghyZhCBHG3eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eNQpFWqzXHPsQMgJjDF+MXlX/ggOhYNXrIbTRC4s1KKA82QTmoX86a4ZWU+D1XvQBq/j4IlJkra9/wMxMj5hAOswlK0SuvVZaFFGMnZ/LLavaccd/Ij/FNdtEDpE4i3NPtfTnNBX5uEejDZRoTrLqIT6MyB0yUZRXGniVaFtns0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BunHc1QM; arc=fail smtp.client-ip=52.101.125.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BunHc1QM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MqLERZ+/rgO8AfDLvetQbTE9AKFFQM8O9mAMA94Xl6TLDdRfd4ZCYRU5BZsBlLfEXI7R+5HcAb75+/rQenPfBk0pY3oEuZ8PbiZmXaEmZYuiWE6g8TWdSkPytDY0HLt0gUQ8VZQIQU9VrRW15kySq9kr9x3ajZunWRDahseBDRUhEFzur4wBDUGmh2jnJ+R5/B8pPGx4BqFPh1Pfohdut+kqyPRpT/iQwe69JXQ7XrKzL+703kK2OfglezQYQP1NgzEaSLbEBGI0RJ9YNcUza470XHh8LdcXSR9CwJ7M0qVgD9c7tSHrn479eSFtJleXYSpU5/HApsqtf7jo0+vjjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EgIMboPI2PXczRCxr4VlFdjijVsjskPJirgV2I9loFQ=;
 b=Zoe6j18GivLrj8oFAMVQGqw2WM/FBMCpI6Sz0iwiw1qvzzIa8l63BzqL9ZT5OCXZ1rjtEKzeYxCCIfEFkK+cSa+JIYkFFn8YrwywPy7U+pD4vlpHuefuXaMtaYGxbl5ovNnoQVELbRS/PBL2dRfJzr23PxcBlB4uTuCByl29+F3AMEhG5N3DgR8NWf6L8ueGyRGjx+SnyBvjr5L2lnv+TFe8CXHH0JghFDzFFnZ7S7moLOsuhJvGLO5UEBprp2XQIX4w+kGRg1qrIAc9flFQCXjfnbUuh+Ygs65B4+yePjmdLNW/A+ixmUOxaZB1VwGWfdd9akAYN0YqlKi8UJAAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EgIMboPI2PXczRCxr4VlFdjijVsjskPJirgV2I9loFQ=;
 b=BunHc1QMSvzs5x1QD+VZeQO/LG1Xrdy9WQOeWBQNd2zfMD04DnxhM6YlQqPvXMzQOfLDeo18GVDKYDUAodZykE0EaZlNu2Pupms5rXL6iHHsN3iaQULVHCl9AgRAxmxNG9wJAbVeJouo3ALHaC8hjh8fqc9fbbilWfv8omajwrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:44 +0000
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
Subject: [PATCH 02/11] NTB: ntb_transport: Start TX offload thread after queue setup
Date: Mon,  7 Sep 2026 23:24:20 +0900
Message-ID: <20260907142429.951930-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0312.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: c861c426-83ab-40b1-3da1-08df0cebc32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pQPsnqmIDPZrGrW3wo02yIITJyiorwboR6kxmocXsqGibXb0x+4nlLywjAzppkmvXfyTViBMbpgUiLHlHv5NGjqQ0Bjzcg03yWllj0uxUEJ7XFtQ3ZJTirER7xPOCX3YaWGnED+ipUenOQ9j1Cjh48WdjO9qZisGk3TowAqeH9qw1YrxqYRxK1UzwXsps5x5gE1hJi2y/5wf6bwxvZWdksxXK77S7X/RbwMXBvs/dU4eXYeIan5y6J4Gql7FSSehnE/LjS1i9nZmRB3O5f35VgLHGsdY+ngoRNePXwtfmfGFMBf6+VhEv70esUl66d9pZzmW24jnfHp9eiKoB7KCG027tjtxFjy6upcoDhYvupOietS8C5bwljj2fw1ZzfX9eGhNyOUYyvrKcpTsajjtcWWU4CGYmt5HLa797geicIEVJDt+meuLVLUIgid6EYj088RjezUlhbynSy12F9IgNcNydSF4xyPLGJgd86U70Fid0nFkQ7wf5X3qgL9ikwl/4LRxJQniWZtIDpRPR6TbgEtQVJMohUBvehCW913GUc7b5uogS9FJNoKxlh+c5yAULl6TKN/dC6d4Ly1GVd3w0QZojoLbajHJ/eLMPKuA5024ou0S/mv6ON/gKFSwthFZ
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h7ciE/chcp/G9GsGGVcYHAsqcZ8Wj77+gcTSuoZvs1UgXPQk0xHZ5EK8SVwy?=
 =?us-ascii?Q?Y89fxwKzQM46V8bWPaSggmNiI0UWWh1H2f3bW48VwJ2TrpU6hpdgCu4fwtCI?=
 =?us-ascii?Q?UY12S5h+KItUrSAlv+EHNdFW4mTGahyJ5vDeS0nGt6En1CFumzrDV1Mwu3BJ?=
 =?us-ascii?Q?B8BBthpsa1K0f1S2MjPdEBjrwaPNGrneDQQA1XenvZc1B3IUq9W+mZTz2/W0?=
 =?us-ascii?Q?ItzqXb8XEQNpg1zEFO4Y+fDF2hEKgR00MGs1dteaaoQskEvAgIjmJE72NiI4?=
 =?us-ascii?Q?by2/fRfO92imZuEajfWvKUCB97MkyHvsaddM5nVGdHAqHSy/C95fzHTeuLQk?=
 =?us-ascii?Q?5+lnDAayMBs+Kqr/V7IyS5OTuxesno1kWFj4FzxrC+4trpwr7r/N1lGjLTD/?=
 =?us-ascii?Q?5UFt2r8tPXYiZLa+ty7PPoHNk7UGAegDzBi6vlwT4Y5wLQjSxY6irx8plz/Y?=
 =?us-ascii?Q?L41CJt72KtcDvhLxw84ZIM0BX5xpN7bv+ZB3SYft3Qc0A4njsiQcAW3HI3SR?=
 =?us-ascii?Q?CCZZRSG14BRO7cIQI9lP8+vbw8yzZAJBzlkO/hoZANHtYNRFEV80pbovbmGM?=
 =?us-ascii?Q?9/szreX36Tjx1uN97wzSFeEliOKajBvNSiB0oTfeE35MRLIbx7dnC4W0TEMZ?=
 =?us-ascii?Q?BPKeNPgjJR0eJVk3Dbsl51NfJHTaPkTt4IJWKjsXQLVbsgUpWsiFa0stmuKb?=
 =?us-ascii?Q?BypRp/nF0YfZTWp3fE0Yq1nSMjs86MJe0uylktBsZoc0LQgMSQxWU/mBQk2x?=
 =?us-ascii?Q?z7SZiYlIdWcyWxZ+Y2hh/slFWeDMmMo+fVPidTHw2m5UhPk64s9kptU6p60U?=
 =?us-ascii?Q?E8+ieH+mzZJsXld1zcxp1QDOzW7vBNVltcEAuleEvRWk+xpUMAFjOJRnFUPy?=
 =?us-ascii?Q?EoWCDj+pRK48TaQdnCn6hWqsJIZ2ddQDUCTipwFKUonvCXW02SyIZXXZBW+K?=
 =?us-ascii?Q?bwaGQrpYMgjrHOm9Xo/dyiyMRNW9uhxxereBNqWdB3Wr1XTZWxk6/mx81Ndn?=
 =?us-ascii?Q?ewXtriTSXqjFBtQ6BzWZCyjZul+C43aeiDKgo52N99cpY7mcT9OwvZVK7H/Q?=
 =?us-ascii?Q?bIsT1gSgbtUf6zwzcFbU20JTSQjZ5EgBpJZcF2vETXvhnNZw9LChX9nqGES0?=
 =?us-ascii?Q?7Ebx9LZJDc/i2/mc88PUO/A/zQptyEkKzOGTDHl+Ph5Es2gjXKO0SJJXFwmp?=
 =?us-ascii?Q?hNbz3uZ2sGD05szCphVzU2VDTASM5PGFTANERNSYM8wMJJMyj8d2hHKC1Sdn?=
 =?us-ascii?Q?QsWFOmhEzWzZoU//k6EgU3JgzXVLuxemiWeiomt15Aolm+dyjUQwBmLECuIw?=
 =?us-ascii?Q?E7nZjm+NDJezgEQlwQs+XUMNLb94ciFa+04WB0vIP8/DmHy9J01VHFGTABmw?=
 =?us-ascii?Q?Z5Xv7o4M1Yf+llKF4gJAc1Ag7mPoOeagjAkXVB4uKpWdxca6dC7CVHU86fPW?=
 =?us-ascii?Q?EfItyMuD1mPAAyvz2wTUxB/ueA7P/XIo6Jxo9Em7niebObF9HXR2Svi4peho?=
 =?us-ascii?Q?hby0noWTBig6xbpmD1V9p+oMOoGjmo/9NS4iwudHQHCHIiD5Z05w5gGs4ngP?=
 =?us-ascii?Q?CK5q9wsIObgpDZu0k21BLK1y35cO9BaPjWpm5JbOf8mYzQKrshoqmJjfzGxG?=
 =?us-ascii?Q?l2PpWU/gdbut4NAh9UXFJQIl9g+8+Xz6GGzZ9sQcRNR1aibL5dVOnICAs3yp?=
 =?us-ascii?Q?kKdBOJoiGkmyxnTzcS6k8OlW+ETs19krHlXGEBeIhZkeG11H78PDqHHgKn4P?=
 =?us-ascii?Q?kF+ba0VcQHcOXSNEz3ZM/exKPEMSR54GftTwKDovPGq9Oe3EJpuQ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c861c426-83ab-40b1-3da1-08df0cebc32b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:44.1598
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lTHuB6Jmns+xn4h/5oIKfEy/c69T7yZfjCJhNXpRaUA9gYzbb6GE86fhLbJU2HHktTUSAKFdOLue5qWXARmRSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_transport_create_queue() starts the per-QP TX offload thread before
DMA mappings and queue entries are allocated. If later setup fails, the
error path returns the QP to the free bitmap without stopping the
thread. A retry can then reinitialize its waitqueue while the old thread
is still waiting on it.

Start the thread after queue setup.

Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Originally submitted as part of the direct TX/RX series v1:
https://lore.kernel.org/r/20260810165136.2292436-4-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3389d6ca9ebd..55a20ae9a85e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2055,20 +2055,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	init_waitqueue_head(&qp->tx_offload_wq);
-	if (tx_memcpy_offload) {
-		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
-						    "ntb-txcpy/%s/%u",
-						    pci_name(ndev->pdev), qp->qp_num);
-		if (IS_ERR(qp->tx_offload_thread)) {
-			dev_warn(&nt->ndev->dev,
-				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
-				 PTR_ERR(qp->tx_offload_thread));
-			qp->tx_offload_thread = NULL;
-		}
-	} else
-		qp->tx_offload_thread = NULL;
-
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
@@ -2129,6 +2115,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 			     &qp->tx_free_q);
 	}
 
+	init_waitqueue_head(&qp->tx_offload_wq);
+	qp->tx_offload_thread = NULL;
+	if (tx_memcpy_offload) {
+		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
+						    "ntb-txcpy/%s/%u",
+						    pci_name(ndev->pdev), qp->qp_num);
+		if (IS_ERR(qp->tx_offload_thread)) {
+			dev_warn(&nt->ndev->dev,
+				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
+				 PTR_ERR(qp->tx_offload_thread));
+			qp->tx_offload_thread = NULL;
+		}
+	}
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
-- 
2.51.0

