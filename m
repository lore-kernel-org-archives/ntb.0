Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x242.google.com (mail-lf0-x242.google.com. [2a00:1450:4010:c07::242])
        by gmr-mx.google.com with ESMTPS id v12-v6si3596wmc.2.2018.06.07.17.24.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 17:24:33 -0700 (PDT)
Received: by mail-lf0-x242.google.com with SMTP id j13-v6so17363272lfb.13
        for <linux-ntb@googlegroups.com>; Thu, 07 Jun 2018 17:24:33 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Fri, 8 Jun 2018 03:24:29 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: dma_alloc_coherent bug in latest ntb_tool changes
Message-ID: <20180608002429.GC28442@mobilestation>
References: <e4743cee-5c10-4e16-5b8a-2090db3f9791@deltatee.com>
 <0a9adce4-dd06-652d-19ae-72929fa386f6@intel.com>
 <20180607235735.GA28442@mobilestation>
 <a607b7b3-fa69-4b8b-7b1e-ae9759ea54f8@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a607b7b3-fa69-4b8b-7b1e-ae9759ea54f8@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jun 07, 2018 at 06:05:20PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> 
> 
> On 07/06/18 05:57 PM, Serge Semin wrote:
> > The outcome was to use dma_coerce_mask_and_coherent() to set the proper mask
> > of the NTB device (copy of PCI-device mask) and use NTB device for DMA allocations.
> > My patchset concerned IDT, Intel and AMD hw code only in this matter. The change
> > worked for all of them. It wasn't tested on AMDs though, since well to be honest
> > we don't even know whether such hardware exists. I can't remember why the Switchtec driver
> > wasn't altered. It might be, the code hadn't been merged yet before I sent/prepared
> > the patchset.
> 
> Well, I kind of agree with Dave and should probably stick with using the
> PCI device as we don't know what else all arches need for properly
> allocating the DMA memory.
> 

You also said:
>> It seems cleaner to use the NTB device but then we at least have to set the
>> coherent_mask to something sane ...
It doesn't seem clearer now?

> If we want to stick with this solution, I'd suggest we set the coherent
> mask in ntb_register given that all the drivers are doing the exact same
> thing. Then we won't have to worry about missing one.
> 

Only hardware driver knows what dma address range is supported by device. Since
we have to initialize the coherence_mask anyway, seeing the field exists in the
standard device structure.
Regarding the ntb_register_device(). Since all the currently supported NTB devices
are PCIe-based, we can temporarily move the coherency mask setting to ntb.c. But
NTB API is still an abstraction, so I wouldn't do this, since there might be
non-PCIe-based devices.

> > I can't remember why the Switchtec driver
> > wasn't altered. It might be, the code hadn't been merged yet before I sent/prepared
> > the patchset.
> 
> The switchtec driver was in ntb-next well before this patch set
> materialized. In fact, the code in kernel v4.15 works fine.
> 

Ok. you got a chance to fix it know.

> It would have also been nice for this type of change to be in it's own
> commit with a full description of the decisions made. Then, when we
> bisect to find these issues we don't have to scratch our heads and
> wonder what we were thinking.
> 

You don't have to:
https://github.com/torvalds/linux/commit/417cf39cfea9c680aa7c278c8d8a0ca879cacf0a#diff-4cc577115709fbd1fb24e8803f9d629d

> Logan
