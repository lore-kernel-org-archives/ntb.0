Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089F39E194
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791091; cv=fail; b=qrkfpG7y/BiPDtQWKidcKGnccND7LPWZ77ZAQVAjDK4VknTC6Z3V4oqRHJPXDwaIpXkp3DrAmnd9tzfof16nGd3jSWpPeNbBs3IvQ+GqMZU7RGr7Zw5iALLHXKRwbh+VXW3/qBM/VGLDXqL005IRvHt1pte1DYKH2MPAyIciFg8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791091; c=relaxed/simple;
	bh=MGBcmJ6NEEShRoTnE5/6IH46YOUyd2nN6tpQslZwB3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OX6OU+GaWWpD3WIJK/zmmtK9s2Xjzcwl4G/R8nwZ82MQqaU9Cwn4DKggo7nJUM5f2ZrSsjNrgZ8sgNM8niqRTZXVQ4dwdrv/VefZYGab0rZh4I88d+ula1tXuvzGirSqOq+s62M1/8W/JyieXmxoIA+EW+UJV1qkLkin11N7deA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=ELuxApS/; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="ELuxApS/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w1iIH8yV5Qnuj5aKziTI+enLxybT0IuIqL+xvaL7jL0w63dDfSQv2XGH5bqne4rVFUq3Qcdgkhb4xvs/fQmzzSI1+Hjbj/DbbqaAAYRuZp73pb1KVemYYPR+TRLc2z7kPzmheciwJrz1YrhowMOOsYvgTLjCtUFWxVACeVT2WH934qAti90+jg5K7eSCAdhc58hZIAkfPS64HH0gYvXFB05z/pQnx/PztQhelON8xIbakZDLSvcP8MOnk3AxFa4/EX1WXLrs5/egTYl4WRW9XnpeFLghfJ9irqisRudKTAG92AYPmaeTFH6RBSNXkW6pCrWWROHsvwV9DhinVb8iMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Xhdy3uLiXCT7kjNyObVHkE4aHOYBp8kcd89OEswlBI=;
 b=yKDvsHQb+00o4Hi+tlG6pzgtTFOToRDBV8QCM2wFwcKt1+Of6KJ4bsj6BZlds22E7iouZGgrq2hC0GbJw0WUGQO/hLVx36tuQsvcH203GXtvEQojkAnV6IwPVzyihvO5VMbpqVVtQmnS59c43nfsKKdd76y0kR7ESDGpH4FbA+iCgM5eJB+Xn4Yt04MBWsWJHVs3xP5vl0WUM43pU5KExiNAX1Pmp5YzunSmvP1ONqt9VTnS5NOaW4q9B9ZdiofAAS2IP+ubIPEv9WXXpJ08PYUEHse9NX4gDA31hRxxWOXzxen450HG7AghrU3XLTZ6eSRy/KY2Fp8Y7YiTw9XQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Xhdy3uLiXCT7kjNyObVHkE4aHOYBp8kcd89OEswlBI=;
 b=ELuxApS/Ksi7nNUt9L8GnKc5Og98tVTzy2qF4MgmlDI47BtaJXmfjpVQvyBnitFzCemGxfqoHKX+R3XX84ncFHQ2/dA9gXlvuLmECr5B1f/I4dfAddzNGtmRYC0/FTzEwqrMrbb++RzUvmx6+RAt3Cy9weJZnSnOGcoZeyTPTxQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:44 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:44 +0000
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
Subject: [PATCH 03/11] NTB: ntb_transport: Prepare remote RX info accesses for MW teardown
Date: Mon,  7 Sep 2026 23:24:21 +0900
Message-ID: <20260907142429.951930-4-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0302.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:38b::14) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: ae481a7f-2536-447b-0de7-08df0cebc398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	TNYcw2hzheo1ds9ppffPR1rrPwaz4FUo7bmNGNiTnMT9tLztEJsy2h0dlWNf4UUAJ0nbCD9COSwercn5KLsWMZN8jpnR/SlWM8UXCTZycG8xh2ysMQfzIDvmKjbQL8iG2OMYY1wwbX0XzCkRf7eRrg47h0QKezi9SdoS6Sh7pl6TdOyH6mucJQBHX+dD0zXkcGkMU8wJz7N3eSsLJPH5F5T7B76iCsNGnRC05csg2IlklVUucu1QRGUYB0AnAuvsCGiY7tYEwnfriKqdmWhvpdfGOq5HU86aVWCizDfqaM2ZgODpLgcYgX+CKft4v/adXs+5AVJmVBu/sckr9LXcXqHD6tQVSXqcdoAhT4FbzJvP3+y0lftyoHpGeg7NEQa9SDSg5qNLI1JF3dLfoN2+/leeL0WX+6RowOamluBY07Y+BExQIx+4USWn5ThuvwjiypMhM3HDLyA/ngisr36Ny7tbPZozsQRkNhH7kKtWFd9n8K+F2T0lv21gXDPGTJqyYq/LeUaE7vrSGAk0+xBwJ3a35MhaHof1nCyNceqpM6+D8At2YYl2Rd84DHLm25lRdOrIzb58FwxE73ZJTpcbcT0JSwBxf5ApepDwL/FvbTzRbiVqjt5e2GUonfWLwfXDtUf9RE0gAEZxKRGn7dQwQfLYanb+M47V59OKViaUrSk=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7QruuEYhVr4is/2Q+Xk4JHTojH3Qu7gSUN2aPgZf29FscWfF2XkGv1G0XXxw?=
 =?us-ascii?Q?PnOfa9G1AY3CTcTl1ifWxO9SRFnR8dySSlP9FHGSWtvU24nCKgn6+4qRfbyl?=
 =?us-ascii?Q?Im4yzSAEUvQClLCTsemoQP6atdDNAx5t0DBwQEIVmJcFCd7IDy/qIQjMQTxh?=
 =?us-ascii?Q?v6JfnWoicbx0/6wcO4Tdt5o5orUSfwTiC1xFC9S05VdidzvQeKrLIKf6CTkM?=
 =?us-ascii?Q?ZOl32faJRD+5ZIu4yzvBp1d5pHDJDTBYGyhCvzkizw4CE2CngorUGD2jVeWx?=
 =?us-ascii?Q?Q7xFEne3qVtp+WoT9Y+tclw4opqi/kQU0ZQtQ//+Dz7IS2xDqRXC7dRNZQhR?=
 =?us-ascii?Q?ppLdVKkUtkuiP9pRhSPjSov8BappJ7A0rVNuNBOkeKrX+yKUJkaOx9brV2tF?=
 =?us-ascii?Q?f08EMHII4egJJkWxTuGcAN3ZI61Ve7QZM/ATlTMZDJeZ2c8qFAI5OBRhsPAu?=
 =?us-ascii?Q?XRBMno1DdT0xvXSSRXm37YYXxOQAP5NNLbocpizwyPAg1INAglOhQgAd9vT+?=
 =?us-ascii?Q?e9Xi9BjyFplILPPhgh5e6lFGFuW6t9z0nJJ39X4sSgS8yyw8EotR3/xBs8xv?=
 =?us-ascii?Q?R+CsNDI70GZs+GhVJNvRwCoY3jSO5X+Uorc4UcDNFTnp9fjCWu3iF4YXsErn?=
 =?us-ascii?Q?/7QmVg1FDwha4T7YKBPZiZgnblz9ndLd3ygtv78huPtJRG+ZUzKFfrESFk3/?=
 =?us-ascii?Q?11dQUZ6IzhC1s4J0+WD25ihb2mgT7tVU1NP06v9arPsRVOapUfc2ZdCeadTH?=
 =?us-ascii?Q?4eGq57y6nzMJK7AXWjVYogUVHqF0AmqZRz8TDgryqYFoN+dasJ0/tPkHdaqJ?=
 =?us-ascii?Q?ENSReIXssY1FILNIWe98v5KwXBrqf9iptoA8ITSOetttq7cI/UoQngEOpbdw?=
 =?us-ascii?Q?edkpyMduOZ1DZklnsqPNuVRDBDIKnXfHgddHrIeuIGZ5Q3FDZPxRBk5iSBfk?=
 =?us-ascii?Q?yelOHtZVXa24FcuwsWC8gZ/P6ZkYqEAT21DK0jx3600o+pMLHKxr7eqO6kEN?=
 =?us-ascii?Q?99sy9oKa2w1wMVlu4RbuJiNcr6STefkK2szJDBJucSWbhldom0ERtB0X+HRl?=
 =?us-ascii?Q?+rHbmF/YUV/MS8W7lpj/UvWw4wSyix+lgUPpsZkk/cQ+NKoESTFu/9yDlQrF?=
 =?us-ascii?Q?dID8FTB06ALpPDVBJMhXcfpbJg617uGTuNmIZYqmcTI5Fz08ToM8erZB9g/q?=
 =?us-ascii?Q?xF5bg0Mm7VBTdeWdlhGfpI6InDic8rQ2IHZ1SqPbty8oqq2Nxp6mfiA0Km/o?=
 =?us-ascii?Q?VmbBgbBuDJ5Hm2EUU3ivE6H9vBLl+yehcLkP0yVDHTlTPgMEldRYSsfC7LBQ?=
 =?us-ascii?Q?Wcz+HI8p4B9YB4GMAXSw+naJnu3zzgvURFlN6KvMYm/3dFLHWgUjzShW9qEy?=
 =?us-ascii?Q?yhM3k44K6RKQiPy+d94sSjZq+Pk3YEmLuFne+hlLCrDtApd9PqiGf3ufKyoy?=
 =?us-ascii?Q?lkY/WfX20bY9aVhaz5VjZTbZxP0hX6ycIQVtB3mRZs3qc8mNWAyzibDZk2dX?=
 =?us-ascii?Q?QlO1d748XCtbNbgHKzMNBQTnYD8J7rOfAQYbAuw4mWjgUhCrB6MN/ejIcusS?=
 =?us-ascii?Q?HGwFmynqKOmGlWkmsWo0/3S0Vf5lSNtcoX0L+K4uffACkHM1INFK1foT5bdp?=
 =?us-ascii?Q?PXEiXpzMvZOYW2zvfd6K6ji/Xms2aAzecguOr4dALr/7H+GrJSj3Pzvo7//z?=
 =?us-ascii?Q?7nUJyRIJthI6dCSnhuyI0Fg4mo+FYVJITet3+96jRUBwCR6Yz5rxtQQX7k6p?=
 =?us-ascii?Q?mvKBe1mTXXmowqnA9jLplse8THpnyTGz6u5HlSqxHr2wYerXnNu+?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ae481a7f-2536-447b-0de7-08df0cebc398
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:44.8925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tDpkj+e2UYzMvfaHAmIGMqN9orfxlYLWeZ8TAXo1XYwgWDhRmESr8XxwoMJQV2yKnlOKMT1rsLMeaZMQehlHRA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

The next patch clears remote_rx_info when freeing its MW.
ntb_transport_tx_free_entry() and debugfs stats reads can run during
link cleanup, so make them handle a NULL pointer.

The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
to prevent compiler-induced tearing, and retain the read value so
the NULL check and dereference use the same pointer.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 55a20ae9a85e..944d38c7efd3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -487,6 +487,7 @@ EXPORT_SYMBOL_GPL(ntb_transport_unregister_client);
 static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 {
 	struct ntb_transport_qp *qp = s->private;
+	struct ntb_rx_info *remote_rx_info;
 
 	if (!qp || !qp->link_is_up)
 		return 0;
@@ -514,7 +515,9 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
 	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
 	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
 	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
-	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
+	remote_rx_info = READ_ONCE(qp->remote_rx_info);
+	if (remote_rx_info)
+		seq_printf(s, "RRI (T) - \t%u\n", remote_rx_info->entry);
 	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
 	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
 	seq_putc(s, '\n');
@@ -609,7 +612,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	qp->rx_buff = mw->virt_addr + rx_size * (qp_num / mw_count);
 	rx_size -= sizeof(struct ntb_rx_info);
 
-	qp->remote_rx_info = qp->rx_buff + rx_size;
+	WRITE_ONCE(qp->remote_rx_info, qp->rx_buff + rx_size);
 
 	/* Due to housekeeping, there must be atleast 2 buffs */
 	qp->rx_max_frame = min(transport_mtu, rx_size / 2);
@@ -917,9 +920,12 @@ static void ntb_qp_link_context_reset(struct ntb_transport_qp *qp)
 
 static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
 {
+	struct ntb_rx_info *remote_rx_info;
+
 	ntb_qp_link_context_reset(qp);
-	if (qp->remote_rx_info)
-		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
+	remote_rx_info = READ_ONCE(qp->remote_rx_info);
+	if (remote_rx_info)
+		remote_rx_info->entry = qp->rx_max_entry - 1;
 }
 
 static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
@@ -2487,8 +2493,14 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
 
 unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
 {
+	struct ntb_rx_info *remote_rx_info = READ_ONCE(qp->remote_rx_info);
 	unsigned int head = qp->tx_index;
-	unsigned int tail = qp->remote_rx_info->entry;
+	unsigned int tail;
+
+	if (!remote_rx_info)
+		return 0;
+
+	tail = remote_rx_info->entry;
 
 	return tail >= head ? tail - head : qp->tx_max_entry + tail - head;
 }
-- 
2.51.0

