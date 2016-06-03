Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id f69si889851pfc.1.2016.06.03.13.53.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Jun 2016 13:53:21 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Fri,  3 Jun 2016 14:50:31 -0600
Message-Id: <9e9ca38bef468fc1dd3d135f5f3d3cfb6b61246d.1464986161.git.logang@deltatee.com>
In-Reply-To: <cover.1464986161.git.logang@deltatee.com>
References: <cover.1464986161.git.logang@deltatee.com>
In-Reply-To: <cover.1464986161.git.logang@deltatee.com>
References: <cover.1464986161.git.logang@deltatee.com>
Subject: [PATCH 1/3] ntb_perf: Allow limiting the size of the memory windows
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, John Kading <john.kading@gd-ms.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

On my system, dma_alloc_coherent won't produce memory anywhere
near the size of the BAR. So I needed a way to limit this.

It's pretty much copied straight from ntb_transport.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 8dfce9c..30635c8 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -83,6 +83,10 @@ MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
 
 static struct dentry *perf_debugfs_dir;
 
+static unsigned long max_mw_size;
+module_param(max_mw_size, ulong, 0644);
+MODULE_PARM_DESC(max_mw_size, "Limit size of large memory windows");
+
 static unsigned int seg_order = 19; /* 512K */
 module_param(seg_order, uint, 0644);
 MODULE_PARM_DESC(seg_order, "size order [n^2] of buffer segment for testing");
@@ -472,6 +476,10 @@ static void perf_link_work(struct work_struct *work)
 	dev_dbg(&perf->ntb->pdev->dev, "%s called\n", __func__);
 
 	size = perf->mw.phys_size;
+
+	if (max_mw_size && size > max_mw_size)
+		size = max_mw_size;
+
 	ntb_peer_spad_write(ndev, MW_SZ_HIGH, upper_32_bits(size));
 	ntb_peer_spad_write(ndev, MW_SZ_LOW, lower_32_bits(size));
 	ntb_peer_spad_write(ndev, VERSION, PERF_VERSION);
-- 
2.1.4

