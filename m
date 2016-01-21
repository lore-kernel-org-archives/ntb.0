Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id u74si368830ywf.0.2016.01.21.14.52.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 14:52:28 -0800 (PST)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Fix macro parameter conflict with field name
Date: Thu, 21 Jan 2016 12:53:50 -0500
Message-Id: <92f2c0f9f753ddb55242f01dd3d351191d2128c8.1453398752.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

If the parameter given to the macro is replaced throughout the macro as
it is evaluated.  The intent is that the macro parameter should replace
the only the first parameter to container_of().  However, the way the
macro was written, it would also inadvertantly replace a structure field
name.  If a parameter of any other name is given to the macro, it will
fail to compile, if the structure does not contain a field of the same
name.  At worst, it will compile, and hide improper access of an
unintended field in the structure.

Change the macro parameter name, so it does not conflict with the
structure field name.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
index 2eb4addd10d0..43b3fe0d4aed 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.h
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
@@ -334,7 +334,8 @@ struct intel_ntb_dev {
 #define ndev_pdev(ndev) ((ndev)->ntb.pdev)
 #define ndev_name(ndev) pci_name(ndev_pdev(ndev))
 #define ndev_dev(ndev) (&ndev_pdev(ndev)->dev)
-#define ntb_ndev(ntb) container_of(ntb, struct intel_ntb_dev, ntb)
-#define hb_ndev(work) container_of(work, struct intel_ntb_dev, hb_timer.work)
+#define ntb_ndev(__ntb) container_of(__ntb, struct intel_ntb_dev, ntb)
+#define hb_ndev(__work) container_of(__work, struct intel_ntb_dev, \
+				     hb_timer.work)
 
 #endif
-- 
2.7.0

