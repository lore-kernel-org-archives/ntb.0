Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id e18-v6si6670wmh.1.2018.06.07.16.57.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 16:57:40 -0700 (PDT)
Received: by mail-lf0-x242.google.com with SMTP id 36-v6so17282622lfr.11
        for <linux-ntb@googlegroups.com>; Thu, 07 Jun 2018 16:57:40 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 8 Jun 2018 02:57:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: dma_alloc_coherent bug in latest ntb_tool changes
Message-ID: <20180607235735.GA28442@mobilestation>
References: <e4743cee-5c10-4e16-5b8a-2090db3f9791@deltatee.com>
 <0a9adce4-dd06-652d-19ae-72929fa386f6@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a9adce4-dd06-652d-19ae-72929fa386f6@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jun 07, 2018 at 04:17:02PM -0700, Dave Jiang <dave.jiang@intel.com> wrote:
> 
> 
> On 06/07/2018 04:10 PM, Logan Gunthorpe wrote:
> > Hey,
> > 
> > I'm just running ntb_test on recent kernels with switchtec hardware and
> > found that ntb_tool and ntb_perf no longer work. I get this kernel warning:
> > 
> > [   64.077406] WARNING: CPU: 3 PID: 2231 at
> > ./include/linux/dma-mapping.h:516 tool_mw_trans_write+0x16d/0x332 [ntb_tool]
> > 
> > Indicating that the dma_coherent mask is not set on the device. (Not
> > sure how much testing that patch set got before it was merged upstream...)
> > 
> > It seems one of the changes that slipped through is that it now
> > allocates DMA memory using the NTB struct device instead of the PCI
> > struct device that was used before the patchset.
> > 
> > Seeing nothing in the NTB tree sets the coherent mask on the NTB device
> > we get a warning and fail to allocate DMA-able memory.
> > 
> > I'm not sure the proper fix here: should we be using the NTB device for
> > DMA operations or roll back to using the PCI device? It seems cleaner to
> > use the NTB device but then we at least have to set the coherent_mask to
> > something sane (probably safe to set it to 64bits for NTB hardware).
> > However, I'm not sure if, for all arches, DMA ops depend on anything in
> > the device besides the mask.
> > 
> > Logan
> > 
> 
> I seem to recall having this discussion previously but don't remember
> the outcome. I still think we should be dealing with the PCI device when
> it comes to hardware stuff like DMA since that is the actual device. The
> NTB device is just a an abstract device to make it work with the NTB bus
> isn't it?

Hi

The outcome was to use dma_coerce_mask_and_coherent() to set the proper mask
of the NTB device (copy of PCI-device mask) and use NTB device for DMA allocations.
My patchset concerned IDT, Intel and AMD hw code only in this matter. The change
worked for all of them. It wasn't tested on AMDs though, since well to be honest
we don't even know whether such hardware exists. I can't remember why the Switchtec driver
wasn't altered. It might be, the code hadn't been merged yet before I sent/prepared
the patchset.

Logan, you can see the reference of the function usage in the rest of the hardware
drivers.

-Sergey
