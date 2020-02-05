Return-Path: <anath.amd@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com. [2607:f8b0:4864:20::543])
        by gmr-mx.google.com with ESMTPS id z20si8186ill.5.2020.02.05.07.55.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:55:01 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w21so1155489pgl.9
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:55:01 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 04/15] NTB: define a new function to get link status
Date: Wed,  5 Feb 2020 21:24:21 +0530
Message-Id: <d775a8653d3f4550adfdbfaaf03c269ad2896273.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
In-Reply-To: <cover.1580914232.git.arindam.nath@amd.com>
References: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Since getting the status of link is a logically separate
operation, we simply create a new function which will
store the link status to be used later.

Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 93 ++++++++++++++++++---------------
 1 file changed, 50 insertions(+), 43 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 111f33ff2bd7..f50537e0917b 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -195,6 +195,54 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	return 0;
 }
 
+static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
+{
+	struct pci_dev *pdev = NULL;
+	struct pci_dev *pci_swds = NULL;
+	struct pci_dev *pci_swus = NULL;
+	u32 stat;
+	int rc;
+
+	if (ndev->ntb.topo == NTB_TOPO_SEC) {
+		/* Locate the pointer to Downstream Switch for this device */
+		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
+		if (pci_swds) {
+			/*
+			 * Locate the pointer to Upstream Switch for
+			 * the Downstream Switch.
+			 */
+			pci_swus = pci_upstream_bridge(pci_swds);
+			if (pci_swus) {
+				rc = pcie_capability_read_dword(pci_swus,
+								PCI_EXP_LNKCTL,
+								&stat);
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
+	} else {
+		/* Catch all for everything else */
+		return 0;
+	}
+
+	ndev->lnk_sta = stat;
+
+	return 1;
+}
+
 static int amd_link_is_up(struct amd_ntb_dev *ndev)
 {
 	if (!ndev->peer_sta)
@@ -845,11 +893,7 @@ static inline void ndev_init_struct(struct amd_ntb_dev *ndev,
 static int amd_poll_link(struct amd_ntb_dev *ndev)
 {
 	void __iomem *mmio = ndev->peer_mmio;
-	struct pci_dev *pdev = NULL;
-	struct pci_dev *pci_swds = NULL;
-	struct pci_dev *pci_swus = NULL;
-	u32 reg, stat;
-	int rc;
+	u32 reg;
 
 	reg = readl(mmio + AMD_SIDEINFO_OFFSET);
 	reg &= NTB_LIN_STA_ACTIVE_BIT;
@@ -861,44 +905,7 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	if (ndev->ntb.topo == NTB_TOPO_SEC) {
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
-					return 0;
-			} else {
-				return 0;
-			}
-		} else {
-			return 0;
-		}
-	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {
-		/*
-		 * For NTB primary, we simply read the Link Status and control
-		 * register of the NTB device itself.
-		 */
-		pdev = ndev->ntb.pdev;
-		rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
-		if (rc)
-			return 0;
-	} else {
-		/* Catch all for everything else */
-		return 0;
-	}
-
-	ndev->lnk_sta = stat;
-
-	return 1;
+	return amd_ntb_get_link_status(ndev);
 }
 
 static void amd_link_hb(struct work_struct *work)
-- 
2.17.1

