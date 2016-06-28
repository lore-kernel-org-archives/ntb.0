Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTP id po17si124823pab.2.2016.06.28.16.15.42
        for <linux-ntb@googlegroups.com>;
        Tue, 28 Jun 2016 16:15:42 -0700 (PDT)
Subject: [PATCH v3 3/5] dmaengine: ioatdma: add error strings to chanerr
 output
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 28 Jun 2016 16:15:22 -0700
Message-ID: <146715572259.208762.1593926659031750819.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
References: <146715558744.208762.15608813894802261982.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc.com, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com, dan.j.williams@intel.com
List-ID: <linux-ntb.googlegroups.com>

Provide a mechanism to translate CHANERR bits to English strings in order
to allow user to report more concise errors.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/ioat/dma.c |   65 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 61 insertions(+), 4 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 899f9e1..007169a 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -38,8 +38,54 @@
 
 #include "../dmaengine.h"
 
+static char *chanerr_str[] = {
+	"DMA Transfer Destination Address Error",
+	"Next Descriptor Address Error",
+	"Descriptor Error",
+	"Chan Address Value Error",
+	"CHANCMD Error",
+	"Chipset Uncorrectable Data Integrity Error",
+	"DMA Uncorrectable Data Integrity Error",
+	"Read Data Error",
+	"Write Data Error",
+	"Descriptor Control Error",
+	"Descriptor Transfer Size Error",
+	"Completion Address Error",
+	"Interrupt Configuration Error",
+	"Super extended descriptor Address Error",
+	"Unaffiliated Error",
+	"CRC or XOR P Error",
+	"XOR Q Error",
+	"Descriptor Count Error",
+	"DIF All F detect Error",
+	"Guard Tag verification Error",
+	"Application Tag verification Error",
+	"Reference Tag verification Error",
+	"Bundle Bit Error",
+	"Result DIF All F detect Error",
+	"Result Guard Tag verification Error",
+	"Result Application Tag verification Error",
+	"Result Reference Tag verification Error",
+	NULL
+};
+
 static void ioat_eh(struct ioatdma_chan *ioat_chan);
 
+static void ioat_print_chanerrs(struct ioatdma_chan *ioat_chan, u32 chanerr)
+{
+	int i;
+
+	for (i = 0; i < 32; i++) {
+		if ((chanerr >> i) & 1) {
+			if (chanerr_str[i]) {
+				dev_err(to_dev(ioat_chan), "Err(%d): %s\n",
+					i, chanerr_str[i]);
+			} else
+				break;
+		}
+	}
+}
+
 /**
  * ioat_dma_do_interrupt - handler used for single vector interrupt mode
  * @irq: interrupt id
@@ -769,6 +815,11 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
 	if (chanerr ^ err_handled || chanerr == 0) {
 		dev_err(to_dev(ioat_chan), "%s: fatal error (%x:%x)\n",
 			__func__, chanerr, err_handled);
+		dev_err(to_dev(ioat_chan), "Errors handled:\n");
+		ioat_print_chanerrs(ioat_chan, err_handled);
+		dev_err(to_dev(ioat_chan), "Errors not handled:\n");
+		ioat_print_chanerrs(ioat_chan, (chanerr & ~err_handled));
+
 		BUG();
 	}
 
@@ -829,6 +880,9 @@ void ioat_timer_event(unsigned long data)
 		chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 		dev_err(to_dev(ioat_chan), "%s: Channel halted (%x)\n",
 			__func__, chanerr);
+		dev_err(to_dev(ioat_chan), "Errors:\n");
+		ioat_print_chanerrs(ioat_chan, chanerr);
+
 		if (test_bit(IOAT_RUN, &ioat_chan->state)) {
 			spin_lock_bh(&ioat_chan->cleanup_lock);
 			spin_lock_bh(&ioat_chan->prep_lock);
@@ -871,10 +925,13 @@ void ioat_timer_event(unsigned long data)
 		u32 chanerr;
 
 		chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
-		dev_warn(to_dev(ioat_chan), "CHANSTS: %#Lx CHANERR: %#x\n",
-			 status, chanerr);
-		dev_warn(to_dev(ioat_chan), "Active descriptors: %d\n",
-			 ioat_ring_active(ioat_chan));
+		dev_err(to_dev(ioat_chan), "CHANSTS: %#Lx CHANERR: %#x\n",
+			status, chanerr);
+		dev_err(to_dev(ioat_chan), "Errors:\n");
+		ioat_print_chanerrs(ioat_chan, chanerr);
+
+		dev_dbg(to_dev(ioat_chan), "Active descriptors: %d\n",
+			ioat_ring_active(ioat_chan));
 
 		spin_lock_bh(&ioat_chan->prep_lock);
 		set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);

