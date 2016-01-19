Return-Path: <Xiangliang.Yu@amd.com>
Received: from na01-by2-obe.outbound.protection.outlook.com (mail-by2on0076.outbound.protection.outlook.com. [207.46.100.76])
        by gmr-mx.google.com with ESMTPS id 190si2794145pfb.1.2016.01.18.23.17.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Jan 2016 23:17:46 -0800 (PST)
From: Xiangliang Yu <Xiangliang.Yu@amd.com>
Subject: [PATCH V4 0/1] AMD NTB V4 changes
Date: Tue, 19 Jan 2016 20:16:26 +0800
Message-ID: <1453205786-804-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Xiangliang.Yu@amd.com
To: jdmason@kudzu.us, Allen.Hubbe@emc.com, akpm@linux-foundation.org, gregkh@linuxfoundation.org, davem@davemloft.net, mchehab@osg.samsung.com, joe@perches.com, jslaby@suse.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
Cc: SPG_Linux_Kernel@amd.com, Xiangliang Yu <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

Main changes in V4
Add contact info into MAINTAINERS file.
Remove flush interface patch, will resubmit it next time.
Improve code quality.

Xiangliang Yu (1):
  NTB: Add support for AMD PCI-Express Non-Transparent Bridge

 MAINTAINERS                     |    6 +
 drivers/ntb/hw/Kconfig          |    1 +
 drivers/ntb/hw/Makefile         |    1 +
 drivers/ntb/hw/amd/Kconfig      |    7 +
 drivers/ntb/hw/amd/Makefile     |    1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c | 1138 +++++++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/amd/ntb_hw_amd.h |  217 ++++++++
 7 files changed, 1371 insertions(+)
 create mode 100644 drivers/ntb/hw/amd/Kconfig
 create mode 100644 drivers/ntb/hw/amd/Makefile
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.c
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.h

-- 
1.9.1

