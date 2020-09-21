Return-Path: <kishon@ti.com>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com. [198.47.19.141])
        by gmr-mx.google.com with ESMTPS id m3si867892otk.4.2020.09.20.21.35.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Sep 2020 21:35:06 -0700 (PDT)
Subject: Re: [PATCH v5 12/17] PCI: endpoint: Add EP function driver to provide
 NTB functionality
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-13-kishon@ti.com>
 <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <b79f760b-0641-0e14-375b-df89588405b6@ti.com>
Date: Mon, 21 Sep 2020 10:04:45 +0530
MIME-Version: 1.0
In-Reply-To: <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Randy,

On 18/09/20 9:47 pm, Randy Dunlap wrote:
> On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
>> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
>> index 8820d0f7ec77..55ac7bb2d469 100644
>> --- a/drivers/pci/endpoint/functions/Kconfig
>> +++ b/drivers/pci/endpoint/functions/Kconfig
>> @@ -12,3 +12,15 @@ config PCI_EPF_TEST
>>  	   for PCI Endpoint.
>>  
>>  	   If in doubt, say "N" to disable Endpoint test driver.
>> +
>> +config PCI_EPF_NTB
>> +	tristate "PCI Endpoint NTB driver"
>> +	depends on PCI_ENDPOINT
>> +	help
>> +	   Select this configuration option to enable the NTB driver
>> +	   for PCI Endpoint. NTB driver implements NTB controller
>> +	   functionality using multiple PCIe endpoint instances. It
>> +	   can support NTB endpoint function devices created using
>> +	   device tree.
> 
> Indent help text with one tab + 2 spaces...
> according to coding-style.rst.

Okay, will fix this.

Thanks
Kishon
