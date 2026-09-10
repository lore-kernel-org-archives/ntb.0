Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11021076.outbound.protection.outlook.com [40.107.74.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B86523A453F
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013340; cv=fail; b=dprbrgMrkYI4+YmF2n3gyS2Exv5PTUzSwC8AYiNTz5eagl9r6iLuAbFqJJT1PHQYWqNrrqIsyp7+AKSvnctaleKqZkjoP+Dv9kew4JAOHB9jAxRifK3VNh6m26KYHPYQ+H7535KMVvcXrFtg3bMYGoI61qK3iI5tIhBSvG03R1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013340; c=relaxed/simple;
	bh=ag+UFp4qL3urdzcCBDtXlUYKu+sgUscKGfQb6ntyXiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=tJANtsTpTN9vsZIK59aTy27j+ve93BrD7Ez/Gzc8GHUi8WSGoelPMdH7xqSymSo4/JaAnLvau3H5YtFhIAfUVpXE7Qr2baVbr025a7rKq3GnA488+AIuwry4Et2ykUKqQ4zOzxH+NR5DiBYJxPWSL8eoI78ZD1piXFnBFXlimYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=as2xmtLl; arc=fail smtp.client-ip=40.107.74.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="as2xmtLl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLA94/p+XWUzZeyS5OfJ25+Pm21LN8OmcUBE5dwZDiMYvcL00ThsB93YGXoQCqfcq8Ty0G1bcLvwd1jxZomSFkJJf8ii8vH+cv682SH9vTIbZX56jcs/TooWljnjJmy7Q431Ndk6i0A6pzwBWAmdJIMRkZiO0SvMZMal2cXeQx8kpK5Z+KPrhn4uK6cEJkGHOoiQtDb6JN/8lj9G2DWSAxzzLDic1uvMsUC+FkrAFZx4wUbweTu1X4Db93I8g9s0V+zN+O/TGfydPCvcBcmYyDIxe60QTc2RTKVAQ9G9ayOz+aeSnUS71fThs9s4KOLMWFvFe3jcEI//pbn+/u/lKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q40TDwPskADVMGqF5DGVKB54SSs+Y/ny4cI9iUJE6YI=;
 b=ij3TeMVemLZkyCZwqL2EHP7/t50GBQJFGO6trzr75c2/t3JlW24WC3av6PUC8iYz7kQeiznmFVLXpOmNKr4WE0oaF4vphFqlz5gngpAZBdOgCZSiVq5lIAgIZcg2jeXkebt51vDrMFSj0M5cKJILPbpNVdFRIe64tnCMJk1GBI6MGCWmykCFx/9Dx6pSTD5TJS9GA7SugBNqRvvTWPZtEfL1Jh+qrkzgN8myjNEFOQjYZxi9XuTLhMIu57RZxtLdW/dmzeXoqgUZNHNU/I8hPZJKRyCPM9qkAdNfPfkOd0fuj6JJ7lze3O9GwWVGSfbTkvXUf+jaL9fv7UVADb/G9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q40TDwPskADVMGqF5DGVKB54SSs+Y/ny4cI9iUJE6YI=;
 b=as2xmtLldW+pQQ1l7nM2nufxlHSGsNOoesHjGo6gLmznWDpKjEhbUt4uES8NwFwARoMn0umRLu8+hQ5iz+ExVEjntl/X02fVCAoW886H/6sAGmprBv3pq1DFuoKQ6JkTFF9APbLLQPFAimnVkh1hyHzRmBzopvN4kGLBRmL0q6s=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS7P286MB6619.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:42d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 04:08:52 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:52 +0000
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
Subject: [PATCH v2 13/14] NTB: ntb_transport: Abort link setup on QP MW allocation failure
Date: Thu, 10 Sep 2026 13:08:35 +0900
Message-ID: <20260910040836.3792333-14-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TY4P301CA0007.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::6) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS7P286MB6619:EE_
X-MS-Office365-Filtering-Correlation-Id: b1ab0120-bbcb-4335-ed4a-08df0ef139a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|10070799003|366016|7416014|376014|18002099003|22082099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	LoNMIEmaV1o45fFYNg/tO4Uf5BEWB+PWngg1Zee1okaWw9oXaF+FBz7UpxvjMkVfaKgFBtg+drvi2KIvLmjUiHC185rWSS6xVVpQ1UePTAu6jNsw0IceR48O1u1Oz2hP6DNu635Bp9SW34uQmDKP77DpcOa/Xp60xJa9qWiaK9y+d2tAX9cpVgTB4GFTvUYtS3ieuV9H7lPe30wyUesBicFC/3zfdUNktiJeHwk9ZqsM+WB/BqX5xq6TRbR9ZLrIh8DFimthv0zUVEGGW1AtmHJeFUyhFhDT5b9Zvq21Owfj2j6h9BZEJR59pBjZdckznuKJUv0p+jLvaEF0PB6KkLMbJUbMOBT4qV0eruV5ahjuGBALidpXDXDba+DHfBw8Pa1egFM4Rx0ptNWZ43ihwtBvhEm/6qaiJEzdc/VThD9PGI7OwbhXDSOUAOPEO29UUfYf1e0Af0UrjorHukqerlqFqY6qBjmV4EzztmypHZsOLv49BBtPu30dTlGQA8x627tghZg4ktU3Puh+GlJGY7fciUNSnIvspggzwnG3Tfz21kAsbCtKWzO9kSdaDLQub+haB66xjnIOpbYTts36aTXBKeggwXe7VtzOA7acfpQdBuTj7rXBFnrI2I/+UJ0L
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(10070799003)(366016)(7416014)(376014)(18002099003)(22082099003)(56012099006)(10067099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kArFqLREgEzW3hp987vIjlhJ2CcD9ZH8l6hYDXh6YxyXAwh8p8CVqIRAXgn5?=
 =?us-ascii?Q?UOs48TFM5XvceFVriCo4EAVGB14msN9Emy9YOnTuE04A0g2lRxLrsuewlS/8?=
 =?us-ascii?Q?sKW/dw1mEnf+pqeOKKWNKk146yBL2fyfuL9a4rMp+bJsB7g39+kFcVw1qNjs?=
 =?us-ascii?Q?F/f5FfJgXViRY6XOBBseDv5HyMjOwhw1NeTPl72Gvuc22ToO0yC+TjBFqhpf?=
 =?us-ascii?Q?+Uulu1uYc4Oa1yJe+fV9IM2oBUfV7mIHgVjwvr8nx2zFTHq8d4xPeSxn+q7V?=
 =?us-ascii?Q?czFym3w6Iiz+iazCtcI1Jsjb/SXcBwuAI02li77xopVESUck+5unJm0be1eM?=
 =?us-ascii?Q?+fovMo9p9A7JiJdW5RLrV5e5KHQQr9leWqLcV3b2jfG/e/fClZp8/nq77mVv?=
 =?us-ascii?Q?jT4SpdJDQ1FYpKvyuneERtNWLCvMbCJp5VjxVb2KPb089NeRC+cBJZfWf+Cx?=
 =?us-ascii?Q?6niA2d1o0L8TupAvHmb0BDerzqd46ieR821GPc7ZnIDkDQXOmB/Ohrxfxdoi?=
 =?us-ascii?Q?SarrxF+w9e058hP0GlP1L1OQb0uLCjX8ftk/q1b/21BitFmYCno4WnTmByPH?=
 =?us-ascii?Q?5Z4RJ7Jt4lyDkO1VzlXtbNgSTcr4zg+j3LHXBMcRL2Qs6yKN36bZvAjDkMtb?=
 =?us-ascii?Q?tPazf064DAXExRAZr8B7k3aa0cwIx9TJ3vfUdq5QHLRKpK9/6n53RQQH7eRE?=
 =?us-ascii?Q?QfMl6oG92SL9+vtPCYHRvKxBrqEwYJnm2dg4sHIP7eCZQ60LXupskxzwpBnk?=
 =?us-ascii?Q?2lC2zk5TM+3x4u3mCX7XM+z5lyr6YXeNCvE1yQv9RSYssqeD6Ur5EqL0JLDJ?=
 =?us-ascii?Q?D8CCatw39FNf7d/6gsPXvdhx0ltEy4bPNd56sr0tdynbVtyw02b8mLUsG4Dt?=
 =?us-ascii?Q?r2iYlIrk2eRXLni2XZg1AI41QiW5W9Dbt2FsR9uIekPn5yP+G+FoaIyiJ5D7?=
 =?us-ascii?Q?wLqKDUx4AQRtS/xYFellscgnDKYN2FkeMQS9blBzwwsdUayWrntx+E78pJb0?=
 =?us-ascii?Q?aFpYUThmjzestVrAcFAtHo3eRyBdjtDB52X+A7LQA9dUuYIIj34FCcnixDz8?=
 =?us-ascii?Q?ptJMx7URD5m+t8OgEuikDB5ubiRHjxQhxDR7xFOCQOUdMmO7YYLmcqGyf1qp?=
 =?us-ascii?Q?BL/iSEDiGMQ0FZBc5sTQoZIRWoOWYGSUkVH1mp7fZ8qcHPQ+fSGnvh7URgbI?=
 =?us-ascii?Q?e9sOQ1IQ/Tg6x8cKbZ81QUnYU89EQUxcX01A2yQo/gabTJoD/r/Ot8zFBsfu?=
 =?us-ascii?Q?OC6JPybdO2R4Gq6nwTH88y/rueHU5nmFd0RzPmvuRIMKbzkMZs5MmX8Z9Qal?=
 =?us-ascii?Q?4MBindf3LJU1t/ebSvAuHdhFk8FfmQUCuLkm61zU8JRf6YgOXFXIOc62YZkr?=
 =?us-ascii?Q?avd9PFePjyUTkgkh+HwXaIsyFVDHJAASZhTtn2fImbfrzYkCMX91MHw7sdJr?=
 =?us-ascii?Q?2d5+tBvd0Iko4ittMOaKIXukgh5dtKJbuEIsS/WdleCRPKghsXEhyar1/EDi?=
 =?us-ascii?Q?BuDh9/ISG6USH/Jsxe7YAo+CY1LKYJ7mF1M4PUZxpEOEKhSHF8oukf01TtJe?=
 =?us-ascii?Q?y7PFe45OT5P6SiNsbnf3VIqrBC/5NnZnXfhaLjR0eDN30mM8SK236bDEMyqZ?=
 =?us-ascii?Q?3QjShvZXmXw2RSLsqdevsUFxgYW1CRimJMkVUmzDehUZaNQaMxZybsI1v1Hx?=
 =?us-ascii?Q?GpudO8LYnFbMQs9LVDoc8MgWIfonSGQO2rUlyb8FvPGP3NWn62ePCKZHl8Bm?=
 =?us-ascii?Q?WnXCQZ2W6HcCibN6bfIJDBW1Lb1aSoufnM0LYHesITpXepuR3t1N?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: b1ab0120-bbcb-4335-ed4a-08df0ef139a9
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:52.7978
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8kSIMuRTpJAGM5+49DTi+0/XQ190xTIzO3pRUckR6TjBiUIhIZOUrVpbh0En3A02MzN8Pt/OuKJwZI1aBkDaag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7P286MB6619

ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
but the link worker ignores that error. The worker can consequently
publish a QP whose memory-window state is only partly initialized.

Abort on the first QP setup error and release the MWs through the
existing error path instead of publishing the transport link.

Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

Originally submitted as part of the direct TX/RX series v1:
https://lore.kernel.org/r/20260810165136.2292436-2-den@valinux.co.jp/

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 096be87e5ede..c1e3a077c45e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1152,7 +1152,9 @@ static void ntb_transport_link_work(struct work_struct *work)
 	}
 
 	for (i = 0; i < nt->qp_count; i++) {
-		ntb_transport_setup_qp_mw(nt, i);
+		rc = ntb_transport_setup_qp_mw(nt, i);
+		if (rc)
+			goto out1;
 		ntb_transport_setup_qp_peer_msi(nt, i);
 	}
 
-- 
2.51.0

