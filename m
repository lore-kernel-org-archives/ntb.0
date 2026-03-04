Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11020127.outbound.protection.outlook.com [52.101.229.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3ACF513
	for <ntb@lists.linux.dev>; Wed,  4 Mar 2026 02:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.127
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772589939; cv=fail; b=Fw1dHfD1NLvrn20HABmOpjteEn8G4PjdNWF7DqFjaJA/T9uv72b+t7okOM1NWP+OFFQwEbH2HfDlKWfaVdCQi/xWXcmOhKpdFlLci4mRXPQ6lhRFNVEL0j5GXDvvR/r7tx2GMdvJjZSbXmVX8V9HBlB52hgcPahcFdO6NETZAvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772589939; c=relaxed/simple;
	bh=XHIEXzoG71mLqWdjo/FUZtq2GaPcABR97quO400CC1c=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=qe+AaiXzf3w5UJQgY43JDHVhsVmGcGi3O34G9Tr7CBLCvETtB2SuVFyni4njJuqUj03m8FmHI+oqepOHd7DXrXZ7V14BOLaqAj+tarRUHwf1tgNj5hwX0f9IMzTFzlRRiaDwTSOLEIkeO9ulJOWxY4VT2OpWqLez1D7ClBNQ+Tk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp; spf=pass smtp.mailfrom=valinux.co.jp; dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b=UYxtMGY9; arc=fail smtp.client-ip=52.101.229.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valinux.co.jp
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=valinux.co.jp header.i=@valinux.co.jp header.b="UYxtMGY9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=blfddCZ+MmeoL9qNuQ7F39VW/BVabvLkVhSAqALCocztywC2nZ6HrP0nCmZ8tO7OgSmWvfT1vTRYc1925PIdQUh2jmP2oWUjuAE6saz4yjrTaK2LSs84guU5bIgw9I9AE8XSLWUX5QEl0cb269amehBgErgHHEtNxAnjI0W2uCoupPASvg0wPuoeaQP/jHGz1N9pAnhk/t1sRZeojZfrqB26kbzz4eMCn02oJ4+yhRJALklN9X+NKoeR5IdfvrZ5G8MZ/mM/Ea/aHe4kmJ5OTzVhhzEk5LofnjqHssjaGSR9sqI0CW4gablR8ghQJUIErbo558XThm0g450T3sR/MA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HoQylpnTeaC+jOkCJOybEHcQ6jF2+kiKfQ2pdJ4FANk=;
 b=bx7Ojl04FdH7H3F28lRIjSmDOjZM7EXyGHQQz/Tufh1Ig9L1Ab+SYY5/XsEf7AGlEEqH0R8eNAxChCkfA9GbbwmcmXCcTbeFb5IgSZm7LqjGhU94HkqG4NwPI0EVXZJjOu/XTmo+5ljdjUKwMEeuu35DkOIRr3MRkal3YMH98Z/2123+nsUs0r2jAA+PHC3/oaWxcKC2f4B206+Y97TYvqn2MAfFX8whnvDZX0fuTsT8aCtgH+9TKSF1hBcfqNl77GbdnQxgLC4DKi3FL8CPi5Tge0xcNFBRPfDtBPWgqYJdZdfhEM6AQbs9eMg2pYB8DENJwFqPz10oaBYNwFnZ8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=valinux.co.jp; dmarc=pass action=none
 header.from=valinux.co.jp; dkim=pass header.d=valinux.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valinux.co.jp;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HoQylpnTeaC+jOkCJOybEHcQ6jF2+kiKfQ2pdJ4FANk=;
 b=UYxtMGY9oypg8KZjq+pD5bwfizCos3qirj2mv5OXq+T4n1ZxL+2zu7SffvtwAJFtOBfXZw5cyjjXEFZ635rPUPkL7xX1WiRzbo61LaNAVAKgNix7rt/pLIh2sxr720sDFNeJbn2O+BXXNsZLhiXMKySq18hEvJ8224LzagEuTQs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=valinux.co.jp;
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM (2603:1096:405:38f::10)
 by OS9P286MB7418.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:44f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.22; Wed, 4 Mar
 2026 02:05:34 +0000
Received: from TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32]) by TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 ([fe80::2305:327c:28ec:9b32%5]) with mapi id 15.20.9678.016; Wed, 4 Mar 2026
 02:05:34 +0000
From: Koichiro Den <den@valinux.co.jp>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH] NTB: epf: Avoid pci_iounmap() with offset when PEER_SPAD and CONFIG share BAR
Date: Wed,  4 Mar 2026 11:05:27 +0900
Message-ID: <20260304020527.1067049-1-den@valinux.co.jp>
X-Mailer: git-send-email 2.51.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TYCP286CA0180.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3c6::13) To TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:38f::10)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TY7P286MB7722:EE_|OS9P286MB7418:EE_
X-MS-Office365-Filtering-Correlation-Id: 77aeb71a-264c-4dd1-157e-08de7992857b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|10070799003|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	97CWEAG4PPoBEKD9/EbP1Vv5DAnwlXoa0S/tEnEtMHSXbZji2aplZr0Yc8oTVdGSniNcbxFxgYhu2rObxIZYZ2qJz5nHHAv7TRtl4z3VqiDc1l7vIu3PWCRnZT/Ho+db/tZzd2wg4p9r+t5pu3Dmk5sg8FSpwqESZRXTvpSY7WlI7AcruuG5BM1zcRkUjsCaMX8wZg1+XtnEO9QLHAkfqmJIS1moP1JEqQE4e2t78IiVXR93c2fE66OBEa8DC+ZzUFNMRySUW3FArmMgFzCM7TzzK2+eOgG+YbcSJEEksI9yOSDDv/U18/GI/zn34gHJje94ZEHYoOsfdyaKi+XfPzz7gszWRy1pZWAr6B2Be8zIKvqgXuKk4HH7cfFIT0wLWxQdZ43+9vmgTE+GRY5GgsRZ4B18B9FbVxiJbtPipNVm7oBkRv+KiywRt0Uax55j4Z0niHd3mywsj9UU60LjFei5AMqQyyBTEK/R1bL6piNjO8gBvllLEWcIW9feXfaG2Sj/8C0MCdrs2gNCMcikzdh13H4ERSoIV4VW3eFZvDxu4bx/pu3jUOX31+fTA3iVHWcHYt/cVXt7TedKf2t26Lhlc1DHBDoUNe0VCFJV8rJiP2XYaaapAWkWbh1bMkNCismKSLoBw4NkawZmeXXIveR/vLffOm+xpk2p0EB07nkhhlx3xCMsZt6owveoARYquQy/Br1IXAEt87TaeTGec8FftS6F9SLg8OJbtwNCpoE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KMPStnlRGNMlgOviI7qNsMAqyrXnWfwqcjpNvhvh3RPcQqiGtITzT46rmwRG?=
 =?us-ascii?Q?8oU5N90Gr7Vx8P8woMkZurZ5KoDUbrO0okbcCLLtm8/ncf2abZ43CbbRsrbz?=
 =?us-ascii?Q?8v2S3VkDgQBKfXeQe4a/A9hvfus/kdrjESRPG75tKA7AUM7EyvIaha/bW3Rm?=
 =?us-ascii?Q?xMofXBD0jdGwf0zQx231HVAsrpbLiWxPyV+ZLUYk6vv0zE+jautAYfBFcNDi?=
 =?us-ascii?Q?LOjVf7L57RGNvVyVDst606fv30/5eOyCRiiZT6NyXWyWJaQY0YC0tTD2+Oni?=
 =?us-ascii?Q?7CtJPXszQQURnnfrIqlrDysJDLmAWrybogHGa8hkX68gU23Y4OlEs/dQx5jd?=
 =?us-ascii?Q?GGNDvDrVFpQba2TTZwerkLaur4PeuV4Sff540TOM2nnBahNERvPT5uMxJoat?=
 =?us-ascii?Q?hjImD1AhZjcMteRTcMMmSR2S0AhWl/7uygRop6d6cdHJNat6tQjGySK1G14Q?=
 =?us-ascii?Q?JXleIP+fo5v2SDTBHk8nu43BR9wcG/STsbhNuAMAo4aqWFUGDFxt/jaIWCYU?=
 =?us-ascii?Q?qiuMdLXGUImLuAzoQE7FTELg8TPqMyxLASIUqPVmmJN4liae/4eJIKO4T3LK?=
 =?us-ascii?Q?GthFF4pnwhFv4RcOJArpZ2EOBY+qANx51Hawa5gjFQOIM9R8td78dbOeeHhV?=
 =?us-ascii?Q?LpTTzdSRavQsuchUtYohwxNKYR9OUbW0AQxxHuJ8svkF/eudeoJfrhbfAICQ?=
 =?us-ascii?Q?XNaqaTGd/mM6yF/IIrNLFlFpL+cGrHqdEgpytr1iJWx0+m4yZFRz+78DkUFA?=
 =?us-ascii?Q?fxt2aUqVWGz+pgeomD17NuGcjr8lR4kd/XE/7Yj8tLKklP5FKw6ary/wudP0?=
 =?us-ascii?Q?mnFTXyNWJ5innknIH+/Sj0KthqJjslNB6SSMoYEmfRKN548/3JJIPWdWgWF0?=
 =?us-ascii?Q?Jy5ExCsqBPzXoCaO3sGYdReExBtarL12IjB8ccJPX8LWRJCXcsG/1IKR3Gp1?=
 =?us-ascii?Q?aVzs28wvaa8slOMCSqmxMTTw0cjJ3a18ke+uK4ifQLF8Y5PUzo/mS+UW+VSZ?=
 =?us-ascii?Q?r9kOl26gWXgZVOnBlMF1mIn75b3fmqYKBALu5NwDCNrqB6vDQsvAR+5xo3zI?=
 =?us-ascii?Q?NRojaES2qxedaC8U6ThqZRuQfN5bqKceVUH0qMYM5DNnLnsugD0Ns/QS0xGD?=
 =?us-ascii?Q?nht8rHJgUy2EJpHnlED7+kfYkfWBXUiZT6qcFrFE4wL1sQmxqVHAUfG0x04M?=
 =?us-ascii?Q?yeOdf/o7mxYoaiHY8XQs6c2wJudsBT50slbLPTmUuCs6SDBoIQRbz4VceSmq?=
 =?us-ascii?Q?vZGIdf32YmP9uC72uWzpDU7F7XcflAVdCWFvmK3YAY3TQs/hTqwE5qg1bxkz?=
 =?us-ascii?Q?3PockXWziDN2SMXvqrmCcwBAnr23xE++7GPmzAgxg/16yFKcey8aJPrNneYJ?=
 =?us-ascii?Q?FOh/kknFRq4avyBhaBgP4qJ6Joh9DYMrxBixygFdbKnXIeMazwKNdRcOsUD8?=
 =?us-ascii?Q?O0wMYJDu3WqDytxxEGWghk+Ma+pvwA5eZSORmrhlqJFBWjAijF3s0njj758b?=
 =?us-ascii?Q?+5he7c8cJaiJlkcVKJxKB9rzQjZWVZOKam0Npyr260yvD8qrfdFgYXQ2YS/g?=
 =?us-ascii?Q?Cv4GNhbSP1xrnIJZbWueb763BNP0PF2wKMLjeXhUq5izqWDhCmbtUVOACWy5?=
 =?us-ascii?Q?UKOyyX9EnctZ+0LMmxX9/SRgiWYQRWR91ATlZqDiX+oAbrJg8AvbgBwFQi7t?=
 =?us-ascii?Q?eTARbzhzbbGbxBbZVhaE1MqFu3c0Dn33iUvQC1YqZaBd5dM43ajg0OATObxz?=
 =?us-ascii?Q?1ybKjBwJ+eaYNSKElgQYAmud+N6mQb7RCydvOWnanHiN8KC8YbnH?=
X-OriginatorOrg: valinux.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: 77aeb71a-264c-4dd1-157e-08de7992857b
X-MS-Exchange-CrossTenant-AuthSource: TY7P286MB7722.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2026 02:05:34.5557
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 7a57bee8-f73d-4c5f-a4f7-d72c91c8c111
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EkbnmpCMQ5aYYTFqkiK1J03uxdL9HMfEquLoSnOW2nGHCuzGBNlUNmuPQPSO7QhY3A8tSsaOXFPWTprGNlBWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9P286MB7418

When BAR_PEER_SPAD and BAR_CONFIG share one PCI BAR, the module teardown
path ends up calling pci_iounmap() on the same iomem with some offset,
which is unnecessary and triggers a kernel warning like the following:

  Trying to vunmap() nonexistent vm area (0000000069a5ffe8)
  WARNING: mm/vmalloc.c:3470 at vunmap+0x58/0x68, CPU#5: modprobe/2937
  [...]
  Call trace:
   vunmap+0x58/0x68 (P)
   iounmap+0x34/0x48
   pci_iounmap+0x2c/0x40
   ntb_epf_pci_remove+0x44/0x80 [ntb_hw_epf]
   pci_device_remove+0x48/0xf8
   device_remove+0x50/0x88
   device_release_driver_internal+0x1c8/0x228
   driver_detach+0x50/0xb0
   bus_remove_driver+0x74/0x100
   driver_unregister+0x34/0x68
   pci_unregister_driver+0x34/0xa0
   ntb_epf_pci_driver_exit+0x14/0xfe0 [ntb_hw_epf]
  [...]

Fix it by unmapping only when PEER_SPAD and CONFIG use difference bars.

Cc: stable@vger.kernel.org
Fixes: e75d5ae8ab88 ("NTB: epf: Allow more flexibility in the memory BAR map method")
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Koichiro Den <den@valinux.co.jp>
---
Split off from a previously combined series:
https://lore.kernel.org/linux-pci/20251202072348.2752371-2-den@valinux.co.jp/

 drivers/ntb/hw/epf/ntb_hw_epf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index d3ecf25a5162..9935da48a52e 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -646,7 +646,8 @@ static void ntb_epf_deinit_pci(struct ntb_epf_dev *ndev)
 	struct pci_dev *pdev = ndev->ntb.pdev;
 
 	pci_iounmap(pdev, ndev->ctrl_reg);
-	pci_iounmap(pdev, ndev->peer_spad_reg);
+	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG])
+		pci_iounmap(pdev, ndev->peer_spad_reg);
 	pci_iounmap(pdev, ndev->db_reg);
 
 	pci_release_regions(pdev);
-- 
2.51.0

