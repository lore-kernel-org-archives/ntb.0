Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id u79-v6si766310vkd.2.2018.07.11.09.52.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Jul 2018 09:52:35 -0700 (PDT)
References: <20180711163224.30892-1-fancer.lancer@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <58db6cb1-c62e-bedd-6542-9a0e40e3dd86@deltatee.com>
Date: Wed, 11 Jul 2018 10:52:29 -0600
MIME-Version: 1.0
In-Reply-To: <20180711163224.30892-1-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb: idt: Set PCIe bus address to BARLIMITx
To: Serge Semin <fancer.lancer@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 11/07/18 10:32 AM, Serge Semin wrote:
> @@ -1320,7 +1321,9 @@ static int idt_ntb_peer_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
>  		idt_nt_write(ndev, bar->ltbase, (u32)addr);
>  		idt_nt_write(ndev, bar->utbase, (u32)(addr >> 32));
>  		/* Set the custom BAR aperture limit */
> -		limit = pci_resource_start(ntb->pdev, mw_cfg->bar) + size;
> +		pcibios_resource_to_bus(ntb->pdev->bus, &region,
> +					&ntb->pdev->resource[mw_cfg->bar]);
> +		limit = region.start + size;

You should use the pci_bus_address() helper instead. It's much simpler
and you don't need to delve into pci_dev internals to use it.

Logan
