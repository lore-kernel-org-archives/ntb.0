Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTP id c11si2810975pfc.2.2016.06.27.16.09.53
        for <linux-ntb@googlegroups.com>;
        Mon, 27 Jun 2016 16:09:53 -0700 (PDT)
Subject: [PATCH 0/5] dmaengine: ioatdma: DMA error reporting
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 27 Jun 2016 16:09:33 -0700
Message-ID: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

The following series implements error reporting and handling for ioatdma.
An error flag field has been added to return DMA error status via the 
generic DMA descriptor so the upper layer can be notified if there are errors.
The ioatdma driver now will abort remaining outstanding descriptors when an
error has occured that requires a channel reset. The Intel NTB driver has been
modified to handle the error condition from the DMA layer. 

---

Dave Jiang (5):
      dmaengine: Adding error handling flag
      dmaengine: IOATDMA: Add error handling to driver
      dmaengine: ioatdma: add error strings to chanerr output
      ntb: add DMA error handling for TX DMA
      ntb: add DMA error handling for RX DMA


 drivers/dma/ioat/dma.c       |  201 ++++++++++++++++++++++++++++++++++----
 drivers/dma/ioat/registers.h |    2 
 drivers/ntb/ntb_transport.c  |  222 +++++++++++++++++++++++++++++++-----------
 include/linux/dmaengine.h    |   15 +++
 4 files changed, 359 insertions(+), 81 deletions(-)

--
