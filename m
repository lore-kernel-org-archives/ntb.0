Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTP id zj2si115945pac.1.2016.06.28.16.15.25
        for <linux-ntb@googlegroups.com>;
        Tue, 28 Jun 2016 16:15:26 -0700 (PDT)
Subject: [PATCH v3 0/5] dmaengine: ioatdma: DMA error reporting
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 28 Jun 2016 16:15:05 -0700
Message-ID: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc.com, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

Changes v2 -> v3:
- Fix up commit header that was missing in patch 2/5.

Changes v1 -> v2: 
- Addressed comments from Allen Hubbe
- Added CPU resubmit for aborted/failed NTB submissions

The following series implements error reporting and handling for ioatdma.
An error flag field has been added to return DMA error status via the 
generic DMA descriptor so the upper layer can be notified if there are errors.
The ioatdma driver now will abort remaining outstanding descriptors when an
error has occured that requires a channel reset. The Intel NTB driver has been
modified to handle the error condition from the DMA layer.

---

Dave Jiang (5):
      dmaengine: Adding error handling flag
      dmaengine: ioatdma: Add error handling to ioat driver
      dmaengine: ioatdma: add error strings to chanerr output
      ntb: add DMA error handling for TX DMA
      ntb: add DMA error handling for RX DMA


 drivers/dma/ioat/dma.c       |  201 +++++++++++++++++++++++++++++++++++++-----
 drivers/dma/ioat/registers.h |    2 
 2 files changed, 181 insertions(+), 22 deletions(-)

--
