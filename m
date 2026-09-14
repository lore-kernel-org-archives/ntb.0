Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020093.outbound.protection.outlook.com [52.101.229.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DD141168C
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.93
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375734; cv=fail; b=o4V4uW7gnllscaYDbnznrZO/iJhnYRwAWpfGn5uatNC2uHY8Rf+2MguTf4J/Eumrd1ESb+i+nR+LXvJxh4NRGBjH7PcTKZV/+muAWydCABJ1q76Vp5I9/w5EmjRwSBgUX3KZQVBCDmRUeNnWwhv0ayfgs4CZsfG8Sxg5DuKaCRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375734; c=relaxed/simple;
	bh=fi510pSp+tU+IMhlqPLkFICv1DddkIlQ98KiZsAQi5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SVfhH2SssbCmZLu1/dbdrtcKgbZvR9JdOs3OjFWelL6m8Y7VxIanRtO80LV8gLoIhocEBpI9Tp/uuy+rgBxnC8l99wjzbChsFN7UihIP5KUcj8IRBd4UGKJwda8h0lFBtYm9JuGI0v+mQsUBohd+yBdwIRtQS6ZnDV5BFfYTPX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=e3ZEekxP; arc=fail smtp.client-ip=52.101.229.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="e3ZEekxP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NSyidUlukCbcX3g4oeQwSgAxcFQhOU7vjl44B8ibZYInu3s4XPBxyK2NCjjudM9KHJA3oJlzC5ZUOhxXPmMIWzW5qtV2axukCqU4mHXeXjk/vntCB2n8u0OMyv0dzD7JP4r9/2R7e9vsPy8vgXLbMq4Zu0L5c5N8XYTYfc9fuPRWCTyAkNKGh9sYZZ42kWFiVm7iTH1TqneP5paEqniIY22Qm1ByDtEewkgsFCNZHKwDZp31m+4l7B20H6yfJ7hAPI5AeQjNQ2QCDS8jA9wC7pY5K1FLCoc4g7bNRESSsUlMr1yz3uydBSMEQVdcVpuTIvyniKfO8sC+yMSc7USVuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53W9iwXOiV+CBicmeKDEiC9Sh7YvSqQrgXXpO9Qyl8E=;
 b=uB7QpC9EYB/JYsgxk06Wubkt4H8d7WQ52UKL8jqy/JosD79DbhBL0tFOkLcJAxjhqD7pAlNvJZLYqDg1g4REXo3aAC/hzCF6GnVBuDx3T/EWXq7x2Kg8XmJnzAlHP501QgGqBGL+fnwdcyoHOAatjhp8d2QSZ8DSPj70MWXG+lUQNAySCa3Urw/li4wbnrwHu0iDBy2oEESEXHrrPvppVaJbkODD1DFg0ZDtbPx/g0/skpJsHeKkcvqVd0uyRMAuA8kQS5islS/NKe2Ja2ilvIZOYsqcH9fcTL6i6GrPUrW0GQj1aE7ENkB125oI8ti6ip+Go5MNDxfhYfMooI+kVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53W9iwXOiV+CBicmeKDEiC9Sh7YvSqQrgXXpO9Qyl8E=;
 b=e3ZEekxPm49erDUGaUX7A1It2cUwZ4UgFOB8GQZqBm2vybDAQHRvsdQaiqCk8egflbCFo8RAVZ7vBPIrv4HnuX7Q0v0DQRSITzbHcKyRMByi0GOc9I/dq4agtY3xB7zjc9xQJG6zclnDENkhfeKKKaWNtPYD0ry9w5PLQ4A7uNY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:45 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:45 +0000
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
Subject: [PATCH net-next v4 04/10] NTB: ntb_transport: Keep local QP link requests separate
Date: Mon, 14 Sep 2026 17:48:32 +0900
Message-ID: <20260914084838.2158249-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260914084838.2158249-1-den@valinux.co.jp>
References: <20260914084838.2158249-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0179.jpnprd01.prod.outlook.com
 (2603:1096:400:2b2::14) To TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:325::11)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB6866:EE_|TY7P286MB7153:EE_
X-MS-Office365-Filtering-Correlation-Id: 87e05c90-b0f8-4cb9-19bc-08df123cfc52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T7IrJZBTEQWhf7TBUGUbbRDHmOhq0pfmIsO+0QhCIGWGE1e+wDhCAy9RkaKwURSCQYTdS2cBT/j3oszqC/pjtdpG4jlKP48FL6IXZFNvgFJLOocDvMfI3iy8IeLhw0Ces7ohQSakbOcLFTsQ9zC/mUtgYj96cCPCHG29lDrJgfYJuBHSeXDfiiO889VHetpY+QSsE3XIirgANR7SkS2uLqJfvjqD4J+BEHt/xIgbzn8ephxQw3I8YnYh0YXoXlv1bdjeHOje4CU8vI3Oe16wwPTq9GkhTuJKcEjOu5gcTMsyKONHiTnwnegPl4/mQQMojHtsCTaXsfs2/XsBz6FU4GOS0EwzF1g9w5HpCZHE7IXoEaN34+GXA8R6kRgmPnkaWXHllebFGwukFvsLNOBV5+PFYRIRO9cHKcBZrlossg9SOTA3DLFVMepUnSy18Mzwv0puHvMbn6qCT7Pa0SylCw2pYNLTX+cH+pSsbbtk+OxIJ9nXs/vYBb6iIP1gABEjYmqIzIoFOAN3rU/F+k2jo+GZWymtDD5QSFDe0EpCZwhTGyJt36ZoWPsdlGeO4cOaS6NlPnhgdy4GKimURPCXsHZ8sV+H1wxYoaPEGsZsC82u9T8hbbJaOjG0XT5/bAIcjD5dHTWriCTV2sltEf0TtMIyOQ0Pr8Tz5M0Dz1cwi9E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Puc6Z8J1lTpUqVo8b1Hsb0WWKEAiARL4Son7ocKGUfuvg8j78QPIwwbxyN4D?=
 =?us-ascii?Q?tbI5cERkBGKStTEs6UQXQbwm+gmWmx/DpWwV8nUj0lIXBSaOPeVETweb3Ni/?=
 =?us-ascii?Q?5Hzb85raM3/7FuBsM1wTEJyWWyo+QXNpVq5OYpO22JYJFTHzfe5HVQ576sTT?=
 =?us-ascii?Q?vgn2Eh5a0Jjrx+k5x5cSncvZWKwiMLr1+XOkmpa/puksaJSjiNmBELZrAHAU?=
 =?us-ascii?Q?PkEjXJchAJf6OkrthHuW38O2hL1PwsQ+CdSMuxXynj01mg9BcE7CRFT0kfdb?=
 =?us-ascii?Q?AzNQlB7vBHNYt11sHuvbSOkEfAmlAusEBBl4s+8pO9eNG6Tr4+RdmShB6wZT?=
 =?us-ascii?Q?Z3vqOG2U2r5ZcjU6yTrYI4+Q0/vwvDBgicpU543PKELpoYi2zA/haaFfZyK/?=
 =?us-ascii?Q?+cmO9Hq6dBfECVDQ6//o/SWxorBSRBTLMbmXITtk/0TALylw2LB5mlATus7u?=
 =?us-ascii?Q?/u94Z7yHFdyMeNJKh6TVtaw+IaEh3b8jx0o6ww61x0Yr4lIkH4wtROodSDr9?=
 =?us-ascii?Q?nJApTMq3Iw+mPIaIk/mxA3/ik9f57/gAJtEpGt0CA1XuDgOYCc/9FtsNeoIV?=
 =?us-ascii?Q?gn5N15ekkC6fJW0CoNipn9qEa42q065/t+GF4So7EMFYA2mWwqmWiOk/3g1B?=
 =?us-ascii?Q?gPwoaFjwo1sXNiz4xUd6ZcyHXfTsy1Dz9u3d7R31Uq1ep6UclyS6cBOtHwPP?=
 =?us-ascii?Q?MrX9tAByKkVI4ZitJst5fRA8z7I94bC//ihZuNkbmYjP2P/M/TIUMDXbRCGX?=
 =?us-ascii?Q?p1XGmTwjFWCY6PVtkYO+sanfeUnEK8UFdFQqZLZ9fPkyEti6/neWPevSsE1E?=
 =?us-ascii?Q?4V/ChW4bja/sMUlXpKpyFzXAVdvrx+bf4trMtXjl7SLu9mgo7XnV4p2dASzf?=
 =?us-ascii?Q?QK+nB0cgy2gcz/Rv+7dbBcKtFkCjQD4tigyLE0NHA/Rlb0ASQzazStP0Mllz?=
 =?us-ascii?Q?NODuCOyfggPQPcbTigVgxC5j8QnyA3+JMuGOpEwRIZfnHDbavqAXH5ptzNlo?=
 =?us-ascii?Q?pjXbcG+krZ4QhgQmXmkkYX2gh5VmMn+uQIcZaJQUdrBcjq7Cmxi9rq31xpPA?=
 =?us-ascii?Q?YJ/+Qr0CRvFnZXZV8a477wYZmTgUmEsC5lTSuoMQa0fHqpuJASNWJwwirxBm?=
 =?us-ascii?Q?SWdLrJX8qkim+HVbmnoRQZvbpP6Zy1G7kTxdlTOo13Ec66VroJjFK63uXyS4?=
 =?us-ascii?Q?v0/hbnBhZ6Z6DyoUFkWfoSCc4Gpj5G2HEfe5d+vGqI9ihm2w7ZHTvuNkFCSK?=
 =?us-ascii?Q?s+gXDeYFL5cA4Y+M7Dl/4ljz7Y0LP+Rr6D0Ly73GCQ/ADtKSTCVR+6J8Jg/C?=
 =?us-ascii?Q?Y3AlOH5oEz7/UyzwJXUlWVSoPDralKHtC1b053TZxQL7ahm2m67hP68xAbmp?=
 =?us-ascii?Q?T+4gG8CfCpSuACtY5wrI+86i/GB/mJmztn0csLiH1BRgPQZ5mHDdXycdxEz5?=
 =?us-ascii?Q?vr5IHVzhYLw4vT5NpcGFu+r4tF6s9Hxpr4LctGn7/qRgW/Oe6bcb7HnhhhkO?=
 =?us-ascii?Q?iwOjAEd1wDz6VEEbEp2Lc/UcbLPRvbuKFmJluFs5DNvCabIa0id/JyCOIoHN?=
 =?us-ascii?Q?oZAkBzw3nv1sHuVY33GaTCdGwiUaFMRspiUecRc3ZU8zvvA0/LGL+7O5CRfZ?=
 =?us-ascii?Q?E2iWs8ugMdD6WWxmRz4luhQ9umrwnGNK253Nve+gZfYEjPs4fFnzxzgd5DUb?=
 =?us-ascii?Q?42krnRe/w3WToNGTOcy0h/TlS1/3Rl7Hlz8Nqtbwgkaqm7JLY37vSFWXUryP?=
 =?us-ascii?Q?fxuuZg5cn4jFrylDI699XMhQXmy46VgxpzdRW/HTVhINbWA01xof?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 87e05c90-b0f8-4cb9-19bc-08df123cfc52
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:45.1136
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WhXC2Ge5VzI+/47KrX5rCrE6pZtRuljMybA1oDFcFSpyOCeBQfilYPLjhAyT0S1r+MjyMkDFMCCC6X/8SYxTpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

The QP_LINKS handshake is a smart way for both sides to converge on
link-up without peer SPAD reads (MRd). But copying the peer's bitmap
back mixes up local requests and peer readiness when multiple QPs are
used.

When QPs are shut down back-to-back, each update reads the local
scratchpad and can restore a bit just cleared in the peer scratchpad.
Likewise, a peer's QP1 worker can echo our QP0 request before its own
QP0 worker runs, making us report QP0 up too early.

Keep our up requests in a bitmap in ntb_transport_ctx. Serialize bitmap
updates and peer writes under one lock. Clear it on transport cleanup
so each QP advertises itself again after reconnecting.

This bitmap handling dates back to commit fce8a7bb5b4b ("PCI-Express
Non-Transparent Bridge Support"), but ntb_netdev multi-queue support
exposed the problem in practice, hence the Fixes tag below.

Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi-queue")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch for a pre-existing issue found while preparing v4.

 drivers/ntb/ntb_transport.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index b69e8ac8047d..0b47285ef48b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -244,6 +244,9 @@ struct ntb_transport_ctx {
 	unsigned int qp_count;
 	u64 qp_bitmap;
 	u64 qp_bitmap_free;
+	/* Serialize request updates and peer writes. */
+	spinlock_t up_request_lock;
+	u32 up_request;
 
 	bool use_msi;
 	unsigned int msi_spad_offset;
@@ -976,6 +979,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
 	if (!nt->link_is_up)
 		cancel_delayed_work_sync(&nt->link_work);
 
+	scoped_guard(spinlock, &nt->up_request_lock)
+		nt->up_request = 0;
+
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
 
@@ -1113,6 +1119,21 @@ static void ntb_transport_link_work(struct work_struct *work)
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
 }
 
+static void ntb_qp_up_request(struct ntb_transport_qp *qp, bool up)
+{
+	struct ntb_transport_ctx *nt = qp->transport;
+
+	guard(spinlock)(&nt->up_request_lock);
+
+	if (up)
+		nt->up_request |= BIT(qp->qp_num);
+	else
+		nt->up_request &= ~BIT(qp->qp_num);
+
+	/* Update the peer's view of our requests. */
+	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, nt->up_request);
+}
+
 static void ntb_qp_link_work(struct work_struct *work)
 {
 	struct ntb_transport_qp *qp = container_of(work,
@@ -1126,7 +1147,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
-	ntb_peer_spad_write(nt->ndev, PIDX, QP_LINKS, val | BIT(qp->qp_num));
+	ntb_qp_up_request(qp, true);
 
 	/* query remote spad for qp ready bits */
 	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
@@ -1361,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 			goto err2;
 	}
 
+	spin_lock_init(&nt->up_request_lock);
 	mutex_init(&nt->link_event_lock);
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
 	INIT_WORK(&nt->link_cleanup, ntb_transport_link_cleanup_work);
@@ -2412,16 +2434,12 @@ EXPORT_SYMBOL_GPL(ntb_transport_link_up);
  */
 void ntb_transport_link_down(struct ntb_transport_qp *qp)
 {
-	int val;
-
 	if (!qp)
 		return;
 
 	qp->client_ready = false;
 
-	val = ntb_spad_read(qp->ndev, QP_LINKS);
-
-	ntb_peer_spad_write(qp->ndev, PIDX, QP_LINKS, val & ~BIT(qp->qp_num));
+	ntb_qp_up_request(qp, false);
 
 	if (qp->link_is_up)
 		ntb_send_link_down(qp);
-- 
2.51.0

