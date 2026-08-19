Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020101.outbound.protection.outlook.com [52.101.229.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084A04BCADD
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787160352; cv=fail; b=Qyhu7zolirk5VTBKCIiffuvbyljiT7uyFLRPi6ZAnGMqj/4axnEVTDboIHYKoiQLc9dajX7h4V6z8kr1AK2a4loJddBDm4nfTC7Kt5WpjQ7NKJn5NxtItbC2eL0CBQ2QcCHPn+3JjGVEbHA4b2HlW7HIYl0PEbwC+BIr2yfIMz4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787160352; c=relaxed/simple;
	bh=znZSIHczwEfKzZ+mnNTjhYtmPFetH6Tas9TmYgvSDJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KyjUtWbnbLZwHJXnChVp8B/helZoTdqpKsV+IOIRprTtTgP/99oNtqCJXVhTwCebOhmNGz3iJdGQY8EpqeViSTCeXSTgf04W0xRYj7yEwsIvyFtutQxtRbWV48DAVWNg/iou718nScG39IIukO+NZk4X+VM565dx/BI1TIad7lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=mt/J0aJ0; arc=fail smtp.client-ip=52.101.229.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="mt/J0aJ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vSFr7dhCVb6Q9ozPWViVQAcc+rTq9wfHdUzgJPOX4P9I5vOF3DnNe74PfmHwmXFo75Ho+cd2VLUHH5lxzUTmKHPLNFdiROwUZ2x8YIFBKUWPlyF5G6aPX2aQRpnmpUtXqnwU6hkPIq7A0SUJL/vwmEm5YPAuKzBGQJMtAY63lCj5hAgUg31m1hT1NAZYSn/tbRQNcwHnjShe12YWKkv1B9TWEsdNVL1J2wjMt0bKcYBDcI1zLHJoGxjwf2TGTqZhKNckf4M7/1ueIoT7REMvma/0l0MCbZsUVHcCybkgKWaGAEM0sxYLZ2s6eKqXs9hDmUz81kZImiWgJTuHO9bFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J0oLh2Zkn4A/RPEHVfYCENWbIFupfDUjqbDKAxbZzg8=;
 b=etbM0CsOMxAgpcqa60gkoCmTOu6u9c+3E8BGKeTBsaVQ3KY02nHUTOf88KAjbMj1SEeyIEUw2XxHmZ2hk2sq/TEd5fU0W9AxrKtiFZLXpapzrtCzoRyWnx+0WM73qip72g6+LXtFIx0Oe2XChcMorLpd5pcbxi6omfytypqBVwRO8gI4dusO/ZxqpxZcQfgJRpCGFSLxF7c5QOzjvj/12YP2tMPNTjgAEPe1BIC1bGwulvDoYCWED0TagURK6P/cgw3qRj+99yKuuKUpkhfrPWqy3HlOjz0w/QJUb2MKoMaFLIwIxDPM2WNOLbqQpk9oK5ZxzLEr2TAeG5XwSxAKCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0oLh2Zkn4A/RPEHVfYCENWbIFupfDUjqbDKAxbZzg8=;
 b=mt/J0aJ06I0nndq84/EPgvveCt1U8CmEQbVz1sNtxpEU5GETu1ISMQfWDm3nd973qLrUUzvtfUbturpMrDKN4ko0r7wzk9ja1nFLLLZ+kXTm7RKoaOp0CJ+ytAjI5rmIpWgvJSyd9dVy3GQgHaDhC1stvQPAG38mNlna0g0dfNs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY7P286MB5333.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:1f0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 19 Aug
 2026 17:25:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0339.007; Wed, 19 Aug 2026
 17:25:42 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jakub Kicinski <kuba@kernel.org>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net 1/2] net: ntb_netdev: Avoid double-accounting netif_rx() drops
Date: Thu, 20 Aug 2026 02:25:38 +0900
Message-ID: <20260819172539.1450821-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260819172539.1450821-1-den@valinux.co.jp>
References: <20260819172539.1450821-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P286CA0042.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::12) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY7P286MB5333:EE_
X-MS-Office365-Filtering-Correlation-Id: 052f4382-94b3-4748-a461-08defe16e55f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|10070799003|23010399003|10067099003|56012099006|22082099003|18002099003|921020;
X-Microsoft-Antispam-Message-Info:
	xpGHANG2VfA1IorjNA+XpTWYWn/v2/22JCsmYoiJMzfEZhD9ZjbJTrPOia+88bHR1O8PkqcJNS6dYk+Gy7rpXOGdhdfzDrn+QmaZN19uA5E+gYfF74T0iUdVQrR7K9rxsYxVlIK0elln6EfA4k5mmv61byrUDq19AD62CrobHEj0kY4sv8E9MM/SqeJ2gNT9InZWHtQqwPorhX78QBW2vYRRmrF45XblwwXteQf61sP76TiggEpU/eBaSMXdKSRT8BOvn35GsGoeB9SyLckoPsFZjrXCnX6N4d7CbYenmoKob9r39u3BwfM9G4bgt8ZIJUrbcNjTGR7g2lX1L1E2E9VvSgCSjyuJLHRARggcPoyM5iWgdra0uijx14onquvR4dJdFyvinbEEhchfX96j1JADwocpyrxJg0SYwR+Gabr0kleLEv4sJ7IOgDxEiGgeyGsu+eiXGY5wu3cZ4BPerKEzBkidaFsrBYWXqMUkwEaMk7+nnAdyDoXl+VLO3NW3hsGVIZGfQJ9Q0a4Vi725LEyLPqQ+njaazxTwXcBp7kRV4FoHipSrU9Isfl5QdNZSKeTMliY9cDHBB4Qps08guywPmmnAWxny1JsQrpbeWUNV+Q54Mlo75ioJAca/0Hy2+PfBhaTUK5W5a5HK0qTdA9aHIzn/FyRVS0+F9AlyykuCC9CzXbSppv1o4Hk0KOdnDxr6TuGUtUTR8S7Xht1Mdw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(10070799003)(23010399003)(10067099003)(56012099006)(22082099003)(18002099003)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iFOzi7+yTLe7Gn/LkjjfWPPx5j/jbVolq+4tfDKMwuxfMYzZhLBpsuDZb/5b?=
 =?us-ascii?Q?6XAuTvYSA+tAqg27PWrR7Ak0RlTwn2uAlEpdcXW2poKKjfSaLN5xnUdVzAdm?=
 =?us-ascii?Q?vhr6breCQ3zZcT2SLF2X2KBgtoGAUxFum2g0R2gXC985eLzJBeaA0677kiTC?=
 =?us-ascii?Q?8q8dLO66Xm8B8mtqj0DYkQo4LCimB8PKmb6YVWnwLTd7jKtxmufPvbFnj1Yz?=
 =?us-ascii?Q?+Eu0WCXR20NXHrcBWU2+SOHv6qv84/7D6R71mbuFDSrpvZh7u419LDY2AF7+?=
 =?us-ascii?Q?2RTqTjCgyQNbtZ9uKyBwusPnuwIFbtctfUJPcVb+PstjOaAO7woQ7MMFUg4O?=
 =?us-ascii?Q?Um6QQwRUHlXM8wK0rfZ3XnMTh5uQLxQVAe9rMd5XR175UNUZVEVaWPKq11LL?=
 =?us-ascii?Q?nH+bSr/LZKOzaRYCPl0J+RNaxc28F4qobb/cou3QYfnR80UDEOT9YwUa0xc6?=
 =?us-ascii?Q?fJ//jcbUx0T4e4mFULJ/FYgegyEHc38dgn5dSMcfRxQXcHplqtgf/22D9XW6?=
 =?us-ascii?Q?CVYISKJ5Lkr7JWj5+ixrU+DQIJv7AxDLczdPc8n9I/mIuJ0NfiYPQi6wEpLi?=
 =?us-ascii?Q?wdeMrodORf0qOMMMaiwu3N/nTkpW8XBDcFxaNQYr4p+lrnaqDq892QweGKRN?=
 =?us-ascii?Q?BKn0psYZdh1LtzSMZDHzO8c5PYaCrX5Nf0+/rNf/J0soSHz5wvoGppCFC6gy?=
 =?us-ascii?Q?SDnv7LxLjPLa/EhkYDiGokL+0tFi1pvM2HnA7dUqf/gHUQJPlgG/AE08CQ8U?=
 =?us-ascii?Q?SUaaMP6ddgJ2LW/7+CdjhQ0JitXGylGQg7A9v8SXwajL5w+C6ad/WnNnBwaX?=
 =?us-ascii?Q?EPy3jGEanC6vDKB3+7P5ILBr07DqkQqOvXYSU75ALpER9kLI/jfejag2qaAL?=
 =?us-ascii?Q?dJoeXv2sM4QJYS6e3lSGSbzCX+InSOEASDuGml1N5abNkI3jogFwdswEtiPN?=
 =?us-ascii?Q?UewzzTRz1f5RaT9zAFQ7Z3Hser2YwzcAHrX1KKTBqTfnU2YHryYrd0evLXzq?=
 =?us-ascii?Q?2/3o2UFZbxmgr/yStOCxRfDezydqIGrLYcMUezUsLnolQVFgMJlveejEVVza?=
 =?us-ascii?Q?l3kqOPq9K8GtaEQuNIseAx5DqA9yXwq+Z9OCr0HFcrtJJgdXLUvS6wXd6KoC?=
 =?us-ascii?Q?k2HhGglSxJcFA9bXDKTf79VX1X+ib3bYeVqYlN3bEXf073uxnyHtOVnhT+wJ?=
 =?us-ascii?Q?nJB/xmsjnXZgI7Hh8Q9mYdqoWAlonP+nPdCKQnlEUzx8UsggzupI57RmBO3/?=
 =?us-ascii?Q?rPZCEHiCl/G4jxd5POs+uaYeeBmNVJ5rMytvW+32oUug8iMR133bOss368dw?=
 =?us-ascii?Q?CfUKZFUn9OJQYq0yShKvvd+nXq2k2DZ9Izf3c1NxRvGn9i6cOHk+SFZ0lD/p?=
 =?us-ascii?Q?EQwH2Lv1dsi52LmsWkzhf2ESPPK5wBOHuKpmM6HygkQl6Jdk9ltpICGYqn7G?=
 =?us-ascii?Q?zm3fGm7AbX/u6q9WDaZ7JIlrnHHIUyOqHsL339WK+i4hIKgM1K3qtyEJs3PE?=
 =?us-ascii?Q?85BUbnO/QSRYBNnBvEAA714rlq1lJkxRk9Qa2qw4+ioVRrNuCtB6DbKLADYW?=
 =?us-ascii?Q?4iFsrUv2z/qtL/vWH4KMqRCutkgWyoV32oLH37OetiTVd1Yp9IXDGSL6snMh?=
 =?us-ascii?Q?/+GJS/rWFO0NX76IxU3/RB/VhXZQLDwy8n+NJoc5sN1KToH/SDOEE/BcJxrk?=
 =?us-ascii?Q?WnG5stZN7W8NtBJKucC8/yoPP1pyRDvzx1Ja5OPlgWZrGsCA0Y9qs+Rh66ye?=
 =?us-ascii?Q?ldx9EG4/G467dafU6eOewvB/u36WtP1BKQXZ3ZxJ2tOcYofgcOGZ?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 052f4382-94b3-4748-a461-08defe16e55f
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2026 17:25:42.4842
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JotZXGs2MHsYs/0SbFLLw5QYeUBKdAjQS/WOTvqf2q0YnY+qMccnIFvUrq6ODF5BiDeJQw2z/Xmtt8HX3tBbLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY7P286MB5333

netif_rx() already accounts packets it drops in the core rx_dropped
counter. ntb_netdev counts them again as both errors and drops.

Leave netif_rx() drops to the core. Count the packet and bytes
unconditionally since it was received successfully by the driver.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Cc: stable@vger.kernel.org
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 029a4a532a10..4e53b00f016b 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -155,13 +155,9 @@ static void ntb_netdev_rx_handler(struct ntb_transport_qp *qp, void *qp_data,
 	skb->ip_summed = CHECKSUM_NONE;
 	skb_record_rx_queue(skb, q->qid);
 
-	if (netif_rx(skb) == NET_RX_DROP) {
-		ndev->stats.rx_errors++;
-		ndev->stats.rx_dropped++;
-	} else {
-		ndev->stats.rx_packets++;
-		ndev->stats.rx_bytes += len;
-	}
+	netif_rx(skb);
+	ndev->stats.rx_packets++;
+	ndev->stats.rx_bytes += len;
 
 	skb = new_skb;
 
-- 
2.51.0

