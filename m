Return-Path: <tiwai@suse.de>
Received: from mx2.suse.de (mx2.suse.de. [195.135.220.15])
        by gmr-mx.google.com with ESMTPS id h10si82584edn.1.2020.03.11.01.49.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Mar 2020 01:49:20 -0700 (PDT)
From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] NTB: ntb_transport: Use scnprintf() for avoiding potential buffer overflow
Date: Wed, 11 Mar 2020 09:49:17 +0100
Message-Id: <20200311084917.18592-1-tiwai@suse.de>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/ntb/ntb_transport.c | 58 ++++++++++++++++++++++-----------------------
 1 file changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 00a5d5764993..e6d1f5b298f3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -481,70 +481,70 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 		return -ENOMEM;
 
 	out_offset = 0;
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "\nNTB QP stats:\n\n");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_bytes - \t%llu\n", qp->rx_bytes);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_pkts - \t%llu\n", qp->rx_pkts);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_memcpy - \t%llu\n", qp->rx_memcpy);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_async - \t%llu\n", qp->rx_async);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_ring_empty - %llu\n", qp->rx_ring_empty);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_err_no_buf - %llu\n", qp->rx_err_no_buf);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_err_oflow - \t%llu\n", qp->rx_err_oflow);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_buff - \t0x%p\n", qp->rx_buff);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_index - \t%u\n", qp->rx_index);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "rx_alloc_entry - \t%u\n\n", qp->rx_alloc_entry);
 
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_bytes - \t%llu\n", qp->tx_bytes);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_pkts - \t%llu\n", qp->tx_pkts);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_memcpy - \t%llu\n", qp->tx_memcpy);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_async - \t%llu\n", qp->tx_async);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_ring_full - \t%llu\n", qp->tx_ring_full);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_mw - \t0x%p\n", qp->tx_mw);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_index (H) - \t%u\n", qp->tx_index);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "RRI (T) - \t%u\n",
 			       qp->remote_rx_info->entry);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "free tx - \t%u\n",
 			       ntb_transport_tx_free_entry(qp));
 
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "\n");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Using TX DMA - \t%s\n",
 			       qp->tx_dma_chan ? "Yes" : "No");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "Using RX DMA - \t%s\n",
 			       qp->rx_dma_chan ? "Yes" : "No");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "QP Link - \t%s\n",
 			       qp->link_is_up ? "Up" : "Down");
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+	out_offset += scnprintf(buf + out_offset, out_count - out_offset,
 			       "\n");
 
 	if (out_offset > out_count)
-- 
2.16.4

