Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h27si3559515ywk.1.2019.01.09.11.33.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 11:33:40 -0800 (PST)
References: <20190109192233.5752-1-logang@deltatee.com>
 <57aae0aa-fb12-b686-9835-b5dc60d97878@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f0096e1a-4256-98e1-57d8-d18f5b01fbae@deltatee.com>
Date: Wed, 9 Jan 2019 12:33:37 -0700
MIME-Version: 1.0
In-Reply-To: <57aae0aa-fb12-b686-9835-b5dc60d97878@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/8] Fix breakage caused by the NTB multi-port patchset
To: Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-09 12:32 p.m., Dave Jiang wrote:
>> I'm resending this because I've recently found out that the change we
>> made to use the NTB struct device in DMA allocations is wrong and
>> needs to be reverted. Turns out that, when running with an IOMMU,
>> dma_alloc_coherent() will always fail if you pass it the NTB struct
>> device. This is because the device has not been assigned an IOMMU
>> group and the Intel IOMMU at least expect the devices to be on the PCI
>> bus and be able to find a proper bus-dev-fn number through a struct
>> pci device. Therefore, we must revert the change and I've changed
>> patch 2 to do this and remove the no longer necessary DMA mask
>> adjustments.
> 
> For the revert, I think we should cc stable as well.

I agree it should go into stable too. But I thought the fixes tag would
make that happen...

Logan
