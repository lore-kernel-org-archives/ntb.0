Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71833B05A3
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013345; cv=fail; b=LTSlO7B374+w5lcJ1xPSPHsIjJsK4q9HAxogz/I5oh8VoRV/RGRdL3k/HNXOFrUeMmzrj3807kb67phSwGyqdb108y7biqNje5YSv9f3/IdzpVk6LQ/d2Y5mXDWJLlb1JQIWaTRUF/bPx7P/JE4oCnOcE731RJYzII8Ti+XdfDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013345; c=relaxed/simple;
	bh=txEsxfr/bw2WMg6SVIq0hGS7XmX5nMdT6k7USiQ7HDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZHYc9nt6MQ2w9E0OUnFU0k6g1Q7Vq4QUvxmf4S2hP9ktkifCOuXvSIAbrBkOqehGJCuy7ELbUAp2hnlK9g1TgDwZhgGdKjK14CiHPnMTg70xKfFV50xKrIWtMjvlyEsQ2YlFcTdqJrhTVHA1Z/rvsdIjnddgVRt/3ZG5C69XZ5Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=khwtGeiU; arc=fail smtp.client-ip=52.101.125.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="khwtGeiU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pzmK+s9xLdveIddhoHWM6h/P+Z8Sa23l2OqC4k/hDadgfSvZ7ZBxvkCUOBU43yBfGzZ3+sbPiB+sKzYPVf2ljqtAGxGe5y/13nMknS67m3bEwRgyK6YCF3t9fgvEyZhXsxYqKNtjzK5KnTlzeDiSsp3z0n0rTWTrDvdwPrlbrrDsOaBqIWsWlIRSRNNsyP56OxqCPof2WOPRSStQUPjaAFXeCxa91EnaJ2NtggMwJ9vM+5LZDmvrtwrmd74FzIAJUjGhfQeFY90DzqR+xtRpDEsUAXEhDmEX5DEi56eharhWPJSNWeSP1XmjiHjrYJ46B2dXMoP+xU1fXJmz/7bdQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l7KKvjlh3g7joi+qBg5zwTfUubTqO0PhWxs6bzlJ5Q=;
 b=fEIq8n6WNVurBaol51e70USUtcHf91TO6vut9mqGHvWjft06S+LaaiyfEKQRukiP1JF8832RoK+DadGigAjbS2z1PSMrlP3MlcahUVlJy+i9/hkGcuj0iS2ItAol9Ym+FdVuY65RLG2NnIiY5wu/GfpMOsSGQCxYuDgSElmd01NCJa+00hpmIKpPDNxIh2vMDRtqBXjhhSHvKQIcQEAFt4vyqNCqdubbQaXHeRcbfyI01JHz+14n1pAtjPGKghR2A14Qhp3ra2h/P1J1JCXASE05iOlYcg2gkNxDuBUDAQne7GkMgbFFuVmZ80UnGr2BOLrOUwdzu/V+fxsr4SIElQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l7KKvjlh3g7joi+qBg5zwTfUubTqO0PhWxs6bzlJ5Q=;
 b=khwtGeiU1PWsI9iCV5QldSeMLe0H8eA6h00fTNNsaYMkBfkr21GiGiYrgtoaS01NmF13ZVmpreuvsrJ1aWLHC9E0OD0cweMMy5h3G+nlVGie9xsYjOzLM+fnvKwGMz1nDRimj2ffP0BpL0SXbYzP+42I8N0fBTDONJou3K29IDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:49 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:49 +0000
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
Subject: [PATCH v2 09/14] NTB: ntb_transport: Drain RX tasklets during link cleanup
Date: Thu, 10 Sep 2026 13:08:31 +0900
Message-ID: <20260910040836.3792333-10-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0024.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b0::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: 169a208a-b662-4d22-bc10-08df0ef1378a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	bkHAUKXhswQSn70cv93VU5vPsi5bPMpKvgSNdun0TeAmNjrLE/DCMws54LNXRDHN/eNEjRqIarqmz99G7ioBYis9Q4ERJ4rLMZVh5qOk/MpuQu43J30jdvLMXoAn3k32PNGgfAvwpAnx10GCfOTgCiUMw6XbXQ8tRsLqFXAN/jnWgr2zHplM3lWDHLZK/1aYLqN6XPC8da5TdWq6Qf7q0gDkVYPvJLrU1+iDpNs6Lx7dtCd1ytvbRmEBUfEuU8JVxDYX5q/yQ7PWfJVLu4l2stSYgDUVl6MpxtZaE0EozPJwUNK+zCU9FgaRsyiTKztuICO85sAp1HdnwPlTfKjxoEk7IzEo/am3w9ArQne/tdRqKZzbw1Lu/mde5kqf0XqDTW4x5HuPbTmwoM3PVVVYTHPhPJKeFmbqkZHCqg9a8FsOennMnZDNdFsLlg2cFdpbfN37cPSBJPd9nUbIvbKkHaSanMzhdXNL09MgT2amWgZtCN24dqHwflairN/0d2ai7ar3tvsb7ECmZJ9KTCqgzMqYOKFk6mF4XGJfowy6ymicnxe6Nzwq6qN95zmF9VrXyzDG+CMqH9GMrKoEa7vPTmIQlKj4SdxOMlvcER6aJF0QX2e6UtNSFqQVW8YhmhS4osd6tE4OYV0isP2jPYFosg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zLXfVSECZza9i73ydmpXdik1xwLwxh8nhQNp5lE65m20nu1DCr6OkHDYLb6Q?=
 =?us-ascii?Q?kGIpnKnr+06QrrqS80yXpZkjbABikQXzUZ6sH3K+yWmJKX/Sl1mnr9hmAqPW?=
 =?us-ascii?Q?PXKIUMjD4xGQrDBWuy1jyN0uNfTQ8rNlUfxPQFokP5a6zywGiv1ZaPH5s0cL?=
 =?us-ascii?Q?Ycd7OVoeKXlAHk0dCwmC2tu2RYj3vdtKlyQfCxurE1DvxD7LUShSIdeWogkg?=
 =?us-ascii?Q?R1bZnbB6k/kT43RgStv1kp7vVA0ZJT/DBiZ3s5i8rHL6jYhdAsSp2V20IpHa?=
 =?us-ascii?Q?vlf3mWEDjlhRBtm1J3kK8A0Q8gJ8tQMD1s6TmYczjO3knoJA8zSax9GBxEAG?=
 =?us-ascii?Q?DcjCHcLxeKx8LbnYjZTtC8mA4aPP7OQZQJu5fvW2NsBqWEdut0C5yHX1CFhY?=
 =?us-ascii?Q?BUYozJiCvHt9dxNKsUzhle680W56zlcdgffY5RIe1VYmqKybb3mB43WeOJUS?=
 =?us-ascii?Q?cavkt8U05O+JbgeIiAvz39cjcx3ctxGOkGH6qpaikUMBGUFt0uKmq8XP4EUM?=
 =?us-ascii?Q?LmQ8OOH540Zop0bJp08K89J3BpdK6GvyMIYYnyMOp+kVl4NjFQjTWeQ6dGjc?=
 =?us-ascii?Q?YxwSiw52h1aspPOTjxfvtalBjDVQ4uQ1EO4MbkY99FLmZ4mnjrJZIGlwUEji?=
 =?us-ascii?Q?Pfi6a6VZnfrBj70MfiHqERRGRNdGbzTMQofX6EPIBPoI38lOatrJtxHkqM7K?=
 =?us-ascii?Q?ZSOEyQ7N/hKNk+vHuU36hR+DR2fqi9lVxiF1yXZrzl9fzVgLYgWtG5Y81Cbu?=
 =?us-ascii?Q?r3Z9fKvbPC/fkgH7zPmgghVbIWhmh7ES102k0aVuCLIZGkl59WdN+27ZT0IG?=
 =?us-ascii?Q?Ajrpx+SBTtwGEgNLNLNimIHYjxxOtb4t6zBG+GSUFFmVWL7RSSgfIJLMhwqm?=
 =?us-ascii?Q?drh4tC9QrKRJoLZPLhvOnRUqsE+Kuv+1G/kUeD2eFAS66AnUnUSoosLHAQ6H?=
 =?us-ascii?Q?XIiJ5jOyhxC11RTfjnEy5UREZRGQZK9/+aMBUMDujPx3uvrZMZj1GQdVDENE?=
 =?us-ascii?Q?YjoFBwMJeJHG6EnGzuhE+rEcofdiS5Kheus/00RbqbsdUCHjFkSouO0ifte+?=
 =?us-ascii?Q?wzW0lzNIRHFU+9I6QWOAm8WotzEhakIwbjanqnnBZZnP64kzbeklYeSKJ9Qm?=
 =?us-ascii?Q?wkVYhqsgotTIqcVa9hgetKqhIE4i956tRA8/bpetjkZeIWX5zk6BLFCTkqHv?=
 =?us-ascii?Q?Te796XtkuCUOnZ4pr6RXeJp1G/CV/6vv206MUqLEY3lwaN/4gDKdKpuMBegn?=
 =?us-ascii?Q?ANGlMHG3DNYZzXTzmDhF4/nhslUgbs2W+rX8fJuyWy1gL/48clPYSXRoHSUG?=
 =?us-ascii?Q?20iNBET/l5vTj7WQM7m+9NRFqdSYI7xoU40HsVciqeHZb74O8GTKVgnGmZhC?=
 =?us-ascii?Q?eWer/IZTrBdQwRNdpP7AnR9yVAgszolHVcvA47BhTnbysYTmqvnyJLrqFTBU?=
 =?us-ascii?Q?0qsOq8lVgb6FvZT2KcMvDyZ51qV0nhgcS0weZ004/RrT/GmmW2tf+60aj339?=
 =?us-ascii?Q?Strgpsa4u1rG8vOAD/+8kXkJtld5/e/QJLM9Jbz6bilNt0ve7HgD016MIYyg?=
 =?us-ascii?Q?hSCBjH34ZzD0qhXxM5tsRxzahL1O47JP/PadiV0bzsA+idjXnzUb1/zB3YM8?=
 =?us-ascii?Q?rNojDOcs1aSEbeSx80NcdotvaLFXNpsEONHDq2G+sxAChfMI7NLx/qxiH8rJ?=
 =?us-ascii?Q?8LcZ63ZsayvyntPmYpNMVsUaOa+2x+pmKS/yY/ar9NmE3adq88/8Nma1VHkw?=
 =?us-ascii?Q?p+/OxnZfyKUYA0l2Ed4jOLwUCYCJM5lG7ninOFHnhzCC9FOQCvFj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 169a208a-b662-4d22-bc10-08df0ef1378a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:49.2499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7iHOWzlO6QApZq0X3oQVLtLVzsnFRnuY1mZLVTTIpPyJr72r6kPU/UjT2WKWhCPDlBUWf7LWDWu0M8UyrH7cXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
tasklet. The tasklet can still be processing the ring while cleanup
resets the QP, and transport link cleanup can free the MW before the
tasklet finishes.

Clear active under rx_sched_lock and drain the tasklet before resetting
the QP. Temporarily disable QP link work so a concurrent client link-up
request cannot reactivate RX during cleanup, then re-enable it for the
existing link setup paths.

This does not drain RX DMA transfers or their completion callbacks.

Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 45d4365becac..36797ea3ff45 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -956,11 +956,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 
 	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 
-	cancel_delayed_work_sync(&qp->link_work);
+	disable_delayed_work_sync(&qp->link_work);
+	ntb_transport_set_qp_active(qp, false);
+	tasklet_kill(&qp->rxc_db_work);
+
 	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
 		qp->event_handler(qp->cb_data, qp->link_is_up);
+
+	enable_delayed_work(&qp->link_work);
 }
 
 static void ntb_qp_link_cleanup_work(struct work_struct *work)
-- 
2.51.0

