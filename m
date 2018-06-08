Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id m4-v6si43527ybo.3.2018.06.07.17.05.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 17:05:25 -0700 (PDT)
References: <e4743cee-5c10-4e16-5b8a-2090db3f9791@deltatee.com>
 <0a9adce4-dd06-652d-19ae-72929fa386f6@intel.com>
 <20180607235735.GA28442@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a607b7b3-fa69-4b8b-7b1e-ae9759ea54f8@deltatee.com>
Date: Thu, 7 Jun 2018 18:05:20 -0600
MIME-Version: 1.0
In-Reply-To: <20180607235735.GA28442@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: dma_alloc_coherent bug in latest ntb_tool changes
To: Serge Semin <fancer.lancer@gmail.com>, Dave Jiang <dave.jiang@intel.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 07/06/18 05:57 PM, Serge Semin wrote:
> The outcome was to use dma_coerce_mask_and_coherent() to set the proper mask
> of the NTB device (copy of PCI-device mask) and use NTB device for DMA allocations.
> My patchset concerned IDT, Intel and AMD hw code only in this matter. The change
> worked for all of them. It wasn't tested on AMDs though, since well to be honest
> we don't even know whether such hardware exists. I can't remember why the Switchtec driver
> wasn't altered. It might be, the code hadn't been merged yet before I sent/prepared
> the patchset.

Well, I kind of agree with Dave and should probably stick with using the
PCI device as we don't know what else all arches need for properly
allocating the DMA memory.

If we want to stick with this solution, I'd suggest we set the coherent
mask in ntb_register given that all the drivers are doing the exact same
thing. Then we won't have to worry about missing one.

> I can't remember why the Switchtec driver
> wasn't altered. It might be, the code hadn't been merged yet before I sent/prepared
> the patchset.

The switchtec driver was in ntb-next well before this patch set
materialized. In fact, the code in kernel v4.15 works fine.

It would have also been nice for this type of change to be in it's own
commit with a full description of the decisions made. Then, when we
bisect to find these issues we don't have to scratch our heads and
wonder what we were thinking.

Logan
