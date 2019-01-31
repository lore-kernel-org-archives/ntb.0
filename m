Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 186si203103ybu.3.2019.01.31.09.07.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 09:07:26 -0800 (PST)
References: <20190130112058.h5qhboivcbkt3itl@alfbook-pro.local>
 <3cf50650-f105-cacb-69ae-ca79a7e4af9e@deltatee.com>
 <20190131095439.cyfqw6ymjlmgtykk@alfbook-pro.local>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f5e91ec1-7427-e880-b27a-4d46071df652@deltatee.com>
Date: Thu, 31 Jan 2019 10:07:22 -0700
MIME-Version: 1.0
In-Reply-To: <20190131095439.cyfqw6ymjlmgtykk@alfbook-pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] ntb core: copy device archdata on create
To: Alexander Fomichev <fomichev.ru@gmail.com>, linux-ntb@googlegroups.com
Cc: linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-31 2:54 a.m., Alexander Fomichev wrote:
> On Wed, Jan 30, 2019 at 10:25:27AM -0700, Logan Gunthorpe wrote:
>>
>> I think you're just playing wack-a-mole at this point and this is not a
>> good solution as the IOMMU implementations still may not know exactly
>> what device this is or which IOMMU group we are in. So unless we want to
>> audit all the IOMMU drivers we shouldn't bother.
>>
>> We should revert back to using the pci device for DMA allocations and I
>> already posted a patch for that here [1].
>>
>> Logan
>>
>> [1]
>> https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/T/#u
>>
> 
> Thanks, Logan. I'll test your solution ASAP.
> However I think it's better to separate your patch into "use pci device
> struct" part and "move dma_coerce_mask_and_coherent() to ntb core" part.
> Especially since the latter is still under discussion.

With that patch we are not moving dma_coerce_mask_and_coherent(); we are
removing it.

If we do DMA operations on the PCI device (as is pretty much universal
in other drivers[1]), then we don't need to set the DMA mask for the
virtual device anymore and thus that patch removes that code -- it does
not move it.

Logan

[1] Just grep the kernel for dma_alloc_coherent; you'll find a lot of
users that reference a 'pdev':

$ kgrep dma_alloc_  | grep pdev | wc -l
568
