Return-Path: <anath.amd@gmail.com>
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com. [2607:f8b0:4864:20::1042])
        by gmr-mx.google.com with ESMTPS id o19si14368vka.4.2020.02.05.09.17.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 09:17:39 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id n96so1245831pjc.3
        for <linux-ntb@googlegroups.com>; Wed, 05 Feb 2020 09:17:39 -0800 (PST)
Return-Path: <anath.amd@gmail.com>
Sender: Arindam Nath <anath.amd@gmail.com>
From: Arindam Nath <arindam.nath@amd.com>
Subject: [PATCH 0/4] ntb perf and ntb tool improvements
Date: Wed,  5 Feb 2020 22:46:54 +0530
Message-Id: <cover.1580921119.git.arindam.nath@amd.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Arindam Nath <arindam.nath@amd.com>
List-ID: <linux-ntb.googlegroups.com>

This patch series modifies the ntb perf code to
have separate functions for CPU and DMA transfers.
It also adds handling for -EAGAIN error code so
that we re-try sending commands later.

Fixes have been made to ntb_perf and ntb_tool
to use 'struct device' associated with 'struct
pci_dev' rather than 'struct ntb_dev'.

The patches are based on Linus' tree,

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

Arindam Nath (2):
  ntb_perf: refactor code for CPU and DMA transfers
  ntb_perf: send command in response to EAGAIN

Sanjay R Mehta (2):
  ntb_perf: pass correct struct device to dma_alloc_coherent
  ntb_tool: pass correct struct device to dma_alloc_coherent

 drivers/ntb/test/ntb_perf.c | 168 ++++++++++++++++++++++++++----------
 drivers/ntb/test/ntb_tool.c |   6 +-
 2 files changed, 126 insertions(+), 48 deletions(-)

-- 
2.17.1

