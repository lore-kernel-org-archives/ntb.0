Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021084.outbound.protection.outlook.com [52.101.125.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AFC9318EC4
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791094; cv=fail; b=Sf+xS6jaFyOK3dia0wkomSE8opQPkmpafZBEhGM0bY1BLG9Y+sm2BVONmXOitJ96KZ9wVlyT7geunUmkwtYpJUPoXZNrkX6H1Jk3eGXdWDrOUJwYfC11XeJVI5Qno1zM3oe7eww3KpK2UynpZPKfe42KJ+BP4a3+luF45BYeYRo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791094; c=relaxed/simple;
	bh=ayXdW4Tojsh4e/F0NbFE7nZ8ZtJRIvgqSQ8GBBTGbTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ddIwxm1XeogrO0ucD58gf8U9wB16m4gPpyQUJzQ1RW2+PhArmA1mMbQyQc9pDc4U7RxYgBNX2G9ELEL/GNVdO5vEkjtMzDJheF+MmGJS5fFykgMnvq99kFLmiVayDmAo1p+iEPW0OhPmyIGBcGcvel3/7vzP1H3taBiTOxVeC5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=AZOM8MDB; arc=fail smtp.client-ip=52.101.125.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="AZOM8MDB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wxN7FgD7C4N2V3THACj2nqxdW/BSdBeaSMaNx2Wjw1ztmPdjA9nGwJMUwWHsoR0/03r6/d/nFSFkOKGdwpS510yzAlsXXHAhrmIMofqcydelBH4eQGO9+Ka6ziVJ+LpgjJMBaBCl6xvLmaniEIh+pRHBZRlo0mc42a5kLzeu/ioCu/bK3/hoYbEsr2K2ZHdi5KqDnuwgOBGrOVXBcnjpLlxTjEDRKl3maVuAqDAdYE0SFGwbh27Opnh3fusl/r81xUZ1yjfSMeIHSgJiUrhryB88aIMytEjtQRZ2vzOs4m+Da8b2l6PTGb7Cpza1MZU0VKoUb7l5w0fBJLYCaO/FwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tX5ZeXG/2aZ16HjrvwqndfRSuPtc6MnXhz/QBMnQ5Do=;
 b=Tcz8hpVNAO6an2qykVpuW9x0eoYkd2jnslIKlcXY1CbEhMR8jzZrraEWbBUPsB3rpJkNH1E2kTNVSt8/tPRmwTDFeHbPb20C0wKDEC6FzCTfD+E6k0sCRpMOua9+aN0UEqA/4S1pEgm+CSPvi6a/AsqPAq8AcSqT2E/5pzVWJkRtB33on6YC7E6wrXfd+k66tFM9AzCPkjKWqrp1mHOifchh8b6JZM5CY0yBJc+DL3jkzkLH4QS2qqaRJB4GvsLMEQfKevG2Gu/89WjXVPDlyN2hNNKiqlrRGkMZVHe8x0A1eCSvlFAQBbwmQo5qmxPirihdgkQfA5lsZwKVYfgMkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tX5ZeXG/2aZ16HjrvwqndfRSuPtc6MnXhz/QBMnQ5Do=;
 b=AZOM8MDB76iZeX9nlYKTdLusodwHYmdYHT2vtNSWmpVV/2ZCm2LQsxjwYx5bXTPhM099+gJkEBwSOvn1cUMIdXm8ZDnBRXWBErcxypRxeUFF+fF1dSLO6JJ0KOQcC0WAVKu9KzeSee7eghelxM4lL7WmOvpKEWp/IVHSS5toY5Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:46 +0000
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
Subject: [PATCH 05/11] NTB: ntb_transport: Avoid deadlock when cancelling link work
Date: Mon,  7 Sep 2026 23:24:23 +0900
Message-ID: <20260907142429.951930-6-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0009.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:386::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: a2e4a043-309b-40ab-7b09-08df0cebc4ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TyFxCbw9T7ljl6xBqCosp165JwSlAHK4qc+D1pQaexXA198KUEF5S4co6Y52v7596fwxtRdFOysWOGokRgsB6lBCghrPJ9Sf2Q6Fq2rn1bqZ8fRfgrDqNy12V7A+IXjujlFaDJbLzBOw6t0cYK7BzPu1iPR7xP3Z8llOQihZ6F4EoyVa2mZK7sNwZXWg2gfORRc+VVyj+mJnN8I+SW2RzZcOKzfenXhE/QrrJDj7yWUeF0AkmHyFsSmcWCCAhUlwG+Km3lQiKRkOrjbdVB75VyRTchtZd7VZ0DpT9ZRVKxI2SP638HfQdU9+9oE8uNqh7v6agm3cKXU03SExWXCWktiB0OHOaYKbqozQjOREPBQ1suQsr8H+PvImK2JNMUtmlpCG7ikv+tKcx0fLRqcGknuZ/rOyteDXePxg+rl0pY61B+3jauvDnjQly8YVEn3w0m+GMZdoVxppHPz++XDBH38H2WdYIle7+9jp/3nIIGDLp+xmG5IgZIJL0mKZ5FZTgMpgMPlShUymtVQAo9LSMiNDwG60p4SLOTYXLnF0IQlTluZJWQvjpdAiv0XbCdIc+eJwpFrCrefCG1bfNkYAq3/41VColjw6plyuYwG2O4EXaBto05Dvg7PFcB2CZNbqSLXQLCu6/+f1JKumUhvyRZ+WqdUwullpmof+qHB/Oqc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2/8jSbe5yDybOaMtEisOWeJ6402evOHom7iaAjALfkY5qVcrAVxSgPTtcXGA?=
 =?us-ascii?Q?UrLc84305pLze6pXgtegSGzAJAlGRJbpGFDQxiHHPgeFur1ph5yTkMkHH+Z2?=
 =?us-ascii?Q?LrlolByOQSEdM2Y//z58Ccj2apUlC9YN6qVQq7Qir5Pzq6QYTlTs6CfctUv3?=
 =?us-ascii?Q?iUW4/XjcBBY7KkcV1qfaC+98ylFCDGeJ3lhIwQskUnHShqCqXmdvln6NCZGv?=
 =?us-ascii?Q?0f+r1pnSxq7JyQTM63JqgHWY0QOjKL0xHnJFjB3WOR9FNw3LbuY32YfZJxY3?=
 =?us-ascii?Q?lRahAyj/GWRilJl8mNt4bDRFyEMu5sB1jCb75HcTxVipJ82xeCfpSaByaGsq?=
 =?us-ascii?Q?LQ7yNsNNHmzmJrrApLOWz1v+9BTUt03iPnPd+DyzHSVJgMjPlVqfUVgVfHtf?=
 =?us-ascii?Q?LwK4xyHtUxmgb6YAYKx0QdvgqPtcU3EpBkwFKMPmXE2sQqhYFJ13DK22dQl+?=
 =?us-ascii?Q?OFrhhUKtfymvLeZER8ns/MoybzYD40rsgLYS2l1gEsorRFFv8NJtawypgs5w?=
 =?us-ascii?Q?gWTK3G1BRsltHICBHmufNlFUox8s8217w6i7q/FjW+Ss6VOOZIhcjn5UFAre?=
 =?us-ascii?Q?8r564izo21AVZ96g4VGhXsp7ZGAtwDGxMnQ70Th9XiSuEy7RlOBOI7PATGdJ?=
 =?us-ascii?Q?XFS+LTl03DxVTKy8RPwx7yY/Wz/gBl8Ok3fcF8BxdbQMzYhmWiRSp6TP5xlD?=
 =?us-ascii?Q?VUG/xoIpaD6V8H3RW+h9prDbjmwaQLv5gy5mL4UCCxDzWl2YAC9I13a9M2za?=
 =?us-ascii?Q?zV6+6tgeG1b31ih27zK24lilw8aGEoExZRVBLV/C1VDH8PNmg/OBxrdkjHdF?=
 =?us-ascii?Q?2+Se6lk/3AavszrEhH2Y12YbfChccXwXy8ljH7PoOwY9uacjlMdojinA1nkI?=
 =?us-ascii?Q?Imjx3M8X2xooRQ22EUyOO4qKgZ8oJJAHdRXzDtTRbOlXkeyVCWDo+wrv9xx1?=
 =?us-ascii?Q?ZWeDlly2rVwsM8lJuIHai8TOaea2032O6jFhXp0d70UvFUjRV13Y9bC1JUOu?=
 =?us-ascii?Q?XIDCYYUK56a6YkFnt7+iCpj5beGwfT+gOKJtIcpDVb4wEvsjGp1v6OHMNYX/?=
 =?us-ascii?Q?XTY79POkQbdRZCGjJ+WRt4hrFYoQNpdFN/IcOu2T46kFiPxv9NkTlhBwM1xD?=
 =?us-ascii?Q?Ek9Tz72O0rr8gJOFLTenwgOL1dDbXWGApH0r5DqSfpIZt1C1cqXjb7naKuof?=
 =?us-ascii?Q?FSjVUfVnMnSWYvu0uINuazlTk2il1tta1G07jJrqdM4b9KBXZFtGmILB0NMd?=
 =?us-ascii?Q?riFx3zq7CWJ0nMIAaACJx0JS1alah9MMX10SI8mQtNtiQXCyYP7F3z5+hu6L?=
 =?us-ascii?Q?J3LyPm/0fvjiU9/Df6vf/dMq6KnDRXeLyIgrOmN/T8vlfoGrr9H6TUW2SWpL?=
 =?us-ascii?Q?Ek6keKC5sFpnqBuwgoF49ZdR5UZMAYKwpKI/Y7pi+BdpFiUL82VCd6ZiJBqU?=
 =?us-ascii?Q?3J5uYdxtEGpIXl+bR5fCpjHSPM1Gm59YtWrzH+OAKxqNaWodeydO2x05orcv?=
 =?us-ascii?Q?NFeglbLAXJCYu2sTACg4Xd5sV35n8TzTXK5E7Xq6tcAkbSmmDN21WJaz4t4f?=
 =?us-ascii?Q?t8Z+mYS4mwhFI/RSPCRYT2qwa8sqJaQMLUcUNE2m8UKfKRtCmKMd+3SVcM3z?=
 =?us-ascii?Q?qWU2it/FAhlxlrIyY16MW2KJBTeYVU1qSrss5HOQ8zQ9sr8Q40fz6hlz9Exh?=
 =?us-ascii?Q?MWdtuhzvpAVJetko8CEV6N04wihE3vFnDxYYuovF3KQJus+r6pCCo1ng508d?=
 =?us-ascii?Q?MYV/A48iIMg1GMkON3Mr3D/5pQRJ+uo+K+AsnpvYloGy05BRK6du?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a2e4a043-309b-40ab-7b09-08df0cebc4ad
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:46.7008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gpdVAzvQDiZq42fTZ7kDD9iV/9eRCid3jJvPVAscTWhlymHdBzLKIWsozbc7lkB3ccDrnTNoxo8orPqDvvlEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

During initial link setup, ntb_transport_link_work() can retry with
nt->link_is_up still false. A retry can block on link_event_lock
while cleanup holds it and waits in cancel_delayed_work_sync(),
leading to deadlock.

Move the conditional cancellation outside link_event_lock, before
QP cleanup. Keep QP cleanup and MW release under the lock so link
work cannot restart QPs between them. Put the locking in
ntb_transport_link_cleanup() to cover both worker and remove paths.

Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 763e4bb175a3..c8e7fc774b4f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -973,6 +973,15 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	struct ntb_transport_qp *qp;
 	u64 qp_bitmap_alloc;
 	unsigned int i, count;
+	bool cancel_link_work;
+
+	scoped_guard(mutex, &nt->link_event_lock)
+		cancel_link_work = !nt->link_is_up;
+
+	if (cancel_link_work)
+		cancel_delayed_work_sync(&nt->link_work);
+
+	guard(mutex)(&nt->link_event_lock);
 
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
@@ -985,9 +994,6 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 			cancel_delayed_work_sync(&qp->link_work);
 		}
 
-	if (!nt->link_is_up)
-		cancel_delayed_work_sync(&nt->link_work);
-
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
 
@@ -1005,7 +1011,6 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
-	guard(mutex)(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
 }
 
-- 
2.51.0

