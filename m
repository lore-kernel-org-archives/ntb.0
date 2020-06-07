Return-Path: <jdmason@kudzu.us>
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com. [2607:f8b0:4864:20::744])
        by gmr-mx.google.com with ESMTPS id x10si603953ila.3.2020.06.07.09.55.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 07 Jun 2020 09:55:02 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id b27so15019556qka.4
        for <linux-ntb@googlegroups.com>; Sun, 07 Jun 2020 09:55:02 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 7 Jun 2020 12:55:01 -0400
Subject: [GIT PULL] NTB patches for v5.8
Message-ID: <20200607165501.GA7336@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a lot of NTB bug fixes and Intel Icelake for v5.8.  Please
consider pulling them.

Thanks,
Jon



The following changes since commit 8f3d9f354286745c751374f5f1fcafee6b3f3136:

  Linux 5.7-rc1 (2020-04-12 12:35:55 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.8

for you to fetch changes up to 2130c0ba69d69bb21f5c52787f2587db00d13d8a:

  NTB: ntb_test: Fix bug when counting remote files (2020-06-05 20:02:09 -0400)

----------------------------------------------------------------
Intel Icelake NTB support, Intel driver bug fixes, and lots of bug fixes
for ntb tests

----------------------------------------------------------------
Dave Jiang (3):
      ntb: intel: Add Icelake (gen4) support for Intel NTB
      ntb: intel: add hw workaround for NTB BAR alignment
      ntb: intel: fix static declaration

Jiasen Lin (1):
      NTB: Fix static check warning in perf_clear_test

Logan Gunthorpe (9):
      ntb: hw: remove the code that sets the DMA mask
      NTB: ntb_tool: reading the link file should not end in a NULL byte
      NTB: Revert the change to use the NTB device dev for DMA allocations
      NTB: Fix the default port and peer numbers for legacy drivers
      NTB: ntb_pingpong: Choose doorbells based on port number
      NTB: perf: Don't require one more memory window than number of peers
      NTB: perf: Fix support for hardware that doesn't have port numbers
      NTB: perf: Fix race condition when run with ntb_test
      NTB: ntb_test: Fix bug when counting remote files

Maciej Grochowski (1):
      include/ntb: Fix typo in ntb_unregister_device description

Sanjay R Mehta (4):
      ntb_perf: pass correct struct device to dma_alloc_coherent
      ntb_tool: pass correct struct device to dma_alloc_coherent
      ntb_perf: increase sleep time from one milli sec to one sec
      ntb_perf: avoid false dma unmap of destination address

Wesley Sheng (1):
      NTB: correct ntb_peer_spad_addr and ntb_peer_spad_read comment typos

 drivers/ntb/core.c                      |   9 +-
 drivers/ntb/hw/amd/ntb_hw_amd.c         |   4 -
 drivers/ntb/hw/idt/ntb_hw_idt.c         |   6 -
 drivers/ntb/hw/intel/Makefile           |   2 +-
 drivers/ntb/hw/intel/ntb_hw_gen1.c      |  49 +--
 drivers/ntb/hw/intel/ntb_hw_gen1.h      |   1 +
 drivers/ntb/hw/intel/ntb_hw_gen3.c      |  13 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.h      |   8 +
 drivers/ntb/hw/intel/ntb_hw_gen4.c      | 552 ++++++++++++++++++++++++++++++++
 drivers/ntb/hw/intel/ntb_hw_gen4.h      | 100 ++++++
 drivers/ntb/hw/intel/ntb_hw_intel.h     |  12 +
 drivers/ntb/test/ntb_perf.c             |  49 +--
 drivers/ntb/test/ntb_pingpong.c         |  14 +-
 drivers/ntb/test/ntb_tool.c             |   9 +-
 include/linux/ntb.h                     |   6 +-
 tools/testing/selftests/ntb/ntb_test.sh |   2 +-
 16 files changed, 751 insertions(+), 85 deletions(-)
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen4.c
 create mode 100644 drivers/ntb/hw/intel/ntb_hw_gen4.h
