Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y133si562072qka.3.2019.02.01.09.27.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 09:27:41 -0800 (PST)
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-2-logang@deltatee.com>
 <20190201164401.GT32526@8bytes.org>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
Date: Fri, 1 Feb 2019 10:27:29 -0700
MIME-Version: 1.0
In-Reply-To: <20190201164401.GT32526@8bytes.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus for
 aliased devices
To: Joerg Roedel <joro@8bytes.org>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-ntb.googlegroups.com>



On 2019-02-01 9:44 a.m., Joerg Roedel wrote:
> On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe wrote:
>> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>>  		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
>>  			     PCI_DEVID(PCI_BUS_NUM(data.alias),
>>  				       dev->bus->number));
>> +	else if (data.count >= 2 && data.busmatch_count == data.count)
>> +		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
>> +			     PCI_DEVID(dev->bus->number,
>> +				       dev->bus->number));
> 
> The dev->bus->number argument for the devfn parameter of PCI_DEVID is
> not needed, right?

Oh, yes. I think you are right.

> Also, this requires at least a comment to document that special case.

I'll add a comment for v2.

Thanks for the review!

Logan
