Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021133.outbound.protection.outlook.com [40.107.74.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25BD1416865
	for <ntb@lists.linux.dev>; Mon, 14 Sep 2026 08:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.133
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789375738; cv=fail; b=tOH7BXrRIaZZoAPRxPt7FJY9EMp40pabzohZ2HLYfZSgIZesRVbuOSGwwryzyz+4V2RGKhDwPx9hdqm84uNkNT4u2TpKm6ENzQaSkonloHmVHyxD1q6t9TkAvWwrevkDJo9AKZYfxsqwVOE7ZKO+shyELyfRrP8rK8saN0YTtYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789375738; c=relaxed/simple;
	bh=Bm6igc0MXhNi2xfH6dqLngZKbktC3AhZb0VTk9OIfYg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Pjg37hXC1sq+dOOkgnTkB4qOCBs5ufdpHy60nplYVDh5ZStkRf4CBjHrWBuOpJScLp5rDKubbvcOl9e6miv1bq9PPWLuC9W1xouFtqA+/AbC85zpfOuziXIrwazLSTTyP+52lf/EA7/E0YqDBJ94hQLWbsrQKxeWZz0i1fFP3VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=XBGzNu76; arc=fail smtp.client-ip=40.107.74.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="XBGzNu76"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JCmN/fdLFIIvxwgm+r/yg2ouKCpqLfN1PYvVdMUCwj5sIFjI9iHdaQ97upJEt+FiJK9ULJ2rFB76q/tokc87kOxm2l8ea5DhfA1TCIG0ccaXlxi16ZTMpx4DPQ+87w7c79iLcpbDOCt90q1cuXPS5QTDhNPKJnTpvhwHT5lZBNLwqnwukQCGmUs8S2ihqSpbO3Ex+1rPYvrkz4lfmt3U3xrZ9epLNwVl/4LCyo8Pl34bAKDfbCwqiHeHJPHsNs2ktH61mtw+3byGI/sHmjjAaL3oz1NbN4i7lKWjr2XImYs/veJdBwU2fBp+74TGCbkJdkkXtcz+2LXfB0wBBJRLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KQXqe6qohQtFrBGyA/UUHmDwrR6Rn99WWy9HU2mExJY=;
 b=nSaYqokSKCoQfu3gvr+Vm1Y/4KF4AnMhFkqMjRGFRYhXYqsoe1reuHwlYa7GCwqiu/DTELukoofhbc0Y5pBOUDRa2OhIZ6vEXTRDm+FcgVr0obIDKH8HtbK+HUZpyazzvMbJfqBREbcPmo9uJGPsJXjrUgsd/9nRULmpQc4vO37zBmx83eui342fr558Yjh0YkO1ZC84eiC+r5y/jINL//VXycc7CnBsVj27yQ1GgDo3RaQtpqDittlKHuDOe8+8wwwr+6/W2rymHP95J1Oj5RlLKIBQ+bV1ihvAHBLCpqS+ttrWZpMKiAxmYzNDBCjW1K8TdY4L6oezKiZdZjNBug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KQXqe6qohQtFrBGyA/UUHmDwrR6Rn99WWy9HU2mExJY=;
 b=XBGzNu76uXpAuQjUyj9sNYp7/iY83RRVo1TwmVwfycaHZHcdINsyH7LUjMZVkfw5sWWgKF+dDztHjrBFpQzXU05Ie7RqeOfQlIxk0SEumizEW4TMl/1+VvBO2B1V9xXlqsMD2o+L6M3RM1qAzAI4nbKCFMUQaXdmbKWJSrEkJnw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:325::11)
 by TY7P286MB7153.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:326::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 08:48:47 +0000
Received: from TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9]) by TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
 ([fe80::cce5:2aa8:53f9:dba9%5]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 08:48:46 +0000
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
Subject: [PATCH net-next v4 05/10] NTB: ntb_transport: Exchange client capabilities at link-up
Date: Mon, 14 Sep 2026 17:48:33 +0900
Message-ID: <20260914084838.2158249-6-den@valinux.co.jp>
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
X-MS-Office365-Filtering-Correlation-Id: 2df1f887-c6a4-4c4b-1dc2-08df123cfcdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|23010399003|1800799024|366016|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	pZDeO/j3rM05LHy4cM8PCZdXl+7OnqWSTxTgJBiEOXYE6+SjxlMpwZ8RqWw1glxdqtTLiBuL9PimOlcP6m/XLVvAvLrPxEQ5kQiKSLvR1z4Scz8XOEoOKKXlWbv+MDyC5n6Z5zDjWqF/nHL7cj9G7nb2iQZ8pP6fhuxFp/wfYE56AFeg+G1wQi2Mp32r2X+wQ8UMLVoEmNP4ZpBR8atLwwv4hhwcXlV79H6TDk8aQ80l6AcExtu6HojtSsWn5RSo22+kn008rl6xDZ++Cg6meGbq6DYWn4GaU5u+bKE1dqYS1t3WkLT8WHOjwU9RN+mJc7V9hpLcqMNiKUDcaXt3O/OpwW3Grk0CHHlfUGRQlTd5grplSqZ6EC1XY05vJ9w9mbiF5qxEvGsdl+Hy93PL/WkxG0UH1L4tiU8gkfKVMMbrWZ7vqF9tLiu39aIDq6DdwGrOVQ/SyCXKEY7pDut0RWMpvYm/plfOlS++aZ+JpFhobHug+wwQDn5X4gPlt6ro3XaFd/EnqBkLjUVTwjvN9t+yK0oOUvt6n+DQfISR/UODiMnmdZSLrEKqQ0umyGaovVwpaIYM3uLDPQ5EKdj3kfE1ziWkyjbSxhjE9AId3Zc1awc2mQ9WqiP8BptqWmmOJ3P7BBb0I7jgHqbJh6lEoz0Wp2xmvcItZnLNCYz43EE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(23010399003)(1800799024)(366016)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nc8XgnmYHRqjaZwSJwLFnAGL33nh8X9h+rdNALtz2JuNy5vAytkmrkTs2OSf?=
 =?us-ascii?Q?vSftFGzSMAp5gXGG3+AhsVMYWCopujFKK0Eht7UpAEO6RyP+F/tyn0I/lc3u?=
 =?us-ascii?Q?X4hJOvH8VwZEEfgq+ZsXk6u+o5w1hSSecyFciYpFBlE+KTicSIUl4lJuM/p2?=
 =?us-ascii?Q?6jmPuuXDjjALUko+8HW+eekQBCgDla4Y5+6Jhxp0eD+vx4mwnnVLVaVMpfB3?=
 =?us-ascii?Q?4A7q2gmo10yIvOTqrI4NPY4AM6qIlSI7kN5H+JM34ijpxVJYSB6PRKfko3o2?=
 =?us-ascii?Q?D16DJu76MMwoBlbBMfffT5a//Y3F6I4YObnkiM5d5yOkGbiKbIappm0veZoK?=
 =?us-ascii?Q?5jts8656Pt7EI1SU9g/TL1y7WW6y5vikKshiXf1eysPjz53HSP15CpLk74BO?=
 =?us-ascii?Q?dpWRHNMYC2Mnp7FMjKUIu6R++fHwpsfr85IEL1bnIqgBvLKzJqZwGbbKHueg?=
 =?us-ascii?Q?y8wkoXmjku6m9tEoqVqV5tLfwZp6EXzCg9Za+Q+udsIOfvQ4Nog8jE4vvyYT?=
 =?us-ascii?Q?T7ztOxxgAraCm9+ndyUtjbvt9p3gJAaTTBwNiS69twU4ADS+gEyMHiFqTifr?=
 =?us-ascii?Q?KHOg2NaxGhyjHXhMV8mMj4T5W8hEFj8rfS4kkc81FlBBwtGS7jc1Dxmtpqbh?=
 =?us-ascii?Q?F7xBKIK9pK2HqgZvLNsUrnLnTicbUlvj10JLQHjR755kEiihJhudyNnbI0Y0?=
 =?us-ascii?Q?LOesDTQc1AdkBpthCY/gVQ789K7uDxVzmxh5x5jK7zgjnEH8RwqP4i5d4jaH?=
 =?us-ascii?Q?i5lthzwCCTyno8t1cWyl1zt57tUoxQWvB2ILhRXS8kKN2d9EgViV9/45P7I3?=
 =?us-ascii?Q?HcqpoeqV+zKjjBu2ILtbWcgOD6sBn3GrO0ryeMuxrqZ9Vj1EyLzqono3gSWt?=
 =?us-ascii?Q?MxaCzqyQL8osKAL+2TCHhJbUiziX3qWQ6mb7D3IujtbCm/GrRsclXLX7g97n?=
 =?us-ascii?Q?PyrpfiI08FfBm7g1XTjjzrE2dzsKMy6q8UY5M+OGiSbv49KD0S4+TJ2RmBha?=
 =?us-ascii?Q?PV1jRn7zZraPv4Ww/DFzgNUV9DxA90ougg0gWGSYu2GK6VY9z0sIexlhRIb9?=
 =?us-ascii?Q?Mba0W+XzaQQWgp0eLHX8wsSEOidJUa4WgDLz9peiFeziexdPB4m/ZbHdbDOc?=
 =?us-ascii?Q?BPXh65PYOjSeSMX07qb4Ndca+8S5KfuI/EPKFp0GYi/Q9qFNArWNip3IjscH?=
 =?us-ascii?Q?XjoTevHZ/G4UvoCSr1Tq0pwMjcBWu61Mhr4cDwffEfPmaIyWSQpiYShGCHX1?=
 =?us-ascii?Q?/NdoBtt5KxVbp2CS4RFEYBQitRO8nuiptSEQV8wF73o8LuIztFIFuAX/X9hK?=
 =?us-ascii?Q?LafximMlXp643dx8Q5BvOPBv2tEtDsNaHy+ZRjxpN67WxxBfR5BX3feXQt0Z?=
 =?us-ascii?Q?hH/TiTdyNJZTp5o3maLHf5W5q8Hvs8Vhz3Q2bHfAXaTlmBcab4AoD6cnkajT?=
 =?us-ascii?Q?VtelhfvIalUlhmqwFjSyhpo3Q5jllQUhluRS2sSwmYJcFOrZUNEP2RBXi4wW?=
 =?us-ascii?Q?F1E3aQzvhtz3OF47va2IpSczGKELVHcy49PDkeEGf6stfgGv0MAeHOn4yrvW?=
 =?us-ascii?Q?kdE1udfcB36apSFPrO6RQYf7yDh1C7Or/rksxED3zAVh6mv6wezpE/33tmhK?=
 =?us-ascii?Q?/rcEBYCVBmCaFd2K95MT4KEmongX+AG9t5+XtloBWQOynw/TqqJSPOViaLD6?=
 =?us-ascii?Q?h9Z5ecyyLCPgoWdLxkZj4NCoUzng9NV90+74m58MqRzy3oa7GIM5zy28j8YU?=
 =?us-ascii?Q?lKDmksBKQTS9AP43xKj5EMP7fEKqjDJVr50rYF5aQ9fqN6S5flkW?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df1f887-c6a4-4c4b-1dc2-08df123cfcdc
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB6866.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 08:48:46.0597
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9R9NSGuf71imX0zDM+FqkJ/Jwpa78NX7ZPivO1oVYqAhnZsVl8NxJ/mxIgKZSVIb6lSnjYMa4LP0/1WKn8RRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB7153

Clients need to learn peer capabilities before sending data. Exchange
opaque 31-bit capabilities during QP link setup and pass them to the
client with the link-up event.

Use one scratchpad per QP after the MW sizes and MSI descriptors. The
top bit marks a valid advertisement. Write capabilities to the peer
before advertising QP readiness. Read peer capabilities from the local
scratchpad once the peer reports ready.

Clear the local capability scratchpad at probe, not on QP open or reset,
so early peer advertisements are not lost.
Withdraw advertisements on link-down. The existing transport link
cleanup clears all local scratchpads.

The transport version 4 layout is kept as-is, including MSI slots even
without local MSI. Report zero capabilities without extra retries for
legacy peers or QPs without spare scratchpads.

Adapt ntb_netdev to the API without using capabilities yet.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v4:
  - New patch to address Sashiko's feedback:
    https://lore.kernel.org/r/xsaocp32a6siggahziu4jqbwgmdasmp6v64pd5aujfkoxhiqws@n5luestlntzc/

For reviewers: we could also protect qp->client_ready and qp->local_caps
with ntb_rx_q_lock. I find the current approach easier to read, but I'm
happy to change it if preferred.

 drivers/net/ntb_netdev.c      |  8 ++---
 drivers/ntb/ntb_transport.c   | 60 +++++++++++++++++++++++++++++++----
 include/linux/ntb_transport.h |  7 ++--
 3 files changed, 62 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 7a0d5e892a1a..869fc9a7f9e8 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -101,7 +101,7 @@ static int ntb_netdev_queue_rx_fill(struct net_device *ndev,
 	return 0;
 }
 
-static void ntb_netdev_event_handler(void *data, int link_is_up)
+static void ntb_netdev_event_handler(void *data, int link_is_up, u32 peer_caps)
 {
 	struct ntb_netdev_queue *q = data;
 	struct ntb_netdev *dev = q->ntdev;
@@ -346,7 +346,7 @@ static int ntb_netdev_open(struct net_device *ndev)
 	netif_tx_stop_all_queues(ndev);
 
 	for (q = 0; q < dev->num_queues; q++)
-		ntb_transport_link_up(dev->queues[q].qp);
+		ntb_transport_link_up(dev->queues[q].qp, 0);
 
 	return 0;
 
@@ -430,7 +430,7 @@ static int ntb_netdev_change_mtu(struct net_device *ndev, int new_mtu)
 	WRITE_ONCE(ndev->mtu, new_mtu);
 
 	for (q = 0; q < dev->num_queues; q++)
-		ntb_transport_link_up(dev->queues[q].qp);
+		ntb_transport_link_up(dev->queues[q].qp, 0);
 
 	return 0;
 
@@ -538,7 +538,7 @@ static int ntb_inc_channels(struct net_device *ndev,
 
 	if (running)
 		for (q = old; q < new; q++)
-			ntb_transport_link_up(dev->queues[q].qp);
+			ntb_transport_link_up(dev->queues[q].qp, 0);
 
 	return 0;
 
diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 0b47285ef48b..ea89eb336472 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -145,6 +145,8 @@ struct ntb_transport_qp {
 	bool client_ready;
 	bool link_is_up;
 	bool active;
+	u32 local_caps;
+	unsigned int caps_spad;
 
 	u8 qp_num;	/* Only 64 QP's are allowed.  0-63 */
 	u64 qp_bit;
@@ -181,7 +183,7 @@ struct ntb_transport_qp {
 	dma_cookie_t last_cookie;
 	struct tasklet_struct rxc_db_work;
 
-	void (*event_handler)(void *data, int status);
+	void (*event_handler)(void *data, int status, u32 peer_caps);
 	struct delayed_work link_work;
 	struct work_struct link_cleanup;
 
@@ -282,6 +284,9 @@ enum {
 	MW0_SZ_LOW,
 };
 
+/* One per-QP scratchpad, with the remaining bits owned by the client. */
+#define QP_CAPS_VALID		BIT(31)
+
 #define dev_client_dev(__dev) \
 	container_of((__dev), struct ntb_transport_client_dev, dev)
 
@@ -937,7 +942,7 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
-		qp->event_handler(qp->cb_data, qp->link_is_up);
+		qp->event_handler(qp->cb_data, qp->link_is_up, 0);
 }
 
 static void ntb_qp_link_cleanup_work(struct work_struct *work)
@@ -1141,10 +1146,19 @@ static void ntb_qp_link_work(struct work_struct *work)
 						   link_work.work);
 	struct pci_dev *pdev = qp->ndev->pdev;
 	struct ntb_transport_ctx *nt = qp->transport;
+	u32 peer_caps = 0;
 	int val;
 
 	WARN_ON(!nt->link_is_up);
 
+	/* Pair with the release store in ntb_transport_link_up(). */
+	if (!smp_load_acquire(&qp->client_ready))
+		return;
+
+	/* Publish capabilities before QP readiness. */
+	if (qp->caps_spad)
+		ntb_peer_spad_write(nt->ndev, PIDX, qp->caps_spad,
+				    READ_ONCE(qp->local_caps) | QP_CAPS_VALID);
 	val = ntb_spad_read(nt->ndev, QP_LINKS);
 
 	ntb_qp_up_request(qp, true);
@@ -1154,12 +1168,26 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 	/* See if the remote side is up */
 	if (val & BIT(qp->qp_num)) {
+		if (qp->caps_spad) {
+			u32 caps;
+
+			/*
+			 * Order the readiness read before the capability read
+			 * for memory-backed SPADs.
+			 */
+			dma_rmb();
+			caps = ntb_spad_read(nt->ndev, qp->caps_spad);
+
+			if (caps & QP_CAPS_VALID)
+				peer_caps = caps & ~QP_CAPS_VALID;
+		}
+
 		dev_info(&pdev->dev, "qp %d: Link Up\n", qp->qp_num);
 		qp->link_is_up = true;
 		qp->active = true;
 
 		if (qp->event_handler)
-			qp->event_handler(qp->cb_data, qp->link_is_up);
+			qp->event_handler(qp->cb_data, qp->link_is_up, peer_caps);
 
 		if (qp->active)
 			tasklet_schedule(&qp->rxc_db_work);
@@ -1189,6 +1217,12 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 	qp->ndev = nt->ndev;
 	qp->client_ready = false;
 	qp->event_handler = NULL;
+	/* Reserve MSI slots even when only the peer might use them. */
+	qp->caps_spad = nt->msi_spad_offset + 2 * qp_count + qp_num;
+	if (qp->caps_spad >= ntb_spad_count(nt->ndev))
+		qp->caps_spad = 0;
+	else
+		ntb_spad_write(qp->ndev, qp->caps_spad, 0);
 	ntb_qp_link_context_reset(qp);
 
 	if (mw_num < qp_count % mw_count)
@@ -2409,15 +2443,22 @@ EXPORT_SYMBOL_GPL(ntb_transport_tx_enqueue);
 /**
  * ntb_transport_link_up - Notify NTB transport of client readiness to use queue
  * @qp: NTB transport layer queue to be enabled
+ * @local_caps: Opaque client capabilities in bits 0..30, unchanged until
+ *              ntb_transport_link_down()
  *
  * Notify NTB transport layer of client readiness to use queue
+ *
+ * Exchange capabilities before reporting link-up through event_handler.
+ * Report zero peer capabilities for legacy peers or insufficient scratchpads.
  */
-void ntb_transport_link_up(struct ntb_transport_qp *qp)
+void ntb_transport_link_up(struct ntb_transport_qp *qp, u32 local_caps)
 {
 	if (!qp)
 		return;
 
-	qp->client_ready = true;
+	WRITE_ONCE(qp->local_caps, local_caps & ~QP_CAPS_VALID);
+	/* Publish local_caps before QP link work sees client_ready. */
+	smp_store_release(&qp->client_ready, true);
 
 	if (qp->transport->link_is_up)
 		schedule_delayed_work(&qp->link_work, 0);
@@ -2439,12 +2480,17 @@ void ntb_transport_link_down(struct ntb_transport_qp *qp)
 
 	qp->client_ready = false;
 
+	if (!qp->link_is_up)
+		cancel_delayed_work_sync(&qp->link_work);
+
+	/* Stop advertising capabilities before withdrawing QP readiness. */
+	if (qp->caps_spad)
+		ntb_peer_spad_write(qp->ndev, PIDX, qp->caps_spad, 0);
+
 	ntb_qp_up_request(qp, false);
 
 	if (qp->link_is_up)
 		ntb_send_link_down(qp);
-	else
-		cancel_delayed_work_sync(&qp->link_work);
 }
 EXPORT_SYMBOL_GPL(ntb_transport_link_down);
 
diff --git a/include/linux/ntb_transport.h b/include/linux/ntb_transport.h
index 7243eb98a722..685dde629a48 100644
--- a/include/linux/ntb_transport.h
+++ b/include/linux/ntb_transport.h
@@ -48,6 +48,8 @@
  * Jon Mason <jon.mason@intel.com>
  */
 
+#include <linux/types.h>
+
 struct ntb_transport_qp;
 
 struct ntb_transport_client {
@@ -66,7 +68,8 @@ struct ntb_queue_handlers {
 			   void *data, int len);
 	void (*tx_handler)(struct ntb_transport_qp *qp, void *qp_data,
 			   void *data, int len);
-	void (*event_handler)(void *data, int status);
+	/* peer_caps is 31-bit, zero on link-down or without peer support. */
+	void (*event_handler)(void *data, int status, u32 peer_caps);
 };
 
 unsigned char ntb_transport_qp_num(struct ntb_transport_qp *qp);
@@ -80,7 +83,7 @@ int ntb_transport_rx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 			     unsigned int len);
 void *ntb_transport_rx_remove(struct ntb_transport_qp *qp, unsigned int *len);
-void ntb_transport_link_up(struct ntb_transport_qp *qp);
+void ntb_transport_link_up(struct ntb_transport_qp *qp, u32 local_caps);
 void ntb_transport_link_down(struct ntb_transport_qp *qp);
 bool ntb_transport_link_query(struct ntb_transport_qp *qp);
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp);
-- 
2.51.0

