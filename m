Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id b5si88915lfa.0.2020.09.18.09.15.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 09:15:17 -0700 (PDT)
Subject: Re: [PATCH v5 14/17] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-15-kishon@ti.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
Date: Fri, 18 Sep 2020 09:15:03 -0700
MIME-Version: 1.0
In-Reply-To: <20200918064227.1463-15-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
> new file mode 100644
> index 000000000000..6197d1aab344
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/Kconfig
> @@ -0,0 +1,6 @@
> +config NTB_EPF
> +	tristate "Generic EPF Non-Transparent Bridge support"
> +	depends on m
> +	help
> +	  This driver supports EPF NTB on configurable endpoint.
> +	  If unsure, say N.

Hi,
Why is this driver restricted to 'm' (loadable module)?
I.e., it cannot be builtin.

thanks.
-- 
~Randy

