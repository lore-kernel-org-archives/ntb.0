Return-Path: <willy@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org. [2607:7c80:54:e::133])
        by gmr-mx.google.com with ESMTPS id gv9si241476pjb.3.2020.06.11.08.13.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 08:13:18 -0700 (PDT)
Date: Thu, 11 Jun 2020 08:13:01 -0700
From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 01/14] Documentation: PCI: Add specification for the
 *PCI NTB* function device
Message-ID: <20200611151301.GB8681@bombadil.infradead.org>
References: <20200611130525.22746-1-kishon@ti.com>
 <20200611130525.22746-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200611130525.22746-2-kishon@ti.com>
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jun 11, 2020 at 06:35:12PM +0530, Kishon Vijay Abraham I wrote:
> +++ b/Documentation/PCI/endpoint/pci-ntb-function.rst
> @@ -0,0 +1,344 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=================
> +PCI NTB Function
> +=================
> +
> +:Author: Kishon Vijay Abraham I <kishon@ti.com>
> +
> +PCI NTB Function allows two different systems (or hosts) to communicate
> +with each other by configurig the endpoint instances in such a way that
> +transactions from one system is routed to the other system.

At no point in this document do you expand "NTB" into Non-Transparent
Bridge.  The above paragraph probably also needs to say something like "By
making each host appear as a device to the other host".  Although maybe
that's not entirely accurate?  It's been a few years since I last played
with NTBs.

So how about the following opening paragraph:

PCI Non Transparent Bridges (NTB) allow two host systems to communicate
with each other by exposing each host as a device to the other host.
NTBs typically support the ability to generate interrupts on the remote
machine, expose memory ranges as BARs and perform DMA.  They also support
scratchpads which are areas of memory within the NTB that are accessible
from both machines.

... feel free to fix that up if my memory is out of date or corrupted.
