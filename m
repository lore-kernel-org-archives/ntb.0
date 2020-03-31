Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com. [2607:f8b0:4864:20::843])
        by gmr-mx.google.com with ESMTPS id u14si222734pjn.2.2020.03.31.08.27.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Mar 2020 08:27:23 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id c9so18640119qtw.7
        for <linux-ntb@googlegroups.com>; Tue, 31 Mar 2020 08:27:23 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 31 Mar 2020 11:27:21 -0400
Subject: [GIT PULL] NTB bug fixes for v5.7
Message-ID: <20200331152721.GA1719@athena.kudzu.us>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Linus,
Here are a few NTB bug fixes and AMD NTB driver changes for v5.7.  Please consider pulling them.

Thanks,
Jon



The following changes since commit bb6d3fb354c5ee8d6bde2d576eb7220ea09862b9:

  Linux 5.6-rc1 (2020-02-09 16:08:48 -0800)

are available in the Git repository at:

  git://github.com/jonmason/ntb tags/ntb-5.7

for you to fetch changes up to b350f0a3eb264962caefeb892af56c1b727ee03f:

  NTB: add pci shutdown handler for AMD NTB (2020-03-13 10:04:20 -0400)

----------------------------------------------------------------
Bug fixes for a few printing issues, link status detection bug on AMD
hardware, and a DMA address issue with ntb_perf.  Also, large series of
AMD NTB patches.

----------------------------------------------------------------
Alexander Fomichev (1):
      ntb_hw_switchtec: Fix ntb_mw_clear_trans error if size == 0

Arindam Nath (15):
      NTB: Fix access to link status and control register
      NTB: clear interrupt status register
      NTB: Enable link up and down event notification
      NTB: define a new function to get link status
      NTB: return the side info status from amd_poll_link
      NTB: set peer_sta within event handler itself
      NTB: remove handling of peer_sta from amd_link_is_up
      NTB: handle link down event correctly
      NTB: handle link up, D0 and D3 events correctly
      NTB: move ntb_ctrl handling to init and deinit
      NTB: add helper functions to set and clear sideinfo
      NTB: return link up status correctly for PRI and SEC
      NTB: remove redundant setting of DB valid mask
      NTB: send DB event when driver is loaded or un-loaded
      NTB: add pci shutdown handler for AMD NTB

Helge Deller (1):
      ntb_tool: Fix printk format

Jiasen Lin (2):
      NTB: Fix an error in get link status
      NTB: ntb_perf: Fix address err in perf_copy_chunk

Sanjay R Mehta (1):
      MAINTAINERS: update maintainer list for AMD NTB driver

Takashi Iwai (1):
      NTB: ntb_transport: Use scnprintf() for avoiding potential buffer overflow

 MAINTAINERS                            |   1 +
 drivers/ntb/hw/amd/ntb_hw_amd.c        | 290 +++++++++++++++++++++++++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h        |   8 +-
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c |   2 +-
 drivers/ntb/ntb_transport.c            |  58 +++----
 drivers/ntb/test/ntb_perf.c            |  57 +++++--
 drivers/ntb/test/ntb_tool.c            |  14 +-
 7 files changed, 332 insertions(+), 98 deletions(-)
