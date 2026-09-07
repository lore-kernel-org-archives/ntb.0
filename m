Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021112.outbound.protection.outlook.com [40.107.74.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C103A6B9D
	for <ntb@lists.linux.dev>; Mon,  7 Sep 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788791094; cv=fail; b=rADEpeXWBUMNI7/mphI1nbvFb45oaHswE2xj9XlqlKWAjIT3FJq9XMcXHI2jZO/pchAk1w4BfjW4xDotKhSkX07Hx1zHjIOqtMtRJE+mEy6P7f3ftDC6ioznuzmXnKpq0hAqlKyi780Tk1wby2zqr1w9YR1coq8mfWHf5WzMKVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788791094; c=relaxed/simple;
	bh=QRQuzHVbA2WiPk1hCL7dyD/tUDWq4gyP8+WFzOQC1jc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=G/+1QNyA1mXGWHaEYNu9ZtjV85ide2OiXCkkSJcGVquvOP07qntZpFPbnIhpcnKnlyfxxJQ4v23KIg0SoiXarLHgaie2o6kAclwzhs7P/B1mHvJmg59eHdQXDtcWIcjt3zVYbBfFXg1cd2HEZdMkjmj1F3XrulX0jl2vpWt2PRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=Gsi4JzTf; arc=fail smtp.client-ip=40.107.74.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="Gsi4JzTf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gf0AiJE1Z5UiNbM9J/SL6dszyRfGGayn3JiYJlSI4mlaFqli0gJjPPm1PtawX2hr81deAodpzUOfl05+1Jg2VrXUuXpYkKXPiKbgIDVOac89X2lgZBrFeidCMLU+YKQatIHjXeSpe2kaiJAN5uj4yUuG6NIVGdhJsaBjWQRt2Kw2j5Mv42hL6NZbDiqJWQm0IwTx/aKp1pWgT3iyUAcOIyEDMTxYpyRdXzOjt99MEBJ0gFjlNXPJErihK5yfnvp0j6wQYqdqIDI9C0hK3RHGOr7avw2zwEV60KH5EIXedIZlK1GiALupmP8phYqWaJXs+ZeUbzH49ukfYPjZ4dbQ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qrv8QER681hTdSgJ8WwkcdpOlc8sRPqLG+iAjCqknmI=;
 b=t99j61bl5fycW2XxSndc1tAyNDkfM3QSitOT4eCW0UjQ3LDIEcETD2Y2oa870OHABMV+IBtuPywNeJFSMVJQmfu9A88WpLgqc2Zb1A/1/IqsWqVx9A2UGpUL04/f0GqBpDMBNCjBcQykw8SG1HODG4k4tbrAhAXIbu/NqHJJ98JgEFSXcX0CzeHixFyxVw+cwlCGQptfU6ZXXzo/LMCIB0O1OEjnwfMqTF//yH7uCJl1LP+sZA/OS9x65N84cksqIuuIrY+zs/Srgx+A8dTYQ/iw/b/SgXgfRi9MCjuDsP2Q2CjwJ4+dvKX/c6B+yc8eKsPmGDEG1LEF3IhMgQGQmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qrv8QER681hTdSgJ8WwkcdpOlc8sRPqLG+iAjCqknmI=;
 b=Gsi4JzTfs0C8PxoJWWmyNG0WQy0/kjqB8GuceY/cf0cSB8yk8pBmxLpvr3C/R4K9W4HoQdu+ktlp5FD1URRO4/hSouKdYUOhIixUlNh/EuMklAVcUB9rP/YvchqM65MR06wJJp/dFBjFTpiW5Cs0D7FE0MJKTJOjFWKvRy9mFWw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TY4P286MB7581.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:34e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.15; Mon, 7 Sep
 2026 14:24:45 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0382.014; Mon, 7 Sep 2026
 14:24:45 +0000
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
Subject: [PATCH 04/11] NTB: ntb_transport: Clear QP pointers when freeing an MW
Date: Mon,  7 Sep 2026 23:24:22 +0900
Message-ID: <20260907142429.951930-5-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260907142429.951930-1-den@valinux.co.jp>
References: <20260907142429.951930-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCPR01CA0126.jpnprd01.prod.outlook.com
 (2603:1096:400:26d::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TY4P286MB7581:EE_
X-MS-Office365-Filtering-Correlation-Id: c2d88e72-b4ff-4d8d-c672-08df0cebc416
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|23010399003|10070799003|6133799003|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	N9Fn7uHi0yQkJtIf1oRAfxWjEtYjbJF9FwvlVpZKUb43C1DOnIjick8kFIS6/lSxqo+93cOg3Zzd0gzgJQm8MpL5bzG/yQwOqIMzi1FgF4mHmJa8Cuikn6eYyFtqEQrChnE3ktxQ0Hf/sjlJzgATEtmXT4cDycJj9wdPzIWPDHzG6ZiQNgL37LKzpnYXbwiEdRuub7Q23iAp7evXeR5yffLIcXg9tg6pDbhFbta4j1A8sxstxJQG+8iLLGOj1TvocqLMnj4mei/+Wbcd3bUwhcJMEgWpzJfAZ4o816jiJjUZfNgfodi4WMrayGVeQyaiC40bzUifpvrpxJDPrSzomXL/wSexupA/IXVNYtMuvHbY4FvQh2s3d8ogqwHDLgTE/5UYd4M3kOicpb4wtDEkHzrjMKEqMLtLnbWo49EtqTlXr2COKtH25twZMIKbEE+yWKiwY9r7eYJ41EbXXzzCCb1q5iQeDq2mKsfDdLzdRiPKdExP9luojB35BmSsGsEZWOmH6EBuXBlcV0i+HisIa1I+Vuk2/e2NjzC6APhzSP9IZfA5/Nswbk79LlUBWbhfEBwQO7b7Voebv2Fy4dGcnX0gjIhEDi80amiysExF2BxidqqfKVJxeKeh6cw2SleGfsnKG0PQ7AfY7TbrAHm9eIqIbwyU+Ycj/l/e5zZMyuo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10070799003)(6133799003)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?02/nmzhh6s10bv69sMgbK2vf4RKQgY1V2Em6GvbjPFGf8YbJZMPKIWbuG1mB?=
 =?us-ascii?Q?jjKUN9nSgkJ0c/A7u1lEhOe1OlEshTxg0W4Kk7bWM6HdwUqYd2xLjFK6HWYi?=
 =?us-ascii?Q?i2WxaZRIxK63w3euw9DOAya4Y7x+EI1cZNJJEcl30854E4r2PxDf/EjNLdHk?=
 =?us-ascii?Q?6C1iiAZlVB7tp40j8fPSvQtMPYK0goBSTEtKE/KeP4OlGO4P72gUHqVxP0Su?=
 =?us-ascii?Q?LC/fITViq9AenDzUD7VVKFWMblkd4y/d2AVDwlAfn0BQbJor1/ydcZKolrci?=
 =?us-ascii?Q?D+UHQoFc361InyB2ircM1fvo8Xp57VRZ1LPUqapvdbrZ8ZVnNRdISExHFhLf?=
 =?us-ascii?Q?3ivzPfI7OMDCDwYmR/E+Ku3Hte+JrMPuFqjMdgT3jdTSIABDg0KTwfmmdG/v?=
 =?us-ascii?Q?Dud1HUwx7iazR1q5dXsfhM8bQSzgUoykVcNdFbii1Hzs8MemzHJVK0rGXl87?=
 =?us-ascii?Q?ou2dyqLNhlYIza2iReG/R/BePTURpeQlOexDzEAQ94Ez01yGonzjc26uicNv?=
 =?us-ascii?Q?V/kXdJEqQJMO3txp3OS6Wjjb/ULdCTgVMtCpSvBdlWhxPRwNSYBRFPTUOZMY?=
 =?us-ascii?Q?6d8wP+/Oc1c7vWNJk0m9W67WQuDPZpYa8gESPrJeZcHzBpqr9x9eisKMG943?=
 =?us-ascii?Q?oTvUuAkWI8EOOEz2UQiDlSmIeU4lAwC/w/7LKVHEaoWQZjkEePRM6day3doR?=
 =?us-ascii?Q?eEsfXG3KKsAB3WliXDzl8jgOAKMeMm3+klwvrUeZtirOanDuaGJyZ9GD94Zl?=
 =?us-ascii?Q?3nON/z90mCEyLrVjKPElGjoS2n5oSUZXzKNq3YHpKX3KhbJuiIbb5c8RtElz?=
 =?us-ascii?Q?Dpx4Ttkm13e6O5cNsDqIn2Lg4JCzyoRSX4hQqRHmj4KRv7ZNshFRIZYsC/sN?=
 =?us-ascii?Q?VN45nMtWeW69P+/1IoEdqQejTdLxlXmg79SFmFQzk6PRjxArNDxZ+e1rnmu8?=
 =?us-ascii?Q?L5966RvcjxU4qj9fZu8C/2UGeO8t/ai7tgvcFxwnUbCTsiFvTm2aAn0q6ZvV?=
 =?us-ascii?Q?oBWdbwG4Dc3cbEv8LmGZHGaNKYWiEdE2hHAXTO5qIzJnn5pcAzwD10J+joPP?=
 =?us-ascii?Q?yDxhI8tTNdXXstEiOr7pk2afhLA8Jyi4UuRFk+MzhTECKsM4DiC5r8DnsM0F?=
 =?us-ascii?Q?6ohE/y5UEjYZevoeVNb+qGXzepVOQ8YWkvJT1u12AKAku0mHdYHwaEupAwCA?=
 =?us-ascii?Q?Ou8Avxcc+oGi935UvW5gN6qRJxzaytOQ+FakhGVPjY4ULEBOAJepeGuzI5AK?=
 =?us-ascii?Q?u/xG3qyUQp+XyxJLBwAqWvU+qgz7qhd5XJLYOeYZRaKltTnDOP8P9P90/gLx?=
 =?us-ascii?Q?t+mA7Gpggn4+dIjW7QU1IC+vW4sEWM28gO43hgnJzPDCyzZQiZv0uAjl9NXb?=
 =?us-ascii?Q?6GASK7OmrnYL2XRc3ySsGhnQrN43cXHMm+ehnSoRE4Voccq21WrJEiFPkX2w?=
 =?us-ascii?Q?MTk+Aq9Gakr2u9Kfrl3HXhQM8X06yogwARkaxjitl7CQvUeMcv/6LTuU75MX?=
 =?us-ascii?Q?cpDZMIOeqTaPMSj20gk/u3apn95wI0YleNvlHBnxPeR/7+S4RufzvUXqPRQB?=
 =?us-ascii?Q?jA1hhj2v6cnENNvvHX0Qdgm1Bb6DEIJk+kZoOBncZo8IyPcg5oi2L2pEelPO?=
 =?us-ascii?Q?j2EOX8S8Nvp+eDTTbVTt9n+4nI0aMREr1rix05FX59iiGK6k8WhIXdWU7igl?=
 =?us-ascii?Q?xPq15cbjVDPj0wqCRraqrkREmvYvJwLIomfa7ida7YHRKhUQ8oPOBAaMjhrv?=
 =?us-ascii?Q?RJnfi5Sel4u9hYi12ERfZPd9RvtmtR8fO5uR7KujSgw50SPn0dXo?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: c2d88e72-b4ff-4d8d-c672-08df0cebc416
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2026 14:24:45.7029
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mUvOKmaTQYw2ZZB7VFtzStCbHMwoOy0ckGanTMnp9tJXtLo6EiEyDHujfUFENIQu5A1jQGrdn4/vLaiwmECuxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY4P286MB7581

ntb_transport_link_cleanup() frees MW buffers but leaves rx_buff and
remote_rx_info pointing into them. With a QP still allocated, another
link-down notification or transport unbind before MW setup runs again
can make ntb_qp_link_down_reset() write to freed memory through
remote_rx_info.

Clear both pointers in ntb_free_mw() for all QPs using that MW,
including those without a client. This also covers link-setup failures.

How to reproduce:

  1. Load ntb_transport and ntb_netdev on both sides and establish the
     transport/QP links once. Stop traffic, but leave ntb_netdev loaded
     on VHOST so its QPs remain allocated throughout the test.

  2. On HOST, unload ntb_netdev and ntb_transport, leaving ntb_hw_epf
     bound:

     modprobe -r ntb_netdev ntb_transport

     Transport removal sends COMMAND_LINK_DOWN to VHOST. Wait for
     ntb_transport_link_cleanup_work() to return on VHOST, using a
     function-graph trace. The "Link Cleanup" message is printed before
     MW release and is not sufficient to establish completion. Do not
     bring the link back up before the next step.

  3-(A). UAF via repeated link-down notification

     Use ntb_tool on HOST to send another link-down request:

     HOST# modprobe ntb_tool
     HOST# echo N > "/sys/kernel/debug/ntb_tool/$ntb_host_dev/link"

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_link_cleanup_work+0x2c/0x50 [ntb_transport]
      process_one_work+0x5b8/0x12f0
      ...

  3-(B). UAF via transport removal after link-down

     VHOST# echo "$ntb_vhost_dev" > \
         /sys/bus/ntb/drivers/ntb_transport/unbind

     ==================================================================
     BUG: KASAN: vmalloc-out-of-bounds in ntb_qp_link_down_reset+0x2c0..
     ...
     Call trace:
      ...
      __asan_report_store4_noabort+0x1c/0x28
      ntb_qp_link_down_reset+0x2c0/0x2e0 [ntb_transport]
      ntb_qp_link_cleanup+0xc4/0x148 [ntb_transport]
      ntb_transport_link_cleanup+0x314/0x350 [ntb_transport]
      ntb_transport_free+0x68/0x588 [ntb_transport]
      ntb_remove+0x5c/0xa0 [ntb]

Verified that neither test triggers a KASAN report with this patch.

Fixes: cc79bd2738c2 ("ntb: Clean up tx tail index on link down")
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 944d38c7efd3..763e4bb175a3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -764,10 +764,17 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 {
 	struct ntb_transport_mw *mw = &nt->mw_vec[num_mw];
 	struct device *dma_dev = ntb_get_dma_dev(nt->ndev);
+	unsigned int i;
 
 	if (!mw->virt_addr)
 		return;
 
+	/* Drop references from every QP using this MW. */
+	for (i = num_mw; i < nt->qp_count; i += nt->mw_count) {
+		nt->qp_vec[i].rx_buff = NULL;
+		WRITE_ONCE(nt->qp_vec[i].remote_rx_info, NULL);
+	}
+
 	ntb_mw_clear_trans(nt->ndev, PIDX, num_mw);
 	dma_free_attrs(dma_dev, mw->alloc_size, mw->alloc_addr,
 		       mw->original_dma_addr, DMA_ATTR_FORCE_CONTIGUOUS);
-- 
2.51.0

