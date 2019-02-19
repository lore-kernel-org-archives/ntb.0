Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i11si114771qkk.4.2019.02.19.11.56.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:56:43 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 19 Feb 2019 12:56:36 -0700
Message-Id: <20190219195636.1485-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH] NTB: ntb_transport: Ensure qp->tx_mw_dma_addr is initaliazed
To: linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>, Dan Carpenter <dan.carpenter@oracle.com>, Jon Mason <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>

Dan Carpenter's static checker reported:

    drivers/ntb/ntb_transport.c:1926 ntb_transport_create_queue()
    error: we previously assumed 'qp->tx_dma_chan' could be null (see line 1872)

This is because the tx_mw_dma_addr is uninitialized in this function and
may be incorrectly released using a NULL DMA channel.

In practice this bug will not likely be seen. I'd guess you could hit
this if you loaded ntb_netdev with use_dma=True, then unloaded it and
loaded it again after setting the module parameter to use_dma=False.

To fix this, we simply ensure that tx_mw_dma_addr is always
initialized to zero. This is the safest in case any other part of the
code operates on it if it is non-zero.

Fixes: c27ccb899219 ("NTB: ntb_transport: Ensure the destination buffer is mapped for TX DMA")
Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jon Mason <jdmason@kudzu.us>
---
 drivers/ntb/ntb_transport.c | 1 +
 1 file changed, 1 insertion(+)

@Jon, it would be best if you can squash this with the commit that
introduced the bug in ntb-next. Thanks.

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 526b65afc16a..e8a8304a42df 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1866,6 +1866,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
 		qp->rx_dma_chan = NULL;
 	}

+	qp->tx_mw_dma_addr = 0;
 	if (qp->tx_dma_chan) {
 		qp->tx_mw_dma_addr =
 			dma_map_resource(qp->tx_dma_chan->device->dev,
--
2.19.0
