Return-Path: <anath.amd@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com. [2607:f8b0:4864:20::641])
        by gmr-mx.google.com with ESMTPS id z7si8900ilz.1.2020.02.05.07.54.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:54:49 -0800 (PST)
Received: by mail-pl1-x641.google.com with SMTP id g6so1050927plt.2
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 07:54:48 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 00/15] AMD ntb driver fixes and improvements
Date: Wed,  5 Feb 2020 21:24:17 +0530
Message-Id: <cover.1580914232.git.arindam.nath@amd.com>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Jiasen Lin <linjiasen@hygon.cn>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

This patch series fixes some bugs in the existing
AMD NTB driver, cleans-up code, and modifies the
code to handle NTB link-up/down events. The series
is based on Linus' tree,

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

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

 drivers/ntb/hw/amd/ntb_hw_amd.c | 290 ++++++++++++++++++++++++++------
 drivers/ntb/hw/amd/ntb_hw_amd.h |   8 +-
 2 files changed, 247 insertions(+), 51 deletions(-)

-- 
2.17.1

