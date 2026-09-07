Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021084.outbound.protection.outlook.com [52.101.125.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E89D318EC4
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791095; cv=fail; b=i/ebrgfvLTBdgo2RmSFscME43ep9NEbgX4o+H06yS9x9KhZHjcR6j7XntjqXDWF94iSg8t1QOO2b4xBD8XydfH95PRJrI/N8Nrx0JBLL4tiDl2IyyQYupUU9KYQ6c9GRCXeQAViShll+x7T1ZprmCm2LpYOqVzugNYSV0zeHWHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791095; c=relaxed/simple;
	bh=W+dPF7uVmeP/RTVLE3tpxqZQjEaSAF0uYIB3T2YNJXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A6KmVchRmA/5Mpik0wx0S4o9NE30WH6zZjK0CKCszLpe3nS3h0ZxEvtcWNFaZzVzg9+slXorI01SyJ2TgmVmySbABzHfUDfi1aMsDqaHBtpDpJVX33lCBWGQc5Nw/BOUPq+5MNrAPHZcgJncEB07oMKj34Y6MTqNV0fmOuP7NNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=t5O2faNn; arc=fail smtp.client-ip=52.101.125.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="t5O2faNn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=njrAH0tjfp6ZxN7Kc7c5ppzGryaUDh/+nF0j9un20VrhJHulU9SsL8dMnh3W2Ynd0sdRJbvCHPxybMw13WyPgNWGQbDMFIOlqXfUcVxXdNU892SEFmOBF2K6lYReOFkqmT5zWRe7tmGKnjlwGTTwsKKsRBQngdlMsY6S2W07+1fgez/jyJNkwrFZrNJTmmhA4Jeq2it/MNWLJtrTTCEQ3Yw6l+4ckDCMGkt01MA7Oo0QA5KLs4CRVVn3tP/BfK30FeWIGXVDM7scZ8PiIGtw7CSIFqmI0D7lmWqj/XUTYs42kgIYxjmLDNFIItzyVwu/EcEAvvfhWb+c1g7nYbkzzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hPs/8mXqmZUROE3AO+YBQnuBjs3AqT34vklAaU4Rf6I=;
 b=NGu34OZYqcu1hPA6jfzMFIEpz+fGRgZztBamgOGPE9+Fzn41xiAwSTJ7YQ93/qKmrSnHuARyDzdOmfRp5+w62Baz/Esrixt75059NzWwqBmrRn/b6o7mi4XYkY6Xevjcs09HM1EhuLSlW8gk13AhQVQOC+gSwXF0b1NUS3HXLsg5Chc5CQWF61ISi6S/g3VjxPBqmHnGugSkxCB27R2UG/yDZK3oWfA2B3+yDV3V60qrQVA3CpwgeSZgIvzbfBZsrDvfGelLZFykCMStI1YYtIBqngVEu0tT6r02/IqYSQ5/su4l2FtJrkZezs0MsFa9iMxfeZnr2CzvYbield83CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hPs/8mXqmZUROE3AO+YBQnuBjs3AqT34vklAaU4Rf6I=;
 b=t5O2faNnqPGgGGQsEbbF837uToUW6JsL3zR5tA1pzzbCcEgEoE8X/puUjjfroUus16FEoy9qThXGfRc2EEoZ8jX8WYGjMbzKjExzo87XWhxncC3p6Bjc5lhLlmtCRzFmIV5jyW2aDduhs4bsrc/M0tAixKS+4+dUNeJm/kKnj8k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:48 +0000
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
Subject: [PATCH 07/11] NTB: ntb_transport: Clear link state before QP cleanup
Date: Mon,  7 Sep 2026 23:24:25 +0900
Message-ID: <20260907142429.951930-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0118.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:37c::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: 275f880f-78d9-4856-9c0c-08df0cebc5a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yL0ppFsx/AvM+MqiGwqkiBKC0IC6Fk0xLw+QkHeSO3iZyC1l/VAA7eTpCNKNxhTjDXmvk6DYbcMPGODfm3hUwna65RlUr9EoJn8Bm2x12YIQEsntse7h9ysMQdaAVPVM2TJMN1LoLP9C7UDwTl/ukbwoVreeqsr161+8EvMxp3fnzvErSoH+Cl4y09Q2lJhHOMVab3bOSVe6OpMLyKJUMgxWTWyjAYHWAFpcQP+gx0ARycuxw12AAN8b7lVCW8VjzJqTJsGdflsQVlacC72m0nNgN340n+OgYmfi0sa5TyPVvS7AUME0OXhgUh0sLixX6kS83fS10vrgUz9TN+XEdD10Ti82w7gfUog5f+XMwpxWjheaGEocQJAbMFndSJhujC0HjoGAV2I39u/6N0edr1/GW5dD15Q+/qU5K2lcxQ/wjrhs7D118WZiyzoby46mnXf1PX0FhoWj2CduOXPPcnsoHAfuXASbAOMDroGT8zd+5XkGkgKa/NVsImP0mVsbofWyxKso84pW4H9iQ8mVfqCImX9TXNJY3+9NWgio3hIZuz0ZHDIxExFwtPlPg9GbiYllEQA5ZlOdJV4pRrsbI7ms4pdPiH7nHpPGeLD1mrnLuUhrotWWQLVXuDJ1gWXn
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5ps3+KHRgODuL7ylsejbOiS9WhuEXLrSbNAvQjUdmkr/u8xDpNMPsi2Yfm2a?=
 =?us-ascii?Q?25KnUB6vzTqcLjs9yielpCn1xo314vgW6jo9xWL2pmsosEnZAgemfCyXxTU/?=
 =?us-ascii?Q?JiyIB8wTNGAAdrUOazM2FHHgmMr9cvTOcJLmH2gYAO+9Q1ToaM0nlfAYJrxB?=
 =?us-ascii?Q?Jy2fUIyozVnQiA1kaJxGvG2VibEBNJEqB0G44BfmT3FgaN1k4WRPwS5uvq7m?=
 =?us-ascii?Q?8ORgeN5hICrPjwDyg6ViBXgVw/6FKChwJ6HIXhsmC3m6y2GNpykII3KyNgND?=
 =?us-ascii?Q?MgZN6goR4rhYBlbH2HnotICakiUBkY0jAfUbMuk0qTX2pZj5/LJYMglhvOjN?=
 =?us-ascii?Q?50GBItFcfT0g81uYPsbIbS5jXuAG9rN6fNwOAMeCq2Xrx6VEgI7TG1fPXcNH?=
 =?us-ascii?Q?E54W3SVe/5ZVFm6utm5J5ATyoDA0bzURdG9KpUr9ARoQYNyxHGYLfoF1byNq?=
 =?us-ascii?Q?W4czzVWtAT0Fo8sf7FnChjvGGVtRvI5eh5yrLOiR3GORmx+yoI9fK9muT2z3?=
 =?us-ascii?Q?TT7o7lMvhbjiQ2AV9tVvx6FLHJB3T9WowrUiGHfgSZ4LwQteOp/ezZE+LBdL?=
 =?us-ascii?Q?TX7cgBKG8NczeIPEy/0QedW0GrGKRh6YtrjhESnOjCV7w2+xHsTFfI8d8maM?=
 =?us-ascii?Q?VmFM3JwkMidftAks2V6JRFFVxH4xtZToxAXI1SP1kzilp4iLhCAYKgGgm+lO?=
 =?us-ascii?Q?sOp8KgqOYeVrDyX9+2wMM7WAfkOdDCaEBPCV3sRJdlXEYTyNfSi18VUGeZpE?=
 =?us-ascii?Q?7/4u82BvdHu1VlE6jsGQmHNNdqgNpgTjOICYsoa8f+SgBwji4IHVXBqO/GxR?=
 =?us-ascii?Q?uJ+MRAMs8sMMAl9cAbI2rJS6QqWa98IFiCryzXLd6iwOk7vgQsyBDRjF2f5e?=
 =?us-ascii?Q?SvJ726onpifv1sAfwvqOiTBVEdX9gelpqCoMGWD/OCVXqFHzrHd65wO5kgM2?=
 =?us-ascii?Q?bjnRlaeIsz0ITu2YmV2QCRirDtVH5Gyslymtip2rHihH6Gp3a0VXEFSdJL2B?=
 =?us-ascii?Q?C5vsgwpcxTiHoS1x6s+BTsvsGWxqpE5M53NAf1+ecelmK/SMA0ZRe2SOBEJv?=
 =?us-ascii?Q?bw0pwqiJqZh4jCmQl55JnTjwjUs+MGVhGL/N1RzeiuIg61ScBlbTmngcJigm?=
 =?us-ascii?Q?NT5OTiVRsZbDo6bQBFADkPZqEwioaOlktPbINHKKhaa4TzTLP9HXN7E+MyXO?=
 =?us-ascii?Q?sfzRwuntzkq1+zcNG0/3MRnB7wxAdr0Ai89G3c9IJXPWwb/mKO1wQlmJxFwu?=
 =?us-ascii?Q?Ckzhn1GlxVtn2ogxq67qWDROzuTaFfWHg+YIT2ehzIg29Emez/akmc8TLrqu?=
 =?us-ascii?Q?zWMyUEpJSAA7Aq833ag7VWGVR1JfWMQABTteiHBqf7/NHnkZNSJugTti+wjW?=
 =?us-ascii?Q?hHH3JKeCUYnF0nyYQcOb7egcqtZiKUbEsyoDryv7cfGLJOF4qz8d6O2qej0W?=
 =?us-ascii?Q?KiSKaJWjw145sQiVjBTHgtRKbLBPWF5b8Va+iQWLCim6H8bMb40OnON03Obe?=
 =?us-ascii?Q?Vd0hEpE6Oyv5ODhlrKwzChy6XcL2mDQDXIXX63k0NAbeU/h6FjY9TOsD6xiY?=
 =?us-ascii?Q?Oi9HMRO1MOQj+10WvqQ3tppkDMDk+6eXLSSwiVzVTgBHPH5AGeMr3GrW+zOL?=
 =?us-ascii?Q?JZ2ylgynFdxs1+oDR3GOC0AdwILod9uz3tHATt6C+dSvX9JA7nkWrYdsOhxo?=
 =?us-ascii?Q?0xRUgew8zlFEt9KxLTEVZzQIDhNSF9+y48Is7O8U6t5JRQ3ESiVwWrgHhofK?=
 =?us-ascii?Q?/Xvr/Ti9FwNuuWrlEWqRkf8xbw9NljNsUf/KunDkrPw2wLXCY5mj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 275f880f-78d9-4856-9c0c-08df0cebc5a6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:48.3348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fv2geB0VR0kYZatr3YL+iN07zzFQ6a8kTLJsMAZy6+uU51G7jCXdddiJHbbLmd2ekFaG3S2uog3xXVH2NbIDHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

Cleanup leaves the transport link marked up after releasing its MWs.
A subsequent client link-up request can therefore start QP link work
before the transport has been set up again.

Clear link_is_up before cancelling QP work and releasing the MWs.
Have QP link work return if the transport went down after it was
queued.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Note: this is a reworked version of my earlier, withdrawn patch:
https://lore.kernel.org/r/20260717061223.2203863-1-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 411017873a83..4c0a29693ac2 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -990,6 +990,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 
 	guard(mutex)(&nt->link_event_lock);
 
+	WRITE_ONCE(nt->link_is_up, false);
+
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
 	/* Pass along the info to any clients */
@@ -1149,7 +1151,9 @@ static void ntb_qp_link_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt = qp->transport;
 	int val;
 
-	WARN_ON(!nt->link_is_up);
+	/* Pair with the link publication in ntb_transport_link_work(). */
+	if (!smp_load_acquire(&nt->link_is_up))
+		return;
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-- 
2.51.0

