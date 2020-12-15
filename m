Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id n20si1044439qta.1.2020.12.15.08.01.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Dec 2020 08:01:39 -0800 (PST)
MIME-Version: 1.0
References: <20201111153559.19050-1-kishon@ti.com> <20201111153559.19050-12-kishon@ti.com>
In-Reply-To: <20201111153559.19050-12-kishon@ti.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 15 Dec 2020 10:01:25 -0600
Message-ID: <CAL_Jsq+iUU0aR950fvQ7+uenBT5MVbCEU9cDg+vfyO=VugpTZA@mail.gmail.com>
Subject: Re: [PATCH v8 11/18] PCI: cadence: Implement ->msi_map_irq() ops
Content-Type: text/plain; charset="UTF-8"
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, PCI <linux-pci@vger.kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Nov 11, 2020 at 9:37 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> Implement ->msi_map_irq() ops in order to map physical address to
> MSI address and return MSI data.
>
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 53 +++++++++++++++++++
>  1 file changed, 53 insertions(+)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 84cc58dc8512..1fe6b8baca97 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -382,6 +382,57 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>         return 0;
>  }
>
> +static int cdns_pcie_ep_map_msi_irq(struct pci_epc *epc, u8 fn,
> +                                   phys_addr_t addr, u8 interrupt_num,
> +                                   u32 entry_size, u32 *msi_data,
> +                                   u32 *msi_addr_offset)
> +{
> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +       u32 cap = CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET;
> +       struct cdns_pcie *pcie = &ep->pcie;
> +       u64 pci_addr, pci_addr_mask = 0xff;
> +       u16 flags, mme, data, data_mask;
> +       u8 msi_count;
> +       int ret;
> +       int i;
> +


> +       /* Check whether the MSI feature has been enabled by the PCI host. */
> +       flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_FLAGS);
> +       if (!(flags & PCI_MSI_FLAGS_ENABLE))
> +               return -EINVAL;
> +
> +       /* Get the number of enabled MSIs */
> +       mme = (flags & PCI_MSI_FLAGS_QSIZE) >> 4;
> +       msi_count = 1 << mme;
> +       if (!interrupt_num || interrupt_num > msi_count)
> +               return -EINVAL;
> +
> +       /* Compute the data value to be written. */
> +       data_mask = msi_count - 1;
> +       data = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSI_DATA_64);
> +       data = data & ~data_mask;
> +
> +       /* Get the PCI address where to write the data into. */
> +       pci_addr = cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_HI);
> +       pci_addr <<= 32;
> +       pci_addr |= cdns_pcie_ep_fn_readl(pcie, fn, cap + PCI_MSI_ADDRESS_LO);
> +       pci_addr &= GENMASK_ULL(63, 2);

Wouldn't all of the above be the same code for any endpoint driver? We
just need endpoint config space accessors for the same 32-bit only
access issues. Not asking for that in this series, but if that's the
direction we should go.

> +
> +       for (i = 0; i < interrupt_num; i++) {
> +               ret = cdns_pcie_ep_map_addr(epc, fn, addr,
> +                                           pci_addr & ~pci_addr_mask,
> +                                           entry_size);
> +               if (ret)
> +                       return ret;
> +               addr = addr + entry_size;
> +       }
> +
> +       *msi_data = data;
> +       *msi_addr_offset = pci_addr & pci_addr_mask;
> +
> +       return 0;
> +}
> +
>  static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
>                                       u16 interrupt_num)
>  {
> @@ -481,6 +532,7 @@ static const struct pci_epc_features cdns_pcie_epc_features = {
>         .linkup_notifier = false,
>         .msi_capable = true,
>         .msix_capable = true,
> +       .align = 256,
>  };
>
>  static const struct pci_epc_features*
> @@ -500,6 +552,7 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>         .set_msix       = cdns_pcie_ep_set_msix,
>         .get_msix       = cdns_pcie_ep_get_msix,
>         .raise_irq      = cdns_pcie_ep_raise_irq,
> +       .map_msi_irq    = cdns_pcie_ep_map_msi_irq,
>         .start          = cdns_pcie_ep_start,
>         .get_features   = cdns_pcie_ep_get_features,
>  };
> --
> 2.17.1
>
