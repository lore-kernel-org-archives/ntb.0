Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id n75si401432ljb.0.2017.12.03.11.17.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 11:17:49 -0800 (PST)
Received: by mail-lf0-x242.google.com with SMTP id r143so16768713lfe.13
        for <linux-ntb@googlegroups.com>; Sun, 03 Dec 2017 11:17:49 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 00/15] NTB: Add full multi-port API support to the test drivers
Date: Sun,  3 Dec 2017 22:17:21 +0300
Message-Id: <20171203191736.3399-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

The multi-port NTB API was introduced in kernel 4.13 as well as the
first driver for the true multi-port devices of IDT PCIe-switches
series. But the test drivers still were left almost unchanged. Yes,
they didn't fail being used with new NTB API, but they only worked
with two-ports NTB devices. This patchset is intended to fix the
issue, by amending the NTB test drivers and script so they would be
fully compatible with multi-port NTB API.

Additionally I found a few NTB subsystem issues while developing the
submitted patches. So they are also fixed in this patchset.

Serge Semin (15):
  NTB: Rename NTB messaging API methods
  NTB: Set dma mask and dma coherent mask to NTB devices
  NTB: Fix UB/bug in ntb_mw_get_align()
  NTB: ntb_pp: Add full multi-port NTB API support
  NTB: ntb_tool: Add full multi-port NTB API support
  NTB: ntb_perf: Add full multi-port NTB API support
  NTB: ntb_test: Safely use paths with whitespace
  NTB: ntb_test: Add ntb_tool port tests
  NTB: ntb_test: Update ntb_tool link tests
  NTB: ntb_test: Update ntb_tool DB tests
  NTB: ntb_test: Update ntb_tool Scratchpad tests
  NTB: ntb_test: Add ntb_tool Message tests
  NTB: ntb_test: Update ntb_tool MW tests
  NTB: ntb_test: Update ntb_perf tests
  NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology

 drivers/ntb/hw/amd/ntb_hw_amd.c         |    4 +
 drivers/ntb/hw/idt/ntb_hw_idt.c         |   37 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c     |    4 +
 drivers/ntb/ntb.c                       |    1 -
 drivers/ntb/test/ntb_perf.c             | 1826 +++++++++++++++++++++----------
 drivers/ntb/test/ntb_pingpong.c         |  450 +++++---
 drivers/ntb/test/ntb_tool.c             | 1805 ++++++++++++++++++++----------
 include/linux/ntb.h                     |   36 +-
 tools/testing/selftests/ntb/ntb_test.sh |  307 ++++--
 9 files changed, 3013 insertions(+), 1457 deletions(-)

-- 
2.12.0

