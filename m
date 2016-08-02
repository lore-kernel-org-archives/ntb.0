Return-Path: <baolex.ni@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id ph9si412101pac.1.2016.08.02.05.26.09
        for <linux-ntb@googlegroups.com>;
        Tue, 02 Aug 2016 05:26:09 -0700 (PDT)
From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0808/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 19:48:28 +0800
Message-Id: <20160802114828.3831-1-baolex.ni@intel.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, rjui@broadcom.com, sbranden@broadcom.com, m.chehab@samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, k.kozlowski@samsung.com
Cc: linux-ntb@googlegroups.com, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com
List-ID: <linux-ntb.googlegroups.com>

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/ntb/ntb_transport.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2ef9d91..222c5a1 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -73,23 +73,23 @@ MODULE_LICENSE("Dual BSD/GPL");
 MODULE_AUTHOR("Intel Corporation");
 
 static unsigned long max_mw_size;
-module_param(max_mw_size, ulong, 0644);
+module_param(max_mw_size, ulong, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
 
 static unsigned int transport_mtu = 0x10000;
-module_param(transport_mtu, uint, 0644);
+module_param(transport_mtu, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(transport_mtu, "Maximum size of NTB transport packets");
 
 static unsigned char max_num_clients;
-module_param(max_num_clients, byte, 0644);
+module_param(max_num_clients, byte, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(max_num_clients, "Maximum number of NTB transport clients");
 
 static unsigned int copy_bytes = 1024;
-module_param(copy_bytes, uint, 0644);
+module_param(copy_bytes, uint, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(copy_bytes, "Threshold under which NTB will use the CPU to copy instead of DMA");
 
 static bool use_dma;
-module_param(use_dma, bool, 0644);
+module_param(use_dma, bool, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
 MODULE_PARM_DESC(use_dma, "Use DMA engine to perform large data copy");
 
 static struct dentry *nt_debugfs_dir;
-- 
2.9.2

