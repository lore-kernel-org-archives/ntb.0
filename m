Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1on0678.outbound.protection.outlook.com. [2a01:111:f400:fc10::678])
        by gmr-mx.google.com with ESMTPS id p88si3759337pfi.0.2015.12.23.00.44.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 00:44:37 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V2 2/3] NTB: Add AMD NTB support in Kconfig and Makefile
Date: Wed, 23 Dec 2015 21:43:11 +0800
Message-ID: <1450878191-9342-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

This patch is to enable AMD NTB support in Kconfig and Makefile.

Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
---
 drivers/ntb/hw/Kconfig  | 1 +
 drivers/ntb/hw/Makefile | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig
index 4d5535c..0c5c2a6 100644
--- a/drivers/ntb/hw/Kconfig
+++ b/drivers/ntb/hw/Kconfig
@@ -1 +1,2 @@
 source "drivers/ntb/hw/intel/Kconfig"
+source "drivers/ntb/hw/amd/Kconfig"
diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile
index 175d7c9..636be7d 100644
--- a/drivers/ntb/hw/Makefile
+++ b/drivers/ntb/hw/Makefile
@@ -1 +1,2 @@
 obj-$(CONFIG_NTB_INTEL)	+= intel/
+obj-$(CONFIG_NTB_AMD)	+= amd/
-- 
1.9.1

