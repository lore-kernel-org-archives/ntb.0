Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id t7si811175ywa.1.2017.05.14.06.50.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 May 2017 06:50:37 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id y128so13752905qka.3
        for <linux-ntb@googlegroups.com>; Sun, 14 May 2017 06:50:37 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 14 May 2017 09:50:29 -0400
Subject: [GIT PULL] NTB bug fixes for vv4.12
Message-ID: <20170514135029.GA7804@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB changes for v4.12.  I appologize for the delay in
sending my pull request, but I wanted to give the IDT changes a nice
long testing cycle before sending my pull request.  Please consider
pulling them.

Thanks,
Jon



The following changes since commit a351e9b9fc24e982ec2f0e76379a49826036da12:

  Linux 4.11 (2017-04-30 19:47:48 -0700)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.12

for you to fetch changes up to 6f21746f2529cc6f15d7095756e240b484947981:

  NTB: Add IDT 89HPESxNTx PCIe-switches support (2017-05-01 11:16:24 -0400)

----------------------------------------------------------------
New IDT NTB driver and changes to the NTB infrastructure to allow for
this different kind of NTB HW, some style fixes (per Greg KH
recommendation), and some ntb_test tweaks.

----------------------------------------------------------------
Allen Hubbe (2):
      NTB: ntb_test: modprobe on remote host
      NTB: ntb_test: add parameter for doorbell bitmask

Logan Gunthorpe (2):
      ntb_hw_amd: Style fixes: open code macros that just obfuscate code
      ntb_hw_intel: Style fixes: open code macros that just obfuscate code

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
 drivers/ntb/test/ntb_perf.c             |   27 +-
 drivers/ntb/test/ntb_pingpong.c         |   14 +-
 drivers/ntb/test/ntb_tool.c             |   69 +-
 include/linux/ntb.h                     |  721 ++++++--
 tools/testing/selftests/ntb/ntb_test.sh |   11 +-
 19 files changed, 5056 insertions(+), 340 deletions(-)
 create mode 100644 drivers/ntb/hw/idt/Kconfig
 create mode 100644 drivers/ntb/hw/idt/Makefile
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.c
 create mode 100644 drivers/ntb/hw/idt/ntb_hw_idt.h
