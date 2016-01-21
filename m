Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com (mail-bn1bn0100.outbound.protection.outlook.com. [157.56.110.100])
        by gmr-mx.google.com with ESMTPS id r2si3548649pfr.0.2016.01.20.22.54.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Jan 2016 22:54:26 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [Resend PATCH V5 0/1] AMD NTB V5 changes
Date: Thu, 21 Jan 2016 19:53:10 +0800
Message-ID: <1453377190-10533-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, Allen.Hubbe@emc.com, dave.jiang@intel.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Resend V5 for more convenient pick up.
Main changes in V5
Only change Signed-off-by to Reviewed-by.

Xiangliang Yu (1):
  [Resend patch V5] NTB: Add support for AMD PCI-Express Non-Transparent Bridge

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

