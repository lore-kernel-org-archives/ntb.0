Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x242.google.com (mail-qk0-x242.google.com. [2607:f8b0:400d:c09::242])
        by gmr-mx.google.com with ESMTPS id c74si672588ywh.3.2017.07.14.08.54.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Jul 2017 08:54:28 -0700 (PDT)
Received: by mail-qk0-x242.google.com with SMTP id q66so12593962qki.1
        for <linux-ntb@googlegroups.com>; Fri, 14 Jul 2017 08:54:28 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Fri, 14 Jul 2017 11:54:20 -0400
Subject: [GIT PULL] NTB bug fixes for v4.13
Message-ID: <20170714155420.GA24043@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a number of NTB changes for 4.13.

The major change in the series is a rework of the NTB infrastructure to
all for IDT hardware to be supported (and resulting fallout from that).
There are also a few clean-ups, etc.

This series has been tested very heavily on the previous version of the
kernel, and is compartmentalized to the ntb code.  So even if something
was broken, there should be no ill effects to other subsystems.

Please consider pulling it.

Thanks,
Jon



The following changes since commit 6f7da290413ba713f0cdd9ff1a2a9bb129ef4f6c:

  Linux 4.12 (2017-07-02 16:07:02 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.13

for you to fetch changes up to 854b1dd9c39d8c8c8647a44de47ef18506ae11f9:

  ntb_netdev: set the net_device's parent (2017-07-06 11:30:08 -0400)

----------------------------------------------------------------
New IDT NTB driver and changes to the NTB infrastructure to allow for
this different kind of NTB HW, some style fixes (per Greg KH
recommendation), and some ntb_test tweaks.

----------------------------------------------------------------
Allen Hubbe (2):
      NTB: ntb_test: modprobe on remote host
      NTB: ntb_test: add parameter for doorbell bitmask

Gary R Hook (4):
      ntb: Add a module option to control affinity of DMA channels
      ntb: Remove debug-fs variables from the context structure
      ntb: Add more debugfs support for ntb_perf testing options
      ntb: Add error path/handling to Debug FS entry creation

Logan Gunthorpe (3):
      ntb_hw_amd: Style fixes: open code macros that just obfuscate code
      ntb_hw_intel: Style fixes: open code macros that just obfuscate code
      ntb_netdev: set the net_device's parent

Serge Semin (10):
      NTB: Make link-state API being declared first
      NTB: Add indexed ports NTB API
      NTB: Alter link-state API to support multi-port devices
      NTB: Alter MW API to support multi-ports devices
      NTB: Alter Scratchpads API to support multi-ports devices
      NTB: Add Messaging NTB API
      NTB: Add new Memory Windows API documentation
      NTB: Add PCIe Gen4 link speed
      NTB: Add ntb.h comments
      NTB: Add IDT 89HPESxNTx PCIe-switches support

 Documentation/ntb.txt                   |   99 +-
 MAINTAINERS                             |    6 +
 drivers/net/ntb_netdev.c                |    2 +
 drivers/ntb/hw/Kconfig                  |    1 +
 drivers/ntb/hw/Makefile                 |    1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c         |  139 +-
 drivers/ntb/hw/amd/ntb_hw_amd.h         |    3 -
 drivers/ntb/hw/idt/Kconfig              |   31 +
 drivers/ntb/hw/idt/Makefile             |    1 +
 drivers/ntb/hw/idt/ntb_hw_idt.c         | 2712 +++++++++++++++++++++++++++++++
 drivers/ntb/hw/idt/ntb_hw_idt.h         | 1149 +++++++++++++
 drivers/ntb/hw/intel/ntb_hw_intel.c     |  298 ++--
 drivers/ntb/hw/intel/ntb_hw_intel.h     |    3 -
 drivers/ntb/ntb.c                       |   69 +
 drivers/ntb/ntb_transport.c             |   42 +-
 drivers/ntb/test/ntb_perf.c             |  109 +-
 drivers/ntb/test/ntb_pingpong.c         |   14 +-
 drivers/ntb/test/ntb_tool.c             |   69 +-
 include/linux/ntb.h                     |  721 ++++++--
 tools/testing/selftests/ntb/ntb_test.sh |   11 +-
 20 files changed, 5120 insertions(+), 360 deletions(-)
 create mode 100644 drivers/ntb/hw/idt/Kconfig
 create mode 100644 drivers/ntb/hw/idt/Makefile
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.c
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.h
