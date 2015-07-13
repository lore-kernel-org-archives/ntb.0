Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id u75si1883991ywe.4.2015.07.13.10.07.43
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:43 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 00/14] NTB: Performance and Usability Features
Date: Mon, 13 Jul 2015 08:07:15 -0400
Message-Id: <cover.1436788771.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

I split the v1 series into two series.  These patches are _not_ bug fixes.

Numbering in this v2 starts at 8.  This is the second half of the patches.

Module parameters are removed from "Add flow control".

These are in github.com/allenbh/linux.git branch ntb/next.

Allen Hubbe (1):
  NTB: Remove dma_sync_wait from ntb_async_rx

Dave Jiang (5):
  NTB: Add flow control to the ntb_netdev
  NTB: Add PCI Device IDs for Broadwell Xeon
  NTB: Make the transport list in order of discovery
  NTB: Clean up QP stats info
  NTB: Use unique DMA channels for TX and RX

Jon Mason (1):
  NTB: Add list to MAINTAINERS

 MAINTAINERS                         |   2 +
 drivers/net/ntb_netdev.c            |  77 ++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.c |  15 +++++
 drivers/ntb/hw/intel/ntb_hw_intel.h |   3 +
 drivers/ntb/ntb_transport.c         | 126 ++++++++++++++++++++++++++----------
 include/linux/ntb_transport.h       |   1 +
 6 files changed, 189 insertions(+), 35 deletions(-)

-- 
2.5.0.rc1

