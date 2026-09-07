Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021084.outbound.protection.outlook.com [52.101.125.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB53539EF20
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791100; cv=fail; b=dusE7Gm2e/7M61hjuWBaQF2V7eyArQHtDyx+voehI+7nAg3CsTMkkrMdr+02klyBfyMBxTpfbhnHVu3YslUcTJMr3eUlYr2+9MZv4FQT3THR3tLpHMkFuWPH4BVP6aH5+6WpyvJLRDPtFWjtUtWnVPfyRQxYPB80faGHS+w89oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791100; c=relaxed/simple;
	bh=ebUJiuE0G6fDfogqD2czJiibCMt4L3zpdqQw3S+jtXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=f+j23t2W2W1XBbNwkgysKzhw2ZBd0qImaMVpa6bo0Cs8WWM8MrC5ne4eQuR+cQ1begH9/SczJfOHowOxzXWGla8MttF2P5jx/JT2PGsv0rkg/8lbydkOl3s45Gk7SD3eLTOsn3qFUHlVRGVhj+r3FAT7HBWjfpAoFX8ewXSkf10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=OxHqz+8x; arc=fail smtp.client-ip=52.101.125.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="OxHqz+8x"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZf98EEKfk8YjZ6dQwDerEnFmdN7m8VfzojIww8BuN42zTm1wNHEkyecFpPn7wOuPluwx6Qo84qESEuZZ7Z5l+hxuAN/MxFb74eJ/MuT/Xjuk4SJan3uDioVR4iJz+C21ZGva2PpgO5ARiAoWcNaR9G8IfgTsmg/V4OgWDeaODvKG/n/E5tl7ZCei5mM+VSVQhrxTmM5m2k7G7WJTvw64ugAJ27ZYgCGhikQfGuKz2i/sjHQqkVoAztq8FU9ULU0RFToxmeK2twEDcbNnTmhHaf1RETS8ZWXvmnCDoEV1g3D5uHawgFPVo2QWDqSfDtNcWfXN93KnmGxaNeJFA4Azg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRzcxgeBKCZ+BU0SFpvkueLlAyjyr0o6iQpGgRVoZY4=;
 b=Zs82cV8HOEmwsy4Cz7UBKisCsLva1XGVhP5GfAcpCLeFhXE+iWIUwPvoD0PM7U+9qxLb4Sz06cgm0iL7hS61mRFcn2y8fT7MABIO/19uKALkxDzM9D8gqgf1oeoO19cvJWQf9SPmxg89JXi9/tedHcE+J/WK5IHunQumHVeGIsyjGzFV4kTLRf1cHnsKdLMbJjeUMTImZlf9hWLfFXKbOX7MOX4BdiprwiRtSnpzMgWvHeiPdj+b4CH8ZwgLFEHj8mZdS8W0o99dBd1Y7ZARAHzGYu80ldfVP/KeUhuVbZKDjDW+tYz+RvBrMAIpZq8vd4yoB/pDnGz7wDdmkTU1Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRzcxgeBKCZ+BU0SFpvkueLlAyjyr0o6iQpGgRVoZY4=;
 b=OxHqz+8xo2ZJLH0on9B1DGdkDKsy3hsjKM8X9uIUBEg+XEi9KdBz5Rz61dvFqEPrU325CRhQeCUM/9ZyvGCbhsLyW1640aWWoZx0miz17aoDArrNNqXRygvSh+xQQqMbTqIi/1VGqOVSCB01ekztWXL+laB5h9NESry4cRFDbGs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:50 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:50 +0000
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
Subject: [PATCH 10/11] NTB: ntb_transport: Stop RX tasklet scheduling before freeing a queue
Date: Mon,  7 Sep 2026 23:24:28 +0900
Message-ID: <20260907142429.951930-11-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0209.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: c432c654-64a1-4a4d-7a4f-08df0cebc71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U/SUewK6E3m5BMXMuf5FJk81OA6M8FELXa6tQ6zN8SMIp8WMDlhn1YJ93vXAxLInLmRTgV2lb5D/WyRwU5UuKGHe1qIuj5onmaHGsF5yVeywVcF2mTwQbHpE2+++eRNEFQLI4nBvU6Kx9SlTGr+a6gcc7f7LgAoGcvWqj2CGjQ1smfQ2UZg/xuB4r4VmN69GO+nsJdnVFalWVmLz2WYc1B7Ii7DwsMy9DS6Z9pWGNyw9aoE6rVNba3Su9UoBVnJtrM3AfNBmaeL/I23Nur2JXjUe1ToHOqgKhH2d24m7rPZ2KGCANGptzgGpvUq+XvTPOdk1u97KeQXG8D/DFZSmJsxScA2d1haSeNBiXLNQp4liFEKVo81tgg3v/iwqJyLh1L8ZOIdFjhyp2zgfYlTSwE/OpuLZWxrk0faDY+YUxpeuoqD9v+V4y79RPory7CMCrT+QpeiBYXIP1xR4FIn0TEVTI7Ow17qyKEDOd1I+/mLfNPN9lenxXEfL/sfGFs53iLUUPtM9KVRMfLlt8Zn8nFnqwy1z8R9rZEIKoR7BuPD0BK/SiDIH36LnbzlHvx4+vqVqtscAU/aS/4tXobeXwYTSrDFFIhmWGN1WSV+lZuzyRL5F8lj1BFpQWlIvrl5XDHFAoQKQ4wXPPuxeYjPaTK7VzKzvqFsjUHP/kPSub9M=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YfjBxbrleO4BIsO4bYRy8Z0r2ecozPcBmIOKHJaanymUe8t0EBz3wmKQMwoy?=
 =?us-ascii?Q?vKYEi1f1SUZXW7oUN1r+RqlNXYfy0/DOqOwwprXN1tDB1sqIPxP5z2t/S8b7?=
 =?us-ascii?Q?fNImpwQXJnuZouiTnMpKxiuLIHFBDS3+/Q8Ai69QHMet4vi4B2cZtQ+H2V8u?=
 =?us-ascii?Q?g5qN33DRCwr7nVuiq2F2JY9MOOYva+tfpVSY35wBnz9EMUPDxPIDzBQF8IrQ?=
 =?us-ascii?Q?lAl09On45WkT2VrBZXwXkDp+BqgfkABZsemc6Zlgcz2Wchfy9t2XMx2a1K32?=
 =?us-ascii?Q?2ZaWWt02vvWNmwgh/vgcnh+keo0mLbSYPIRN1tXKuLBmKJo5qKDPPR7MzB4D?=
 =?us-ascii?Q?qhJs1HvrICcwzQk2oaqJ7dXhDdEeFWodwHRoqn2s8z70yfLvEq3Dc7//eI9h?=
 =?us-ascii?Q?giMQh1NqQrl+73CO3ODNXeH0RQYlpHZVmYW1VoLQXJdJqZMf4b0Hg7ylZiO0?=
 =?us-ascii?Q?x/HEuC1W0n7+MRj8OqUN2s0lOnfzWWX6NVIb9cubKHWDiBI32t/sMkbRc17E?=
 =?us-ascii?Q?YA5My+pQh85zrsjRTbyV7ZaFOB/s6aOpUNGTJHy514BBPevrFDdOKg8SEjsC?=
 =?us-ascii?Q?iIyUPE4F0N0vf5pQh0065P/iC5EwICLNEwpss4ZlBS86JdQqG6IibVGsSItF?=
 =?us-ascii?Q?gEhuiPY262W+J5X9Pri/5SLmWN72XaxOIpDMT7BA8kKtfiXeU9wFmE91PRN6?=
 =?us-ascii?Q?dTfHaNaS865UdewoziRXd3F7vN87JRPAYRPxV1Z/ijPGc620GkxRmRsz+jEZ?=
 =?us-ascii?Q?KBZ4rYRs98Kd2PKX0Ms6GYgbuSjcn2ehnBMGic63XrHLJeNhQQfzhwqOYScI?=
 =?us-ascii?Q?qXQ6//nQA0kJvSRwUeZl2sJYmNTSgw6U59LRs72EM0bcC5XaxGdf6zZ8ZCtv?=
 =?us-ascii?Q?K7kFJEDARW666yhf2ORK6YwGKAHfnXmIRbj76EF/I4lUAXr1ZRneX7csitEJ?=
 =?us-ascii?Q?XZr4btvx26rYDuIaQPt9+71n1ckzBeD2yDyGeknWhCj8YuoKQHmzIAhDqIvh?=
 =?us-ascii?Q?BxktShcPrcGZcpP1bgM74jHzXIyzqoyvAI/5f0W5ah+4L0L3qnikJw1FezOU?=
 =?us-ascii?Q?W7oFIlDllxUbE9kTd8vx/0BT9B2bDNnpPeF1gxIgnk/yyvsIJY2dv9vSfC9i?=
 =?us-ascii?Q?lP93qIQ558TLPsI2xbnPT8m2QImjiWehDZRzrnK434y8i7j+B0CfKjTAjEcs?=
 =?us-ascii?Q?PrGtVWx+ar73ov09XFhme9Wr2exHDu7G+dIfgG1rXsx2e3IRm384gB/sxEZU?=
 =?us-ascii?Q?SeuYS0ybPeMOkG5FiGQO9ApZ2lcJhE1mnzWBeVm1N77/VHv5egemAXEh0E+9?=
 =?us-ascii?Q?j8GAbudFCKUofjm8f53oN2f0/Ex1g17oE46gEcSVbA5PGQhSNH8zlJwNkZDs?=
 =?us-ascii?Q?dqhvgEwf6W+hvd/H/ORBJkqWhlVYNab8DVQ0E7uXqkxrvCH3MOQ/1qMGlxti?=
 =?us-ascii?Q?Msf8pSJFRTF2ZWJqcc0cLZBG7wLX2vrYKiYTl1yd4s1myTQgN/NKmXPvWmlv?=
 =?us-ascii?Q?Y9lH9HaXh01JOB1GAQHNxFdPomT+Cy2wHOe6cacGR8ZBw/bx7iG8G5WXhxue?=
 =?us-ascii?Q?TIY+IeDoNkBDX4Ivk9Zovwd66UydLKtuR3WX0qJXs3wn9t07Tk+j/siMEHi3?=
 =?us-ascii?Q?TGb6pUNQGNLZUed4fhybqoGPAo+0jDnOuSNaPLL1hfXJKTWQO4OhLN8PSzGO?=
 =?us-ascii?Q?DUaD0kwP1fCjwGB7BPI7F3PYZO505JJ5YNihhc5z10oBWdgf5XV+okfiiRW/?=
 =?us-ascii?Q?/seGEjW1KacdcQ9Ja8KHaWwl4NkZx+MU/sDUlTVWza3dWscTstg4?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c432c654-64a1-4a4d-7a4f-08df0cebc71a
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:50.7808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62zSTLwxSuvClwbJ+oD+QmbKp5hawb3niEtvj9VcamfG9JF1X1PGw7aBWRqOqlJ8SK961RlS5PNAJaF8RuBCdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

A caller can read qp->active before teardown clears it, then schedule
the RX tasklet after tasklet_kill() returns. The MSI handler does not
check active at all. Teardown also releases DMA channels before
draining the tasklet.

Protect active updates and the check-and-schedule sequence with
rx_sched_lock, including the MSI path. Clear active under the lock,
then drain the tasklet before releasing DMA channels or queue entries.
QP link work is already disabled, so it cannot reactivate RX. Use a
separate lock to avoid contention with RX list operations.

Fixes: e902133162af ("ntb: stop tasklet from spinning forever during shutdown.")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 50 +++++++++++++++++++++++--------------
 1 file changed, 31 insertions(+), 19 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index d009bb5bb54b..0257f3eeb5cd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -179,6 +179,8 @@ struct ntb_transport_qp {
 	unsigned int rx_max_frame;
 	unsigned int rx_alloc_entry;
 	dma_cookie_t last_cookie;
+	/* Protect active and RX tasklet scheduling. */
+	spinlock_t rx_sched_lock;
 	struct tasklet_struct rxc_db_work;
 
 	void (*event_handler)(void *data, int status);
@@ -652,11 +654,26 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	return 0;
 }
 
+static void ntb_transport_set_qp_active(struct ntb_transport_qp *qp, bool active)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	qp->active = active;
+}
+
+static void ntb_transport_schedule_rxc(struct ntb_transport_qp *qp)
+{
+	guard(spinlock_irqsave)(&qp->rx_sched_lock);
+
+	if (qp->active)
+		tasklet_schedule(&qp->rxc_db_work);
+}
+
 static irqreturn_t ntb_transport_isr(int irq, void *dev)
 {
 	struct ntb_transport_qp *qp = dev;
 
-	tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return IRQ_HANDLED;
 }
@@ -905,7 +922,7 @@ static int ntb_set_mw(struct ntb_transport_ctx *nt, int num_mw,
 static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 {
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
 
 	qp->tx_index = 0;
 	qp->rx_index = 0;
@@ -1168,13 +1185,12 @@ static void ntb_qp_link_work(struct work_struct *work)
 	if (val & BIT(qp->qp_num)) {
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
-		qp->active = true;
+		ntb_transport_set_qp_active(qp, true);
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else {
 		ntb_transport_schedule_qp_link(qp,
 					       msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
@@ -1202,6 +1218,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
+	spin_lock_init(&qp->rx_sched_lock);
 	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
@@ -1738,8 +1755,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 
 	if (i == qp->rx_max_entry) {
 		/* there is more work to do */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	} else if (ntb_db_read(qp->ndev) & BIT_ULL(qp->qp_num)) {
 		/* the doorbell bit is set: clear it */
 		ntb_db_clear(qp->ndev, BIT_ULL(qp->qp_num));
@@ -1750,8 +1766,7 @@ static void ntb_transport_rxc_db(unsigned long data)
 		 * ntb_process_rxc and clearing the doorbell bit:
 		 * there might be some more work to do.
 		 */
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 	}
 }
 
@@ -2218,7 +2233,11 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	disable_work_sync(&qp->link_cleanup);
 	disable_delayed_work_sync(&qp->link_work);
 	qp->link_is_up = false;
-	qp->active = false;
+	ntb_transport_set_qp_active(qp, false);
+
+	qp_bit = BIT_ULL(qp->qp_num);
+	ntb_db_set_mask(qp->ndev, qp_bit);
+	tasklet_kill(&qp->rxc_db_work);
 
 	if (qp->tx_offload_thread) {
 		kthread_stop(qp->tx_offload_thread);
@@ -2260,11 +2279,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 		dma_release_channel(chan);
 	}
 
-	qp_bit = BIT_ULL(qp->qp_num);
-
-	ntb_db_set_mask(qp->ndev, qp_bit);
-	tasklet_kill(&qp->rxc_db_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
@@ -2359,8 +2373,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 
 	ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry, &qp->rx_pend_q);
 
-	if (qp->active)
-		tasklet_schedule(&qp->rxc_db_work);
+	ntb_transport_schedule_rxc(qp);
 
 	return 0;
 }
@@ -2560,8 +2573,7 @@ static void ntb_transport_doorbell_callback(void *data, int vector)
 		qp_num = __ffs(db_bits);
 		qp = &nt->qp_vec[qp_num];
 
-		if (qp->active)
-			tasklet_schedule(&qp->rxc_db_work);
+		ntb_transport_schedule_rxc(qp);
 
 		db_bits &= ~BIT_ULL(qp_num);
 	}
-- 
2.51.0

