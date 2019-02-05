Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com. [2a00:1450:4864:20::244])
        by gmr-mx.google.com with ESMTPS id i11si727741wmb.2.2019.02.05.07.47.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 07:47:41 -0800 (PST)
Received: by mail-lj1-x244.google.com with SMTP id n18-v6so3302746lji.7
        for <linux-ntb@googlegroups.com>; Tue, 05 Feb 2019 07:47:41 -0800 (PST)
Return-Path: <fomichev.ru@gmail.com>
Date: Tue, 5 Feb 2019 18:47:38 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: Re: [RFC PATCH] ntb core: copy device archdata on create
Message-ID: <20190205154736.nbt6knoepnc2cfxu@alfbook-pro.local>
References: <20190130112058.h5qhboivcbkt3itl@alfbook-pro.local>
 <3cf50650-f105-cacb-69ae-ca79a7e4af9e@deltatee.com>
 <20190131095439.cyfqw6ymjlmgtykk@alfbook-pro.local>
 <f5e91ec1-7427-e880-b27a-4d46071df652@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5e91ec1-7427-e880-b27a-4d46071df652@deltatee.com>
To: linux-ntb@googlegroups.com, Logan Gunthorpe <logang@deltatee.com>
Cc: linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 31, 2019 at 10:07:22AM -0700, Logan Gunthorpe wrote:
> 
> 
> > On Wed, Jan 30, 2019 at 10:25:27AM -0700, Logan Gunthorpe wrote:
> >>
> >>
> >> We should revert back to using the pci device for DMA allocations and I
> >> already posted a patch for that here [1].
> >>
> >> Logan
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/T/#u
> >>
> > 
> 
> With that patch we are not moving dma_coerce_mask_and_coherent(); we are
> removing it.
> 
> If we do DMA operations on the PCI device (as is pretty much universal
> in other drivers[1]), then we don't need to set the DMA mask for the
> virtual device anymore and thus that patch removes that code -- it does
> not move it.
> 

Sorry, my bad.
It seems to me that using PCI device struct for DMA-related operations is a
preferred solution. No need to play with dma_mask. And also dma_alloc_* works on
powerpc systems as good as on x86.
If Logan's patchset is applied into mainline kernel then my patch will
be unnecessary.

-- 
Regards,
  Alexander
