Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id p3si1049986ywh.5.2016.07.22.06.39.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2016 06:39:03 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 2/2] NTB: ntb_hw_intel: use local variable pdev
Date: Fri, 22 Jul 2016 09:38:23 -0400
Message-Id: <1d852b3f868e6cbca583d7b8b277f49790978192.1469194609.git.Allen.Hubbe@emc.com>
In-Reply-To: <6a5cd51b82d6d20bfbc129f4d83264d93adbf78c.1469194609.git.Allen.Hubbe@emc.com>
References: <6a5cd51b82d6d20bfbc129f4d83264d93adbf78c.1469194609.git.Allen.Hubbe@emc.com>
In-Reply-To: <6a5cd51b82d6d20bfbc129f4d83264d93adbf78c.1469194609.git.Allen.Hubbe@emc.com>
References: <6a5cd51b82d6d20bfbc129f4d83264d93adbf78c.1469194609.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Clean up duplicated expression by replacing it with the equivalent local
varible pdev.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 5efd03705e5c..0d5c29ae51de 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -706,7 +706,7 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 				 "LMT45 -\t\t\t%#018llx\n", u.v64);
 	}
 
-	if (pdev_is_xeon(ndev->ntb.pdev)) {
+	if (pdev_is_xeon(pdev)) {
 		if (ntb_topo_is_b2b(ndev->ntb.topo)) {
 			off += scnprintf(buf + off, buf_size - off,
 					 "\nNTB Outgoing B2B XLAT:\n");
@@ -787,22 +787,22 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 		off += scnprintf(buf + off, buf_size - off,
 				 "\nXEON NTB Hardware Errors:\n");
 
-		if (!pci_read_config_word(ndev->ntb.pdev,
+		if (!pci_read_config_word(pdev,
 					  XEON_DEVSTS_OFFSET, &u.v16))
 			off += scnprintf(buf + off, buf_size - off,
 					 "DEVSTS -\t\t%#06x\n", u.v16);
 
-		if (!pci_read_config_word(ndev->ntb.pdev,
+		if (!pci_read_config_word(pdev,
 					  XEON_LINK_STATUS_OFFSET, &u.v16))
 			off += scnprintf(buf + off, buf_size - off,
 					 "LNKSTS -\t\t%#06x\n", u.v16);
 
-		if (!pci_read_config_dword(ndev->ntb.pdev,
+		if (!pci_read_config_dword(pdev,
 					   XEON_UNCERRSTS_OFFSET, &u.v32))
 			off += scnprintf(buf + off, buf_size - off,
 					 "UNCERRSTS -\t\t%#06x\n", u.v32);
 
-		if (!pci_read_config_dword(ndev->ntb.pdev,
+		if (!pci_read_config_dword(pdev,
 					   XEON_CORERRSTS_OFFSET, &u.v32))
 			off += scnprintf(buf + off, buf_size - off,
 					 "CORERRSTS -\t\t%#06x\n", u.v32);
-- 
2.7.2

