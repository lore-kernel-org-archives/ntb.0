Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0095.outbound.protection.outlook.com. [65.55.169.95])
        by gmr-mx.google.com with ESMTPS id j19si332173ywg.7.2016.01.13.22.45.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jan 2016 22:45:36 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V3 0/2] AMD NTB V3 changes
Date: Thu, 14 Jan 2016 19:43:50 +0800
Message-ID: <1452771830-16907-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Main changes in V3
1. Remove all power managment related code.
2. Put makefile and kconfig changes in first patch.
3. Call readl/writel directly, not use macros to hide it.

Xiangliang Yu (2):
  NTB: Add AMD PCI-Express NTB driver
  NTB: Add support for flush request interface

 drivers/ntb/hw/Kconfig          |    1 +
 drivers/ntb/hw/Makefile         |    1 +
 drivers/ntb/hw/amd/Kconfig      |    7 +
 drivers/ntb/hw/amd/Makefile     |    1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1182 +++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/amd/ntb_hw_amd.h |  249 +++++++++
 include/linux/ntb.h             |   22 +
 7 files changed, 1463 insertions(+)
 create mode 100644 drivers/ntb/hw/amd/Kconfig
 create mode 100644 drivers/ntb/hw/amd/Makefile
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.c
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.h

-- 
1.9.1

