Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F24286D73
	for <ntb@lists.linux.dev>; Fri, 12 Sep 2025 10:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672798; cv=fail; b=A8K3pEVQGx3lDAbD+4FGR2At32AaWVGCZd/AHb0kKgDmLBMRfQDkFMTFMK42sMccy9eScss/VHVY7ONV60n0GbkSWfzgZQyM4Nt/PebNGNwFuwAtLgyzyL2+K6TTU+IexBcfWJ/AI/zlM6SIHAOb1jAWPQ+5SOQwU0u3f7Rbats=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672798; c=relaxed/simple;
	bh=TSm5zYw+GM6MF/D6tFk0dHUrc5FMKUkwlL0+2WXbjxk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hiX12SAfG8oUQsgkGGQwVDtNapBkk4iP3JKIdyeRmmHNL5kSbL2GQBkVDBv+ioQ/LtW+c8aFBwIZLusI66AQ2YzCxnPOGX5FN0osQUs3W/FQ365GCsf9gJo3VKAaTgppf0KP7x8kOuqymVJGjJF3arMtElz4CGVmQV2L3PVQI5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=fZfKWpsT; arc=fail smtp.client-ip=40.107.92.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="fZfKWpsT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrKEk/VgYeEvRVmCaD/cYZOM6R7bFRgHRY/K7JHefyaHbm8Yoxakmpv+IZ4VFkDqb2DzOKzW8PMsTPLSWseK0JBGTYMkGemIK9EZOErW+DogQNHpRq3H+DZQbOensapwmaFzEmTP6uI3ulgF8lWnJij9Gg1Yb87WkQWFI7cS6OEE6QndkJGbrdz8Qvbsx6E7FlzrIx5zhvETywsxIa6MkXpywzr7RM3hxnPmpzlvkwwiRXu9eozJA7nKYRQNQz1sTrAvvAatX5qpDRP0l2J0wFtPX5AXLdxr1BTX9CLGyNLyaolSS48LJlyiyyhv7YdRohxNgE1VzSqib323bt79gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jpL72/ZC1NkhFEaNPCpZy9PdTFL1VVbXXY8wI+WXG4E=;
 b=EM4f5IXAJDdifEg9LSkAQd26JZFDUdkBClUFHIYAXu+YvS8fuwdDyyTmIFoB99mEaNroqdzayuXZA7EAWBxgOCz68HAZmpHABGU+73QV4SIfCCBxWu7dH7XYutDE4miXrZMWv9iR6O9/4Ytdxu9VseS3/w+s9VrrQ4pR0x+euY8FNXdl51Z1i74EmsSIN1N93gQOlXji0bXg0ThhdlhtDefouQy5cwL1EfrDVognIESty6coffeB9noLeyaWIqv27QKkMRAsM/kWUJZOh8+Qt+RdNA/7GZVJh3LEAGU+nwKmPn+m+A2lQbk8U+euuPFdyHPF5uVsYABu1UoQTMuUyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jpL72/ZC1NkhFEaNPCpZy9PdTFL1VVbXXY8wI+WXG4E=;
 b=fZfKWpsTgjLl8jQQRI74VAHeA0X3+p+9XUkQ48qNScRNGUWxQjJQgcCn5h+bvnwjGNvWT9ULoeeh5qikHlBJ2cJRi8rC9J8U1Hk5yWvYALt8fMy4+4bQFDCaJpIro2h/eHPXHpdOT/Yp/0QovlWVyEsUlD78FhSGeKgZ2ndTl14=
Received: from SJ0PR13CA0149.namprd13.prod.outlook.com (2603:10b6:a03:2c6::34)
 by IA0PR12MB7650.namprd12.prod.outlook.com (2603:10b6:208:436::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:26:33 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::86) by SJ0PR13CA0149.outlook.office365.com
 (2603:10b6:a03:2c6::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Fri,
 12 Sep 2025 10:26:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:26:32 +0000
Received: from jatayu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:26:29 -0700
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 0/2] Updates to AMD NTB driver 
Date: Fri, 12 Sep 2025 15:56:02 +0530
Message-ID: <20250912102604.765444-1-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|IA0PR12MB7650:EE_
X-MS-Office365-Filtering-Correlation-Id: bd6e735a-cc2b-4385-9fee-08ddf1e6d839
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UVw4OVpHXwtPvO718iO40xkfSP2HT6TiIuzce32tPJNPAhWdEjMvcv44vAZm?=
 =?us-ascii?Q?VIJQ10MGKbZN2lh8KvAc9rZXpMQkpA2ZmgzNy2rPgYbXQqRSUUlTQg0t2ffs?=
 =?us-ascii?Q?MhDtQNVGzQGdWpSosIYs0cbws/SMUGhkkNa7rvs0EpiYv67gCX4ASSGInX/L?=
 =?us-ascii?Q?we8RrhgKTE0CN+iT5q22SLmRDdJa2tlEEqp52ykD7LiKcfnsqEF1J0/I+s2R?=
 =?us-ascii?Q?nMWH6g4SrznWAklPSKfB+wCSdlF52WdvljK905+Eb2GRhrfkZcJZ2FcywKpu?=
 =?us-ascii?Q?V0YHUT51SXNBIY0u6y0aOe7ENnso4gBRr07tDpOjArYVfYsB9zA3LiFXktBb?=
 =?us-ascii?Q?+M/o9IUOumLEy5xfH3HcxCkE1ammCA36TfzfxzbSjuHgo22qv5YT45+hrYjz?=
 =?us-ascii?Q?8TBMk2Uad3+drZLSeB4TZen91NO0oO1LtPA5IwzeQJm1N5s3tMyHq475mLEs?=
 =?us-ascii?Q?ISfdOVzdibTITCUt6vGg+oByNWUut8HqwaC3aIijZEXdwtxgYru7dZa+OeGr?=
 =?us-ascii?Q?Gt9QKCImR3lil4U1Y+0/2kZbj5g5ajxVxrUJkFnMMLEn4egXuYT/8PFFrWdh?=
 =?us-ascii?Q?ctp0c6CStlIGUpqAWSQRc9nSMing2MbO+Rrw/OAo65SgBeaWvPMS8piqIKph?=
 =?us-ascii?Q?8YuN97eqGTuax9DinkjewESzQafx2UEZt5fwkGSu9jol1m2UMeAVWefMibYu?=
 =?us-ascii?Q?DV7ea/gLQok7YYkBTIpGoFhgOY13tkT+3oJcll3z3vyZmTZrAJPI4oZGdd2+?=
 =?us-ascii?Q?IhuRov8gL60GVuPebkWEebGXKSkL+JArIaO4+t+yTdgRDxW05nB8oBk3D2sw?=
 =?us-ascii?Q?R3aH7WdFVkg285FEek8ANYYObbrOozIM74jp2A2PJa7n5pnMKsRPkLldZIzg?=
 =?us-ascii?Q?LDiUewG9/t1ZCbRT3UHVpaAhNZ3zeq76Vf1W83SptRKnvZTC08slzKgQiLCn?=
 =?us-ascii?Q?yA5gj3qkUTePNlVoA5KTWFdSxsEgoTCVQnUe9K9HNUDTgvmAc1bujCxkb0qO?=
 =?us-ascii?Q?PQGlNXR94ykjYKHp0MTJT1TK/SUYonBz3VCGtbwKmm7bVlAdFs+bZlNxpTfx?=
 =?us-ascii?Q?BbC09X0VPnEd6pCYE76kmOSxa8FuU9nMYRRqT5H/xVe3OFurHC7/iWbCvW5w?=
 =?us-ascii?Q?Et1MywKbH5bzWVwbXORMNvS27S8bc4+3D5A4ZpvahNRbE2VQfzTSXQr46DEj?=
 =?us-ascii?Q?d+DMt808h2/FA9m+5G2O3khL+4x2MGvoUPMQxzq6C60Wkh85A9ChhzFLH+KS?=
 =?us-ascii?Q?KgMbt2kGl7lOHPboTTiSQBMBz9FTsU4AlYZCbzxcTyg2DucnS61IvlYPLZna?=
 =?us-ascii?Q?dqxciGBjrH8rCbOMzi2l+xc5Aby3taNv63XXEZNP5mbVrK+nteVihrbJ4MAO?=
 =?us-ascii?Q?91D8fjDWCmJQzqjT6TgTkqqVK0y1DdeDSX4DqQPomfCu3Qfzk+wzbJq2IF5A?=
 =?us-ascii?Q?sS3B2nc0ssWRiBRlAFd5UMbu92g0MyK8tlgGS1WNsCm+GQx8wfDuPpcxG1Jv?=
 =?us-ascii?Q?0DmTpl+iPEpQKrEq8GXQtgND9QiydR1+oHoV?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:26:32.7570
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd6e735a-cc2b-4385-9fee-08ddf1e6d839
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7650

This patch series include changes for:
 - Adding a new gen CPU support.
 - Update for the NTB AMD driver maintainer.

Basavaraj Natikar (2):
  ntb_hw_amd: Update amd_ntb_get_link_status to support latest
    generation secondary topology
  MAINTAINERS: Update for the NTB AMD driver maintainer

 MAINTAINERS                     |  1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c | 45 +++++++++++++++++++++------------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 3 files changed, 31 insertions(+), 16 deletions(-)

-- 
2.25.1

