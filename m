Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id b1si97437wmj.1.2020.09.18.09.18.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:18:00 -0700 (PDT)
Subject: Re: [PATCH v5 12/17] PCI: endpoint: Add EP function driver to provide
 NTB functionality
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-13-kishon@ti.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
Date: Fri, 18 Sep 2020 09:17:54 -0700
MIME-Version: 1.0
In-Reply-To: <20200918064227.1463-13-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 8820d0f7ec77..55ac7bb2d469 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -12,3 +12,15 @@ config PCI_EPF_TEST
>  	   for PCI Endpoint.
>  
>  	   If in doubt, say "N" to disable Endpoint test driver.
> +
> +config PCI_EPF_NTB
> +	tristate "PCI Endpoint NTB driver"
> +	depends on PCI_ENDPOINT
> +	help
> +	   Select this configuration option to enable the NTB driver
> +	   for PCI Endpoint. NTB driver implements NTB controller
> +	   functionality using multiple PCIe endpoint instances. It
> +	   can support NTB endpoint function devices created using
> +	   device tree.

Indent help text with one tab + 2 spaces...
according to coding-style.rst.


> +
> +	   If in doubt, say "N" to disable Endpoint NTB driver.


thanks.
-- 
~Randy

