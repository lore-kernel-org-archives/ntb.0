Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021142.outbound.protection.outlook.com [40.107.74.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66E942FCC4
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.142
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380718; cv=fail; b=bUZoKSDGCO8+4AgdLzpvCMyZwAxdjfoM98jYu1LisqCHF25FGEaIVq1poB2O6N0w/L0UyrAuXqMny0oXY7LRn9CohcccClLqcV2S5mpb6WMP1XdtDGkqsg2MJbr4Huf1dq2KkQdK9XAPZIc6NTawE2gWs9ASCdW3N8/y/oLA+aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380718; c=relaxed/simple;
	bh=q7uX/m3myFGxS/H23kr2wBfh2VMscpI5qjurg8REVac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sgd0ocpiTtRmiYkW8Jo7uZMCjX8SQ1+7Ajtf/NM0NaSo5DEy94hSoCkyOXvmUvOR3sZ/x8j2Bfovv4N7d742f1Y4Avv/FCeAawDFgn0VS4wH2rN9sxYMnXdngN+DTtc7ThCKZ+ZqQsPX7n873f1/YwAzs3jgWl5wAj6ori3lJ8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=h5q0CfPt; arc=fail smtp.client-ip=40.107.74.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="h5q0CfPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrCO6ROYJQ6E1YDtk79AHlhteAq3wa5dHkFmNpc6QbmqOdS4GCNB1qKAJfcQTYzqCpFnxJYX9eznlZ47Y5N0AzfPIUurHnWDGHBxRXAChJ9i8ATAx97myUvruCX5XfisTJQZmwABpOREdeofZgouh1w+6Ca6rTMsQZO6SdgoSbK4H3Bq6XE1zKWTIIlkj2OajSOOSFl/Y1A6MHl4UrMm3thqvR1YOJDYfcnKcoeLFq8kMYk7OFtUbt8Z07jBQjPaN/uLweNZ4aX+DKdso4LiuFKHFLXbSnVJQ/aBjZFIYc6oLU2D1RuCZciIax+4lk8nv8iPIVHT7cvhVLoazIV5lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9JZWEmk61sgDmvje2yFNsZLZtKahNJRq0jpo+Wl6w2E=;
 b=E8lHCYWBy3L6ieSLEaS5BIyOjvyexv7tGon2nzWGdwo6F9aso6NyfspZVVLiQ2xvLbmNVpwrtIkxeXielZ7TIvjMTJjDOiB1r2gHRaX/cp11P8J7Kyi64oZV4prPCgKe6/bs2wNwWDxDmwXRWgKhWldvW7E8WVSkld8gxwQJVGE4YA4mBaDOxDlKqjNmNmSrUhrZpTj+mLJ8ZWxk0ixFmiT5Tmrlg+rlDZnSyetFmWwZPmOtRgQwiclKeebLhUYmvyznRXAznnVZB88b1n911gCdeanLaLC6gyP6en1d3+gbQ6Hd33JUJAZNXQf7hn9IfmkQZyH1jZCfO1W0A12E7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9JZWEmk61sgDmvje2yFNsZLZtKahNJRq0jpo+Wl6w2E=;
 b=h5q0CfPthbrBvvXmu1C+Ekj9oIEn2V19+p4Tuk4C4enlb0vkS2uWMj+4hfoMEW3b2W5etjo/J+DZfgLhvxVD+rwoG3382EyKblGVZ7JLedVaqBPXWUkFM5EEYaxTWMKNY8aLWfaN/IT94F0237B2K/0SOYK9lQ7y9zljFI6UF2Q=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:48 +0000
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
Subject: [PATCH 06/16] NTB: ntb_transport: Define direct-DMA shared state
Date: Tue, 11 Aug 2026 01:51:25 +0900
Message-ID: <20260810165136.2292436-7-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0045.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: 177a1042-24df-4752-0603-08def6ffab5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|6133799003|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	0RZgdRkKCL5rLoVZ5sOgmjpDNTx7AL3/FpyjgW5h2O9fqoSLxgPT7G6z6EocBSe9VH9SNLDGZ626BsdCsHZwIabgWw7PU9DSGaJfPKKB9jHRtqnMddR1ay3MbJ0dZ0X6sOuZxx0In79sZPNldBgyZqybhVr08mPDa9t1OLWJRnKnTamkFz57Lzsa4wq2V1qT2eICixrnjTUJwFi3P1bTZptNpbvntADjDLXc2k58WpQYFLOP1vB+mKZlFF7/ySB0F+6NlexSseslgbAFKor4kSLGy7YTsUZAWN71Bjr4fxTTESH7JHu01DfZyZA1Bukvhr69w2oLXq26yG28PmQAP1ifu9m6p0m8Hd11t2EyZ632ZdZNm5lucam2gw0bxHKSkf71nkkxkmD+ZUdBB9l6OHXT1FVjVjXJgALH/175oKBo0cbjgd2xcDhVudmmrWwwJqd4YrcnlgoHTuBJLigsxGbISn/lei2MOOzfTMEVxdOv9lbX7lCVI6RmilQhLgGY4dPJ3DSvoclBLwpPorcmQg4fD6TWLtMSd72JfyAIRxgzK43s34Mh2u7zokw7r5wjyJNjP3KfSbvCT8jR273+Yk/QG+szoxImuzLcsd/1ygxbNExjGIup7wrl3Y0dbcpZrQ7ECtyIJUOVkcQD//yRriD2FTCTd0mjY2+NejrHyxE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(6133799003)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LUkMXDJAQuoCgRip8AaPkiVlFFE8vFVUmh6i1e9Izh7nrcS2Y9fw+oa+jSHa?=
 =?us-ascii?Q?1CDUrscNpGmFmmFccyZvKdlDZKUT8JcquOwH1ZPFZ4rk6YruAVHCbsH8+Kbj?=
 =?us-ascii?Q?KJfozlRgmTPKE/GIzrQ2xZKIzl8G9HLyZQ5Wd7zOp1BJSjriaZwkDgqwEJ1N?=
 =?us-ascii?Q?cldjDIgZRwRIryvJl9sSa3VBIeSyHPLPGF1cDZ+nPABiSTASlsWaiYiTi0DZ?=
 =?us-ascii?Q?j++wZVg7P6y1CAvSA8Y5oH+jaTPDRwVS1eZvrw7NQ7GTT3579QhKL9tojYh3?=
 =?us-ascii?Q?McOrtMuyns/ycW8zqnZ6T8RbrZsJyrtX49WtHFq/7EQmR+O/zQxIqVO1J55P?=
 =?us-ascii?Q?gOuT4xNXL5KOvwAZjrPUqmr1F4R5OuThXt9oYtUBtERo8AYq7Hh+c7XI8fUT?=
 =?us-ascii?Q?AhETFXLpWa8OstU90PNICZz76p1xVCtI7FjB4N3MlmbbFzh5C67gMjzLBrV/?=
 =?us-ascii?Q?TL77G8rustGi9w9IhSPzn5wR9e4hCblEhRpyVH8tyAFeQJUwgwj2qRDGQ0S4?=
 =?us-ascii?Q?PIsHmjfJpF/EWZxRBbmyXYG8bsO/VfPSNNxWJ5Aq4QIbFZEsMjdKvKM8WA4Y?=
 =?us-ascii?Q?vHSBnmFCvhoWAalRLWmCCj4ZdFD+9Lfb57jw0/YdTvcagAI4PZdO67bktTQS?=
 =?us-ascii?Q?QyNFeZ2tRtWaZOfLcndET1XdUuNxg6wmwTrnEkfF9PPrFkxs6ov26C6gtljZ?=
 =?us-ascii?Q?ygO22LZlrcbSDJacHcUmpRTRGrzsRl37Pj4w31X+qrNe9ouZEkiBo2Q5x2Jb?=
 =?us-ascii?Q?Hm2f8RI+5KHoyxjW36fz2QAjXsjf6B3HOFmnmdlHKMV3BkUnko6+auxBzMjD?=
 =?us-ascii?Q?GMd1C+CiPnOQsp2lCx2UnZamoSK5A6HdTSinFo6tCa4Kf+045UQCi0Et+mwq?=
 =?us-ascii?Q?d1+eZ38ew4iM4fQbJtbtIdN8/8q2QhoWZ4TLJd5QG7uogn2bdZmC0HqbBrLB?=
 =?us-ascii?Q?FaDO9J69fzEwksVBRE/nBsNFC5lqo5kTqjlReHZRdiC8t6n+AYO/HGagamx2?=
 =?us-ascii?Q?8Pf4vI0zX3rjBcyDDI0jCtPeU9Rz9Tjv/EcevJa72NxF100YJHSvVXO9Oeq8?=
 =?us-ascii?Q?ITIEEbSTO8J7q6nDJJ5VUe91jREJzyhjwKYbbAjqaMS4EibaOglUBl/SZwQy?=
 =?us-ascii?Q?REH1ggJl1Mysxu2f17xT4EK95V1uf+DemU740SFhSFGBU3cQVOTIEkvLCrjZ?=
 =?us-ascii?Q?Y4Z/Iudtux8ToR+JRGMyEUmbd2En8GesX7Nu3whk1wS3jWfi5LorxoOQGT7V?=
 =?us-ascii?Q?1wFFoidAs6SYimHvLW3nZ00uoMqDES8pieim7ESDvNyHJVLlJVTknc6W7Yt9?=
 =?us-ascii?Q?IkxnClZy5LwlIA5lHOhPfSx15hCdKPJjg5AyXw2RSeCyoAoDlsKGS6If4tIB?=
 =?us-ascii?Q?+ftAcmtKbQBSMAkTFEGZZSpmvScvR/jjuDRbesiSnElWOOZruj2EpDKtQ2RI?=
 =?us-ascii?Q?gwMRBgmIPMGn09tld+uy975IWnfyqRyCZ7SAOHZu0Tz+W3KKr0wszRahYfqC?=
 =?us-ascii?Q?Fu/g9du0q3jYMmIpEvvyPTosWOGhFXsn2p4t72YVJiMZGbK6fi4v/wQ50Urn?=
 =?us-ascii?Q?qtv0zpM/LkZy9FAoIf4tzUbdPekwzd1NB9KWB2XopWtu5LAwPxsePERABuU+?=
 =?us-ascii?Q?gwo7F7jDqxP5o4SjQG4VEz0itzxFdPnxOg9M7RXjCKxCsiV1wvI6tY3pOw3w?=
 =?us-ascii?Q?zB74dhDV2TBOQKAWWki+P8jpvz/4uEjq+4HrbVSgbSRbDzVflaRlvcwY86y0?=
 =?us-ascii?Q?HLT8hA/r8Aiv2dmxkLz76HB76bbuHSjgHYGNGFydiF0UhUvYN85H?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 177a1042-24df-4752-0603-08def6ffab5d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:48.5822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: apDDSAXqH3deCmd/yhTsXuDMb/cyMpfct3s7gO9rKQCQSD1iaOClP3WOQwdYtin/3N9JCLS4g1ITJ2NJjqsVWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

Define the per-QP shared layout for session state, RX buffer
publications, completion reporting, and teardown boundaries.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 463ee6f17fcb..44957c11d1c8 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -55,6 +55,7 @@
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/kthread.h>
+#include <linux/limits.h>
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/slab.h>
@@ -264,6 +265,61 @@ enum {
 	LINK_DOWN_FLAG = BIT(1),
 };
 
+/* RX publications are pushed into the sender's local copy. */
+struct ntb_direct_pub {
+	u32 addr_lo;
+	u32 addr_hi;
+	u32 len;
+};
+
+/* During a session, the peer writes this area and the local CPU reads it. */
+struct ntb_direct_shared {
+	/* Peer session ID and the peer's ack of the local session. */
+	u32 session;
+	u32 session_ack;
+
+	/*
+	 * Tearing down a direct-DMA session must keep RX mappings valid until
+	 * completions for all in-flight transfers have been consumed. Each peer
+	 * publishes its final issued TX boundary, followed by a session-tagged
+	 * quiesce marker, using CPU MMIO writes to the peer's memory window.
+	 * The marker may arrive before earlier DMA writes because the CPU and
+	 * DMA paths may use different PCIe ordering domains. Quiesce is
+	 * therefore acknowledged only after completions through the published
+	 * boundary have been consumed:
+	 * - quiesce_issue: exclusive boundary of the peer's issued TX work that
+	 *                  local RX must consume.
+	 * - quiesce: local session ID written by the peer after quiesce_issue,
+	 *            validating that boundary for the current session.
+	 * - quiesce_ack: local session ID confirming that the peer consumed
+	 *                local TX through its final boundary.
+	 */
+	u32 quiesce_issue;
+	u32 quiesce;
+	u32 quiesce_ack;
+
+	/* Base address of the peer's RX completion array. */
+	u32 cpl_addr_lo;
+	u32 cpl_addr_hi;
+
+	/* Exclusive producer boundary for the peer RX publications below. */
+	u32 pub_head;
+
+	/* Peer RX buffer publications in ring order. */
+	struct ntb_direct_pub pub[];
+};
+
+/* Bound per-QP completion arrays and software queue allocations. */
+#define NTB_DIRECT_MAX_RING_ENTRIES	4096
+
+/* Zero is pending, U32_MAX is an error, and other values are lengths. */
+#define NTB_DIRECT_CPL_ERROR		U32_MAX
+
+static inline size_t ntb_direct_shared_size(unsigned int entries)
+{
+	return struct_size_t(struct ntb_direct_shared, pub, entries);
+}
+
 struct ntb_payload_header {
 	unsigned int ver;
 	unsigned int len;
-- 
2.51.0

