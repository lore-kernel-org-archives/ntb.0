Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id t63-v6si1416105pgd.2.2018.06.05.09.16.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Jun 2018 09:16:48 -0700 (PDT)
Subject: Re: Problem with the connection status (Link-status) after loading
 the driver ntb_hw_intel
References: <e46a0926-7118-4009-886f-c1252cb93d62@googlegroups.com>
 <CAJ80sasPx7HFT2wgD7tMpmEVKPraHg+oQJ-zoUkNyRpnB8to+Q@mail.gmail.com>
 <62e8a338-e07b-4174-927c-f4f70a54949b@googlegroups.com>
 <CAJ80sauCYYOUak+1sQ=3kx_mK10pvL3pLCs_hEq-MPUaNgSD-g@mail.gmail.com>
 <32bfb787-223c-41c1-9df6-3cf57045f918@googlegroups.com>
 <1ed5452b-678e-4881-a82c-182413c12954@googlegroups.com>
 <CAJ80sav0RepYOu+C5-hzVdsKYpzrZuHP0M_Q=h+2P-L1LeUDbA@mail.gmail.com>
 <b05ac043-38ab-7439-1ede-7348f1b7e3bd@intel.com>
 <9058dedf-ec3a-42d4-9eaa-40d95740fcc0@googlegroups.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <0fe77341-d309-479f-177c-c18b0193926e@intel.com>
Date: Tue, 5 Jun 2018 09:16:47 -0700
MIME-Version: 1.0
In-Reply-To: <9058dedf-ec3a-42d4-9eaa-40d95740fcc0@googlegroups.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: vk en <yato.iacs@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 06/05/2018 01:21 AM, vk en wrote:
> 1. I did not find the CBDMA in BIOS, it's not there.
> But we wrote to the manufacturer to find out where to find CBDMA.

That is pretty unusual. All Intel E5 or higher based Xeon (or whatever
the equivalent is now, thanks marketing) has ioatdma (CBDMA). It's a
matter of whether your BIOS enable it or not. Of course if your platform
has NTB, then you should have the DMA engine as well as they are part of
the platform storage extension features. Which Xeon platform are you on
and who is your supplier?


> 2. Empty
> 
> 
> 
> On Monday, 4 June 2018 19:36:43 UTC+3, dave.jiang wrote:
> 
> 
>     ^ So he has the ioatdma driver already loaded.
> 
>     1. Please make sure CBDMA is enabled in your BIOS options? Probably
>     under IIO section.
>     2. Please provide lspci and show if the DMA shows up? i.e.
> 
>     00:04.0 System peripheral: Intel Corporation Xeon E7 v3/Xeon E5 v3/Core
>     i7 DMA Channel 0 (rev 02)
>             Subsystem: Intel Corporation Device 35c8
>             Flags: bus master, fast devsel, latency 0, IRQ 52, NUMA node 0
>             Memory at 383ffff2c000 (64-bit, non-prefetchable) [size=16K]
>             Capabilities: [80] MSI-X: Enable+ Count=1 Masked-
>             Capabilities: [90] Express Root Complex Integrated Endpoint,
>     MSI 00
>             Capabilities: [e0] Power Management version 3
>             Kernel driver in use: ioatdma
>             Kernel modules: ioatdma
> 
> 
> -- 
> You received this message because you are subscribed to the Google
> Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send
> an email to linux-ntb+unsubscribe@googlegroups.com
> <mailto:linux-ntb+unsubscribe@googlegroups.com>.
> To post to this group, send email to linux-ntb@googlegroups.com
> <mailto:linux-ntb@googlegroups.com>.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/9058dedf-ec3a-42d4-9eaa-40d95740fcc0%40googlegroups.com
> <https://groups.google.com/d/msgid/linux-ntb/9058dedf-ec3a-42d4-9eaa-40d95740fcc0%40googlegroups.com?utm_medium=email&utm_source=footer>.
> For more options, visit https://groups.google.com/d/optout.
