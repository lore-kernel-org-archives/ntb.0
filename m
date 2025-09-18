Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010012.outbound.protection.outlook.com [52.101.56.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939F82E41E
	for <ntb@lists.linux.dev>; Thu, 18 Sep 2025 07:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181039; cv=fail; b=rcDNJKK0qmZzGSzKjlOkiC2fmFrD5tsYtHYZ1pptTNAhgTzC9KTmL23GxhO5vIDxnnbRFxgvVPJ/8HtuVFnvCCrG273SLGeevhzlwepjeI7Q9PK7grMbcEzrXhHfNOgOdnnG7YFctPAr/FJrIfU2AG3/MvMksT9rmtiShnatNe8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181039; c=relaxed/simple;
	bh=pI3CLpevXu6w95vpFBNHuEold6kbQo+lRfnwXWmb+ng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gll+SzohDVXZxxXiJQrGKEv3HEKiF6IaWKKeg3Kav3xovX2TaACqksu8ZWgyAIAUWUcVJh52EyeyARjnYOmYmB6XG5/XK07pm9ghDkjErsXE1i7LiIjX7McJYE302LaJar26AXqQyDadp0tgVxnyenysXpdsNqdW8Rlqp80Cb94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1UradrZS; arc=fail smtp.client-ip=52.101.56.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1UradrZS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZbHwB71wlKR+O/W2X+Gwczz4wjSGpsga/ckPZNwnCXsiVgCt81c1H34lC1Vpmz8obfJw9x/CanvH3YEVjiA81bOnTdCrivqs6rJhoZoGdPegnXtFBnizz+Z3pK0wlXZWblTxkC2rE2l+QJub4gL3NG0eibb8Nu/WHWmi5b8aiKR0Jl+lw5JQQLJKeQEQcuDxUd8UatSzHBZl85M5fjgpP6H9HU1zfR3QdMlECaJUVDUsalqUpQdGHjaBSD+wTO3AKlX4NSgN3m0p7n1acpuNom9jR3D5jSaZGVH5syFUDf0DFGulTARHCsj4ONzDcWBmVAXCI6ZWwDPHWYTxkp4I7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDd7LnqCB6SjKkQl8LDrbIX0pR53pJruotKFMV61mwE=;
 b=TK1nThKx37RXphc78QXd+uHUxXqA8rTpdONAGdzytfx9gT5ji7HM8pjCeiZHByc5kvLovhwcvwU9E7PCyHApj0XKpd1yZsHwh43zFvBZRDRmEIWkvOcms9Hgw1rHXiJOXnEeLZVdlzOM5jkUW/NQ2nKO4DEPMG0IF42BSlog12YtViUNzAP9qQnmpELmWLsjDV8O/kDWSxFI+k5Pffz6eZlRHziMdoeaY/RgqwjM42cQIwNZOdvKj7yTvyp+y2+B+5KtKzCXUME9mvjAme6SouJh2sf35+2tLc4OeTA9qRU4jvt+dI5z0GlEqLxzjZItBR0sczIckfPjfQdfpUoH0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XDd7LnqCB6SjKkQl8LDrbIX0pR53pJruotKFMV61mwE=;
 b=1UradrZSkw+Lodp7Tsg5bawy9NJpSDpaZsx/NYmkO2yPX4AVkbzL1FGT11w1frnGJeDweI6nKgx/wXzHwtMeDcnjzjUMVP1rcGTW2vKXhMI24aovu6xgr7KLFrstMCLQKdRcpR0C/U19F/J1ltwcw4VL1iP2+jRq9DAjkHEvsQw=
Received: from BN9PR03CA0594.namprd03.prod.outlook.com (2603:10b6:408:10d::29)
 by CYYPR12MB9013.namprd12.prod.outlook.com (2603:10b6:930:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 07:37:10 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::6b) by BN9PR03CA0594.outlook.office365.com
 (2603:10b6:408:10d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:37:10 +0000
Received: from jatayu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 00:37:07 -0700
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH v2 2/2] MAINTAINERS: Update for the NTB AMD driver maintainer
Date: Thu, 18 Sep 2025 13:04:48 +0530
Message-ID: <20250918073448.1070104-3-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250918073448.1070104-1-Basavaraj.Natikar@amd.com>
References: <20250918073448.1070104-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|CYYPR12MB9013:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bfefbba-fdac-43c6-781f-08ddf6862d63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YyCJKKFNUFc4fx0SOcK2nz3ivnBabMSmZ1GjpqxvTdw+i3Zozg/zN7eAaAho?=
 =?us-ascii?Q?GT13D2MSWwHqtLjnAj8QhXfguS0Vr3dzODK4Z0f/178tA91ZIlgo941rxyXA?=
 =?us-ascii?Q?6PS7G1daFqILIPNP/9V7gvNYagCXOZC9GxO5rONklo7yJoZqV2AViwMqs3MH?=
 =?us-ascii?Q?cJ8LBwNdlyZy5j74L9EmVu7adogAHMqHVHoF7/Im2j3pGbtQL/QLcltWAh0X?=
 =?us-ascii?Q?k+LdpS/Ak7lIjyRnbBUCVZzIiKUfB5GwB1940WAFb4lA6MNz1AlBwc7gEQ/v?=
 =?us-ascii?Q?5WlWgMA1LcsCW7DbGJHy4ysYKga4MHo0hYuIKXWarXdZltOpF74+1sI2l/YO?=
 =?us-ascii?Q?tmV3KpDZRvOWtKz458IuA76XR1/B9Prn0luZsmf+lpx85EQBIvFypDNTJt4t?=
 =?us-ascii?Q?sfynMnyF8NcLTO8I7tjjZrvBD60oBQJOxv6IEFejGaHm33Pc0qd0bKTz1RvQ?=
 =?us-ascii?Q?WWEEnVzmu9T2BwwyFdHPzrAkIJtcbhaPx+ieEwdsNQvvjjuQoDJRXt5ZEtfK?=
 =?us-ascii?Q?3gnjFq5OLjepB596elfKCNT8FpGesMpmCVOp+ChhUAzsib9ZFnySd4LzA/0A?=
 =?us-ascii?Q?K5RJnyXIPe5iLBDChQHkLXiq7yj8xJ+oV+ct77EUPsmtj7kv7riTY4nLjD0f?=
 =?us-ascii?Q?0hCbUNfw4BT87EX1DfOpkmAM9JVGqDyMBYnJCvh8A/wj4cX/76bNYkIKNBjK?=
 =?us-ascii?Q?xp5jBf4Jg1N43lIjFJ5G86ams8Uso9eLZ73PMXF4+l2BRwReNKyahDFKZTBn?=
 =?us-ascii?Q?fHViU/KKQHX6f9KxxZeY0u+pOJPvFzrTTzPzV1dsgPdoEXi5M2cWrrTSCYWY?=
 =?us-ascii?Q?+fiE9YVqjXz+uP3A+Bza5RgPNJZZiFj0Xpvj3J2+/sq416ttPvDDsl5U33jC?=
 =?us-ascii?Q?k3kNYTcBZwHMfa5BlWZ6ZslTq1X50QhIdFIeJ+nfrWgVf5Tnn0SL3aFjcxBT?=
 =?us-ascii?Q?9ffHZhHGB6TmOGmUzDA9O6PxWHZ3eRb3+iQDlrmuUQ7hjk8/z6wFedD4pjBX?=
 =?us-ascii?Q?4yjPZgZF8eXNxfPGk9L63Kku4u+eCMAm9xyE//ItiS8nJqBLqB1QfPXqoWZs?=
 =?us-ascii?Q?jn/x9I77Ak37mQHNBfPmB4PVqZpcGlDr/6ONL2Hx+3Ip3EgAvjHhm6sbApXO?=
 =?us-ascii?Q?a2ZCx7s24/ljrymk/B0+x1fNNdU3q1Zc1eiUuzonuZuA5LUmrWh+jxSmLMEz?=
 =?us-ascii?Q?lK4i8YB6b64Zd85+DTCrWFgFifOAOkWTYFAmJbv6/s5ApsF1s6bmZGDSRJPX?=
 =?us-ascii?Q?tWqi55DVPZIDw5HX1oz2UBJ74ep525Ux6rJXyU+4QcLUWUvJMQENOsgBJWW3?=
 =?us-ascii?Q?vJ5U9soSq9tmcUHpUuK4BYZM1JmnkrFNaaCl0yp7H7FMj1Wni1EKf/rIRR+0?=
 =?us-ascii?Q?UZciJEY8RTBo8/5JvpRzyH11ESeR7KWzvbEygVB/TGaBNIJUx/RthhZ8ysVN?=
 =?us-ascii?Q?pz7LqgD0TsKpupm6EmA2BxZD3z/wjWVfYzbzcD8ossub2Ikoi97gyktEY3yu?=
 =?us-ascii?Q?7lKsyPEc8Ab58tqodZXcDXG7epm5XEWJ47Bw?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:37:10.3598
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bfefbba-fdac-43c6-781f-08ddf6862d63
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB9013

Adding myself to the maintainers list for the ntb_hw_amd driver.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6bbe4b4f8ec0..34c72616410a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18060,6 +18060,7 @@ F:	Documentation/core-api/symbol-namespaces.rst
 F:	scripts/nsdeps
 
 NTB AMD DRIVER
+M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	ntb@lists.linux.dev
 S:	Supported
-- 
2.25.1

