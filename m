Return-Path: <kishon@ti.com>
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com. [198.47.19.142])
        by gmr-mx.google.com with ESMTPS id y198si144335oie.1.2020.06.11.22.31.07
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Jun 2020 22:31:07 -0700 (PDT)
Subject: Re: [PATCH v2 01/14] Documentation: PCI: Add specification for the
 *PCI NTB* function device
References: <20200611130525.22746-1-kishon@ti.com>
 <20200611130525.22746-2-kishon@ti.com>
 <20200611151301.GB8681@bombadil.infradead.org>
From: Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <c8a5d63a-7026-2b40-4b26-5f4e481f7df4@ti.com>
Date: Fri, 12 Jun 2020 11:00:53 +0530
MIME-Version: 1.0
In-Reply-To: <20200611151301.GB8681@bombadil.infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Matthew Wilcox <willy@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Hi Matthew,

On 6/11/2020 8:43 PM, Matthew Wilcox wrote:
> On Thu, Jun 11, 2020 at 06:35:12PM +0530, Kishon Vijay Abraham I wrote:
>> +++ b/Documentation/PCI/endpoint/pci-ntb-function.rst
>> @@ -0,0 +1,344 @@
>> +.. SPDX-License-Identifier: GPL-2.0
>> +
>> +=================
>> +PCI NTB Function
>> +=================
>> +
>> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
>> +
>> +PCI NTB Function allows two different systems (or hosts) to communicate
>> +with each other by configurig the endpoint instances in such a way that
>> +transactions from one system is routed to the other system.
> 
> At no point in this document do you expand "NTB" into Non-Transparent
> Bridge.  The above paragraph probably also needs to say something like "By
> making each host appear as a device to the other host".  Although maybe
> that's not entirely accurate?  It's been a few years since I last played
> with NTBs.
> 
> So how about the following opening paragraph:
> 
> PCI Non Transparent Bridges (NTB) allow two host systems to communicate
> with each other by exposing each host as a device to the other host.
> NTBs typically support the ability to generate interrupts on the remote
> machine, expose memory ranges as BARs and perform DMA.  They also support
> scratchpads which are areas of memory within the NTB that are accessible
> from both machines.
> 
> ... feel free to fix that up if my memory is out of date or corrupted.

I think that's accurate. I'll wait for review comments on the rest of the
series and I'll fix this one in my next revision.

Thanks
Kishon
