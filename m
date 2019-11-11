Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id p78si1263107vkf.0.2019.11.11.08.59.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Nov 2019 08:59:09 -0800 (PST)
References: <1573097913-104555-1-git-send-email-linjiasen@hygon.cn>
 <7ea7ef5d-7e46-396a-8d70-2c6c333a4508@deltatee.com>
 <8973e56c-ccce-2884-f4dc-4d0f8072a948@hygon.cn>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c340cb9e-9dcc-39f7-1e12-198ad2a47861@deltatee.com>
Date: Mon, 11 Nov 2019 09:59:00 -0700
MIME-Version: 1.0
In-Reply-To: <8973e56c-ccce-2884-f4dc-4d0f8072a948@hygon.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] NTB: ntb_perf: Fix address err in perf_copy_chunk
To: Jiasen Lin <linjiasen@hygon.cn>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc: allenbh@gmail.com, dave.jiang@intel.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-11-11 12:51 a.m., Jiasen Lin wrote:
> 
> 
> On 2019/11/9 1:04, Logan Gunthorpe wrote:
>>
>>
>> On 2019-11-06 8:38 p.m., Jiasen Lin wrote:
>>> peer->outbuf is a virtual address which is get by ioremap, it can not
>>> be converted to a physical address by virt_to_page and page_to_phys.
>>> This conversion will result in DMA error, because the destination address
>>> which is converted by page_to_phys is invalid.
>>
>> Hmm, yes, ntb_perf is obviously wrong. I never noticed this, how did
>> this ever work?
>>
> 
> The default value of use_dma which is used to enable DMA engine to 
> measure NTB performance is zero, in other words, DMA engine is not used 
> by default. Thus, olny memcpy_toio is called in perf_copy_chunk and not 
> trigger this bug.
> 
> If we install driver with specified dma-enabled flag like this:
> insmod ntb_perf.ko use_dma=1, this issue will be triggered.

I've definitely tested with use_dma=1 in the past. But it looks like it
was broken by this problematic commit and I must have never personally
run the DMA tests after it:

5648e56d03fa ("NTB: ntb_perf: Add full multi-port NTB API support")

So it's probably worth adding a fixes tag to your patch.

>>> We Save the physical address in perf_setup_peer_mw, it is MMIO address
>>> of NTB BARx. Then fill the destination address of DMA descriptor with
>>> this physical address to guarantee that the address of memory write
>>> requests fall in memory window of NBT BARx.
>>
>> Using the physical address directly is also wrong and will not work in
>> the presence of an IOMMU. You should use dma_map_resource() for this.
>> See what was done in ntb_transport[1].
>>
> 
> Yes, my mistake. I will modify the code according to your suggestion and 
> test it on AMD and HYGON platforms with the IOMMU enabled. Maybe the 
> following patches are relied on, when IOMMU is enabled on AMD and HYGON 
> plartforms.
> 
> https://lore.kernel.org/patchwork/cover/1143155/
> https://lore.kernel.org/patchwork/patch/1143156/
> https://lore.kernel.org/patchwork/patch/1143157/

Thanks!

Logan
