Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com. [2a00:1450:4864:20::234])
        by gmr-mx.google.com with ESMTPS id 64si153578wma.1.2019.01.31.01.54.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 01:54:44 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id v15-v6so2058712ljh.13
        for <linux-ntb@googlegroups.com>; Thu, 31 Jan 2019 01:54:44 -0800 (PST)
Return-Path: <fomichev.ru@gmail.com>
Date: Thu, 31 Jan 2019 12:54:41 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: Re: [RFC PATCH] ntb core: copy device archdata on create
Message-ID: <20190131095439.cyfqw6ymjlmgtykk@alfbook-pro.local>
References: <20190130112058.h5qhboivcbkt3itl@alfbook-pro.local>
 <3cf50650-f105-cacb-69ae-ca79a7e4af9e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3cf50650-f105-cacb-69ae-ca79a7e4af9e@deltatee.com>
To: linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>, linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 30, 2019 at 10:25:27AM -0700, Logan Gunthorpe wrote:
> 
> I think you're just playing wack-a-mole at this point and this is not a
> good solution as the IOMMU implementations still may not know exactly
> what device this is or which IOMMU group we are in. So unless we want to
> audit all the IOMMU drivers we shouldn't bother.
> 
> We should revert back to using the pci device for DMA allocations and I
> already posted a patch for that here [1].
> 
> Logan
> 
> [1]
> https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/T/#u
> 

Thanks, Logan. I'll test your solution ASAP.
However I think it's better to separate your patch into "use pci device
struct" part and "move dma_coerce_mask_and_coherent() to ntb core" part.
Especially since the latter is still under discussion.

-- 
Regards,
  Alexander
