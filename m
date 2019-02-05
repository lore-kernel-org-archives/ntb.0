Return-Path: <jacob.jun.pan@linux.intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id q3si1629159oib.1.2019.02.05.11.17.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 11:17:41 -0800 (PST)
Date: Tue, 5 Feb 2019 11:19:39 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus
 for aliased devices
Message-ID: <20190205111939.6f91739e@jacob-builder>
In-Reply-To: <398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
	<20190131185656.17972-2-logang@deltatee.com>
	<20190201164401.GT32526@8bytes.org>
	<398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-ntb@googlegroups.com, David Woodhouse <dwmw2@infradead.org>, jacob.jun.pan@linux.intel.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, 1 Feb 2019 10:27:29 -0700
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 2019-02-01 9:44 a.m., Joerg Roedel wrote:
> > On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe wrote:  
> >> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte,
> >> struct pci_dev *dev) set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
> >>  			     PCI_DEVID(PCI_BUS_NUM(data.alias),
> >>  				       dev->bus->number));
I guess devfn can be removed also. but that is separate cleanup.
 
> >> +	else if (data.count >= 2 && data.busmatch_count ==
> >> data.count)
> >> +		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
> >> +			     PCI_DEVID(dev->bus->number,
> >> +				       dev->bus->number));  
> > 
> > The dev->bus->number argument for the devfn parameter of PCI_DEVID
> > is not needed, right?  
> 
> Oh, yes. I think you are right.
> 
> > Also, this requires at least a comment to document that special
> > case.  
> 
> I'll add a comment for v2.
> 
> Thanks for the review!
> 
> Logan
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu

[Jacob Pan]
