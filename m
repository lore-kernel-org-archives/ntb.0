Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g1-v6si1694016ioc.0.2018.05.23.13.26.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 23 May 2018 13:26:45 -0700 (PDT)
References: <1527106686-18852-1-git-send-email-dmeyer@gigaio.com>
 <1527106686-18852-2-git-send-email-dmeyer@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <553308ee-9c6f-2e1e-1ce8-03b739d1acb0@deltatee.com>
Date: Wed, 23 May 2018 14:26:41 -0600
MIME-Version: 1.0
In-Reply-To: <1527106686-18852-2-git-send-email-dmeyer@gigaio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 1/2] NTB: Migrate PCI Constants to Cannonical PCI
 Header
To: dmeyer@gigaio.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 23/05/18 02:18 PM, dmeyer@gigaio.com wrote:
> +#define PCI_DEVICE_ID_MICROSEMI_PFX24XG3	0x8531

I think Bjorn asked not to add the device IDs to the pci_ids.h and to
just use the raw IDs in quirks.h. switchtec.c already uses the raw values.

Besides that, it looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>


