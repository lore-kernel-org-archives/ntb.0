Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id v70si872163ywc.2.2016.07.22.06.38.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jul 2016 06:38:51 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 1/2] NTB: ntb_hw_intel: show BAR size in debugfs info
Date: Fri, 22 Jul 2016 09:38:22 -0400
Message-Id: <6a5cd51b82d6d20bfbc129f4d83264d93adbf78c.1469194609.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

It will be useful to know the hardware configured BAR size to diagnose
issues with NTB memory windows.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c | 39 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 40d04ef5da9e..5efd03705e5c 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -551,13 +551,15 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 				 size_t count, loff_t *offp)
 {
 	struct intel_ntb_dev *ndev;
+	struct pci_dev *pdev;
 	void __iomem *mmio;
 	char *buf;
 	size_t buf_size;
 	ssize_t ret, off;
-	union { u64 v64; u32 v32; u16 v16; } u;
+	union { u64 v64; u32 v32; u16 v16; u8 v8; } u;
 
 	ndev = filp->private_data;
+	pdev = ndev_pdev(ndev);
 	mmio = ndev->self_mmio;
 
 	buf_size = min(count, 0x800ul);
@@ -632,6 +634,41 @@ static ssize_t ndev_debugfs_read(struct file *filp, char __user *ubuf,
 			 "Doorbell Bell -\t\t%#llx\n", u.v64);
 
 	off += scnprintf(buf + off, buf_size - off,
+			 "\nNTB Window Size:\n");
+
+	pci_read_config_byte(pdev, XEON_PBAR23SZ_OFFSET, &u.v8);
+	off += scnprintf(buf + off, buf_size - off,
+			 "PBAR23SZ %hhu\n", u.v8);
+	if (!ndev->bar4_split) {
+		pci_read_config_byte(pdev, XEON_PBAR45SZ_OFFSET, &u.v8);
+		off += scnprintf(buf + off, buf_size - off,
+				 "PBAR45SZ %hhu\n", u.v8);
+	} else {
+		pci_read_config_byte(pdev, XEON_PBAR4SZ_OFFSET, &u.v8);
+		off += scnprintf(buf + off, buf_size - off,
+				 "PBAR4SZ %hhu\n", u.v8);
+		pci_read_config_byte(pdev, XEON_PBAR5SZ_OFFSET, &u.v8);
+		off += scnprintf(buf + off, buf_size - off,
+				 "PBAR5SZ %hhu\n", u.v8);
+	}
+
+	pci_read_config_byte(pdev, XEON_SBAR23SZ_OFFSET, &u.v8);
+	off += scnprintf(buf + off, buf_size - off,
+			 "SBAR23SZ %hhu\n", u.v8);
+	if (!ndev->bar4_split) {
+		pci_read_config_byte(pdev, XEON_SBAR45SZ_OFFSET, &u.v8);
+		off += scnprintf(buf + off, buf_size - off,
+				 "SBAR45SZ %hhu\n", u.v8);
+	} else {
+		pci_read_config_byte(pdev, XEON_SBAR4SZ_OFFSET, &u.v8);
+		off += scnprintf(buf + off, buf_size - off,
+				 "SBAR4SZ %hhu\n", u.v8);
+		pci_read_config_byte(pdev, XEON_SBAR5SZ_OFFSET, &u.v8);
+		off += scnprintf(buf + off, buf_size - off,
+				 "SBAR5SZ %hhu\n", u.v8);
+	}
+
+	off += scnprintf(buf + off, buf_size - off,
 			 "\nNTB Incoming XLAT:\n");
 
 	u.v64 = ioread64(mmio + bar2_off(ndev->xlat_reg->bar2_xlat, 2));
-- 
2.7.2

