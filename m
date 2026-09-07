Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11FA53B3BFE
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791099; cv=fail; b=uA0g1FFv6zgVTqYc8q0AwvCj5i1T/YEHvt6GX2MBigeOfVHzH1QnlhPfL9j1oCpO5xEX7//ISKVPZQvt/RNgDB4FDZcntRSm1Ro3EYU3i2JLAO5SMum6qwqNrp3vnkt3V6+qeOAuPdyffQrdHJ7wbIwJ0NFil9LKrOmA/glTgcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791099; c=relaxed/simple;
	bh=wf3K02vyiTuyylRiruRHpeWK7ToLGR81bebNHzuU1n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aY1U8TV7WNr7mtwgNsVNu3VbfET7wjR3rOPm/aFZ2qZtgUyM8g1HMN7TTp47UktghSEZ+R5tUXfMJc+zKg9ve3QczKjxTwBK0qZ6OfT52PL1hgrna5tRyFp83OC+v6GozXtIS0C98gh25WqtGU8dNmxCPA9Rz9kdxC3501LNOQA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=K123anGZ; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="K123anGZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OxaeGJWOzc9BKLHupFO5K2yhWYyzm31dBGK+B2IkRULPqoqafV2Lmm23hL5gtGSDov95RUaK8xXMq9992tPy+34Ebc9b/f9q/87UmDe4eBCOnQx7i2u65/WCtdROiTDP2b28dQBmgppxEahKYjhM3vsp3/ax8cNBQkHlLTIOYr/OqCa6/qPAtZ0BhoE3lt9dVLV8UwDOnuBvfkdfuz+4zFq6+C78r3JqKeqxI+sTWMifC7VJRGl5wMkR50ZfJuWAlsCIn4NHdBVWjG22zmiPsMOW2OGIMRHIVCtBO2G/QimkjgqIM/E70ScAtEganXEld9ajkXMannWxtTdm8oEf/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0aNK/7JostnaxSyB7krNk5CCG6ZL2TacRQf5nWjRzEs=;
 b=ybI1YFAVnOO/US774cPRleAGIL5HnPMOM9soxKLbTqBHhhc8o1FoDAVEshm4vxyZe6dJjySip8uXf7eDvi3Ituh+a10+PyZPWLm4H4L0lKH19cx6xoBhBeWaMpReKtUVyw4HDCpq74roAyH5LBhdrA4wxCDuxtMmVmBmHKnThR0pJzYY1bKl2NiYoMQmUrw0eE4evr50yphQQYUFL3q3SfWev7HRnQxoT31/1P6GKZAdZMLq/X3gk+mNzVyFnNmRPwBHSrHHsFiRL3CKZiXQC3uVERDZOW03dtNkeFVwgoQZSvme2N5V9p37bUuzzhaYNUQop9N+2ThlQRQ2YGuZDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0aNK/7JostnaxSyB7krNk5CCG6ZL2TacRQf5nWjRzEs=;
 b=K123anGZH2XCEvofh3lePwtfajsd4DfF/utPCFHq/2PUe7WD62EPaa+Nv+4CWXokHza8eVOMsU3B0OThvl/kH+z6dyoeQ0CSUY92sbQyC0fXRxKZ+zGOH0Zb3FBLU4Z8UimBRLifJxsXmOQioQKlJ0yRrPi5+x7NLyMyKJhacO8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:51 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:51 +0000
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
Subject: [PATCH 11/11] NTB: ntb_transport: Drain RX tasklets during link cleanup
Date: Mon,  7 Sep 2026 23:24:29 +0900
Message-ID: <20260907142429.951930-12-den@valinux.co.jp>
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
X-MS-Office365-Filtering-Correlation-Id: d044cb7f-6ffe-4b35-bc6f-08df0cebc78b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	wa8DLEij/arfHwmijjWnJaKVM9Iq96QwjXZcUEc9FdP4y6mtleYzMT2DHlk0Q5kgb4CMzs1r6uqLDqlVDkimgkRQ3cIX7nOhB7119nqqcn5XKiW9Qlheo4JFJ5aNDY8IYyXeLJ0IIRi+B34QRBKY1jP6DK7j0DNeCAMs9JAjKyNXUcmX4TqZrOii1ong0dVrhXRyG/3u7m1uex6p94oCurx0WdQNCMSdztEmumo6hGgpMogDaAXyllqEgRUOWXYrs5J6WOE/nJNdBQ3J+qt3sdkgpTi3It7DYDoOOCyAIb+Oqz68FGRbWL1TiKeOg0UduiaTAifwZuSAVBLh/IYJPs9mpUG7w0sYRbN6qrRQVpCijpk31SU9fB1VvVaQ9I2OzwSO09tfhuwX138SOUN9H2ewFckSYIWBxYSH+QZVpVQ5NmP2/OCnZkLtcwK6TOrtG49+eYuCVwgjqIc/McfVf0w8D3oIPKDz7I+rswpqXZCRGK4GcQaxLxSxNIgIN9DJimSRD9AyJhKfJqYZ4BJMc5F/XwZrpBL+vnLpeZfEQNA9JA0waIlyZIGFiYv/ZSYwMKKXGUuJ3BxQDlxuTzGil890Maf8ZfSsF2aboGB/50Sx63+ovj7qA2Vbb+LkEmG1LspJ3NsW9DnKVPhaBnl936qcfX1TYunwsmosm0H+1IQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rYbD+pH/RHBF862PG+xliEgp9126t4HfEBXdRZHZfzV6z7/JXpWmMXTXgzTT?=
 =?us-ascii?Q?rNanOQQE2okze6bxSGtEt0C+eXIjxkGnaWWjIXY0HGvVA3eZobLbSUyY/W2P?=
 =?us-ascii?Q?3T5Ppz9B25t34Af5fxDFYdPelmLYiXTPJjy1tN3hrhuxXe6F1r1jhmrzzlkT?=
 =?us-ascii?Q?c6EsEqTLHL27lVd0qBJgYk9QhlvbLrlPm58qG2F4I0kKT8SmttkVJpS7nr0w?=
 =?us-ascii?Q?es1JG0A1Yf4cSwJN1LGouc3X/scbbcoyPpmNPUIHxbT+qm2QEOqN3NBwr5Lu?=
 =?us-ascii?Q?fjJXFPxge9sSdKxZFE46JgQXplr2W/aBHu2jFgkVYEzrzFH76/k1lRafx9JB?=
 =?us-ascii?Q?ilAQJdyXcCEz/oUrpGI69LzhkOC03j6JmOfqRd1rrmyZWe6Q7zYtTG5ifoyV?=
 =?us-ascii?Q?m6E98Q6thaoLbGXhJLB2GfANDCX/doL/7bOp8ax3VykbaDzbMrPIT8T8e7/t?=
 =?us-ascii?Q?fWZegy6MB++82PZg1l628sJiLG0flUa0kZFhla8NHqnIWhcjXbf21ivFhdGb?=
 =?us-ascii?Q?WySuzw7xZ1RM9YkhO5901yq52CYrFKzMT3zkSjgWWjCFGnSpU5o//rrpdHpR?=
 =?us-ascii?Q?+IV/nqC/xkzBprC5e+B+uvCrKiaAmLdKofX3C/378bAcZ+G74Nk9gy5fcxqa?=
 =?us-ascii?Q?eYEBsy2k/Q0JHZJYwY1WPEKqrea61faDdjK3d/3bszVA3LRWmag/2een+oYn?=
 =?us-ascii?Q?BfoqbE2fAvnClsvdQgaUfmrD+2VqOXT9FtJhJDuyCwFLKVtQ454IutUlNb79?=
 =?us-ascii?Q?B9R76+BVmmve8gO+GoAw+u/Ja/8V/7d0xjjSy47CzJVlOQ1QmUIYNMuhcPzG?=
 =?us-ascii?Q?LtCaVff6x85k4w9FPFtoXNGeeR3byPiQ+w/0/elAwKUB9X4QAughh2PDRfgx?=
 =?us-ascii?Q?Y6zDVSoD+aMriMJ14vJ8fHAaOgLxneS4OFPYypYPmDOZpARFsB4du43/HSqM?=
 =?us-ascii?Q?hr1lZmtNBLbTjPhU8DLSDWd0hTaLXdN8ivllYirHKG4gPHkx/L0qkC+K73+I?=
 =?us-ascii?Q?Gups8WCzCJslFxoVcFSqWfERlpNQ3jqwN8Mp1DWVfXqnYfZ2jp4PD2wcLfqi?=
 =?us-ascii?Q?54ixyq0wgGDyab4h2hu6Z4sBtNse+KsHhrK/kaRlIUpEHjFiJi6Bfals0YQn?=
 =?us-ascii?Q?E4gY8AwRgM9Kfb4+HKZ/DELlHiBptauG+n3/7+JyR7y5quW9vjCB9VGTaC7k?=
 =?us-ascii?Q?WjZih4dCjgDKF1QEOXnDve+E+RG3ufuS6FMTYz1JNaiWsAOWp1bXGiuWhV0V?=
 =?us-ascii?Q?tcPn+viOWYrST251BvD8V6euSnC8TmJBmRC2d6rTDwvvr3sYueVunWcxMF/W?=
 =?us-ascii?Q?ja4zj2KxNzCbBaG+4XWtyfhC/SzPIgrecLLScSHvbbif/d1RIccj9+ID3KcF?=
 =?us-ascii?Q?AzHIX3vzShQ7X96RBj4oVB9hEd/KqiNlGkD268JtobboJMJ2l2/XS/Mri8yc?=
 =?us-ascii?Q?Jw8/rh10kMBpJdausZlhtQPFz1jSKNsjr6OLKPujd56a7iSeD1m8GpwikluY?=
 =?us-ascii?Q?RqpGtB3//a2C4UVnaT75KMoqknKvrArsCIAnJwsSbb91TSEC14g77pYNMP9E?=
 =?us-ascii?Q?YiZyfeZEEJC3AGQFc0s+DSpfKTGCpL4KmaK2sJd9/Q4iMcizyXOjP+iLWDn5?=
 =?us-ascii?Q?Ge37W17rnoJUHupukbo3IWUJwDJ7kqFBWcEke2O9mKeAPkRQUq2He9S5r3lc?=
 =?us-ascii?Q?BpX4YwPamp7Cwt4UGJcwdZN1reaHM6QEKGnAYWrYd8kGQtCXNtCEL2cCfQf7?=
 =?us-ascii?Q?iTRMIIDFFQOiwvjh+l6GcobOMr8FjuabwqSqwcEGZ+vYS72u/lSE?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: d044cb7f-6ffe-4b35-bc6f-08df0cebc78b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:51.4996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jkSiK4JZadDZTEhkXli3nQg7RZG4nfNXx+oiXucs/ag8w29acU9Rdf5xATtHFNTL1y7YI6ZqYkk6Fo9tD5VjjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
tasklet. The tasklet can still be processing the ring while cleanup
resets the QP, and transport link cleanup can free the MW before the
tasklet finishes.

Clear active under rx_sched_lock and drain the tasklet before resetting
the QP. Temporarily disable QP link work so a concurrent client link-up
request cannot reactivate RX during cleanup, then re-enable it for the
existing link setup paths.

This does not drain RX DMA transfers or their completion callbacks.

Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 0257f3eeb5cd..dce7b1311406 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -969,11 +969,16 @@ static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
 
 	dev_info(&pdev->dev, "qp %d: Link Cleanup\n", qp->qp_num);
 
-	cancel_delayed_work_sync(&qp->link_work);
+	disable_delayed_work_sync(&qp->link_work);
+	ntb_transport_set_qp_active(qp, false);
+	tasklet_kill(&qp->rxc_db_work);
+
 	ntb_qp_link_down_reset(qp);
 
 	if (qp->event_handler)
 		qp->event_handler(qp->cb_data, qp->link_is_up);
+
+	enable_delayed_work(&qp->link_work);
 }
 
 static void ntb_qp_link_cleanup_work(struct work_struct *work)
-- 
2.51.0

