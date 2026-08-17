Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020078.outbound.protection.outlook.com [52.101.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A71A38E8AB
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 05:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944942; cv=fail; b=Um3afGQS5LD7KV1rSp2eoy9SzIBX3EmSvwNwpB++5qwpcJX9n1seNu7DLfOSEo9nnAs+frIafHTVEiVyU5V2tjRQqR2vb5+sanlxK11jHbfU2tPg0zZUBHphi2ToVxRw/tUhMNI8j9fAn61as3bhVqyHyqjZ7suI8bKsiTquJ6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944942; c=relaxed/simple;
	bh=iZU49SiDtX895+vv9RWtc+rUZih8ryIuFP0zzYy7UQk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VSdqvyE3ME+NgkJjbmiB/lDXEb5issZrogAgxo+ksVcnuUC7XnOpvMvBWVrKw9O3r968eTjqJbocYCQq3vo2OxrOU98tA/y6gL4GkgIuWL5f3kdktT0rTuREMnZeg/DNksS2whuEeWzqydrXoG5L/W3b4GbfhNef8SLcUdCtiGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ilYrMMjI; arc=fail smtp.client-ip=52.101.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ilYrMMjI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odHYn04PVX6YX8JiW5ZXiTahjKdwvKTbRgruQc3TkGyFjgzPNhf6RCRHZQMIk9xqUIJU+N2+kr2tLBPSfEcI+WDQ9sSpts/QebAqDuJd8yZZVCKWtWUttyrusMArzII3AgYPmDr1HZTlM1drrplQ1JnCOwz3TeSQZf0O/UXWVSxYuRnrbAAs1V1+o9Z6p15VhA12TE69LPBzLXd9VqIoAnP7qZNqtVVL80kNih436WJGU0aYTRXoY1Cu1mcBI63xQnPc1/jjCAYgZ2/pKxqwhBW+lhnsaZtGnd25Jx/Mz4AuRNHsBrb6hhrgBPJjjE9Qz3GZP7rIYbR+tDeZRMSTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g99kSsQLeAUP9kvxOgvvJjWQ75gkhz1A++wawEhvGOk=;
 b=BIrpaWGAgBs+3GYmmDcs9KGCr82wa8egOUr7bVF/d1S1cnmABjf2hYIOXC/l2/RsCSxFe6pwD1u6Wq60AVsPFgxivcM8bF4A2xfGapuU+6o+2nQClF3EEXjvnPyX6wfx6WrZh3TUjJ9214qe3nkEMbyaKtrxVb+jGjYW28pNuHJPGa5muVodLk1Nj67KZKkre4br/vFv8WAGPnrlhNFyL084zryqpwo7PhOEUB/D4vxXsPuAqEvvrA7DzldubzV0/p48BK7acHHOIX2CmrbencFujJ1kCLLBuTUXYQFyVVwM3F5xiPkZLFMs9C2UzaxO1Y0F6akEn8NF0TZiiCRBIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g99kSsQLeAUP9kvxOgvvJjWQ75gkhz1A++wawEhvGOk=;
 b=ilYrMMjIjc0vCRyk+ZhlYOOC7eMhYqgeKO9RYJyCISA99STN0bpXjtIVJMADrIfuAl9ut/zJknlbRG0MS4un5Q9IpjbKUD9nwz3doHfhznAtPK4nwqydZH5/FICvD8mumrkOZBCJfHM8UpRS60ewoXK2+3B9ckEsGIB5Z8xxa5s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB2996.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:35:25 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:35:25 +0000
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
Subject: [PATCH net 4/4] NTB: ntb_transport: Reject oversized TX buffers
Date: Mon, 17 Aug 2026 14:35:19 +0900
Message-ID: <20260817053519.4135287-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817053519.4135287-1-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0208.jpnprd01.prod.outlook.com
 (2603:1096:405:7a::16) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB2996:EE_
X-MS-Office365-Filtering-Correlation-Id: 230edbfc-22eb-45c6-1440-08defc2156e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	gzNJYNTXSzaYTsxxY9vCkfKjxiZyuuH05MOF5+F5QbWT0reM8S3yUOGRDVYyTLWttij1zJFl9yfVhWltzYM2TmcDQ1Umnl0nj4eIuMVhBADXqEutvEA7wxA/f+WvIaRzXhi15dhZWLoXftqQVMuYiDwtcBF1gfu4kOexA7t2eG7x7rh4ZFH4T+DQ6thPHN2T/ZfK4aq3LIUCmAA2gpTDIuKqeHXSNHuCe5OzOQ/rQwfFCqCpuTuP2ligOtVrwbaCAYnYIWiHDNLRvbuDtmkIrxGjwykQTJtkjGB/XY4E6G3gucw5ZkdvhksrARUTUgv7gI/RYOPXItMi0P790DdSVJ2zyW80sunBDy4ohauBAn5id/rbU6Tc3V+JsTXEJj2RmYo24HubRgrYIeqqq4nZ2sxRaAYdwhkFQSba4svSCZ3lRuFUReppm8gtg+AX2N1/Y8aFMtDhzEh1llk69jV5pUXGCKKwHQx1xmYZB/3etm0AqdHI+eKlhEN2VL+fzzl2cRDlVf5+1cn/L0c/G7eYXCYac/kug1yq5L6eF4fUGXAuUdbnftZmVMbLKdQrVi44tsC4lXBBh2pY79rEVNtGToznvFl8kBhEfGRqVPwN3xkcgTjUfs3f2abZn+JYGJm2TkU/+00JGMMyVzv8dMDOerQGXvH/lNpTRApjguMtjHg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kb2KKXun0oMD8ebHIHyfOatp52ErymROz1deG6+KRaA1lM+RZhtlHMTV83BJ?=
 =?us-ascii?Q?5YVsHUq1+F1Zx7CYMZ32RL4tifuAh/5khNkEaWXNBhxxl1XFMzTdStjU9KNg?=
 =?us-ascii?Q?7MbYfC92jrXME5y1UF83/GLJMPgbpqw8kDcrEGNJ4J5Xc3Ld+U3Hl/jS7x42?=
 =?us-ascii?Q?Dd3SxOu2KsYVs/qOS2k/Ay3TdYkKUoh7omyVC8XjEcEfg5Nd4SDgQs3J9Nqw?=
 =?us-ascii?Q?iIwN5kGEhdhmAW4YbTTLekvQaH12YoIIylu/6LhLSQ75cVmFHe5b06K786gA?=
 =?us-ascii?Q?rhTWXM7ePBuU1jwxWQZZYzq6T/z0MsoLFWntDWH9bz0f17jEl4WQb11Opfuo?=
 =?us-ascii?Q?WonyRl4+kkNIY8OtWajeIMSVNxwFRdLxcSM3EoIoYnYICO5tQeBKgfJIUYXW?=
 =?us-ascii?Q?/fx0b0ZB2+8l12bLjmDA4ytKMgj2MwI15V114+SXR26PpLrBJ6HlhaGSMQ+7?=
 =?us-ascii?Q?Q1UjOqblrs7KSKYroq1N0eqP8POL9NHoW62Z84y3FiBnawjnT14JMRHa7kss?=
 =?us-ascii?Q?/xtervY/wuNAdyhd2ja7aIfelAq33tbxLfKlv3RtDMa/iu7jfXT5pjDfkVxc?=
 =?us-ascii?Q?DLkAy7OI8oEVd+wKw2zbW2MgBNr7nFGa8yIPtSLsdKrtQQ7CT0QCgO+tW+Mk?=
 =?us-ascii?Q?uzm6nm68yh2v5vCISYq400+DniusqczDS5U6y7j6OcJruMpy5zMbu4bftp/b?=
 =?us-ascii?Q?iaqR9iniEYikkH5w/jnWe7U0cv08jJp/6GC5xIzf+Ms1ZYE5/IwblzbI4r3l?=
 =?us-ascii?Q?gNKxg9EuglKWG+4ydkGB1FknJXyioU4ZoD1H/eWVUQcN0yO3ArvFJvkXUpzZ?=
 =?us-ascii?Q?LWpSY7yZjAkYjm2p55wNn/TD9ECKq5upD63GoVr0hQ/10wUeVNHq9idAkJge?=
 =?us-ascii?Q?KYaPBugrm1xdPTveNsYM/kOt+3hXRV4DTb8Bok9JqVL+jcmTSbORRXILybsd?=
 =?us-ascii?Q?SbsNPVIrj2Z4au1Y0IPmgpFDtxvB2nqBXn6N9mlTbFKsXDajxA2/ZWhtqwm6?=
 =?us-ascii?Q?el9MWse7GuVgc9nCmJI3qg11KrFdfdQJW//JWujosffDb5KNgzZkJHZlLiKb?=
 =?us-ascii?Q?rfRI5aW90e8gSpjUYxs4k4XWwrQtcLewCHn/Mq+QGa4VPfNA8C5UQuekWLzZ?=
 =?us-ascii?Q?twWT8ixH7shYlCDBZ/znJip53xVVg6eMIClmzDTTCf+RCWVVp445MO+88EiJ?=
 =?us-ascii?Q?pI7mh/QNLHXlWLPGIiYyNsGp7BcgqfyMbJ1ANH2f4vqhaGyHBql8dzhEVQTD?=
 =?us-ascii?Q?Eiz3m5SAQjomcl3FOcQglxUskxML6ulqaUaDOpOceVc15PvGVitT9WrYB0qS?=
 =?us-ascii?Q?2VXfdiwe8Gj3wP8GBe4Vw802li2/NyABayK08CcQbyHGi26E9I3bLcjGmilx?=
 =?us-ascii?Q?x61Ju5zrN8yWOG/+A93J+MvP/RkNQq+3IzKyCQbv9bLCF27gUeOQ1RSwCEMs?=
 =?us-ascii?Q?/8XElms9kGXtiNQEAMDoyb2GuYjdSCFtxKb8YfC6R0+IffNizD6taDiPMglj?=
 =?us-ascii?Q?1DNCulyJpEtNXV7c3uxop68Jpcqi7NeZSRWHkbrSYydyiqXCG1it1AYAYp8S?=
 =?us-ascii?Q?iGpmxGX0rO+geO120QUpBUL8TEzstM6MZdiNJdt7zh66+ZWtbmX9eUfa9Inq?=
 =?us-ascii?Q?XJ//1U+AqY8moHx2agVOI48SakIhvOrjriRF+7Dws3Eo8z72ifrvTZ8B4BsQ?=
 =?us-ascii?Q?mhonO0/pVQMeFi3Q87l60pOR6cC1DNPNlfC1ZQEeH1m3aAgczPRQN7FvtN8m?=
 =?us-ascii?Q?tm0ZpD85V+btqvfhznG4vcogPivu7N9UG/lP2FWARNvwfAyQXcbe?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 230edbfc-22eb-45c6-1440-08defc2156e1
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:35:25.5601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: udzQ4b8HB2yxD8COJdDtNj5995ORo6E+ns3XlJr/WLENBTkgVeu1BN0vI6e+dSYeTr1fWRulkaQ4fDi5lvVyuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2996

ntb_process_tx() handles an oversized buffer by calling tx_handler()
with a NULL data pointer and returning success. ntb_netdev therefore
neither frees the skb in its completion callback nor takes its enqueue
error path, leaking it.

Reject oversized buffers in ntb_transport_tx_enqueue() before acquiring
a queue entry and return -EMSGSIZE. The caller retains ownership of the
buffer, and the preceding netdev patch frees the skb when enqueue
returns this permanent error.

Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Previously posted at:
https://lore.kernel.org/r/20260810165136.2292436-3-den@valinux.co.jp/

I moved the fix here because it addresses a pre-existing issue
independently of that feature series. I also moved the size check before
the tx_free_q lookup so -EBUSY cannot mask -EMSGSIZE.
---
 drivers/ntb/ntb_transport.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4bdd81edcb87..f9caa1a653c5 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1955,15 +1955,6 @@ static int ntb_process_tx(struct ntb_transport_qp *qp,
 		return -EAGAIN;
 	}
 
-	if (entry->len > qp->tx_max_frame - sizeof(struct ntb_payload_header)) {
-		if (qp->tx_handler)
-			qp->tx_handler(qp, qp->cb_data, NULL, -EIO);
-
-		ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
-			     &qp->tx_free_q);
-		return 0;
-	}
-
 	ntb_async_tx(qp, entry);
 
 	qp->tx_pkts++;
@@ -2356,6 +2347,9 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
 	if (!qp->link_is_up)
 		return -ENOLINK;
 
+	if (len > qp->tx_max_frame - sizeof(struct ntb_payload_header))
+		return -EMSGSIZE;
+
 	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
 	if (!entry) {
 		qp->tx_err_no_buf++;
-- 
2.51.0

