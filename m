Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11021078.outbound.protection.outlook.com [52.101.125.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6F3A6B6C
	for <ntb@lists.linux.dev>; Thu, 10 Sep 2026 04:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013333; cv=fail; b=nH3iJmv64WQ5b222EOCmOhnmt4XngbKJ+glMWVqZe5hnC7ewnLn0/fvUMqAXw3jgReoJxFwxyrFFHy9vseDMx48CcaOpqeq87pXb4Z9hwgEKSJAnHe+XgtD2rjAQm6dPAEGNsHdxQ+0hK9JcNmejzp9xrh7zYUc7lKbGXmk7XhU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013333; c=relaxed/simple;
	bh=XBvfjkGg3kgHVhc1/NMXR8r9SyEdBnoPQBHsV2KH6rk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EdvgokRA+8fSJii+IrxPxFKJ6b2G6OBjKbMaKz7IMaEmjVyBn3hW9YU3qcZ81KWpxGZMY9nYrkkG2GvZcr8Mj06cpJ0KAMnOLucCxcBe2UWViKly94mbQgLgNmpCD9dM9UTadAjzORnitGsaQ4aM7TpCZajJBnNYaQE4/CnxJlI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=FiHgLS6w; arc=fail smtp.client-ip=52.101.125.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="FiHgLS6w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e6Jlv04FzZTzEjdPBmNYbq1soYjKH0wJL+YVyhVTGjpmVKbcVQZi2xPQYA6PGayy1B7VoisJYjfiFrxU+KcoCqQMHwr4R4/QWliigfxrqMONDM8ff7LrfFUgd0XU9AH0gXKua7ESHEI27g2gKz39slGCagK6G0VTLq1Yv2Keb8GSpPl9EpOLlgZ73V4AI0pAg3/a/9WNxbfXai9dBpMaTuz+7xgXJTtVs/30iJeWE98xYxQLmxFQk+jB5vnOFGTvXF7sBJNPj1zq2fGndiNKL5N5MVM2xyrhGvgZKxKAZv+uRMrJmk9dQgHP6+9EaOFBJ+S45Ct9dZiQ31TBhxm0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8RHk5R62QE+4/QwGbD2BHOWIttvXhk2J3HHKo04pHFs=;
 b=rnqNCQHNpB0p4P7P4M+L29MrXrOmAbSCh5keUFPzsKXB/Lz1jX56pmuIDb88F2JiayH47zY5+cZv/cJuHQw0UFLV4UK0WFkgpwUkTxPISsknT8XI5GUQvisfB5HFPep/u5gcVnrSqR7TY4HlTB5gp2RzRmE/gZl1HsbRE9MkmdiaXJb7T5lfavotKVcFnUEOmC7xnDhgNUjmVfV3S2Ce0suQ82p9uIm6sAE68HNNuG+WkAyX5aBc+5FdKp2JsRetk/o/HUNW0bnu89E1NrLp+FBPe7rik+0Y26rE5TxaVpuE9+fJdhOHHeth1Zb3QFfDexomh+bx5TMkXeDrS1aP7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8RHk5R62QE+4/QwGbD2BHOWIttvXhk2J3HHKo04pHFs=;
 b=FiHgLS6watJFDv+MW8OuHO+jxlRBLxdfD5F0RcxstJ7isFUnRxM6Q1jkTc3vu0z/Z8sIX3dWajFXFJynm+E1jLMEYoznnJr0d2X2SSKwviJnYjpmKrOLzKU5K5Ug1nPz+Hb7j/fA8f9XhNN1Wy8ZwiNWdhURvedKVlGYHioobls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by TYWP286MB2220.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 10 Sep
 2026 04:08:42 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%4]) with mapi id 15.21.0406.007; Thu, 10 Sep 2026
 04:08:42 +0000
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
Subject: [PATCH v2 01/14] NTB: ntb_transport: Remove the device debugfs directory
Date: Thu, 10 Sep 2026 13:08:23 +0900
Message-ID: <20260910040836.3792333-2-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260910040836.3792333-1-den@valinux.co.jp>
References: <20260910040836.3792333-1-den@valinux.co.jp>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0371.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:79::7) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|TYWP286MB2220:EE_
X-MS-Office365-Filtering-Correlation-Id: e64c6e77-df65-4975-8411-08df0ef13359
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|10070799003|22082099003|18002099003|5023799004|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	jLgpgW5Yb/XC9En9mZnhskjDgdcFtDv/SqeCypQI8TLDkcI/mbV0cF+ayJKlj0EFYzHYntp7nXK69rPTobDrAVi+/J1doEjDMSTKrVic3ziY60oUZ9yVSVMZmBm0aZYkAhNTTGmfvsv3kvzymvHRZkWpic/JYjVfD4T/oeQhjUS2Fq4lC+kom2Fb737a7IFFb7At4XxjGkBMhrTf5J1vU7lPDtRg2oI60JtlaGxeA7Z5XGi6OsJigbwG/uMlwnVmPVkNKDHrKVgl32lXk66kaGwHvGZO4Hk3yu21UW7ys0Q4XpM3N56v0O31zymwTa0dJKAn7vCGEo+Xy52VRP4ymInfDqk50JsCr748HIfN/tY3cTB4dznDI95VvkxnjjP2S9svwNJnjYYPam7UOe/CTrPJUUnCQwOp1Ry8JQ8YHIZJKUsCwKSDg5r2mHRCIraGaHoq4sW50UlUTWm/ONqITuNs3rWfOBxrrLvxhm/Jc+5Dd1JDWyMcEoj5J3BtgNpIrb1of6bRxioOX1/lMaKFVCI0Lvf7GpIGOvsweRxir9SQ4hERCh8CQY9wQ4wQpobNZF+KvmrsUphS/mKBLXeJBMHe91bYcFEWeLGHuPLZDMf3izC4ApzPbek+CMkxYNR40il8/XYKcJuG1i3ZT1O8w0TtQoI7xnCXCB60L+OOsoM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(10070799003)(22082099003)(18002099003)(5023799004)(10067099003)(56012099006);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QGK2VA1ZhddoHqDqY4VJjc7VRDHkHTZtsZXYy3jH2pM4CcND28i67FhyHDDA?=
 =?us-ascii?Q?MQ8hh8eNT0sEjSWsY8/RmkwJYdIftQES1FtFIj1wr8ByU/Bls9EFi1RXLy2k?=
 =?us-ascii?Q?OuHnMWO8/ToB1GtJh0qjjPdzpAGny8Gv3fw5dWEYoObiLTwhzMsNAiS67AnN?=
 =?us-ascii?Q?kgMkx/f2ulGAKKMD/+K41VmAf8Vjmmns/KROGis7DS0cNolr0SW0NFl3k1We?=
 =?us-ascii?Q?g35QGEqxBHVst6mx2LCu71XL4aXhSN8r8ZMrpCPGchLuNotfuxMdikWKNT72?=
 =?us-ascii?Q?3VTC4b0H4NWM32M0YwiPoHTEz6FdDqNfAglburTIFZoo7hwnjhn6Jfogj+U9?=
 =?us-ascii?Q?cdTw/J3AFJc8Hyo2Z4u2wPd6qHWYlK16g1oc1eqBj4dX57RLajPk5ST62wq+?=
 =?us-ascii?Q?0uGjB8ebbc1FlUdGAj6jGBwYjYj7ByK/9YjEBKuW2ih1xkJNO2h5dZbCguY0?=
 =?us-ascii?Q?4XyisO4RlUywPc4RG3SFrDM3u8CfgOm/yNl45CnEqC/Owb0TyDyQcWydTMx2?=
 =?us-ascii?Q?s9v4Eog7QK5W9xGyqIb0yH0Oin8/xgcqtS38vE5+UBp0Qp3J3kn+n5U/984i?=
 =?us-ascii?Q?+Pv/VBmRk4MXpfpCX+wGstCBBydta1NegZPFrNnJ+tyu3dB5tuwCzdJ0Z8s+?=
 =?us-ascii?Q?AxTbygYkjX7TtIYrtfEE+LWD2TAcUOn5txDwL07fqmDtJ73WGzeo9LZteJ47?=
 =?us-ascii?Q?27Pw+wt++25khieiNWkrSLVHoIL8C7rT7z9E/NW1ebiBatd74Xsduyb+LWLZ?=
 =?us-ascii?Q?qg2N+RNNDmah4J47b8xqQI4NmXJ25+tM8qIH8iBthodc6OndH5K1NwTgfk74?=
 =?us-ascii?Q?ZlmeYqniuUuQlStKZqWr8cBg+eaqXdrYNKbDGtGMSGsitNH0kLbTxjNnTkaD?=
 =?us-ascii?Q?7g+D5jGMkjq8INQt1XrZZFPTYZzE16m1lVuWuPMrCOFg7Au98yxPP+THQmpA?=
 =?us-ascii?Q?0apWYBKP/1SChUYmUB8f/fFtn3JPStV/q6KPye8kaM5ccRd+6NOsU3uTEmJx?=
 =?us-ascii?Q?Mx2DYZwHZFc1CpRs46KU3j33INaHbM87eFbDtDJZ84M+igcB36XBmxAZ/DHG?=
 =?us-ascii?Q?pKZ92RJzIWlODBODW8HPehAOQhd4sYvpKO/4nc4cGNatQoBV3YwCo6lSOxyr?=
 =?us-ascii?Q?ESA+Bpbu1EUilGcvi8QcCTRDmt0JJUQ4BFoqR2CLh1iVngUD7CIXb9xOB0vv?=
 =?us-ascii?Q?f82Ap/nBouoEPgPqTX54V9fYOCBZkyzoWHt9NFnmsYr9AzL+n7ZTVIeFfIk6?=
 =?us-ascii?Q?7Obg7I5Gxq2TpSHsbJRU2UAitC2q1AOBaRJ21Z2ENEDwSIsh2XNXCCl0ZOFx?=
 =?us-ascii?Q?K3JwbuCM31ZTx3SQdUmSW8u7RDp+TWQ5H9oPAM+phe76Br7kxK/AYxrR/XSe?=
 =?us-ascii?Q?xB/J3dCAfYVfS8B6Meb9A3ed7fe/n3Eh/1CaDd0kMBmGlDnuerHWM90kjWJy?=
 =?us-ascii?Q?tW1reE8km2WaY3bHsoNm4mQyD+h826I5+hdYEAGu9JhEEDcBtQaHKLwPc/3J?=
 =?us-ascii?Q?Wtt2E5szw0pUO4wcMCZx68kruJR9W15bHPmdsMStH0PngyYtvb/Cpc6s7SzR?=
 =?us-ascii?Q?QeNooicrupCsJTl5yzQyYW7BQFTsemKYzh9G0Xj+w4WTAMDTf3/lgc2Zv7jj?=
 =?us-ascii?Q?PkxIb/Kzga01PI+CJYx1tIOVqCWb09zdKlxwtzizWmMJeyLc0QL8Q6qOclNN?=
 =?us-ascii?Q?2zXyIfaQawN8jteNkRO9CNXpBC0kRmYLZPh3Ee6ITNcWZIm/yHu8xM4fiAPR?=
 =?us-ascii?Q?cgPqRK1V/1Yr9da1fW/Ujcd/TUrhqjpwdEltazyjYKWOOCCWtYmD?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: e64c6e77-df65-4975-8411-08df0ef13359
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 04:08:42.2555
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2Jc03RO2nwfK4BWG06Tlf+4VEAF5SRNGhS7Svj/JpascGURxSdf9DNluicnXbie2GIV7gB6WO2F8bHylUehUwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWP286MB2220

ntb_transport_free() removes QP debugfs directories but leaves the
device directory. On rebind, debugfs_create_dir() fails with -EEXIST
and QP statistics files are not recreated. Module unload masks this
by removing the entire debugfs tree.

To reproduce:

  # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
  qp0
  # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/unbind
  # ls /sys/kernel/debug/ntb_transport/
  0001:10:00.0   <-- should not remain
  # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/bind

  .. and then dmesg shows:
  debugfs: '0001:10:00.0' already exists in 'ntb_transport'

  # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
  (nothing)      <-- should be 'qp0'

Remove the device debugfs tree on teardown and probe failure.

Verified that unbind removes the directory and rebind recreates qp0.

Fixes: c8650fd03d32 ("NTB: Fix transport stats for multiple devices")
Cc: stable@vger.kernel.org
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Changes in v2:
  - No changes.

 drivers/ntb/ntb_transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5..3389d6ca9ebd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1382,6 +1382,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 err3:
 	ntb_clear_ctx(ndev);
 err2:
+	debugfs_remove_recursive(nt->debugfs_node_dir);
 	kfree(nt->qp_vec);
 err1:
 	while (i--) {
@@ -1401,6 +1402,8 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 	u64 qp_bitmap_alloc;
 	int i;
 
+	debugfs_remove_recursive(nt->debugfs_node_dir);
+
 	ntb_transport_link_cleanup(nt);
 	cancel_work_sync(&nt->link_cleanup);
 	cancel_delayed_work_sync(&nt->link_work);
@@ -1412,7 +1415,6 @@ static void ntb_transport_free(struct ntb_client *self, struct ntb_dev *ndev)
 		qp = &nt->qp_vec[i];
 		if (qp_bitmap_alloc & BIT_ULL(i))
 			ntb_transport_free_queue(qp);
-		debugfs_remove_recursive(qp->debugfs_dir);
 	}
 
 	ntb_link_disable(ndev);
-- 
2.51.0

