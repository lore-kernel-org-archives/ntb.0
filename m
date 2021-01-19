Return-Path: <helgaas@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id k4si220718oib.1.2021.01.19.10.34.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Jan 2021 10:34:17 -0800 (PST)
Date: Tue, 19 Jan 2021 12:34:15 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v9 17/17] Documentation: PCI: Add userguide for PCI
 endpoint NTB function
Message-ID: <20210119181852.GA2495234@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210104152909.22038-18-kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jan 04, 2021 at 08:59:09PM +0530, Kishon Vijay Abraham I wrote:
> Add documentation to help users use pci-epf-ntb function driver and
> existing host side NTB infrastructure for NTB functionality.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  Documentation/PCI/endpoint/index.rst         |   1 +
>  Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
> 
> diff --git a/Documentation/PCI/endpoint/index.rst b/Documentation/PCI/endpoint/index.rst
> index 9cb6e5f3c4d5..38ea1f604b6d 100644
> --- a/Documentation/PCI/endpoint/index.rst
> +++ b/Documentation/PCI/endpoint/index.rst
> @@ -12,6 +12,7 @@ PCI Endpoint Framework
>     pci-test-function
>     pci-test-howto
>     pci-ntb-function
> +   pci-ntb-howto
>  
>     function/binding/pci-test
>     function/binding/pci-ntb
> diff --git a/Documentation/PCI/endpoint/pci-ntb-howto.rst b/Documentation/PCI/endpoint/pci-ntb-howto.rst
> new file mode 100644
> index 000000000000..b6e1073c9a39
> --- /dev/null
> +++ b/Documentation/PCI/endpoint/pci-ntb-howto.rst
> @@ -0,0 +1,160 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +===================================================================
> +PCI Non-Transparent Bridge (NTB) Endpoint Function (EPF) User Guide
> +===================================================================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
> +
> +This document is a guide to help users use pci-epf-ntb function driver
> +and ntb_hw_epf host driver for NTB functionality. The list of steps to
> +be followed in the host side and EP side is given below. For the hardware
> +configuration and internals of NTB using configurable endpoints see
> +Documentation/PCI/endpoint/pci-ntb-function.rst
> +
> +Endpoint Device
> +===============
> +
> +Endpoint Controller Devices
> +---------------------------
> +
> +For implementing NTB functionality at least two endpoint controller devices
> +are required.
> +To find the list of endpoint controller devices in the system::

Is the above one paragraph or two?  Reflow or add blank line as
appropriate.
