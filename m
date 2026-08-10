Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020079.outbound.protection.outlook.com [52.101.229.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFEC42D751
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380712; cv=fail; b=A3LnWvnsNfKqIwf1DzXHRBF1T6rzowYVbxUJzvs2K2GLj4Gkv0NZOUeI8HA4TnowVswVV7jTNjaSA2pmujBFS8hnhE82jM0Asa3M7g6eEHkWwMJsH84e/KWSqTUftWPRSviMNfXfPqQIzt63NSxgW/VjbulnkStz30YwT2CfExg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380712; c=relaxed/simple;
	bh=QwNLuMDgrOcmLir2IstgapNc3zOhHMQoHkDAFDv3m0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IE+pyrfouTI6dljBOEk+yrBwbd496LmotDhmbzXrGij+6SQCBdDNc5HN6Y8J+H4nTNISLV4hyaa3dKS027uzzgZmV8PuT9+F+aukURw2B/jL23hXY6sYQPJP3vidEUVOzixLMkeLHbD1PFBQZPOoq/RYO+8MSzz9kO8X/ZFv+8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XZZuwAnY; arc=fail smtp.client-ip=52.101.229.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XZZuwAnY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YZ5U0WOrUcTuqYtWV6nJqdI6skAvbrEsbntqgtv8e3sXcgpS3dTNHfmFrNMo8BMuuImqq9XE1Cw8ZDmxsgdWYlBxjU/5xK3aFJv7QS0OCUSHxFrDYmI0b/XyAxxcbBFN+0lwJFNY/HTgJol40cDytKgZRmFWt6y5ksiNjMy1g0tXBLO8umI1wlS/iCgrFVBKU9YeDqsmMrEzHiKVwyoguWLbmr6rase+zZbUfPXjj/UlU7Tu9tGMjC9nB8or81sUMt9FvbbXvjmfnjYmzaJbWaD+HyBSNIT9JRHnfgzI4mV7EDOmFpvsnAEIjPwRYLpLAOh/e4gE5nkZW8i82VbpKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lLTFMsq27TeF6RbZZc8F8bfAa4toJlXXkInnb9Jmr7A=;
 b=aBAi4U3od9y9aguw8CL1ckUHK4bc3hFoGZjyEfljZ6kWMSJJBTVqtl+QnwqoIuEzoJAhCH5onnPpp67LQtQE4C2yQfAfgkjZ9X2jPilVzvySFQmnNa3d8eXEROv9y/QOeRUeoRCuYEun6oMhPDdxuJrUZ9PBDLFFPFbgr+EZawVOyEc2lcgbjAJq9XXfIl6ekijLhugDlewMw/RkFSHvZox7SEdqfBh+Tum1ZRdXb+Bp3Xiode2JumzEO5aOMzmDfMN1vfoNeqKFqaR4FhhKMZkv9d4BrRKr8NzeeFMcMMCMZmoLfZv/uUR1G5WT/a0AxNAWeY3Qi/QksdPFAPunVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lLTFMsq27TeF6RbZZc8F8bfAa4toJlXXkInnb9Jmr7A=;
 b=XZZuwAnYm2E68S7ThY2I0sSNPDjndzyNWzxSGNRE6bazJFJ64I2GenGiTR7DY2/HeVOX1pA1Lht3osbHtNAiA9TcA8OK0lWVbSUTglNv9Q+ez+Z4zB50c1TT0tlfyOiGfyIqGT9B8mQ87NAzJEqXtXKKPaG4z+F8WORTHEtGriU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:44 +0000
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
Subject: [PATCH 01/16] NTB: ntb_transport: Abort link setup on QP MW allocation failure
Date: Tue, 11 Aug 2026 01:51:20 +0900
Message-ID: <20260810165136.2292436-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0031.jpnprd01.prod.outlook.com
 (2603:1096:400:aa::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c36d5d3-11f0-4f4c-09dc-08def6ffa8ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	iexGuIG686+6CqoKMbfDlZVwc6KkXad6mKoYoi2C8diwEO6MhxccZV9Ve85f+0wvPOlVktCUAXGv8YXZbl/abg8DW2OGJ/7nUPrEFo6LwJiiCnBSPPK3oSOxdTzHqyp/V6U3l3PWImdsB/j8kOiAcEKaDJ2gBK8s8R/pUAPB9vaW689deYLi5Kr4X8j4idPlbQC4YgQar3Ov9ziDm+tkD2uRZL9hh39XembM6sOs3Sv0GbQ/UHxrVzwOQpo7hKtCy0OBNgPTwAIbsKDGxIEWcg/05Z/FdpM/NT/t7TC8P1rXUzOk/GB2MAOYwKoXM+fspO6gXgI/6/26EAaEy8+3tvmTHxGz2uc3ubIULOM+dXsGkfpCwxhK/FArb0z8vnum4bW8RoGvTcsNv5T7S07PpA0oUWNMRFz/btU4EVaGzHFENMOuvxLU3ScqxQT3TQhGtRWgK1aLce/5RyACWfe7h23KI9i/vfwua0eD2Wityf16Tt6MoyAsQyHDvJPUQsG6hdLCUtpeZVme1cE0diZ3+axN/d1+U0rmuH3xxWPGlpqMlnkuooxw6+EcLnTqY/jOdqLW6E0i6k6IQkCVqeF04vOiv8z8ExyCbcjOZT82nGzBDDDmESR+L0eaLwWo5SbOWRm1yjBa4fpVgq92v3XNG+S+vodICs8pSE8c79PcOOc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F1PPSjtuviAouIi4jhVyFq/IhhhkfEiaMqQuSEFDNKbU5ExA2Jc7Pv7lvdxT?=
 =?us-ascii?Q?zzfdybh+AvA/Lk3RBSm2wqRRKX0/57D9lUkq3O9Tpahm0xkadAApH4QNFsXL?=
 =?us-ascii?Q?J6+23+PegCtqC5UnD0+h4y9EnPX0IwljvVFkUHvsuCk4+fmWUtvBmN8aXTdc?=
 =?us-ascii?Q?2so0XpwQMsS2AD84X+qESJEGPfYMXOW2CIEqadtCUFiSE1RcYwveI05/aDB4?=
 =?us-ascii?Q?Gp5NyI1EPSGsjm+MKBK4hFHot4d4WsGUeVQMOCIaE9ghoyhYrGRXdfhZWZAg?=
 =?us-ascii?Q?CBrk8lqu+kW94mdR8x9thA0Zn1x3rr9JAtNnDyvgQQ5RtXoM1sHdykBOWKDE?=
 =?us-ascii?Q?E032sPFqKetWWBYav4RbvLtVYy03ac/PwhpBsMDvEDJ0NQPU1GVfSzHrGDxn?=
 =?us-ascii?Q?+qWnYgDNO11z1NDx6y4zUFLPKZli/Rs0eR6DfaQejMK7a0PjJR2ZRgf5v0vL?=
 =?us-ascii?Q?Nld7dNqAbHSb8Q0yie8hJVDx75gQIPxzGJieKwOylYjyMA3K5oxsStkEC8uK?=
 =?us-ascii?Q?FOwrCZhlr5LzVzXnorFB+nxsRXoh0QvAyRyRZkhv1M/xG4NdA6N7yKEjDCza?=
 =?us-ascii?Q?crL8lJWlkNZ8/mk0mPth7gfmfeS6mXwIlOQiVz9fr0joA58vNLVAJndGo1y/?=
 =?us-ascii?Q?j/5B/wbQrkzz1AWLTAv1a01Nnq+Hk3tzR4nBtO/HvAo/N82fgL9JcQPLTeUE?=
 =?us-ascii?Q?InzpxmUmbVwVkiLnmwu7tgqujN2yhviXHM1MRMxZM321XoxN+Jjo/qiUhKyZ?=
 =?us-ascii?Q?5SHSaFTr5/ueFs15b/b8j/3r8p4zffm7lS50SZX5zX1jjell5X9liGAIeiAQ?=
 =?us-ascii?Q?SQ8LHzQZpxZBTEiPGyBDtZsAEL9u+ZAR8aL6gQ/snhIU/4WnRpFT15uTPOcE?=
 =?us-ascii?Q?2xb73/sHtXdOugQqMzC1exxze9eGSkUmDtF8mQmEpzm8zodk5gJoX/Pnw/1t?=
 =?us-ascii?Q?ISJbxRNjRxwSeCKhxx8OZ9cEHoysffN+6H0AnMBNlXSfwWhHpz8qQZ6ZmjZP?=
 =?us-ascii?Q?MilVjQHyu6JsnwH+HNrZaIZ0Bj3KSAxRB/QgxkwATABaQ804UUgjb/svKoN8?=
 =?us-ascii?Q?/vBHmogG1XKjU82hdFpqqTwfbmI/M0F/VCbSi/pqua1hwTuFncdcM3D8u4rQ?=
 =?us-ascii?Q?JnKFvzu1A/C5HXSk2oPZtFtS6bKC8oPUcHs74MrFxhwOM3Ew0v6EBxeRwmC9?=
 =?us-ascii?Q?cZ6ZPy86CDqSQnhrppMy+sKTA7MchsEEk81hsRxrfnsl7VmwH3MLY1YY2Wjh?=
 =?us-ascii?Q?kmoGdXTgFHF8wLctz47oL8tABETH82bKfH/c7IOMmERm1kf4UFOciV/2SsJE?=
 =?us-ascii?Q?nCE9yckaP4k6auFW+ZZt5SiuVL0q7pX346QniAaCbCg72uvCnZsy/A2sYBFJ?=
 =?us-ascii?Q?GPemduU1LifvKoGvYc50bAO5TQxWYypTdOfkjmTDpzbotqMGxjIBi4jMEhR0?=
 =?us-ascii?Q?f1AvQ8euozowYAh/uKaTYw6sqpKK5FOd4unlAMiESRhnzYjuMkSndFIZy0Q6?=
 =?us-ascii?Q?FzfX1zHg0Q4LgXf7hE5gEleTGyqwZXZNHG4Uw+1YSracf11vAimdWe+hBicY?=
 =?us-ascii?Q?lK9kOppJ4r9qXLRHO9qODiq6bRZCR03eip3fgdCN1ClXhXBLwZlFKNa7bQdm?=
 =?us-ascii?Q?o5S8MPOm6m8onmWIvirqUqv7xSQzimMTb07euPja9PdXyqN8wFXAbZeKRD+e?=
 =?us-ascii?Q?yWYo37oGPoyGV5bESb8W5BoUP6Rd3dga1m8Wz03YnKbZ2sDQEDgE2/TGArzg?=
 =?us-ascii?Q?k3l8mI3TVNG+gMu9zs6CKQ5MDn74food//O1st2KW13ioJfQlbn9?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c36d5d3-11f0-4f4c-09dc-08def6ffa8ea
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:44.4898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcmOjklNbabQ9YpeuOM33bYHMmczGhQLTOezGxZ0pm3D8KEJI7iOc3j3A0Z2fJwUHFmWIb55JhkOPxiXdp/ERA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
but the link worker ignores that error. The worker can then publish a QP
whose memory-window state is only partly initialized, and later work can
use stale or incomplete pointers.

Set up every QP memory window before publishing the transport link. On
failure, clear the QP pointers before releasing its MW backing and leave
the link down.

Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f59f926d4bfa..3efc50955253 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1084,14 +1084,19 @@ static void ntb_transport_link_work(struct work_struct *work)
 			goto out1;
 	}
 
-	nt->link_is_up = true;
+	nt->link_is_up = false;
+	for (i = 0; i < nt->qp_count; i++) {
+		rc = ntb_transport_setup_qp_mw(nt, i);
+		if (rc)
+			goto out1;
+		ntb_transport_setup_qp_peer_msi(nt, i);
+	}
 
+	/* Publish the link only after every QP has been set up. */
+	nt->link_is_up = true;
 	for (i = 0; i < nt->qp_count; i++) {
 		struct ntb_transport_qp *qp = &nt->qp_vec[i];
 
-		ntb_transport_setup_qp_mw(nt, i);
-		ntb_transport_setup_qp_peer_msi(nt, i);
-
 		if (qp->client_ready)
 			schedule_delayed_work(&qp->link_work, 0);
 	}
@@ -1099,6 +1104,13 @@ static void ntb_transport_link_work(struct work_struct *work)
 	return;
 
 out1:
+	for (i = 0; i < nt->qp_count; i++) {
+		struct ntb_transport_qp *qp = &nt->qp_vec[i];
+
+		qp->rx_buff = NULL;
+		qp->remote_rx_info = NULL;
+	}
+
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
 
-- 
2.51.0

