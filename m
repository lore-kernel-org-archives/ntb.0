Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com. [141.146.126.79])
        by gmr-mx.google.com with ESMTPS id c6si999648ybo.0.2019.02.19.02.03.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 02:03:19 -0800 (PST)
Date: Tue, 19 Feb 2019 13:03:02 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
Message-ID: <20190219100302.GA17991@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: logang@deltatee.com
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Logan Gunthorpe,

This is a semi-automatic email about new static checker warnings.

The patch c59666bb32b9: "NTB: ntb_transport: Ensure the destination 
buffer is mapped for TX DMA" from Jan 18, 2019, leads to the 
following Smatch complaint:

    drivers/ntb/ntb_transport.c:1926 ntb_transport_create_queue()
    error: we previously assumed 'qp->tx_dma_chan' could be null (see line 1872)

drivers/ntb/ntb_transport.c
  1835          free_queue = ffs(nt->qp_bitmap_free);
  1836          if (!free_queue)
  1837                  goto err;
  1838  
  1839          /* decrement free_queue to make it zero based */
  1840          free_queue--;
  1841  
  1842          qp = &nt->qp_vec[free_queue];
  1843          qp_bit = BIT_ULL(qp->qp_num);
  1844  
  1845          nt->qp_bitmap_free &= ~qp_bit;
  1846  
  1847          qp->cb_data = data;
  1848          qp->rx_handler = handlers->rx_handler;
  1849          qp->tx_handler = handlers->tx_handler;
  1850          qp->event_handler = handlers->event_handler;
  1851  
  1852          dma_cap_zero(dma_mask);
  1853          dma_cap_set(DMA_MEMCPY, dma_mask);
  1854  
  1855          if (use_dma) {
  1856                  qp->tx_dma_chan =
  1857                          dma_request_channel(dma_mask, ntb_dma_filter_fn,
  1858                                              (void *)(unsigned long)node);
  1859                  if (!qp->tx_dma_chan)
  1860                          dev_info(&pdev->dev, "Unable to allocate TX DMA channel\n");
  1861  
  1862                  qp->rx_dma_chan =
  1863                          dma_request_channel(dma_mask, ntb_dma_filter_fn,
  1864                                              (void *)(unsigned long)node);
  1865                  if (!qp->rx_dma_chan)
  1866                          dev_info(&pdev->dev, "Unable to allocate RX DMA channel\n");
  1867          } else {
  1868                  qp->tx_dma_chan = NULL;
  1869                  qp->rx_dma_chan = NULL;
                        ^^^^^^^^^^^^^^^^^^^^^^
What does this start as?  This assignment implies that qp->tx_mw_dma_addr
can be uninitialized also.


  1870          }
  1871	
  1872		if (qp->tx_dma_chan) {
  1873			qp->tx_mw_dma_addr =
                        ^^^^^^^^^^^^^^^^^^^^
Assigned here.

  1874				dma_map_resource(qp->tx_dma_chan->device->dev,
  1875						 qp->tx_mw_phys, qp->tx_mw_size,
  1876						 DMA_FROM_DEVICE, 0);
  1877			if (dma_mapping_error(qp->tx_dma_chan->device->dev,
  1878					      qp->tx_mw_dma_addr)) {
  1879				qp->tx_mw_dma_addr = 0;
  1880				goto err1;
  1881			}
  1882		}

But Smatch thinks qp->tx_mw_dma_addr can be uninitialized on the else
path.  I think that's correct, because I don't see us clearing it in
the error handling code.

  1883	
  1884		dev_dbg(&pdev->dev, "Using %s memcpy for TX\n",
  1885			qp->tx_dma_chan ? "DMA" : "CPU");
  1886	
  1887		dev_dbg(&pdev->dev, "Using %s memcpy for RX\n",
  1888			qp->rx_dma_chan ? "DMA" : "CPU");
  1889	
  1890		for (i = 0; i < NTB_QP_DEF_NUM_ENTRIES; i++) {
  1891			entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
  1892			if (!entry)
  1893				goto err1;
  1894	
  1895			entry->qp = qp;
  1896			ntb_list_add(&qp->ntb_rx_q_lock, &entry->entry,
  1897				     &qp->rx_free_q);
  1898		}
  1899		qp->rx_alloc_entry = NTB_QP_DEF_NUM_ENTRIES;
  1900	
  1901		for (i = 0; i < qp->tx_max_entry; i++) {
  1902			entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
  1903			if (!entry)
  1904				goto err2;
  1905	
  1906			entry->qp = qp;
  1907			ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry,
  1908				     &qp->tx_free_q);
  1909		}
  1910	
  1911		ntb_db_clear(qp->ndev, qp_bit);
  1912		ntb_db_clear_mask(qp->ndev, qp_bit);
  1913	
  1914		dev_info(&pdev->dev, "NTB Transport QP %d created\n", qp->qp_num);
  1915	
  1916		return qp;
  1917	
  1918	err2:
  1919		while ((entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q)))
  1920			kfree(entry);
  1921	err1:
  1922		qp->rx_alloc_entry = 0;
  1923		while ((entry = ntb_list_rm(&qp->ntb_rx_q_lock, &qp->rx_free_q)))
  1924			kfree(entry);
  1925		if (qp->tx_mw_dma_addr)
  1926			dma_unmap_resource(qp->tx_dma_chan->device->dev,
                                           ^^^^^^^^^^^^^^^^^
Warning.

  1927					   qp->tx_mw_dma_addr, qp->tx_mw_size,
  1928					   DMA_FROM_DEVICE, 0);
  1929          if (qp->tx_dma_chan)
  1930                  dma_release_channel(qp->tx_dma_chan);
  1931          if (qp->rx_dma_chan)
  1932                  dma_release_channel(qp->rx_dma_chan);
  1933          nt->qp_bitmap_free |= qp_bit;
  1934  err:
  1935          return NULL;
  1936  }

regards,
dan carpenter
