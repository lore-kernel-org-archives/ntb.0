Return-Path: <dave.jiang@intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTP id 62si2953807pfx.1.2016.06.27.16.10.05
        for <linux-ntb@googlegroups.com>;
        Mon, 27 Jun 2016 16:10:05 -0700 (PDT)
Subject: [PATCH 2/5] dmaengine: IOATDMA: Add error handling to driver
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 27 Jun 2016 16:09:45 -0700
Message-ID: <146706898537.188649.13633369547142674206.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
References: <146706860557.188649.10766278554335496632.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: vinod.koul@intel.com, allen.hubbe@emc, jdmason@kudzu.us
Cc: dmaengine@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/dma/ioat/dma.c       |  136 ++++++++++++++++++++++++++++++++++++------
 drivers/dma/ioat/registers.h |    2 +
 2 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index bd09961..1bbc005 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -622,7 +622,8 @@ static void ioat_cleanup(struct ioatdma_chan *ioat_chan)
 	if (is_ioat_halted(*ioat_chan->completion)) {
 		u32 chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 
-		if (chanerr & IOAT_CHANERR_HANDLE_MASK) {
+		if (chanerr &
+		    (IOAT_CHANERR_HANDLE_MASK | IOAT_CHANERR_RECOVER_MASK)) {
 			mod_timer(&ioat_chan->timer, jiffies + IDLE_TIMEOUT);
 			ioat_eh(ioat_chan);
 		}
@@ -652,6 +653,60 @@ static void ioat_restart_channel(struct ioatdma_chan *ioat_chan)
 	__ioat_restart_chan(ioat_chan);
 }
 
+
+static void ioat_abort_descs(struct ioatdma_chan *ioat_chan)
+{
+	struct ioatdma_device *ioat_dma = ioat_chan->ioat_dma;
+	struct ioat_ring_ent *desc;
+	u16 active;
+	int idx = ioat_chan->tail, i;
+
+	/*
+	 * We assume that the failed descriptor has been processed.
+	 * Now we are just returning all the remaining submitted
+	 * descriptors to abort.
+	 */
+	active = ioat_ring_active(ioat_chan);
+
+	/* we skip the failed descriptor that tail points to */
+	for (i = 1; i < active; i++) {
+		struct dma_async_tx_descriptor *tx;
+
+		smp_read_barrier_depends();
+		prefetch(ioat_get_ring_ent(ioat_chan, idx + i + 1));
+		desc = ioat_get_ring_ent(ioat_chan, idx + i);
+		desc->txd.result |= ERR_DMA_ABORT;
+
+		tx = &desc->txd;
+		if (tx->cookie) {
+			dma_cookie_complete(tx);
+			dma_descriptor_unmap(tx);
+			if (tx->callback) {
+				tx->callback(tx->callback_param);
+				tx->callback = NULL;
+			}
+		}
+
+		/* skip extended descriptors */
+		if (desc_has_ext(desc)) {
+			WARN_ON(i + 1 >= active);
+			i++;
+		}
+
+		/* cleanup super extended descriptors */
+		if (desc->sed) {
+			ioat_free_sed(ioat_dma, desc->sed);
+			desc->sed = NULL;
+		}
+	}
+
+	smp_mb(); /* finish all descriptor reads before incrementing tail */
+	ioat_chan->tail = idx + i;
+
+	desc = ioat_get_ring_ent(ioat_chan, ioat_chan->tail);
+	ioat_chan->last_completion = *ioat_chan->completion = desc->txd.phys;
+}
+
 static void ioat_eh(struct ioatdma_chan *ioat_chan)
 {
 	struct pci_dev *pdev = to_pdev(ioat_chan);
@@ -662,6 +717,7 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
 	u32 err_handled = 0;
 	u32 chanerr_int;
 	u32 chanerr;
+	bool abort = false;
 
 	/* cleanup so tail points to descriptor that caused the error */
 	if (ioat_cleanup_preamble(ioat_chan, &phys_complete))
@@ -697,30 +753,50 @@ static void ioat_eh(struct ioatdma_chan *ioat_chan)
 		break;
 	}
 
+	if (chanerr & IOAT_CHANERR_RECOVER_MASK) {
+		if (chanerr & IOAT_CHANERR_READ_DATA_ERR) {
+			desc->txd.result |= ERR_DMA_READ;
+			err_handled |= IOAT_CHANERR_READ_DATA_ERR;
+		} else if (chanerr & IOAT_CHANERR_WRITE_DATA_ERR) {
+			desc->txd.result |= ERR_DMA_WRITE;
+			err_handled |= IOAT_CHANERR_WRITE_DATA_ERR;
+		}
+
+		abort = true;
+	}
+
 	/* fault on unhandled error or spurious halt */
 	if (chanerr ^ err_handled || chanerr == 0) {
 		dev_err(to_dev(ioat_chan), "%s: fatal error (%x:%x)\n",
 			__func__, chanerr, err_handled);
 		BUG();
-	} else { /* cleanup the faulty descriptor */
-		tx = &desc->txd;
-		if (tx->cookie) {
-			dma_cookie_complete(tx);
-			dma_descriptor_unmap(tx);
-			if (tx->callback) {
-				tx->callback(tx->callback_param);
-				tx->callback = NULL;
-			}
-		}
 	}
 
-	writel(chanerr, ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
-	pci_write_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, chanerr_int);
+	/* cleanup the faulty descriptor since we are continuing */
+	tx = &desc->txd;
+	if (tx->cookie) {
+		dma_cookie_complete(tx);
+		dma_descriptor_unmap(tx);
+		if (tx->callback) {
+			tx->callback(tx->callback_param);
+			tx->callback = NULL;
+		}
+	}
 
 	/* mark faulting descriptor as complete */
 	*ioat_chan->completion = desc->txd.phys;
 
 	spin_lock_bh(&ioat_chan->prep_lock);
+	/* we need abort all descriptors */
+	if (abort) {
+		ioat_abort_descs(ioat_chan);
+		/* clean up the channel, we could be in weird state */
+		ioat_reset_hw(ioat_chan);
+	}
+
+	writel(chanerr, ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
+	pci_write_config_dword(pdev, IOAT_PCI_CHANERR_INT_OFFSET, chanerr_int);
+
 	ioat_restart_channel(ioat_chan);
 	spin_unlock_bh(&ioat_chan->prep_lock);
 }
@@ -753,10 +829,25 @@ void ioat_timer_event(unsigned long data)
 		chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
 		dev_err(to_dev(ioat_chan), "%s: Channel halted (%x)\n",
 			__func__, chanerr);
-		if (test_bit(IOAT_RUN, &ioat_chan->state))
-			BUG_ON(is_ioat_bug(chanerr));
-		else /* we never got off the ground */
-			return;
+		if (test_bit(IOAT_RUN, &ioat_chan->state)) {
+			spin_lock_bh(&ioat_chan->cleanup_lock);
+			spin_lock_bh(&ioat_chan->prep_lock);
+			set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
+			spin_unlock_bh(&ioat_chan->prep_lock);
+
+			ioat_abort_descs(ioat_chan);
+			dev_warn(to_dev(ioat_chan), "Reset channel...\n");
+			ioat_reset_hw(ioat_chan);
+			dev_warn(to_dev(ioat_chan), "Restart channel...\n");
+			ioat_restart_channel(ioat_chan);
+
+			spin_lock_bh(&ioat_chan->prep_lock);
+			clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
+			spin_unlock_bh(&ioat_chan->prep_lock);
+			spin_unlock_bh(&ioat_chan->cleanup_lock);
+		}
+
+		return;
 	}
 
 	spin_lock_bh(&ioat_chan->cleanup_lock);
@@ -780,14 +871,23 @@ void ioat_timer_event(unsigned long data)
 		u32 chanerr;
 
 		chanerr = readl(ioat_chan->reg_base + IOAT_CHANERR_OFFSET);
-		dev_warn(to_dev(ioat_chan), "Restarting channel...\n");
 		dev_warn(to_dev(ioat_chan), "CHANSTS: %#Lx CHANERR: %#x\n",
 			 status, chanerr);
 		dev_warn(to_dev(ioat_chan), "Active descriptors: %d\n",
 			 ioat_ring_active(ioat_chan));
 
 		spin_lock_bh(&ioat_chan->prep_lock);
+		set_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
+		spin_unlock_bh(&ioat_chan->prep_lock);
+
+		ioat_abort_descs(ioat_chan);
+		dev_warn(to_dev(ioat_chan), "Resetting channel...\n");
+		ioat_reset_hw(ioat_chan);
+		dev_warn(to_dev(ioat_chan), "Restarting channel...\n");
 		ioat_restart_channel(ioat_chan);
+
+		spin_lock_bh(&ioat_chan->prep_lock);
+		clear_bit(IOAT_CHAN_DOWN, &ioat_chan->state);
 		spin_unlock_bh(&ioat_chan->prep_lock);
 		spin_unlock_bh(&ioat_chan->cleanup_lock);
 		return;
diff --git a/drivers/dma/ioat/registers.h b/drivers/dma/ioat/registers.h
index 4994a36..faf20fa 100644
--- a/drivers/dma/ioat/registers.h
+++ b/drivers/dma/ioat/registers.h
@@ -233,6 +233,8 @@
 #define IOAT_CHANERR_DESCRIPTOR_COUNT_ERR	0x40000
 
 #define IOAT_CHANERR_HANDLE_MASK (IOAT_CHANERR_XOR_P_OR_CRC_ERR | IOAT_CHANERR_XOR_Q_ERR)
+#define IOAT_CHANERR_RECOVER_MASK (IOAT_CHANERR_READ_DATA_ERR | \
+				   IOAT_CHANERR_WRITE_DATA_ERR)
 
 #define IOAT_CHANERR_MASK_OFFSET		0x2C	/* 32-bit Channel Error Register */
 

