Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020135.outbound.protection.outlook.com [52.101.228.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 521FE3A6EEC
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013333; cv=fail; b=ecs1G3srOk0M8OLaAimed91HirH6ncFNpnzHVGnXeFCP0glhtrxlLJWyW6IdXWGH5KUY2lLtsfYS+aXD13+FwuG+vU71TP2rX+SB6Fvwj+p+BmXt4WTdpPt9CoWU6FINB/AqOmVzCaKOYPLhPa/vlH8tNN8pbgGO2MT7ktfv8II=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013333; c=relaxed/simple;
	bh=HgTbdwNnt0dlN5O5w9Rc3Hjcg2H1GcsV0+cbOBnvj5w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZnbnCE2ViJ4aMjTJvGkTl4OXfanvvJ/jIYvqo6mRd6ruCTDaXm0Ivpx1h3dBMzi62ScQt1H4s75LTGAc4hvz0VjdgRwg78ROlp5GwqIppHW+euIhYPDyV9kSn5vlZPmFo4Ix4ez2OlZvA5ViR//Y9R2sjpA5qoTyzzz/CoyriAY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mjOcxpvZ; arc=fail smtp.client-ip=52.101.228.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mjOcxpvZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NH2pEgoUey9hHSchhpMbZdCGs5dCc6fIo4Ywo35Mim1pExoMOruRfCaDEX0j2j601ryO0536vgojeJodR4ytU76MMaJq5yJSGOzoS2eGYzbyMrJhMf3qvTONdgF0ZKoeHyEzDjhI7IodWEbyO7tQSmktOKSrD9muXDjW/ChQunqPsv8628gy2WiEj5jOsWaIK3B8Vm+I/RMG8usijAFQehiW4TaBP7lz7auVZr8A/h5O4xIa/lrRNRqDy6jHpGQuEG66R+0KpCUqiro1q5b9XPsNh1+f4lzMnmyA6ytO+P7i1JL8NwBcnL0O4qKd2qqJ6oAF5mDkA9CFnhKEsQys8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLeJQA+Mx17INZy3AFPfCVPNKqYv+O0vm7zGyiv/OIM=;
 b=QQsgFQt3ozriSbLZmv+h4qNsespKr7ILeJaD+EZx0LMhItxFqRAbnMtV4ciJ/Uhh5epQ4in6LtRA7pnlhXpcW0pE+i6cACccK7lZYaMWxwY9YGrn9JygsrNCj3UEb4L+7CuHOnmdVH6+TCiWduvdRWxFgZkhdSjyIn62qo0XbmsGigOOE43uA21428t3ZAyU4LW3XK81QnyYeeKhI9g8TboGRD3nRf2eOr7t+ZOPfqrkCk9QyeWG7HJ0vqb7w/6Covz1a0cNpVlW1xsRmO4t3pD11fmKWtRSTjKb+S+nV5WKjlOev4LaW0YZ7UUJibRTSeCTx3O5h0EKVFtKFLTjJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLeJQA+Mx17INZy3AFPfCVPNKqYv+O0vm7zGyiv/OIM=;
 b=mjOcxpvZPinGgWRGWsoHC1owjVW/FOH059XSo8+KGLx1Zf3zwMm8ujNtYp5miNsMeqebWzGAwyishhQM4Le5NAYpJgaZWFSuSdFwXHgAEY5BkXND6YPYVWXVgpavuV2HE41s3dXHgOG7dK113PgU0kgwIjM/GPjEdFuAl6+w6KM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:43 +0000
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
Subject: [PATCH v2 02/14] NTB: ntb_transport: Start TX offload thread after queue setup
Date: Thu, 10 Sep 2026 13:08:24 +0900
Message-ID: <20260910040836.3792333-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0213.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c5::19) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: 89ad3305-c0ff-42bf-aa16-08df0ef133ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	sgZLxTW454gWdyD3/8ZashMCZF2zB4hx6dJM/qSnVpnSpuY5fwzCm0zohrrD1xBoEKamwzLxnx1j8lcFKDYOXfADIe4JnsQN0ksx4RH0GbW/8qgXiff9JK8Nvd3xHr7zuGKdHBt9a8tnU6iz9KUxxRKJMDVLeGv6vF0EhIKEDPtjnxmhVqxPTnKq7AyyXmbHm1tBWb3gMU+Q6rEF5cxWHZl4kJqMZEh5x7qbaEDjmVD3w4abWyOPNtVYTpyHDATnc5SYmB/ppORHybdLzqzSF61JjcyjN4YYJ1jRlJXyt3EGZxzcAJZjQ1YJEsQ+BoS6wVVOkKoQUZI4XnzhO1wjWsN/EEwdolZc4YDodSSwvL+vSWunGe6KBzuVSPW3bjDwZcH2BiyqCtaB4rHRqVeqxRYlLL1K9Yio6lzzE4dhoMW8OKr6dx2XBoS2nfKUCcQvW6K7xDYtEBfUZNfh3lI5BSZ7yIoxqPT393QMqMEHYfuMteH4PkY+S9cnhH5C3GTvCxXzF0s8YKAsDSuycZ4oMmRk+r2xNSkXwNUeZ88g2rX6lK5nsQ9EL+OW8vBfXWw6CuToWpOVxKJ4IFRDlyQbx+oUtWb/UZChyVgzLF1XeCA5q7Qpjuh6+ijDLe/ytlBV
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tjp9OLdVKgtxY3JbY1OtuKo9/2zVSqt4Fa8facgZu76m+P1uDWej2KsLpBsS?=
 =?us-ascii?Q?+4xUhmEId/lbqb/lkXiCnmksC25qEdCDLRAF2pDJUqgjERk/7MuyFI6eWxyL?=
 =?us-ascii?Q?4n46rr27mGONxHsnZDMAs0J0yarADRpcDz3eMXvB3mPyj2zXZVZ8gtPO9/AV?=
 =?us-ascii?Q?4ctOYgm7qy/WwKt5c9gkevZAk9uw+mSNsQC+5TNBvrzDBIo9ZRe8l4++nCW0?=
 =?us-ascii?Q?0CzgVP5O7ldyczRjdKf4KQAF8FlGEKwLGuL72lyaTAW9rtM6Q5HLXx8OgAtf?=
 =?us-ascii?Q?R1rlzKL33xWsq8iu61NBxdtHlSn1Qsh7TrxslnKf0jNPLLIYG9a57NtM44sa?=
 =?us-ascii?Q?j0LeFpMrTBxn5s4bmXls7uw8ZoQWdJP7Jdax5eTS+Sl3p3kvWl4b6KSmRD2L?=
 =?us-ascii?Q?r7NWMmjJXAhlXq2tik2CoJpRPc+kRWJ9lvGWbxRcvXoYSBBsqnCKCT3oiI2X?=
 =?us-ascii?Q?iA6hgBRO7WdjRc6aHkC8lYl0rIXVbAsZybKK1YhUGt5bMPGsnOtE2/Gz5jcS?=
 =?us-ascii?Q?xrNXy1xmKKfIBqA4VCJ5oCgpr/Fx+LEbvaar87nzzaaRHJwgtDKgXD4noMAk?=
 =?us-ascii?Q?vs3vFspiCxQ+OwRdKqVLPG0BjIdrhhKROE3VUaAPJyX/3GP3eufkdB+bylgk?=
 =?us-ascii?Q?BvUE5Yh3DzKmXcHXf+CTT+klVhb5YqPDcs96S+yO2cTjbTix407l7XsgqE0/?=
 =?us-ascii?Q?Tb49SOi2n8+ElqHv/x7NYkRlLONKzC/2guX0LuDjsJZ2xGPbqyGeTcp9Cugq?=
 =?us-ascii?Q?JgWgDZUi8qw0sHa/Jr8mmh6W8+a4PjFvbn93fItpTCOFKgfVgx6b/6/ZpMfC?=
 =?us-ascii?Q?U5eA+n59ZIqShtIihDowyd0tZMobVr8EzQWzibRP1P6KB3mi+D0e0O+s0B04?=
 =?us-ascii?Q?ol8DS76/w5zpL3aip9e3SFwsi7QOaJJXE/CgoiSFKoc9X7bVwYhSnVua77wP?=
 =?us-ascii?Q?UdBZpQ5gDZGUaimzPYrY2tcBCupumbM7sVargjZuGl0Oq3tY5abgk3SwNPBY?=
 =?us-ascii?Q?jxts6+Z5ZX4Q1DDFAdCWBhdskGiefe6qlQunKL9Hzz8WWS4f6LhsftvhGY31?=
 =?us-ascii?Q?e6rxAexskmnacve/9NzR1/uBcTV0HlA6RIwnDac12dyywQrxla2LOqEJKakD?=
 =?us-ascii?Q?m/yE6RXfxGy72DirZjd3vjrrNcMCvqMGvffyRvR1OfOXgriAxgaFpCK49/tQ?=
 =?us-ascii?Q?8pWHUAQOsnDk+Ru5VuuDrIPIbQPpUvVk37UVr2ipUztaPSBH2VtlWJkMh8AY?=
 =?us-ascii?Q?SeF9HYkYoLD9OE/YbFoBIL5sUkByxTyCLt7z2c2hwAhvTCqHkjGMbSgGCUOz?=
 =?us-ascii?Q?4p2Uk8N/edh5a+K/BqDWvohW6QDcZq7mMbpa44BByZq0KwACegPcUgbHYEoO?=
 =?us-ascii?Q?1yZaY9IqfKkf4MNtgzrtiHfEe4j4GU81NFTKw0+k3EohuKcZE+NLelFYjYHM?=
 =?us-ascii?Q?yBFj0hIVQvVCUCW4aAYi4gmy5A4v5Cp3OLUoJrV/QP2zI8oR/gKRbDqCuxVG?=
 =?us-ascii?Q?ft5JwUfwH+HV720TYzd2kwbFd9rWpjkTyMg49MZgyi5FaaR8LY7GJKpRxBrv?=
 =?us-ascii?Q?BJvLWepFiiBk0EzbJlBO2QJ4b9pFafj4OqLFLchm1LTKABJMJLFwCd5Tgpg5?=
 =?us-ascii?Q?K/RdQqLwt4nsg9zkJjjiiM7S58KIEG91mdWaU3pU4MtIyM6oMqudn+1fD3Dj?=
 =?us-ascii?Q?UH3LCSu0L8N4pCsQVTkuKln3zu5VUej0DexObe7nCb66B8RkAwAz3z+igLqX?=
 =?us-ascii?Q?1WQD5w2XqSKp0fDDYAfNfE7TklZso7cxIa0VbQI08N+rKjSG+MV2?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 89ad3305-c0ff-42bf-aa16-08df0ef133ed
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:43.1928
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K573WVc1dv3drLngfXqjO4re+b20jvKSUrdxwe7v2oqdn5xvWnCd8ZjzvMNVRKUzXJE6VsN4FFgRRM4gJmZOew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_transport_create_queue() starts the per-QP TX offload thread before
DMA mappings and queue entries are allocated. If later setup fails, the
error path returns the QP to the free bitmap without stopping the
thread. A retry can then reinitialize its waitqueue while the old thread
is still waiting on it.

Start the thread after queue setup.

Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

NOTE: Originally submitted as part of the direct TX/RX series v1:
https://lore.kernel.org/r/20260810165136.2292436-4-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 3389d6ca9ebd..55a20ae9a85e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -2055,20 +2055,6 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 	qp->tx_handler = handlers->tx_handler;
 	qp->event_handler = handlers->event_handler;
 
-	init_waitqueue_head(&qp->tx_offload_wq);
-	if (tx_memcpy_offload) {
-		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
-						    "ntb-txcpy/%s/%u",
-						    pci_name(ndev->pdev), qp->qp_num);
-		if (IS_ERR(qp->tx_offload_thread)) {
-			dev_warn(&nt->ndev->dev,
-				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
-				 PTR_ERR(qp->tx_offload_thread));
-			qp->tx_offload_thread = NULL;
-		}
-	} else
-		qp->tx_offload_thread = NULL;
-
 	dma_cap_zero(dma_mask);
 	dma_cap_set(DMA_MEMCPY, dma_mask);
 
@@ -2129,6 +2115,20 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 			     &qp->tx_free_q);
 	}
 
+	init_waitqueue_head(&qp->tx_offload_wq);
+	qp->tx_offload_thread = NULL;
+	if (tx_memcpy_offload) {
+		qp->tx_offload_thread = kthread_run(ntb_tx_memcpy_kthread, qp,
+						    "ntb-txcpy/%s/%u",
+						    pci_name(ndev->pdev), qp->qp_num);
+		if (IS_ERR(qp->tx_offload_thread)) {
+			dev_warn(&nt->ndev->dev,
+				 "tx memcpy offload thread creation failed: %ld; falling back to inline copy\n",
+				 PTR_ERR(qp->tx_offload_thread));
+			qp->tx_offload_thread = NULL;
+		}
+	}
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
-- 
2.51.0

