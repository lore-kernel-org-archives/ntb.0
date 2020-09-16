Return-Path: <rdunlap@infradead.org>
Received: from casper.infradead.org (casper.infradead.org. [2001:8b0:10b:1236::1])
        by gmr-mx.google.com with ESMTPS id g5si174009wmi.3.2020.09.16.10.06.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 10:06:04 -0700 (PDT)
Subject: Re: [PATCH v4 17/17] Documentation: PCI: Add userguide for PCI
 endpoint NTB function
References: <20200915042110.3015-1-kishon@ti.com>
 <20200915042110.3015-18-kishon@ti.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <17b7c073-d358-e274-c783-1a17590a83a3@infradead.org>
Date: Wed, 16 Sep 2020 10:05:55 -0700
MIME-Version: 1.0
In-Reply-To: <20200915042110.3015-18-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Kishon Vijay Abraham I <kishon@ti.com>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tom Joseph <tjoseph@cadence.com>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 9/14/20 9:21 PM, Kishon Vijay Abraham I wrote:
> Add documentation to help users use pci-epf-ntb function driver and
> existing host side NTB infrastructure for NTB functionality.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  Documentation/PCI/endpoint/index.rst         |   1 +
>  Documentation/PCI/endpoint/pci-ntb-howto.rst | 160 +++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/PCI/endpoint/pci-ntb-howto.rst
> 

LGTM. Thanks for the update.

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>


-- 
~Randy
