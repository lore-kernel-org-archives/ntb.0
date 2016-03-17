Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com. [141.146.126.69])
        by gmr-mx.google.com with ESMTPS id 12si1312823pfb.1.2016.03.17.10.50.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Mar 2016 10:50:54 -0700 (PDT)
Date: Thu, 17 Mar 2016 20:50:44 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: ntb: ntb perf tool
Message-ID: <20160317175044.GA24724@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: dave.jiang@intel.com
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Dave Jiang,

The patch 8a7b6a778a85: "ntb: ntb perf tool" from Jan 13, 2016, leads
to the following static checker warning:

	drivers/ntb/test/ntb_perf.c:608 debugfs_run_write()
	error: 'pctx->thread' dereferencing possible ERR_PTR()

drivers/ntb/test/ntb_perf.c
   597                  for (i = 0; i < perf->perf_threads; i++) {
   598                          struct pthr_ctx *pctx;
   599  
   600                          pctx = &perf->pthr_ctx[i];
   601                          atomic_set(&pctx->dma_sync, 0);
   602                          pctx->perf = perf;
   603                          pctx->thread =
   604                                  kthread_create_on_node(ntb_perf_thread,
   605                                                         (void *)pctx,
   606                                                         node, "ntb_perf %d", i);

kthread_create_on_node() returns error pointers, never NULL.

   607                          if (pctx->thread)

It's better to flip this test around so it does failure handling instead
of success handling.

   608                                  wake_up_process(pctx->thread);
   609                          else {
   610                                  perf->run = false;
   611                                  for (i = 0; i < MAX_THREADS; i++) {

This loop doesn't make sense because we already tested "pctx->thread"
and because we're setting the same pointer to NULL 32 times in a row.

   612                                          if (pctx->thread) {
   613                                                  kthread_stop(pctx->thread);
   614                                                  pctx->thread = NULL;
   615                                          }
   616                                  }
   617                          }
   618  
   619                          if (perf->run == false)
   620                                  return -ENXIO;
   621                  }

regards,
dan carpenter
