Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012016.outbound.protection.outlook.com [40.107.209.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B232E8DF3
	for <ntb@lists.linux.dev>; Thu, 18 Sep 2025 07:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181030; cv=fail; b=OKDF8Ixi1vBojfh8K6DPB9sEPY0W9qxk8fDVy41U0Cw4QuOQcf90Bw2c1OdetrKz8F8TLW621pemlEm/KQeZ3XiumlFZfHpa095PXlp5elMssA4/edEbpMNmjE/yFJb4wfxkNQ0J9FQTDxgv7EKVuuXs3TXpSPfdRf0+sLyFRaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181030; c=relaxed/simple;
	bh=BOYrS002mJuUL3VMavPbgLtIMv+C++FKKk+WHd9S+7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lGEbHPqbm3S0vsoMF0D981WYWSajh89S258pxXoS+CZrn+V8slKL/4spG7grYPrvbaddWA1stV++reKnLzuD5CuUdbawB+ksRAwJzeiE7xBh2TaKZcmVG5vPQ7a7/IGGnU4qseO3p9I2tjWxHjXzidGoMPdHr4rs1/LO0/dVdjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aaZpjJic; arc=fail smtp.client-ip=40.107.209.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aaZpjJic"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9HYDY10XspFI/r1RKwcgFmiR3gIgAxcMgjkxAPpVLSjLGs60/zu8EdrdSBQ3iPPcNVsX0DAGfKUeEdF+qopMFtvvVd/xCuIz6Inr0oA7Vd42NoB1SzPaDwu9GAJlBKYv+tuIKCj4Rqp0TuJoiwSYt5R+dqxnzB+W45K/0lVlgqL09ew+4LVKt6Ft2VtzLEhUnnS2nU+DOru6GEl9ymspqM/QTohIQuntIQKxIQPofSVItxAuQJd0flSEHKffJZInHKFVkWkZVfSfBEzOklWD8n0YoYtGVh5uhTQKnDhVXxJ39E/AQCRl9SuC1LNO683UTv+6ohLLMOTIqgf53BLug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hH4/pDzjO9mn9deNJP2nUG/Q3yzL2TnbYP1vufcFXvc=;
 b=vfDRwS3cGjyBY9mk8+gsKiU/3p//SS8vECgG5UBgz2poYnGb21bHwvhYbfFcNKychVAsgiBeY8qBXugT5Vt1ofuQakzeVir0r4aXXXRtQ+a42r/Jjpk0koh+R/noSE0VPC2nxVXSQiDZEHdfIGMDXvr4sh0wm2gws6+P1fai3LMFOdHDL/5Vcy5homqld4yOFA/whGVfcAEiOqHcMeQBe51QLdke6McJomqOqTf/j2NHMSLgLWjalgTceYwrQytF8Yf3P1NLPVeBWtWt/J/8C8Ni0NBxW4PC41AYVZtdChwgwtn6ZR9q62flJxS9SUF3bunphZCh43pzCpZyEf0qqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hH4/pDzjO9mn9deNJP2nUG/Q3yzL2TnbYP1vufcFXvc=;
 b=aaZpjJicTaGKTAQ9T0aWjuS5u5dUHSt6MDYbDcJtOW+bS/N3yadoWH1wIf2/p0WD46LsQT5emnjitd16kp5AnlE5KXrgdBXMvV4iGMcPpGbD0aQpI+BqeBOWCcntCoN1huzci4hs54rH68En2M+0V0LvNsgd42uJk3f+6ov761Y=
Received: from BLAPR03CA0155.namprd03.prod.outlook.com (2603:10b6:208:32f::13)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d1) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:37:05 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::dc) by BLAPR03CA0155.outlook.office365.com
 (2603:10b6:208:32f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:37:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:37:05 +0000
Received: from jatayu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 00:37:02 -0700
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 0/2] Updates to AMD NTB driver
Date: Thu, 18 Sep 2025 13:04:46 +0530
Message-ID: <20250918073448.1070104-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 59dcf7fc-b301-4b3a-e44f-08ddf6862a37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+agl8RjSed7CUYK1/4EkDbysH8+m2XkfDkmLEL5LwLLmZqCuFYuy9PamDybD?=
 =?us-ascii?Q?5AhdIeejdeOkjR7+ug9Nj2yZfNC3twWT67QARfKJ+uaDybAmGjCKaxI/SqIx?=
 =?us-ascii?Q?4kzo1CoZgv+FiJs9yaiofzA7MeDT0IKekyd/lw+Wgx9CaeaBhNiY6PK7/LGn?=
 =?us-ascii?Q?I7dXM0Y7ul9kWYRuJUPlJluAc561Z5ASjbz18jZumlhnautcbLOSo8GDGRvi?=
 =?us-ascii?Q?bM35iqh+V2abpRIQQPCHqpvc/78AiH7bnlMVnrvHAEEDMtblX94feNC0pEpz?=
 =?us-ascii?Q?c4Rimyh2e+VeoIozHue10FUjosLQ8riCvEZ8w5M1Z+l9b5kANuhk+YoS+lDR?=
 =?us-ascii?Q?1AxUSgKDd22rA5tbsEwqAw0EhgSo1rLaLGRwXe4uXYE2Gjec09DI6O/UAjns?=
 =?us-ascii?Q?NguqU9puh3nh47m/uppoMMX+TfKXEemLQ7eJ3WZ1GQXHrY295vTqgMf/nDcn?=
 =?us-ascii?Q?2gT4ucX5bG8bqNQoaiBCpEhPj2bwg7tSJWjAO7PmFPqBKw11hYCmeLIZSMGy?=
 =?us-ascii?Q?ysYm0koVVsTo2hzrY47UxPcGVsnZHJun3RU+LHlnBACZFX+A7MFBjeXZXFI6?=
 =?us-ascii?Q?5UWbbaSbj5ubndXxYGQ1x0liwwlYCfuf8AV6oNElxYe2rFUXeAzEbzng2z0B?=
 =?us-ascii?Q?kQ8xARL3sxR4hLMN9rIQg++6MHAus7zSF1zKHO4pOtj6cysC1ovV/06Z7cTq?=
 =?us-ascii?Q?O0TKYxlQeNtHnAAkiySp3/Hkon9KJWbdP17pnNdcFtfhUuxBGQjF6n7HAyYk?=
 =?us-ascii?Q?v12nQHBAzqOxN81Kl7R8LrPJWi9taleDa0EcZUdNpBcsjyqjJG3C86tgXI2P?=
 =?us-ascii?Q?mbId8IcXLP162lRLdCGPqqrtXSXUI8oC8iTDFZnJEK4Bjfe1r8u1ZZWNpNnc?=
 =?us-ascii?Q?UHil0/TFlgElJqjWc7HMepKjpQuxIr+BRAIhekw27AIdBPTU3pq6tVtQYodZ?=
 =?us-ascii?Q?46OX3nUEfMHMBwxTycuNjxwUZa79Jh58amA6qG4FavYoEUHmF9kA1CJIZa/B?=
 =?us-ascii?Q?1Wk9PtkMnPIQq0+tzBvjxV/j6ZEs2xOTAlriu6B30z96rkz622+ktMfQ77gz?=
 =?us-ascii?Q?yYQssOO2y0xxnZhZ7H56whNOGZbNHq9sNFpPgSitT04dRsonFuJVMGJphiJM?=
 =?us-ascii?Q?l+6zdSyDzIfSFicYxJTjp2XtrXPYymw7fWlf6Phs5P3MjJnGOSizGYSGH+BT?=
 =?us-ascii?Q?bn3wTulkmZT27U0iaKJM3vtrwiGTlpUil6nNPL6tMZGLWW6JSTzqVAj3PIUX?=
 =?us-ascii?Q?MQrpuYR2BXCSM1hyK74CMlzBwyXb2nFLVFVtWmw0T0zQAiSP7dz/wXnGxJn2?=
 =?us-ascii?Q?dW4Z/+9rnx3+pu0toJd018ziXrbOi5177TggIJx+lzUqwYgrlOg8nSUegufk?=
 =?us-ascii?Q?jBG3HE9Ki3mLp+lOWviMNsZvn6TTZ2AYAJ8rGe+muwpnvy/PdrkOT/rRxhJF?=
 =?us-ascii?Q?qnos9I2SuZz+qQ5ZDnELitotgYwPpbYgkQsNl67LW/rEMk+135wvTIdiJtBp?=
 =?us-ascii?Q?uvrMXBHwHeF1kBzo8TP23xV9nt49VwbNR14Q?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:37:05.0425
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dcf7fc-b301-4b3a-e44f-08ddf6862a37
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1

This patch series include changes for:
 - Adding a new gen CPU support.
 - Update for the NTB AMD driver maintainer.

Changes in v2:
	-  Reformatted block to reduce indentation
	   by using early returns.

Basavaraj Natikar (2):
  ntb_hw_amd: Update amd_ntb_get_link_status to support latest
    generation secondary topology
  MAINTAINERS: Update for the NTB AMD driver maintainer

 MAINTAINERS                     |  1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c | 18 +++++++++++++++++-
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

-- 
2.25.1

