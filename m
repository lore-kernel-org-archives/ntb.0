Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011036.outbound.protection.outlook.com [40.107.74.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D232E2F1A
	for <ntb@lists.linux.dev>; Thu, 23 Oct 2025 07:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761204082; cv=fail; b=HhJK0GaYV4BMrm3FTj2U1ff6r+uU53lLb6lG6W/TvEgVHsY9BaZQEbz2DCV3tDp99N/itlnFIa/q7S/tEcxbsVcILUnkCrSrayoMCvnWk2GO/amPhzSILyb774usxSt9NmDl4mUWyiqv9vwqRaeQGE+plSQ26/+pP9Ikqz6MnQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761204082; c=relaxed/simple;
	bh=iInewF/Nn96A9u8toqFdXz3dWKznFWoZrAdzcsdLgpc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Af0TqO4LW6ZTwBGhCxOR6920slH+upZRhHHVDqaN7TnOxem/mVVwTTkIZCRADeDVrPj+avvodGnPb3P7iwCxnzC8yrgs4D4+/zAyvW/3+2cdp0FdR7ZpAFCiJ4cxvi6c2rcZH4uHn8mdYYp/J/4XI478pHKBDvdm1IQ8oBqm1NQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=RQpecUQy; arc=fail smtp.client-ip=40.107.74.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="RQpecUQy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY3/mMTJuAcryPVdHWZlcbjAfSZH4mWtJf1dEdN1xBw34iPfxwFEFH9VSB9CnHFKGyGMzaJbC1g3td05EuJScWYqhYfi4J3hWrh7WerXKpiWvJ0AByCznaa/ART1OLIx/4+QVjquebOJSs9Thyc10lo2mnzIi9L59bSga26j7hfRn0UWk0F/o4Sepm5KqeYVyNntxeH06alZ0Zm2yiQjjfc4TPXVhXpr/Qsv57KGyVqnbRXtHNMtkczDi3SKzjzAEGavYbPSnW48/sE/B+1ZR+TLThGJ9f0OxWLf/6/EwI0dX91pKPT1pyIpJJICbmVXcTJ1zorw56eEeFDOxW7GXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qUCbXhyPzK9Ww9Pxs4mmsyS1S+y8p4UOzwnj9IMV2FU=;
 b=wnj2htDSHCUpA3n6ZAgX52VdJRpPDWyxVyoXeSNJOFjG1F2nbtZ/LigQuowtjyuYZrUWFtAwjiZ6CKun5wMH4BXTcnerUbc3LxjgIEcx4zHoWEHyx5/gkGUwNQ8PRciKYJQD+zPPc3PmvHh3nfg1zAVqaXEt2zf2b6WIoKhb0zCoeJtZstAeJv4c4eAf0600VyuVxVcpwGc7pqedUDb5d9Ptqt+gyxMLIXE2h+7I3+MiRytGgxkrWX5clTwuL8akQKH0rPj34Iwp2PoUc4QvyC/6W1501XNGP8+hCBYDL386vpx/C/W/GidAG9CfRQBkUxtJoMnyAeHdDsJOW9wONw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qUCbXhyPzK9Ww9Pxs4mmsyS1S+y8p4UOzwnj9IMV2FU=;
 b=RQpecUQykuSb4Ab9ynXJ85dypnjZ6fHfODZpmRMt1NIQb8/fAZrvq8HJO3tEEj9uvo85J+JigQtqPsgLUIQ7asPXxfMCy5cPLlO8qfYkf+/+tz6rqt+ZDNuJikVLHnzbye/CwFrEfMHA9WlxoaiMMMGawaht9KxBxDPv6PsnUrY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:10d::7)
 by TYRP286MB4555.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1b0::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 07:21:11 +0000
Received: from OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a]) by OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 ([fe80::80f1:db56:4a11:3f7a%5]) with mapi id 15.20.9253.011; Thu, 23 Oct 2025
 07:21:11 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Subject: [PATCH 1/2] NTB: ntb_transport: Remove unused 'retries' field from ntb_queue_entry
Date: Thu, 23 Oct 2025 16:21:04 +0900
Message-ID: <20251023072105.901707-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251023072105.901707-1-den@valinux.co.jp>
References: <20251023072105.901707-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0095.jpnprd01.prod.outlook.com
 (2603:1096:405:3::35) To OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:10d::7)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: OS3P286MB0979:EE_|TYRP286MB4555:EE_
X-MS-Office365-Filtering-Correlation-Id: c8d7ab18-93f8-48ff-566d-08de1204be08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|10070799003|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xQpvoqSE9D3TLhys2MU45R1MRg6cCUbMo7KaDK8ConcuTcMibIjfP0DZQqHe?=
 =?us-ascii?Q?vyOS0P9zVlsUDmmvdPWxmCroqyYQWH2w3ILn1iLcQnkaf9exdEtxsb1BVeCn?=
 =?us-ascii?Q?fF+DCRurqxTw027q9gkIcReLc+2ISNx+na3nsLRZ3ZHa8N1I5xcVkmjvsmbO?=
 =?us-ascii?Q?Kt/d2yCekq0SOj6osvIH1EjlXL53YPBXwMrrQUxCYA6fjMJkJ2MptEDyJJ4Y?=
 =?us-ascii?Q?4tI2ph4klQltnXr+7b7MoGqLCsvobNdCtwIHd7qpRwKAcQOej4DYDwYJvXMJ?=
 =?us-ascii?Q?JlrLKiB8lzBbAtqLSlP/GlCXjIvApPG4n8kDjsrnWaylYSETI/zbJU81B4Ls?=
 =?us-ascii?Q?2pKqDhIbXmixghcv+U75IxDqB1MH1frUUV1SCWFsoQ7eGc9lrcC7DCMUb+5D?=
 =?us-ascii?Q?oOQXvHFZYWGDUFuJoZVU2QNu6/e/g3u0E8BZMhztBXR7p+H17z7hYQz3V3yK?=
 =?us-ascii?Q?BIVMZIQNOJbTvC/QnY1XrDjnWh4yAIShPp+rm5gqx4NwMJ1iM9SYv6qkn1Mc?=
 =?us-ascii?Q?M4sBQ3K9LeGFDDsvsYb8ou62rlsH5lyMx27hQKtiDWVkR/71C9Uc0HV0JgAW?=
 =?us-ascii?Q?nuqj8C6wRasEF8wtkE/V3Z1wF/7JZwl7CW8v34lUmy6KLhFldlE7EKZSDPWT?=
 =?us-ascii?Q?JkFUzbTY0gBydTsKcOoJqlSQn0UAb+wu2xmuTJsYEHcWl92Xa/IA4uxsFoOW?=
 =?us-ascii?Q?JdN/SxHZ6iyQ/Mu8ScvVz7YZg5CYOG4ZfFJOlvqNMIwd/qic4zJcsCqsim+m?=
 =?us-ascii?Q?jNeDqA5kMxBrXP1GW7vn3KKo3jBhn0XJ9gXF5KAu7EuB1FV0SsLDWFEm9lU5?=
 =?us-ascii?Q?/u8Nobfop6xH0FELPftxhWnTijPy3my7mREmV+cM/Uf41Zcy3bKNQxNEy5P5?=
 =?us-ascii?Q?6GQ6H1vVEVxHCCqCMtY8XxiSCNgdaZckeFuintnIkicBzQ6SNEa2d5C/NyPf?=
 =?us-ascii?Q?hQzcSZMetc9G5+JidoNWcUtWHROEfrf1gvU2CJfJTGy+zIMivDb9/weOKkr/?=
 =?us-ascii?Q?WTvJ8u9sYTSEDFckhVXljZtGBVx0okWRa+doIAtDwz+CWNxkXO6FP/r9gwHe?=
 =?us-ascii?Q?+xDEdfFJImUxzda0r5eivGE23C6a6OtX+daI4/TRGM/VWsnPMZdqhUFmmXHq?=
 =?us-ascii?Q?LbFpeCLCtZ7o5tZ3j62B8HFP2KYSca28TR5QZNBf4t7hERgMkHjieHiJaBWP?=
 =?us-ascii?Q?oMD/3h9Sclc9eIbijlLA4q4QZsvEeL50Bhm6DDtD+nPqkr40FXt14VWJz3Op?=
 =?us-ascii?Q?Q+IgvYTEmRWVj0t3uQcvAG4hyownLRdhvZ3VfWJJwM2d04xI1PJQmHICUTTY?=
 =?us-ascii?Q?NI+rB5RfY63yqtSE/AXrtODDrTExzOZF1S0dxKwrO1purwfgNn5Ap1jWX/VT?=
 =?us-ascii?Q?/hHROWcj0vuMsNxsE9Y0lp8Xi2CPwCvjPeIIk29VKEtkdIoMOebWKEitQQow?=
 =?us-ascii?Q?UTKcfW22J12o45xwcYmyKXnIfwJ6CHmX?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dz/UiTNDx6VmG64UXKGTE73gvamXgfbNuYL76Usu+SU1JPOoSHqIwIwpnEQ0?=
 =?us-ascii?Q?nIuCUkSzSMDvQCKAKztNbQckHvw86bLZHE/OR/56u11roz89rfXWrAw2y9BD?=
 =?us-ascii?Q?jujvqpe71LsIhZjH3DhjoQ+6xqOo8H32lBYp0CdS5JEtl9OQccg4hlEekta2?=
 =?us-ascii?Q?B1MXTAWeJZPwpvwPkMUVFEDprNGCu96E5yjTwExU+MMK6Q7VQNs75m94P983?=
 =?us-ascii?Q?kB0HVglL45R8F59mXAnr6Q+38MRIW8KX17ttC22s7EraEbhv37pLiRGDGqE4?=
 =?us-ascii?Q?ooElqUWgsJXDm/XqWnWuXIhqT9MD0BjE9Cko4+IdKiEFv7SbOhFr5RkWfiFX?=
 =?us-ascii?Q?dfHTaCCI6hJxfErPWVJkk30HYgjGDOk1BhI5dOtcuavnbckahJD7rFwtV/k/?=
 =?us-ascii?Q?yhhSpIp2wWsVWU4Ei9JSd8wAg0nwy9HIoFSPQ1yd8qijnupP+SdE2tM1IaHT?=
 =?us-ascii?Q?S7FlwMMD4Ut57RjZUXp1UUkSDZ8skoxvOjRfuXKINIe9leDiDtq+xlnD4uX4?=
 =?us-ascii?Q?oIQMVG3ifeeKhLsPUjIqlLAyfN4J5hgPmu3oxTcUTee7sYzRgf5Zh2u2/AHb?=
 =?us-ascii?Q?+OK44RIPMrQWw8TwDtxKXet+6WSC2+ez/rK7hK2I32qnd/bGwJyIp8TSZj/W?=
 =?us-ascii?Q?B9yLD6CwXAkTt+5d2dYX7Z7HsviR4Amp/hxLtJDnatowm3fOtM6mtC2RRvOd?=
 =?us-ascii?Q?JivOmePuvMbh9A0QAzW9Z7QWwJvSEDhbrB66ldIwl0j1Mt4JS3P4rLTV6dJi?=
 =?us-ascii?Q?i09i5muJKBdD+7JtmVGh2YqNlxirlAZhijRg9FP2nnOeQysr+arYKSyQPpAL?=
 =?us-ascii?Q?dp81s6t3SZWl58YtHRi6E17p86oYy4tQMS78wzdeLpI44tbfhUy9AOjFv6um?=
 =?us-ascii?Q?0wuXIyskzflrQBd4v4IeWZ0Mj4h256AAukNwzx4u7qh+dderDx4ur8dUXTC2?=
 =?us-ascii?Q?ybURot40pHs21T5zEvp934FoTeR6weAW6KMLPnaaj/BKC8hFn0pxN7/nI5JS?=
 =?us-ascii?Q?Rn2hG5WW45FbPJawIDYLRqWqOsmcCLYS4ql32hy4NyPSSi9kcvAvdD9U+MDc?=
 =?us-ascii?Q?bO+SUzLxzSfAtZjzMLbS8SCfbYoQWszl32zgSNJFnp5goKdD/dTCezM4TdZE?=
 =?us-ascii?Q?jscT0xAUtLPkTOF5JUGyD64hYuTxzh4jSd8g2KbCGAMvYlTvQessQ2Kz9Hcm?=
 =?us-ascii?Q?lJ5RAPg9GE5jKKOES8sEgCYKYmmPTphKBH/7QcuqTBfqw+IaLje+wzSx7fGk?=
 =?us-ascii?Q?/eoYgsAntZuPWj/V3da8E8vMjeLCVa7kvbRAkdYWsbL2lJi6nQMxmnbdaCzf?=
 =?us-ascii?Q?uzvIqyKZEN0YMI89fyg2imD1R7X5lN9Ho4bAsifGWN9Yg7X9SuW8xP+IeFoU?=
 =?us-ascii?Q?SgO2u8D2vJ4xpWIl7e6ecQX/cghq74YO0puYtkIVkOk21CZJBym07qAOTfM7?=
 =?us-ascii?Q?MUCdGjQkvqfFQ6K08jdfsjF8rdeqaoiX1NWhXAx5KYsGG32mqgL7b8VXxuFp?=
 =?us-ascii?Q?N1RndPWRUjQ2TBs045LcFE65SgS2+z9xq98C2XN5KgpLrnXaoncNnpvR2k3w?=
 =?us-ascii?Q?G8xMnGFmYbDkhsFGR0EYKbik6Nh/5L/F3H599AmlvIMx4hjN/NKfzrg0Zk4Q?=
 =?us-ascii?Q?av681mkOB5b36oto0+saW1k=3D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c8d7ab18-93f8-48ff-566d-08de1204be08
X-MS-Exchange-CrossTenant-AuthSource: OS3P286MB0979.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 07:21:11.1604
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nk6l16B2xTpAVOsGbt4QgkxIVl7blwcyqqpXxVv6H3SnA2G0I7Ymc0WNM5eArJHXXwJj7W4wj/XTvPWb7OAfkg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYRP286MB4555

Drop the unused field 'retries' from struct ntb_queue_entry for
simplicity's sake.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..39b2398b95a6 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -113,7 +113,6 @@ struct ntb_queue_entry {
 	void *buf;
 	unsigned int len;
 	unsigned int flags;
-	int retries;
 	int errors;
 	unsigned int tx_index;
 	unsigned int rx_index;
@@ -1630,9 +1629,7 @@ static void ntb_async_rx(struct ntb_queue_entry *entry, void *offset)
 	if (res < 0)
 		goto err;
 
-	if (!entry->retries)
-		qp->rx_async++;
-
+	qp->rx_async++;
 	return;
 
 err:
@@ -1910,9 +1907,7 @@ static void ntb_async_tx(struct ntb_transport_qp *qp,
 	if (res < 0)
 		goto err;
 
-	if (!entry->retries)
-		qp->tx_async++;
-
+	qp->tx_async++;
 	return;
 
 err:
@@ -2273,7 +2268,6 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->buf = data;
 	entry->len = len;
 	entry->flags = 0;
-	entry->retries = 0;
 	entry->errors = 0;
 	entry->rx_index = 0;
 
@@ -2323,7 +2317,6 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	entry->len = len;
 	entry->flags = 0;
 	entry->errors = 0;
-	entry->retries = 0;
 	entry->tx_index = 0;
 
 	rc = ntb_process_tx(qp, entry);
-- 
2.48.1

