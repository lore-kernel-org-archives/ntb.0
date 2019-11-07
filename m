Return-Path: <linjiasen@hygon.cn>
Received: from spam2.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id r20si140658pfc.3.2019.11.07.01.37.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 01:37:02 -0800 (PST)
From: Jiasen Lin <linjiasen@hygon.cn>
Subject: [PATCH] NTB: Fix an error in get link status
Date: Thu, 7 Nov 2019 01:35:36 -0800
Message-ID: <1573119336-107732-1-git-send-email-linjiasen@hygon.cn>
MIME-Version: 1.0
Content-Type: text/plain
To: jdmason@kudzu.us, Shyam-sundar.S-k@amd.com, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linjiasen@hygon.cn, linjiasen007@gmail.com
List-ID: <linux-ntb.googlegroups.com>

The offset of PCIe Capability Header for AMD and HYGON NTB is 0x64,
but the macro which named "AMD_LINK_STATUS_OFFSET" is defined as 0x68.
It is offset of Device Capabilities Reg rather than Link Control Reg.

This code trigger an error in get link statsus:

	cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
		LNK STA -               0x8fa1
		Link Status -           Up
		Link Speed -            PCI-E Gen 0
		Link Width -            x0

This patch use pcie_capability_read_dword to get link status.
After fix this issue, we can get link status accurately:

	cat /sys/kernel/debug/ntb_hw_amd/0000:43:00.1/info
		LNK STA -               0x11030042
		Link Status -           Up
		Link Speed -            PCI-E Gen 3
		Link Width -            x16

Signed-off-by: Jiasen Lin <linjiasen@hygon.cn>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 5 +++--
 drivers/ntb/hw/amd/ntb_hw_amd.h | 1 -
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 156c2a1..ae91105 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -855,8 +855,8 @@ static int amd_poll_link(struct amd_ntb_dev *ndev)
 
 	ndev->cntl_sta = reg;
 
-	rc = pci_read_config_dword(ndev->ntb.pdev,
-				   AMD_LINK_STATUS_OFFSET, &stat);
+	rc = pcie_capability_read_dword(ndev->ntb.pdev,
+				   PCI_EXP_LNKCTL, &stat);
 	if (rc)
 		return 0;
 	ndev->lnk_sta = stat;
@@ -1139,6 +1139,7 @@ static const struct ntb_dev_data dev_data[] = {
 static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
 MODULE_DEVICE_TABLE(pci, amd_ntb_pci_tbl);
diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
index 139a307..39e5d18 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.h
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
@@ -53,7 +53,6 @@
 #include <linux/pci.h>
 
 #define AMD_LINK_HB_TIMEOUT	msecs_to_jiffies(1000)
-#define AMD_LINK_STATUS_OFFSET	0x68
 #define NTB_LIN_STA_ACTIVE_BIT	0x00000002
 #define NTB_LNK_STA_SPEED_MASK	0x000F0000
 #define NTB_LNK_STA_WIDTH_MASK	0x03F00000
-- 
2.7.4

