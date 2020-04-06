Return-Path: <dan.carpenter@oracle.com>
Received: from userp2130.oracle.com (userp2130.oracle.com. [156.151.31.86])
        by gmr-mx.google.com with ESMTPS id 185si1088863pgh.3.2020.04.06.03.43.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Apr 2020 03:43:15 -0700 (PDT)
Date: Mon, 6 Apr 2020 13:41:05 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] NTB: ntb_perf: Fix address err in perf_copy_chunk
Message-ID: <20200406104105.GA34519@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linjiasen@hygon.cn
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Jiasen Lin,

This is a semi-automatic email about new static checker warnings.

The patch 99a06056124d: "NTB: ntb_perf: Fix address err in
perf_copy_chunk" from Nov 20, 2019, leads to the following Smatch
complaint:

    drivers/ntb/test/ntb_perf.c:1017 perf_clear_test()
    warn: variable dereferenced before check 'pthr->dma_chan' (see line 1011)

drivers/ntb/test/ntb_perf.c
  1010		 */
  1011		(void)dmaengine_terminate_sync(pthr->dma_chan);
                                               ^^^^^^^^^^^^^^
"pthr->dma_chan" is dereferenced inside the function.

  1012		if (pthr->perf->test_peer->dma_dst_addr)
  1013			dma_unmap_resource(pthr->dma_chan->device->dev,
  1014					   pthr->perf->test_peer->dma_dst_addr,
  1015					   pthr->perf->test_peer->outbuf_size,
  1016					   DMA_FROM_DEVICE, 0);
  1017		if (pthr->dma_chan)
                    ^^^^^^^^^^^^^^
This new NULL check is too late.

  1018			dma_release_channel(pthr->dma_chan);
  1019	

regards,
dan carpenter
