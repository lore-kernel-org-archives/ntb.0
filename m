Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id s18-v6si501532pfh.0.2018.06.07.17.33.58
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 07 Jun 2018 17:33:58 -0700 (PDT)
References: <e4743cee-5c10-4e16-5b8a-2090db3f9791@deltatee.com>
 <0a9adce4-dd06-652d-19ae-72929fa386f6@intel.com>
 <20180607235735.GA28442@mobilestation>
 <a607b7b3-fa69-4b8b-7b1e-ae9759ea54f8@deltatee.com>
 <20180608002429.GC28442@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <12929abd-14e8-2acb-ad58-8d82e4e7c28b@deltatee.com>
Date: Thu, 7 Jun 2018 18:33:48 -0600
MIME-Version: 1.0
In-Reply-To: <20180608002429.GC28442@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: dma_alloc_coherent bug in latest ntb_tool changes
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, linux-ntb <linux-ntb@googlegroups.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 07/06/18 06:24 PM, Serge Semin wrote:
> You also said:
>>> It seems cleaner to use the NTB device but then we at least have to set the
>>> coherent_mask to something sane ...
> It doesn't seem clearer now?

It still seems cleaner... But I'm not convinced it's safe. I'm on the
fence really.

> Only hardware driver knows what dma address range is supported by device. 

Well given that all the hardware drivers only copy what's set in the pci
device I don't think that applies.

> Regarding the ntb_register_device(). Since all the currently supported NTB devices
> are PCIe-based, we can temporarily move the coherency mask setting to ntb.c. But
> NTB API is still an abstraction, so I wouldn't do this, since there might be
> non-PCIe-based devices.

NTB is a long way from being non-pci based. Especially seeing it's a PCI
standard. If and when that day comes where someone wants to create some
non-PCI NTB we'd probably have an ntb_register for pci devices and one
for other devices -- but then it's that person's problem. The general
rule of thumb for kernel development is not to write code for an
imagined future but to write good code for now.
> You don't have to:
> https://github.com/torvalds/linux/commit/417cf39cfea9c680aa7c278c8d8a0ca879cacf0a#diff-4cc577115709fbd1fb24e8803f9d629d

That's the commit that fixed an issue. It didn't cause the issue or even
talk about the change that would break it. Nor did it come up when a
bisect was done. That's why changes should be done in small chunks. It
would be different if there was a commit that made the change from pdevs
to ntb devs right after this commit explaining the consequences and that
it was fixed in the previous commit.

Logan

