Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B0B547ECF4
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160350; cv=fail; b=e+1yVWIy4f2dbnYysOhMuEYmhND0wnDH5mdeoezIotCkENhMNYB8EHFPYaA5CXjJRFxZkqkW1PXt9Z+A0M+XWGKVaGE0T5R3cXS7KjMnIPGZiQsR6m4/aQXeg63Q7CXNmyM6tqJNfZaAX/lbx7imdgeNfQbqQLuWyuD5Tt99xWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160350; c=relaxed/simple;
	bh=8HH911MW3qEugNsZIOP9oaDgFrtyTZZriaqBuTxJ864=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=QBqwGbD6eK7HFpV6wYNsIVT2GWnCmhRTBGd5pmhU/XKz5wxQAUPeTXJc/9pjVpJwbrfpl6M7ja+MsjafB6iS7hgYgvXOi2uKXNYGwyRHmKp5y1Vjhcw9SHy6XrW4gSNtT6WgiCawZyIizlt+OxeCB+xUY5GTQ+ledIvRzcMd6fA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=hEvWrq5f; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="hEvWrq5f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SaR43ej80RjETBZZTW/aahF3qc22o3uFNbbMBMsqnWgKp6YGcuPODoJY5YqVlElLaTtI2VO0iHHddzk333qd87gMOz1ZHYCZh/mbYXHK8cog3xJAF/sMLN1Zi7aNbRY8MVshvcaxYwmFdEFt6RdbD7J5pJ8aX5mfICmEFI+dJukAguhVxvAm0QEiYF319SN1kFrbM3a9e7mgzLePalekqGfI78lwKk6s8StAfMxXzT/Du8o0molLuejyUXaA9suvPvcxe3j1f7no9tsPhu+j/VF2gxgsJoEWQgjhO8nQ7VpE5/9MmOSsKdiFes/eKK2YUmPg4KkO6ghR/mxm2LwYkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qJv//T07Ov5ZdAN9YhiVSOpczm67MgJcZrGaLpD8y1U=;
 b=HWFzbKK87F1Tv8s+0emxtZHKa3ypb2oSsDK9Bch/24QX0d2BgeexeFiL+D0sMrMgb8MN9g+tGe10yLIyTI4LKIBiwVEZcC7SL4hnPOWFF13pGtqwPD9I0g3z1SINKqEs2axjqL6JCG0zc/VZy2770LdSHKXsNliToebVKRqf/79sYKxqy+flMcBRrRFOowbRex4PUjZC4VSWl2LKDgJlQZ92BahpmYcG3z2maw4/KtqvBK0lw2L0kaNtBcfZu8e1P4kPZRycYYz/ZRiJBO1oot704dNC+1XzKKjNoetwx4wwlWtwc7hgDUVMDyzn+J9W5mw2ehdj7wf5cS2FT1rELw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qJv//T07Ov5ZdAN9YhiVSOpczm67MgJcZrGaLpD8y1U=;
 b=hEvWrq5fPa/QYBTujWUL4EVCirU8BjAmnR8tPom/XBhPETBRUg2IMAl3Zz4NGowuvrRkW9RCH5LkoxRDQWQFTCak/V8/A6a0XdkLtJuOdpBIJOKOORM9NwR+iOiN4QPVITjvUOsMu06iMOhrvdkp/pUEdVTtQf3zTozHJb86e9U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5333.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:25:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 17:25:41 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 0/2] net: ntb_netdev: Fix RX statistics accounting
Date: Thu, 20 Aug 2026 02:25:37 +0900
Message-ID: <20260819172539.1450821-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: df41a4be-19a3-4190-ccdd-08defe16e4dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|10067099003|56012099006|6133799003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	gfYem/Bz0OJhBezCFtJM2tAmiICWI3xSu7bvB85IQQKBVN+a0rCqGIYXwtafmFv7gwsj63btGydn+D6XtaHWSMl0ZHFROols9KnD81Mp0l6SUwvSS2NN4XawQbm+k3rXHnEYLlERGBHEGKN7PJwtImQzSCEyRma44K8vwCXuAW3IPsiggmdthnfOvgt02pHnuHFQOu32qhCflhMHK7NS4Ok7cGkcDldnJiaE7dQzq/DTY21Gl8JVXsg4s56VWhWW4fr6R38r/28aA1KlLiwJgoydChjvIFTxCGNvTkiQBHDcgAXR/+EORWFGbHINemPRzl+VIGVblZcM7IeH2VBXtNHiw/mhoMI9YeyvhrvxPY7dkbSkSFfElUvCvc92UCQMFTNUjvGB7yc2FPDA2g3Vjc2ujPf982poDFwCUBTaVwbWCptIfPTgle3o/2CroBBmaIz2D16fRRda9bpCL9yMcJSVae+kHnNuJA0/hvpBkBE2cbxNYjz6a0whE93VPuZ/rS1rTYSxQzu5gL09CWOjbWydLneMZe5ZvXtbJIzUUwPN0gy4J5jIOopUGqts+eXqr+yC/m7mLTCansn8hOL+Q1GDvKoP6er6tPw/Di8btofEpxmV83GuwI3MDJtORrZayGMsDd0ABPkLh0BSTwzDgVHni3IgevfJms10JBD7lT3vehEswnSWtjojy7/e5XgQsa7NTJQ1jqgKfWW6+ZCSBA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(10067099003)(56012099006)(6133799003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IjDEk76+mdWTwGQ+/5oOV9ZNihUNZ4Fbk0AyX4EKLEHLMbgAYR9kKMNzzRhx?=
 =?us-ascii?Q?15O9aONF1OCYNxufzN0A1rYdkeWEbB9ghd58J0N1i/ELvowsA0WF101s8bql?=
 =?us-ascii?Q?BUYjjawXA7jCVIbyA0veaA5bmxh02pCT1cESTHTiLtHo1pNH5qp75riVAkCg?=
 =?us-ascii?Q?lkR4Xix7sXLvKhiz4Cwl4EYU337yfl/fcPagsp9vC9D60lYLiliO4AoTt5eg?=
 =?us-ascii?Q?PYPYqgYS/X2RB0KuwmsEIrtQG9bWC/zdrt3JJNk4XeaLru5EdByplqf69JTe?=
 =?us-ascii?Q?W9w8jplATD3vDB3OOs9QOELP62cJW/c/Zrx5vvb0uvrqFzb47HcLi14vYcRE?=
 =?us-ascii?Q?q/dyB+pKmwMwLXubMDkXE6p6i5frf0AZM3C4J7DyguvsAsQpuvPKwz8yPPEk?=
 =?us-ascii?Q?f1Esuloezx4B9hplPhl1A106JQqeUoMiWM66orMKM5jsSbuk4vUIpR+9U+nT?=
 =?us-ascii?Q?Bam5KCkwO2y3ZMPWxbUvNPU3FL0Kbldn1ZHHIbD4ahJsqjKho8kkcm7KqLq+?=
 =?us-ascii?Q?8nN8+xH6dG+ryasQzTv7l6y+G7+8TsjXaIYbA++HqdVCEWckg6ki5EtsFPDL?=
 =?us-ascii?Q?DrWyLhZjP5+hUbS/F2AAwciq2Op/r5AJe+u2LwPxdb3xtlUaBBSt/ZswMvug?=
 =?us-ascii?Q?DlqepkDy8ok3KoWDULhxYDhoPceNBUJqjS48W50Y6sNQkr0ZVYkfC9r6HmAE?=
 =?us-ascii?Q?cmhUZlSz/24e9lUT5ThMBYSK2x4hf/J+Jeve+ay8oJ4RyB+GsmJAY90UxFTn?=
 =?us-ascii?Q?oK38bMMtcv4ACY5y6zadOBp8wLzn69PDWhy1pZItXGG6/wXhehtQSAYarPbi?=
 =?us-ascii?Q?J1OeAILKYYExvinRPgekhMoaOQj/2mif6A+kzPapITu4M2Pf3HDCC+TxhhDa?=
 =?us-ascii?Q?6JPZAh1bEvmOkUn9Dxm0iHXpm1raYkC6RfmdzNaTX8DFsB3uB2rqlBqLYXoO?=
 =?us-ascii?Q?+Fy76sImPEqfe6FevCC6HLH8CSMeUIZNMLEQA1PIuKbzm4EiA007FTKKQmI7?=
 =?us-ascii?Q?TsZ1IqseYwOiIqHkoJAYKCWuYgEf2hIadpWHoju1Sz5klcimjPwsuu5miJlR?=
 =?us-ascii?Q?Tt3M1SnvwCH3tRss6o3EGal5RZAG1fs7xNcfvZkRLA0nK6V4Apic3heSztA4?=
 =?us-ascii?Q?5LEfA3yyzVayMoxEp+PmD5/HV0IT4t3i/e8KcNVdoiBrGZwt5VbQ8XLqJpjJ?=
 =?us-ascii?Q?+MH3qorVzU3AZ9DGm9VuCDju78z7Q7oIV7as1CdIs4LT0NTzNl0zj5T6QwKD?=
 =?us-ascii?Q?rCtIqD8m+gz1UKE5H+ZLpGqHfxmBOz601lwHYUM0O5EvKvwiKqXmeoCHlrgg?=
 =?us-ascii?Q?q223fZgZBHc+/rHQ3n9QVHRqkV1tLEc0pAZhJzNcBzDDYdbd6PxkbLovbX6k?=
 =?us-ascii?Q?4M4TbGrmwBzjmUMwK2MkybysnVDMUEFFqiiDMqeO4USRbeWrSl5TtZaBWMJw?=
 =?us-ascii?Q?I+xINVQng7b58xcUDucDZ4+o85wpN33tRIuAb4mobdRaC7LzZhi6wa3IxWN2?=
 =?us-ascii?Q?F+SYRZLq36jWdhPOqcBwybE3e9FckMZkKN3rDQFeR/+lbYGBfVuxUL82uAfQ?=
 =?us-ascii?Q?ddHiLzP3QLQk7nxcgBQ2QOicRUtH8eUzt+fuFNwhBVzpYUAs3PEhd1hiyhyL?=
 =?us-ascii?Q?GctA3X8Q7P+1cqElo8UEYaMViR4ZK2d+QNb4LDY5EpKiPG5ZISqDADp6ZJS/?=
 =?us-ascii?Q?ptHX8gO9mLPGUQny7hPxkh2/d5jO/ig6VFF2nJQPaovtqeNhuTAbRPNTuC50?=
 =?us-ascii?Q?pAHzvYMXz2Mwd3nMT2ddI7f9f+vxgezyw71ZpG5ReBqU13bpaW/L?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: df41a4be-19a3-4190-ccdd-08defe16e4dd
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:25:41.6689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HY0Otzc2utB4EzjEbMgnUcrNWbycw+IqegA3r4n3m1N3DTcTXGQYGfrPAoWkAjw8bVTlQqhYCMWJzYpMoZOmwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5333

Hi,

This series addresses Jakub's comment on ntb_netdev RX statistics
accounting:
https://lore.kernel.org/r/20260818092938.4121c220@kernel.org/

It fixes the double counting and also the related packet/byte accounting
on RX refill failure.

Notes:
- No ordering dependency on the TX completion/error handling series,
  which is currently awaiting review. Either series can go first.
  https://patchwork.kernel.org/project/netdevbpf/cover/20260817053519.4135287-1-den@valinux.co.jp/
- Once both series land, I plan to post one follow-up patch to net for
  the multi-queue stats race introduced by commit 24d9e73c7e00 ("net:
  ntb_netdev: Support ethtool channels for multi-queue"). My plan is to
  move packet/byte/drop counters to core-managed per-CPU stats and use
  DEV_STATS_INC() for the remaining slow-path counters. IMO this is
  lower severity and better done after the TX/RX changes settle.

Best regards,
Koichiro


Koichiro Den (2):
  net: ntb_netdev: Avoid double-accounting netif_rx() drops
  net: ntb_netdev: Count packets dropped on RX refill failure

 drivers/net/ntb_netdev.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

base-commit: 564973a259ec76f2dad0853420e7034cc43994c4
-- 
2.51.0

