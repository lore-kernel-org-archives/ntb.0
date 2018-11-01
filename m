Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc42.google.com (mail-yw1-xc42.google.com. [2607:f8b0:4864:20::c42])
        by gmr-mx.google.com with ESMTPS id p9-v6si1682220qte.4.2018.11.01.10.29.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 10:29:56 -0700 (PDT)
Received: by mail-yw1-xc42.google.com with SMTP id i185-v6so8207135ywa.12
        for <linux-ntb@googlegroups.com>; Thu, 01 Nov 2018 10:29:56 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Received: from graymalkin (76-230-155-4.lightspeed.rlghnc.sbcglobal.net. [76.230.155.4])
        by smtp.gmail.com with ESMTPSA id 207-v6sm8035244ywi.0.2018.11.01.10.29.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 01 Nov 2018 10:29:54 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
Date: Thu, 1 Nov 2018 13:29:53 -0400
Subject: NTB patches for v4.20
Message-ID: <20181101172953.GA15846@graymalkin.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>


Everyone, please test.  It is my intention to send the following pull
request to Linus tomorrow afternoon.  So barring someone telling me that
it is non-functional, this is what will happen.

If there are any outstanding patches not in the pull request below, they
need to be resent.

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
