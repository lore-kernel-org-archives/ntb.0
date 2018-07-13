Return-Path: <allenbh@gmail.com>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id q17-v6si795308lfc.4.2018.07.13.11.31.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jul 2018 11:31:54 -0700 (PDT)
Received: by mail-wm0-x235.google.com with SMTP id s9-v6so2327795wmh.3
        for <linux-ntb@googlegroups.com>; Fri, 13 Jul 2018 11:31:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180711163224.30892-1-fancer.lancer@gmail.com> <20180711204051.26139-1-fancer.lancer@gmail.com>
In-Reply-To: <20180711204051.26139-1-fancer.lancer@gmail.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Fri, 13 Jul 2018 14:31:43 -0400
Message-ID: <CAJ80savarHn+aoo7bQqwREjebS8=XU4h6jUkTUJDqBRTb8CW-Q@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: idt: Set PCIe bus address to BARLIMITx
Content-Type: text/plain; charset="UTF-8"
To: fancer.lancer@gmail.com
Cc: Jon Mason <jdmason@kudzu.us>, dave.jiang@intel.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jul 11, 2018 at 4:40 PM Serge Semin <fancer.lancer@gmail.com> wrote:
> IDT NTB driver sets the upper limit of actual translation address
> being written to the corresponding memory window setup. It is achieved
> by BARLIMITx register initialization. Needless to say, that the register
> works within PCIe bus address space.
>
> In general CPU and PCIe address spaces are different. It means,
> that addresses used for Memory TLPs routine can be different from
> CPU addresses. While in most of cases they are the same, there are
> exceptions when the proper mapping must be performed to have the
> portable driver code. There used to be a virt_to_bus()/bus_to_virt()
> interface for this purpose. But it's deprecated now. It was also a
> mistake to use pci_resource_start() since the return address of the
> method is at the CPU address space. In order to achieve the desired
> purpose we need to use pci_bus_address() helper. This method shall
> return a PCIe bus base address of the corresponding BAR resource.
>
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Acked-by: Allen Hubbe <allenbh@gmail.com>

>
> ---
>
> Changelog v2:
> - Replace pcibios_resource_to_bus() with pci_bus_address() helper.
>
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index dbe72f116017..fb2c44ac9c69 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -1320,7 +1320,7 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>                 idt_nt_write(ndev, bar->ltbase, (u32)addr);
>                 idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
>                 /* Set the custom BAR aperture limit */
> -               limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
> +               limit = pci_bus_address(ntb->pdev, mw_cfg->bar) + size;
>                 idt_nt_write(ndev, bar->limit, (u32)limit);
>                 if (IS_FLD_SET(BARSETUP_TYPE, data, 64))
>                         idt_nt_write(ndev, (bar + 1)->limit, (limit >> 32));
> --
> 2.12.0
