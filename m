Return-Path: <dan.carpenter@oracle.com>
Received: from aserp1040.oracle.com (aserp1040.oracle.com. [141.146.126.69])
        by gmr-mx.google.com with ESMTPS id fk4si2733834pbc.2.2015.09.16.07.13.04
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Sep 2015 07:13:05 -0700 (PDT)
Date: Wed, 16 Sep 2015 17:12:53 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: re: NTB: Use unique DMA channels for TX and RX
Message-ID: <20150916141253.GA7674@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: dave.jiang@intel.com
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hello Dave Jiang,

This is a semi-automatic email about new static checker warnings.

The patch 569410ca756c: "NTB: Use unique DMA channels for TX and RX" 
from Jul 13, 2015, leads to the following Smatch complaint:

drivers/ntb/ntb_transport.c:2008 ntb_transport_max_size()
	 error: we previously assumed 'qp->tx_dma_chan' could be null (see line 2005)

drivers/ntb/ntb_transport.c
  2004	
  2005		if (!qp->tx_dma_chan && !qp->rx_dma_chan)

Patch adds new checks for NULL.  Was || intended here perhaps?

  2006			return qp->tx_max_frame - sizeof(struct ntb_payload_header);
  2007	
  2008		copy_align = max(qp->tx_dma_chan->device->copy_align,
  2009				 qp->rx_dma_chan->device->copy_align);

Patch adds unchecked dereferences.

  2010	

regards,
dan carpenter
