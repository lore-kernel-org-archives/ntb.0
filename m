Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020106.outbound.protection.outlook.com [52.101.229.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F15303A8FE9
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 06:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949372; cv=fail; b=PHSf5vBEgt130vXEo6fZ1RfANGkhKDmkKj1kVXPiM3I3khJhFsMqNIdHCW0xEPpCa/XHywmFcEPUHOcMaQIMn/MjXWMTsAOgY0g7Ax266Wdx99rPvmzofSB42+v6gri6uFAYnLk+CPsReWi4S1ahURa9rjo/+8zJ17WQGW+NWTg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949372; c=relaxed/simple;
	bh=pxaeBEEouUeuKHRlSAeOwuXhOHEc3qUFmTaQzhUzpHs=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=PAUFeLbUZoLDVdl6jXcKSGvPastE4PdHNDsCaWKqJvkSWwY5VPrD72x8Kgp34rX7nMPHGWhKdk9meHjm3DOKUA/q84WkDYRFWh69gaElDoHyY06A69DzjKV2u/7CVFq2rTySdpN0/ESXen7IU/jj6fY8ofX4pQhf2hiQtnNSzOU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=MzBgfzWY; arc=fail smtp.client-ip=52.101.229.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="MzBgfzWY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rC+KXr6/n15Vfw1rAo8LhPKMqKbIyBFSVKi7LpN1Yd3emTGk/l0tJo47bsnYv2TMaTeJcoEFRNy0yKOW2nXLo/tZKvN+lorjRS7xwt8hEIw3So9vFddzzJLt+6zopMK3dQuYqRow+0Dv4m2GseKr2ZFi/31dZd6gy6sniSLe9CkdpAsNOJMjjINp1Mz+697h8C2b0fUgWxlnTsBEc8DH+hqbv6tZy55420cu6mUhMCiFEHuzf7COytMn9p2Y8IL6cYSsuUzXheiCNxUCZINoSYAwW3ysBuW726AAKRAJ3am0m8+fOUsPMUIoa5VFmffXdfdqT842UQYRxEwrxbyHwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZWaaWhlwqxmlfIg+0ARHDuBT00h1OeXNt3oS8q0tW4=;
 b=BVG0FUpqKlV/7AHup1hjr/q3Kcal1v8DyceAO0rYvNP3fV/x7p3afA0ufKc8gNgzfirmB6YeUsHuOHi+oyfwwBxwpa3HGGoxPlZR3Vj8ypv07RcaNn8lCpHNe3Wvjpvns/Lh8GxmoK88JrR9o83Zsg20KoV/0Y/YLiTBtdkrumJhfEwayRMj5j7Kg7tMEzAKgGRz7necTBP5RIS1EL3pekfSjLlfVs4LGJyVjftFWsmau74gqzBNKehWbMaHSQpbCZdllfQVUhA5ZYaYR3KYe0oUoEmeQRr2udW5OqdYpuGKu7Wa/a6Exo4i6E3PJqrmB+3xF6O2SOm4Sjd08m7vmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZWaaWhlwqxmlfIg+0ARHDuBT00h1OeXNt3oS8q0tW4=;
 b=MzBgfzWYQADl5u7mM22+EaVdLBxP02Xpb5Qr5Z02zhvK5a1DpLrI2LSSxLGpn1GgOleBgth0EbWjwuXq+CHgA21RnMK++WCqkieedB0mcVu1vSqRU0iuP6HBhILY/OICWeTfvRd9hSQqXXczyCd/Isq+C3a24FNx8MfwmxVSNKQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB3805.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 06:49:24 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 06:49:22 +0000
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
Subject: [PATCH net-next v2 0/4] net: ntb_netdev: Preserve checksum offload across NTB
Date: Mon, 17 Aug 2026 15:49:12 +0900
Message-ID: <20260817064916.13278-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::17) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB3805:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c73f462-cc46-40c1-fa57-08defc2bab56
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|10070799003|18002099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	2T8FVSBvN4JgOezZ0ihLQPThieXXxfsUvQSMjhZh+Su+esMAJZF4AfEpGVn84CEKXUlik3VM9P6H2KVl02f5e+eFTTV5/jtCTRgDD1TfBFo8edelOlMfCGVW/1iFnYkVNKnDXen+43M2TZj2hU5ytFhP8gHpC3WpGgFfsWdZLiMQNZmLqy9CdGusUN6ID8I8Diu2vPRS4X+z8bfzVPTeg//fI0nilsKc+WIrqL1AaZ2jA2T9cGrpgNdvDrUBvoUp9FMLkwwe68Zeq1EWrNW4uyDUr/Bk18MwtlT5DR268tA1Yw90Qb8Xb1ULCXZ3axdPW4yvsQrEiYkMJVimvxCMg19hNyzo2+K4l7sB61eWmzi5QF/mgizk+ax7Ld+eqq54GmZpOlkpIksS63I1KjKtnQVTa6u9Sa/EY6sLpYgPK93Wo1pxo3B8oW+Wns9n1lvzsxuf1ovgbdj6/rK6WvOwttccwh91g5nTvPeGi2Xq4flSEKxIaYJ1ia63E6uRJSGCQONyG8ZyJE9G2ghVJKKcIs7A9kaDivhjI20uXr+osh+BXQe3avL8zCG5LyHDLHwfTLBKhkEHULYq7ai6zU3JAIQnFYVyOfVOZuimOVZDwN/qxNsJYZr4lbdvVSVuRfIfUl1+VYxksAjeSX14X4M7aQK9LsU1DfSalJQaEnk0Z5Y=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(10070799003)(18002099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Cls39FtIahocJNR86jqg5uYG4lSf31Q9db6rIRGHUCSzXG/fzi++TGqBN0z9?=
 =?us-ascii?Q?sp3pk1l7+Gy7LO1kPTMJtpuaZoWS1EOmtWX7tBlAE5GvqK0+oxnIl57jiK/N?=
 =?us-ascii?Q?X0ZYgH0Tn1v7dLR78cRSNp3+iDv5W2UIM71W97VuqzKhlgIdxfvXodhQk4JA?=
 =?us-ascii?Q?Ay32n4Y/mzrhC+HTJnL05jie3vT9FzVPyyfUkAAw02UI11UiW2cxk/GgGdJO?=
 =?us-ascii?Q?SiTGZZ/SQamKwdZTTZkim0Fbxs3dHrvzvZcLJnYGczxsz105t0JkHX6usZAL?=
 =?us-ascii?Q?JviaCcE0tTr0qsEQPPJvsxsNrj6MvZIgwZczGq+QDLUrswtSVNOpi88JSin0?=
 =?us-ascii?Q?3d/QbIZ8dOOPP4OgKuSSiIWgLVDsBhmVR9E00AOHPaZQp9GZlqcON3lVG0Ey?=
 =?us-ascii?Q?dWmQ/PpHqwkypPZo6qyTRugTzuR3YWW4zSDjKABWpLvd/q21Db5V3vyRI6QN?=
 =?us-ascii?Q?n53aP0vUW9EwPup1pbxxQtwDQLgTo00bBFp0Je47k99yGZ3oIvG4NtAxzz8w?=
 =?us-ascii?Q?OEviV2m+VtEm+GbzoK+Dc+WXQwDsmA+D+MMsDNeqhMZ50zbEwR6GmYvRKNh4?=
 =?us-ascii?Q?DHfoKZmPk8j+Y9OhfbQGmeJYAPV13DWOdq5mTvFH/SKjeixxaRRvuvoTcoMw?=
 =?us-ascii?Q?/j4sYjS2eWWC/NRuFS23gI4E7d3WM6xXKNxyfrImG/RTbh1TdIMmql+YWwnh?=
 =?us-ascii?Q?kRSKkny6ttxfcIDvs8igUwgqq02p0hnUMQ7uzld4B/U/Yjm5LQVNP9a6snt+?=
 =?us-ascii?Q?5iUiUQeZF+fXr/WaZBRVJlzfJjOytNqp1xgY2cYZjDC87UfsDWa+QtxjnwFd?=
 =?us-ascii?Q?ric/vwoVF1IilLVXNuFRIF55g4ElkKeaQktpQ+FS2ABA3o0imvXRbWeQxS7q?=
 =?us-ascii?Q?75FwKgwspcXhNiYoKV4a/e9mi6LZj9DwjhcplvdKLmT+XGtmr9aqZdjSi3XZ?=
 =?us-ascii?Q?MfIapJa1yAVwq/7akFD7oPTI9qphK848iBTzyfv5de6qOtkud2lIeAwE0fqy?=
 =?us-ascii?Q?F67KalYNKU40pcZAC4VzFYFV/LQwUmksVQ2h8eC4KLpjOrpzXBEpN5mPiI0i?=
 =?us-ascii?Q?77h2ZsJsERoUR6hzyx2u2OynmsWR1K0xugDYVIOj/m0eBLx1y7glfRGQLq5r?=
 =?us-ascii?Q?gFqlQBLzaQay3JawmZbsOq93XQ7VoJ1TzbJW51kXECYZofka5YiAigRPsBWW?=
 =?us-ascii?Q?Y+Mzx66UcHzPv0avgfeByZ9D7RS5wNxUw/EzSlowODuSeyh/+ariRJs5VPyZ?=
 =?us-ascii?Q?T1rxZQpsXWgQMf27uIrrT3XJC0TgMM0qHaV0N8aVcHezp67JNA1f2aWqxRES?=
 =?us-ascii?Q?9R2kPHLXK3lS4mwPuJkYI7B8MrX4z3eNYdsn7Z4uWKZvVKX1ugZ8p7s9SF3J?=
 =?us-ascii?Q?gDfIn9AVWvd1JcmvQ82ySRjN0ESPxKzCgHajpZeQ9bviJZYighyIo1shmg3d?=
 =?us-ascii?Q?64SdEGpbu/nXrZOpSJG2N4aJkkz1xqQIA35+B4urpzgXfmJt2p4JTS9foXDp?=
 =?us-ascii?Q?2sBoH+yMj25yhOUZo09JEvRHhPgLYwVgwZqbQ4D2MkQvoPXLy8m2PA9DwACh?=
 =?us-ascii?Q?ksUNrGy6bWCI8se32WwdPlourTJ5lDNKMJuVnqOYINGOEYoVmBv/79lBTZCw?=
 =?us-ascii?Q?Bwaau72ukW+L4Wm581d6lDqzLbkkCIBSpb0PBB40amoiBJqyaYai2x0zJQqP?=
 =?us-ascii?Q?yk0vSaq4EwWjeJgHz3v2Objq8m36wYp3OsueFC67jEo3TAJbQuv+T8EtUGpG?=
 =?us-ascii?Q?UyH0OkfDEpvJ6sFXnNeFVlEl4n7Zj/iRX3ADlZ3oB+tJ9CdaG3bl?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c73f462-cc46-40c1-fa57-08defc2bab56
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 06:49:22.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kztkpe0bKV7ntn+coqNNk8pFMKlLx4izg/a9zwBwjCim342tXldWQliF3ndkb9i89kF/9R1YSiendw6vUiqf6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB3805

Hi,

ntb_netdev may be used on embedded systems, where CPU resources are
often limited. L4 checksum calculation can therefore become a bottleneck
even when traffic stays within a trusted PCIe fabric.

This small series makes it possible to carry CHECKSUM_PARTIAL state
across the NTB link using opaque per-payload metadata in ntb_transport.
Existing peers continue to use software checksumming. The feature
remains disabled by default and must be enabled explicitly for trusted
links.

Note: the first two fixes came from Sashiko's review of v1. They touch
the same ntb_transport path as the metadata patch, so keeping them here
avoids a cross-tree dependency. With review from the NTB side, I hope
the whole series can go through net-next.

Best regards,
Koichiro
---
Changes in v2:
  - Reset peer checksum capability on every link event (Sashiko)
  - Add prerequisite fixes for RX ordering and shared field endianness
    (Sashiko)

v1: https://lore.kernel.org/r/20260814032913.3558500-1-den@valinux.co.jp/

Koichiro Den (4):
  NTB: ntb_transport: Order RX descriptor reads after completion
  NTB: ntb_transport: Use little-endian shared fields
  NTB: ntb_transport: Add per-payload client metadata
  net: ntb_netdev: Preserve CHECKSUM_PARTIAL across NTB

 drivers/net/ntb_netdev.c      | 77 +++++++++++++++++++++++++++++++++--
 drivers/ntb/ntb_transport.c   | 73 +++++++++++++++++++++------------
 include/linux/ntb_transport.h |  6 ++-
 3 files changed, 123 insertions(+), 33 deletions(-)

base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
-- 
2.51.0

