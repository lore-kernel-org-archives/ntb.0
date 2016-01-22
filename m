Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x229.google.com (mail-yk0-x229.google.com. [2607:f8b0:4002:c07::229])
        by gmr-mx.google.com with ESMTPS id i138si428626ywe.2.2016.01.21.17.18.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 17:18:30 -0800 (PST)
Received: by mail-yk0-x229.google.com with SMTP id k129so70504372yke.0
        for <linux-ntb@googlegroups.com>; Thu, 21 Jan 2016 17:18:30 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 21 Jan 2016 20:17:08 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: NTB patches for v4.5
Message-ID: <20160122011706.GC18163@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Allen Hubbe <Allen.Hubbe@emc.com>, Dave Jiang <dave.jiang@intel.com>, Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Below are the patches that will be in my pull request to Linus on
Saturday.  If possible, please test them in the next 24 hours to verify
everything is in working order.

git://github.com/jonmason/ntb ntb-4.5

Thanks,
Jon

----------------------------------------------------------------
Allen Hubbe (1):
      NTB: Fix macro parameter conflict with field name

Dave Jiang (3):
      NTB: Clear property bits in BAR value
      NTB: Address out of DMA descriptor issue with NTB
      ntb: ntb perf tool

Jon Mason (1):
      NTB: ntb_process_tx error path bug

Xiangliang Yu (1):
      NTB: Add support for AMD PCI-Express Non-Transparent Bridge

 MAINTAINERS                         |    6 +
 drivers/ntb/hw/Kconfig              |    1 +
 drivers/ntb/hw/Makefile             |    1 +
 drivers/ntb/hw/amd/Kconfig          |    7 +
 drivers/ntb/hw/amd/Makefile         |    1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c     | 1143 +++++++++++++++++++++++++++++++++++
 drivers/ntb/hw/amd/ntb_hw_amd.h     |  217 +++++++
 drivers/ntb/hw/intel/ntb_hw_intel.c |    4 +-
 drivers/ntb/hw/intel/ntb_hw_intel.h |    8 +-
 drivers/ntb/ntb_transport.c         |   50 +-
 drivers/ntb/test/Kconfig            |    8 +
 drivers/ntb/test/Makefile           |    1 +
 drivers/ntb/test/ntb_perf.c         |  748 +++++++++++++++++++++++
 13 files changed, 2183 insertions(+), 12 deletions(-)
 create mode 100644 drivers/ntb/hw/amd/Kconfig
 create mode 100644 drivers/ntb/hw/amd/Makefile
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.c
 create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.h
 create mode 100644 drivers/ntb/test/ntb_perf.c
