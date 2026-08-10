Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B06431A39
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380733; cv=fail; b=jFL5r0AlvEbJrKhfYC+1J92mq3i/csMaSZMTIvvH8pHt6d5ccIMB4s58JGhrKkfaN2Eh+yt5CMu5SSJRbvxBV6PlUQIybUyTEPSimBHWMIsWORpDEl9Gs3YnmJlCr2kQoXnpMw5IwD+8UHgfq9hIyhi1IksLljzvrmNWBXLpc+8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380733; c=relaxed/simple;
	bh=Z4cfJn0F3/Yb1PPIyT9Zj/QxkFPT5QTMlHYbIhkyyaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tvfnS+RjoaVM/rNDBPtLxwB/brjLV7/VCyva+AQMd9mqBa82hioBFPewZr1BxTBpcPLN4iKnmjk6g2MZ0oLL20jY6uOh+4RJHueBQNwzr2DP4ZCgc+fUW4K7vOnf1y1pFN6FoDRtKynX21OR/5l1fJiRwXEWj9x9MRSE5SPvM9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=QJD5HwU+; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="QJD5HwU+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4J2XBaDuwc4W0Cuy/YzVIGaG1PyI7iXpDukRi89WqN4rq5eb5iJTh8ll4GAx9JHKXkXDoKU5BIuy0oifTgzCYlLLmGJ1JhFTOOx32AHzdmhIMELe74MwKv6h0H7GsiWH7VIVc2QIZHjuQo9ikgiuBLY1kQTKumpWtz0uzONisfBsnbULOeQzAN9xgcbbFDqwGpYq6/12YuEomp/vHEk5LatPZeZJfaRYVlkgYb98QKHFATKjn977RrxNLdHaaBLYwJsbfLbYKPmhHuE/6sPUKmOUr+uHPh0AsE2Ei+CR9/auLqHK9VYgV5a5CUebJXBatEKYJu5BCkqg2xLXWpzqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/sWr+aZOpWqWZBJGFAVabsK0O7OqqBwHQiSZA/HPYc0=;
 b=zLXUemBkSRDbdTvE8bcd6ZsnZPgCIOZxjM/0e4vBe6KP/LWRAqkkpROCR60Ymk1C5Md0MZ11puj9cW/img/Niw5sk8/qC3JagkSelUua4IJV/ldbU1uxVkSVK0yQXK76T9coJmjvxZiM4A4g1hZJpaSNbSqNnh5tlvT1dFfMbXHuLHxZg20Wgb6iq63leUTkZdrDwhvsUeCaH/fbKyecSu2ZLlJoAO82if7fsHjvByc6np7ghY3pBrzaH9eooAIfdz2+YglKYblviS1Uo6ilXr2IDf3CK1XjyM+RD5G2u9yQu+v3Q9RCKHF/ZLg5D4VK0hRoNQ1/YOsWuZU8vi355w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/sWr+aZOpWqWZBJGFAVabsK0O7OqqBwHQiSZA/HPYc0=;
 b=QJD5HwU+S8a/LyYkFsZB9BtpEYIpz6YEe1A917DDnm6RUYVvgZMbae1/GhSQNxMlymZeN2UaAtJEpFJhmaCOmM4pvL7xwnfNmIHwGO/5rC4hsMPMCG/+jMy5igzotcj4rmMmng9QTN/bIO1XDO3EIEsRgD9vPco1G5j3d0HlGOw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:54 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 14/16] NTB: ntb_transport: Enable direct-DMA queues
Date: Tue, 11 Aug 2026 01:51:33 +0900
Message-ID: <20260810165136.2292436-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0120.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 07d40194-dff2-42d0-b3da-08def6ffaf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	R1guuzx+KZm3PJUFY8Bxs0a0OtMR4c6HsqwK/+TqfEobuISz5faxYgbwd2ndg6j/M6kkBRbW+GGwuQIj0MBmmjc4o4N3slsYux8kHzZ7BXCjg5wwR2oBujzhEvhNcuehAevswJ6c+Sg9Ib83dgl9/WdtAOXuL7n7R1qBfgDGD/5x8GvdmK8BcfBJd4UaqL0NElsu1i4iWgQxa7dHeTBcFGQw42etaEUeM05eLGIgWlaW1CDRT49k6GFe/6a4Itr+gi0KcX/Fxs7C2/3cobCCQlLDVtWcJs6+N6j9mc8koFc6whDKuvznxfjFumDOOGlIucdCDGc3yr6TUvbg5ZQNYhb8pPJO18muoLCmWoIAgmz8NcGmKmcoGbpGrmRlfYEtgplyD4h+776g0si2YSzr2qw0hbUblDW7uSPbOBuJNqcpa9B/uf8q8okjuQEvECxtPRwfTUS4K2r4HvlfkXE6JcOIMiNIXSz4apWBiqvTlM+WSyr1g+pSuZJslYwlvxgfO5ZKwIJNTUbvThEo8e5AyAoB+cDyNyMfxac84uJ0sTTReVQ9cdVRgxcbAd4PQaHB4stFMxMkv99y3sUpUFlBX9sslp33HEG7iJJnt3D+WplraDLPQlMk7bjmVTSBR3nGBvDCImu5ohaZvMTf4yQpZ2Q/w42z/s1lSJDDbz8YC6U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6TlGbhD7RQxs003Ccl6F621tw8tqwZdzeBu8bhJnSiZgbeHjcJZa8Xc5Rmpq?=
 =?us-ascii?Q?dDhBtV2diCQT2r9EYGJof+IpwV9AIrKA4JPaycGkRzrXBqRtqlPCXWqctZo9?=
 =?us-ascii?Q?EYHrtEQz/2/LCOGxcGI+a+j78i1yykyP3YsdoYSwxYQxdZeechQ/UTwbJwqO?=
 =?us-ascii?Q?gVqlbU6KlHZlKiuQcgJPRBxjyFFBKJss3Qz0ojKLQVUufjEBnsHq76XQZUW5?=
 =?us-ascii?Q?ZnIiqi74TgPIem19v+CxHo/h1AfauDc2CathgH74lxfEj4IdVuKOdH6qr1sd?=
 =?us-ascii?Q?XziT7NhTpxAhwWGjohD/WNPG9U0Nt0fQHQuTlnkLHxptYqqBvfGqWNsDPbqD?=
 =?us-ascii?Q?TpfQYH/hX9xcdAwuYnWiXtEY5BK/aJmvxhS/rFCzvXSOvLA7yr3K28qQ96K0?=
 =?us-ascii?Q?1/qROodD82/fI19xE3PpSM1KHVrYVN8dMUsdt+FNquKXkKPqT6QIDNC1Mc4f?=
 =?us-ascii?Q?SxLGihXLJ4liVik7QqT35FOVFBw4HByBJhS44ZW18dc+50ToqdlUWNSFXwZ2?=
 =?us-ascii?Q?AthtzHYTBWTP8M73zP8Y0ynr351Y/eNwuIjFrcS3k+JD+IkVbGGN/T/+vRgf?=
 =?us-ascii?Q?5liBk/gdIaWLxTuVWvLO9MB6X6ex5m6ks4cl75gBq1gRVS3e+uUuD3HK+heS?=
 =?us-ascii?Q?+CAVO2jHh1LGFr0JuDYWT2Jlt4qWrD12G+FgKVaMlRxcJJvmj5g5gHhGNTRH?=
 =?us-ascii?Q?OAmnSKr5MwBAs8RYD/fqXATVUEBlVTTpU0Xr9PJBrEc79HXao52TA76pb0Fk?=
 =?us-ascii?Q?9XCTSu9ufI885gHBlvBrwVtIjTyNo9gIO8B5g6nlo7R/4KOJvP5mf2LKsl0/?=
 =?us-ascii?Q?osEGbkV2L3xVYBfyBliS173oYtAtqqZNPmWfpldBzbTUe7u/PhKReef5BjcR?=
 =?us-ascii?Q?Q5mb1/TvBMp0HD8RnXTpjOMjqJLh7eDVYOKDyvJSLDq2gFk3ocihIY6oL29/?=
 =?us-ascii?Q?+f3tOJ95uoNq+Z4Q8PE/0SInCpkmHtD8AtSirZ15mP91jEPFEMIkalapKt6i?=
 =?us-ascii?Q?VHMs1Jn0gwlNJ3FdsTUvO43bK0q8oS93MbFJbkzEcLge7ie+tyRAxv3hJNeb?=
 =?us-ascii?Q?FPJ1bztZPvV1n2YmS20fwliqycQCVD/i7P0STjod34B4djJGhY97xbICL8nC?=
 =?us-ascii?Q?tnVl3tjsMh+1ucGu9cCy8XW59CnYdXgBjHauhSioUERjiw6J5dORChg4Hci8?=
 =?us-ascii?Q?R3H0YM1uTHRhAryw4JAAIIv3v45CH4L8jHA9SrCIutHGVjyxQEHEXGyry7eo?=
 =?us-ascii?Q?OAc0Td/F8pTYACc5v1a4Tkh+eFUOCOfe38V0Cl4cx01ZWmj8sJ/c+I+22FQ0?=
 =?us-ascii?Q?cZeJa007w+ystIeCd2Uj7MzQbLMuxKLqboYo/jv2Zx/mU0n/TjpZTcP6RlKy?=
 =?us-ascii?Q?FgovT04YrXXkoINEiXIfD2BGgTBFHaT0191O5ZZfMmtzCwWOcJMAyrFOg7tC?=
 =?us-ascii?Q?zo87IXoxTbKngHfc8fgw47JIaDaA4XRXDAS6vxY5yR9AwY6hl6LZfMxR8U+T?=
 =?us-ascii?Q?ktCuCsgETsTVHbAHloa/200v9d54uyY3KeW6oh9Ng7TXRx0Ola/rivFa2oLp?=
 =?us-ascii?Q?9Hu/ilhUXoBXyfZAi+sZ5xUUwSsjPh6p1foZFqYwe/58B1RNouwsqYMuL6wJ?=
 =?us-ascii?Q?Tuv/rMICMvOvCpmonHA+lGDrFx1YZBCje4nj0y+Hn2qMaay4rDBcD+PN4MZS?=
 =?us-ascii?Q?OCw7CvAd0SkTzgUk2NdtZjeYSeqDroHeNHgzI1yjOAF9oCsW2KiMLSX/RjL1?=
 =?us-ascii?Q?x0f5Cmuow2eQTv526/68DKjuuPGqzL+6DXDEWT9TgCTZA4jlns2P?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 07d40194-dff2-42d0-b3da-08def6ffaf22
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:54.9121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V0W+qIASQ6HfA7NxhuosXPzola7yuegl5vhl/8E2Q5PqI8o5A9DqDES/tsKwVjaZCbK+RBlINxstJEiBWqNjdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Advertise direct RX when a DMA mapping device is available, and direct
TX only when every QP has a suitable channel. Negotiation can then
enable either direction independently.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f2fa145994b9..9f5d6a407be7 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -554,7 +554,7 @@ static bool ntb_direct_tx_mode(struct ntb_transport_qp *qp)
 
 static bool ntb_direct_link_capable(struct ntb_transport_qp *qp)
 {
-	return ntb_direct_rx_mode(qp) || ntb_direct_tx_mode(qp);
+	return ntb_direct_layout(qp->transport);
 }
 
 static void ntb_transport_notify_peer(struct ntb_transport_qp *qp)
@@ -2058,6 +2058,11 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 	else if (use_direct_dma)
 		dev_info(&ndev->dev,
 			 "not enough scratchpads for direct DMA negotiation\n");
+	if (nt->direct_dma_dev) {
+		nt->direct_features = NTB_DIRECT_FEAT_RX;
+		if (nt->qp_count && nt->qp_vec[0].direct_dma_chan)
+			nt->direct_features |= NTB_DIRECT_FEAT_TX;
+	}
 
 	mutex_init(&nt->link_event_lock);
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
-- 
2.51.0

