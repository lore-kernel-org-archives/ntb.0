Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2083.outbound.protection.outlook.com. [40.107.93.83])
        by gmr-mx.google.com with ESMTPS id g4si567210vke.3.2020.03.10.13.55.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 13:55:17 -0700 (PDT)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v2 0/5] ntb perf, ntb tool and ntb-hw improvements
Date: Tue, 10 Mar 2020 15:54:49 -0500
Message-Id: <1583873694-19151-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: sanju.mehta@amd.com
MIME-Version: 1.0
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

This patch series modifies the ntb perf code to
have separate functions for CPU and DMA transfers.
It also adds handling for -EAGAIN error code so
that we re-try sending commands later.

Fixes have been made to ntb_perf, ntb_tool and 
ntb_hw* files.

The patches are based on Linus' tree,

git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

v2: Incorporated improvements suggested by Logan Gunthorpe

Arindam Nath (2):
  ntb_perf: refactor code for CPU and DMA transfers
  ntb_perf: send command in response to EAGAIN

Logan Gunthorpe (1):
  ntb: hw: remove the code that sets the DMA mask

Sanjay R Mehta (2):
  ntb_perf: pass correct struct device to dma_alloc_coherent
  ntb_tool: pass correct struct device to dma_alloc_coherent

 drivers/ntb/hw/amd/ntb_hw_amd.c    |   4 -
 drivers/ntb/hw/idt/ntb_hw_idt.c    |   6 --
 drivers/ntb/hw/intel/ntb_hw_gen1.c |   4 -
 drivers/ntb/test/ntb_perf.c        | 167 +++++++++++++++++++++++++++----------
 drivers/ntb/test/ntb_tool.c        |   6 +-
 5 files changed, 126 insertions(+), 61 deletions(-)

-- 
2.7.4

