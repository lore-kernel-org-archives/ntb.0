Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x22b.google.com (mail-yk0-x22b.google.com. [2607:f8b0:4002:c07::22b])
        by gmr-mx.google.com with ESMTPS id i138si1107908ywe.2.2016.01.23.11.53.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Jan 2016 11:53:26 -0800 (PST)
Received: by mail-yk0-x22b.google.com with SMTP id a85so122669656ykb.1
        for <linux-ntb@googlegroups.com>; Sat, 23 Jan 2016 11:53:26 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Sat, 23 Jan 2016 14:52:08 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: [GIT PULL] NTB changes for v4.5
Message-ID: <20160123195207.GA18724@kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, , linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB changes fixes for v4.5.  A new driver for the AMD
NTB and a few bug fixes.  Please consider pulling them.

Thanks,
Jon



The following changes since commit afd2ff9b7e1b367172f18ba7f693dfb62bdcb2dc:

  Linux 4.4 (2016-01-10 15:01:32 -0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.5

for you to fetch changes up to 03beaec80d57e7a540b1990188f8a97a076da6de:

  NTB: Fix macro parameter conflict with field name (2016-01-21 19:53:10 -0500)

----------------------------------------------------------------
A new driver to support AMD NTB, a NTB performance test driver, NTB bugs
fixes, and the ability to recover from running out of DMA descriptors.

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
