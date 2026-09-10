Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0899D395254
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013331; cv=fail; b=HYP8OXcwb7xwhhK30jgTovTESKOAKHNkte2CKHMrwFSSvc7eqW2Evvm+848Mm/bJoNXxYQoOzUAWYZXEUZn7+Y+tsDA+WD5I/ZxXcxgIemfq2vNaxTo5+iNthBFrhS8FEPWP8tzX0riwoUyCn2Ofv2EOmLPvVX+PNuAGjdkRRTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013331; c=relaxed/simple;
	bh=qDLMKC2AQkYkauqJetbwTuw6sc5Y6wruGuBv8ok8E8c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=dJouHfCbLpTlYiFkSumnk6c7c5AL62xXSaqihp0bfCfNO65TBvssHFgYPmzdHFWll9bBTE+hD0M2zAiiNkboZccAxkmblh2BJMrcsV+oXkIg7ooPHkaeyPGg5h1Qn3YHva4VefE+Z82CFGDgtFb/7VatI+WhUja4MP2sKODn0LE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=c8JPPqL/; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="c8JPPqL/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U1Cy4Z+4i7sYc/6qF13NCz4NAol+qPDzYIIeN3szLBYjtjrZjGvbG19j40w3yOTCx9t8m399Pi+NwDaVV9YOwcg1loiIcC8NHOIHSdF+LNMTo08ChIW0y9/X+uzWHZVJZXsfuOuBAMh7TD+GBYR5hmSwlJHLvwQ4VgN3Fykv8BZ+wE5WhruuQgM9OqAkdVq8HUZExGpq44L91J/SJfo6tRAML0d3CEQ86+Wb5rbgutgd6//kyouZuV7PwnTjQMfUjQreWZRCOMq0qQI3sJozD5YmcysNiwDx5MAHb0tVFlKKpnWWd0GHV2qJIqcW9cjAUDE+l8FbD4jfwOo0Ro6GYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JA3GPqoDscpdgKmTiyJGVFN+YLUZSIcu52F83+6/Hs=;
 b=ovv0nw0h4c+BRRA5DbGo+T6R9T2F/S4ZEM3eP3DHdKf9ZrDgKkx6E0uMKnhZemC2rSvcyPS0mM/dpHIEFAAh3sauMh+Ic1Mk6rlZaUQlyeARyn7XZCw/pFjfosFmQF3xYb63SqcdFQg6/T3IT8MY04SzZh4P1AG1NbMWTjutY7uHKwGuEPatCHOn/s6M+3QbNC55gvglu39/Y4czxQmb9kwlcVh60OG6R1E3OlTBN4fOiguF9El07NK8qCKFVG/0QnD7ba09TyWeClMB0rmwIsQ2r6gyDm2lyLwlTAh9HIAXgojz6/9i0X7yJlq7keoBaDq97hzCPEfKC+hSCXf1Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JA3GPqoDscpdgKmTiyJGVFN+YLUZSIcu52F83+6/Hs=;
 b=c8JPPqL//H85Oi5skiZkzrb5CCmms41WlTqnSfnZY9kv8EWBgR1hnzQ0RLlU+aruu8CWvhUaU2/8VGnclmxV/h5/vku2Wq2A6qEm1Esrb9Iottfj8W3LeGjo+JId9qHZYjbqlT4kFiNXGNqdO+0qOcMBSAalZ1P1tUQINRV0S1k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:41 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:41 +0000
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
Subject: [PATCH v2 00/14] NTB: ntb_transport: Miscellaneous fixes
Date: Thu, 10 Sep 2026 13:08:22 +0900
Message-ID: <20260910040836.3792333-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0198.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:385::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: c1de203b-1e8a-4de4-d615-08df0ef132d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	XFUlnQS/S5+xx2CxGGWwRUmJNmyr/YabW1QZoHeeai2zEo/iW0UW/mmaMIzwHnt5tDirtlQq+dYnXYxYPwMd4V/2ODneiR4iXjySzgmp1ATEqDlcjy6I37wCHXFjis53SBD7sa4LW/90cYgdX2Ihcpeutg3vUGNBXZEpb+7VhLf6Rmq9Ig799kp/SbgTQG1OzgQAQ2sIEC6MzgCIcx+Dz9j7gAl5/nGHa5ZGkVgQ4e3U6zyPEss4BiouVAck/Z3U+TCh3XbCzlMUdnyOMpfg9JZWr5w6QjJDPBx/ITb7hMhFAbG4kdnGLNEHuPn317I2ZwscoGjOjoN4gugPBFGXTJMimxUB/UQP8ymFxtpP3dS1sTRGwcWU3G9P8MJKkC85qv8rusdwRQ8l1Jc4WiCRt4yOJ+DK0T5P9Ft5Mnee7ebAhaasdxyvVEfJrgzPo++vpyiwdll6cCpHZfhFUeo8nwwyLwZ/Kz8R/Ih+Kd2aSIet4kQZ+oU1+Hxahi5YhEyNMtimm7E6aww95QQ3jUmqz9oW9QIDEksOQFzqmUMFd4p8lMgg8ZOQwxjLw3rgb0s/EJrWEQfihfETmr8u4tXNTKP+5f/N0hvYnmmm/vfxneM6qK58gQ/EQU84TRH9tJK8
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LgnoFliyLmI+3yyr/sjR6imVmqeyao7gpNPblUvWM8XI1vJ/deE7+KmReYKz?=
 =?us-ascii?Q?lZO4xQD3qNh6O/ow9Ix/hcLuN7C8n1j6X1J39LIgvtBI7Ce0lVtIc6DQh9Yc?=
 =?us-ascii?Q?JyvrmDspYKS9FM/pny8OIBNwvM2GIXGgXnFD4KticXVX40y5aNGj2UewfLmJ?=
 =?us-ascii?Q?AuTa9yFVm3FPUIQ/e+bH2mY0iqWDll9Mmtkdu2LIGhT0VKy5vBw/xfMG/XQh?=
 =?us-ascii?Q?UKMzH5Z7SMyDABYJywu+MdLUbowtui2PEy9Ru03wy3aZARlQpVzt2ojPAzDZ?=
 =?us-ascii?Q?Mb3FNkwlUsnjJfGd4cbu3awZSKZz8ZQB4tGw4v6iXaq05d+6oWBE6gERaifP?=
 =?us-ascii?Q?yCVyEz1ZGNEzs2tcgM7VtlW0GOutoe6aCgqETl2mYo/dhj9xoS3S6uCSSn30?=
 =?us-ascii?Q?UvOh5E49f+yCweH8rJsP9WX6H/tl+1PLaobd+nc1mMHPUNP7Epw9h9Ouwa7U?=
 =?us-ascii?Q?KNZV5eAtPwsoP9WL9lDfxxVsMU4iT1q/3ougAliqlgEwwDBU8itSaIyBiCOq?=
 =?us-ascii?Q?VMK30x8IdokPM3dW12JwtcRrWvDxPy4YWi8Wn/u+EpiSDzs01CX+SgoJXEfF?=
 =?us-ascii?Q?sitKI5cs0HlZ6Cu//KtJlgc2ifYZfbJSXXxF+sZcj8tvslcDG3HmsxeMLQ/e?=
 =?us-ascii?Q?gkbvg2Npz4js1hxaDRBAd7fPqBu31QGR04DVrHrDc/R3gYhapLf4+SoOQg5z?=
 =?us-ascii?Q?DQFw+J4tqj7R7Qqz7C1x242rmJj1gSJFg030fEp5MoouqFoNK4Ysm+ySXIx+?=
 =?us-ascii?Q?qz3T2bJFW8/kPQ5jRE+YHnhS6+7sILfKze4lFqiYv/rs4abD5UPwVs+RmOOY?=
 =?us-ascii?Q?nrCUMC6QTKlZd4VANbIrjhfjf9UJkqGWvjwZ+9bCYLUAuYd1NslehuKUwqhM?=
 =?us-ascii?Q?lBQH6aPemJwPk2sOkqX8zFi2m/Ornl0lOpUq+9B4nzxP3AHimczSCrmPyG8t?=
 =?us-ascii?Q?52JZUi/vcIWulXe+zrKDi4QNhrfQ52AR8DMebe6M9/D4K5c+YR4kdL+0BnZU?=
 =?us-ascii?Q?GR5PVTfkntXbNu3uWRYEa6klgfb+KjoGmvkX0OCGFlUhTNEcutxitnq6nqlK?=
 =?us-ascii?Q?mC1frf0t0Ah0UdWY6U6OeT7ChliqmTVxV23SgGviacN4yiCOOqtJpRPch6/Y?=
 =?us-ascii?Q?Df6ZhUAVUsXAUDDXca2RQejnul+vCHZtkpFfi/JuwopQ1ij5SttoEWGtnLDN?=
 =?us-ascii?Q?7cFMCZ0RGc6FCgxCIt0lzXnvB/t5USfIoTmPdcg8K6J3IIXp7g0ED5MxKVlZ?=
 =?us-ascii?Q?u7FmAxS4/ZTvFut53j14QWeuNsQ3ALs0VUw2XoYJkfnCOwnsNBACC7KQF63X?=
 =?us-ascii?Q?Ek0xKwA+fWDMOibDVnNbgVbX8b9q4dHGrXnA0dWj1MYWeZrA9vdifFoWCEWY?=
 =?us-ascii?Q?KE81JH7zXypoXFwBHUqxwNSjCxsaknzs7gu1cbZ7hKCrlNbqhWQ1g2jaxL1Q?=
 =?us-ascii?Q?tIyUcYWBCcunElrsA2TmfJUtW6+PtaIVx3ymKob1GfiErju6ysGYbxifcR9v?=
 =?us-ascii?Q?/zCRQBwxpVkIFPVqFwc7nWe3LpYk7EBpkbYRHRva0Ky0rGgPLvpLFHeF5tcW?=
 =?us-ascii?Q?8BFFHAjsDXd0x/IoPRyVpwPwvlK0HwHBswnJaRodFnTmlytvkmE0/xiJ+iMl?=
 =?us-ascii?Q?GJhaAexzymeSmZJB3ZEyxPg/RHxM8GXzeF1m/v+Ymfkt88LwmLBnZpuo0JII?=
 =?us-ascii?Q?05hP3WIhKq4LhQv0JpHRWVZvVcZf6rf8t+6QobiEPgACokorkkVVZCrCLZRo?=
 =?us-ascii?Q?AaYp55RqI++7UAdzGvT5O9nBeHSQ5Yen94VuXthNHR5pCFbUhdSJ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c1de203b-1e8a-4de4-d615-08df0ef132d4
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:41.3911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJhr7Ldd4mH7J4PCYRfAACh66OSh0Q8mbcIVaYsfiZdg6gsi8KMgDwGhwIRnXUKMUhzEBddP957uHyeDhHcVgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

Hi,

This series attempts to fix miscellaneous issues in ntb_transport. Some
of these were split from the direct TX/RX series v1 [1], as they stand
on their own. Based on v7.3-rc2.

Dave, could you please review this series and ack if it looks good to
you?

[1] https://lore.kernel.org/r/20260810165136.2292436-1-den@valinux.co.jp/
    (The v2 of [1] will be based off of this series to avoid conflicts.)

Best regards,
Koichiro
---
Changes in v2:
  - Address Sashiko feedback, including regressions introduced by v1,
    with new patches 5 and 10.
    Note that to keep the series manageable, this revision does not
    attempt to fix all the reported pre-existing issues.
  - Add a fix for client removal ordering (patch 14).
  - Reorder patches, moving v1 patch 4 after the fixes it depends on.
  - Add missing Cc: stable@vger.kernel.org.

v1: https://lore.kernel.org/r/20260907142429.951930-1-den@valinux.co.jp/


Koichiro Den (14):
  NTB: ntb_transport: Remove the device debugfs directory
  NTB: ntb_transport: Start TX offload thread after queue setup
  NTB: ntb_transport: Avoid deadlock when cancelling link work
  NTB: ntb_transport: Publish link state after QP setup
  NTB: ntb_transport: Avoid losing QP link-up requests
  NTB: ntb_transport: Clear link state before QP cleanup
  NTB: ntb_transport: Stop QP work before freeing a queue
  NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
  NTB: ntb_transport: Drain RX tasklets during link cleanup
  NTB: ntb_transport: Wait for RX completions before resetting a QP
  NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
  NTB: ntb_transport: Clear QP pointers when freeing an MW
  NTB: ntb_transport: Abort link setup on QP MW allocation failure
  NTB: ntb_transport: Remove clients before freeing transport resources

 drivers/ntb/ntb_transport.c | 232 +++++++++++++++++++++++++-----------
 1 file changed, 163 insertions(+), 69 deletions(-)

base-commit: df2908090cda368b01ff43709f51890076c56157
-- 
2.51.0

