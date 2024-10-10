Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2085.outbound.protection.outlook.com [40.107.100.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC3B18F2FF
	for <ntb@lists.linux.dev>; Thu, 10 Oct 2024 04:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728536265; cv=fail; b=R4/qMtBl6yb7i7hKtqpKmESngn3hupTyVQ8T31QjOXzGJ2IQAMr6MudtBC3sTmvA9ZNSb7PdCqTo8dwSqt4zygmuiEwLB9Cp54c3z+PfoiQi9Nru3zYNZZ076Ltf6EACuGmeJ5jT+6iTIe4F1Xc1fM9BXHYhD/pBI8iyGBJjB/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728536265; c=relaxed/simple;
	bh=Zit9gyBCPp4cwXWvKzP+u+X1mTKoUPDzbVzQBviaXU4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EA57fExV9OfodsSOqlo8TQpL51AtiKw7ZNjATPMFse4tmhMZdRCp51cwuiUn5TKl5j/WLZD+2OTYYiLhFClTdjuh+IprPEA/E3G+XecA/ZJbZvtdD4r113T7/N6KRMHtmwJZ0+RhbsYLxu4zOrkxVHteRi8Usu/PLi+WOaoDkHo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sPxjKypM; arc=fail smtp.client-ip=40.107.100.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sPxjKypM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cA2JoNx4xFdHmj0hDCJ+8qxV3wytH+4FiCQT5wb0uB9MiPLYchYf1sSmAEGPg9+xET7BYykZ5fNEUtkn7l5VXcgsrrucR+6seUK3Fp/LLYcS2YaA/vJaVe/ilKaq7rnOfGzbSVe8Qi4KFXn/iFLXo8pzRCyK126yJ0sqLMKleX4jJVoYAbQvAk/xqguXh0NBmcl8Hcp+HHzN9TGdZLRe4A9VRjUhzpK7gsKPbT+8IJYnsxV4atX2yG4XDBgKfUyiZ3kVH4by9apACQd40OtAh2yAl6NTcRJ6DlsP+qepxVUzxfx6hM3M472NxSb9KA805QhcaM5bQZ8I+cFDF1Im7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uDC4St1GEd/XMM8xHNYlvzhhzJdupN2su443arqW0RM=;
 b=ugzzHWT4/n0B7oOqsW1vS6sS58FUiMQRzKVfL/btghyU8pJyqAXICH/Py+0RDMOlFX0N9uiyddo2DDwidJC9lgC/o3WY5WG+jhvhEsHf7O1b9TssvilDySOhaX6RtrkAX/+uGEmh/zurOlGXKRdDVpYo6BQBcRIOu9JtLlI6CiWYl0FJTytsynYaOrfqnZ9x/S0wpGecUWQ5u68Pmn9hCfv7CkJmce56jrszLarNh5ocLylXEGlb+oAzGV6mmp54eOE4eCuq+748kbYdWpF2xU8CHP15M95wCN0URdcUKU91pofZ6lOdUeg8KqlDDjMmtTsGY6FpqTxDHS66puf9Gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uDC4St1GEd/XMM8xHNYlvzhhzJdupN2su443arqW0RM=;
 b=sPxjKypMakxHUYoLkA/9XXXMG4iMi1TU9B/3PjLXBd+DyE+tSO9VIhwyTtEC47hx98U5gSX+2gFiqUP1vKETsIa32dNmwN8Uoo90eVNItZOESKIa2vCE2Zq7/Zg7InxtHHXibxF00LL50+wLa7WWfbYDbchKm76HR6lsqS+5sE0=
Received: from CH3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1e8::16)
 by BL1PR12MB5708.namprd12.prod.outlook.com (2603:10b6:208:387::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 04:57:40 +0000
Received: from DS2PEPF00003444.namprd04.prod.outlook.com
 (2603:10b6:610:1e8:cafe::b3) by CH3P220CA0014.outlook.office365.com
 (2603:10b6:610:1e8::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18 via Frontend
 Transport; Thu, 10 Oct 2024 04:57:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003444.mail.protection.outlook.com (10.167.17.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 04:57:39 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 9 Oct
 2024 23:57:37 -0500
From: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
CC: <ntb@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] MAINTAINERS: Update AMD NTB maintainers
Date: Thu, 10 Oct 2024 10:26:54 +0530
Message-ID: <20241010045654.4110321-1-Shyam-sundar.S-k@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003444:EE_|BL1PR12MB5708:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d80a390-76dc-4bd2-1e3f-08dce8e81143
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kj7J3bIl52Wrdpr+79IT3E+QjZZnH64073bRR28ExAOms2ljYNDjngxAO4qh?=
 =?us-ascii?Q?1hdYTpBP2dOJTyNpaZCXIvxUp6RaUjG19FrR3YBzUAQGMZ8tDtBztMYwNSIi?=
 =?us-ascii?Q?KFxiuuqfaxtqHiITja2Yf+cqYamel3pzDwD2bvsiXVO7V075HalEIZ+mMzN4?=
 =?us-ascii?Q?0BUX382u/rnwtlBy1fCvOcpZ/kIQ4RB76FtiwghjFTgkQfwHQJPGhURosRdJ?=
 =?us-ascii?Q?K7CIvW3iSGyGG1deS4C2Yo97sVFLZ6LY1c+hekIVTUZjzhqMuaFAafKPuOzs?=
 =?us-ascii?Q?Yg4qNyDjCW/RSGNv7Hh0lDPzO5xv9Plq8MCJBtr51et9yDFygjIJurbAkOQL?=
 =?us-ascii?Q?k5LUokmnC2izKy9MaTczl77QQPOtsKfvOzaDMkwMLcT0hjKIV92VxzEj6x03?=
 =?us-ascii?Q?4yoBt/c2Wu1RWhY8VYYJmylViAgS+SB69WY1rVMwu8xKBJ4qA7dnB2YFH4Er?=
 =?us-ascii?Q?Jk9KLi/StTSR5UwMi3J87jqu8KqscIaXTjtZ6xyrWNRuBdbDLz+OILPEsqSb?=
 =?us-ascii?Q?F+NkkHpNyw6t2ONDT1ntnY/Sjw5Burcx8SA6jAvpLPonH4XwEgnQNpLkEWTI?=
 =?us-ascii?Q?yWYSe6W8ujDPTSO/Tz0kwFUOtUE0g+WpVBpBzwRJ+WToQWXyHJQstwdJGY0I?=
 =?us-ascii?Q?QkLiOJ0J9eEoH7htlWFq2QgD0TnkmcMibijl0gvOKUY6Xy9lSaGQR+xLCNYH?=
 =?us-ascii?Q?Q/SNqYRCF3FZiXuuu68tz3n2afpz+61dm7spA2QSTJuPO/6LyIFU38l7a+FV?=
 =?us-ascii?Q?DGBgbGWUlAat971qm1yS4R0GynHsj1fORcmEZgyc1FfSqeTt9iclfjBkG1ED?=
 =?us-ascii?Q?U/V8upGx0TVbk8yNYf2NjgjO9mH1E1oaLeXgMGdepoj96PskExVHoYOJNSG5?=
 =?us-ascii?Q?/kA5+pUGWN5dc4fTCteXdz531ZWvoyRRNtSIf5GdRu/bPZqPsrQMa7DfoEGh?=
 =?us-ascii?Q?r4eQbJhCFPiq2FbjMOdDz1FE7xjvjzt1gEFMeYk4rXl7+Nk5K1fl4W+tD4sz?=
 =?us-ascii?Q?+WHOWg10BDu5EXC6Ilblq1BNHxHx9PoFKN0OZjqQzAzXU8Wj/Clhv3BpzxWu?=
 =?us-ascii?Q?okRkQeVqs50PuC+k1TXBBYE+OG6VLVpzFzmkK3pSDdla5NReGnEqL9nRqoWf?=
 =?us-ascii?Q?G0LdN5gGQC/iOin+5RHSJRru58B0IK5UwTplheK2I6Ck+g0oDCP0JTCY9YGT?=
 =?us-ascii?Q?etWJ8eOgZUu6WHYQF66XRIBLS0QZMlj/jRkwUgy3PJcjJszpFz3Kxx2Nd/Oy?=
 =?us-ascii?Q?i0Zay8swa0rannbJUYOUtK0fuTze/aLYzmPldzaQqaKWT19jU2m8aYY7U3Px?=
 =?us-ascii?Q?gtafKWGsf1ITQ2RvGdWMqU3ffqMjBJ9KKkXu+nGffkDiP8bt4bR9lnzKDVPG?=
 =?us-ascii?Q?GujnIsXyw1EyErThswF2ieDQ2tQ6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 04:57:39.8342
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d80a390-76dc-4bd2-1e3f-08dce8e81143
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003444.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5708

Sanju is no longer with AMD. Update the MAINTAINERS file record.

Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a097afd76ded..b0ff1b6164ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16491,7 +16491,6 @@ F:	Documentation/core-api/symbol-namespaces.rst
 F:	scripts/nsdeps
 
 NTB AMD DRIVER
-M:	Sanjay R Mehta <sanju.mehta@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	ntb@lists.linux.dev
 S:	Supported
-- 
2.34.1

