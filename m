Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2077.outbound.protection.outlook.com [40.107.237.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A16D1E520A
	for <ntb@lists.linux.dev>; Fri, 12 Sep 2025 10:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672806; cv=fail; b=X7SBGz5BkLvxyZjWf/Ridj2ZHoIiBRiHQ/b86dQRk1ciAaQ4DuxqQlo/2KGCcSOnBtPNJMtmJ4cnkjK+l4jyGTZEP113mZj+9xtB9jE8KhEtMJUTqxXUtQ27sJNyz30Qsj0RsvI+NQxDwzL1pFkiIX5I8muSQX5HoKTl96OXjA0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672806; c=relaxed/simple;
	bh=0zYbDZxKzQxx4f7KL0H6kMiKySq2VUYwV2Q+tLgS97A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GDDNK2KxeVcNlUNiB4KF8kF9vQCkQ150+r6q5mbNbfv8H9VKVzkXEulhQoJ0xK0FF0Ye+w3y1yt+XuWpJwDW8Pe2YSubkJ80drBskamJ9nbCDWB345CJkS5Pi6DHMpFF/YpXE4v74EvvdVw8xnbLwCHA+n199uak3OUmtTNFefI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AToM1pSi; arc=fail smtp.client-ip=40.107.237.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AToM1pSi"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHqyNiopwcOytl/VkAQy5w0mO73WIAn0Ohw1h+V/y2tALIHyBrO/Slt1p+3OoYz4L/nQNQeAtSb4Vg1pJrxHnef0dbIx+q5Vq0vkqGqAIY7SYOe2paHZsfpayCXdHuElbH7hqQRDCUgmZZwkXZfnf6YXSvyzrQqb4PWfmJJpa7eSIAPYFNi2FMZ21LbQd27mtJGetjPl/t8YWZtoJN/GpXzBK4GWDLf2e2JsZxohs3a59AVx1sNTQ8k159j1YUE1LtbFGe/Lrn0yj7QgfU3ZDtNkGPb9MTMkcZXeVURbWYEw3RdmPpUsadXLH8jfOCHHw5piAkuY0lQ1AKxJzAzlNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ugMsrEYYtEVRY1gfn4P84HfKiX0TwqBdiw0xETpSj0A=;
 b=GolySi+o3VRUmobXXt7SBxScLLQgQvKpttUbAn8Bvh8A5lKZtssEgV2P9+ePwlltHj+h5fTJ9PO94cRyEONWa4mnvep7OhskWnVUTcLE5HX1vXdcpclWsVtfouM3FkRhlyc0kfQ28Z3tP2eqsvj+UeTvYwytOLxVQLveSj3Jq+8Y2SrlZEaWDqKfvfoDnkgX81fmgbyDr+km3o0/PkYKfo4YBuWlyKu3sketKuEW9EZgcJcoXwC+h6c9YPJ9z5N6T7AXPqsb7qgA4FzSil7oYhIpitKO5JgIUa5A4JIfWI7GV7roOsT4sPhuLeZjfIlKIv3zHGApvFceSNe0j4hNOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ugMsrEYYtEVRY1gfn4P84HfKiX0TwqBdiw0xETpSj0A=;
 b=AToM1pSiydmXj6Sqc5gcBwuUbfJSVanvAUgvYRtZcwKLe9Hkfq9g3wHaB3MirjSHAsXSsso/XcUd2T4WqLrhySvxm2c9jXi7XtAWYDG3UmiBTajngxMNa+HAOto+K7gURG81NRKSrBZ1+Z7MzdZ/Dg2gEBKvHQ4r7fBUbWhvRwk=
Received: from SJ0PR13CA0138.namprd13.prod.outlook.com (2603:10b6:a03:2c6::23)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:26:40 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::a4) by SJ0PR13CA0138.outlook.office365.com
 (2603:10b6:a03:2c6::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.8 via Frontend Transport; Fri,
 12 Sep 2025 10:26:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:26:40 +0000
Received: from jatayu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:26:36 -0700
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 2/2] MAINTAINERS: Update for the NTB AMD driver maintainer
Date: Fri, 12 Sep 2025 15:56:04 +0530
Message-ID: <20250912102604.765444-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250912102604.765444-1-Basavaraj.Natikar@amd.com>
References: <20250912102604.765444-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|PH7PR12MB7188:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d249ac7-f8f2-482c-7cbd-08ddf1e6dcd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bjzMDD4zw2n+uk3ISC7F3Wkjr4Q/eUhheRfQYY79h/CBnnbZpgC7H41DizD3?=
 =?us-ascii?Q?ojJ+yiOe30vE32Pm9reHGBaF5g9+i0XYVOrCqTfZK8AjrwUTRHWfTxWhsj69?=
 =?us-ascii?Q?OvT3tfOP78/vVkPN8czPHu4DWr22IFk/RlHvWJdEeOyigKE9EZMk9aO85U5z?=
 =?us-ascii?Q?8OUukwlFwQPJDbwaDEwxdFD1EC/koDSOtCeFVpf/2j4i0+hX02xUQ64wiNHv?=
 =?us-ascii?Q?ddwRM5RU5q2XnZSRexBEg7yw2VwE1Wd/OoHWs/CQQbjUO4QdvsLwl90PcvVg?=
 =?us-ascii?Q?jPsZ5xaulZhDwUX89X+Sustty1tCOcC4gmc8w5tHFo0jVLx7kXqc/xJHDU5y?=
 =?us-ascii?Q?Mktye+x2Dt+I6O0g6ZmR8M5CkGMdle0HRAa63NR4PcDpwdGmDfSGh3DcMo5z?=
 =?us-ascii?Q?YNdM3vv5EIwb0+RmPpa0R6DM+5amvnrYTQ0jAR1BwpQVrXL2GC2+gzYFizau?=
 =?us-ascii?Q?qJZVWse2rhkBsf45WOx3u38JFHHoZAPst6cTio6rwhITjQBL3gvFV5DoyMl8?=
 =?us-ascii?Q?mxNU7gWm/ySu/bSqI+5uK9Cu1z8fCyn2A2PmB1+f8Q3Xk0Im484ub3O8KLCH?=
 =?us-ascii?Q?JqbToDZK5ALuk3slnrii5q1Xq+cl8J+bxZomaY2AzishrySE8gzvM+HpRCjm?=
 =?us-ascii?Q?gcIhrDMYciaLeJ37RykqYYLAXdtZjUqyMaG3rJtUDQFGUlfmJziJxFyKevUN?=
 =?us-ascii?Q?A1kuI8A5daUJnEyyX2mHORDTbl4Pe9tFiNd4lAYhUctKc9wbW322m152UcGf?=
 =?us-ascii?Q?Tboqyh9QlL9zy+2VPql3NPO1IjsMXs5OjJyyDL6k2FNq9PIPt0ZT6CC3h20d?=
 =?us-ascii?Q?+lSC39f9o7d/BATMkuG8TPVGIVU7VHhUeAEWmkcOwngJWgtq5o1o9m1WvlnN?=
 =?us-ascii?Q?OUjJioAeWnJNS21Iu3hmZ81i4VhJMxIjKzkOLN+i7F7zqBOd/rPStNDXVsri?=
 =?us-ascii?Q?/Hwu3WYXVy+LzDuuRkHx7jJum0MkU243xn0UItBj6PNQsKrrJfCKN62Cldd4?=
 =?us-ascii?Q?w1FuXWJ/BGzRbOTJF2liQiYuugoCyYnMAJ9Eu6d3OebfVVVBjgXdvf0sp22F?=
 =?us-ascii?Q?lHNOby8j+HAzB3pVMEVmtQv/HodV5Ex24HiknF6jMAXHvADdV0vCEQm+7P+D?=
 =?us-ascii?Q?m1Af0UcoaFCBZN1wGOwQzde0xcC3HXcVmoiuh7ZJBdgC3Qdo9GBw/JPVyc9P?=
 =?us-ascii?Q?4+XF8LKAYcifPH9jznirsbPYtwjZxq4ufrP/R7oyzF78zm/ZXHCZdq6Lr1PV?=
 =?us-ascii?Q?t2/9jrhc/XkTXBDtZrhYYFkQ8miHEekxHyhqZBDox7jWRs89yQNn/e9ywcIZ?=
 =?us-ascii?Q?OZfFG5KwXFNZgbkKJ4oTVQkzL3AKTiur/GBxUGphN2qEHO2EllGdwpH4hl5z?=
 =?us-ascii?Q?rjkXT7JIANLKgIcNXvjKxFkO7FLa6ZQU4mxGNRQUsKq68iKZueYShkPhSFAT?=
 =?us-ascii?Q?xZphbodsmjbKDFSTtDsN5O0KnfAEik3YeV2Am3+EKBnIPYXYrwQMBcIZmp1t?=
 =?us-ascii?Q?y7gyD+Ig3gYXfu75wdN/EMySZPDZ5i7ld7BE?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:26:40.4901
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d249ac7-f8f2-482c-7cbd-08ddf1e6dcd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

Adding myself to the maintainers list for the ntb_hw_amd driver.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ea95802d87e1..76b1625c8247 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18056,6 +18056,7 @@ F:	Documentation/core-api/symbol-namespaces.rst
 F:	scripts/nsdeps
 
 NTB AMD DRIVER
+M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	ntb@lists.linux.dev
 S:	Supported
-- 
2.25.1

