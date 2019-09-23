Return-Path: <jdmason@kudzu.us>
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com. [2607:f8b0:4864:20::d42])
        by gmr-mx.google.com with ESMTPS id h184si869123vka.3.2019.09.23.15.12.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 15:12:41 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id n197so37412149iod.9
        for <linux-ntb@googlegroups.com>; Mon, 23 Sep 2019 15:12:41 -0700 (PDT)
MIME-Version: 1.0
References: <55f2fb85-9d4d-f78d-e6dd-70b09d7667e4@infradead.org>
In-Reply-To: <55f2fb85-9d4d-f78d-e6dd-70b09d7667e4@infradead.org>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 23 Sep 2019 15:12:30 -0700
Message-ID: <CAPoiz9zWo+LuzWG29kSYCrs9FdwvzDycWBEmg_GHL3W5c3QRuQ@mail.gmail.com>
Subject: Re: [PATCH] NTB: fix IDT Kconfig typos/spellos
Content-Type: text/plain; charset="UTF-8"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ntb <linux-ntb@googlegroups.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Sep 18, 2019 at 1:58 PM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> From: Randy Dunlap <rdunlap@infradead.org>
>
> Fix typos in drivers/ntb/hw/idt/Kconfig.
> Use consistent spelling and capitalization.
>
> Fixes: bf2a952d31d2 ("NTB: Add IDT 89HPESxNTx PCIe-switches support")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: Serge Semin <fancer.lancer@gmail.com>
> Cc: linux-ntb@googlegroups.com

Pulled into the ntb branch.

Thanks,
Jon

> ---
>  drivers/ntb/hw/idt/Kconfig |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> --- lnx-53.orig/drivers/ntb/hw/idt/Kconfig
> +++ lnx-53/drivers/ntb/hw/idt/Kconfig
> @@ -4,11 +4,11 @@ config NTB_IDT
>         depends on PCI
>         select HWMON
>         help
> -        This driver supports NTB of cappable IDT PCIe-switches.
> +        This driver supports NTB of capable IDT PCIe-switches.
>
>          Some of the pre-initializations must be made before IDT PCIe-switch
> -        exposes it NT-functions correctly. It should be done by either proper
> -        initialisation of EEPROM connected to master smbus of the switch or
> +        exposes its NT-functions correctly. It should be done by either proper
> +        initialization of EEPROM connected to master SMbus of the switch or
>          by BIOS using slave-SMBus interface changing corresponding registers
>          value. Evidently it must be done before PCI bus enumeration is
>          finished in Linux kernel.
>
>
