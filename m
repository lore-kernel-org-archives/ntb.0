Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C0637CD2C
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375732; cv=fail; b=PLOEc8F2A9uU0ctxXObFOa0Iy7LEPbx8S2m1NJ2RPt6QRZBv8w1EXLW+9GPhGRGKsx5cOA243Vs+Tam4EPJUckwNFWpsu4UCfixMX1vakRGYKmakGEZd6swlqSjGBFBb7tceib07eN65epICT6TYkHFQ+3wq+AjqVaKfma8djgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375732; c=relaxed/simple;
	bh=OadsX1OdSZwMEQO3A/K4IWawZCbIWcbpGv5BZiiQ3sk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ofOb/ypzGvlwdhoD3LuKJ68jS3HnjZSalUcxUnuJuB9mWa5WOgvgc8S0DAzgcchpMJPmTDO2NuNgwlcJgt5aQcUUj4J4m5s1yAEWL6RE/Qz5ME+rbj2VWAxvBFNBp4gxu+jTxc/wCOjl9EQJVdKuaBx7tzBBus/CrffhBfPwAhk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=EUjuct8H; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="EUjuct8H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dpdHvBqIomgsvc6g0MwKikxjK4trvaR8VI8555I0YUEFuOAPZG2LD1OEZO+AfoL8vyzACloleEG2wss4GfV6FU0GeeQ51o3zExGgEkEEtEYHqDhWpeA7GPNDrzxLcWCFNo+nwdIu1gaZwUsm48FPxna6B5ex7a3MK4mX1/HovAIDGx9zZh0yPp810P4cUwOWx3T30HxDKmhNm7COu3cNL7tT0olgqiHraBsrQ6WP1Uul431Z1TKeNx1F1zF6l9g2gLpfBhivN2F3PG3qmeeEWcsRK6b7+tMfYpMX9pTG9D0pbnVcK/QqQjKTeht8NNeZClJ54D12m+tyG5R3hYnzzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hGK9AAVwOUh9urIaJth1F8DO8yIs2ftyHbbjmiMZmIs=;
 b=H+aDL+kLipGThq5ykL+r7bwL6sAjn5KZ5L9dgM//7Ztenj2BM4sGyFjZtklHkyvPRtyRRIPVqVN9uM7PA288xi4cyrnQite8xc+3YveDxOcOXc8NR4vS7ttt7/g0N7V9nDEWmxgqGN1yvGr9y2iC6woHEMjleDdqkrQvHM02gRtvkAqWNR0RI30dQxnqfPFpZsrMSGGyk4inxLazQ9e5MgyDxke5Tc4nEFQEcScmioID3FcRxlIKINEq7FGncLVNQhFInGwa8CE1CIOYiF3xx48MLfHv1ukkORqxQeoipZ01wOQkSILSOcpeY5mTBFcShpb1xfYdSQH25F7Pssecbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hGK9AAVwOUh9urIaJth1F8DO8yIs2ftyHbbjmiMZmIs=;
 b=EUjuct8H6PPgRb1NcWqNG9xgCgaCSJcrmYEBh3R0aWYu3bk6YSoL3iq+TI1KAzGY3ep3iRlzzKE4UZ7AXwxGNKBEsI0bcd5o+S7UxeETBn4872dPssBqsFSh2BVXTz9h89O+SU0yLxtVjm6iEolUB6v1hizcrd4o2A/PaS9pKUY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:44 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:44 +0000
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
Subject: [PATCH net-next v4 03/10] NTB: ntb_transport: Order RX entry completion
Date: Mon, 14 Sep 2026 17:48:31 +0900
Message-ID: <20260914084838.2158249-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0029.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b7::19) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f29e283-0a2d-4665-4a33-08df123cfbc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	kim9Bc8lJJZP7l9M9RhyAwz3XWfvxwtlseNxLQrttFUimDuPbrUxESoP0mT57JCG8qfcmB9zfpbshUytAl7vDeLNn3z4pENK9HZaISGftenls8nOzGf4ALUdNCVfFYHnU/jUgcqRQ859NLlnIbrmUzAPX2Kk12M+CJ7Rz6s9nZNCgcHA+7lXdBVi1cgIrLfFYQjBkYtp+j1rZRPDtZZ1cKy0MYsiSWnSzIzbd9ncCQwK67Z52ptlSsX3B4e9eKyZjqNEhbRwy86UvMf+iWy7KrfXWsZChDGBiJlmaR7R+Xz/WGb+n4YDgL+3eiSj7EUbFgoUUTG13NocyFZfH/S8N458kQK7+32ge856Heh9WhhkQqB4q+rv+/1iFKYOpA1qi39E7RcwHzOJzvUbIt6blXTzWAbDo3/zZYsRBpeBcM9DTCzfbEPoK3ILFYi6ASKG9d7zEMHCGMOMAGCJFVLylThlQDFsnPUMmmNwWimG9eXC1/bPjkm9uvyad2AkU3pGnqkhkrJ4wUyIcHQGt/16AUVMqw67ko1WFJA71OTgDc3L/H0xHTgEwe+NAJkSfcTISTqLqtYvzmET8ogF4Z/ESiiSYj9Gn4uQz87avH6g9j7dQnVhzQDS3el9hhl2YUhU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xaRZz6gT+2e9QpfNERt1vOtHMxc/f6y9HAVLeVPv12alz1HjfKSncqBu4asE?=
 =?us-ascii?Q?wMUXlfnoy3jNMh+WoVSYZDkcGUMC5OUyhEEu0LkNQz5E3P9msKEKjhS32BTV?=
 =?us-ascii?Q?OgHFd61CRqv2LJ/BqyXfFwNxx74QfTqqezBDxPKoGq3xE9lXIEMLPBi1Zohp?=
 =?us-ascii?Q?DvN9RYTnhJec8c6kyWEAWXKp3u+bU3Z1OmWkf6NmowdVaxJ8NQjGfEyjWi0A?=
 =?us-ascii?Q?Yw+1gcG70lxFyWYlHXO/5611Ia51PfEMTNGB7fyzMnK6szHN/3XQjtpeBD6p?=
 =?us-ascii?Q?b+k3x4Pbn8kKhbcoTFrtB8xKxHkSnbrYXB2G9Vm8VesKultfycKtKpM1gogG?=
 =?us-ascii?Q?xhtBV1vBCMlP4gKPgFh9G3BeiNaCNwSwBvmm9qT3EzMfYPupFYogGAJ7w+kd?=
 =?us-ascii?Q?P4Sc8NlgjV2aKzAjbu5BxR3rBTkxcR+w3ur0IzIOkB8RPnJ4U6XaAPQACJ6z?=
 =?us-ascii?Q?HpHKBB/nOKnId2NawtsOi320jOI1AmBSfkrmmP0Vn/OPQDk5nYpTdn12oWnV?=
 =?us-ascii?Q?NQUK5GN+tjkJZcyvLxRPlK5p0uGohUyas21VJ+8HQojsCUEAhqi2A0J3n1w1?=
 =?us-ascii?Q?cgBkEOH8QHr7JaH6IBcCbjghUasFL5ndOakB/l+mXzPOHt6GPtxp1ath08kw?=
 =?us-ascii?Q?ZCaZC1xZj+v9HXWOiLxHRPlBPYrLUW8JLQm+6I3FshSK77fmCOaCim95Ryoc?=
 =?us-ascii?Q?nSlKd1kJvM3KpTBWVACLL4k3ZievK7F8Bv5F2r/f4cp/1r4xPGVV+2/9gwG/?=
 =?us-ascii?Q?gfG78PF2RG0yRoXj2jIUbjB2vp211fbSf9kypIAiboBvWK7Vdr65485RYyET?=
 =?us-ascii?Q?Yu6VMiKxxINPprYkSdzGE9o1FeuRZ/rQu2q0xW+fsiTiWIsZwfgOlCSbMOIh?=
 =?us-ascii?Q?DRpVnw9lxZhdogFyuVJM8sH2l/LpeVhXpHIX//r9SXNuGU3ZyL72DN4LHIUV?=
 =?us-ascii?Q?/lykyc04fYH+0VOn6XEVAV1VOzXCm7caSwZkDwDLJKOZwoHwSKc7DPLbX0Ep?=
 =?us-ascii?Q?a5ARK+fzl2Nyozq6iayHIlJ/OBERSc2+dLpWq1o0cRmeEFt4LgLFd751a14O?=
 =?us-ascii?Q?lm7ph78Ie+CHd01TJaN7b7yjsChMUgJCZ5eQGlWA9aN5Qias+PuNqB9azHrW?=
 =?us-ascii?Q?NGLDR2tQBjk5Hvbj6m32BERqH+b1qKO9hFlDBTWDTyR4WdJ16bq0NmeTz3Jw?=
 =?us-ascii?Q?TQrPfarGVDoHSr7dl2djOCTe9echTddFxY4IQde0StXiuYZeTvXlm+Ps5hI6?=
 =?us-ascii?Q?azXOisWbFrXAez6b1b05POqi21IW8CAp/jhbhDOK+VfKDQpm1CNISmDMIRjh?=
 =?us-ascii?Q?XjS6P4QKJ0UPhtIqVEXQD6CjCW9JPXBDJC/yU5ps745F1pmvWTPCOpTdSytW?=
 =?us-ascii?Q?GY29FI8cgTI+R6XAgNtyL4vjFYbm2iXsTOdUG1jJP5x6+O+M6HvHxMpAoP66?=
 =?us-ascii?Q?Q/lJo1lvKJ0bDYFEONh9i1rdsoLK5Ln1OkRJnq9QeK1s+qcr/Zv6tRtaK+B5?=
 =?us-ascii?Q?lB72dZkhFYdBcq9zsTSR6xVQ1Mhx5F/S975MuyMBbrZTiFwcI7k1a3AQ58M0?=
 =?us-ascii?Q?/G6QwBnNcn8b0YBJl+lWEKEE/I+N6rNB7kSsYwFdo+xTFf+SXdIqPFkSAEMo?=
 =?us-ascii?Q?6kQwZpGOq5JdJIlwMhpGuiVUfcCa6GV85FK7fIRndrkwGWCd5aIeYW/kt+4l?=
 =?us-ascii?Q?cRlZcqKiGVC90v14kdlgnOp0fHfAnh3t+6fJUjZq5jM+1dEBi6WlfguQCfs6?=
 =?us-ascii?Q?edI8Qw3OpGcRys43MkYIVwqkttrSn2WfrJBPuQhCesfR/62uB+fj?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f29e283-0a2d-4665-4a33-08df123cfbc6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:44.3035
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NJvioSrcn9uCbLXcbF19pfsFMaQbVtse2LGnODcyvMFmdvr9twP0l6q7DGRtmKvwqx/LHdHG5opCpCQvg5KHvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

RX entries are added to rx_post_q before their fields are filled in.
The overflow path sets DONE without a write barrier, and
ntb_complete_rxc() has no read barrier after checking DONE. A concurrent
completion can therefore consume stale entry fields.

Publish DONE with release ordering and check it with acquire ordering in
ntb_complete_rxc(). Use the same publication rule in the copy callback.

Fixes: da2e5ae56164 ("NTB: Fix ntb_transport out-of-order RX update")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp?part=3
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch (Sashiko)

 drivers/ntb/ntb_transport.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3f497a62673f..b69e8ac8047d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1443,7 +1443,8 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
 	while (!list_empty(&qp->rx_post_q)) {
 		entry = list_first_entry(&qp->rx_post_q,
 					 struct ntb_queue_entry, entry);
-		if (!(entry->flags & DESC_DONE_FLAG))
+		/* DONE publishes the entry fields and copied data. */
+		if (!(smp_load_acquire(&entry->flags) & DESC_DONE_FLAG))
 			break;
 
 		entry->rx_hdr->flags = cpu_to_le32(0);
@@ -1496,7 +1497,8 @@ static void ntb_rx_copy_callback(void *data,
 		}
 	}
 
-	entry->flags |= DESC_DONE_FLAG;
+	/* Pair with the acquire load in ntb_complete_rxc(). */
+	smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
 
 	ntb_complete_rxc(entry->qp);
 }
@@ -1664,7 +1666,8 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 		qp->rx_err_oflow++;
 
 		entry->len = -EIO;
-		entry->flags |= DESC_DONE_FLAG;
+		/* Pair with the acquire load in ntb_complete_rxc(). */
+		smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
 
 		ntb_complete_rxc(qp);
 	} else {
-- 
2.51.0

