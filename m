Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2064.outbound.protection.outlook.com [40.107.223.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F40A199FB2
	for <ntb@lists.linux.dev>; Fri, 12 Sep 2025 10:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757672803; cv=fail; b=D/QqrAzCzRBG2vqrexgeTa5ooBQ+GQDH597L1S4gL9VAFldiH6NrdLrIMLfVKE+6PaYRHmut8nb8clzLcVonmIgGangPKQwD8QZdJODxG15sBxQyCBz6Rb85HX9r+T73MTe2dqkt9eYr11n2sHozsq96wbWDwHPdyTBZwKK8mc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757672803; c=relaxed/simple;
	bh=A3cm7z+bYvM4rrZrcqmzZ9e4DUP03EVnjJ/4C1LJ2MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MTNmazmx3+EocqaliGWzuvvTt1BcuNrgU8plad2uqjF9hSEuX10nOyvJ9OoNFy3NR9POA+y2kSng/HasOQg597iPEXj9hIqnBzD1vj9ipPxNFFGkLmAXIs8N8Eb9iP4epVM/efJGV7DsjYw/c6c+13oCnsaCtUYa6uAXiVNhcLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wjl1B/CJ; arc=fail smtp.client-ip=40.107.223.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wjl1B/CJ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S6G5QMhTGesh2hSBH3vua3jqto5O7W7VJjDx/EKoIbinNTSoYT+8yHIM1pS8Gygl87phN0L/tSdtpqOKPkHjwKAttGvngBx5DyU625CPnpn8fca5qO3/YDZ8jbYCUdjl51MdN9xYO5YA92X80t/+fULJNl4J1DsD1SvAePQiDBGCJw2QPSsDlXKgIEN8Gbqvzj/KGIA2E0cmaC9ZjzDl78eR13LaB/8gSW+7FLiEL3YCW8+5oBMPydzmEq9+KEUNIFH5/78sEPwSKXk5g7U09Lw3Dxiei1pa0hzc6opted4SVQm6MkDmO48AWiZ7xsFbX1aNXp+1Fy9Cq6l3Qpv+hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU1VK7Edb45loeXf4mZQoNuDpaftpzDlFuIU4FBtCdc=;
 b=Hah/JAttsd/ylVPBfHmtdh5x92HRe1XbM2slV1CILL6/hUwpj1IIbn0qM+B6Oa1vxSYhSj/itisMdGXMUTkrcWg7Nsqapj6js3BZTbB1BIgWhsqBJwBRk6g5kK96c5Y/r8WGPUNBAFR24PhEQiT8nLa2Xi+ZwjbM3GvEc+deVqQfPwREyEAp+hJwI9HaTvAg+LM6ZbyrdgcxL55oAW1GLxX1SVHGlO9aM+nKAcTqLrn7V4WY/bDoOP/51jpXs6CCeibilfgxVK8DaWl1LlCKi8iQ9sJqfkSeoH5dec6MgYC3a2ZN2uBPz4j2rxM9IQyO/vpUYEtsHnwkfU8f7uRlUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU1VK7Edb45loeXf4mZQoNuDpaftpzDlFuIU4FBtCdc=;
 b=Wjl1B/CJfwYexCRtSyqKcxl/Pgg7lL71GhkMZO7IYAx7vqk+dxYZHtw4qNYyn7yV49NWax3lqHzKBUJagghbmnsW9qw854r91n47Vyw2kCgs7w9aOW70D6E0OoTeiL9+WG6S5BGyxHN4DiLsaNHgkjEr99OYI9ApG/n7UH90eoQ=
Received: from SJ0PR13CA0131.namprd13.prod.outlook.com (2603:10b6:a03:2c6::16)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 10:26:38 +0000
Received: from CO1PEPF000075EF.namprd03.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::f8) by SJ0PR13CA0131.outlook.office365.com
 (2603:10b6:a03:2c6::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.7 via Frontend Transport; Fri,
 12 Sep 2025 10:26:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EF.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Fri, 12 Sep 2025 10:26:38 +0000
Received: from jatayu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 12 Sep
 2025 03:26:32 -0700
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Sanath S <Sanath.S@amd.com>
Subject: [PATCH 1/2] ntb_hw_amd: Update amd_ntb_get_link_status to support latest generation secondary topology
Date: Fri, 12 Sep 2025 15:56:03 +0530
Message-ID: <20250912102604.765444-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EF:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 84bfb285-22df-4781-d570-08ddf1e6db7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JPBZfVpQWxVsdKbvuKYyeoVyLe3WeHraUZwTI4FaqhfHgEAhyPMSL6Ud1YzV?=
 =?us-ascii?Q?otnfE96OXEXzfVKI1udzbPW+9KFGt6i870kRVbQ1ZdADLypB/lzELIrsGP4w?=
 =?us-ascii?Q?h1AbMP1YWzf/qw24dqY98l2Ve5kxd4Wz+LsgroKe3sUafUNxrmoADxUKDpj7?=
 =?us-ascii?Q?J4Cnn3CHmQlYc/Ofwu83ADru+omwr3h+1JSpYNN/kPxHPtG7KxIbnQU6ZWZL?=
 =?us-ascii?Q?TfZiz9ywJ4PsfZFqeH+stBEZKWYB1UJIkVAeRFsL9AvUFFFoiPEtRfthPd/f?=
 =?us-ascii?Q?NkGYvP7G1JGQ6ncLyBpx17ARBUJ15bDmMgpxyE4IzQrziKbUAoUUq6EMG9Xq?=
 =?us-ascii?Q?Jfjc86yr0GODA7024I+ZR/Dy4ZzIxF/fMP9cRJjqud+DReEhh5RVo9HZ6BfA?=
 =?us-ascii?Q?HLT3NKr1khTNkHnuTTzz+iRc0+TeiNLWeRM3FpXfZ2pGEzWcIZam8ouyWkt+?=
 =?us-ascii?Q?NxoRSaHcc+dDEqHFxaBfTdF0L35X0fSdGC6vcMnN+H44z4GEr0sjxyc1D0r5?=
 =?us-ascii?Q?wgss6aLb/3y2wq8jiMTR6UXzQqj62Bg5IAEHfnV3LNw8gkj5ndrEW7BF7juk?=
 =?us-ascii?Q?6+ThSt/A1C61SzzwFUr0HRNRVxHk+ZTP1auSHYoz6K0n8WeCQPGGztOtRdmZ?=
 =?us-ascii?Q?1uPX1CY3nuBjQ4jPirTXL44CwkxIa0wF94qJeBlF6/eDApblLZeHo6AAa/VU?=
 =?us-ascii?Q?nRmcLJIzCWShARlT29CQQ5C1wWQa8XKRJgUdjNE9u8RpU1QGxwTaO5onM3g1?=
 =?us-ascii?Q?5Mu6CTA+Ww1eqpzH7M1pciWvb+oi/dv17Rqt+Lb9mz5GycEle4GxqkhOXMae?=
 =?us-ascii?Q?L5kes3sy+Fc4yNDk6Sp1pgymXAEqbBM3+KcIqcXDBWIDMN06r66ohrx51PMB?=
 =?us-ascii?Q?rkIGcxhuw6/8uOv7jg9P1wohSGyRi2gYqW9zqfSgwL/w5XXgvV1JIMXXBoii?=
 =?us-ascii?Q?qkJIzoCxrtD8+OCjfC8ZEZhFBAUkuinEKyY1Ra4F3cm8mDCIvF+54Kd49FAB?=
 =?us-ascii?Q?d+DM5RGKPtrpflswzp+gdhKrfC6rjivB2PYuRoovGjBxclDrN0mzhSUDuHjc?=
 =?us-ascii?Q?MXW3fQJx3WjI297vL2QSKGPtwmbgZPNPjMx7ZS7j0dXPeulxsBqv2O/+0TFs?=
 =?us-ascii?Q?0rD+egaURf7o11jQwPpfzUAOtQUBgf5OWOB4Y6N0YxxpDNTp3AcMuOlbYORF?=
 =?us-ascii?Q?DrOw1iAYWLVXQHQ4+hIaLGNNXANB7fnbeSxj7WseEGWZikXQnI3r8/TCiML+?=
 =?us-ascii?Q?nR9ROYOQAGHyhzOTdrUqG84tC14RN1OGvo7DhdWtR0JQpmlSCAato5/LuV5K?=
 =?us-ascii?Q?38RXJAV2O1umSzhao2Tc7I98ZCerz5PjbwllwOOn7L9cqBS3DYvndN9dqizi?=
 =?us-ascii?Q?unDOtVsF8/CYxLhAEj7L7iVUmnwwo+YWt0wPwUqViuaEgtkqjB4V3qt68PXI?=
 =?us-ascii?Q?9Sypagdbe/KBgT5CJm44alqRSR4IjEWgar9K2txjqzxKEqevEJciVRwANOxu?=
 =?us-ascii?Q?08hB7AOCnsjAw8efunl8kaFxiFFfTvSzcCG4?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 10:26:38.2509
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 84bfb285-22df-4781-d570-08ddf1e6db7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000075EF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736

In the NTB secondary topology configuration of the latest generation,
the device behaves like an endpoint. Hence, add endpoint support and
update amd_ntb_get_link_status to accommodate endpoint devices.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 45 +++++++++++++++++++++------------
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 2 files changed, 30 insertions(+), 16 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 63ceed89b62e..39dfe089bf59 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -197,32 +197,38 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 
 static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = NULL;
+	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct pci_dev *pci_swds = NULL;
 	struct pci_dev *pci_swus = NULL;
 	u32 stat;
 	int rc;
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC) {
-		/* Locate the pointer to Downstream Switch for this device */
-		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
-		if (pci_swds) {
-			/*
-			 * Locate the pointer to Upstream Switch for
-			 * the Downstream Switch.
-			 */
-			pci_swus = pci_upstream_bridge(pci_swds);
-			if (pci_swus) {
-				rc = pcie_capability_read_dword(pci_swus,
-								PCI_EXP_LNKCTL,
-								&stat);
-				if (rc)
+		if (ndev->dev_data->is_endpoint) {
+			rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+			if (rc)
+				return 0;
+		} else {
+			/* Locate the pointer to Downstream Switch for this device */
+			pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
+			if (pci_swds) {
+				/*
+				 * Locate the pointer to Upstream Switch for
+				 * the Downstream Switch.
+				 */
+				pci_swus = pci_upstream_bridge(pci_swds);
+				if (pci_swus) {
+					rc = pcie_capability_read_dword(pci_swus,
+									PCI_EXP_LNKCTL,
+									&stat);
+					if (rc)
+						return 0;
+				} else {
 					return 0;
+				}
 			} else {
 				return 0;
 			}
-		} else {
-			return 0;
 		}
 	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {
 		/*
@@ -1311,6 +1317,11 @@ static const struct ntb_dev_data dev_data[] = {
 		.mw_count = 2,
 		.mw_idx = 2,
 	},
+	{ /* for device 0x17d7 */
+		.mw_count = 2,
+		.mw_idx = 2,
+		.is_endpoint = true,
+	},
 };
 
 static const struct pci_device_id amd_ntb_pci_tbl[] = {
@@ -1319,6 +1330,8 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x17d4), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x17d7), (kernel_ulong_t)&dev_data[2] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 5f337b1572a0..e8c3165fa38b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -168,6 +168,7 @@ enum {
 struct ntb_dev_data {
 	const unsigned char mw_count;
 	const unsigned int mw_idx;
+	const bool is_endpoint;
 };
 
 struct amd_ntb_dev;
-- 
2.25.1

