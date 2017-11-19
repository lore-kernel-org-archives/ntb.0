Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com. [2607:f8b0:400d:c0d::243])
        by gmr-mx.google.com with ESMTPS id 72si480500vko.3.2017.11.19.07.25.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 07:25:39 -0800 (PST)
Received: by mail-qt0-x243.google.com with SMTP id q13so667469qtb.5
        for <linux-ntb@googlegroups.com>; Sun, 19 Nov 2017 07:25:39 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 19 Nov 2017 10:25:36 -0500
Subject: [GIT PULL] NTB bug fixes for v4.15
Message-ID: <20171119152536.GA17838@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here is a new Switchtec NTB driver and a few NTB bug fixes for 4.15.
It's been sitting in my ntb-next branch for some time and should be
throughly tested.  Please consider pulling them.

Thanks,
Jon



The following changes since commit bebc6082da0a9f5d47a1ea2edc099bf671058bd4:

  Linux 4.14 (2017-11-12 10:46:13 -0800)

are available in the git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.15

for you to fetch changes up to 4201a9918c49bece71d25b2ef30cbadb1fc528e8:

  ntb: intel: remove b2b memory window workaround for Skylake NTB (2017-11-18 20:54:47 -0500)

----------------------------------------------------------------
Support for the switchtec ntb and related changes.  Also, a couple of
bug fixes.

----------------------------------------------------------------
Bhumika Goyal (1):
      NTB: make idt_89hpes_cfg const

Dave Jiang (2):
      ntb: update maintainer list for Intel NTB driver
      ntb: intel: remove b2b memory window workaround for Skylake NTB

Logan Gunthorpe (15):
      NTB: switchtec: Move structure definitions into a common header
      NTB: switchtec: Export class symbol for use in upper layer driver
      NTB: switchtec: Add NTB hardware register definitions
      NTB: switchtec: Add link event notifier callback
      NTB: Ensure ntb_mw_get_align() is only called when the link is up
      NTB: Add check and comment for link up to mw_count() and mw_get_align()
      NTB: switchtec_ntb: Introduce initial NTB driver
      NTB: switchtec_ntb: Initialize hardware for memory windows
      NTB: switchtec_ntb: Initialize hardware for doorbells and messages
      NTB: switchtec_ntb: Add skeleton NTB driver
      NTB: switchtec_ntb: Add link management
      NTB: switchtec_ntb: Implement doorbell registers
      NTB: switchtec_ntb: Implement scratchpad registers
      NTB: switchtec_ntb: Add memory window support
      NTB: switchtec_ntb: Update switchtec documentation with notes for NTB

 Documentation/switchtec.txt            |   12 +
 MAINTAINERS                            |    7 +-
 drivers/ntb/hw/Kconfig                 |    1 +
 drivers/ntb/hw/Makefile                |    1 +
 drivers/ntb/hw/idt/ntb_hw_idt.c        |   16 +-
 drivers/ntb/hw/intel/ntb_hw_intel.c    |   75 +-
 drivers/ntb/hw/mscc/Kconfig            |    9 +
 drivers/ntb/hw/mscc/Makefile           |    1 +
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 1216 ++++++++++++++++++++++++++++++++
 drivers/ntb/ntb_transport.c            |   20 +-
 drivers/ntb/test/ntb_perf.c            |   18 +-
 drivers/ntb/test/ntb_tool.c            |    6 +-
 drivers/pci/switch/switchtec.c         |  316 ++-------
 include/linux/ntb.h                    |   11 +-
 include/linux/switchtec.h              |  373 ++++++++++
 15 files changed, 1715 insertions(+), 367 deletions(-)
 create mode 100644 drivers/ntb/hw/mscc/Kconfig
 create mode 100644 drivers/ntb/hw/mscc/Makefile
 create mode 100644 drivers/ntb/hw/mscc/ntb_hw_switchtec.c
 create mode 100644 include/linux/switchtec.h
