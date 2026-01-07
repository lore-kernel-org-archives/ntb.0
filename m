Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021127.outbound.protection.outlook.com [52.101.125.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3779823D2B2
	for <ntb@lists.linux.dev>; Wed,  7 Jan 2026 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767759910; cv=fail; b=RRQ4zsmVdK1lMG+ye+0Kq5J+Xlm1VjsZh9PjHFFcU9huZPOE/oatNwuAv87qV8QJi0aEbKbEbVPPlkvBYKPpi7rD5aX3r3rrKNgVlYPzRi0rJw9/MYzOChxAIwqYyc9ze+vIMHjalvZ0Fk/IWXyVVhaKn9NhhAczTt0KXKRHgx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767759910; c=relaxed/simple;
	bh=yAXfr/lfuk29dstFTtVrSN81Yuy839mrxxWjW4ZhzgI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=SxMnGUeQjxyoZjCBpKm4Ca3mSXJ+A7wRLltiZD1nLYVsEYMEt52jrhRlSPUWEpTZfSPRNmb66btyhewaH+m9y48tQ8L2cUFQVbIoLQlk2QPFoDM2CtLEri68QU0ph88EV5vW3etqfCl+MkskQC1RVZjAiGUgdZ7hVo9wLYkCiWI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=pW/fyKnq; arc=fail smtp.client-ip=52.101.125.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="pW/fyKnq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qB3fZWFn9t7RRh/zcIYVVYZoOitsiLCUTqb9+67J5MqIzblzL3ud1591DaTMQHhjaAUJ4APEtwoVY6tyXZZOUGl9/5RUHwOIp8ktWBayz23hAUI1HB94sCyAN6EUdjsYBBHASsdhEZ8f1ESvy0rXviyUJunR/mEb01b13SEhTGp/qzggpFpBB/gBbGxA232fOpDFO3uCLb9U93ZmEj6qMlFfgxaRhq4d1w2p2KNQjsiZbGytUchKCvRzTqKLC+0/mA3fO2byijZw97HEgb2X/n/HZt9WVBRezPQtJcvChGlgvB/8wjqNjos8QCOTUjYlPaioIE4oohtd9Cy3Z2qjXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ikjGZKgItrRLNeYJErq1LX1skOgIlAb76awj0r/7RCQ=;
 b=DeSeAtdFtVBhrXj2XorwS35OQ1QNnZuJ4FBCKm5Ki2QH9ATheNd9kK+0VpGHcz63wFSnW4No9ORqTfvY3qM9KXS+CRiPzkFdrE8MjeFGhv81/MgxG4KUsfEc0tFZ83g2vSyJevqy4rcNzwK+SbtUm/9a9JbYc6p44Qr4AFONYFwRyUNrB39Gi1luLzCSh7BAb61fAY1JXgpKKx93ycU9eTGObwOC18OxLsj+RvJPb2XD/L/rCNUcywivEcaQB05Y31gw8ZV0sL+2irslBu4oacsKFKmU3M5hcQ++5o/QesP/vQz0UeMeiqxJGeyyFV3Xb/RGCBzMd55hDJ+DprdUqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ikjGZKgItrRLNeYJErq1LX1skOgIlAb76awj0r/7RCQ=;
 b=pW/fyKnqLjPQc+oApTECfWMqN9UAtoJ2Dib+v69uXmIKWJVqCrgvgZWMfissGwMyfI50y7U2gnKCHmlvWZttG7vZV7l2a+2mis6q/jles2xLKn6je2xV1CpjCWAesSWXBjTXHAKQNhRWBDWpADNNY7TroChrovvlq/2YHZ1AWxM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6828.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:433::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 04:25:01 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 04:25:01 +0000
From: Koichiro Den <den@valinux.co.jp>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	Frank.Li@nxp.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] NTB: ntb_transport: debugfs cleanups
Date: Wed,  7 Jan 2026 13:24:56 +0900
Message-ID: <20260107042458.1987818-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0133.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6828:EE_
X-MS-Office365-Filtering-Correlation-Id: fa9bfb45-34ef-4dc2-1d53-08de4da4b94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1Q5u+FycDZmSBIj1M+nNHFGng/GYsgh62NT1U5W01W6tBtZQ5u4qklDByUyn?=
 =?us-ascii?Q?fSzvlsZfDE2cav1SuW2OSgBP2Yct4ZlhHjHhuqf744oSod7YCoVdtOWosvvf?=
 =?us-ascii?Q?kGD5NvmfNSUtqGhja7QKPH0LueahuOe8XObrV1D+WHvd+pszBLP+TEG+nQ2Z?=
 =?us-ascii?Q?CFC0aa57q9dtdcbfNzRyL/3AE05RvahdTgm/CHVTVCFA+anVXjpYApfq1nQ7?=
 =?us-ascii?Q?afWzFPvX8HlT9v7oGaa4IL/JNBPJT7y68+lFSUHeOS65gVntRkZGaIWrWxz6?=
 =?us-ascii?Q?IwYpp22M4A0lyRRu09Vqp5EKy8eWH5YOZ016xXjPqZLJte+k7FOUKUGpXJeQ?=
 =?us-ascii?Q?X2LjxOgFqFhj9TK9ronDmXgU04phXkGxSbpkvkNV629ewXV4wrOdQhWRbJC8?=
 =?us-ascii?Q?n88WhcFKRUQcDdf9ll4taGDgVwZlfOE6Kk5TGVoUIoK0+cVJgaySwuoraj7c?=
 =?us-ascii?Q?tySDc7DP2iTPo8/sjFwHehr1NNiPB2jz3cYsVXLJBGwxkUym1HTQJXIJ37l6?=
 =?us-ascii?Q?bpP18JiwDUrqMC/h9Uhh8p+1joT23/6jw0WyLDnv1qAzVb9GhE6iRGAP8ott?=
 =?us-ascii?Q?9aFrQ0eLZths1ImErjoP1PxIorKDQqXBGSiH0YN5jKulNQPwqibKRni5RlvE?=
 =?us-ascii?Q?QQAG8YwOJSMW1R8pXs3ZiI+qMqskXbryXswC3BIdL65xVo4N9fnQoitdgYt1?=
 =?us-ascii?Q?LFevQTicNOm0Fa2EFucz81UKYsJ8QpVXiqt5M60/PD6NjHULI1BI08qUHV8G?=
 =?us-ascii?Q?DmfkegNPfdy4o7Hiozdt6ZAMFQcA38oO9q66gpqUG1GcE7KNT6QQNiQrb/IU?=
 =?us-ascii?Q?umrvIxUyJ9oLiA6SW6KJaiMTZ09vO6jcJZybCGi75hp4LFEuhZfV2fjXYry1?=
 =?us-ascii?Q?slBpW/helG9Qopy97nhPaD3w++qODaqKt/UIAloltHc8kT4nBcYRYu1D8x69?=
 =?us-ascii?Q?vLlFu5dnzdA8dvxK4932ku3TEZQOk05/EwDUzN+URfJyPycHkezQYRNGXjjj?=
 =?us-ascii?Q?c+n5YonO2VDpmOgvQB8iPMW2g5qj9dCHsPm4ZBQqle/GAqVlz5GO84exIGRK?=
 =?us-ascii?Q?NV+aN5ToownCNTdeL4GUlbYsKy/eApVAoMGyPcy8mkH7y1KpcgS2x8VxjlD1?=
 =?us-ascii?Q?JDfX+srrjWh09rgYyMCeq5uxeiaINTc6bDUGJFCPuVPxiSdfDxv8+/RIJTT2?=
 =?us-ascii?Q?UATev/kvNtz3Px+3+9M6fkLNH4DZFUZffwYBsyuLo1xtcCJkmL67JFNv2HGh?=
 =?us-ascii?Q?uXeI7FZ8o/j1XF6GSyiYsXR0PY//T4Jf/7k7HeUoO7L0TNg32EClLlh44aIk?=
 =?us-ascii?Q?gyyPg1uOCoInzVsoLc0p9kpzH2BiG+/x2zGtzNdBwuzbS1ZHusDElWC9MCgY?=
 =?us-ascii?Q?J2K3Fgh7cdKH+MAhmHCAPX7YHRwaII3ncOM6TAH9wfjKwoN6yudV3azJjTNS?=
 =?us-ascii?Q?lAaPRSdvnvfdW6ze6F7Sxf/+Vb6Rrm9E1H/N83J7yuHEDB9QNGWrQA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?c0XjMsr2qVhpALtGuOHqBGogAWllCoiGOCt7rfOAVblo+jqR0sbYKA3/XTij?=
 =?us-ascii?Q?OtmhgD9Bb+5s+EvT6UHiaWa+y/unbn0kaEMrzVuHs52wq199Ww/t9VwSJ0Dh?=
 =?us-ascii?Q?zLjbEKwDHpJg3EoCrNY04grcSjpuX+nrdL8r4BGxwguCLxlBBqmE/5w1GPcE?=
 =?us-ascii?Q?BKOOAUtqNl4VsBONxtdPmPzYe9bNLdMP9m9xjwfIT5Dw7DlYInjEz9ri0IZZ?=
 =?us-ascii?Q?4rMoBwFPAI6/QhFT8TTod3OhotC/T0aqt4qMHaRdyCZvvwZxZDFJETywreeU?=
 =?us-ascii?Q?MdoXyEV2Zp64mjKWu3fIUx9eKdkf47sAbZ0h48MGXB6kC6WCF5dTlCmOVbJq?=
 =?us-ascii?Q?L/l6AFPp7PvLF+slP8WCSjJp4zNYCyO/PbtE1qAnYwJAzzYTIEEq9y6mKw/g?=
 =?us-ascii?Q?lsKACiF8/IytyxUqw5H3/VManaDC9wRblRnk4xGXdbaheuSpCFpkmP1msmWJ?=
 =?us-ascii?Q?nL7rLF+grZmjFVL6esss8ll0Lz2nuv7HAYs1b2L88kZM1WDVlncoxUJR1V3O?=
 =?us-ascii?Q?0NAiyNmu0YbqPQKN2rhjciJqSdFMzrZh05cI9eJep6qovBfoqT/QsLgiu42y?=
 =?us-ascii?Q?WPbb7f+Je4/dP1AXVujdqxHfkiS9fqlFO7EK63GSSrN3mk4C4zAKc0TLpt3D?=
 =?us-ascii?Q?duRITWmi6cXFcMZNGwnGx9ukOI5xoyWI40Ui1qpQA9jf6cnDwuqAXjzw7mVT?=
 =?us-ascii?Q?VxucVFX8FBnU0gsGebdbaFUpXaiL6lgH0k1YOzd/LUpk3BawS6xr/0sMcwRn?=
 =?us-ascii?Q?9Xyjn63zTaeAAvf/bQTrZiZ8VEkMc3GD7J7q5Pp6k4JBCBsG0J0AC9Xr2Fcl?=
 =?us-ascii?Q?lOoyixPj1sPRbSabOBKLdYr012j+R7Jvbi2x7Sh3PcwtAZFk5MFnDCs8KIkc?=
 =?us-ascii?Q?WJrasxDX0jy9e4keEfRtgF5VSnqLwRDf3KJdg9q5/ipn6Stmr+ZYA23X63KE?=
 =?us-ascii?Q?/p81HAC2xQOVqlPSZPEhpScum6ZipIg0g6nU+Sbo2wMp3J53WARABDFkOs4+?=
 =?us-ascii?Q?wDOgPtF4WE7zb8dJ7f5FpRM3qiK4vc8KiRLMw14QRFEianOxD8fUuHa18v8r?=
 =?us-ascii?Q?KDQfirldadF4zFzVC0UmK/j/TTV04+j9XYWnZgB7aW5Hj2cZYzV1o5SmKuJa?=
 =?us-ascii?Q?MfVPZ5+N3P0zxdyE8Ufj8o19tVXjBkJj31h2Bqq58MEKMSBwWRYoyE8TFqK5?=
 =?us-ascii?Q?1/zpugxNmR/TveBqp5AYwMGoyNDJcWbCogno8n0PJbTrmrC+BcBlqhS7SmoT?=
 =?us-ascii?Q?n28LxuqGAGBjoPqnHHiTpTGP/ACRdpOEtKRr+rw5K3Y6jXbOhIpAtFb2rqQZ?=
 =?us-ascii?Q?8GfpKVJJ/liwZbHG1LIhs88SkBranoXfti8v3/VRlSP4Q87vq72gHR7m3vca?=
 =?us-ascii?Q?7cp5COVQ+bb7xWzGtUedwBInW6TERSccE4u7eGCnx17IvCA1RCSE5dd5cDxg?=
 =?us-ascii?Q?wJEBXVVH0MvrfiHhXwVkZ4BQhddTXjQAoFzUUi2ovvsyW8JlAs0KohLzfs0H?=
 =?us-ascii?Q?ZLEwccMVa3tY/lMRH28ntw4I3uYsT2DuRXYxRB4FkTa9O6h6Ui1vmVev5ikF?=
 =?us-ascii?Q?DLRw2vCCVpXb1M5qs9bhkmHRaIR9oZuNlMq3NPo//76H5Tk4CfgBvF21bK/Y?=
 =?us-ascii?Q?D8/M60jxiSWh4Aetv7moMElI4A40+rwzIUygEBZBwyQjp1O0+lAIIw98TuFS?=
 =?us-ascii?Q?fHHxI0H8hOFIelp/ZZbMQugwMm+zqbjO7N6W/xc8sD+EhzxjRzaJHm8rGwac?=
 =?us-ascii?Q?rYEVit8YruerxHLEvayd4psuHwNP0CIUnhutOl9XPVvWismhMd2D?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: fa9bfb45-34ef-4dc2-1d53-08de4da4b94f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 04:25:01.3254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3XFtgdGrZPYXUUgPY03VtChZs2ipivFy3OePDD/wZgA1WEzH1PdiotAvVuoM8uUGQAMNaxBRjI3Zens38ziV6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6828

This series cleans up the debugfs implementation in ntb_transport.
To make review and backporting easier, the fixes have been split into two
small and self-contained patches.

The first patch fixes an undersized buffer used for naming per-QP
debugfs directories, which could lead to name truncation and directory
collisions once the number of queues exceeds a single digit. This is a
candidate for stable tree inclusion.

The second patch converts the per-QP stats debugfs file to use seq_file.
This removes the hand-crafted kmalloc()/scnprintf() buffer handling,
simplifies the code, and avoids potential truncation as the stats output
grows.

No functional behavior of the NTB transport itself is changed. This
series is limited to debugfs robustness and maintainability.


v1->v2 changes:
- Split the original change into two patches:
  * buffer size fix for debugfs directory names
  * seq_file conversion for QP stats

v1: https://lore.kernel.org/all/20251217081955.3137163-1-den@valinux.co.jp/


Koichiro Den (2):
  NTB: ntb_transport: Fix too small buffer for debugfs_name
  NTB: ntb_transport: Use seq_file for QP stats debugfs

 drivers/ntb/ntb_transport.c | 136 +++++++++++-------------------------
 1 file changed, 41 insertions(+), 95 deletions(-)

-- 
2.51.0

