Return-Path: <gustavo@embeddedor.com>
Received: from gateway36.websitewelcome.com (gateway36.websitewelcome.com. [192.185.193.12])
        by gmr-mx.google.com with ESMTPS id o3-v6si371840qkl.4.2018.10.05.00.12.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Oct 2018 00:12:37 -0700 (PDT)
Received: from cm14.websitewelcome.com (cm14.websitewelcome.com [100.42.49.7])
	by gateway36.websitewelcome.com (Postfix) with ESMTP id 942C6400CC0BF
	for <linux-ntb@googlegroups.com>; Fri,  5 Oct 2018 01:18:56 -0500 (CDT)
Date: Fri, 5 Oct 2018 09:12:34 +0200
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ntb: ntb_transport: Mark expected switch fall-throughs
Message-ID: <20181005071234.GA8803@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-ntb.googlegroups.com>

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 1373888 ("Missing break in switch")
Addresses-Coverity-ID: 1373889 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/ntb/ntb_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9398959..c643b9c 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1278,6 +1278,7 @@ static void ntb_rx_copy_callback(void *data,
 		case DMA_TRANS_READ_FAILED:
 		case DMA_TRANS_WRITE_FAILED:
 			entry->errors++;
+			/* fall through */
 		case DMA_TRANS_ABORTED:
 		{
 			struct ntb_transport_qp *qp = entry->qp;
@@ -1533,6 +1534,7 @@ static void ntb_tx_copy_callback(void *data,
 		case DMA_TRANS_READ_FAILED:
 		case DMA_TRANS_WRITE_FAILED:
 			entry->errors++;
+			/* fall through */
 		case DMA_TRANS_ABORTED:
 		{
 			void __iomem *offset =
-- 
2.7.4

