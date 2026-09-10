Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BAC03AE6EB
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013341; cv=fail; b=QlvosJ6ufIKfdmzXyareu54eMorayzPtUXQ5vFNmzCi7i8wWpynOYvVgbLqyZj1r7ruZT1Lbnd78olegnXu/osaPRSzyxmzcKMRGEXwqrMIdcPF6nPqHR+WIUyZBJbT01ramN0OSmujfVijWBqboIZQrrXGEGhwDY7fHioQ1UqA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013341; c=relaxed/simple;
	bh=0Ajt63zi7FTRzoIr+oiPGjKOfIodgEepuj8nIDWk04g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jNXaJP6QLr5rrRKEUW1SV1qAfdhjdrTI0y2niulMfWacUh8zs+9N8szumN8xGoaf4oeAxfc5cDwIltG++3KTale/CiCsxZtDDqIJrXj5mmRoYxa7f39Se9UzL8dyD1hbcMn3JI2Y8XI7QFM+7CRdup7bLjWRSbCZDnTMpr018/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=nvVwBlpu; arc=fail smtp.client-ip=52.101.125.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="nvVwBlpu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NA7zJSxZLDs5FdoEWyKONdfvVHWP+queTPIWnojc3rdKT7NyjHVWku0TbYq9PElSQNJVPFPr1xAjRuM5pFLJHKRIeMWjutBNBcEE7/bAtGrNi86TdWM/fkELH8rVwQchDkm4PR1nT6TYzERarjo0DC4m4HCbrGs3DfvCbNfwCJC6+hu/uB87K7tIFMVgvUTBzfZlvHHN1kWoWAzrE8ilBNWvM3FwiCiBsfJo27ZQS/IL5usZ1rV8m+CAVQDl77jeGYJkFI+jI5J+p/BF4Thm6TLTvWcrUrccwhfTVNFdfyfHdTN+s3tfaPNZjIdVd3y2OlQPG0Rl44JZfy1BNP4lkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J25PxL4F59fZZrsVfAmYoJUfQar6WJlEI5N1hvECO4A=;
 b=Cm2Ux16RZlNSvYXRlgFKNg9BfZI3p5nkuOcJFT1nmmiWKmjg/ZVxpkgMZ2NF66rcizpU8qZzetA7wbewv2Wje0Rw8XqH51ZXp3U2QKEJK8ePSgJnD1Fu3btXLwAH0xjomra/R+lGUQeYRa7k0NlHzrfnTw4bzD0Qf2mRH1redXOt4RrAyrvrItjDR2QQgcc9XX7FPWfdWu1TtsTgkN3y9VE8xBVE8b1b61qy1eCP0UVh6Vt89OGTG7chdD6C/kXCE2aLu0Gmvk6m1KVXBfXVD9ms7IBDJQq+o81SQT5EQxHS+NfDuKOKoGhq0nEdd0eWgJd/jXRF0jzd8hlHiDfnQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J25PxL4F59fZZrsVfAmYoJUfQar6WJlEI5N1hvECO4A=;
 b=nvVwBlpuOUfV6/VsHFTJTOL9QJPgkD7rPRyLLIFIsUCmIadhFfdlSNMcxpSpNXoLPY9pwCkjz6VFSgRXIb69uuuyCE80yR7K64CAP0Fyav5i1rn/F4O4P0ByIL0SkyiPQH6pBp91segjdylDEhTh9JUwaHTsLFIGmgvv+ptZDTY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:48 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:48 +0000
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
Subject: [PATCH v2 07/14] NTB: ntb_transport: Stop QP work before freeing a queue
Date: Thu, 10 Sep 2026 13:08:29 +0900
Message-ID: <20260910040836.3792333-8-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0176.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::8) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: b7c74ba0-8714-4560-b8f3-08df0ef13683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	hSJjE/OKD1y9z3CP3nJvWmCjbRlUTZcb8CDKzS9kXDWdAdFU9KZggcOFqr+mS1yCbLRVsLmQOT1obmgk9JTHEVShyGQ5wpKT8ACmp0lkzzcO0ZWXihbNw3GvZtCt40GMNtdYcPHPHY91BzuzsGZHmkRGykLe4zNOu5ILiuA73z1yH6aehLXsa8O9HsIV0Fmdzoki6WxauAZV5FKAS+DoOJjqgf7R7rbdw7xuEQHfRo2obXSkF4C2pZz+3TqsfzqMS9/q0UTxHXe4jhlIgceHh3SkeB8I1mVnFJWTeNwkbe0sli6HZi97Z+MdNCqWyHqvh628/d4rIpMy+4CsH6qbdawsDWn+482jQRwQ2sh4FCCoK65tvIUxLPJXKq9ucDZZ1xDLbwJcHJXhtXZ58wZokQAQizi1fiwvZZO70qgnbg/TTqXy/LTXizIdy1t93BsdtNeQNViB00FEJv5zVqliHIO+YRdDbZvPsOqHVNrcA0sYloJGyoeD/5Z0cocmDs+jLgxhY6D4RgD1i62lIT7i2nKXWNGaFXOEv5LYOLzdckTpV26m0IS12f+RYETU5FCrSbIOW37DpIeoQ6gbOV8+fLI4oWFCj/FDWeGJfpUd5xMRCC8RLJ4fY+BiJ13c5Qt0
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZohnPKpZ/uyoMg9U9KzVb52luetS8xXZ3fZgdvqjdw+9RGyaSxRxry68yFp1?=
 =?us-ascii?Q?DlUce17P2P9JWJUEkgmw48smc+Zu97ooKSPhLcsHagiA42MzzQ/T4Klfgbtx?=
 =?us-ascii?Q?0ymTQEokdHJ+P4cAUfwS3nsOeVQVkFi0YYgLrdn/iOUbRiAdK8bSyQMTnd4z?=
 =?us-ascii?Q?Unt6hfDO560ZNW/DgcWKhRA17tzVzWI0kxL/tGP162Hrh9p2Bjh1ML2JmPlh?=
 =?us-ascii?Q?O+zLk5+Tc/NDtsloM86eUQ9yCQDMHXTlMYxG0eiJrv7odya9YuW+tj50qAaD?=
 =?us-ascii?Q?Jw7/E3WD39pdcRIiN8aEhr6bCXFj7Ta/oa87wPrcb34BAGKMIRiKS2GMPrRV?=
 =?us-ascii?Q?qM4aLGtEuefUs9zUOdDxFX9P9hVTj6mtEQ+xYrMqpA1p5PO0OSgwSy6GZJnQ?=
 =?us-ascii?Q?TgLzds/57CmNkAfMInnuRBfQ99LLZus87KZU95V0HyXBtQES1r2xLuqtzvqw?=
 =?us-ascii?Q?/lCvOsniaqan2KzTSaRDS2l3VzvA7mT5/27OUamBh4FqU0a/gKokSGhoMcKO?=
 =?us-ascii?Q?SpfKNF2n74LerkuLQ+Dau2FateMgMa5msf3lf7x0o5F3u0/fN9iMaxXgcGAm?=
 =?us-ascii?Q?io5Wry7GV21lnbQqnwBXny2NZIcvg6jAaWKW/gOM0pmXEsuc2lQFSzFvine6?=
 =?us-ascii?Q?ul6MN3gDTTak9lAqNsL48cJ4FGs//bmU0Ke47EXAIufbW9gCwedNbyuil6gs?=
 =?us-ascii?Q?SrMkFrO4X1zL83tM2ZZm91w9yRyvsjGOnPphGXeLRcP4VEiZEwLKEfudAW49?=
 =?us-ascii?Q?W2qU4fIB1wQSAKZQQYgrhe9nMUGj+2a4Ieu7KcRCTIDB4ZhY9v0pnuCrREe2?=
 =?us-ascii?Q?s3IOQCD+052QNBekpV/3RKM1akFUf4HYyFoOB8WurNtydEzv1b8EnnAvL8mr?=
 =?us-ascii?Q?weTIM+nKw4XTqee0zlG5jUiKTqnEbN9lirVfO4xqV7I5lb148im1NqHxwIk0?=
 =?us-ascii?Q?+tFAD+auYpvU1u0v9LtNQlJDDT1ZtrN8fdlRYo2GHtql2cczQYpJ11g2C6Mm?=
 =?us-ascii?Q?rahQvDO59lPBSa7eoC6KXaL6PulygsbgrB6S02PMmN16Y4c39HUA699e7Ttj?=
 =?us-ascii?Q?+6j38d+Te/rSuaYdeuF4C/nAGLQawTvBi1f2TwjR7gYUObqPvufAYGp5jVK6?=
 =?us-ascii?Q?TFeshLYKHr4eeQu/XYs6Yj94WwTex/NgqTpjX3JZabNZw8peQQ7Oif/BAB27?=
 =?us-ascii?Q?Lqih5U39pvFI5SqoHy1eNvR8GYoGTB7wJ4mfNnSqhvATC72msmyND0gzM4BM?=
 =?us-ascii?Q?yLb+S9zAUyZC9sOuXUMYaxn9KGjCiM3SZZRXRa4/GWlRVUr3VeRD7NAWN2G7?=
 =?us-ascii?Q?eS0Sv54RTPIxc0fmd4YrhvB/+Id54lpbWVnpdfBKmdKYtM07C+R1F/a7nrO4?=
 =?us-ascii?Q?0l8m+Ap+a0LjS0jtAHtOi4eTlL+Xk+mfPJG2nr9uMuljR7vInRZ/lv3th1Vf?=
 =?us-ascii?Q?1seNVeOAhM328P+Teqjxw0qPojfPwSBcWm7VQoCY25bM15JebEMI1wQZGQbk?=
 =?us-ascii?Q?gdNXSnJCx0VunizO1K6lpUzbYGbfX0F5iFjmp74LR74OB3S1mkfzdp88uPhb?=
 =?us-ascii?Q?1QfIej+OAdWbOSnEX6SyL6l+LLPwooLHNRcrqtKlEI6GdR43EdmVarBEzZKL?=
 =?us-ascii?Q?lHd+Pj45dq8c0c+GzI0wZLC5tLW5/IlN1SIxINkU+R8kilaf8IPZCKX8pIAO?=
 =?us-ascii?Q?Gxm8rSkMthfVcs+dZSHdcYIalR5OkqrF+xcCmIGWoQinKCtsDTti53ZuFiNH?=
 =?us-ascii?Q?PnT50Jl4vHFafrU+BQT/bf5Dkau7Ncjx+vA0v0gG/94zU22x/Eln?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b7c74ba0-8714-4560-b8f3-08df0ef13683
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:47.5062
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 22ewCWtMQl2kLmbvFFTbvkJOVRcArbLfaXbyVIp3Ffjax9nRopJzWU6ybTP8RNryrdvhHjLi6e/34v+irCt8PQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_transport_free_queue() cancels qp->link_work but not qp->link_cleanup.
A peer link-down message can queue cleanup while ntb_netdev is freeing
the QP. Cleanup can then requeue link work after the queue resources
have been freed.

Disable and wait for cleanup, then link work, before freeing resources.
Unlike cancel, disable also prevents the RX tasklet and transport link
setup from queuing more work. Enable the works only after queue creation
succeeds.

Clear client_ready first so RX completions and transport link setup see
that the client is no longer ready. Clear link_is_up and active after
the workers stop, since link work can set both back to true.

Fixes: 7b4f2d3c3b82 ("NTB: No sleeping in interrupt context")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

Reworked from the corresponding patch in the direct TX/RX series v1:
https://lore.kernel.org/r/20260810165136.2292436-5-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8dd1770aaaf1..e5599c7ca93f 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1242,6 +1242,8 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
 
 	INIT_DELAYED_WORK(&qp->link_work, ntb_qp_link_work);
 	INIT_WORK(&qp->link_cleanup, ntb_qp_link_cleanup_work);
+	disable_delayed_work(&qp->link_work);
+	disable_work(&qp->link_cleanup);
 
 	spin_lock_init(&qp->ntb_rx_q_lock);
 	spin_lock_init(&qp->ntb_tx_free_q_lock);
@@ -2155,6 +2157,9 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		}
 	}
 
+	enable_work(&qp->link_cleanup);
+	enable_delayed_work(&qp->link_work);
+
 	ntb_db_clear(qp->ndev, qp_bit);
 	ntb_db_clear_mask(qp->ndev, qp_bit);
 
@@ -2200,6 +2205,10 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 
 	pdev = qp->ndev->pdev;
 
+	qp->client_ready = false;
+	disable_work_sync(&qp->link_cleanup);
+	disable_delayed_work_sync(&qp->link_work);
+	qp->link_is_up = false;
 	qp->active = false;
 
 	if (qp->tx_offload_thread) {
@@ -2247,8 +2256,6 @@ void ntb_transport_free_queue(struct ntb_transport_qp *qp)
 	ntb_db_set_mask(qp->ndev, qp_bit);
 	tasklet_kill(&qp->rxc_db_work);
 
-	cancel_delayed_work_sync(&qp->link_work);
-
 	qp->cb_data = NULL;
 	qp->rx_handler = NULL;
 	qp->tx_handler = NULL;
-- 
2.51.0

