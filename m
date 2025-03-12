Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2043.outbound.protection.outlook.com [40.107.100.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB211F949
	for <ntb@lists.linux.dev>; Wed, 12 Mar 2025 14:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741789980; cv=fail; b=Xe+ZhV/o0bymXZ1grbZCbffhnQDqCzyK6tt1UhmvPtzo3vTgBA233sLu5G8BAC6OGCnc65x7C3T2LBGl3pw34wuPMJOgwuH6NpJoPNoY8M+Xjzi9fzxjA/yqoULWeB/nEsIkW/Q54PqORoxtUBY6+y/l8oN+H7ss8UECtccH0TU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741789980; c=relaxed/simple;
	bh=XR+/Edaw4jh+8jBbkdeQVuQz4CR8ash8h6klHFB0zJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cg4cbVClQRytdIqbTa4GFdpSVt5Sx7w2FUi1q1IX19frT9RDDDZXIQo2NVwgkpAWeAuF4KLHlZwPDFi7rDeChu54jXBdGqVanj7a7aP0tu2LxyXjWTMd9KE9i1bprh5ERSEsASO90lozPAe6Q1I844dFXMZqrACdec07rKAjKU8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=L7RaIHRR; arc=fail smtp.client-ip=40.107.100.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="L7RaIHRR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsqowNjneIYAPwLtrhEBqp7GK4X66wpEa2GMDzSqm8V5kUKkpAnmd2dCu1r4oEWv7WJauz0Xvu9Mi3TnJxUnrDgS0q1oj8qgGZdyI71+3rg2BYNsS+8UM9DjN7v9B+6j2YhL7oOBCIKaFotzIfaRQNL9E0z+ReBvw5LOxI2jZ0AQhuEhBbEJquWpABupC4ZoDJY1ol0/cI1Jv7xLsTOGyzA+e7fyFvOxbNCuZZYu3e4UXTi7bciIzw+L57xfDm52RXSTRuzOT1Zo0qAIaMPUlnXjr4LyW5K9NsFbLr+Dd8pkC+Vg0m8orhMqATNx86g0JRKXjxDM4i++TbtYPluYig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+8D0D15SoC99AmUmW9huTN0XWia1lWzi0VCUQWx4XY=;
 b=A38JvpXn03gMz49RPfVaUAD1UtvuMPu+Ou6hkD4C9BbySMRElwH3/qaQA61r6r/mghprR/lpdgdfC7tJvJiLYrlZTmSwaZl82M5MS6PppyA96jVHM+wvOrzyAZcN7JQNUIvvr8hODgbNoYIWiVAXH+j9koMb6RobhFGZYJu1DSuBHkPIB0RyecjWED4OPiPUxRna3bHfNY5girCSvQSFxy7jzQpDeC29Ft9ESyinER9LrdIsVq4DihYGa2nwlNm0VN9X4//ie3i2Elfc61IHMbEgLc16d1pbk77zRdsWJamBcqeidkR1yuCO3k/AYet/S02wqzB3/FpOR6d/eaaUXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p+8D0D15SoC99AmUmW9huTN0XWia1lWzi0VCUQWx4XY=;
 b=L7RaIHRRmdUxBkXFoT3SjsTT9oeBwpjOFqkH0j64cSK2nz0cMPj+1sZr5vrreLLXeMu75FblIWa2cil801VN75+QLE+YomrtCcS7K+gt486ft6KDEy1VlnnG3eqOpVi5QqN4hnU1uuk7a+ACC9XDSbRIuO75EiolFjk3BoEws+E=
Received: from MW4PR04CA0135.namprd04.prod.outlook.com (2603:10b6:303:84::20)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 14:32:52 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:303:84:cafe::27) by MW4PR04CA0135.outlook.office365.com
 (2603:10b6:303:84::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.25 via Frontend Transport; Wed,
 12 Mar 2025 14:32:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 14:32:51 +0000
Received: from jatayu.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 12 Mar
 2025 09:32:49 -0500
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Subject: [PATCH 2/2] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date: Wed, 12 Mar 2025 20:02:16 +0530
Message-ID: <20250312143216.311011-3-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 30b26330-1d73-416a-0cd1-08dd6172c544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vb2Ozjq/YEsjQ4YznLXPbKlt46QNV/gNC8DfMWMi4lM7ubHHBX1wkkvq164C?=
 =?us-ascii?Q?sGiTYtdjnFq1ox4iRJQZ/yxLS2Np5Op+CxQ+WgkYo6XvNHWY+1dSc3eK4tcM?=
 =?us-ascii?Q?h8WwWK+aUJj5HZ4iIq+g8c3kvANkAisJvUxbgNmbz3schBMegyYLIcnnx25f?=
 =?us-ascii?Q?ktnXIg8ZV3EybXrnfOuMB3COcWMBjIDLjDcXS7oFroh/6jZhTzHkR6pDY2ND?=
 =?us-ascii?Q?HanpQDfp9KjmN0T0+TaVRQ5CEaSNNpYRFD/5zrCIVkJrffbgT9Mx4JQn6X7W?=
 =?us-ascii?Q?AQRemewAAxHVMN5eDem7qiT+dXBihwL+QhSuILmJZ/BinhaaaQw2Km24FXP/?=
 =?us-ascii?Q?CsDeQlumXpWBIVO6nh/mKdCDI6L/wxpD4Hn2lHpyTcoiStsP7rRxApHCqLVk?=
 =?us-ascii?Q?rZ2X3+BtXirh1c3KBQgbHt9Klhyot+ZnurysXOaGs/06oaWbUoTkoUYw0lyL?=
 =?us-ascii?Q?SVq0U3I/fEictdgcuUd6r6szBz9ABSsrLj27Uckexx3RUFKzm3uLlJ1B/o2W?=
 =?us-ascii?Q?AQ94USBlWdAXBOmPyCm173aXAlYwsmMInGVN8sRdDcEBpZf78/NFmnaXsGZ1?=
 =?us-ascii?Q?vMp4M+TsXHm2G4Mp/27zHfB7efyCXYzu93laA1kgY7geqFkMiPfLouSLLhQz?=
 =?us-ascii?Q?ch/Iv2aUBAoLggWpoNRyPqAKstLEsn31aCIBKi5AvHgv1BFZRJQuIvlg0dqF?=
 =?us-ascii?Q?hTU5e1PuMucyGGXMfn/1EkUyCI59VGNw7CKKEJPRiVxembgJMCbX/IwphMOT?=
 =?us-ascii?Q?FFJHos+3qBEL9RjO1CcUWo1oXGY/5+YR1U81G389nGPxvDyNhPeunLjJC0ql?=
 =?us-ascii?Q?REMx67XdYOnVR7WMW/gLLPURDg3Kv1/GHFFFEbFHWjAWtcm1HyiTR4y/bFDk?=
 =?us-ascii?Q?ezGoWqTlfIr+FcPbjv7HNbXAoFXkeWrijs023OWy8bOH0KtTr0jSa44CNA7b?=
 =?us-ascii?Q?f53LUB/w4pj0FE7p7BxWs48EVQ/nfHe9TTqQDO6CzL33JvhlBcnPgtmo5h6f?=
 =?us-ascii?Q?SFEtVRivjRORknGzmE4BAGC8Pt1M0Q6sGic4FJ1DeCK8tG5iIyn/R1qyAanx?=
 =?us-ascii?Q?b0TWAR09AkuL/VN0K4MvkfzRAuMRtJA42o/wFx3P6MAEQNOTMIyOnr850Ym5?=
 =?us-ascii?Q?RVcFhV0Ehc8xAeRkDeta3SpKP45dxmTnUH2WUndBhBW1ZECUljfr5JkUJWgN?=
 =?us-ascii?Q?hBBHLYrJLgnt5SP2P8+tqnRkS5bhsfwvFwNSxPhNK8ij3Z4mc5etDXcEkz5b?=
 =?us-ascii?Q?rgima9WOSiCghwKk98gvv63oW9hTbI7enhA9mZv5B/8qHo7McqMcoI7hGfVD?=
 =?us-ascii?Q?xhDGrTGuNFN/XU53qnRcpvyk2sdOZkFwA09tNtzp89JzCAW946FcUTTXCKYH?=
 =?us-ascii?Q?laNYTgZEujTI5LI/G/OmFDXGjFaSy74GlnDy5gOBGeWVH7UVIvKLoRkytBhb?=
 =?us-ascii?Q?o3ukubfPXPp2SN/ylRG8s3HzWvGDN44hMHDd13ql5tDDzh/jOzee8g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 14:32:51.8809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b26330-1d73-416a-0cd1-08dd6172c544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

Add NTB support for new generation of processor.

Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index d687e8c2cc78..63ceed89b62e 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1318,6 +1318,7 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.25.1

