Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id p16si120972plo.1.2019.01.30.09.25.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 30 Jan 2019 09:25:31 -0800 (PST)
References: <20190130112058.h5qhboivcbkt3itl@alfbook-pro.local>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <3cf50650-f105-cacb-69ae-ca79a7e4af9e@deltatee.com>
Date: Wed, 30 Jan 2019 10:25:27 -0700
MIME-Version: 1.0
In-Reply-To: <20190130112058.h5qhboivcbkt3itl@alfbook-pro.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [RFC PATCH] ntb core: copy device archdata on create
To: Alexander Fomichev <fomichev.ru@gmail.com>, linux-ntb@googlegroups.com
Cc: linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-30 4:20 a.m., Alexander Fomichev wrote:
> On non-x86 platforms, e.g. PowerPC, struct device's archdata field is used to
> store DMA-related sensitive information. Meanwhile NTB subsystem doesn't copy
> that field when creates a child device. Therefore dma_alloc_coherent() fails on
> PowerPC. As a result ntb_tool doesn't work.
> This is the possible solution.

I think you're just playing wack-a-mole at this point and this is not a
good solution as the IOMMU implementations still may not know exactly
what device this is or which IOMMU group we are in. So unless we want to
audit all the IOMMU drivers we shouldn't bother.

We should revert back to using the pci device for DMA allocations and I
already posted a patch for that here [1].

Logan

[1]
https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/T/#u

> ---
>  drivers/ntb/ntb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
> index 2581ab7..e690987 100644
> --- a/drivers/ntb/ntb.c
> +++ b/drivers/ntb/ntb.c
> @@ -114,6 +114,7 @@ int ntb_register_device(struct ntb_dev *ntb)
>  	ntb->dev.bus = &ntb_bus;
>  	ntb->dev.parent = &ntb->pdev->dev;
>  	ntb->dev.release = ntb_dev_release;
> +	ntb->dev.archdata = ntb->pdev->dev.archdata;
>  	dev_set_name(&ntb->dev, "%s", pci_name(ntb->pdev));
>  
>  	ntb->ctx = NULL;
> 
