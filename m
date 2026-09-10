Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23333A9017
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013335; cv=fail; b=hFf2HvNPkc0yAYJKQ7vGLt7lvPrPP++PqCK4ck+pv6Xx6r1EDYawyPXriLiSQEK+/ueSoxnOTzwZfMoIMQt7n1Y3QNTx9NRTTL+wnLZsgiW15K19XFLRWXutL64GxzSHDrmv9eTcJx6HAkwtVy/6ESOaZ5SSMEWp4iycdl3jtLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013335; c=relaxed/simple;
	bh=RzXYT7Tm5jkhpbuj4K1xLZdyMlay/fuRfot3HHojE5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I6EJyc1KQ4IBnC6cJ3ih5iT+N5jyZy67buO4QXsulmJIifq0wGLxCndocvDhGPgnvGw+wz3RCy+rLlrKQ4MWnvGrDBiZOzEhQlZ9jplbvLQ9sHpSxlSLAQzDjvSZ71oGRbBwYVePqmz3zpsieYXyLMMskNLbbRRu0IM9Qfpi6Sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=uCDVn2KI; arc=fail smtp.client-ip=52.101.125.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="uCDVn2KI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W94K4guRBCK6Qn+26g4n9ORnlVpTl0kUG+L03eljAAHhieS0NHzMxBFNc06WbcErQp8Mn9ulWn89alRdX2ECwVPZ9GdSkIvWfh2I+Q2+RDNKupz3KOQEWTvMY6vbWxm2UiU4XLI1lwYMyBMP3Kko3ckBwuwvm++hzX/Dq/OFwuhngI8EzEeN3m5rnmc2F5MjTSNKOG0Fc4JMdZf5fBx26z48Vlm1ohUDVf5sulSLstuwZ+lCaxuPDbwbx+sRxX5DJPlzx1ZkZiZdLBtXk1KT5jwt3NDicMB8xpQkGGuisNI7PtC0gIrrJ0Cn9bpa5qWQfjdAoNjxtKizpWvo/uddGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FZxc3mZECsQMBy+ni31RZczAtlGFD2lrYpBrKesT+PE=;
 b=BAKENnIMgzV08P4Wak31jjmzCQ/ytYu3XQ1jpy3R1QHNmu6Fpu7HIdEMDgWg4VUwPK+IvfeLnhdEwtq982Ew8CizaXr9yHE9j14OzVh0b8F6DbAYtmR1ikcbnBWCsnAPNQXIOUElY3t59hWFtVAXM0x1WncakYthtdBjGvUFT3A9zN7b5W2ZCPMWCYEbArdKSIEpY6Ao4l1ZJE+44E4U6XgLFLi0iMXAzXw0pdMaFstSqVkvhGEgFPi+nG5gQEaGVb+ZC2SEk9G/I6mH4BV58b92x5EINP45gPEwKJTxoeV+PKlr59AX4MU/TRtFtzxvhNSE1d5oqUo3+cD9n77SKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FZxc3mZECsQMBy+ni31RZczAtlGFD2lrYpBrKesT+PE=;
 b=uCDVn2KISy65j+qdf7wCYja+Br0C9O1R7J1+dAr5XzX38zlwrf7vCo1yPcKsEWx+wRhaEHeoImwe/Dz5Q9XBbKVFc2ovsiKONEfwXqWCZ056vg4dB3R/EeEkc4ZRT7aYsIg/pcZyKsg7T+5oiOztJRfDuIeovBFBL2Sb9AufvUs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:44 +0000
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
Subject: [PATCH v2 03/14] NTB: ntb_transport: Avoid deadlock when cancelling link work
Date: Thu, 10 Sep 2026 13:08:25 +0900
Message-ID: <20260910040836.3792333-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY6P301CA0032.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: c27a04a6-0d6c-41eb-0211-08df0ef13478
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|6133799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	FXEwztRH5QLLKoPSz4gkOs+e65jfDnaI1nUJ971lsHuqk5bhDd8+x7b10cZYy72yMtzqh8PKU87oWemWbDQxFG91QJ2VGu5h2s6jFLrf7VfH6gdAjty/qG7JwJRFocJk+Jr9VucMDuUND95KXCcsP21iVVU0hJfUZ+XtGiPQkq8yOGgWMC8j4qmCqdqPJI+EFZ2ViZiafO5X9lpAdwCtVAWJFOS2uHxaiKDqcStAPRsjyc4e7DQxCbQskmDWJuZPd6sru58/SADt82fgG8Q0kkhHTlZ+3p6F8HaS4xYEu5zJ7IH0/iYh89y3ik9mPtrGibf09h6ijVYQxlxqeQ+ZXjVTx15cSYNyDaUnYGuqCczMp3ht1HHESu916IefZd/W1g+JaiM7rhqeFy7XPWy8/mj/pOmB4qEGIgnTgllLeJ0gl9Y8h6u2BrLhJYn/fG9VHZ7BNOumE5dj2T7czwQHQ4S6uYijKWyqzGIqI2uHJoVEndRpYeIi33/VVDiovDVg+Dwk9Ox/K5lFW8l6BxIuY74EwI9Ud2efaRWgnMKEUec0myt6MmLaxO95tWEgJkxT0TSPWQlsRK/EsFWH2yafzOuvNtyr1wG4CE7woq5zR/fpJiMuUGgGeenEKaEKLYpmZV6ua1t2nBlhTHnTFf4xWAoHxIuW7+x6VQGmNYfXtuo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(6133799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OxFICZqa6DzTlIlZRbgBhppR712enAKb2x0OER6jCnGZM7AwWtcADBGivTGv?=
 =?us-ascii?Q?9giX7K6HuwKdyvdYZdvVz/e5e0//tGVyQzc9f6QLl38p20S2cFXi75Nz6Is/?=
 =?us-ascii?Q?X6gql2lBBZdq1TluQEJaRJKdwJ8wb+dVW9yQSDCbstrJvoV/wdMityXAyKh0?=
 =?us-ascii?Q?5vmppxOYFHbWEskRvAXF9k19CYFcMzR4pE3y5KDPVky1MIP2CKik48gaqOy9?=
 =?us-ascii?Q?6fM53kWQMp4cUBc45yfqeB0CLBp3ms6hxxTGMJYZNRwE6vnim/bnRJfXxuGB?=
 =?us-ascii?Q?liffu1KwKIxdfi06MgK+F5YBAL2AZYm/xfuM74JLbHHQlQrIBjfdZYMp4h4O?=
 =?us-ascii?Q?Eh/DBVQ06jMClXKXUc+X9XWaWEtcQpNgN+OJgI5ZwpOE8/arcnfJ27TpuSSd?=
 =?us-ascii?Q?R0wyv3FfKNe/Kc1T02qYjNfkK6T3b0qJk0oA4WxgUwJUVIbyVKofQEjramQI?=
 =?us-ascii?Q?NOFM0bOV6LE9D2n1ey8ZCnNqtARUuMykpUT4Dv4EavnT3mqryIbulrwdFhXe?=
 =?us-ascii?Q?1sRrNdvi+sEJ7TJ0Row9LrM/9AHeWcTXU1+N2QhArT5f5gSTt31geZD1PSpq?=
 =?us-ascii?Q?k2XezGMsl8orWrA/rIDh7W9X/QBD6ZXTmG+8riomp9jn/kF6z67a9MWj76F9?=
 =?us-ascii?Q?EtiMG30KwmtQv+YfQD1Ro6HrZjtv4VaOSc+5eN1ZFsyOEBAZiMs9lsS/ywbd?=
 =?us-ascii?Q?GboxlZnJ06urBdYtM8p67TzDegD/s0KJuxwTutMYQmNgrSGWz18X2p0BZ1iY?=
 =?us-ascii?Q?pNvbPUWJl4u2acCwYBe0xXl5Y2DHdHAMJ7SUp6n9LDz+G3tuT658oqZjsILk?=
 =?us-ascii?Q?5iDbOCAFkHsimiaMibMisfhVrjQn+W/Sd36NLpcw0TA2EVM/ZZSxcQCnz0TN?=
 =?us-ascii?Q?GEw+SJn+oLtvVmm9JqydWNClEDBaByPxJtPLLTNlJ1UuL5J8re5GPw7D4lPN?=
 =?us-ascii?Q?i0BcBFaNrEPoF33WXSS11FF/136M52K96jKF7AwWvDXlFVI3oIXEPeJD54lK?=
 =?us-ascii?Q?Le96ABLgLZoRxARhhJUdmkpjNPd8BVi6iyZTpLzWG0DtJld4UbbXFqRBLIdo?=
 =?us-ascii?Q?Ssz9P9SD0Me8nR2PezwLYKVmTwqH0bbTahqXkrzYK1WnKjLKa3rxrKXlP2pJ?=
 =?us-ascii?Q?u1mHzRsGJsL3yjP0sWRVWCwTq3UumcDboMP8lfL9msme+V+13YDjloSIWrJH?=
 =?us-ascii?Q?PlemQ60JuJdT3tQnuO7pJXszlcOiYbSeI4U7ufSA3lLW1FGLP5xVV0xVCTLq?=
 =?us-ascii?Q?/roQBkgVQff0f0W6KIjAPOfMvNOb/3nACzukhfOdiYxU3BhYHBiPznk2Vb/d?=
 =?us-ascii?Q?0kA8dxvuLN+ukKxBNjdYVgJfPVn6TyffY5rNMDSEDsg8aZLQbOZxSrpKfnFH?=
 =?us-ascii?Q?S7iz8xIdpS9xZVXF7Y95puxl5gEBR7rt9CM3//K2e2Zph2oJG0v8qM+PXrUr?=
 =?us-ascii?Q?801Fx0eQEagBG7KHeF2+axC9poMhic59dt1XwD2rp28mLnjL0pBpLswZJFKj?=
 =?us-ascii?Q?Z/drhcV4hJDhLZ6yHsBg9AZBwPAkvTQG0O6tjWCVLKtR5IfZ4d/eJ0mmDSlB?=
 =?us-ascii?Q?YbOCx/lPCQv1IO1DpT3uJwPRWpyZQgXx3NqPWgb6nU3v1upmD/mlJh3EUnr+?=
 =?us-ascii?Q?L6WL7hN8pFKB5u1lN0L1i2OPXRgsNSis2Hek11MF+jwc/SDH7ocNf2jyWNxN?=
 =?us-ascii?Q?bfS2Iww//FZXsXRy9p+5KnOgzZVtqpQuvFEIsaNcbl4JlHVY99lktXchrOLw?=
 =?us-ascii?Q?PMQireuJHfte5zRsap2HTwv/3OK8CRSn8pebgoJ6bC//gTeBNeyU?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c27a04a6-0d6c-41eb-0211-08df0ef13478
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:44.0929
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4FlVvAgbkq/zmhD/xO+gGguKjx+ygkn/05yBpSD4ckYtIYTR0mAboKSMhf1C/3ehnBVBAzRrh5/GWB0kG+hxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

During initial link setup, ntb_transport_link_work() can retry with
nt->link_is_up still false. A retry can block on link_event_lock
while cleanup holds it and waits in cancel_delayed_work_sync(),
leading to deadlock.

Move the conditional cancellation outside link_event_lock, before
QP cleanup. Keep QP cleanup and MW release under the lock so link
work cannot restart QPs between them. Put the locking in
ntb_transport_link_cleanup() to cover both worker and remove paths.

Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 55a20ae9a85e..c77b173dca01 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -960,6 +960,15 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	struct ntb_transport_qp *qp;
 	u64 qp_bitmap_alloc;
 	unsigned int i, count;
+	bool cancel_link_work;
+
+	scoped_guard(mutex, &nt->link_event_lock)
+		cancel_link_work = !nt->link_is_up;
+
+	if (cancel_link_work)
+		cancel_delayed_work_sync(&nt->link_work);
+
+	guard(mutex)(&nt->link_event_lock);
 
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
@@ -972,9 +981,6 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 			cancel_delayed_work_sync(&qp->link_work);
 		}
 
-	if (!nt->link_is_up)
-		cancel_delayed_work_sync(&nt->link_work);
-
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
 
@@ -992,7 +998,6 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
-	guard(mutex)(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
 }
 
-- 
2.51.0

