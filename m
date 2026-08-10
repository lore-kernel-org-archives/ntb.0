Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021111.outbound.protection.outlook.com [52.101.125.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA232434405
	for <ntb@lists.linux.dev>; Mon, 10 Aug 2026 16:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.111
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786380733; cv=fail; b=aM+L66DssPrm/gkASVNS1QTgRQN72oh4slIM/JIq23vICamN4j7RitJ7SZIpyquOKijhRtZra2RisH3Xj9tBJRakvWt1eJY+HadfY3y2CaFGgmRf1uJygLPI+pXRvSzc5DdY7lA4pcZdiujRjgVVYNhHd7tHJxHc+zZ0KcU61Jo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786380733; c=relaxed/simple;
	bh=bvPDmpy/Pf20RenlHvaSdO6hFdFEznu/iarr/DM17qc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ij7+dsBq+dB8qnUg/yc3ySL8f8cZS57YxfAbxFxtMfUYxj1PxKNPmhyCXdDH1+8XBDeCT9ZfsJebLnYyTpVt5z14M1fMOLFRyjMKDlF7Q+tqJttsB0XZyWfTMdETG0JXZ7xMZXK/oZq5WrJ698XIY+PO3NwmF0KcjZdqwrE8hRM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=BxlCpzIn; arc=fail smtp.client-ip=52.101.125.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="BxlCpzIn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TJv5O6ITCQSZB37BGelxIgVcOnicW9fUOzF7sTsFRTzvfINlnmLmQrwEpAdf6A55/9h36D6iLy7283wYyMxNU02RMpJOoRLRZbdbGCKmcJMsO4Mwrf1OO6yHN78vCiWPnZf+f7TGmpa/iZPbbO6a0+Mm/J0MCucxfXGFaGpiXsHri9Gcm10HmHD8NB+Aq/Z3mhfhdklHBbb/mL7aHAzUeuYRCTysmalEDkzR8ciGjKSvkgTlDRtIGqSw34sWSdn8oTT29Ah7/N5/r0t/GLBk5+V5W+rtDGlEcfkWwsI3KrwD1mExT3FBLFfhPqBDOrwMqm10tvfFyAW36IP6nBoKEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qnqqqSPS5/G8mvZnxNvT5kdrAWZSHAkWgqVc0FLzwVQ=;
 b=VH/I5ifMpZRnfm4uYBbEMGKwc08IgFe88xmDJZSTQmgtudr8kYmoskJtRy1LbKOqBRZ0ECu6MMtUOv/DfpnhgRViGRgx1U2RCrFaV6jHnnmCYwKXFOkW5+d2HWfY8EG0Cb7/QpEtD439EnfFuHs2Qkzl8dCL8pIvdwjFzNRo58qtM0Ou2bjPivEp6IIwFc/i9cGfNdXloSR6SFctwW1L58zbVDGFdeDId53m1Snw3fPQweMyNKHtLLR4I5sj6vex+i1yG3X8twF6a6LM0rrbRZnZJ8u7gFdFUUAVpZvNjU9C1slyRCbfSNuWCbM4vPPfejjaZCMo81QGraSGVuhlyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qnqqqSPS5/G8mvZnxNvT5kdrAWZSHAkWgqVc0FLzwVQ=;
 b=BxlCpzInZeIEsAJ4IQsnwnOV58qMOEH0eGl3AOPynpKAFocoxTCLq0/iMbJz3fEea4a8BMJWwjQWOGiN0l2RV+bCgYGgVACPULN/MIJKrTsqZx7X+tlqnO6LWaKjz2PaLnc5J+rxfyBd3IOwVo3i9It70N1/NHgmV57o8Y5i+74=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6729.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 16:51:55 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%3]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 16:51:55 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Frank Li <Frank.Li@kernel.org>,
	Allen Hubbe <allenbh@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Niklas Cassel <cassel@kernel.org>,
	Nicholas Bellinger <nab@linux-iscsi.org>
Cc: ntb@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 15/16] NTB: ntb_transport: Report the direct-DMA payload limit
Date: Tue, 11 Aug 2026 01:51:34 +0900
Message-ID: <20260810165136.2292436-16-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260810165136.2292436-1-den@valinux.co.jp>
References: <20260810165136.2292436-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYWP286CA0030.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:262::20) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6729:EE_
X-MS-Office365-Filtering-Correlation-Id: a39a17f4-5271-42cd-b3c3-08def6ffafa6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|23010399003|376014|1800799024|366016|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	GrXXItnMDTQteeyN2jfBhuMHPCkPxPxf5cCHC+mtnZdOElNtgZx6v6PuYFx5XLpuNAA7rANxZYLjFFVX06Icot4IQsyweL/Q6IYTcUzVml0TeWMwprja1Gdu/H3PrQ8zoQAz7eP1GUJHrC9ABcwgx5Dj7ADIDfDS8MW5/qAR2sgDNcO+X1mfbe8+p439jRYPg4wDp2pXGcn2txLfButWDQwCCuER2WQBanSBvLElrWAfJ0+7jclG7l42lXKP7ZQxgIulDo9o1STz4YxA6Ye7pzmmJxhaFFcfCPNYiHvZ9FgBN4CkfhYWJn4/KNXwTszOfwZjJEPNVUdsD0NMjbAqkp3f8iolLvQ/ZhDRwBjMtqwYApXsmjBMsHNWaJqxRwTYgiMCDIx9bNFLckr6dgDirYhs+gOv6MnjlW3b5XiiqVzNVTUAb84+6SosoJwweCsU4iO89wm2fIuwtjWd4RkG4avzAla87Es/5c2z2CgHq3nMvn/5OPaHuSuuuKmNHhS128beyu+cL4oWA+ffbxFuvKcob8BUvkqzK56yxpK2hkY2RUsb2zISOFQsT4vei15wI7LgdKGzOgsfbQJYVBlqHyAdPp8aagG/GhpqABMYNr/w3F0yWaVu/dKEMaOlHsNeim0MzDhJ3vWMf59Ijmrxdgk5xdMuu81VLacpra+jbG4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(23010399003)(376014)(1800799024)(366016)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mIJN3kyMaKGGL6RC+aYZU88ttiB0sZrjsG398NYJ5B+CyuttIgBQOp2sZaz/?=
 =?us-ascii?Q?KucoX7T6ZKkd2Y+/CHJjac++8LaY5TADsPtsjXIVcMdKDfej34zD3QVuz7KA?=
 =?us-ascii?Q?Amoskdkcu7s9MFoRWJCTzCh67tw0w/MB9PN1DxkzMZV6jurNfbc5t1/YvJoB?=
 =?us-ascii?Q?P7UHFrmVERcdY8NkHgwQaki2rJdM6+u0C+v7J1aV0Se6kn9+6+q0scKyVH3v?=
 =?us-ascii?Q?U/J9HsukA+i3Dk38jojlRPp7QEEAuRFp51xRFcCUHhz5HGVD7k4O9VXbRnqw?=
 =?us-ascii?Q?/BdV79py0+yGaGYHqyEk4+C03Tad1ZwFmh7YVVqsocCi244s+QjSeTEgrtdC?=
 =?us-ascii?Q?2TTaRIHSASsQhUH25n8VHn45NTATzxLUieO+j/pyoY6QzQJMl9GgSowUe9wr?=
 =?us-ascii?Q?bAPX99wccpR3yu1yuZ0LcxkOmdLSBOlx81VH6AhxcgfFQqMKCpOIQKmwdemz?=
 =?us-ascii?Q?StcOhvqPgPfQ82AclJa1ri9Nl7bAU89Zdt2CyXdip6g1HdadMDANMjBu6LtK?=
 =?us-ascii?Q?iTWpVmbW+XLcNZcuMw2DpzHLD24A7887LgQp68Pw6xZKzc8GPJLTzI7HPk9R?=
 =?us-ascii?Q?Bp0BwbOtEsVcw9tYOpd8UMrLXTySTS60Ud3g8Uxm/gUfQ5tTjJCYCvFo8iw7?=
 =?us-ascii?Q?VxopJsPHHMKXLHGJFvAUzMO+g/wYHNH38F0NL67YQ+/dSVnVT6lkfsV4zk9w?=
 =?us-ascii?Q?piEa2FBwhtN1Qc7EOVtj35py6AcM5+lxqvwmCUTdZ6QHfea5ua8DgI/PnICf?=
 =?us-ascii?Q?YJMpuCqVHNTFTyxfTDqjt6WTyp/P/LTYGrxXeI0Q3hF990YRkzYeSoaTUo+N?=
 =?us-ascii?Q?4MZc8Vxjc+wlTra0hbSxQPWk35bO6sKokFSzSsChks/eHlmZ7HlkDyBVkC4y?=
 =?us-ascii?Q?c7yWIHr/aRx5Ne+aPXzestQ2/yO5FwRldvHgNDBc4aLNyxPVaT7V5cg4M/6Q?=
 =?us-ascii?Q?268f1A/QOBDc2Hr61DJPolzDIY8yw2IXstBl+ISGPYVzTO5hG9lllNLG5c9/?=
 =?us-ascii?Q?UoPXJfr3Dii770DtvnmDTy27lL9jdaxUdWGRU3wJciOOHdS/ND4EyInfyCRD?=
 =?us-ascii?Q?ee2YkKg7my8WfAhYp7v4yCMkQKlJ9mYsjqyP4I0OhhvGWCOsLxaNxCRJRyGh?=
 =?us-ascii?Q?nkmaOXXrg00xH8wnGizVPFZYUxwaC7DbklsJAhvMyQDYzN8KaDay2AoDimsP?=
 =?us-ascii?Q?qb20r3pLWmRGquCaHpq7XTjDeZiXPdah7jLlOQ3cfKbgQ+jxiZvnnjTZwqn5?=
 =?us-ascii?Q?M3a+pdK/+gKoN/WeJ4L/Yz5adfQjMbbL4ETwx/fs+KCPSG/N/fc6R79imVPR?=
 =?us-ascii?Q?2dqe0smO0cOoa44ZCmRa8R3wqEgPkTSTBfA3BEAhrNGL+d9iiqRijqVUW294?=
 =?us-ascii?Q?axQm3bbW8vzSMkBMnNRzOdGWuCGwKkkkcUSIdmiLX06Sq97SuyA7suw1Z65q?=
 =?us-ascii?Q?oszl73k3dkj6x0jo9LQKDzRbTb71v5Abxs2PgIInGkKaJYDUFgtUcsyNUi+j?=
 =?us-ascii?Q?5iVJbotFVw1b2ovImJmRaSQum/ZT9swILWYvgUr0cpSKaweJh9MDFzmOtNGE?=
 =?us-ascii?Q?Kmk33/AAYVfGybLNpoIodFpBxwffZF/l/wgPpg8mGSds19wWQtxg0BhiC7dZ?=
 =?us-ascii?Q?DK8+NuuazXRlGWagxBPrylgA8wyl4anCbyNdT3HPlGzZNsCxV9h9ZdJOg7nh?=
 =?us-ascii?Q?ULaZUdjd21GLo7UZCrAS4t9JlS/KG5ROSknfsMBb+mvw96BLiMsrGXTJKFmN?=
 =?us-ascii?Q?Ty6GtfW6RXlOWz9c5Nh7K5vI/ydiJOrhWg9BojAIFfuRguOUAQj7?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: a39a17f4-5271-42cd-b3c3-08def6ffafa6
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 16:51:55.7683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ChJsQuqNXT/4j4d3LWgwYs2TKJkz88DE0pKBWaRRjid09rBnk2sZif4KYSG8AoF1sID+u0j1LIcwRFDNlQbaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6729

ntb_transport_max_size() currently reports the copy-path limit, which
reserves space for struct ntb_payload_header. Direct DMA bypasses that
layout, so the same limit is unnecessarily restrictive.

For active direct-DMA TX, derive the limit from the DMA device's segment
and mapping limits. Keep it within INT_MAX because transport callbacks
report lengths as int. Continue reporting the copy-path limit until direct
TX is active.

This lets ntb_netdev use ETH_MAX_MTU over direct DMA. If the queue later
falls back to the copy path, larger frames are rejected.

Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
 drivers/ntb/ntb_transport.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9f5d6a407be7..2f69328d5201 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -3787,10 +3787,19 @@ unsigned int ntb_transport_max_size(struct ntb_transport_qp *qp)
 	unsigned int max_size;
 	unsigned int copy_align;
 	struct dma_chan *rx_chan, *tx_chan;
+	struct device *dma_dev;
 
 	if (!qp)
 		return 0;
 
+	if (ntb_transport_link_query(qp) && ntb_direct_tx_enabled(qp)) {
+		dma_dev = dmaengine_get_dma_device(qp->direct_dma_chan);
+		max_size = min_t(size_t, dma_get_max_seg_size(dma_dev),
+				 dma_max_mapping_size(dma_dev));
+
+		return min_t(unsigned int, max_size, INT_MAX);
+	}
+
 	rx_chan = qp->rx_dma_chan;
 	tx_chan = qp->tx_dma_chan;
 
-- 
2.51.0

