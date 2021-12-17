Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2082.outbound.protection.outlook.com. [40.107.95.82])
        by gmr-mx.google.com with ESMTPS id 8926c6da1cb9f-2faa6b53fbfsi1061383173.1.2021.12.17.01.56.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Dec 2021 01:56:41 -0800 (PST)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH] ntb_hw_amd: Add NTB PCI ID for new gen CPU
Date: Fri, 17 Dec 2021 03:56:20 -0600
Message-ID: <1639734980-9748-1-git-send-email-sanju.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: Sanju.Mehta@amd.com
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, logang@deltatee.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R
 Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Add NTB support for new generation of processor

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 87847c3..04550b1 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1321,6 +1321,8 @@ static const struct ntb_dev_data dev_data[] = {
 static const struct pci_device_id amd_ntb_pci_tbl[] = {
 	{ PCI_VDEVICE(AMD, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ PCI_VDEVICE(AMD, 0x148b), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
+	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
 	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
 	{ 0, }
 };
-- 
2.7.4

