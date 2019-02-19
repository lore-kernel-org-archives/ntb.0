Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u13si1072839iof.2.2019.02.19.11.03.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Feb 2019 11:03:38 -0800 (PST)
References: <20190219100302.GA17991@kadam>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1c350d81-a96a-9be0-1e19-99613db45107@deltatee.com>
Date: Tue, 19 Feb 2019 12:03:33 -0700
MIME-Version: 1.0
In-Reply-To: <20190219100302.GA17991@kadam>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [bug report] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-02-19 3:03 a.m., Dan Carpenter wrote:
> Hello Logan Gunthorpe,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch c59666bb32b9: "NTB: ntb_transport: Ensure the destination 
> buffer is mapped for TX DMA" from Jan 18, 2019, leads to the 
> following Smatch complaint:
> 
>     drivers/ntb/ntb_transport.c:1926 ntb_transport_create_queue()
>     error: we previously assumed 'qp->tx_dma_chan' could be null (see line 1872)
> 
> drivers/ntb/ntb_transport.c
>   1835          free_queue = ffs(nt->qp_bitmap_free);
>   1836          if (!free_queue)
>   1837                  goto err;
>   1838  
>   1839          /* decrement free_queue to make it zero based */
>   1840          free_queue--;
>   1841  
>   1842          qp = &nt->qp_vec[free_queue];
>   1843          qp_bit = BIT_ULL(qp->qp_num);
>   1844  
>   1845          nt->qp_bitmap_free &= ~qp_bit;
>   1846  
>   1847          qp->cb_data = data;
>   1848          qp->rx_handler = handlers->rx_handler;
>   1849          qp->tx_handler = handlers->tx_handler;
>   1850          qp->event_handler = handlers->event_handler;
>   1851  
>   1852          dma_cap_zero(dma_mask);
>   1853          dma_cap_set(DMA_MEMCPY, dma_mask);
>   1854  
>   1855          if (use_dma) {
>   1856                  qp->tx_dma_chan =
>   1857                          dma_request_channel(dma_mask, ntb_dma_filter_fn,
>   1858                                              (void *)(unsigned long)node);
>   1859                  if (!qp->tx_dma_chan)
>   1860                          dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
>   1861  
>   1862                  qp->rx_dma_chan =
>   1863                          dma_request_channel(dma_mask, ntb_dma_filter_fn,
>   1864                                              (void *)(unsigned long)node);
>   1865                  if (!qp->rx_dma_chan)
>   1866                          dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
>   1867          } else {
>   1868                  qp->tx_dma_chan = NULL;
>   1869                  qp->rx_dma_chan = NULL;
>                         ^^^^^^^^^^^^^^^^^^^^^^
> What does this start as?  This assignment implies that qp->tx_mw_dma_addr
> can be uninitialized also.

Hmm, yes, the qp should be initialized to zero, but it can also be
reused so it might not always be zero. I'll send a patch to properly set
tx_mw_dma_addr to zero so that we know for certain that, if it is set,
the tx_dma_chan is also non-zero.

Logan
