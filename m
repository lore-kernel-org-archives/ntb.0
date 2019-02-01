Return-Path: <joro@8bytes.org>
Received: from theia.8bytes.org (8bytes.org. [81.169.241.247])
        by gmr-mx.google.com with ESMTPS id k39si332958wre.2.2019.02.01.08.44.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 01 Feb 2019 08:44:02 -0800 (PST)
Date: Fri, 1 Feb 2019 17:44:01 +0100
From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 1/9] iommu/vt-d: Allow interrupts from the entire bus for
 aliased devices
Message-ID: <20190201164401.GT32526@8bytes.org>
References: <20190131185656.17972-1-logang@deltatee.com>
 <20190131185656.17972-2-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131185656.17972-2-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, David Woodhouse <dwmw2@infradead.org>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 31, 2019 at 11:56:48AM -0700, Logan Gunthorpe wrote:
> @@ -394,6 +402,10 @@ static int set_msi_sid(struct irte *irte, struct pci_dev *dev)
>  		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
>  			     PCI_DEVID(PCI_BUS_NUM(data.alias),
>  				       dev->bus->number));
> +	else if (data.count >= 2 && data.busmatch_count == data.count)
> +		set_irte_sid(irte, SVT_VERIFY_BUS, SQ_ALL_16,
> +			     PCI_DEVID(dev->bus->number,
> +				       dev->bus->number));

The dev->bus->number argument for the devfn parameter of PCI_DEVID is
not needed, right?

Also, this requires at least a comment to document that special case.


	Joerg
