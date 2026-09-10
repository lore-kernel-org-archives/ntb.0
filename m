Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021076.outbound.protection.outlook.com [40.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B7B3B058C
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013345; cv=fail; b=Uh0oLtzioeBQ3jIWYOsVfRrlZ/BrRfziTJHNPmqlMWC4LbU2jFWlyOUKhWUXGx04v7Yz1vy+EvX+HrQaReUYKgs17MwqCWqoIjiyMHO3Wdu62KtWVMoSG7peFAkbifwlsqqxiELT633qSD55bv1zTciBgh3Ftm98b1nSeWMCsNw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013345; c=relaxed/simple;
	bh=+SNxzDvgqTSe2uUtf62AvEH3H2idtwSRRLFJZLMxZoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UmL/lrw5/Y9wO8z1cvtxsFflr4IF07P9+I+bhZlz/KkOUReipA653I9X97K2UGHsKUNf3qUIBueSPY572n4p20nTKpE+aYG1tr3GY84r28GKxrUVCD4cG7ij+v+qUSDDSrJkiZ3hIqvvBs4uHSK/LnrDrtQmT8Yajy2RB/HMUoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=qcPbfNXo; arc=fail smtp.client-ip=40.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="qcPbfNXo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l4uSz/3Mf6kl/WkXqRtTiog0ZRrACtgQWvl51afXqaqNhb68T5X2ElLM36BpXqT64lwkWsYe+xjeMhgpMZtgBeiO4nA9hYxg6/zCQCiML8Nxg9c6kVuqQR0lh+76Vwa1K2DuBIAqWrynme4dBYrnr2EzA7tTOwRFlW3YQZaTZultH8Y9o8heVQbt5C7BS1e4yV3wEu8/kksMhY0jlojpivuR9JoeRNLGaarLyycDwjQpWimEfwvZ0jc2wSBqPh27jm2xHjyTfxxTpDV+G+PfMbQ9hvccqnnutFJOL1iAVVqMhiJHTN4JEKyiSc0T6d073MWQi5EoDYESRPlrvu9F5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o/rRMJlP1sSkcj6d13cGOj728+KdjNney33StJuRPi8=;
 b=fSvAMtNyZZdgRgMMtgHOlkNpMaU3CqQc3ukCEgvDBGQ3I7uJngKm34U54ZfDT3Gkh8mSmw9ClywEGWb9kyowuvUgqd228l/xNgZWReLSACVZdO2fAZ3/QJqbF22tmrIesBZsWaYSuJlV+pZ6W+EDzpTsPhEBzKnxEvRfAgh7e9ymh7aLcMQ8XfvQt7AmHvb2PAJVe1YteXf9wNiYXWlNlEQ3vQvmMh2a7V8kxEE+1IQYQtQedlrpnCvIfaJkodXG7x9KfDsYDh1gbIb77majcv2sksULDs2dD8k6EvVqzL/sx5yPBx8e5xFhYGqf51W2uxJP7Eff/jkEUAj3yhSMeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o/rRMJlP1sSkcj6d13cGOj728+KdjNney33StJuRPi8=;
 b=qcPbfNXoVu0XyNjFZYu9Ki4gKgyJwUS+h+IfP+bTkQ6+HjWoTEJk8tCtIUlw/VeuOs1aXCWqdAdxCjafqzUgWg2QH8M4aPrO03Y1ELLLj6gkOPUsg62sbmKqrEkythsAWjW/ebfZMJFvlMkpSdmqMVszAhzVQWOjZEjp/rNj4SA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6619.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 04:08:53 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:53 +0000
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
Subject: [PATCH v2 14/14] NTB: ntb_transport: Remove clients before freeing transport resources
Date: Thu, 10 Sep 2026 13:08:36 +0900
Message-ID: <20260910040836.3792333-15-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0031.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::9) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eed8996-93c8-4ae5-ed61-08df0ef13a2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	aXwqMp7ZevMWfSPyTDJitBX8LDbohc6kuVcSOUtO03I7aFcvA0ELC7/Y4TflsTsGsytoZWhbUMuEuFyNu6u8XNXG4fIoitHUaqSJawZlgHDy33qLEGUfbgrmOX2LrdMmJo+dsqCWFCbVW3XmW0sqHPiizZ7Oo8oZPwq1V5Y8Yr8H6q65jWdX6nURgXre18Zyh5TBGB9SIaNm8aGOTlQw2QbdidusMxAyYZBB3ATW/xLSzc7BHTiLUjw7cftSCetX6faZn6GS9FJLM+EGjK1yT1nXUYgNePE6efDxZGPFAqSA3GkZdkmJy3eo85p0RDneJ6vNpLyDsLY1YWJ9LE7SZ3EmTtts4BSvJqS7nuvQVRC1zZZAoOXwKzzqU5bbBUIQ9tqKg1cY4Y0wpAzHhOBZv30H1B5cd5jQ9IDfgNjqa8Uad8gtqOm3wS0LUonTHzXeBt0O+mzznTDscXmaGAh+3tQcSm8pBAkYrrM4zp67fOporZTPaqbMvQnfGXZU7lW7eeBmR2vwRku5WItgWs5S4Qy6qk8Obf/LW5NHHRnayWn+yPALjBmtWEqJ+wIjWohVIbc0QkGClEpgG2swATDGaQQNpaXmaPz0DYmVMIvFqZN8Ik9RRiqFQSsDVa5NqxdNaaAddELKjs+oXddd1WNFzZqPOO6/6lzD/8Z9Vu2poJY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9KZ7dA7qrHI1IA0AMPoOOsdd+5w1pP7cg2vFmToKxtXSbICz9xBa6ueo6bTq?=
 =?us-ascii?Q?xeqCkIkLfqqmW0MjiA2OOa2KskX3kWGDxC/xAwhh/umhOy5ansIufxC/0XXy?=
 =?us-ascii?Q?+0k4ce6pNXw44G4TpexJIzSP1Hkw8Nforu0A/J9MdqjY41dIwyvLP5V/3xaL?=
 =?us-ascii?Q?0NMdn6YNbYsYK5mE/6p63qPZ38CYYaw6+ddMAo6mGkwnVydQIHFfLM87xl7/?=
 =?us-ascii?Q?zZPl/nPf/eWBuIC4cqfxFkgd8boRtKhEeqfMOOIQiGNd5oXljJzp5IwF8xCm?=
 =?us-ascii?Q?6Qu6hIg8TAn9iSB79PhHUl5/4x3RSurdR5zPxhwEDKGQLGGk7WjE/q00lqLM?=
 =?us-ascii?Q?TzXH8IVcjJl/9gDwc73XipNDGEJ1yesH4bQz0goWzCONjegom3Pa/nl06Rtv?=
 =?us-ascii?Q?mozsf0Ym4D5f6sE5djTydyQUC6dRm1nFbT7lwV2Lpj1+lcZ8gEd7YlFZDp26?=
 =?us-ascii?Q?SYq2pCk1lXWF1bLPDv6+SJF7kcRk4BNDfsDZct+s3iaokw+LKpgPP+O8gShn?=
 =?us-ascii?Q?xF4EKcDXq1WxLckj7mABPc76ayBCiy+7DU3t4PVOaj474PggOW6LdExi8WQr?=
 =?us-ascii?Q?4niXmVswx12uohG57jMGzcx2lPo3Ff52qP540JWM2pfsHuQ5EVDtBckdBjKl?=
 =?us-ascii?Q?aX8q6ZgAR6YdqzNYPMzTOUtSYXACmv+3yLUwib1QJ7rrXxR4Z9of590mjLiJ?=
 =?us-ascii?Q?HaH9g2MwdZdMNUZilFDz7UFfHpTnueMjvWXTd2gZCFFUqyTXJ/ejfayv6mS5?=
 =?us-ascii?Q?nf7arCDIpgtc2FFZ7hQBV8S6B5UFS8BipfAbeO0JS717myLHFevpEP3/Kbr4?=
 =?us-ascii?Q?fRgSpMpmUnsGcYomELDfu7vsz081fXkJqxFFvadYD3dtHyQN5VGTTEYZfTs7?=
 =?us-ascii?Q?1q4EYUwoYPQJLnKTO6o2tOCyS4Fmb32yoEjZcXo7gtlvQ0woUgRtn9EL3y3M?=
 =?us-ascii?Q?hPsBaLur8LFLMRqkTiRlkl1Wh6o8xW3UkqOAp5OxpOg3N3CkYX8TzFj5TJ51?=
 =?us-ascii?Q?CuzYlIHjy8kHzbpYDEtWvacYwmW8dtArUvOUnoBaDKCh8MNmM7g2xpyvt1e7?=
 =?us-ascii?Q?lsGwdB9GjdGFkOzpDSV74XQ9I45PqcsQrMwK/M67RCCLJR23g0e8wPUDoqaE?=
 =?us-ascii?Q?qbH8stnOiWJrBm+XM3QIc4dS9xlZrShgR56jK1/3B2l+AT6Si0o89f1oCuy2?=
 =?us-ascii?Q?VOZwsMkA2DiqeuiNKgMO/YPXju5d4pFiHHxr1IiUC7lfBQp+BRohLNJazhvx?=
 =?us-ascii?Q?9CMVK+1XZRgiSl1g28CCRTeEE2ooCxEEdqkeSiktqql2bASbaymEyaYk7DFf?=
 =?us-ascii?Q?P4HkryqyBZ9jl0YPZxWzG7IpcmlYu02NB8m2aPRY8ffUvkhcAEvKdjmVB2jp?=
 =?us-ascii?Q?trJciXcAl8jZAxtIsNC0pvrWRQU7iXQlcrH2gDTTvvmN4Ba69N5k/OLZ0f8V?=
 =?us-ascii?Q?bnfyg3L7xbOeEFcCDWr6oPRXR+GHIvNknzj0fz1Tc6To1VxvcF7n1GH0DjWN?=
 =?us-ascii?Q?MDt76tvVmnUBYIQr2RxfukInykbin08OyDnfrgRaLtOVEASXblWCerjF895x?=
 =?us-ascii?Q?oaLrCXLMNB8YCQKHIAaSrW21RX/W5L3Q+kOV/jV4oextMVph9h02Y4oV9oRr?=
 =?us-ascii?Q?SEat3WKVlRWKe66y/Qzy+nHBNjcFEjY3Dq462+Btb4xcvcciHVFpR/QGc3F1?=
 =?us-ascii?Q?rJd95TsgR/YTjaIHLPgq0U/vpkIfwUpDNBvhJboqGcqgOpJ6YgiW5JcZmu9w?=
 =?us-ascii?Q?CoGL5cGvggXoRTcwlqlBIgJG0YNdGevCba+e/De5PUJncKbLYiF6?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eed8996-93c8-4ae5-ed61-08df0ef13a2d
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:53.6543
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sXvGeDau50lAqrLYj/QXcDhgPSzqODuT4XEXqkDB/Bs8HFHOUiPXynrnP8Ab3E40mCgQujHI/TJo21+PpstPSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6619

Unbinding ntb_transport can call ntb_transport_free() while ntb_netdev
is still bound. The transport frees MWs and QP resources before
unregistering the clients, so the netdev's transmit path and timer can
access freed memory. Its remove callback also calls
ntb_transport_free_queue() on a QP whose resources have already been
released. This teardown order is unsafe and somewhat unintuitive.

The crash can be reproduced with an intensive TX load, during which you
unbind the NTB device. The following is a KASAN report from my
VHOST/HOST setup using vNTB.

  VHOST# sudo iperf3 -ub0 -c $HOST -l 100 -P 100 &
  VHOST# echo $VHOST_NTB_DEV > /sys/bus/ntb/drivers/ntb_transport/unbind

  ==================================================================
  BUG: KASAN: vmalloc-out-of-bounds in ntb_transport_tx_free_entry+0xf0
  ...
  Call trace:
   ...
   __asan_report_load4_noabort+0x1c/0x30
   ntb_transport_tx_free_entry+0xf0/0x130 [ntb_transport]
   ntb_netdev_tx_timer+0x78/0x260 [ntb_netdev]
   ...

Disable and drain transport link work first, then unregister the clients
so they stop using and release their QPs. After that, free any QPs left
over before running transport link cleanup. Disabling the work keeps
link events from restarting setup or cleanup during client removal.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - New patch.

 drivers/ntb/ntb_transport.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index c1e3a077c45e..f24555b38d1b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1487,9 +1487,11 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 
 	debugfs_remove_recursive(nt->debugfs_node_dir);
 
-	ntb_transport_link_cleanup(nt);
-	cancel_work_sync(&nt->link_cleanup);
-	cancel_delayed_work_sync(&nt->link_work);
+	/* Stop transport work before clients release their QPs. */
+	disable_delayed_work_sync(&nt->link_work);
+	disable_work_sync(&nt->link_cleanup);
+
+	ntb_bus_remove(nt);
 
 	qp_bitmap_alloc = nt->qp_bitmap & ~nt->qp_bitmap_free;
 
@@ -1500,11 +1502,10 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 			ntb_transport_free_queue(qp);
 	}
 
+	ntb_transport_link_cleanup(nt);
 	ntb_link_disable(ndev);
 	ntb_clear_ctx(ndev);
 
-	ntb_bus_remove(nt);
-
 	for (i = nt->mw_count; i--; ) {
 		ntb_free_mw(nt, i);
 		iounmap(nt->mw_vec[i].vbase);
-- 
2.51.0

