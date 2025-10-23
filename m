Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011036.outbound.protection.outlook.com [52.101.125.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0D92D877E
	for <ntb@lists.linux.dev>; Thu, 23 Oct 2025 07:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204076; cv=fail; b=QfRQMVRLtjWMKg506MykUbqYCxuIsmo27YOPunoPEbrPrSBOVRPfBn/VLHWl9bDZX1cvUHeGJoCmGcxAoW7DZMMC1s1SrpHmpOUPQwE8TY45D43fYcueE+O9qkQAZK/DswU2gi9CdMo39x2T6/i3YE91zQN7Ny4u8V4m3h8zboc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204076; c=relaxed/simple;
	bh=iMsTDBDNrXUufZDtH3Dr1IIWmF4kTeLO4QIDmx8Uq9w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=eDWdRfXZZo+sjh31mM3lqAwXMH3SRWoarojDd0WJ1Yxg+NLd1AXZfW2E8ta6SltJOowLDxujOGfvc03say1ehRU69ZlUgOXKjD1RhtIO63/BBTQqpxB/3AhOAc+E4bTKwQu6D81hQcIX5Is9XaBQtdATRf7XB0gIRnHLFZxaoeI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UTReBJNP; arc=fail smtp.client-ip=52.101.125.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UTReBJNP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFRqBQCot93lrSBOtA12JPZ6sd7RJLT19TUqvyuZCEq0bZpZdwbZrfsVJxYJY+SBuQWUx2hJwuicpWKekDnFtHzwussi7QcRSGTehoiOkq3CfI4VJTLtpPUrfsEs0kfTNChRqWdBZMefu0kwFBdbMOK2hKFwNwd39WrRjh9kON9ECsyrpOmXR5kOU3n1q/wdsMa7O8I8QaUEtZkQrg5OL4yqJ3cAxCLqHkmOz4/TdjkQM2TxvfPwrebNzP4/W+4rdCZO8Xdu4ml858KcVaqGUWDsOM5rqmMG5KJDslCYUfdy0NG9qtjQbXmrVqqRwAFkIYEhLATAPc922ImKdQAIxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmvKw3r9LqDHXqMz9ZFlQjSHiVLdMppls/Q64h3Ug6E=;
 b=N29hR9Bjay1cDKkz1bDy6sCpIFVbDKphNnJaLxlHnMVg3GiVfkL0HFiLDJ/f9UvBsdux4PLIAgCL2Cist4GW84snQNrVg2xa3V5eLY8aJxr/MV/vUEKrMLxR57P1BIGczIX/oMXB64zIPwx5WitS/Mg83jcgWZTkAc2GcOhJgF2ykI15HB21PGm+3zMsRFypQUKKbXwGh/h6hybJ08/vnAlDLusJZwjuHRo+RU1Fd7xLPhAo6TDuVA+fR85Mk/zwqaL2VEdnxb8gMIBgfIxUbKFRUKJ+ie+W/KUH1sKHqHqvqnjNHnLQ4gFqzof5xG29Ny2o0CI8E7jVr/9aFNLJJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmvKw3r9LqDHXqMz9ZFlQjSHiVLdMppls/Q64h3Ug6E=;
 b=UTReBJNP1dAPdXAaiCuV9KCa7Megd9qIqAG0cIDc+uRuyE7cLqkH9mc1aViT/niZp4MAvD3yaAK3CU8LF85ovEQM2OFUAtA3gS9EGa1gKrygc0yD9P0wCYWj9fxYdyDsnmlqlmxvgCe4gDExXQf5KEgVA4vsV29o7XuwjFeC4mk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:21:10 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:21:10 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 0/2] Add 'tx_memcpy_offload' option to ntb_transport
Date: Thu, 23 Oct 2025 16:21:03 +0900
Message-ID: <20251023072105.901707-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0181.jpnprd01.prod.outlook.com
 (2603:1096:400:2b0::10) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: 77cca4a6-3bd1-4c09-ec51-08de1204bd5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bS2ePQPMigsUx+wv/w/KEZ6WfoygSqq+dnhdxz0NkdpoJDVhgSppMyrX/g5f?=
 =?us-ascii?Q?XFG3zxMStEWDiAn1bEtGZ1NjiR+o6J2VMw/K01M4OVsS0zEr9YiJlq4wxfvw?=
 =?us-ascii?Q?YTHv+u9GL7mJyJgqM2GFLWUSoxbmDF9dB1NpCsLAkK/Q7uJWR7gldYylTwWB?=
 =?us-ascii?Q?Yl2OexEk5HsocYRQ+hxMjJP7JBj7vflveOUbxWHBf3nzfmE16Gj28Yo2qdLU?=
 =?us-ascii?Q?JXQPbzlu1E2oOeP9oRaJFj8lQ2P/GUxlGP9MZEAkb2Aw73fNWLgG4jtwW0Zu?=
 =?us-ascii?Q?1UEWSzpxodpSIF/Chv93bBh1fkiDKd8jSPG6si2RaR14olQxyUM1vlaxEgiv?=
 =?us-ascii?Q?zF5SpfORC0XSWINynfuRdgVDFW1eKdx8/cTJPV3fA69A1njrbjm60ZX1R/qD?=
 =?us-ascii?Q?4kwcHlz1VULBSzdk4IznW1oQIRGF7a/Y9iDvGpx5G36W3JJ52Mc5DC6oBM5u?=
 =?us-ascii?Q?Rfu28hFGeqHJPpIqh30NU6nvC1QtHbDvns2OA9KK33xoq3TJPIpicIR0sZ5y?=
 =?us-ascii?Q?/y1j0OTV2138I6CzC+76GpYvLnqPPhmbssrkonKwkZzRuCDfSFRI58AnKD5B?=
 =?us-ascii?Q?3j5I+ZwKpnCGiRHH52QFXa4iI0Fa7f9ZIlTAzn5TGCPuNs6+tdDLVmQKijPj?=
 =?us-ascii?Q?c8BlC1uRMeLfYiSE2McAZqCGfEtCVDUiRrSP86yUxHMW2JQE65Vsm506yQxN?=
 =?us-ascii?Q?i5BfjGJxy5AJNSsg+YNoxkaLa+3GRzf5qkv9cadS73ew2++PHLzmvY0zQyjF?=
 =?us-ascii?Q?cy1Ura9yjCn/RRu+FZMgwEB4Vk4b/ut29LBxlqV3yiDx+kyCawdHgVC/+6LW?=
 =?us-ascii?Q?n3EhPWqlEKhpwvo4u+MDHVQqA0UeYyDSzz7eQNFZCf+oI8q21c+Rzaoide96?=
 =?us-ascii?Q?y+dDJnLzLT6EM2kmgjASLHQocztPRDz3ZtUzBkh3V70Yz4xSbssdo5BHhI4g?=
 =?us-ascii?Q?yAvRcmjSXl43C5yrwZlfiOiofxH8fG9oW8BNMfv13wF3rSwtLbnIzDCfsRpS?=
 =?us-ascii?Q?rwY3VVYHGHuOLhRE8uCibUwg3OpBOd6pgsYORS3phEFNNsoQ0x4FP119jwpm?=
 =?us-ascii?Q?b2sSnYRUdSjApk6FLg0gMNrouT9t55qgWuK5fUFbWalGjSLzZ2zbp8zW6m/z?=
 =?us-ascii?Q?XXmoRcz3hazhK86MNhpM8ZXDSFbXxDzCqzefGZcIWGpnyzaZigl3e/AhwbmE?=
 =?us-ascii?Q?RHMwSX9IeRxXV+sYj49s4rzIgxAqkxyKR7kSMRy5rl/Z1leaz6TbXW+QTFav?=
 =?us-ascii?Q?M2Z6I2pSG7EGXmql9nkM+BfYhk1Rk41PPx/dxG2lUcTwlucLuINSh3YG9TlZ?=
 =?us-ascii?Q?4lkfv6hQ24Zlv0mHg7x95VnTDS61AwH+8AFdPdLo3YmWo/MiS33agf3E/0kI?=
 =?us-ascii?Q?xDNqCeU6XexI5PEb44ChJNhKbJFG2TKApsvb+/8Yz7BWONvqE51pUymZ1RzK?=
 =?us-ascii?Q?dmHoY9toge7WqQDCpmLW6PP23ArTlIrz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R5YwW1BTe88+2K09ilj9XU13NGAqchCcgoAPxVWls6/H03d4DrAF4Zemjeqf?=
 =?us-ascii?Q?Ev8OqGbsUd0ORbo3T6Q2rrYCaMnxAUlhGB8M5whpsBcf6nptpH59WA39vPJS?=
 =?us-ascii?Q?WC1XQ7/ziK4sCVzVeBGA2XUEe9fU+KCepKQAsUfv2SpccnAUR6M7PvUV8PKQ?=
 =?us-ascii?Q?vQRnOj9+7KN4fyMraDnAIu3BOw/ejdOsRnlmWvovaL0rz+sZUKa3wGI3yAem?=
 =?us-ascii?Q?IZphDEe6KXOyStTRBvIyx8WHdtg80xw31iT+Qtbwzmaj2hPut1KpJDL6RYP7?=
 =?us-ascii?Q?gC57wsuArQeaWvMs0jig5Y3XNNsn4UzrlbHjxDFCNswU//2LrogjZ4JV5EWZ?=
 =?us-ascii?Q?sLyg/0od0Wq/dqxTejfmPhF4AlXdisGGcqnAmQU7CN7+qrlCZYFQguioBHAb?=
 =?us-ascii?Q?jqVeQOsq9nIXd5xWUuQMdVkvW+6B9XEVF2bOSEE3OBKyClUXWIDzy8FAacUp?=
 =?us-ascii?Q?2YhIuaX78zCOdcItOxSVPWehYcDVzyHMEpgR1eo1X3RvmuywZ7UXzqxqjJYk?=
 =?us-ascii?Q?E33/BAy1N1cgO/V+hZmVSxuYu1bEBolIRdIwpsL8RsXR/bbrZMCoLFvab99J?=
 =?us-ascii?Q?Wcrz0/a6IaZ9tc4t3ZL10IfmrYLINZ/H0WzOOiR8ayKHzvQw9boZWFeq5tci?=
 =?us-ascii?Q?BtTJIamfYXt5pCHZCJKtQZT3W0m5hhpRlqTNNF4OM8SlYKkp3HppMQeCk8Pe?=
 =?us-ascii?Q?Laxr+10hhEVhBI7rPr7cwy6Bg8KGK+0/sEi/6pQ8/bhBUv1Nj5fATjTSzPEq?=
 =?us-ascii?Q?PBkLxdfjJscNqXWqWeKiLc93DAQx62+D7lw9B9lGVLKug5yYvyzE/9lXw77e?=
 =?us-ascii?Q?Xzal0KQCLRy1bxUJwJybSgg0ODgo837AJCWd6vvQ29bnAQqZd6Qya9rD8lQC?=
 =?us-ascii?Q?ihEa7lGFE58iYClEq7co6n2PoXvG2in1bzzGitUyEYBztC4Gretk+ff242mq?=
 =?us-ascii?Q?GlEl2UuQ9BCW0yJNJ3gD5gPNeBM3C3/rffC7Q2RlNH1HDTpz1lTkk9/0E6iW?=
 =?us-ascii?Q?uzw7ywtsY1gD9erFGbv3sOnc3a/EYNTtGFZozdgInMRosckoyRmupZ/X0io0?=
 =?us-ascii?Q?eeV9PGzJQY+AfVMAI75nJIRAR7ktl5UcL6s9NMQmWHj3sBe5qlIDJXNzO2cg?=
 =?us-ascii?Q?XMIk/M8sK8g4LowhOd2rPrGVKg5ZAh7oyKGS82Vstpl6PF++FH84ULk5PlCH?=
 =?us-ascii?Q?kZDEgvPIMP3MYQgJyouBaFdVESy37gnBMP89tdsoVnjgelTXrDtBjs8pG3+H?=
 =?us-ascii?Q?eJ8FX5R37HSkIHhKYBnn9FE+p7f+KJlq3A9Sl6CtclNq70rLawroJZXtk0nR?=
 =?us-ascii?Q?HAfLJ4Eg/2/AJa0I+ON78tjbIU3G+WeaviYYtGCxBO4L5Hx4Vcsd2BfDs1TX?=
 =?us-ascii?Q?lGywEjf9vNcp04bqjRN6hn1rTO8k5P83pcWhB2Ibr/59zFNwBXj8wBruhf3y?=
 =?us-ascii?Q?SzqMXQxtQ39PV4oCYyod1UNuxxwaeZcfCwMaYInfkK/mtau07MFor+C0gp5q?=
 =?us-ascii?Q?JHUnlhOefH09KNdvduE+RgWXgP8eDGyr+Ot1eSRTEybjRf1gGONjZb0eM+Ub?=
 =?us-ascii?Q?C+dq9xp8T++MUY74cTfXZ0U/zJTcWnzW4/cRc0BAzTctSRremBSaAsZ6247X?=
 =?us-ascii?Q?VkVC4xEMvPVxK21e4feNAsE=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 77cca4a6-3bd1-4c09-ec51-08de1204bd5f
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:21:10.0773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WjO2XyMHiK/uee9sAHIe5oQiCf4NxjLF8FP/X7Dvvau+NlzDj1CNfzLzE70Q1SQeSaGpyQ9r0LEfl27GfLcL1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

This patch set adds an optional TX CPU memcpy offload path to ntb_transport
and does a small cleanup. The new module parameter:

    tx_memcpy_offload=<bool> (default: N)

When enabled, ntb_transport creates a per-QP kernel thread and schedules TX
memcpy_toio() work onto it.

On some platforms (e.g. Renesas R-Car S4), using a DMA engine in the TX
path does not always improve throughput, and memcpy_toio() becomes the
bottleneck on the CPU. Offloading the memcpy_toio() and the subsequent
descriptor writes to a per-QP kthread can raise the achievable throughput
by keeping the data path hot while letting the worker thread perform the
copy.


Koichiro Den (2):
  NTB: ntb_transport: Remove unused 'retries' field from ntb_queue_entry
  NTB: ntb_transport: Add 'tx_memcpy_offload' module option

 drivers/ntb/ntb_transport.c | 115 ++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 13 deletions(-)

-- 
2.48.1

