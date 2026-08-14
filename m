Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020083.outbound.protection.outlook.com [52.101.228.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8353D75D3
	for <ntb@lists.linux.dev>; Fri, 14 Aug 2026 03:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786678162; cv=fail; b=Er/H9M334lcJx9hkoN9VzliS/wjNpyOunMy98St1MLLUi3TYJmzr1SPpiKer2i7iUS8LEpX9mEJmfSIKq1dat1GcHE0gjHD5VA9C80njjpl0JUeLEfVDZJNEqMjWkMcVDLY5V9oXZv1cxNcRYtNQnhlzHWe/Nwdxk+3PceXL4y8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786678162; c=relaxed/simple;
	bh=oxb7oRz+MAVENqeIVJ4Etfe11FZ08qwiZTAiLzf/J2A=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=LOFzKP1XjjXiqWF8zsDEztibx3t3uPfsXDFz1/aMxHPtfiJa4WTWw6UQgel5Y6p0Vp21upm9mJsFp/R659sIIUgUrHKstkrgWPZz8TnBjBV6e0ypQiS2xncFQV9o6k9DnZjP8fZznMoBlOKm5gfNschATUZAWyyD3llY/0yzcLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=jqEyhCq7; arc=fail smtp.client-ip=52.101.228.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="jqEyhCq7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrWjlgEXV4VbGuv5uJg/7+UuhPISCjySJmiO8PdBv70SDI4rG5wx4bDNSN3pj/keSknVkN4qozqSjQhXMGnGyQdAsM6cCRUZxlUH2zT6G16ZQPddgbhZJICG6v1y0QjyKi+n3QCZOhUBd05wUiyOWORjG7zAnKz5FLU865aFKgvyhcmBfA9aJczSpCSLdUov18yl5BkL1v3mR7X8/8x45fUwlbdcO7xiklSJ2nJVlgyWd7OzztydDriY4s2Pz/2TU80Kdp5QhGrz3NxbhNKvolusEkWbXae3kPkpBMiHpDFZVxr54GKeI2YZiQr0aXpI5mgb5BFwCCpL+IGm7cwlDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R0B+vmDZ6GdVbAhbONsu6d8n1abReJtYsP6KERsIWDw=;
 b=DUAmXHl/aumdaQ/6FgJ59R5elGcmIUxbcDkQzoZ8U7anNS71Pe+IHw+4Gh4j4bEUDxGRjMx+KZKB55jz73VSplndfqTkR6J5RIbN2SP27C9YYIofKMDLrH6ByiYvj6XCvFYasB7sWEXewhh8Drj2fLxYTWc+M+Hb0m7BdWfnBL0Fk/6wLG3EyvRmprB/FS8JCZ/oyGX9IyEuvLKl565aqDDj7CHEttlKzCp9QDm/n21PepJoiXV7RdDGhsFzyM+mmP8OBlcmSKcDrHGNDc4PXhlDK/+NAH+UhbwuLmJ2KcEeG2fHHB7SZz7Q06y0BMiAjF1aQtrw/ywJ9zRUdNiEAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R0B+vmDZ6GdVbAhbONsu6d8n1abReJtYsP6KERsIWDw=;
 b=jqEyhCq70Q1yuFum69CF4C13Y2uVB0s8A6nBND+hFUBmOl7J2o0RSqixV7//RNJcj5dBiCZ8LqTW8ij/T5Q4A8Oi5jzNrvfA6SvpHsaIeBgIfZTNkdtOKo+mAMkDvOMtcegCe/xnvlk7djyTUsn9Xz4uvsohgcufKFLc2A8w1T0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7404.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Fri, 14 Aug
 2026 03:29:16 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 03:29:16 +0000
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
Subject: [PATCH net-next 0/2] net: ntb_netdev: Preserve checksum offload across NTB
Date: Fri, 14 Aug 2026 12:29:11 +0900
Message-ID: <20260814032913.3558500-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWPR01CA0014.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7404:EE_
X-MS-Office365-Filtering-Correlation-Id: a42f1960-33ef-4c2a-7484-08def9b437f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|23010399003|1800799024|376014|10070799003|7416014|56012099006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	gpWQe/dxZ74J/aLh7Yo1W+b0mb1RjURp8n6UD3UGdLZyTUFoRktYTruHCfmBAKtDn7v/kY4r7wc/c6f24IvVQZeeqLAjrclURbsJ8198hJYsJE83rZZ3dRHlc84hrf4sHXJg5h4sEEXHMfFmGdcK/QkxeBPTcJYattrJvw+nJXtUC2bEnoNPZWNIcMMY0A5uNI9jNPUvgghjHC4rKkMQ3KDSO8Uyiut2EtiVEfgzOUXpLyaUXKxQDAyfWh6om+qCD39IT9/T3yoi5smH1wopWGAUqdFabVpxyZVrJGLP2OnHEKESYPJ5mGjZ2ppd6AOww5KBYXhylyRz0OsyvBpFkXjNsxzo0qfFaUxyVllvyZCRW5JfkdgFbfia+oa6KZ/E11kkNBUoQfyJbaUyHBjYpZV67W3wgWCCYE5vMsp1XcqfdXeCMLUSZ4MV3Nug8/DjoNny0fSa3Lg5qkliohhTVRzTwOqTgd2B0gBU4FOutrun28doBkRzNTYQairuyVQyLjQMr0/6IgV9jm9DItK5mIfVWAz2EngngcxKC8XlDyNJzzxiwRByrg/FX+qfTSei0odF+vA0EcXxHjOH1KDCyF2eHJgzXBjdA40UM6ZCtCE+k3KV14ZB4wVJ9/RZEqBZ8JXhHQfL08klgMl9feg7fYaDQJnQNUYX/sS+ozaxW7k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(10070799003)(7416014)(56012099006)(10067099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xWMb2SB75boNrHGtl5PhE1twPXwHGw19NYhL7U3JKQ2CoN8lNuayCSyPkx1n?=
 =?us-ascii?Q?QUn77yYLuHjUsuJeovIcBVEOlpk/TJ34rW2M7ndcaBqHirwU0NAp0/UuUJOV?=
 =?us-ascii?Q?OmXzE9bta9P/4rwg/pSgFlVT+zygGdhC4frSYdzJ3+yRxUXQz1Fb0k3CIJ9X?=
 =?us-ascii?Q?BKIcKblwwYQeP4UUijZwuFalcrILbCCMbId7xestfgnLvISr35Fs5V/x4t5K?=
 =?us-ascii?Q?XsiJ5tXXoKI8O1GFQpiX2icVafLzFU9ReAuT+TtdJksk/PikNNLgRB/vKNLd?=
 =?us-ascii?Q?bgzE8TR2xbQMkMJD4CheAhi5U55aZqqEjtdCrYbvo4gr+j3vQo/JlIqgZYoH?=
 =?us-ascii?Q?C/h+oJdoYHsrSOfY11aH1dpUUlVqGBHqGqnRS3LyiWzP7emjlGCEpzlkXsOL?=
 =?us-ascii?Q?pEvyGwsyR+5/dIQnOxFmoUyh5MDIt/Vj/Zocs7vm4Tl4lGhKyxE6lPdZZ9XE?=
 =?us-ascii?Q?3eCpCSvcHDdoOuM3+SGp8/0cMjETPJDy/76f9I/vIqhJdbeS4pjuSwmN8bI2?=
 =?us-ascii?Q?43t5o2SC8hYPQeiczPewZpoI+1lsazC4IUHS87nphQ3ymUkPlJEI1ogB/8/f?=
 =?us-ascii?Q?HlZiqojUrcQkgdqOTBluB1p2PK5HnT6wzFhBzNlDEs5VwuForJOxbsZL4q/8?=
 =?us-ascii?Q?CaYED4J/M50zT6WShdREodgHs7dvvzZaxj/RnyxZUAd/lshJDe3y5k8EkscO?=
 =?us-ascii?Q?lrXVEi/Q/pC+pJRNPadEeek5Byo04NqhvRgVOivWLukBgtmn6xq0lW+DNMio?=
 =?us-ascii?Q?nxwBtyzF3LZcUbbVyZhX4B8hAiyxGA8T4ZQa9CUz0gOj6MSIq9vqsQ2fqE8v?=
 =?us-ascii?Q?Vag5MAuJJYggQNYz86Ge4cMuOqBOXFK59JfGJsQxSkB5yNFygwdh2HEgsmsg?=
 =?us-ascii?Q?Qt0GCPHlq7WyRgSeFnHKMQn7+dgWdL4pgxO+IYg3nu0wLMCYd8F6egOEregH?=
 =?us-ascii?Q?SsqTxmHOKFB1SaPBnl3BAWjsSeK+9AVycurRsY2WDmR4qzP8chCESmexhn59?=
 =?us-ascii?Q?YCZ4q0oyqyIOGLLop8ZfsY3C2cvJ/DhYAZIMk7sZO0eS4wCiw4Q4QSONMZK1?=
 =?us-ascii?Q?Y4+KQoQToGuUgNQzuLjgCPTplabEUGxbPGg0V2aGIOd4mArs9OccC8OO2hiH?=
 =?us-ascii?Q?XcOCQt7ZLiOPOae4f96G32c2P0b1S4ul3VZ48pOxEe/cMnWIXvi7bgN8phfx?=
 =?us-ascii?Q?wYK2Y60LUGivh8BaE/G92pCThH075PSKoJEd5KfuaGAXfmqSjhd5LV1w5XKc?=
 =?us-ascii?Q?Fk1JJQrNtar2LHlDZuMG0wR6egohlvDpjKjK+BdfNxXIp7wPXIzGFT6dv5xG?=
 =?us-ascii?Q?HnoHDenSsO+odjh8Sh+VvunDD2sVtNSxJB4jzZ+2qoOehUxvPomQUnNyUNMf?=
 =?us-ascii?Q?FhO2JuVcjEFVagAdBWro4N/xYaB2tiLsnhDJU5qZNAQEOVBkqltgU3MFarhi?=
 =?us-ascii?Q?TuSMft6vJL013wTweUeKPYZ9VS1WyDr8monyuj3Y9Nm0E+bd0Yir3il8G7Jw?=
 =?us-ascii?Q?W5sSxKieCVGe1c7+lLayKEpsLA4Pew3pHFwFgH+HbBspN6d7UrMx5nfDB21x?=
 =?us-ascii?Q?6aAh0tlHGlIPHsRHNPqtaS2NIa/W05jk0jtvnyQo7ghUodK370nbTAe1Z1uR?=
 =?us-ascii?Q?OwgE26KlLWSeAUTbS8tbOKvfIgDigHiRycFnXhNz5ac9U/ZKyGVr3CYEwbVd?=
 =?us-ascii?Q?I9PDy0YQgkXVkjO5rivzavK8+crlmrq/6bwq0itNsWNmqnoP6/eYsNCskbIo?=
 =?us-ascii?Q?/Y0WwfgkFbPmiWegMzeqVw7PvjhqOXlgWaDEou6dblb308z1G8Rw?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a42f1960-33ef-4c2a-7484-08def9b437f0
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 03:29:16.2193
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QG337n4vA9/GH3XQUoU19DF01JBTFWyKuVLfVfIiWDVD/krVQSXcZAq0IRQYe7Vw9tuvQ8FzCBkmuH7y2PRsbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7404

ntb_netdev may be used on embedded systems, where CPU resources are
often limited. L4 checksum calculation can therefore become a bottleneck
even when traffic stays within a trusted PCIe fabric.

This small series carries CHECKSUM_PARTIAL state across the NTB link
using opaque per-payload metadata in ntb_transport. Existing peers
continue to use software checksumming. The feature remains disabled by
default and must be enabled explicitly for trusted links.

Best regards,
Koichiro

Koichiro Den (2):
  NTB: ntb_transport: Add per-payload client metadata
  net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

 drivers/net/ntb_netdev.c      | 78 +++++++++++++++++++++++++++++++++--
 drivers/ntb/ntb_transport.c   | 18 +++++---
 include/linux/ntb_transport.h |  6 ++-
 3 files changed, 91 insertions(+), 11 deletions(-)


base-commit: b3217bdb0091e52887e23896cd82483f7808914a
-- 
2.51.0

