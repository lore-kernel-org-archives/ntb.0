Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021126.outbound.protection.outlook.com [40.107.74.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338C538C40B
	for <ntb@lists.linux.dev>; Fri, 17 Jul 2026 06:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784268756; cv=fail; b=m+wnFJUbSscti2SsJkasHMoXl+AYa+nEqipOFXjZgoMj0dD8Bl/2N7/HV8epNk3BB2+6nGjN8ZdgRZFIzHgjaroA1TNvs17PL8OHVzzJRClyzbvZAvQVnFQgi95Z016mSXep3ZbOZLyfCmGa9uPyHzQ6ifmsDE/Kroc/s5F/PW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784268756; c=relaxed/simple;
	bh=LGOBn8lSHbZrOVYcIjPGUHZUD+nxEmXJGWzVZe+32SU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JKgUHlh/GgUSS/Vq8AlP4G2CMUoCWQMp1gAwfWYh6v60Ui5yPB+6tXDXiYHS4ac8wIHpMJYxik2INtsi+wrNkefES7Fp1C31AykpoH9hyQ8wKN3fa32jbBqtVPEyi8uxr2wCehLilrV+09kK6sHVyLWO7Vs+2atZZ4CKTugxjP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qpt7jEBd; arc=fail smtp.client-ip=40.107.74.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qpt7jEBd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sPIfHeimP6PLOA9QeJ3SmqrzIysMWz+2IVbXJGkgNQDtBMoEF5PUYcQ4vyNJh4wgW6i5AvLBTDq1wwdGQBUeJe7t9/Zwn9TTQI1uI9fZYT1HZRBTx79rQbU1MjLvSjJUDHQPmufsVJRu0i2YLKatbO5BewgmG/NJz9vbigdsMSu/yH7kv1pRmaCCI9+XZyAEsjXUGG+6mnM/3wT4Ez66JT6ZnO6Ek61tnFSR5Gfa9tKZEQ+VABJuC7dU8PHaM73TgJ6FH9LPVNaqPyyQKgB0PhrR0uJT0aQ530e4bITiFQaGWlGrJHdCJPePehBs4QSiMJWoVRa71IVlZLdpH2rXkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/yS0D97dDq+J2eHnCa2Ns7TuFY1HDFTWJqRpSz11W0s=;
 b=vGx9WthuY7fKCEQHGGwMWylQ6JOwtJb15dhneJsfzWkhIGA+p8Tb3rEEe3ubO87FyEA7W+EVkDwA4jQiIotf4QmGCrcIy7BtIn3sQn8bwXh76/WwjHzKbps9B+V6+FNmFaQcqAQhbWhGRazsmc8G0rNLGiAP6MzWsoNOpkh6UEcAlt/v+9IYFK7dhv2d8R6slxTxQq2fFLsBjNmKMdgYqj9VzMlVm8rf2laoJpFMLZFizb4XprmRLM9aJEeZFtC36xtgZRF8jee6Ey8Tgj2PZ/I6c2iw0KKUAAim5j7JNIZcN0pXeqBOtor506JgltYJGQjY7q/9HTbq5SLDoyKypg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/yS0D97dDq+J2eHnCa2Ns7TuFY1HDFTWJqRpSz11W0s=;
 b=qpt7jEBdCKz9q6CnszgkKeWRVSBHgruc/i4392jcbDIuDXKC+kNG46ipfLwTIZAw/N7heBebullCDos0gRqwuk7B/sOOEhOpA+lUwICsa12dgIeDd7OsyM1i9aiFF2U4bgqlj9nzU2I0g+zTp1rQvhjdX4NAgb8ceDP+h2l6geU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2543.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:225::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.12; Fri, 17 Jul
 2026 06:12:31 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0223.008; Fri, 17 Jul 2026
 06:12:30 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NTB: ntb_transport: Mark the transport link down on cleanup
Date: Fri, 17 Jul 2026 15:12:23 +0900
Message-ID: <20260717061223.2203863-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0152.jpnprd01.prod.outlook.com
 (2603:1096:400:2b1::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2543:EE_
X-MS-Office365-Filtering-Correlation-Id: ce6bffd9-8d0f-4999-453b-08dee3ca623d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|376014|366016|1800799024|23010399003|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	9M7msurdK4kl0xD2VgwBCT9RIviaED92RYddfWQLACgkYbx8ObtNfkHN9M7pX2KDVuMqUhWulZP8qRVXaJOtD05PSpsJYjYhdqc/JB/3wwgdg8K/6Rrpma72mK/8YgeLPEZ+o2Un+xslnp7DpL80iJ2PUo6itSbLm2xqb2PO3Gft0afwrv/brEDAbqnxjFksZ17lLz3d0WsRHobNfSvECNwL+F7SQRQOC2w5ZgJp9DyU+ILLVKDjKVrnsD0qRqUoZPZZLsA0sc5b6njf2vN4+XxNmCP0kV1uaxwOq1fB0sK2MfBwmFDjJl03B88uPwzsiYYQpYnRwqkx5fEuJ+A9hzVIvCssZGRe448BH+Xvd/EJrxT7/wNR5U/+JRB/0XQ6rh/ghOMXHrMpH82wKcCbF7Up3h7XJm+qCw6NOx0xxkBansWsKrDlp7jas6/UW9C8YulH/gj2Er1Qssx2oy8jAfTZ5zacI1k7NvvoYH09flRuLdSwzn9bWSw5u9hcWeQctdH/lvAe/ZUAVPwjdOT/T15eI99yd6jpGedGK76pi57k6qGMcKTCKivQt+HIfq877yJm6QS079/lMLN6xMvnukvsB1YDFSuO+Ata0Sl/YtAv2wFmgeVLJh4ybAhnOa/KuM4Ps13Ks0IPfh4HwL1OkG+BwdAj9YRAuPd9lJrLOjQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(376014)(366016)(1800799024)(23010399003)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mtKSjQUvfHQriB94HTTn9rBNM04DQ/42F3mtjaAk43OX6nDU0RpB7O46XQm1?=
 =?us-ascii?Q?Sgic23FQirzyeElciuHcmDnriJEcBbEx0INjQbdGdc1h9HR4JmbKvgqOZDFk?=
 =?us-ascii?Q?JHrUVzGZtHLxvO7qsNwFvcAVoTyOeVIPasXpG/jmVIsofa1dgFdyZlTRqAKP?=
 =?us-ascii?Q?L8UHnrxR0B4yTHhnm8NeuNMGbjoCJCZcKeu0gA2ZgIb5J5/2XKXJALonfdUT?=
 =?us-ascii?Q?r3gfS1nnh5sdg+Gmjl26Q8naZGmyiFpnkHQu7LLW7L8SJcBtYVA31L57JBcp?=
 =?us-ascii?Q?AokY8X9nOCDxgI39Q7pqxotqXztQoPXru4gt6SfCOA2SfsPP1EsbI4gQSTIY?=
 =?us-ascii?Q?/IF/DYfMqJG8MIP1sb1eJBIATOBDc5YFIEjhX7o9mynAuFCxJrHxYabY+cXo?=
 =?us-ascii?Q?UvKvFU5xwyqHMx18LOU2Rag3hBiR1P7gb03MDKD5L/ZvZQsG93xQJh3YvrHQ?=
 =?us-ascii?Q?L594rNi+6DMCnwfTziKOWjdEAxW6kXcNXE353h5uedoGn+f5xa9FSVvEomgW?=
 =?us-ascii?Q?sK9xM8+O2TiBx2y9sRZLh+0VpoYZZsM2WpP+tL0i2memkLLqne2In4xz9qt+?=
 =?us-ascii?Q?Kkxs1Qg1ZVumA2I32MeKo4c/T+lCRibPDUUOsYoz+lalfw+FmZPgmRFLtGaX?=
 =?us-ascii?Q?di4+FMCDfkjx03rpgIdCY9ZY93UfBmCUlxQIAHq3kPZCrIRqwY8ZYGn/HyVp?=
 =?us-ascii?Q?o/Z9OB1kU+Raz8Yy4oZCAEHbO3/7Yo5SclU7Hp4jsTfIEt27n7A4NnaHexfx?=
 =?us-ascii?Q?b/SIfl/CIYkl3heaBzK1HKuM1VxkbiK3XT//0cnnkFS+HqQOy+PlDM0T2kaG?=
 =?us-ascii?Q?+x0kQip8nAXYTlqVTj9tvJPegw1OEYAjwWHCQKlalMm3q1LOzAD1HOhdFWX/?=
 =?us-ascii?Q?sALjOug6RmqACTs/7r52P/90+IAoLKWbLBE77XsiY9oOJB8J/EIaX9+gkqCQ?=
 =?us-ascii?Q?ZICMaJ4zkKbnTs5XXxiSXWEympgez2v4TyzqzMbglMClMCXTL1CPjPBbCKp6?=
 =?us-ascii?Q?YHoV26VU/WhiL6HkGlcBm3/zccR0B/tKXFINN2KljOsZANMH6D8bagTFWIOz?=
 =?us-ascii?Q?mxkaEhctS1naUMDNPD/Zg7n/lhTNObEWMBppJKSfTRLcE04tBAtfdJfAGH0A?=
 =?us-ascii?Q?+A7epEVhSAtuWmr/dlatcbOJz0MAOgJayfOwD7xC+8U4/CVU090QcRNX0/Qf?=
 =?us-ascii?Q?LxzyQYR4kFEREP7Wd3cYB+LsXpYob46BfV6dgSSoNqrN51vc5o2NxMSet4Rk?=
 =?us-ascii?Q?7+jbjzrl+bq04+s4Xf52fOfxpu+F7O+WAzYdnzBXjKg3xeS8wzqrnGsgSDIB?=
 =?us-ascii?Q?APC7rbOMdJfS6YsTbS97FkSFrxjM/A0gCNypWi6KatGE0hHjY5tOUg3QKQ2J?=
 =?us-ascii?Q?Orx33F/8iVPGtas4pEwatTlbLcJH5/I+kB9kTB3FdlFz/28LpqLaHgbciZUW?=
 =?us-ascii?Q?eQ/zpARpvy66NOiksiavAUhWzkZdzPIiE8bh2X+PlqRl+4FaQkOZAbqdU4MY?=
 =?us-ascii?Q?/xq4ZerunVkKROtC23+uZ/I/FtRKGp/zTnblAYalVQy+2yaLivSKAemIslFx?=
 =?us-ascii?Q?Z2kAmvOSU9QuNQgP0XAI4hNiSgaWizrmXYcxWZlJnJ/6dxmwrLeypIodV10d?=
 =?us-ascii?Q?PX6eiKBpMZ6mnxkYtHIwXCbIxo18cVDE6GTCYupETtuowA6/I+P0I0aS/lv5?=
 =?us-ascii?Q?uyaaKZeWKx7hiQzFN2zjRnzCkqZf6TX8HVABiWS0OTytxkMOAQR7ReTgs3um?=
 =?us-ascii?Q?zlxdLfchhY7v0I176eBQgwYqpgoqn0F4vTAFEdoE2hFUm2OgVe67?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ce6bffd9-8d0f-4999-453b-08dee3ca623d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2026 06:12:30.6098
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v0QFNbkZj/c5cxeoAJsT4P4mXFazeijoIrDQPB+zRgF59i0zjL7Z9+r0Pl0DefkRB1lDwdBMeGLVe86FgNlgZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2543

Before the NTB hardware and transport drivers were split,
ntb_transport_link_cleanup() changed the transport link state to down on
the first cleanup and cancelled pending link work on repeated cleanup.

The conversion to struct ntb_transport_ctx retained the repeated-cleanup
branch but dropped the state transition. Once a link has come up,
nt->link_is_up consequently remains true across link-down cleanup, allowing
QP cleanup workers to retry the handshake against a peer that is down.

Restore the missing transition.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f59f926d4bfa..5b9fccd1383d 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -974,6 +974,8 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 
 	if (!nt->link_is_up)
 		cancel_delayed_work_sync(&nt->link_work);
+	else
+		nt->link_is_up = false;
 
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
-- 
2.51.0

