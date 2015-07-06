Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id t6si1000372wiz.0.2015.07.06.08.30.58
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:30:59 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 00/12] NTB: Performance and bug fixes in ntb drivers
Date: Mon,  6 Jul 2015 11:30:23 -0400
Message-Id: <cover.1436196351.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

This series includes the following changes to fix bugs, add new hardware
support, and improve usability and performance of the ntb drivers.

Bug Fixes (issues preexisting the new ntb api):
NTB: Fix ntb_transport out-of-order RX update
NTB: Schedule to receive on QP link up
NTB: Fix zero size or integer overflow in ntb_set_mw
NTB: ntb_netdev not covering all receive errors
NTB: Fix oops in debugfs when transport is half-up

Bug Fixes (regressions since the new ntb api):
NTB: Fix transport stats for multiple devices

Additions and Performance Improvements:
NTB: Remove dma_sync_wait from ntb_async_rx
NTB: Add PCI Device IDs for Broadwell Xeon
NTB: Add flow control to the ntb_netdev
NTB: Make the transport list in order of discovery
NTB: Clean up QP stats info
NTB: Use unique DMA channels for TX and RX


Allen Hubbe (4):
  NTB: Fix ntb_transport out-of-order RX update
  NTB: Schedule to receive on QP link up
  NTB: Remove dma_sync_wait from ntb_async_rx
  NTB: Fix zero size or integer overflow in ntb_set_mw

Dave Jiang (8):
  NTB: Add flow control to the ntb_netdev
  NTB: Fix transport stats for multiple devices
  NTB: ntb_netdev not covering all receive errors
  NTB: Fix oops in debugfs when transport is half-up
  NTB: Add PCI Device IDs for Broadwell Xeon
  NTB: Make the transport list in order of discovery
  NTB: Clean up QP stats info
  NTB: Use unique DMA channels for TX and RX

 drivers/net/ntb_netdev.c            |  89 +++++++++-
 drivers/ntb/hw/intel/ntb_hw_intel.c |  15 ++
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 +
 drivers/ntb/ntb_transport.c         | 322 ++++++++++++++++++++++++------------
 include/linux/ntb_transport.h       |   1 +
 5 files changed, 320 insertions(+), 110 deletions(-)

-- 
2.4.0.rc0.43.gcf8a8c6

