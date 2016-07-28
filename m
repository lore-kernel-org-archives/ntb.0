Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id p199si1946094wmd.1.2016.07.28.03.02.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 03:02:07 -0700 (PDT)
Received: by mail-lf0-x243.google.com with SMTP id l69so3400011lfg.1
        for <linux-ntb@googlegroups.com>; Thu, 28 Jul 2016 03:02:07 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 0/3] ntb: Asynchronous NTB devices support
Date: Thu, 28 Jul 2016 13:01:16 +0300
Message-Id: <1469700079-28377-1-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1469562619-21705-1-git-send-email-fancer.lancer@gmail.com>
References: <1469562619-21705-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Please, find the general patchset description in the cover letter of the first
patchset (see the very first message in thread).

Changes in v2:
 - Fix sparc64 compilation warning in drivers/ntb/hw/idt/ntb_hw_idt.c :
   warning: right shift count >= width of type
 - Fix sparc64 compilation warnings in drivers/ntb/test/ntb_mw_test.c :
   warning: right shift count >= width of type
   warning: cast to pointer from integer of different size

Thanks,

=============================
Serge V. Semin
Leading Programmer
Embedded SW development group
T-platforms
=============================

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

fancer (3):
  ntb: Add asynchronous devices support to NTB-bus interface
  ntb: IDT 89HPES*NT* PCIe-switches NTB device driver
  ntb: Test client drivers for asynchronous NTB devices

 drivers/ntb/Kconfig                    |    4 +-
 drivers/ntb/hw/Kconfig                 |    1 +
 drivers/ntb/hw/Makefile                |    6 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c        |   49 +-
 drivers/ntb/hw/idt/Kconfig             |   21 +
 drivers/ntb/hw/idt/Makefile            |    5 +
 drivers/ntb/hw/idt/ntb_hw_idt.c        | 4050 ++++++++++++++++++++++++++++++++
 drivers/ntb/hw/idt/ntb_hw_idt.h        |  390 +++
 drivers/ntb/hw/idt/ntb_hw_idt_quirks.c |  163 ++
 drivers/ntb/hw/idt/ntb_hw_idt_quirks.h |  114 +
 drivers/ntb/hw/idt/ntb_hw_idt_regmap.h |  877 +++++++
 drivers/ntb/hw/intel/ntb_hw_intel.c    |   59 +-
 drivers/ntb/ntb.c                      |   86 +-
 drivers/ntb/ntb_transport.c            |   19 +-
 drivers/ntb/test/Kconfig               |   32 +
 drivers/ntb/test/Makefile              |    9 +-
 drivers/ntb/test/ntb_db_test.c         |  677 ++++++
 drivers/ntb/test/ntb_msg_test.c        |  736 ++++++
 drivers/ntb/test/ntb_mw_test.c         | 1539 ++++++++++++
 drivers/ntb/test/ntb_perf.c            |   16 +-
 drivers/ntb/test/ntb_pingpong.c        |    5 +
 drivers/ntb/test/ntb_tool.c            |   25 +-
 include/linux/ntb.h                    |  600 ++++-
 23 files changed, 9317 insertions(+), 166 deletions(-)
 create mode 100644 drivers/ntb/hw/idt/Kconfig
 create mode 100644 drivers/ntb/hw/idt/Makefile
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.c
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.h
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt_quirks.c
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt_quirks.h
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt_regmap.h
 create mode 100644 drivers/ntb/test/ntb_db_test.c
 create mode 100644 drivers/ntb/test/ntb_msg_test.c
 create mode 100644 drivers/ntb/test/ntb_mw_test.c

-- 
2.6.6

