Return-Path: <wesley.sheng@microchip.com>
Received: from NAM01-BN3-obe.outbound.protection.outlook.com (mail-eopbgr740049.outbound.protection.outlook.com. [40.107.74.49])
        by gmr-mx.google.com with ESMTPS id x144si1135524oix.5.2018.12.05.23.48.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Dec 2018 23:48:33 -0800 (PST)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH v2 3/3] ntb_hw_switchtec: Added support of >=4G memory windows
Date: Thu, 6 Dec 2018 21:30:52 +0800
Message-ID: <1544103052-28191-4-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com
List-ID: <linux-ntb.googlegroups.com>

From: Paul Selles <paul.selles@microchip.com>

Current Switchtec's BAR setup registers are limited to 32bits,
corresponding to the maximum MW (memory window) size is <4G.

Increase the MW sizes with the addition of the BAR Setup Extension
Register for the upper 32bits of a 64bits MW size. This increases the MW
range to between 4K and 2^63.

Reported-by: Boris Glimcher <boris.glimcher@emc.com>
Signed-off-by: Paul Selles <paul.selles@microchip.com>
Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 9 +++++++--
 include/linux/switchtec.h              | 6 +++++-
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 9916bc5..f6f0035 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -264,6 +264,7 @@ static void switchtec_ntb_mw_clr_direct(struct switchtec_ntb *sndev, int idx)
 	ctl_val &= ~NTB_CTRL_BAR_DIR_WIN_EN;
 	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
 	iowrite32(0, &ctl->bar_entry[bar].win_size);
+	iowrite32(0, &ctl->bar_ext_entry[bar].win_size);
 	iowrite64(sndev->self_partition, &ctl->bar_entry[bar].xlate_addr);
 }
 
@@ -286,7 +287,9 @@ static void switchtec_ntb_mw_set_direct(struct switchtec_ntb *sndev, int idx,
 	ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
 
 	iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
-	iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+	iowrite32(xlate_pos | (lower_32_bits(size) & 0xFFFFF000),
+		  &ctl->bar_entry[bar].win_size);
+	iowrite32(upper_32_bits(size), &ctl->bar_ext_entry[bar].win_size);
 	iowrite64(sndev->self_partition | addr,
 		  &ctl->bar_entry[bar].xlate_addr);
 }
@@ -1053,7 +1056,9 @@ static int crosslink_setup_mws(struct switchtec_ntb *sndev, int ntb_lut_idx,
 		ctl_val |= NTB_CTRL_BAR_DIR_WIN_EN;
 
 		iowrite32(ctl_val, &ctl->bar_entry[bar].ctl);
-		iowrite32(xlate_pos | size, &ctl->bar_entry[bar].win_size);
+		iowrite32(xlate_pos | (lower_32_bits(size) & 0xFFFFF000),
+			  &ctl->bar_entry[bar].win_size);
+		iowrite32(upper_32_bits(size), &ctl->bar_ext_entry[bar].win_size);
 		iowrite64(sndev->peer_partition | addr,
 			  &ctl->bar_entry[bar].xlate_addr);
 	}
diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
index 623719c9..64aa25e 100644
--- a/include/linux/switchtec.h
+++ b/include/linux/switchtec.h
@@ -243,7 +243,11 @@ struct ntb_ctrl_regs {
 		u32 win_size;
 		u64 xlate_addr;
 	} bar_entry[6];
-	u32 reserved2[216];
+	struct {
+		u32 win_size;
+		u32 reserved[3];
+	} bar_ext_entry[6];
+	u32 reserved2[192];
 	u32 req_id_table[512];
 	u32 reserved3[256];
 	u64 lut_entry[512];
-- 
2.7.4

