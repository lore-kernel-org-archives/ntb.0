Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021121.outbound.protection.outlook.com [52.101.125.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7B831F9A7
	for <ntb@lists.linux.dev>; Thu,  6 Aug 2026 03:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785986748; cv=fail; b=C8bHT6xTaD7JKhpJE9oFjiGwmfSp6dK3yRk7lUc8O14jRh9DphfszeaPgrNEreShESUEAXMGOh8MHqV0vljU7J13rIFhWSVR/BOFxP3GFHhAAae9yODSBpPrkjch51kgDs4rd9279nlfM+oD5eqko0OLPtY/NHpN0EYW0W+TO5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785986748; c=relaxed/simple;
	bh=dZqMW0jqZicFlmrfGypdQ5hFBlV12KFJkL0x6uuDom4=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=NGA4cpKuBnB/u4LwYvAEdpMZfapNJsV3N+spsia0Ttzoix488q5Dws7m7oM2mOzKZLWFq3NTo28dQGph8Ai3ok2IqgjwpM5tyIcA5AffC16rT3lX/Dk6V2QCI2An4XlE6e5ZMb75fNUzZ5S2aN0zUV1aimIsO/bZxSwLz8aT4X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=JxJpcZih; arc=fail smtp.client-ip=52.101.125.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="JxJpcZih"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flZ/6kxOmqWXb0XFVCw+GkIDNSwOgPy6VcNKd7hzyYD4qEj4wymMnvRh/bbBQeaM3y4NNdi8FHcjPY+BoUlEsdtCbOOyeWxuuHZxpGhXgCgMujmQwKadletpxBfCJFmHpMiekACJzUK4rCMEAuKnqUlwWbLKvAryUtSP9FQjPRzVmqAvGEar2WbKqJEOOiGnkOPCP9WCMn2uJxnJ/E1rTTcDPnujpZasDXwbve6RuhMraBOUKg2YlEvo2ySEIgTQUjXLmQCTG6di7iMMdeUpi29mkEaBhNZqiOiMH3Ngkuu0ITymN2uXK+TqtUnQfDMtJbx+W6C00ItPysjsQxvT1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KjaQwNL2JFe7IYT4GlcSbqXxDuGtoWATREgRceBlvwg=;
 b=Y9MQhVMujMYvGVyrTuvJGyoRwhqf2xsRubB5Z8P38wPPUE+XsKsbjzyu5qlBDSFXqDoHW8dxZdCvSXudRcH5VkxDL+AcX2fAHS45a+Nlrp2EOk/KmTc4AaGlNCgsggtFh+MCXJlgQcPEHh4hm5cicYv7pdfPMLoo3ugYVK86XBb0ciOPNODgru05aKK09oHuTLxsGIf7qya/JmhKEHofbuEy7QC6Mlh7UhzoJtZxiiQSlbApfu54ChD+qnEY9sQOQOYVHlDq8dYf8h2YjD4MDenPMNCNbeGNdysWuhCB2zcThccAFM4tyadOwIP8E+RfYPq9lfaZ9fgm2mcAZl2e5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KjaQwNL2JFe7IYT4GlcSbqXxDuGtoWATREgRceBlvwg=;
 b=JxJpcZihyMDst9ltexGKPAkc38EAiQqkofYk69XFhjU1VFFFBv+0Y4tbry8v099bEZJlldV0s6wEUzcE89upGcsyFlVXe0qYyTGJOCFyd/5nLO6FS/3rHG/vpvRihLrqSh1pDmAb04RIirLKF7Xc1lGT+7k2LDdbRExKP68PO/I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB4042.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:14f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 03:25:43 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 03:25:43 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
Date: Thu,  6 Aug 2026 12:25:37 +0900
Message-ID: <20260806032537.3526498-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0073.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36f::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB4042:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cf99fbb-a3b8-411d-af5b-08def36a6597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|23010399003|10070799003|18002099003|5023799004|56012099006|3023799007|10067099003|921020;
X-Microsoft-Antispam-Message-Info:
	DgCYQGtSUcXmd+d8izYmCfLRqxZ5W6S1ID3XPbBbhjRPuDLYdPaf9X+Ge34JgsxQuAgpGSqFH8J+pPRZKEEvwFk+WOpgIXaooCnmiOj36llttFEl9KxgP7C7FodVuDNGKFpjrYbudCBr64iNv3grrFNzpmHvb1BcRepDB3XinTPiLGQIvtmEnvURliyN754fiGzq/emC/4bQYxTLrFjDprexcfJJiLn6u9AUz0K+L35rbINqe53loZ9FrVDVQe+jirpBbv8YtBfxnDyJyUuksftbm5m/+R85NnBm8A70ZWBIqkN/ehXAsNQgEOOT40Osl826U6mcaxvl1u3jb0lADFW54litx1tJid+Tn/WrFM27tOB2RJ7M4tQB9wIk0BsYiYoOx/S3C6yGO9QWBHYWaiIB9igwoEuFGdprozvNiUVeR2BkBZ4dv/IQPLaUHEWf+hnDJDMu9FpeAGi/edRlyAQThL+flqP6tG6EBlgu6gAyecn/HzcUvFXxB8SRhP02XHTakhhCHpUGSznqCB5dWqvcnt4AGy64fuqk7IRYwVPO6RjCAfuUOJeRfOhwLi/Obb0HoD6gcx9y3LU+wgch/riGMCHdMQHnxsbdjFGrzeCSL0W/BT14PJjiHUKQRkfdi0Fi41CFpDmdH9FIYEcir9fNE2L0sjbunuGuMctWiGDSAobMDgQV9ZJAezkDVLYgxlUWMhMrcf+xoUt/bKg3TQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(10070799003)(18002099003)(5023799004)(56012099006)(3023799007)(10067099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A1+cpenJel04I8fQDHJDqid8PIlW6eclzXoNJIu8cVNtquoUXRbU5HRRpTsg?=
 =?us-ascii?Q?jGqw8Ljey6MQoZ8jb/NuQJk/jrK0J3sCrxM0CEi6wOIP3oj4Ja9AxfHWSyP3?=
 =?us-ascii?Q?zGkJ972qE9rv1wbyNKjIymzaGmck/ZvdRNEdSBBXLtnf6zJsymIqNjzei75G?=
 =?us-ascii?Q?thkzClTJSS9M306bF0/vdChjwrznKT2OhOyDwxSIiCANcpTkG7JYs7mqCoAN?=
 =?us-ascii?Q?IDJKJpt9jaqROtEMisE0iDIuvIL7OmSTgom0UzWnt57p4dsg8peD/kgJgSSS?=
 =?us-ascii?Q?4e5axEGkwLlzfxktZ0+X+GGHTp9yUjo1nuHXKJYgezIt20KyPH6I7wUx5VUF?=
 =?us-ascii?Q?bL9mstnPr3ZxAWUT+p5qwqGVkeCyghk4WqlfqImLPfiIcx5uj3VgryulXDqZ?=
 =?us-ascii?Q?1GnkoVTLJEEtdVYBJCJLik4S1DlC+ewXZwjtk8ItPA5gtSUDpeVTQIsSGGpE?=
 =?us-ascii?Q?G3eFpf6dHEs3Se7JI5V0/dsSoYbusjWkeJiBNKoLSlZ/dAjueuI4KSYkqbX1?=
 =?us-ascii?Q?ZGbKaNEsOY6niBZ1T8v18CQ3BKPts3Usq4CnC0ScjmqeIDJC0VUhgiz/WNOD?=
 =?us-ascii?Q?PXIDmgWfmgyqT9YBq2yNjYsY2t7qWW6mxHQdXL7/hswxZF+YTf7XBfRp+2p6?=
 =?us-ascii?Q?ndGwII0yb5jDCKBGqTkT98gfqz6G/IYubCTcrKJgSqOMSGXP0DBvEf86PQ6u?=
 =?us-ascii?Q?GCJ+CWGALTVjARInBhjYk7V/n0PyIEw4aENZv+OX6mgeJOntdQ1IqEdVTioM?=
 =?us-ascii?Q?wFjP/REianxCZuHcIGU+ZHy4aXWSKuH2QXi9eiWGXjI5WAtCNqY3vm2MPwG+?=
 =?us-ascii?Q?7Ci+jRaayzrdrPP1Phejy0HHm26MziNkM7oQLeZaVardnQNofZHdKiZSdbsV?=
 =?us-ascii?Q?dSa9p4QGhlk6sAt7K8+NBptkmfkdsVkyzycpKS+lYHFAl1Hzi2coyjlwCZ1V?=
 =?us-ascii?Q?w8hXHsm4ii/D1afx587ujmlUGrMUXQtKIi1ER47E4fQCqwxhBObFky8emBEl?=
 =?us-ascii?Q?LvXFl/U5uODjWb5T2wvC+w6r9AC7TtckiaISzOjuD8ICAOwricH+5+UpcO9z?=
 =?us-ascii?Q?tOGANguBwpIjVp7jdTZB+8j69gUqCcX4bema0BUBaKUFalLDkiWrRM2fAmNc?=
 =?us-ascii?Q?0e8Yk6xIq3g6Cz1Ww1nXBxSp7jG6+ZuI9dc91e2ImU9AfHxqi3j1mQtIz4sP?=
 =?us-ascii?Q?VWu21mjALUeedMSsiR7k0eJoAGpglmGbVe+tPFWEC0CV3pcLDFVfqkRhtvlN?=
 =?us-ascii?Q?zj6mkMzgcfIaXNuvp7QxxANWRi1LELfc6PKL6w29dgGdQizsZ9uoI8Ok2uuT?=
 =?us-ascii?Q?o2wcQG7SmdKHuy1RbelQB7o2GkVsds0cmYsVa6fTtP6iKEX6wx3pp8pCs9kx?=
 =?us-ascii?Q?nYm/DilUh81XKTORCCli2fIj0m4Hv9dW1UB19tQGNUVwQEnCvOU+d4l9RLhI?=
 =?us-ascii?Q?8DOCdyjlOBbCJ+9hx0dq1RMExr2/yrYA15rcn/XpiunBOqakFr3GO7/wkjai?=
 =?us-ascii?Q?zZvyqR1/FGxgbuuNoVHWFcOsNzLQDRWgpud5SFA11wznGdczLsD1LzjWDIEX?=
 =?us-ascii?Q?KI4hT07GXXfcXNXn+olHxr2mD/I0u9y0u7MVhdC/MwAyfrH4kxzoKRljzrDo?=
 =?us-ascii?Q?tOA+JvQ+6nZP87feh/zQgULTdJ7e5OPXNzblZ2Gfo/WI4Q1mbdwE8GdxF5EF?=
 =?us-ascii?Q?0UbfLEHFJVMRW6PwtDNbQmZOiZzkWuwfqvcLDFExIYnk/TX2JxVT52cjV3o6?=
 =?us-ascii?Q?uQHicrxq6XnKZGaqUlxBX6Bmcq1cJJ8KszQCxfJmlcdwQsIgKo6v?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cf99fbb-a3b8-411d-af5b-08def36a6597
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 03:25:43.1831
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AZ2hTHNO4ReEgzh948MVl5FF31e4kaHe8/fiPH2vYAJsfKre2Mq/UOvT5U45Ql58J7KDmLcGlat1son6MMGNgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB4042

ntb_netdev_rx_handler() hands the received skb to the network stack
before allocating its replacement. If the allocation fails, nothing is
reposted. Every failure therefore takes one buffer out of the RX queue
while the interface remains up, and enough failures eventually stall
reception.

A retry path could refill the queue later, but ntb_netdev has none.
Allocate the replacement first instead. If that fails, drop the packet
and repost the same skb. This keeps the queue full and lets packet
delivery resume as soon as memory is available again.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index c3a6ba96fc8a..029a4a532a10 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -127,8 +127,8 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 {
 	struct ntb_netdev_queue *q = qp_data;
 	struct ntb_netdev *dev = q->ntdev;
+	struct sk_buff *skb, *new_skb;
 	struct net_device *ndev;
-	struct sk_buff *skb;
 	int rc;
 
 	ndev = dev->ndev;
@@ -144,6 +144,12 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		goto enqueue_again;
 	}
 
+	new_skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
+	if (!new_skb) {
+		ndev->stats.rx_dropped++;
+		goto enqueue_again;
+	}
+
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, ndev);
 	skb->ip_summed = CHECKSUM_NONE;
@@ -157,12 +163,7 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 		ndev->stats.rx_bytes += len;
 	}
 
-	skb = netdev_alloc_skb(ndev, ndev->mtu + ETH_HLEN);
-	if (!skb) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_frame_errors++;
-		return;
-	}
+	skb = new_skb;
 
 enqueue_again:
 	rc = ntb_transport_rx_enqueue(qp, skb, skb->data, ndev->mtu + ETH_HLEN);
-- 
2.51.0

