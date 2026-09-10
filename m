Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE7F3A4F23
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013346; cv=fail; b=vChqEjHwaQJDrYlJeruaNWU9WXS5hjStvH+Hd9UfGfu805zwiokNmyxRHyBk6++Kaybh1cnFH2liRmA/LzOE0AkPA4/mCRA9omTr37AQf2KbgP5ey5UV+rZO+Ip56XGogdmWRiXTPobuSrXJPtL1CVmXrfi6UZpmStYUZ2VbNKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013346; c=relaxed/simple;
	bh=MUzDHtqekLlOGoqVgkzcewaQS7TVo6UWRqGxcaU1nnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=q9i5/uAnN9WStBLkIZ45vAeLd7VlTbpoSLK0hBkrW8J8omlNofmnIzHwqXGsq2DWDq6sIUn15r0vHk8MhRrIdjQlYAqMgtijwEYdPhD9nE9Z1Pl4DhR026EiEILMgRV48ySPzFvWaVYg0Rf0TAaId7n02FDoD5BrQ48yqJAyJic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=X64ZX1W9; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="X64ZX1W9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ss3WhHMeVXR5ohz4Oj91hLPp8lLVRrCuPyK5dTKgDZfAXqQW96hwyJPo/LQe2+G9pbnofyIu+MTulZUn4TEDZ5Vlwzk0OEBsATnK72YRXeguG20tB8bRN0nfuvIGTrMyBnLzrVJtZ6umhOidFIBw+tWVNj/n1oftEKIza47wfbEZ7LtDSs09qt7ZAdW5K1UxI1aGEnopEy5YpVhZIEz+hj0H3tdRvhqjE9k7gp3m0+0WOGHC4u9VpKW1SKcNXGRhRoB9LYppcYtLhXgX1Fbim0yF3NPj39DFuIL17+EaHOY6FYSqlGI3omwZ4EyBTBs7ZYZYv9lJWpGUu7GFbxhpmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bxt7HHRZbev5K9lihYJCgPk3oBnjQwM5KgQkpw+kJJ4=;
 b=mYeV3+AhFpKuIEy/ot0ktlU6QU7W6InUOAgZNYXKjpC1Ta2o+vl9TnbrkSkGjzi53DtCvXm3aBUoy51cYvxp85ck2+B7AaRaktTVoeOLEGqFA0g5bJ8l8sWQqm5JSQtEUBc8z1y37pyXa4vpP0weVn1DuaV1PtysQHAniUsmOs1JO59uYsdQam9c4PFVEIzgYCIHzkqfRW3aP5oBsuDTFjt3P/ka8aZmeWUjJ4d8+YdrAHVnw2uyy3nlouFZh1gAfmh1LP102u7NxiZrEt3oDCjPnWVWe49f/wkxHBp7i0m3f2hZsDsjq/8KoyKIJT1nTnnArh+/7ODI7dxRks7hLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bxt7HHRZbev5K9lihYJCgPk3oBnjQwM5KgQkpw+kJJ4=;
 b=X64ZX1W9RdJK81ou7bWVj2K7FXRKQPNwwpBb+MtRJF/PBREYHWNQQt399klEu1hL+tDV90VeD2ypbL29A79HbTyJSzZAONqkPN7LnMY5EdC4IwITS3MpiIvV2UZb5sYjJt21YaagNQXwT5bELZsppEsiMSxvdxOH5/Rlks8iY2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:50 +0000
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
Subject: [PATCH v2 10/14] NTB: ntb_transport: Wait for RX completions before resetting a QP
Date: Thu, 10 Sep 2026 13:08:32 +0900
Message-ID: <20260910040836.3792333-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0172.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::10) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: c0ba899c-06b2-4739-7c21-08df0ef1381d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	09OYzZmIpyCHTMpdQw72b8UREE1hk7dZTHTqei/7/AQcIs3HzcjrluyWsP8vxw5YrwqM2xORebfLQMUdPiEYYJ4iPmZYLCSQFPVZB0JXQ+J6RYoRoQ88t5oOZQ0ObD6z8tHM+1tu/rDATgy3Y7vXt1OD1vETS0a+cAoW9cBS72WdNE1r0jre+v64Us72/6lvqx8W1vgHYWxxT1mWyK/1ObZ8zSckvb2vCr56kDwXaoZEtCdLd6/CujTYuaI74EzvW5qGXd6fKabP6JDy+oG/03nxFU+s262G0oNx4I3qoVgV1HFe2vg2bJhRc/mlBkYbARJBxIy9jgRffm+Z1dqkm2KViDE4pSroLZqjg9h02SkyixRP0WdR8iHCi/zR6Z+DF0xG904Z6XJ0BTUxyWz2/m8yCjDosjw/qmX5lzgUNVAetckNwC7ESG1BB785BZzNtlHSFRdvrzo5+SXlLfQ7noNOkTtfd+Xh5yvj7gvssP1bZ1L4tqOy06X+ZjSh7L/9jRhXrLVtorsy21tycSH1lVYn/7Bh7k5ezcGpJOAKjBty3tXSHIOEm4MEp/ZJ2vtW2by+ja4jG4oNQwgqssQ6sFXtUbj9Iam8LK4EtDzHl6s=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zXgLyuNtBZPKSH2KTpxQTjiSAq7da3duBz1hyY0S9a8+ij3j/6r0JOLvywve?=
 =?us-ascii?Q?623ze6ItX68zWrYHrhw2AhNhF87N82MyKkCi7wCFcy3o8GNKN2ADlkQ8+OKX?=
 =?us-ascii?Q?4rVSVoXcHNWqyKuGIs/ilq4/wtwIWN3FMa6ujsKVUdTVtyWSrgu+jiI4F2WY?=
 =?us-ascii?Q?eE6MDd/duiyzOaywTKX4ZrxzxTKufZjwGXxz04ttNFL4u/xZb67d1g7c1DVY?=
 =?us-ascii?Q?Wq3nPY2Myf5uFAofPb7vLuPfMNMv+WmKVG5+a6ktJn9i2Bn2aJK9ZG+wJo1+?=
 =?us-ascii?Q?bhMUOLmV0v2huqt9GAVQUia9R+4F48LYBdoP779XYphlYWIgXS27EuDhvfDu?=
 =?us-ascii?Q?iFyJUjwWrsdKfh0inlxy8aKlyLqZ93bDZK/+iw9L+au/bWNKPRM11P9cdEb+?=
 =?us-ascii?Q?rsckozO3z7HWXGItml9irawChsHT1jlhkvawBiitPqpcuDlrU4czGkypvhl2?=
 =?us-ascii?Q?tVFh/9cZ2/l9o2QsaydfzF6Q7wpDBhYvZomDjoMj85cN5qfxhFJi7jiGZHs6?=
 =?us-ascii?Q?5M9DjGWIgclPgFgHYgI+4ZsJRDGhGoZvLkzb1Qu9lASBWgdJ4xQ++jDP0z71?=
 =?us-ascii?Q?i6KimAbzvWEqYBVaBXyzkaaPQN6cn+8R3PXlK7AWyfBePXpsT8q4xZ6y/kFL?=
 =?us-ascii?Q?iL2Ds1DtDnrJY9OGiomYLEYGWD5ek66Mjjw3qGjtqhvk67VUIEZyeO9osrZU?=
 =?us-ascii?Q?yk/6Dm0DPEHIrbRIplkUtP0GBHkrFF8b6MkMm1D8vgmOT28cKXYqV5J8OzB1?=
 =?us-ascii?Q?nvKaLct7P+vVSAW++VG6k+EcTrmtOnJPRo3XU5l7XOv/VlwyKiZJO7X7VFVj?=
 =?us-ascii?Q?HNmVWtZHGCdyHsTscJ5Yp+yTzHYTplr2va1Rhe9gm9h9qPTM13b2GVVD+2zP?=
 =?us-ascii?Q?ewUfrS7Uf7t9IJdzYJeZ48Qpfa9DRgyOgfmCv5apMxGTwlcbG8uI0giWReZ9?=
 =?us-ascii?Q?2wifl4u8H/aqNqQykc3ptF2rkPn1KbROfvgNvx8eI2BTa5UDXIRbypd/v+CS?=
 =?us-ascii?Q?1HD4Wk2OQucnnWK47TXgplIxRdZfT5TJ/wdMw1oDx+V3f1I18sZQBK1/81U2?=
 =?us-ascii?Q?XLPhIftt1YH8OjN1CkyX8R4Ej+cKu7ug7Hgf1a6jb2gW/QgIUhyp6LHTKDrS?=
 =?us-ascii?Q?D7O4QmUVZ5R4XAYa12Mvc39ztdrotMto+kCp+C+tpw4GhKzNmv+Pf3+qMC3T?=
 =?us-ascii?Q?UY/9BKYccl7uNZRauB8Hd3J7KpDlupqgSI/numIdrkcSN7yqTc7wXy0+EgMo?=
 =?us-ascii?Q?PgNAsseGMIt0idUfHkxJTr2eEmRtDCay0/jHSGTXXHs1ZJy89ZvvKg/fVyqN?=
 =?us-ascii?Q?CIXpWCgUiqPbmgE3dSWzdq7MTh1GO/ghWe1TfEH8OlrKX4G2Jdt69XICIzIg?=
 =?us-ascii?Q?JSaN4rQ2xozvOUq/0dFbvF1cuJA91ozWiZKAn79jLOz8RROCkHv2xBwY2YlK?=
 =?us-ascii?Q?EsacRErbW3a2Ru5I/k22edAjYH+KksJB6go50ndc+F7qBXkR4LMLUa8dRRod?=
 =?us-ascii?Q?lz5lljrQaGiBj2y/3fPQ8ypCkZEEUmo4/bvpDgeD/O4+TXAQqwPX7hNdOhje?=
 =?us-ascii?Q?TBXgEk1oaSs023fRde3Q0svCmt9jkrx63PivxRCjG59z5qIUc3fv/YigTjLR?=
 =?us-ascii?Q?fIZGICF/pYjzLfFDC3xsZEJztjrgtTxW4QSCkh5cPYQEm0rUVKBxN7WPv74Y?=
 =?us-ascii?Q?7ojURc879v6i0AQ48W0UuNQMERB+IfM/Wmnv5t2/Zc0/Wh2mC9B5szOEgXEU?=
 =?us-ascii?Q?ZGKiGaTrbRMf2Zhnm+zyNq2HvbIXRZ3rhvbgyvYW4a50/JL90qUf?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c0ba899c-06b2-4739-7c21-08df0ef1381d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:50.2125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9lJ+Rbp2f5KUwep7Gocgppm7ys3evisBMwA9jrVADGOGvFswa+LjHplHWaPVc4Kx0x3XBuxaPDdRchiTkiBLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

Transport link cleanup can free an MW still used by RX DMA or its
completion path. QP-only cleanup retains the MW, but can restart RX
on ring slots whose old completion callbacks have not yet cleared
the headers.

Wait for rx_post_q to empty before resetting the QP. ntb_complete_rxc()
finishes its MW accesses before removing each entry under ntb_rx_q_lock,
so cleanup can free the MW without racing with these RX accesses.
Using dmaengine_terminate_sync() instead would not work with drivers
such as IOAT that lack the required ops. Cookie-based waits would
not work with DMA_COMPLETION_NO_ORDER either.

DMA teardown in ntb_transport_free_queue() is unchanged.

Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch (Sashiko).

 drivers/ntb/ntb_transport.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 36797ea3ff45..7ccba2c04f54 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -949,6 +949,13 @@ static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
 		schedule_delayed_work(&qp->link_work, delay);
 }
 
+static bool ntb_transport_rx_idle(struct ntb_transport_qp *qp)
+{
+	guard(spinlock_irqsave)(&qp->ntb_rx_q_lock);
+
+	return list_empty(&qp->rx_post_q);
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -959,6 +966,17 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 	disable_delayed_work_sync(&qp->link_work);
 	ntb_transport_set_qp_active(qp, false);
 	tasklet_kill(&qp->rxc_db_work);
+	/*
+	 * Some DMA engines lack terminate/synchronize ops (e.g. IOAT), and
+	 * DMA_COMPLETION_NO_ORDER rules out cookie-based waits.
+	 *
+	 * Waiting for rx_post_q to empty suffices: ntb_complete_rxc() finishes
+	 * its MW accesses before removing each entry under ntb_rx_q_lock.
+	 * qp->active is false and rxc_db_work is stopped, so no new RX DMA
+	 * can be submitted.
+	 */
+	while (!ntb_transport_rx_idle(qp))
+		fsleep(1000);
 
 	ntb_qp_link_down_reset(qp);
 
-- 
2.51.0

