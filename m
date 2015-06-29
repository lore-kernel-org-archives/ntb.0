Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id t6si431617wiz.0.2015.06.29.07.50.34
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 07:50:35 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 0/9] NTB: Fix and cleanup ntb drivers
Date: Mon, 29 Jun 2015 10:49:56 -0400
Message-Id: <cover.1435587291.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

This series includes the following changes to fix bugs, add new hardware
support, and improve usability and performance of the ntb drivers.

Bug Fixes (issues preexisting the new ntb api):
NTB: Fix ntb_transport out-of-order RX update
NTB: Schedule to receive on QP link up
NTB: ntb_netdev not covering all receive errors
NTB: Fix oops in debugfs when transport is half-up

Bug Fixes (regressions since the new ntb api):
NTB: Fix transport stats for multiple devices

Additions:
NTB: Add PCI Device IDs for Broadwell Xeon
NTB: Add flow control to the ntb_netdev
NTB: Make the transport list in order of discovery
NTB: Clean up QP stats info


Allen Hubbe (2):
  NTB: Fix ntb_transport out-of-order RX update
  NTB: Schedule to receive on QP link up

Dave Jiang (7):
  NTB: Add flow control to the ntb_netdev
  NTB: Fix transport stats for multiple devices
  NTB: ntb_netdev not covering all receive errors
  NTB: Fix oops in debugfs when transport is half-up
  NTB: Add PCI Device IDs for Broadwell Xeon
  NTB: Make the transport list in order of discovery
  NTB: Clean up QP stats info

 drivers/net/ntb_netdev.c            |  80 ++++++++++++-
 drivers/ntb/hw/intel/ntb_hw_intel.c |  15 +++
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 +
 drivers/ntb/ntb_transport.c         | 228 +++++++++++++++++++++++-------------
 include/linux/ntb_transport.h       |   1 +
 5 files changed, 246 insertions(+), 81 deletions(-)

-- 
2.4.0.rc0.43.gcf8a8c6

