Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc44.google.com (mail-yw1-xc44.google.com. [2607:f8b0:4864:20::c44])
        by gmr-mx.google.com with ESMTPS id t12si1304239iol.0.2019.07.20.14.58.32
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Sat, 20 Jul 2019 14:58:32 -0700 (PDT)
Received: by mail-yw1-xc44.google.com with SMTP id i138so14658066ywg.8
        for <linux-ntb@googlegroups.com>; Sat, 20 Jul 2019 14:58:32 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sat, 20 Jul 2019 17:58:29 -0400
Subject: [GIT PULL] NTB changes for v5.3
Message-ID: <20190720215829.GA10213@graymalkin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are the NTB changes for v5.3.  The big change is adding the virtual
MSI interface for NTB (reviewed and acked by Bjorn).  Also, there are
some bug fixes.  Please consider pulling them.

Thanks,
Jon



The following changes since commit a188339ca5a396acc588e5851ed7e19f66b0ebd9:

  Linux 5.2-rc1 (2019-05-19 15:47:09 -0700)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.3

for you to fetch changes up to d9c53aa440b332059f7f0ce3f7868ff1dc58c62c:

  NTB: Describe the ntb_msi_test client in the documentation. (2019-06-13 09:03:12 -0400)

----------------------------------------------------------------
New feature to add support for NTB virtual MSI interrupts, the ability
to test and use this feature in the NTB transport layer.  Also, bug
fixes for the AMD and Switchtec drivers, as well as some general
patches.

----------------------------------------------------------------
Dan Carpenter (2):
      ntb_hw_switchtec: potential shift wrapping bug in switchtec_ntb_init_sndev()
      NTB: amd: Silence shift wrapping warning in amd_ntb_db_vector_mask()

Joey Zhang (2):
      ntb_hw_switchtec: Remove redundant steps of switchtec_ntb_reinit_peer() function
      ntb_hw_switchtec: Fix setup MW with failure bug

Logan Gunthorpe (11):
      NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed
      PCI/MSI: Support allocating virtual MSI interrupts
      PCI/switchtec: Add module parameter to request more interrupts
      NTB: Introduce helper functions to calculate logical port number
      NTB: Introduce functions to calculate multi-port resource index
      NTB: Rename ntb.c to support multiple source files in the module
      NTB: Introduce MSI library
      NTB: Introduce NTB MSI Test Client
      NTB: Add ntb_msi_test support to ntb_test
      NTB: Add MSI interrupt support to ntb_transport
      NTB: Describe the ntb_msi_test client in the documentation.

Sanjay R Mehta (4):
      NTB: ntb_perf: Increased the number of message retries to 1000
      NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
      NTB: ntb_perf: Clear stale values in doorbell and command SPAD register
      NTB: ntb_hw_amd: set peer limit register

Wesley Sheng (2):
      NTB: correct ntb_dev_ops and ntb_dev comment typos
      ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window for crosslink case

YueHaibing (1):
      ntb: intel: Make intel_ntb3_peer_db_addr static

 Documentation/ntb.txt                   |  27 ++
 drivers/ntb/Kconfig                     |  11 +
 drivers/ntb/Makefile                    |   3 +
 drivers/ntb/{ntb.c => core.c}           |   0
 drivers/ntb/hw/amd/ntb_hw_amd.c         |  10 +-
 drivers/ntb/hw/intel/ntb_hw_gen3.c      |   6 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c  |  82 +++---
 drivers/ntb/msi.c                       | 415 ++++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c             | 170 ++++++++++++-
 drivers/ntb/test/Kconfig                |   9 +
 drivers/ntb/test/Makefile               |   1 +
 drivers/ntb/test/ntb_msi_test.c         | 433 ++++++++++++++++++++++++++++++++
 drivers/ntb/test/ntb_perf.c             |  14 +-
 drivers/pci/msi.c                       |  54 +++-
 drivers/pci/switch/switchtec.c          |  12 +-
 include/linux/msi.h                     |   8 +
 include/linux/ntb.h                     | 200 ++++++++++++++-
 include/linux/pci.h                     |   9 +
 tools/testing/selftests/ntb/ntb_test.sh |  54 +++-
 19 files changed, 1458 insertions(+), 60 deletions(-)
 rename drivers/ntb/{ntb.c => core.c} (100%)
 create mode 100644 drivers/ntb/msi.c
 create mode 100644 drivers/ntb/test/ntb_msi_test.c
