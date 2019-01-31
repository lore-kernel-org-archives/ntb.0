Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r7si259785pls.0.2019.01.31.14.52.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 31 Jan 2019 14:52:21 -0800 (PST)
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-3-logang@deltatee.com>
 <20190131223932.GR229773@google.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <74993e67-cdc5-234a-d26c-5c0177a0299a@deltatee.com>
Date: Thu, 31 Jan 2019 15:52:09 -0700
MIME-Version: 1.0
In-Reply-To: <20190131223932.GR229773@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/9] PCI/MSI: Support allocating virtual MSI interrupts
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <marc.zyngier@arm.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-01-31 3:39 p.m., Bjorn Helgaas wrote:
> I assume you'll merge this along with the rest of the series, so:
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 784fb52b9900..6458ab049852 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -88,6 +88,7 @@ struct msi_desc {
>>  				__u8	multi_cap	: 3;
>>  				__u8	maskbit		: 1;
>>  				__u8	is_64		: 1;
>> +				__u8    is_virtual      : 1;
> 
> You did the right thing by using the same style as what's already
> here, but does anybody know why are we using __u8 and __u16 here?
> 
> Those typedefs are in include/uapi/asm-generic/int-l64.h, which
> suggests they're for things exported to user space, but I don't think
> that's the case here, so I'm wondering if we could someday replace
> these with u8 and u16.  Obviously that wouldn't be part of *this*
> series.

Yes, I was also confused by this. But I always follow the "when-in-rome"
rule. My understanding is the same as yours is that __u8 should be used
for userspace compatibility which doesn't apply here. If there is
consensus on this being wrong, I'd be happy to write a cleanup patch
that fixes it separate from this series.
>> +/*
>> + * Virtual interrupts allow for more interrupts to be allocated
>> + * than the device has interrupts for. These are not programmed
>> + * into the devices MSI-X table and must be handled by some
> 
> s/devices/device's/

Fixed for when I send v2.

Logan
