Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468BB3ACA6F
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013338; cv=fail; b=IAvxL+5MzxewHIBlqA8qE3H6x/DjgSm/NTVeiM2UMtDX8q75dycbkgSRPLNU186M0wn7MDfHrSbsbfmTjuBg65RTh2RhH3IHVFi4DWveG5cuo3VsXGXiXbBOTxiFjGaSdmXlRhQtNNTLpQzC9yjmBaptzfg/nHbDopDqJnxeML8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013338; c=relaxed/simple;
	bh=3/g7QbWKzN9ZL5C0n1ttalJPYoaxEdQqDRXvjBTT31c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y1WR2hFrUmYt+u5FkjHYRaNRfL+8lzpujDV7h+loil8g1I93WTEMll5WzX5TaiM0GIru7aB7kT9HTHolkBKpwEf39v3wirtIKyoeGwr6ZGXee5VC8CnMAvw3JfwpNdTGf5F8+2OvpB+g4Ykjv47e9dOG5NqYIPO6g0daBxjYKys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Jza+QfGX; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Jza+QfGX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m2QeI7l4qZVxbbGXnlvDj6tQSQB89W4UozuZ4QQ7M5unHKk6C9y/YQzNHSU06i4vI838DXz5pVVfoDSEDBbnM30e2WOvB5ibwYOCITnlPa7nG18kNCeXYVGmljQddMy/pRNhmqGRis/CT3qMGn/Vg0Sm7nlXjW3j6MBUPFULJm/9ebYbKc0xgptyVc6iLbWhWA7r8T0b2zrgu42j8c679jaFRSmL+Y80MaBrd2y4/PvmryiJd7efWZE1Ga1TPyrY6jnyp/6YdIlfsFxdWIWZpZySvzB9V6t8yu2nFVQvn9I1Tbzs4Rq/5dZ3KrseMvzJsAe/V/mUNIJETdKgg52dcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukZGEDDU2OKNJWTMb6q983Z20L0KPdk1Qz4SNs0VlAE=;
 b=eIo8YKIxPzUMfLClX+e//Q72gDupT7TkemjqnK+JaxZywlF30bTVex5E+aYqVN7ztFxz+65HGkCr638a7fd/yA2kqxo0bQMJaSwDeUmIXuwC07cXHsrVj5Bp5G2kICDWx4UYRg3YOYrw6WbvYkUkm0I3aLtt09onf/EYuuYVjbSMJKO/XfrpxuSJiGK1BpED4VbDNXJ5nCSS6YGBLYhIVfFbp2d/B6Zx/RauWxOM3F7qAAgX2GDc46QQ1p4jOVCprsmGWdb5X8z6PVPjtB/Mm6cJKlYGs7m3533VK0vY5wj5XBSQF4NjnAR+msiEV2ronOHS7ouWGCCuPQyVAQC9Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ukZGEDDU2OKNJWTMb6q983Z20L0KPdk1Qz4SNs0VlAE=;
 b=Jza+QfGXNlZJWUb8TiBJJ9FtA40wIaofInZE9dbcyjGmdJlFUzykE/h3KKhPF/5VqYAuQ4AJFZ3s13BuR08y8oTBPI/exQHeUhNac8Fq/0Vhcs2lDKK28mUUoztEqws+TAxjSzhcKytAkTic0ED40ieX/W4bCtolkxZ13STrxFc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:46 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:46 +0000
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
Subject: [PATCH v2 06/14] NTB: ntb_transport: Clear link state before QP cleanup
Date: Thu, 10 Sep 2026 13:08:28 +0900
Message-ID: <20260910040836.3792333-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0169.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: 624d5799-1f70-4e31-c33d-08df0ef13603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	fruvox53YNqLMkraBzEIB/JPwGKOJ4veTo32hdnfxbmXR7kwAjugOfGkA+syrir60v6cM4IbESetvZ0a8tLtgIO5mKHSpow8q6f6v578TXxAheROvyjLCx8B5h8tIclHpThBSXyXCGV6pnXUZ7jbp1QDJturAt6NETumNdMpNPU5c8v41/7jlLJxFvYnvUHTiDDU4SZnBg3MjrFhGjX1GrcByuHnFSrAOsaxkg0RO2xZVaPECSnhLTU+j0ss8IGNd9gB9C06hy997NFtZtCTB3vNHQ0ICJpEkJco6crWWP75Js+wM7n3MU32+FU9Zhbmc2ico9dV0nGpziKm/uWFTITX2GClbnbhKAGN/A6/SIAVN/7jdeW6MJRM8IosXIR2Ukid9l1fbT2lx+MsouZBiBr0hIaufg+tLGd9jZZF8LbTs9j3z5Si4ZS/ecPVZvy+9+z26X0RbC28riPrkiKRy7/MvX28oHi1h/XD7aoVkC/Ps0/rTXX+DVvQgpVUEfNi4ZwoukxULEeO0PVS/wCmwUC1RUvlLWOKCo0GuVhqGO4U6ZcB2Rm9UlTqgodsLez/YI53212kbp1um4kOCPAS+o1wJSjPuKB+Xll22pTWCr90Xnv1CjNXr6jKCohrSg4e
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0MgYGUcif2Y2xzzocTAaf4p2bgHczFa8d59X8InC6gaX2kg7pqx+L9XR/FpG?=
 =?us-ascii?Q?CMSvtfunqtpqNgHUM+bco/SXIgVsFVM3UHhA108serJhkTCE2gMQJhe8d0fn?=
 =?us-ascii?Q?55essPC9VTtZ3u/un3XcahPhuUNGUa9mRtiAyyxXXL/AF3egqQZ+E96YVXcN?=
 =?us-ascii?Q?FT1L+6PudRWZzxJbF8znMjubkk/AIYMsyZwuryd/B+eaWD83EZJY1gGPF/sR?=
 =?us-ascii?Q?+Cg1uHC5ALi6WLZrprEgwOrvxWDgc3ObX4ZMANpywx+Sz5oPc3y1godrOOWT?=
 =?us-ascii?Q?kiVeGiEk9ZBdK7PCQWyUbwcI5hbxeeh1NMKkS4Pa62Imwr8gB+8MYNyBF/hc?=
 =?us-ascii?Q?sFH9PnGdtmxIMZCE5XoEqDsybyXFRJHtCKPYgCr90brtrPdDvhc6G6J1pCup?=
 =?us-ascii?Q?Uzkg30WjuL90i5rhfYfSeTFgFcwe/KPP+DzLqT1h7gKMHWvieEmCgYnXZo8F?=
 =?us-ascii?Q?W6aO5q1q7CPjx8pCY3UPemsSwVZ0xcpXT5sUwTrS47Prjo9E4htn5DVkzVHz?=
 =?us-ascii?Q?ZEX0aCtbT2nAoj4lT0NZyjziwadDCmKyYlQjJ8JCxBFstzqYZC8QsiK/qJDV?=
 =?us-ascii?Q?478Cx2loaO896V4POClI7d1VVF9sjpH1mee9qwobY/LVHwuSlbkFimc7m1dm?=
 =?us-ascii?Q?/ycdBswBm8Jo5gkvxLzswfT758aiA0JYd4nKPegLDWOIGS04S4lmSZ+33qdB?=
 =?us-ascii?Q?8JZl7z2915XzhSFm0zQRM33u9bX92ISRPzA/9GP1hFK52BQI55Y9uuAfGbCM?=
 =?us-ascii?Q?eeKa/zmv0M8Xkh4dJXv/EwcAyN2Ed7ggh/jszKoHPFArt02Bai0XPViKUe5+?=
 =?us-ascii?Q?GBPfjENY36RUeHbn/RacAcZgOKOV5A2XwTP/6UFyP8gp2sKSJdPkIf1qvjcv?=
 =?us-ascii?Q?vciz3RUvEJM5NpikN7dxZuQk0/QvfxWnQYwLsbDV6HUeRHOXsAoeGZ2j3kRf?=
 =?us-ascii?Q?08DW7KCLGH10Fp14p20EdKZGf6bIxGcDHsGNabqfAuS4kIWOsBwj4yYOZpEx?=
 =?us-ascii?Q?epAJg96lZruVKWm+binL64jhqFUoqVhRZ/PnR5T2ITlfzK5i0G0KJUKl9U/M?=
 =?us-ascii?Q?LEQtxxiZCbuPNav1m41lO3eAH6EqETno/J9D3516ldn+TKtIjCDMjvrySdHy?=
 =?us-ascii?Q?y8TDwd6/y5zH7Ve/+VOArxAje43IbPmzU1W5lXO9aUC1R4A5mDelsq0XRQ+s?=
 =?us-ascii?Q?3KIFb4k3JiqcU9kK5k6h9p98mNcxEdEs1ulWE8TecMOYs2bBXl3kBEeX8a6W?=
 =?us-ascii?Q?KAhl3+QRWRPzNwjbSfte+I/860ktFsxwsOHQSPqWLwk9KZ4iOhyLoEvqhuBC?=
 =?us-ascii?Q?kcqdXP0BvV1LERO9z4JT7BH1rGiZ+Lp2I1dEkQjArNWkgkd1wSL/TyzzIwrP?=
 =?us-ascii?Q?dESpPttSrlSj2VqXgB+0jZb0pf+ixKZemQljHwZPZSu3XWplrsjNUtM0oqG5?=
 =?us-ascii?Q?YomKoczGe9FUinFCDeRHk1bmnLLJnyJJfRSMJgNmcMBQmBFyFW+Xy7NEU3Jv?=
 =?us-ascii?Q?Svd2hAQtNKUBMQ4tTetPp32Nea1NVLi1gOpCJ3gHiL+TqGkUd6F/ivRdhCoy?=
 =?us-ascii?Q?TUZM6+G0FdO9HEJ5sZ3PqMOH9ONr6fFWhUsSzlEjZ9Jzbtygs2Vge1/USgdi?=
 =?us-ascii?Q?e+TMyz6xGUra5asqR0AgWC+q01XEZUV123BqV3Q1Oaz4J8NgJncRDVyLAOAc?=
 =?us-ascii?Q?1OsRr+rMeH+1MhVAU8INXE1l3QK8nsAFqzkl1WCyCAWAXWaPTJIScqNadfcq?=
 =?us-ascii?Q?mRLws2CNVx7TKHkwQLY4UvSBzkT3lMUuBFpiMSM5YgndG09pJwmy?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 624d5799-1f70-4e31-c33d-08df0ef13603
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:46.6693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RPmIHNin831l5MoL0PaDeAMY80GS+vwkgm459S5qI/Vch2bOGyFwxOfaqKHiABAdb1RP2mjl+A60VOn0bXp8fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

Cleanup leaves the transport link marked up after releasing its MWs.
A subsequent client link-up request can therefore start QP link work
before the transport has been set up again.

Clear link_is_up before cancelling QP work and releasing the MWs.
Have QP link work return if the transport went down after it was
queued.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

Note: this is a reworked version of my earlier, withdrawn patch:
https://lore.kernel.org/r/20260717061223.2203863-1-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 1332d53bcfe7..8dd1770aaaf1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -977,6 +977,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 
 	guard(mutex)(&nt->link_event_lock);
 
+	WRITE_ONCE(nt->link_is_up, false);
+
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* Pass along the info to any clients */
@@ -1142,7 +1144,9 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
-	WARN_ON(!nt->link_is_up);
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (!smp_load_acquire(&nt->link_is_up))
+		return;
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-- 
2.51.0

