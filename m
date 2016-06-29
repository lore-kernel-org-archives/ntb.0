Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id t206si252879ywb.3.2016.06.29.06.24.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jun 2016 06:24:10 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@emc.com>
References: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
Subject: RE: [PATCH v3 0/5] dmaengine: ioatdma: DMA error reporting
Date: Wed, 29 Jun 2016 09:24:00 -0400
Message-ID: <002a01d1d209$80d81b00$82885100$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Dave Jiang' <dave.jiang@intel.com>, vinod.koul@intel.com, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang
> Changes v2 -> v3:
> - Fix up commit header that was missing in patch 2/5.
> 
> Changes v1 -> v2:
> - Addressed comments from Allen Hubbe
> - Added CPU resubmit for aborted/failed NTB submissions
> 
> The following series implements error reporting and handling for ioatdma.
> An error flag field has been added to return DMA error status via the
> generic DMA descriptor so the upper layer can be notified if there are errors.
> The ioatdma driver now will abort remaining outstanding descriptors when an
> error has occured that requires a channel reset. The Intel NTB driver has been
> modified to handle the error condition from the DMA layer.
> 
> ---
> 
> Dave Jiang (5):
>       dmaengine: Adding error handling flag
>       dmaengine: ioatdma: Add error handling to ioat driver
>       dmaengine: ioatdma: add error strings to chanerr output
>       ntb: add DMA error handling for TX DMA
>       ntb: add DMA error handling for RX DMA
> 

Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

> 
>  drivers/dma/ioat/dma.c       |  201 +++++++++++++++++++++++++++++++++++++-----
>  drivers/dma/ioat/registers.h |    2
>  2 files changed, 181 insertions(+), 22 deletions(-)
> 
> --

