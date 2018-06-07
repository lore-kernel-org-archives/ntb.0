Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id j133-v6si3795771vkf.2.2018.06.07.16.10.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 16:10:44 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e4743cee-5c10-4e16-5b8a-2090db3f9791@deltatee.com>
Date: Thu, 7 Jun 2018 17:10:39 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: dma_alloc_coherent bug in latest ntb_tool changes
To: linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Hey,

I'm just running ntb_test on recent kernels with switchtec hardware and
found that ntb_tool and ntb_perf no longer work. I get this kernel warning:

[   64.077406] WARNING: CPU: 3 PID: 2231 at
./include/linux/dma-mapping.h:516 tool_mw_trans_write+0x16d/0x332 [ntb_tool]

Indicating that the dma_coherent mask is not set on the device. (Not
sure how much testing that patch set got before it was merged upstream...)

It seems one of the changes that slipped through is that it now
allocates DMA memory using the NTB struct device instead of the PCI
struct device that was used before the patchset.

Seeing nothing in the NTB tree sets the coherent mask on the NTB device
we get a warning and fail to allocate DMA-able memory.

I'm not sure the proper fix here: should we be using the NTB device for
DMA operations or roll back to using the PCI device? It seems cleaner to
use the NTB device but then we at least have to set the coherent_mask to
something sane (probably safe to set it to 64bits for NTB hardware).
However, I'm not sure if, for all arches, DMA ops depend on anything in
the device besides the mask.

Logan
