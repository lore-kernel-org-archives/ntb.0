Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1bon0099.outbound.protection.outlook.com. [157.56.111.99])
        by gmr-mx.google.com with ESMTPS id fg10si4357883pad.0.2015.12.23.00.44.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 00:44:06 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V2 0/3] Change notes of V2
Date: Wed, 23 Dec 2015 21:42:40 +0800
Message-ID: <1450878160-9259-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Main changes in V2:
1. Fixed compiler warning;
2. Add marcro argument of ndev in NTB_READ_REG/NTB_WRITE_REG;
3. Add notes for flush and wakeup interfaces;

Xiangliang Yu (3):
  NTB: Add AMD PCI-Express NTB driver
  NTB: Add AMD NTB support in Kconfig and Makefile
  NTB: Add flush_req and wakeup interface

 drivers/ntb/hw/Kconfig          |    1 +
 drivers/ntb/hw/Makefile         |    1 +
 drivers/ntb/hw/amd/Kconfig      |    7 +
 drivers/ntb/hw/amd/Makefile     |    1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1265 +++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/amd/ntb_hw_amd.h |  265 ++++++++
 include/linux/ntb.h             |   35 ++
 7 files changed, 1575 insertions(+)
 create mode 100644 drivers/ntb/hw/amd/Kconfig
 create mode 100644 drivers/ntb/hw/amd/Makefile
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.c
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.h

-- 
1.9.1

