Return-Path: <jacob.jun.pan@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com. [134.134.136.65])
        by gmr-mx.google.com with ESMTPS id j26si264887uag.1.2019.02.05.15.57.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Feb 2019 15:57:00 -0800 (PST)
Date: Tue, 5 Feb 2019 15:58:59 -0800
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus
 for aliased devices
Message-ID: <20190205155859.0e96dd4f@jacob-builder>
In-Reply-To: <d097d98b-0b8b-5b29-c411-a5dc3949a3e7@deltatee.com>
References: <20190131185656.17972-1-logang@deltatee.com>
	<20190131185656.17972-2-logang@deltatee.com>
	<20190201164401.GT32526@8bytes.org>
	<398e6a0a-9cbd-c218-e20e-ed91f74a653d@deltatee.com>
	<20190205111939.6f91739e@jacob-builder>
	<d097d98b-0b8b-5b29-c411-a5dc3949a3e7@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Joerg Roedel <joro@8bytes.org>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, linux-ntb@googlegroups.com, David Woodhouse <dwmw2@infradead.org>, jacob.jun.pan@linux.intel.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, 5 Feb 2019 13:40:36 -0700
Logan Gunthorpe <logang@deltatee.com> wrote:

> On 2019-02-05 12:19 p.m., Jacob Pan wrote:
> > On Fri, 1 Feb 2019 10:27:29 -0700
> > Logan Gunthorpe <logang@deltatee.com> wrote:
> >   
> >> On 2019-02-01 9:44 a.m., Joerg Roedel wrote:  
> >>> On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe
> >>> wrote:    
> >>>> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte,
> >>>> struct pci_dev *dev) set_irte_sid(irte, SVT_VERIFY_BUS,
> >>>> SQ_ALL_16, PCI_DEVID(PCI_BUS_NUM(data.alias),
> >>>>  				       dev->bus->number));  
> > I guess devfn can be removed also. but that is separate cleanup.  
> 
> Actually, no, I've dug into this and we *do* need the devfn here but
> it's needlessly confusing. We should not be using PCI_DEVID() as we
> aren't actually representing a DEVID in this case...
> 
> According to the Intel VT-D spec, when using SVT_VERIFY_BUS, the MSB
> of the SID field represents the starting bus number and the LSB
> represents the end bus number. The requester id's bus number must
> then be within that range. The PCI_DEVID macro matches these
> semantics if you assume the devfn is the end bus, but doesn't really
> make sense here and just confuses the issue.
> 
> So the code was correct, I'll just try to clean it up to make it less
> confusing.
> 
you are right, thanks for explaining.
> Thanks,
> 
> Logan
