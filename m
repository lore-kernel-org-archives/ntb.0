Return-Path: <kishon@ti.com>
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com. [198.47.19.141])
        by gmr-mx.google.com with ESMTPS id k18si620606ion.4.2020.09.20.21.52.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Sep 2020 21:52:56 -0700 (PDT)
Subject: Re: [PATCH v5 14/17] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-15-kishon@ti.com>
 <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8b7fa2b-5586-3929-1e00-8473106935f9@ti.com>
Date: Mon, 21 Sep 2020 10:22:42 +0530
MIME-Version: 1.0
In-Reply-To: <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Randy Dunlap <rdunlap@infradead.org>, Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Randy,

On 18/09/20 9:45 pm, Randy Dunlap wrote:
> On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
>> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
>> new file mode 100644
>> index 000000000000..6197d1aab344
>> --- /dev/null
>> +++ b/drivers/ntb/hw/epf/Kconfig
>> @@ -0,0 +1,6 @@
>> +config NTB_EPF
>> +	tristate "Generic EPF Non-Transparent Bridge support"
>> +	depends on m
>> +	help
>> +	  This driver supports EPF NTB on configurable endpoint.
>> +	  If unsure, say N.
> 
> Hi,
> Why is this driver restricted to 'm' (loadable module)?
> I.e., it cannot be builtin.

I'm trying to keep all the host side PCI drivers corresponding to the
devices configured using endpoint function drivers as modules and also
not populate MODULE_DEVICE_TABLE() to prevent auto-loading.

The different endpoint function drivers (right now only pci-epf-test.c
and pci-epf-ntb.c) can use the same device ID and vendorID for
configuring the endpoint devices. So on the host side, it's possible an
un-intended PCI driver can be bound to the device. So in-order to give
users the flexibility of deciding the driver to be bound, I'm trying to
keep it as modules. (Some driver like NTB also uses class code
PCI_CLASS_MEMORY_RAM for binding a driver in addition to deviceID and
vendorID but it need not be the case for all the drivers.)

Thanks
Kishon
