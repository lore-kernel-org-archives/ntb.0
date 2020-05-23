Return-Path: <kishon@ti.com>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com. [198.47.23.248])
        by gmr-mx.google.com with ESMTPS id 137si790164vkw.5.2020.05.22.18.48.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2020 18:48:03 -0700 (PDT)
Subject: Re: [PATCH 00/19] Implement NTB Controller using multiple PCI EP
References: <20200514145927.17555-1-kishon@ti.com>
 <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <d0c4c813-2af7-7fd4-e401-6fd5de69d4e4@ti.com>
Date: Sat, 23 May 2020 07:17:47 +0530
MIME-Version: 1.0
In-Reply-To: <CAL_JsqKxe5FtZfiQKcQFFLOM5F52kx-q8vZspPTXhcWg+3rJvQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Rob Herring <robh+dt@kernel.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, PCI <linux-pci@vger.kernel.org>, Linux Doc Mailing List <linux-doc@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, devicetree@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Rob,

On 5/22/2020 9:41 PM, Rob Herring wrote:
> On Thu, May 14, 2020 at 8:59 AM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>
>> This series is about implementing SW defined NTB using
>> multiple endpoint instances. This series has been tested using
>> 2 endpoint instances in J7 connected to two DRA7 boards. However there
>> is nothing platform specific for the NTB functionality.
>>
>> This was presented in Linux Plumbers Conference. The presentation
>> can be found @ [1]
> 
> I'd like to know why putting this into DT is better than configfs.
> Does it solve some problem? Doing things in userspace is so much
> easier and more flexible than modifying and updating a DT.

It's a lot cleaner to have an endpoint function bound to two different endpoint
controller using device tree than configfs.

+    epf_bus {
+      compatible = "pci-epf-bus";
+
+      func@0 {
+        compatible = "pci-epf-ntb";
+        epcs = <&pcie0_ep>, <&pcie1_ep>;
+        epc-names = "primary", "secondary";
+        reg = <0>;
+        epf,vendor-id = /bits/ 16 <0x104c>;
+        epf,device-id = /bits/ 16 <0xb00d>;
+        num-mws = <4>;
+        mws-size = <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>, <0x0 0x100000>;
+      };

For device tree, just using phandles is enough and the driver can easily parse
DT to get EPCs bound to the endpoint function
+        epcs = <&pcie0_ep>, <&pcie1_ep>;
+        epc-names = "primary", "secondary";

This would be
ln -s functions/pci-epf-ntb/func1 controllers/2900000.pcie-ep/
ln -s functions/pci-epf-ntb/func1 controllers/2910000.pcie-ep/

pci_epc_epf_link() should then maintain the order of EPC bound to EPF and
designate one as PRIMARY_INTERFACE and the second as SECONDARY_INTERFACE.
pci_epf_bind() should be made to behave differently for NTB case.

While the standard properties (like vendorid, deviceid) has configfs entries,
additional logic would be required for adding function specific fields like
num-mws and mws-size above.

While all this support could be added in configfs, it looks simpler to
represent then in DT.

> 
> I don't really think the PCI endpoint stuff is mature enough to be
> putting into DT either.

I think this will anyways come when we have to export real HW peripherals to
the remote HOST using EP controller.

Thanks
Kishon
