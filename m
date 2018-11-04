Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc41.google.com (mail-yw1-xc41.google.com. [2607:f8b0:4864:20::c41])
        by gmr-mx.google.com with ESMTPS id n22si524018vso.0.2018.11.03.21.00.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 21:00:05 -0700 (PDT)
Received: by mail-yw1-xc41.google.com with SMTP id l66-v6so1966995ywl.7
        for <linux-ntb@googlegroups.com>; Sat, 03 Nov 2018 21:00:05 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Sun, 4 Nov 2018 00:00:02 -0400
Subject: [GIT PULL] NTB patches for v4.20
Message-ID: <20181104040002.GA2439@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB patches for v4.20.  Fairly minor changes and bug
fixes.  Please consider pulling them.


Thanks,
Jon

---

The following changes since commit 84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d:

  Linux 4.19 (2018-10-22 07:37:37 +0100)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-4.20

for you to fetch changes up to a662315d8ad9e687fe648b6eea9bd35017f565dd:

  ntb: idt: Alter the driver info comments (2018-11-01 10:33:12 -0400)

----------------------------------------------------------------
NTB IDT thermal changes and hook into hwmon, ntb_netdev clean-up of
private struct, and a few bug fixes.

----------------------------------------------------------------
Aaron Sierra (2):
      NTB: transport: Try harder to alloc an aligned MW buffer
      ntb_netdev: Simplify remove with client device drvdata

Dave Jiang (1):
      ntb: intel: fix return value for ndev_vec_mask()

Gustavo A. R. Silva (2):
      NTB: ntb_hw_idt: replace IS_ERR_OR_NULL with regular NULL checks
      ntb: ntb_transport: Mark expected switch fall-throughs

Jon Mason (1):
      ntb_netdev: fix sleep time mismatch

Serge Semin (5):
      ntb: idt: Set PCIe bus address to BARLIMITx
      ntb: idt: Alter temperature read method
      ntb: idt: Add basic hwmon sysfs interface
      ntb: idt: Discard temperature sensor IRQ handler
      ntb: idt: Alter the driver info comments

 drivers/net/ntb_netdev.c           |  30 +---
 drivers/ntb/hw/idt/Kconfig         |   5 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c    | 327 +++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h    |  87 +++++++++-
 drivers/ntb/hw/intel/ntb_hw_gen1.c |   2 +-
 drivers/ntb/ntb_transport.c        |  88 +++++++---
 6 files changed, 429 insertions(+), 110 deletions(-)
