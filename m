Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id j1-v6si367235qkk.2.2018.05.17.08.48.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 17 May 2018 08:48:14 -0700 (PDT)
References: <1526558413-23113-1-git-send-email-dmeyer@gigaio.com>
 <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a0997fec-ba06-0d1d-a43d-fcc1600484f5@deltatee.com>
Date: Thu, 17 May 2018 09:48:04 -0600
MIME-Version: 1.0
In-Reply-To: <1526558413-23113-3-git-send-email-dmeyer@gigaio.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] NTB: PCI Quirk to Enable Switchtec NT Functionality
 with IOMMU On
To: dmeyer@gigaio.com, kurt.schwemmer@microsemi.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com
Cc: bhelgaas@google.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Thanks for your hard work on this Doug!

On 17/05/18 06:00 AM, dmeyer@gigaio.com wrote:

> +	if (pci_enable_device(pdev)) {
> +		dev_err(&pdev->dev, "Cannot enable Switchtec device\n");
> +		return;
> +	}

I suspect we should probably cass pci_disable_device() before leaving
this function so it's in the same state we started. Just like we unmap
the mmio.

Logan
