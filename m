Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com (mail-bl2on0083.outbound.protection.outlook.com. [65.55.169.83])
        by gmr-mx.google.com with ESMTPS id ti5si1567624igb.2.2016.01.20.19.40.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 19:40:44 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V5 0/1] AMD NTB V5 changes
Date: Thu, 21 Jan 2016 16:39:28 +0800
Message-ID: <1453365568-9782-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, Allen.Hubbe@emc.com, dave.jiang@intel.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Main changes in V5
Change ioread64/iowrite64 to read64/write64 to keep consistent
with readl/writel, readw/writel.
Add a comment for link check function.

Xiangliang Yu (1):
  NTB: Add support for AMD PCI-Express Non-Transparent Bridge

 MAINTAINERS                     |    6 +
 drivers/ntb/hw/Kconfig          |    1 +
 drivers/ntb/hw/Makefile         |    1 +
 drivers/ntb/hw/amd/Kconfig      |    7 +
 drivers/ntb/hw/amd/Makefile     |    1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1143 +++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/amd/ntb_hw_amd.h |  217 ++++++++
 7 files changed, 1376 insertions(+)
 create mode 100644 drivers/ntb/hw/amd/Kconfig
 create mode 100644 drivers/ntb/hw/amd/Makefile
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.c
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.h

-- 
1.9.1

