Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id p144si139098wme.2.2017.03.06.17.57.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 17:57:36 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id y193so12877892lfd.1
        for <linux-ntb@googlegroups.com>; Mon, 06 Mar 2017 17:57:36 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 7 Mar 2017 04:57:55 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v4] NTB: Add IDT 89HPESxNTx PCIe-switches support
Message-ID: <20170307015755.GA14511@mobilestation.tp-local.ru>
References: <1487933348-32403-1-git-send-email-fancer.lancer@gmail.com>
 <1488187351-12624-1-git-send-email-fancer.lancer@gmail.com>
 <c293fffa-d714-49d3-b0a5-4a1183b5229a@googlegroups.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c293fffa-d714-49d3-b0a5-4a1183b5229a@googlegroups.com>
To: lsgunthorpe@gmail.com
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Thu, Mar 02, 2017 at 10:38:30PM -0800, lsgunthorpe@gmail.com <lsgunthorpe@gmail.com> wrote:

Hello Logan,

> 
> Hi Serge,
> 
> I've done a quick review on your new driver:
>  
> 
> > + * WARNING! IDT PCIe-switch registers are all Little endian. So 
> > corresponding 
> > + *            writel operations must have embedded endiannes conversion. 
> > If local 
> > + *            platform doesn't have it, the driver won't properly work. 
> >
> 
> This warning seems unnecessary. As I understand it, PCI is by convention 
> little 
> endian and writel and friends all swap to little endian (at least their 
> generic version do in include/asm-generic/io.h). 
> So the driver should  already be correct on BE platforms.
>   
> 

I'll just shorten it for small message about endianness.

> > +        /* 
> > +         * It's obvious bug to request a register exceeding the maximum 
> > possible 
> > +         * value as well as to have it unaligned. 
> > +         */ 
> > +        if (WARN_ON(reg > IDT_REG_PCI_MAX || !IS_ALIGNED(reg, 
> > IDT_REG_ALIGN))) 
> > +                return; 
> >
> 
> IMO, This feels like a bit over kill to check this every time you access 
> hardware. It's a static function where most of the calls are constants. In 
> cases when
> they're not constant the value should be checked ahead of time and sane 
> things done instead of printing a stack trace.
> 

Since the driver has just been release, there might be some untested situation
with internal errors. So it would be better to keep it as is for a while.
 
> 
> > +        /* Just write the value to the specified register */ 
> > +        writel(data, ndev->cfgspc + (ptrdiff_t)reg); 
> >
> 
> writel and friends are discouraged for new code. Use iowrite32, et al. See 
> 
> http://www.makelinux.net/ldd3/chp-9-sect-4
>  

Agreed. Replaced with actual methods.

> 
> > +        dev_dbg_pci(ndev, "IDT NT local port: %hhu, num of peers: 
> > %hhu\n", 
> > +                ndev->port, ndev->peer_cnt); 
> >
> 
> Don't do this. Open code it with: dev_dbg(&ndev->ntp.dev...
>  

Agreed. Replaced with traditional dev_*() methods.

> 
> > +        spin_lock_irqsave(&ndev->mtbl_lock, irqflags); 
> > +        idt_nt_write(ndev, IDT_NT_NTMTBLADDR, ndev->part); 
> > +        idt_nt_write(ndev, IDT_NT_NTMTBLDATA, mtbldata); 
> > +        spin_unlock_irqrestore(&ndev->mtbl_lock, irqflags); 
> >
> 
> Why do writes like these need a spin lock? What is that protecting against? 
> What happens if another thread does the same two writes immediately after 
> the unlock?
>  

It's obvious, to prevent a race condition of access to the Mapping table, which
is implemented by Address and Data registers set.
For the same reason the driver have spin lock to protect an access to the
Global Switch registers using GASA-ADDR and GASA-DATA.

> 
> >
> > +        /* Enable MSI interrupts */ 
> > +        ret = pci_enable_msi(pdev); 
> > +        if (ret != 0) { 
> > +                dev_err_pci(ndev, "IDT failed to enable MSI interrupt"); 
> > +                goto err_try_intx; 
> > +        } 
> 
> 
> pci_alloc_irq_vectors could be used to simplify your interrupt enabling. 
> Instead of trying, testing and failing and retrying with INTX, this 
> function does that all for you.
> 

Agreed. It's good idea. Even though my kernel hadn't such functionality.

> +        /* Request corresponding IRQ number */ 
> > +        ret = request_threaded_irq(pdev->irq, NULL, idt_thread_isr, 
> > +                                   IRQF_ONESHOT, NTB_IRQNAME, ndev);  
> 
> 
> It would probably be simpler to use devm_request_threaded_irq then your 
> cleanup path will be simpler.
> 

Agreed. Replaced with the Managed Device Resources version.

> 
> +        /* Request all BARs resources */ 
> > +        ret = pci_request_regions(pdev, NTB_NAME); 
> 
> 
> pcim_iomap_regions_request_all can be used to combine this and the 
> pcim_iompa below it.
> 

Agreed.

> 
> +static void idt_pci_remove(struct pci_dev *pdev) 
> > +{ 
> > +        struct idt_ntb_dev *ndev = pci_get_drvdata(pdev); 
> > + 
> > +        /* Deinit the DebugFS node */ 
> > +        idt_deinit_dbgfs(ndev); 
> > + 
> > +        /* Unregister NTB device */ 
> > +        idt_unregister_device(ndev); 
> > + 
> > +        /* Stop the interrupts handling */ 
> > +        idt_deinit_isr(ndev); 
> > + 
> > +        /* Deinitialize link event subsystem */ 
> > +        idt_deinit_link(ndev); 
> > + 
> > +        /* Deinit basic PCI subsystem */ 
> > +        idt_deinit_pci(ndev); 
> > + 
> > +        /* IDT PCIe-switch NTB driver is finally initialized */ 
> > +        dev_info(&pdev->dev, "IDT NTB device is removed"); 
> > + 
> > +        /* Sayonara... */ 
> 
> 
> I don't see where you kfree ndev the structure... (and it's not done by the 
> ntb device's release code...) so this looks like a memory leak.
> 

Kind of funny. You've sent some comments about devres methods usage, but
suspected a memory leak at the moment where it's actually used. So take a look
at the place of "ndev" structure allocation, and you'll find an answer.

> 
> Logan
> 

Sergey


