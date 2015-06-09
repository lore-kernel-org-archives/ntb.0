Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id ec7si107140wib.3.2015.06.09.07.45.28
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 07:45:28 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v3 07/18] NTB: Do not advance transport RX on link down
Date: Tue,  9 Jun 2015 05:44:34 -0400
Message-Id: <83b2f5bc6a46053d04b3bcd90eaadf1cf9da55d4.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

On link down, don't advance RX index to the next entry.  The next entry
should never be valid after receiving the link down flag.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8d9b59f7fa07..0f86b60a0c0e 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1212,8 +1212,7 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
 		dev_dbg(&qp->ndev->pdev->dev, "link down flag set\n");
 		ntb_qp_link_down(qp);
 		hdr->flags = 0;
-		iowrite32(qp->rx_index, &qp->rx_info->entry);
-		return 0;
+		return -EAGAIN;
 	}
 
 	if (hdr->ver != (u32)qp->rx_pkts) {
-- 
2.4.0.rc0.43.gcf8a8c6

