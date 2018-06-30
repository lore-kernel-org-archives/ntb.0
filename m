Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id z132-v6si578415vkd.0.2018.06.29.19.04.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Jun 2018 19:04:55 -0700 (PDT)
Date: Fri, 29 Jun 2018 21:04:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v3] PCI: Expand documentation for pci_add_dma_alias()
Message-ID: <20180630020452.GO40928@bhelgaas-glaptop.roam.corp.google.com>
References: <20180530201311.11274-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180530201311.11274-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex.williamson@redhat.com>, Doug Meyer <dmeyer@gigaio.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, May 30, 2018 at 02:13:11PM -0600, Logan Gunthorpe wrote:
> Seeing there's been some confusion about the use of pci_add_dma_alias(),
> expand the comment to describe why it must be called early and how
> early it must be called.
> 
> Also, expand on the purpose of this function and common reasons it would
> be used.
> 
> [The comment was reworded to some extent by Alex Williamson]
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Applied to pci/switchtec for v4.19, thanks!

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Doug Meyer <dmeyer@gigaio.com>
> ---
> 
> v3: Fixed some typos pointed out by Randy
> v2: Reworked the patch with Alex's suggested wording
> 
> drivers/pci/pci.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index dbfe7c4f3776..2d8650253cc9 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5395,8 +5395,19 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
>   * @dev: the PCI device for which alias is added
>   * @devfn: alias slot and function
>   *
> - * This helper encodes 8-bit devfn as bit number in dma_alias_mask.
> - * It should be called early, preferably as PCI fixup header quirk.
> + * This helper encodes an 8-bit devfn as a bit number in dma_alias_mask
> + * which is used to program permissible bus-devfn source addresses for DMA
> + * requests in an IOMMU. These aliases factor into IOMMU group creation
> + * and are useful for devices generating DMA requests beyond or different
> + * from their logical bus-devfn. Examples include device quirks where the
> + * device simply uses the wrong devfn, as well as non-transparent bridges
> + * where the alias may be a proxy for devices in another domain.
> + *
> + * IOMMU group creation is performed during device discovery or addition,
> + * prior to any potential DMA mapping and therefore prior to driver probing
> + * (especially for userspace assigned devices where IOMMU group definition
> + * cannot be left as a userspace activity). DMA aliases should therefore
> + * be configured via quirks, such as the PCI fixup header quirk.
>   */
>  void pci_add_dma_alias(struct pci_dev *dev, u8 devfn)
>  {
> --
> 2.11.0
