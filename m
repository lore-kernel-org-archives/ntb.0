Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED473AA9C4
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791095; cv=fail; b=KTULhQtaLqkEXKP+xEqFc5SWlFoOtluQJqJrU0nzQSwRREdG9ymHxB+8jhwIQMvW4LhGPVUmfBflO3qAScC99tVSpY8iNQpdqq1MALOkuwvEJ2EFKIhk07QX7Bid3fxzse7TcscVlW3bbPno8wktzg5ZnHt4Adt/MDWoS4HodqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791095; c=relaxed/simple;
	bh=T/3TDedQj68pvJBWIdROG2PlY7D0SJa0YVr5Y7uJvzI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eXhAMpzMzpWie/0FDtr8rd6bJz/JhBFHLWaErlb11KdzPQ2eQjTA9JJZ5rzuRf293HmlWxW3bR2YzPo0Au2aQEOqPlOwn6Au3uZ+0pRlDnKrer4PZOEPHVcgDnIiIxf5c0S0Xf2/6kbmI12OBO31o//J0mozTT4xuDS9aoqz+wU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=PVR2Ae4m; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="PVR2Ae4m"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LtZYjfjA/uYAyLpySv9R3oIPzuUv4c0qF7wYoBxRcRIX+j+quB47SdQRSY3XyFPpzCyjjG9TwZFXP0JJ4z3c712We7JeIcfj183VNzyXcW9kRpljB51r7DWkfjnat56243LKO1IXW/BO2v2GYp2Ly9A/ivW676siWKSVu/ucVRxc41LI5RyJW7uoqCK8ovbJIsToUL1U799+5Gh7vHL++5zuduXj2mT++cu+HD8c0Iznjrkme/Upl8/L7UJ8osz45g1ZH6AVgX9jox7yO4VGTppo82tc/jUWj63ffGFpqMshTKpdZyo1fZz59qZgC5p8+uLr3FJogQLuOaksbiINOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnCPzDt7Egu0MfhRa0KD83GyM52Kj+hgoj8kQoDhNNw=;
 b=Or9MpTo76IrrTl7xFbcCFnymND3qLB3Kb1xa78qSJb9CbaZsJhjbOG1fCit92liSArTSUOp3JWtPqUN0DEAOIt69bMyLr63voJToAQX8Qki5sylYMtZU2kqWajWxkjNH9z67+I3QkBbIzJa3YHDbx4ydTTt499U4H92N9weywD0qsZT0DGPlbsZCJerFCr6Q6t8tIQ9Z0pdrFPRxJxwb4OSbtVThRr+S9eHIGNlIBMEp279CTaLjZwMifhhVg1ju1ZPHm0N0t0IYzA3gFVMOh8MpFNJ22rpwWIxxekihT7oBLmgGXFxBar4DUyrdpTpAO7WW3QUbRavZVrAdbJY3Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pnCPzDt7Egu0MfhRa0KD83GyM52Kj+hgoj8kQoDhNNw=;
 b=PVR2Ae4mlAkWv3iPcII2MnVXTtUy8CsnnQ3B5l049+VOi/4htzdZhQhBSMKBG9+P+lSfgPm1/XsgexYM0xWsi5FLLYYQb0XoQWI9Vbe4LxI0G0Nx6G56TtSVLXmN4j9xs5f7t6AraSUUNbwqAd0KLzSUq0O7nuN8S9UYWHuX50Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:47 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:47 +0000
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
Subject: [PATCH 06/11] NTB: ntb_transport: Publish link state after QP setup
Date: Mon,  7 Sep 2026 23:24:24 +0900
Message-ID: <20260907142429.951930-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0122.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::11) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: e6585ac2-1c52-4566-a1be-08df0cebc51c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	j8HgbUxJ3tIxvTbyRvwP0BoJSvXEZpq9zRWq36m9L01MHJr1TXe9LlflKAg4O/U8hS2C+oxphaQaiVXdEpzSpTsw0689YAxpyaP58ZFxZQOH1H0n1t/Z18TE2JcRss9RtL2or9fFIWHrbFdn2jQhG1wNGDVLgJKENj+jvjxtlpGU1eH4sXDdC0pbfsSA3P7nOo5VzZikhbsFT+IGSPaau0pYHWeK0iXj+I3BZqHu3FlqEYj1fuY5aOXjI6NWK+W+e3eO269k50BYpHlswfKVn93hYLxIBItbqnPw7UMBH1NwmlFTtXIp0/GHxRAwtBuoaT1NpEpSXEIHgXvsNiYOnobnEdVhmaEGpD1tLEfDpA/FjBOz8c0p1c4OqeDlSVxtAN2ne9oa9k3acJvsm5nx5nryvR7Ez2o+A5tZQSu5C4Cp6BFKpcEOs96pg6HnvSVeZfcGvRZ5xD0UtvraeQGh089q8a3xxxH6BoZVdbg3cr2N45b4O6HktJypQnikd1NGrxTz5SXWQv7AGan/ee2rIfEFRKoy2lWU4PAvIjlHgoagmvCH2GHbUzU4h7JE45V6OL7FM3t7fr9NFnMTv7A1I2e3HxK5rCqGZb7jREvImUVdwseq9I9RN7/lowi0eSCJa0ucyzG/zyqvGnFrDgPTHsinEq8XzGh1IOZwo5JtfZI=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+f6HOou7MdcyMVTSV63mOku/KMFcT8HIGj5aM24ON9yxn09p3F+EN9s+cBx?=
 =?us-ascii?Q?OURi/PQQrRGFVPYJiw3ZIR86lkwtoz07WucCYEw2s3wz0B+y774rZwZcXuw+?=
 =?us-ascii?Q?3kKMMCAU1cPB1whMbpcYJp9vQHALiL1v3ARsWdqCGrLg3ReJHi5nHTjV247i?=
 =?us-ascii?Q?3SGApix6MGJnX0tMJL6YMsogzvlO6B8j5FUa66fpzOTd16B29L4csMz1Htm3?=
 =?us-ascii?Q?IhlYUBKlotw0qrghphMufQ3ZPZ/ti/lpMEkJprkjHkPlQC+91AfNadF2nzCh?=
 =?us-ascii?Q?I7c1E+vsfD2dV/WvRfUh2DI6vp1+Xi+gwZNdGgAM/PO8fBiy07PMjK0rRoaW?=
 =?us-ascii?Q?bfGoxxQv+Rp/5GUxy/TWqa9fxR+FdJUrm5lp0hmcYXirEscpqHOQf/Qrzn0c?=
 =?us-ascii?Q?jQJ6Hf8sfkD9xsjveiDqF+euenc2Hm5eRYTSalIfHFOQ1EYxuEqRwIc2MIL9?=
 =?us-ascii?Q?Qoq7X+bLCnN4VA1PSfBGFUqQGTAA/9dnjGea92bFfjjM2+VksXLwn7sf7nG8?=
 =?us-ascii?Q?/Q89pZ5qEC/r+yyox8ovTUmgK+seD6/6BwiQMs7T7Lu7n3/bGu6SMeoAJWno?=
 =?us-ascii?Q?seX6R6gBWskxnKMwnpvDsW0lMZf3EEBN7uufISA5H4BZlkFXFu4XndQjrmJo?=
 =?us-ascii?Q?01aLu/BwNKlJrwKBtH82xXuEuQ+VXvoqijqmHVEgd3hNxYcgeb9toqnAX4Vc?=
 =?us-ascii?Q?aOn5RrUpq71tGaEW0UezBqvP9BWZQXwFawzGNYr3KqUf/4ljVomactxreG8T?=
 =?us-ascii?Q?2vdMf8adw3fLPdrO6keAsBEJD7AevqIteREQhSqb1JATfTj6Y6bPnfJo5DfT?=
 =?us-ascii?Q?OgMtv7+XnEVpI3v0vxoYeumMSTg3SaUhTeYUT+XQGQNPBJVH8Pm+hChZYHRO?=
 =?us-ascii?Q?+0emssXTo/DJiR6khqjttEbIsMi8L1wzeNrO6rDz23uXPFymvuIF8viz2e6B?=
 =?us-ascii?Q?q4QIhh5PE40KvKyNgEKr+xnaOkghdNLkrfdcUuVnfsBdcz+n63S9LMHECvoS?=
 =?us-ascii?Q?mTdqlX8na63Pzm3CAxfMcnaqv43DkkvFIwjrYd/9R+FVrgs6YzcOKdQ/3jYr?=
 =?us-ascii?Q?bXggzYMztgPVUQawO9+PPmumztmCYu/pMK2g8DWcFnUn+IRZWn7wnqs67hiY?=
 =?us-ascii?Q?mzUGy++HFy6wB/racH9EIJ9ertyaDiodjIV84q7oLKd0zyHBRy/mRc9zogKA?=
 =?us-ascii?Q?kyzUDuGh2630nLnMcmMg8eaoNwyvStHJQQgcQx90gzlZh2ID6Uu16ZGMX4dO?=
 =?us-ascii?Q?dnyYxFfNaRX8jekJy/VFIUJlwbjWc4LSAYsmUzpVraQXPzbiN1ex+H3XMWzd?=
 =?us-ascii?Q?3xEXVBHP01TiBhIZJQtjm8JIj1APtl4PJ5MDUn4jq+4isLxsfN7qUtQuYm8a?=
 =?us-ascii?Q?nhXUe948u56nPsn+pGkxSB7qqgtcbnfFVm+acolzRmPKemCIJWf4dx/MiNb1?=
 =?us-ascii?Q?Z1NKyM5dhFKMW4wWbdw2YqWq9ecY2//nsutwlCJQszrKM9lts/UNEdo2LNDx?=
 =?us-ascii?Q?sJMwmYfgVzUBOjCmhSmvygAcJXr+L2AbxANEaXpUJ05iK6KR22TuwjVKAnB0?=
 =?us-ascii?Q?URI4iEMKV7hC7h8LYop7I8SrSXvWFCGh46kqc6X2OugkFLdp0B/IHk+Amr6y?=
 =?us-ascii?Q?XwRnVo/gMeU6Gp0VIUIuLnJ/AEM+ADbSj4d9Nm+TxSkgSm7VpmncKpES3Lsc?=
 =?us-ascii?Q?WTgqcqD/EglGTBzzpyDJj4DQCiaNI+3v23B2fc/z9Iu/cSucvvWvmZ9XgsdV?=
 =?us-ascii?Q?UKOC4dHoQ8f0Ze9f6QxT/eM1Wz/AAcN830qHmcBg60BDkwAIG/4H?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e6585ac2-1c52-4566-a1be-08df0cebc51c
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:47.4413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yq9lKIqX5XuvVTiD3qSDi5Wpj2dbo3jchfCkGY/t7UvXEmNQaTpC9h60uyUY7e29DV+rgMeIrDCQv1A1XPYovg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_transport_link_work() marks the transport link up before setting
up the QPs' MW and peer MSI state. A concurrent ntb_transport_link_up()
can then queue QP link work, which may enable RX and notify the client
before setup finishes.

Publish link_is_up with a release store after setting up all QPs,
and use acquire loads before queuing QP link work.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Link: https://lore.kernel.org/r/anyKbq3mpLG4y7rb@SMW015318
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 40 +++++++++++++++++++++++--------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index c8e7fc774b4f..411017873a83 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -935,6 +935,16 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 		remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
+static void ntb_transport_schedule_qp_link(struct ntb_transport_qp *qp,
+					   unsigned long delay)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (smp_load_acquire(&nt->link_is_up))
+		schedule_delayed_work(&qp->link_work, delay);
+}
+
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 {
 	struct ntb_transport_ctx *nt = qp->transport;
@@ -954,13 +964,10 @@ static void ntb_qp_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_qp *qp = container_of(work,
 						   struct ntb_transport_qp,
 						   link_cleanup);
-	struct ntb_transport_ctx *nt = qp->transport;
 
 	ntb_qp_link_cleanup(qp);
-
-	if (nt->link_is_up)
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	ntb_transport_schedule_qp_link(qp,
+				       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
 static void ntb_qp_link_down(struct ntb_transport_qp *qp)
@@ -1102,16 +1109,19 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	nt->link_is_up = true;
-
 	for (i = 0; i < nt->qp_count; i++) {
-		struct ntb_transport_qp *qp = &nt->qp_vec[i];
-
 		ntb_transport_setup_qp_mw(nt, i);
 		ntb_transport_setup_qp_peer_msi(nt, i);
+	}
+
+	/* Publish the link only after every QP has been set up. */
+	smp_store_release(&nt->link_is_up, true);
+
+	for (i = 0; i < nt->qp_count; i++) {
+		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
 		if (qp->client_ready)
-			schedule_delayed_work(&qp->link_work, 0);
+			ntb_transport_schedule_qp_link(qp, 0);
 	}
 
 	return;
@@ -1159,9 +1169,10 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
-	} else if (nt->link_is_up)
-		schedule_delayed_work(&qp->link_work,
-				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	} else {
+		ntb_transport_schedule_qp_link(qp,
+					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
+	}
 }
 
 static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
@@ -2405,8 +2416,7 @@ void ntb_transport_link_up(struct ntb_transport_qp *qp)
 
 	qp->client_ready = true;
 
-	if (qp->transport->link_is_up)
-		schedule_delayed_work(&qp->link_work, 0);
+	ntb_transport_schedule_qp_link(qp, 0);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_up);
 
-- 
2.51.0

