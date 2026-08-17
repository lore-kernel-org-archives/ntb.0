Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11020078.outbound.protection.outlook.com [52.101.228.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A1E38DC5F
	for <ntb@lists.linux.dev>; Mon, 17 Aug 2026 05:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786944931; cv=fail; b=ViPoFXvgs87hQS1sUnRb419aD+bBw9Js0ayvxS96HG9jCIE7JLobTqbuMAszGuCMa0lxVS7J54awqztB2ziBuhi8ZS/RFa5Nq0aPHNcO1y5Uz200WDiiq2Xiowsg9uV7kSSHhOx9ISES41e/dvv73oTQ7i32ZwPPNYKV/A3+/4Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786944931; c=relaxed/simple;
	bh=R/b0O8HxpqN4qmd9XvXDk6r/sFQ2fssPrUQ/6ve5arM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWj8WQSUykyclCJt2RzLClv1F7XN+T0P2Ku1vTLykscXVKza6KnR+wVA5rLFu1VGRN+1wnY1C47ZjEszaZETb4CfDGuTGaDBNu2Q36NPxRl5+X445U+PJVypG+HonWpSpAJThbfBJxf4jkulJbRF8V4IxON/I/Cijqmxh9jMd+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=SbrijHfy; arc=fail smtp.client-ip=52.101.228.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="SbrijHfy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cD6j/98I4h8RTn7sYkh+QXLaC9Xf32FI1Pgilstq9dAcfxIsxMxBb26x/+azguJXY98X74aO4XZVn7//E7QZV1I0Ry8Ahj5vsXGD86Y5K4inqJ4hJfZUTgZb4TWr3WbfxBMuS7MXpkU42T45gZdgfDaeBStRCdSc38aWCu/no+mqctWTXBA7zIwjiZoDA14THS+wuQTSXMiLUzMPs6CcEoZpGlIgFEI/zfZ7v3FB0FdZ36powwCVZIecDNimhTG0mfOZF2ypVPzBJlaI2qzGuXboMaCMRvVcj+wUH15FCiGAihckNYNG/XX/jk9g9mEU41Nx1xqNfIkzoqHQ+pv1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQidTvcd1zYJUTUYJUZJ90vhtwUPxNmPl5uqv90DLcQ=;
 b=E4xLgk5lrgdJ7feoeZhtvKhmujOy3lphZqeQa+2crq57EBxuGq5Tx3M8dyO50vRXkU6m3a9SLgRXogVUGZph95j3+geTzaaDwyoCnaSQwA/NUnXmiElANn8pm9PBddQ0E/IYxgq1ER8Lrs1kbrZSsQVYVIhADkqfhnNSNI6iGcYrGeSLSjZJBFZ2RRqxN8rF3rOGIjL6bhiKOMkPBhnNc5h77jj9S2Ikh2KNMHvD4da7ko3H1t+X61bWueHtAsK5vKpVeQGAPx/eZJpxYctsPas5L7A74ey/0hGDLaI7NubR5c2lNhpux0/2izmknIHUYPJtGi7hb/zX5qEH9f3+ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQidTvcd1zYJUTUYJUZJ90vhtwUPxNmPl5uqv90DLcQ=;
 b=SbrijHfyLfBqsHFbMHG/f94lrkjzDqHasVClvLS8/uaze9IKyzyJuPd/Jl3nPpjcrVO84c+C/kK5Xr/DxWT5RW1xZTB2uqzwZlHqPc6+XqObXDqaFePKmY5gDu81XdaRWRCH8avWNaQ66tPwjaEHfaazIBybpbb9K6p//GA+mTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYYP286MB2996.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:30a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 05:35:23 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 05:35:23 +0000
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
Subject: [PATCH net 2/4] net: ntb_netdev: Fix TX busy and drop handling
Date: Mon, 17 Aug 2026 14:35:17 +0900
Message-ID: <20260817053519.4135287-3-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260817053519.4135287-1-den@valinux.co.jp>
References: <20260817053519.4135287-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4PR01CA0024.jpnprd01.prod.outlook.com
 (2603:1096:405:2bf::18) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYYP286MB2996:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d35d5b5-e15d-4257-e17b-08defc2155cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|10070799003|1800799024|366016|23010399003|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	olDDH6cpqecs8CQS9bF56+WIMs0Q9tWN1NuhTIi/ZqI8AIOprK/LZLE+zRA2c/9YZjfzImXCS0vjZcseA1dnRttBDbj3a493hujLqd/mMXgVT7fycwJPnWjm0B5VqMxWTCx9g6mw6u6ovuzh6mK3vv7HI/jH9/5cCdHu5YNP4FSL0/fyuMZbho3ktXiw0Gp0VWZgahvlAhBa80ksMS2Ii3smmVQtWFBbX7HWD0KPpl73ZgV0yeSilwQ0JgU+xoxtHaFzlWyaxHLG5w9FbtX7W/cJpmyNiDOwis0jHFTkbJzHfjD6hqNQEezET/HxM1SlPeDPM+6Lqt7pfCYg8P7BgDN+XnipFBqEqRGKq5ppaUf+CVwfmzHQPxAEs0seWdkr5Ugusz5++ApZO9/exTIJGFxtS4BP7bRqT+sjSoc9oYBRCkCFcP6olfGO/WwUPeen95ePIAvPjaDAm+R5GIJZZZWcuwChZXdTOVm32Nv0xk0HUDZZBLOWLJoZ9c9UHwVkhX/JvqH9K3TXRVaQ53WtQ2brP+eEUdvm/BcvbtcBwlU6ljXpe694C6BnmoDX64n+U7j3ErEEaToNWw/VIdSa9SoGzBWWVABnrN0J2nsMAuG5kTGZiMgB4ltUIth5b97/kOWuI2PxAvqY3Y+PPDsiR8QgXc+uRCRqDwr12pekUcs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(1800799024)(366016)(23010399003)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ofcz4VC4ILuUIGgHVinPQy06b79wRK1NkZ3qfRwEgV7i8pq9oG6A7wCYfsCT?=
 =?us-ascii?Q?lOhcytiMoFLQjlqz1s0ouCE3Y8Ol1AGFC1Xj+HFTph2IgrjNJhhw3uLp7uLS?=
 =?us-ascii?Q?opFW2kG887E+l0xUXud3ewChCykhH7YlhV/7zwEmrAYln1n0tomeA/K2jQbZ?=
 =?us-ascii?Q?0aGFIDp36ZnC5hUE1r7WrmNwkfcEoTpWBEiH1+uZCkJ17C9AzJ+xuYy7zyYg?=
 =?us-ascii?Q?6cvaKzGldZKDHzOu4sVtDhyROtKaxUb77v5SBZ+fSnLojTzMjFFWXthGANXt?=
 =?us-ascii?Q?oRJnFfrINnhSYH3sx9+y3L2cEi8oXgiif8rtck8/IjJ7nI9pD8yDQQYkH5F+?=
 =?us-ascii?Q?iutmKpdNFI+NxpGvdoAas9otqucXEIiwZDbrIe3fR11juUQ/bL4lBXmAAWci?=
 =?us-ascii?Q?WnRoPLSk1bWyiBwNZjqy+lH0ntjV4A/42KJwr2ZDAW/BoMhqDf00vC09au3I?=
 =?us-ascii?Q?3brPWH4L8Tk/zv3eC4A5EXepJjVtz9UUl8tSwlOaM5QpGwHmXHHxXwDg1X3L?=
 =?us-ascii?Q?3BcnEbGuHqm88jXJwMp7iV4WjHtAjBS75Yhp10MrzIu2AHz+IdffJoViZDgR?=
 =?us-ascii?Q?bThgIh43WmB22sjrpBNi+9Yym/PhxCwZfY3MebWu41Wlh28bzQuqxczIzizi?=
 =?us-ascii?Q?e+JW2WWq5m+WaavUZaR0q5Hd4m44TFPJK6zq7/gsMSFSArTnkXvWzM57e6q2?=
 =?us-ascii?Q?W7WLxap9axvzExrAlenvEjTKfl1Nzhhx2TwgK+arNHFOYCFgM/xgzCPCObOh?=
 =?us-ascii?Q?o7Wnhmg5R4kOQAcaLi7KTbzdvjt6CnEyj39RpAjZNyFKZlz9oQrGKpSvSPZR?=
 =?us-ascii?Q?/g3Wx2fuXw5QVPoQEQMmlrl4WABPwT2e2IVkeJV0ybrUWnXiXowhg9EFW/oZ?=
 =?us-ascii?Q?wCR+CUmKbjUcolB4zyfXpGZSkw7B82XxW3Bk+EaWlClO/AV9pa6g6tox9k5U?=
 =?us-ascii?Q?HFP2Ra3D44mNFaOA+wZSaLmqE/amAlikOJZ1U7RbBK+ikx7FUN4viRENgcoE?=
 =?us-ascii?Q?bkT9/8Rr1crHmbfrHn+LMe53wjj61ONVae+0JoCGJYLiOZX8GtfoKX7smtty?=
 =?us-ascii?Q?XiNXOpIoATu2XYrRm0TSCuWkkeF0vvAvAGln9l5/nUuC6YHNghIntVsOZ/cj?=
 =?us-ascii?Q?hYZPIlQaDuElyRBR6cr15BtxBdTwcMN4l+torApkSXkg25AIwbnb2zQWm0Lr?=
 =?us-ascii?Q?VNWru5L6fqaS+MB2zMN6DkLmm05NGv1hp+Hg+mQIfDJD9ZYQkDEkmigWaqV+?=
 =?us-ascii?Q?k45xnJZOb6c40hWiAX09ALyEA9yPrSzWM7KANDb2/TNwv+vMQAVeC4xB4c+5?=
 =?us-ascii?Q?0IFJChzlhvhI4Z0x7NGTm5Z40UcHMx3zoDAHFYdOS+63GsTw1ER9KwgIyl8n?=
 =?us-ascii?Q?00pFx9IJJVVs2oKODu+SWkggi3GWMFgGHZdG4TTDaEXtkYv9URInG8MprnMd?=
 =?us-ascii?Q?VbBM6MhbnZSz1RTyerkTt7L6ja8SH8Qd6Z14lGm8pYvwzSStZk+jVzRlR12c?=
 =?us-ascii?Q?gk3CwzmcsEnIdRPj+C7TrKctmBG9WHxPcYc4a5KEy2ZSWVxcHy193j3E6cVj?=
 =?us-ascii?Q?fvJT4Y2blb50ASBhvMtfYCRlvGgOtmHMQNkOQOfRpDxm8wlu88jPqE9vSebv?=
 =?us-ascii?Q?+yaEfA+WHg/2lLCrrEQyDFQQ7LGHGch1hIq9N+DVH3MBGprwapyl1l2ViHnj?=
 =?us-ascii?Q?iIEvb94bnFdq5FTbxrCl2DWkI+tnwLpdPMAOHUad9nIwN6Z0D+o3qd1YpS/y?=
 =?us-ascii?Q?9ioZmWqkMvBR5vRMjbqq88EqGg4qAlhDFKvAkCoR3eT6It2VD6qT?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d35d5b5-e15d-4257-e17b-08defc2155cb
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 05:35:23.7639
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gW92DAx+xvQYkaKejFuS8M2XL1LZLkJqbwSS3mfvTvjquY9QRbl9cl26b5ctq1VmG/ynxYa9JhiU0fLUoZRTWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYYP286MB2996

Currently, ntb_netdev returns NETDEV_TX_BUSY for every enqueue error. It
also increments the drop and error counters while leaving the skb owned
by the qdisc, and may return BUSY with the subqueue still awake.
Retrying a permanent error cannot succeed either.

The unconditional BUSY return and premature accounting date back to the
initial driver. The error-path queue stop was later removed without
changing that return value. The current flow-control code includes a
resource check, but ntb_netdev does not honor its result before enqueue.

Honor the resource check before enqueue. For -EAGAIN and -EBUSY, stop
the subqueue, arm the existing reaper timer, and return BUSY without
touching the skb. For other errors, free the skb, increment tx_dropped,
and return NETDEV_TX_OK.

Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
Fixes: d723485cb4ca ("ntb_netdev: remove tx timeout")
Fixes: e74bfeedad08 ("NTB: Add flow control to the ntb_netdev")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/net/ntb_netdev.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 029a4a532a10..02b35cf53a62 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -199,8 +199,10 @@ static int __ntb_netdev_maybe_stop_tx(struct net_device *netdev,
 static int ntb_netdev_maybe_stop_tx(struct net_device *ndev,
 				    struct ntb_netdev_queue *q, int size)
 {
-	if (__netif_subqueue_stopped(ndev, q->qid) ||
-	    (ntb_transport_tx_free_entry(q->qp) >= size))
+	if (__netif_subqueue_stopped(ndev, q->qid))
+		return -EBUSY;
+
+	if (ntb_transport_tx_free_entry(q->qp) >= size)
 		return 0;
 
 	return __ntb_netdev_maybe_stop_tx(ndev, q, size);
@@ -256,21 +258,30 @@ static netdev_tx_t ntb_netdev_start_xmit(struct sk_buff *skb,
 
 	q = &dev->queues[qid];
 
-	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
+	if (unlikely(ntb_netdev_maybe_stop_tx(ndev, q, tx_stop)))
+		return NETDEV_TX_BUSY;
 
 	rc = ntb_transport_tx_enqueue(q->qp, skb, skb->data, skb->len);
-	if (rc)
-		goto err;
+	if (rc) {
+		if (rc == -EAGAIN || rc == -EBUSY) {
+			netif_stop_subqueue(ndev, q->qid);
+			mod_timer(&q->tx_timer,
+				  jiffies + usecs_to_jiffies(tx_time));
+			return NETDEV_TX_BUSY;
+		}
+
+		goto drop;
+	}
 
 	/* check for next submit */
 	ntb_netdev_maybe_stop_tx(ndev, q, tx_stop);
 
 	return NETDEV_TX_OK;
 
-err:
+drop:
+	dev_kfree_skb_any(skb);
 	ndev->stats.tx_dropped++;
-	ndev->stats.tx_errors++;
-	return NETDEV_TX_BUSY;
+	return NETDEV_TX_OK;
 }
 
 static void ntb_netdev_tx_timer(struct timer_list *t)
-- 
2.51.0

