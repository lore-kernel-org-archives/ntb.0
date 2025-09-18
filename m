Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011015.outbound.protection.outlook.com [40.93.194.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241B2E7186
	for <ntb@lists.linux.dev>; Thu, 18 Sep 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758181037; cv=fail; b=LEoRD0PxYHUGQczH3Kw17TVfQN1dvjatis554SUwJgm480ve8SSJKD2f7aJYvq5w9qAQpXa5mmEnmKKJYY3Cw2mpzvRPoktxvJkGlbGVoDlNx6883i5D6hLnCVA03K+WqBAdL/HExRDfDWxybrrcZExBB8W2GJD1eeTVT4hDGbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758181037; c=relaxed/simple;
	bh=A7Xz50JZmk+oDT90Pfvcfz2QnmZHdbKesYabgKms5Vc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OkTCBcEZmZJmL5h154Ii2XkHM2znoIe59p2P28F2jdMVAkGUuExx2U2jjiVDm18acuvNs59J1+Z11LloXqM7FsGtzesut2DxKemnCxSGyhzvhAwPLltTfuRkBBWseWZjDKTbZOmX1zpOZYq9GNdcz9k7If4/cAVsAzrIen0EoJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V76Pa5bR; arc=fail smtp.client-ip=40.93.194.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V76Pa5bR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u7YUaXHEm8ueB7tmMkWmC8FJpGR0tp1uc09oAxkU9aPO4qRxVLkrvKlOGFvKztisAdrsPy0jBlui8hjgMBH76tmHyoITqSnuDA80gCOtqNr4y9ToW/e6kyOSj1FVhA5SwXOvCuHKCvIWGOOit4Xn1bBPBNzKIkbOeAmoixJUtXKf3V7nOYTbT5KSvPWP3KVtu1HFi2/C48IyiMepdzVVoowj01E5QIPBHJb2N7rzWg0/HQ/Lfe53rYQTu5t0Jy+SbaLxKhoLUlLn/DWxAUbJmdh6qciyywnl+gM209EbEhnfPaqhOQ1NPpfIKKem9exFyQP+7SRJ0NrPz58hgk/XEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAAjw56pCQbQdUviz7/Rw3neMnRB9k37KLjmyEO7KQY=;
 b=UdDI/BsfZKyLdvdU1DunkVn+6JYG8Uwe2KbNvAu0EX1qkHNNxBlMAmSda3xaBltadlRgP3WtTsnJrvzbsBVqPQehvu1zuzgaazMxYc91jLuhFVNMCi3NnUO1g6f+0nGU7a/CdK4+qZx8vUvWvqBsP0PJE56Pt8MkzCI981xhNKNMZg48QWfincw14QsnAeqokinaxL6uorK7zBvM5Zw3mTVVR93kAipomNuj4hN4dnVvnIfg/MpxaZCvfVeIPoldxf93dRIfCFAVdy+iGGfvysWThlZkz1jsoK1BEk/y15ZqoJdQf3Ua5p7cO7DVxnO3YuSYkYY1fHTkgegHSi0nOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kudzu.us smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAAjw56pCQbQdUviz7/Rw3neMnRB9k37KLjmyEO7KQY=;
 b=V76Pa5bRYcbmTPBJuWKOsvVYZTHTeE7p93KeiAaoycGl/bRn4p9hSWISR8Jm7bpuEXwa9AMgnr2hVRbQDlAfzeBwKcaNqoJ/wjM5kns4Y/m9A/OidVSiYU4gB1TZ5aBEpWgqAEga3Di5PQaqHA9mdOOpk5NoxP/fA9/rSVxFr5U=
Received: from BLAPR03CA0167.namprd03.prod.outlook.com (2603:10b6:208:32f::23)
 by DS2PR12MB9638.namprd12.prod.outlook.com (2603:10b6:8:27b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.14; Thu, 18 Sep
 2025 07:37:09 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:208:32f:cafe::45) by BLAPR03CA0167.outlook.office365.com
 (2603:10b6:208:32f::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 07:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:37:09 +0000
Received: from jatayu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 00:37:05 -0700
From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <jdmason@kudzu.us>, <dave.jiang@intel.com>,
	<allenbh@gmail.com>, <ntb@lists.linux.dev>
CC: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Sanath S <Sanath.S@amd.com>
Subject: [PATCH v2 1/2] ntb_hw_amd: Update amd_ntb_get_link_status to support latest generation secondary topology
Date: Thu, 18 Sep 2025 13:04:47 +0530
Message-ID: <20250918073448.1070104-2-Basavaraj.Natikar@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS2PR12MB9638:EE_
X-MS-Office365-Filtering-Correlation-Id: da72c878-2e10-4149-7679-08ddf6862c9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Sy9kp5dA71sfjrPHJUZNmj5uX0t1WuwpfOA8AQ+YGMpQNd/7lZPj3onLpXEc?=
 =?us-ascii?Q?glxuHmTun1kpK8y8ywiawVaeBVem2lYkoXzKBBzxkyPS2rOQeNNhLd/DEX21?=
 =?us-ascii?Q?BNEr0CcwbjGxe5qmferj5+ZFyZ0+/ljVFVg7lfQ/n+5FujUaC65FifY8FDlJ?=
 =?us-ascii?Q?/RmBnWYez0lChRdfbhLV4P1d0RPUgJB7gyv9iNW6fWDTkEh6vrT21gs+6+g6?=
 =?us-ascii?Q?+hpOuBJq7VgGQuppAmnlFgeeVOSl51Uof5OkTUMB7wRWRF3oFKIHbcgK2wKa?=
 =?us-ascii?Q?qTBQvGryLIijgOJCj9OgJfzTf1tddT8ic51doHv+sXdILCROF8erb/y80tgA?=
 =?us-ascii?Q?5Z8Iw2E0otM5vOyQIkfNsQvvODuNiPQmsaaFNbx4et2R04aPqQ0qWJGZwUYm?=
 =?us-ascii?Q?pkzZhVq6XclA+LofA8N0xniB51yqhh0+lhtjw2uHR770gAj6XEpBp64oXRqY?=
 =?us-ascii?Q?b9YsVLdzUzPxnOfR12Yk2euPGFuZF6r5C0q8rFKLQfi1sp/9FqJpPE0brcI8?=
 =?us-ascii?Q?gfySA1NEIi6+Jz8pioF71uIC3d09SxrZrEVmWzE7eVqXcmtEmP2i7ft5n0Zx?=
 =?us-ascii?Q?x/bVRuxCVCcZv9IzLpyvKwL6jo6GLoFSXm2ssKpxw0AaJtea2yOdGJeKkutR?=
 =?us-ascii?Q?4bgRdnpiFMcOiArFnxh5Ubh5z2b2em0Cfv4kywPEjf+kTfPUuOBFS1J4RZci?=
 =?us-ascii?Q?tFuDbcwq9bqChDlTV8a6b4f5qN648jCZmWd9aTDuKH26g/USE5Vy79WmNDLt?=
 =?us-ascii?Q?NQBSRdQkDCsAA5H9yoqGnuKBPGHV2mL/CLlyl6Dh65fV0uancqEryhM6Py9W?=
 =?us-ascii?Q?pTECJcvFJgJ3L2UXkxpDW7g1p4X+5x9J8QhM7613NAU5zvnnHn0vp3tciApw?=
 =?us-ascii?Q?BCUUQnAQaZvl6APuM8tY4lfk/mIwhStJSmu2U2rxAz71IruAkv/tSSItr8Ja?=
 =?us-ascii?Q?XpJ+ZWPr2G4yw2zvkbsQGXvLbobn9IvDoRUz/3yumCAuNXew0SqtVnhn2JSD?=
 =?us-ascii?Q?GpRJy+XEgM3rKdAnMwPXgCvO6THrXYfXcj5cR4wpvaJg+vGpW8rHNBokfyp7?=
 =?us-ascii?Q?QCZHcISvqXDbjfRQq8aLXe551lG4pGFVPmeo285v3aDVuiPOYEOVA8U3DgZt?=
 =?us-ascii?Q?VWvJ7J0Mqx5C685FbwdLVWsc4YArzTO6DcG9QWFcB5OAYU/M0CpwkrXZwTlI?=
 =?us-ascii?Q?32iOZdSCoQn0zA5b4uMI4HMoydhXbzeSl+t/UKJV8TPi9JKY67iRiO+XJCl0?=
 =?us-ascii?Q?GX8o6J2bQ/sCbFc0dFufZvUIgAPWQDP7DFkcs8V7cefVBp5J1txmTMFdoAGl?=
 =?us-ascii?Q?sYjCfNBNx8CcRl573rH9dtXtcTcNKEPVUq1mv7LJJYyGS02bwRcek0/4lhPN?=
 =?us-ascii?Q?1nsrXKEC9m86MCZWqfJrbhOuRfNPUcUDIb1Mn8g6gQ8oVO2Qfv1EDlbVf0ue?=
 =?us-ascii?Q?BlqZQ+zBdns6F1xVJHpNhC+2SoXc8Za6wv9OonEhG80i9D+CRmScWv0FZxif?=
 =?us-ascii?Q?gOKkYJd3envFcA7MvrLU5O7+evtB382KmSnZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:37:09.0515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da72c878-2e10-4149-7679-08ddf6862c9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9638

In the NTB secondary topology configuration of the latest generation,
the device behaves like an endpoint. Hence, add endpoint support and
update amd_ntb_get_link_status to accommodate endpoint devices.

Co-developed-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Sanath S <Sanath.S@amd.com>
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 18 +++++++++++++++++-
 drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 63ceed89b62e..1a163596ddf5 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -197,13 +197,22 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 
 static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
 {
-	struct pci_dev *pdev = NULL;
+	struct pci_dev *pdev = ndev->ntb.pdev;
 	struct pci_dev *pci_swds = NULL;
 	struct pci_dev *pci_swus = NULL;
 	u32 stat;
 	int rc;
 
 	if (ndev->ntb.topo == NTB_TOPO_SEC) {
+		if (ndev->dev_data->is_endpoint) {
+			rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+			if (rc)
+				return rc;
+
+			ndev->lnk_sta = stat;
+			return 0;
+		}
+
 		/* Locate the pointer to Downstream Switch for this device */
 		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
 		if (pci_swds) {
@@ -1311,6 +1320,11 @@ static const struct ntb_dev_data dev_data[] = {
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
@@ -1319,6 +1333,8 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
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

