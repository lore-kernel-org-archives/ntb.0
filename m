Return-Path: <Gary.Hook@amd.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (mail-dm3nam03on0040.outbound.protection.outlook.com. [104.47.41.40])
        by gmr-mx.google.com with ESMTPS id k69si2328621pfj.1.2017.08.21.14.59.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Aug 2017 14:59:43 -0700 (PDT)
From: Gary R Hook <gary.hook@amd.com>
Subject: Translation registers
Message-ID: <8f9eda70-cd72-b5b0-aa6b-30022cc96e7a@amd.com>
Date: Mon, 21 Aug 2017 16:59:37 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: gary.hook@amd.com
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Stupid question time.

What is the purpose of the call to dma_alloc_coherent() in ntb_perf and 
ntb_tool? Is is supposed to acquire a chunk of DMA memory that is mapped 
into the device bar? A call to ntb_mw_set_trans() ensues, but I'm not 
seeing what is supposed to happen in that, either. The translation 
registers are accessed, yes, but why?

I'm seeing the memory window this way: On my primary I get the MW 
address through the BAR, it's a certain size, and I can write into it. 
The data should appear in the corresponding memory window of the 
secondary. An application could be notified via a doorbell event to go 
read the data.

Or am I just completely confused?

What I'm trying to get down to is how, during initialization of the 
device driver and tool module, I get a virtual address that I can use 
for memcpy operations. The physical address (for DMA ops) is easy; I've 
got that. What's not clear is how (on Intel hardware) is how 
ioremap_wc()/et. al. are used to get a virtual reference to a physical 
address.

Searching has as yet revealed nothing specific on this detail. Of 
course, I could be making this more complex than it needs to be...


In summary: how is the Intel NTB device getting mapped into the virtual 
address space, via dma_alloc_coherent, ioremap_wc, and ntb_mw_set_trans?

Much thanks to anyone that has illuminating comments.
