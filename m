Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i15-v6si1862020pfa.5.2018.05.24.10.51.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 May 2018 10:51:06 -0700 (PDT)
References: <20180524173913.4506-1-logang@deltatee.com>
 <b2481367-3acc-4d54-bae7-cc27fb38232e@infradead.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2ab7b5f8-f068-026a-bc79-5c589dcdb07e@deltatee.com>
Date: Thu, 24 May 2018 11:51:03 -0600
MIME-Version: 1.0
In-Reply-To: <b2481367-3acc-4d54-bae7-cc27fb38232e@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] PCI: Expand documentation for pci_add_dma_alias()
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>, Doug Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>



On 24/05/18 11:44 AM, Randy Dunlap wrote:
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index dbfe7c4f3776..1c0c1ea23b90 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>>   * @dev: the PCI device for which alias is added
>>   * @devfn: alias slot and function
>>   *
>> - * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
>> - * It should be called early, preferably as PCI fixup header quirk.
>> + * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
>> + * which is used to program permissible BDF source addresses for DMA
> 
> It took me a few seconds to decode BDF.  FWIW, I would prefer to see
> bus-devfn or bus-dev-fn or bus-dev-func or bus-dev-function.

Yes, there's a lot of overlapping terminology here. In circles I've
discussed this stuff, BDF is a common acronym. The kernel uses
Bus/Slot/Function in some places, but devfn is also common. In any case,
I like bus-devfn so I'll make these changes and send a v3 shortly.

Thanks,

Logan
