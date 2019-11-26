Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (mail-eopbgr720046.outbound.protection.outlook.com. [40.107.72.46])
        by gmr-mx.google.com with ESMTPS id m11si63086pjb.0.2019.11.26.07.02.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 07:02:30 -0800 (PST)
From: Sanjay R Mehta <Sanju.Mehta@amd.com>
Subject: [PATCH] NTB: Fix access to link status and control register
Date: Tue, 26 Nov 2019 09:01:16 -0600
Message-Id: <1574780476-4423-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain
Return-Path: Sanju.Mehta@amd.com
MIME-Version: 1.0
To: Shyam-sundar.S-k@amd.com, linjiasen@hygon.cn, arindam.nath@amd.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

From: Sanjay R Mehta <sanju.mehta@amd.com>

The design of AMD NTB implementation is such that
the NTB secondary endpoint is behind a combination
of Upstream Switch (SWUS) and a Downstream Switch
(SWDS). The link training happens on the SWUS and
not on the secondary endpoint. So to correctly
return the link status on the NTB secondary, we
need to read the link status of the SWUS.

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 45 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index ae91105..758f748 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -842,6 +842,9 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 static int amd_poll_link(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->peer_mmio;
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pci_swds = NULL;
+	struct pci_dev *pci_swus = NULL;
 	u32 reg, stat;
 	int rc;
 
@@ -855,10 +858,44 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	rc = pcie_capability_read_dword(ndev->ntb.pdev,
-				   PCI_EXP_LNKCTL, &stat);
-	if (rc)
-		return 0;
+	if (ndev->ntb.topo == NTB_TOPO_SEC) {
+		/*
+		 * Locate the pointer to Downstream Switch for
+		 * this device
+		 */
+		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
+		if (pci_swds) {
+			/*
+			 * Locate the pointer to Upstream Switch for
+			 * this device
+			 */
+			pci_swus = pci_upstream_bridge(pci_swds);
+			if (pci_swus) {
+				/*
+				 * Read the PCIe Link Control and
+				 * Status register
+				 */
+				rc = pcie_capability_read_dword(pci_swus,
+						PCI_EXP_LNKCTL, &stat);
+				if (rc)
+					return 0;
+			} else {
+				return 0;
+			}
+		} else {
+			return 0;
+		}
+	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {
+		/*
+		 * For NTB primary, we simply read the Link Status and control
+		 * register of the NTB device itself.
+		 */
+		pdev = ndev->ntb.pdev;
+		rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
+		if (rc)
+			return 0;
+	}
+
 	ndev->lnk_sta = stat;
 
 	return 1;
-- 
2.7.4

