Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id ec7si995530wib.3.2015.07.06.08.31.27
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:27 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 09/12] NTB: Clean up QP stats info
Date: Mon,  6 Jul 2015 11:30:32 -0400
Message-Id: <94307fd3bfbc5e42c356d74f47895d0ba48da2ec.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Dave Jiang <dave.jiang@intel.com>

Make QP stats info more readable for debugging purposes.  Also add an
entry to indicate whether DMA is being used.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f92239141674..98ecf6d50621 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -452,7 +452,7 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 
 	out_offset = 0;
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "NTB QP stats\n");
+			       "\nNTB QP stats:\n\n");
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "rx_bytes - \t%llu\n", qp->rx_bytes);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
@@ -470,11 +470,11 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "rx_err_ver - \t%llu\n", qp->rx_err_ver);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "rx_buff - \t%p\n", qp->rx_buff);
+			       "rx_buff - \t0x%p\n", qp->rx_buff);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "rx_index - \t%u\n", qp->rx_index);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "rx_max_entry - \t%u\n", qp->rx_max_entry);
+			       "rx_max_entry - \t%u\n\n", qp->rx_max_entry);
 
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "tx_bytes - \t%llu\n", qp->tx_bytes);
@@ -489,21 +489,28 @@ static ssize_t debugfs_read(struct file *filp, char __user *ubuf, size_t count,
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "tx_mw - \t%p\n", qp->tx_mw);
+			       "tx_mw - \t0x%p\n", qp->tx_mw);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "tx_index - \t%u\n", qp->tx_index);
+			       "tx_index (H) - \t%u\n", qp->tx_index);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
-	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "qp->remote_rx_info->entry - \t%u\n",
+			       "RRI (T) - \t%u\n",
 			       qp->remote_rx_info->entry);
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "tx_max_entry - \t%u\n", qp->tx_max_entry);
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
 			       "free tx - \t%u\n",
 			       ntb_transport_tx_free_entry(qp));
 
 	out_offset += snprintf(buf + out_offset, out_count - out_offset,
-			       "\nQP Link %s\n",
+			       "\n");
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "Using DMA - \t%s\n", use_dma ? "Yes" : "No");
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "QP Link - \t%s\n",
 			       qp->link_is_up ? "Up" : "Down");
+	out_offset += snprintf(buf + out_offset, out_count - out_offset,
+			       "\n");
+
 	if (out_offset > out_count)
 		out_offset = out_count;
 
-- 
2.4.0.rc0.43.gcf8a8c6

