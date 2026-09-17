Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013014.outbound.protection.outlook.com [40.107.162.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0504D178E;
	Thu, 17 Sep 2026 19:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672124; cv=fail; b=LRcrGoQ9sNT5QSDqYyxLOUYWP4bzQxpvPIQ/61vqjEvvQCZQ3GABKzVnMuhOGc7gE1MBuUQRomadKschuVPstPe4GXSK6/i3rJmUY52+16ot45HSjyh+7V4h9iyduF/pNS/ehg5iKyTsKMweBobyw7uSSgig1YsijeE707XDom4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672124; c=relaxed/simple;
	bh=C0c5MQxdiaZqxzNDsmcLt9Nz8tAjsZBz1raHd4pcmEw=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=m+ARcoXpBfkvr/ZvUpsiVeDOW3ufQOVPQZtRMO5XG6PgM1vMqP3w9lpGL+UIZzLrTDzZnTsyPBCmrePGmWFZ1elYag5hsHqKnD8W+QtJWaoc3SG0abPqCK5T6vbycu5dgG+JREOogSQErLdmQTvpLWaYu2yi4aNw8LrPly89OVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=YN7yFICW; arc=fail smtp.client-ip=40.107.162.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="YN7yFICW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uPrnnIgDrUYLa8XWIJJ7SsxsICJGx8081QilybaTQtkIoehiVOfNfjZtJrUsYUj1gDjVQDADiaAZgtaO4MIcPdDn0GiENeWxSr0tKcZ8AvpAUkai5OKZH9EO7Tgo5yeMpTcik+2mawRhfcxuTPDzm/LlPlSWMNuC8N2VABFMN7yTBwMrvXhJx0uP55mkZOd7pLlotNdX4E3GfNU+21jrSvbjY17hIsKQZDYc6sIh/F3RztbL1ISDJPcM0Z5dUAMDJQoE/n3fXIVlxASXbAPhdIbojqqUHcLPCu3D5m+d0bh0TN2pD0Y6Xsrds6C1OY88XU236DuPPpaEb4JiLbC0Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QJ0tPsnJ81lgU6OLoOlY2Gs5Emu1cCd9+jLLdnkLgTM=;
 b=btUU4G5PEKEUAsDTR1agcsdu6yZb+YNqcLkM0TKX0ODx/8wSWbi+VOEJk9hl7W7r3hcY00afxAixuNGu2ykPU3U2QnzXzwpMiKaBnN4Sz0MQ3+Y1OaqoPzj40WpBKdSsuQ/xv718B18xa1aDk2V1XevnwIeeyYZrdTOwrqkZxOwqV53tduGLO42QsWExBFqBhx0RhkUkPq8LwbJYf6GaJFkaKKZD4+z5fvCTuNOXe1M5xjQtq33rBtnYB21J7SWbQ2v179TS01Og1x0814HoiQqzdLBz4MVPF5mYt4u+Z2HgbmMU6DYMa25RKibaIsFgTA2Lqp3a8bEhq5GEI+Su1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QJ0tPsnJ81lgU6OLoOlY2Gs5Emu1cCd9+jLLdnkLgTM=;
 b=YN7yFICWFztyvWy9tu3USx2LWM/M1yKD34IP/MZa77OwaBk6ZTlImqlH/tzDgeAPpuz6PJkhIewjS3imLs2YfQVSs54J200vOiDEhzI7faIgTMe3oLGxOeN1Vg8ZoimlYtYjYhKssQFH53FUVpUF7wkwLefnHJ7AhAA9zApW4UiMZe2Pcr4ObAE7Bh34KCQOAOJZNo89aR3ZeIwi4ZELWiF572yIun8ldythEluQwGcOxsMLGp/ANGGjPCzaqnQ/ksMinFq+BPEn/CWZhz/I68WmdGCOl2Wd3hs0t4LXQtaHytTVvcXykWXKk81crvm91WijWk/9g2byL+wgnOeFrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com (2603:10a6:150:2cf::9)
 by DBBPR04MB8041.eurprd04.prod.outlook.com (2603:10a6:10:1e2::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 19:08:39 +0000
Received: from GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c]) by GV2PR04MB11799.eurprd04.prod.outlook.com
 ([fe80::2146:83a2:5329:b7c%7]) with mapi id 15.21.0406.012; Thu, 17 Sep 2026
 19:08:39 +0000
From: Frank.Li@oss.nxp.com
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev (open list:NTB DRIVER CORE),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vkoul@kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH 1/1] NTB: ntb_transport: replace direct ->device_prep*() calls with standard DMA engine API
Date: Thu, 17 Sep 2026 15:08:30 -0400
Message-ID: <20260917190831.1194795-1-Frank.Li@oss.nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CYXPR02CA0058.namprd02.prod.outlook.com
 (2603:10b6:930:cd::27) To GV2PR04MB11799.eurprd04.prod.outlook.com
 (2603:10a6:150:2cf::9)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV2PR04MB11799:EE_|DBBPR04MB8041:EE_
X-MS-Office365-Filtering-Correlation-Id: ef871e81-6111-4665-0379-08df14ef14e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|19092799006|366016|10067099003|6133799003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	7WNR8TqDIQAGw5DF5owMW1jlGn8TWpx6ysjWZ3FgO8gOv7Y6zKdYQDhWKSViu7+Rw+XDTvOpkuYFZ1rscRZ6RatKCvFYgXcyWmngSL7C7p1aM2ze7lj6O/GLXRXBP0YlomRvr4OJhhoIFTKXibvfVgqZLfAN6sBISiMpVfh+ciu9JpqV2y4MLJyz2N/YwOG+lYeG32cXosoUI+uBdZ1US1nGJE1yzsHkgckBcUgGiGu4a30ZReLyFSoKSp10iFsf8Bmmw1FJgEHcvw6IP0/wJSPmmEPEW0w7IAQ1po1C9iiPBzPCSO6U6DZtu5S3LBeuhSrbUR9psBmpXCcMliE/BTiLSuhnHdTKJDU5y3Fn2Q5hhS0spsvzomY/tQ0ww4n0DlOrxDnQ8K1+sErLoWta9E3Svx8yac1StA49ZrPpu5tFNPIwMkana6omKXdCRYPvcODh/raAPGy7aGyFttxHWn1rQukb84GeLfMwcBZ2pKlDMc3e7rpG5dV3roihj4IzrOA0FMmu4iiza6F5Tv08Tao5LYRT/mZepw0VyCjqdj35AFDt5kd9/RxdqVhqQT70DdOPjW8GNctPRhvCLxoSp1qPiFM/jiDXo3EXe/r1eSv0rjjqSdZUFPfllLCbDSq2bIGBOXDcUADMObP2jP+OWeam7SksDIAM+4yP0yvAyr0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV2PR04MB11799.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(19092799006)(366016)(10067099003)(6133799003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?k0vUOWX5ksZyC8loYUL2MCd10pwBwU5Mnqql9w+6hg7t9xJhVnlgteO0eOYN?=
 =?us-ascii?Q?x222g5c89h2JVUlkpgwRt8HzHQIONDiBtW1SfczvRbC93KM04/OaaxeQHQtb?=
 =?us-ascii?Q?0Mle8rlqW3gePTbXBYtg0lVxSwAclpadlTllEwGGf/h57Ff3ZH8+BZHvnE2A?=
 =?us-ascii?Q?dxS/gL3Tzu+2W6R5sv9HRAV52ixta2cBshmSEioGmCyUfW9hNaHVxz4LQdlf?=
 =?us-ascii?Q?vUGI4cSmwh2xOpW6YqKUCFtTQJSxZ+uGt0ey4yN7gbCiQ6rfraK6PqldvwyK?=
 =?us-ascii?Q?vM0b5GrwiebX+I7tFzlaM6HlaeJwMueOf4B31N1ixx8eXugd5FTdN5CQQREW?=
 =?us-ascii?Q?3vBXPr3TOKKxfSVghnz/UwPXbXsn6eqTNSQp+dftY8Jek4J2w+PyixcsjPlx?=
 =?us-ascii?Q?DERKEgRJrzByG2AwUjubN9i/yCSC8GHkixjua71xfqnv52CD+tNtvhs5mOSm?=
 =?us-ascii?Q?dH3LiRJJjhphOd83JwdTsyl2o80/g0FM9W8y6V+XxjUTi0LIQdunEsOd40UH?=
 =?us-ascii?Q?BunbdZYtT1h1c2JryzgyhqcAhOdRLcRAuqTOfPanQXkja3FUWpBSpp6nMSnG?=
 =?us-ascii?Q?JlwoSbtqUTMccSEOneQZqH6VQrhVx4GfSdXpqqrjSQojbSPUHqIEMTLFkBBU?=
 =?us-ascii?Q?5gpEgyJLw5lvEUjZ+rkFsxCjWfZVm8f+DsrvBy4+XWKKAWXUErtynw7LnnrH?=
 =?us-ascii?Q?qQDuIHYW4fJeFnWapVAGPN/LUqgiOv6pMdPyOaWjLaNSbXxzpAWUQIWMInDQ?=
 =?us-ascii?Q?JL4znGkW4nLSTgSTA52EC7doDnbDBe3k9GEvfsz6a1lT+jJY4n9VPTtq0JMl?=
 =?us-ascii?Q?9+T6U7EDHQ3x4QE3bEqHQpe67mOJRZw5IORIFPCvX+UySPzMSu5w/349bK1N?=
 =?us-ascii?Q?piM60P9Nrx9UrfshlN/8WTVYLmQBZ1XWkvsaKJOxuRycSEG74/QVrcs9cpv8?=
 =?us-ascii?Q?V/FFVAmB9Gdu+o+0G35KbyC6KJ7LpVMLNyEdNDPZYNCks90JfJhXnx1NJS1I?=
 =?us-ascii?Q?Pqd0DizYWfDm6Tm2J2jor2jxWoaIo/33zm6y0Rhb7rHay4rv9MT+ett6/gSh?=
 =?us-ascii?Q?eWnVjDqzUD/s3onZVXcCetuyL/5XkeTJlDahcU0d43mcidrDJGeF5OPfKwkw?=
 =?us-ascii?Q?DNrismGz2fr2OSu/kFforBIntynivSLT0g/+X9i6kgXPfp6jQ7CH2BdDPe/r?=
 =?us-ascii?Q?HRnLrl9k6X2CERWWI7tD736zpDgeVmJP1jeSShvaWeqYFb1ZfY0PLcNovIB8?=
 =?us-ascii?Q?8O+5nB0POphXnnPuGEu0HTb3lC6YbfopS5y3bvzmxv/905VFzCqmChRRV779?=
 =?us-ascii?Q?XjWUQslq8g972iywr+eJjD8ffF0ICUHrG7OAYPrDMKu61B9KEfj2OA/k346P?=
 =?us-ascii?Q?ZNvePcfzpDaTXEFBJQxFRUx/x28d5cct3qaObTkec+IoenVQ/soAcvB20CI9?=
 =?us-ascii?Q?/RSLW7BuXZDLzGWiolvVIF3/D9tZ6uHiQiM1yJTYsemz39pakJSS/850/Ejg?=
 =?us-ascii?Q?NNnLzIek0piXD1/Yf0c+u5Swib8mQq7I9ghCNJ5i57PWVEsHNODN5m8oEHrT?=
 =?us-ascii?Q?0bXsgAsmH2ybmH0yGhp1xi1YTos57cK4nTnwJ+yW6WjOacbnl7IK1tUhmHvE?=
 =?us-ascii?Q?vjb74l7eE55CUWQzagr8i7Sz2IdgcQsyXgC7DFJr4BR8s2sJJNc8H31yxGBB?=
 =?us-ascii?Q?MJRdXzaQ3EI4MQcjbjp8PQxKlr23T4i3GUVIwyHrDU8qK4sD/nMG8YT5MNDp?=
 =?us-ascii?Q?amobxApE4t/ZLl7ABztov9W9ZCT65P/hTnEZVIO6qEhWryrtC6BS?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef871e81-6111-4665-0379-08df14ef14e3
X-MS-Exchange-CrossTenant-AuthSource: GV2PR04MB11799.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 19:08:39.2008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zGfa4NXiyHGMmarADUv4hlHp74u8Dx7AvjtDYVoKnifwHLIu8hGiIBFja8fB/4kNbgkfO68Y8VaVpxC/l/qCMoiZBA2VAB4tqM2lzZpdBih15Af4HWolmuC4mwK8xyLE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB8041

From: Frank Li <Frank.Li@nxp.com>

DMA engine consumers must not call the channel's device_prep_*() function
pointers directly. Use the standard dmaengine wrapper APIs instead.

Assisted-by: LLM
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/ntb/ntb_transport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9caa1a653c5b..45144abfb7aad 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1551,9 +1551,9 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 
 	unmap->from_cnt = 1;
 
-	txd = device->device_prep_dma_memcpy(chan, unmap->addr[1],
-					     unmap->addr[0], len,
-					     DMA_PREP_INTERRUPT);
+	txd = dmaengine_prep_dma_memcpy(chan, unmap->addr[1],
+					unmap->addr[0], len,
+					DMA_PREP_INTERRUPT);
 	if (!txd)
 		goto err_get_unmap;
 
@@ -1884,8 +1884,8 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 
 	unmap->to_cnt = 1;
 
-	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
-					     DMA_PREP_INTERRUPT);
+	txd = dmaengine_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
+					DMA_PREP_INTERRUPT);
 	if (!txd)
 		goto err_get_unmap;
 
-- 
2.43.0

