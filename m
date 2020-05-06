Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com. [40.107.223.42])
        by gmr-mx.google.com with ESMTPS id 2si80453qtp.1.2020.05.05.21.22.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 21:22:26 -0700 (PDT)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 0/5] ntb perf, ntb tool and ntb-hw improvements
Date: Tue,  5 May 2020 23:21:47 -0500
Message-Id: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: sanju.mehta@amd.com
MIME-Version: 1.0
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

v3: 
- Increased ntb_perf command re-try sleep time
- avoid false dma unmap of dst address.

v2: Incorporated improvements suggested by Logan Gunthorpe

Links of the review comments for v3:
1. https://lkml.org/lkml/2020/3/11/981
2. https://lkml.org/lkml/2020/3/10/1827

Logan Gunthorpe (1):
  ntb: hw: remove the code that sets the DMA mask

Sanjay R Mehta (4):
  ntb_perf: pass correct struct device to dma_alloc_coherent
  ntb_tool: pass correct struct device to dma_alloc_coherent
  ntb_perf: increase sleep time from one milli sec to one sec
  ntb_perf: avoid false dma unmap of destination address

 drivers/ntb/hw/amd/ntb_hw_amd.c    |  4 ----
 drivers/ntb/hw/idt/ntb_hw_idt.c    |  6 ------
 drivers/ntb/hw/intel/ntb_hw_gen1.c |  4 ----
 drivers/ntb/test/ntb_perf.c        | 23 ++++++++---------------
 drivers/ntb/test/ntb_tool.c        |  6 +++---
 5 files changed, 11 insertions(+), 32 deletions(-)

-- 
2.7.4

