Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2079.outbound.protection.outlook.com [40.107.92.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A758635E
	for <ntb@lists.linux.dev>; Wed, 12 Mar 2025 14:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789981; cv=fail; b=lDRsmH3zyisZzPNdlHLmDF/PdSoTYm2grbWGGO6ptuLiLwmmOWL2D2i5F4C8o01zS+kQkJKYNaFDxikYxq83oHaqK5t/AEg35dCdRXoQXdU+mSKTmP7zJ0/ln67taJ9lhxRc0yZkR7xcZ9iPktLgRyhaKF9KLHk1u0dyGiuUBOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789981; c=relaxed/simple;
	bh=mUPVsRv9mLpircDE5MKnTmB+AU/RS8sZqEG6GQRAmVI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=afJK8LKzI/xOi1r8jI+OJcY+qfvaJ4naSu+/NLrtpwOIOJqugPTu7/D5yavtClV89CicDtp96sNYLepIF6281WLwB0ukiOAEQi2nzUZTLAobpyDtuYShcUMhHMvAYXHyE3hU3eTYaIlWk4IDuqqTP6zUd0PTZuvak1q6jPPEkQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=o2CqykK5; arc=fail smtp.client-ip=40.107.92.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="o2CqykK5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n5PuiOkvROAHSGc9fmlTAI/kS23aphZKHNGF47+m3ACKxdyHAAFETVPoy3+5SuZb6FAu70PEyZ/T4oT7Tj7dfj5Uml0S5ufku5dAUW11ykh5aDJZ7rdixpljUc2wZw84+ekNUU40ZUT6lhq/D94oj7qS8uZ38bsXDWrUP7FQwDDtce1sX0OU9qTvvi0EwUX4F2gF4CBzv5PQJMU+w+aUoPsjohdqX7TBEwgGHrHy0EGBWs+eUlN2D6ZzX/BYmpPEa+a0K6dg8KQXMgt+4MY24D/GY7XbBD5NGZqEn2Te99HRSVbndwMoOXUPvpvdrTR/7WRBQGHaNr8IlqdhVrM5Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojqPzoLNHnuiCDtHvb4SYhL5iAPYeAUWuGvF3f53t4U=;
 b=VWGECT8wkD0PBx4DzSvpbhRBhHjjFF1b2vJlDkh7AT+nn9DkpDlPolhlPN7efjPKnVhPkz8uzaus5Fkmx0w3/1tPSQL4MOj9Q/+TPUfVTMTMhy2vyXlpCk1cydiKDpgoJMR1aWm8NxdAO/VhuGjUKXmMsP2IdAjJ8ssjG+POsmIaT9ifzPY4fH9gXAOochpKw9R2l/peiPveMcwYO6UywRIaNz5+6ShZbtZrGUDS3AnUTF8GodH+yRSfcAXsHl1+NYoaP8Dq/yHHgmRM6S01BlXXkW0veVCUVlgZ0P7ifi4vlNf0zk3NJjN6F6Jbrr8CEGjV4ubFJTmfRnGGNNDpqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojqPzoLNHnuiCDtHvb4SYhL5iAPYeAUWuGvF3f53t4U=;
 b=o2CqykK5u7CxaXLzlOPocUYLACmRMnStcDvajB8OyJBvfNGF2GkQO9LQ2u1+7P6PXCOm3+tEUpAnzNVqV/wlWXSz0/hXAuU7rT6JVO4QltzC4kCfxqvz6WwnMzRBjHS/BCVW6nshDi/fR0qrtNn5ci5jVDwbyLGuf3NQyDWpZvg=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by MN0PR12MB6151.namprd12.prod.outlook.com (2603:10b6:208:3c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:32:51 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::52) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 12 Mar 2025 14:32:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 14:32:50 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 09:32:47 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 1/2] MAINTAINERS: Change in NTB AMD DRIVER maintainer
Date: Wed, 12 Mar 2025 20:02:15 +0530
Message-ID: <20250312143216.311011-2-Basavaraj.Natikar@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250312143216.311011-1-Basavaraj.Natikar@amd.com>
References: <20250312143216.311011-1-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|MN0PR12MB6151:EE_
X-MS-Office365-Filtering-Correlation-Id: 87243002-e746-479d-9edd-08dd6172c493
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/oK02lm9mbabRTr8R7s7OkG77aH5eM73+43tcIxqIccMPP6XwasfNLrnjyoF?=
 =?us-ascii?Q?vK3SVQI3t4za608u/FD2TevDl2aSACs4xyl0DMwuUo+AHfFzyEc6TTtd8xAB?=
 =?us-ascii?Q?WTz4tKFJThPjOOSgaXRXlrkugtMuUL9NJRYSFgE/iHm/pYP9uGkzcTc8Cgwf?=
 =?us-ascii?Q?gB/KzMp7BFhG2NuHH6sbupuqUIkMnxzfXU8taAXsOTJ6sTwTgDwu6XKw06sv?=
 =?us-ascii?Q?PW0mthP3biXpNNAmCiqooY6roO4GTQteDJaLaa3iKpuCxLgeJPjDSBsnfska?=
 =?us-ascii?Q?8o+Rz+/HQd/P5ziEWDapahA7JW8wNwvYOY2THcK1+WiYF5C0oU3CNekKrDYe?=
 =?us-ascii?Q?velQueqGyd9Mu6S2zZPsUv8ieKhxgHBSbcrus7dy/FllM4mwNR0a5/XJ8xg4?=
 =?us-ascii?Q?7JHVjw4aKqKPls2vgpthjb95QpXWgUhH0hJ+aUKjEMYBofgHcYATSCE/rlHX?=
 =?us-ascii?Q?7ULMKZC1fhiXG+zy9ovyzwbHrXuD73r1CtR3ZfL6Rkqxggr0CiV0Po7qrqvw?=
 =?us-ascii?Q?hfSj1wqFmDk4TQiUqhKX43jiKCCAALukf3Oj7mVIE3RtZ8SmaEjxpH3AII4D?=
 =?us-ascii?Q?RkIL7ScyFqR6OsYNczucMN2nWbJBJzHSXiho/tqloxLyS3W0y4gGDuG5yU2s?=
 =?us-ascii?Q?X6uPbHj9CNWEf7/yZenJMoCTer4OSgrqQwVljVsT+Yfys8zaEl4KayRqleiT?=
 =?us-ascii?Q?KyahmvWPDaoO5bkmkNwcJahwHiftX8S95WIWgPCef3frfeDLgzEWoJaZC8c5?=
 =?us-ascii?Q?7yKkNKOak9dgJQ4eeea8QHf6pXKt0upNn1aC7uPs+zeAitncs7vKdxlyt4RD?=
 =?us-ascii?Q?/qgXJ79+2Qa637B480o80J/yEXqF1XfyvRPMc5xZpp+XVDZv01eECEYMoxeh?=
 =?us-ascii?Q?fScqkcdfGB+f5UQzWiNZ2pFospXSmG30GBaD31X5RTh0EdP75r/cD2+FQ4hp?=
 =?us-ascii?Q?4EZ+QTQF6EIFhOPv7keQgoi7UIYoLFe6DP2DcZifAsyH1FE9awmD/2LQWJq7?=
 =?us-ascii?Q?FBSlVz6ddoypi11ZV0okD4PKbdYfipm08iqKGt5xMCbcXGcRjimve2i8mRHj?=
 =?us-ascii?Q?6f1vDQrPilOdJd7Gux3i5NUGar9JQLQ5UCryCgrqBvYshRVXoHsW4bZ4KS6/?=
 =?us-ascii?Q?dsyHwOexuiBM6BRomhoscaq0YbRsCzxW3mebUvJvnjDFSyaqq9yliTj/Yueo?=
 =?us-ascii?Q?JWbvO28apYn3lymrhKNvHPbYhDLk0kYPjzkEfbulhZfpe8ylirmDMzP0a/H2?=
 =?us-ascii?Q?wino+/GYyR17aUhkJMjr0tg+R5eTeSlIG8SvT6bv4sBtZ/gs80zDMOwWgoxi?=
 =?us-ascii?Q?9Vs++NFlQbFKi94F1AFw/VW6Aa3/bwv3nbP39kEASxAw90l/nkO7QjZt9lhB?=
 =?us-ascii?Q?4QUzdijBi/sxFZaf+WI3uKcPIcSYEQ7JiyFaMksuaa5+B1GwJoXhzYRKoujv?=
 =?us-ascii?Q?kLccyPTs3jepWEgcsGRXAsdcwWQnJL9D6nMr9v1q2OEhCKuD+a9g+hG3pcXZ?=
 =?us-ascii?Q?n7KYUjxUU2+Qj04=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:32:50.7090
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87243002-e746-479d-9edd-08dd6172c493
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6151

As Sanjay R. Mehta is not in AMD, I request that I be added as the
maintainer of the AMD NTB driver.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ed7aa6867674..180f6c0a4cb7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16872,7 +16872,7 @@ F:	Documentation/core-api/symbol-namespaces.rst
 F:	scripts/nsdeps
 
 NTB AMD DRIVER
-M:	Sanjay R Mehta <sanju.mehta@amd.com>
+M:	Basavaraj Natikar <Basavaraj.Natikar@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
 L:	ntb@lists.linux.dev
 S:	Supported
-- 
2.25.1

