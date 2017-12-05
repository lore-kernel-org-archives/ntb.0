Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x244.google.com (mail-ua0-x244.google.com. [2607:f8b0:400c:c08::244])
        by gmr-mx.google.com with ESMTPS id t123si73849vkb.1.2017.12.05.11.12.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 11:12:31 -0800 (PST)
Received: by mail-ua0-x244.google.com with SMTP id l36so1049378uae.4
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 11:12:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171129175530.31032-6-logang@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com> <20171129175530.31032-6-logang@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 14:12:31 -0500
Message-ID: <CAPoiz9zaT+agL3KZEqnx7O2N38dM4QqHKLii_gzqDWXgQu1jyw@mail.gmail.com>
Subject: Re: [PATCH 5/7] ntb_hw_switchtec: Expand PFF CSR registers
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Nov 29, 2017 at 12:55 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> The PFF CSR registers actual mirrors the PCI configuration space
> for all the ports in the switch. Previously, this was not needed by
> the driver but will be used by the crosslink code to enumerate the
> bus in an host-less centre partition.
>
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>  include/linux/switchtec.h | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/switchtec.h b/include/linux/switchtec.h
> index d4a7c18b42cf..6d325a7a0c19 100644
> --- a/include/linux/switchtec.h
> +++ b/include/linux/switchtec.h
> @@ -292,7 +292,20 @@ enum {
>  struct pff_csr_regs {
>         u16 vendor_id;
>         u16 device_id;
> -       u32 pci_cfg_header[15];
> +       u16 pcicmd;
> +       u16 pcists;
> +       u32 pci_class;
> +       u32 pci_opts;
> +       union {
> +               u32 pci_bar[6];
> +               u64 pci_bar64[3];
> +       };
> +       u32 pci_cardbus;
> +       u32 pci_subsystem_id;
> +       u32 pci_expansion_rom;
> +       u32 pci_cap_ptr;
> +       u32 reserved1;
> +       u32 pci_irq;

It sucks that we don't already have a struct for PCI config space we
can reuse here.  If you find the time, it would be good to add in the
future to reduce duplicate code here and in the PCI core.  However,
this patch is fine without it.

Thanks,
Jon


>         u32 pci_cap_region[48];
>         u32 pcie_cap_region[448];
>         u32 indirect_gas_window[128];
> --
> 2.11.0
>
