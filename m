Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id x3-v6si565699ybp.5.2018.06.06.09.46.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jun 2018 09:46:02 -0700 (PDT)
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
 <0fe77341-d309-479f-177c-c18b0193926e@intel.com>
 <b6723ca5-2f8b-4fcf-812e-20c4f40c73c2@googlegroups.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <d87bda21-29a6-4ce2-678a-79d07220a089@intel.com>
Date: Wed, 6 Jun 2018 09:46:00 -0700
MIME-Version: 1.0
In-Reply-To: <b6723ca5-2f8b-4fcf-812e-20c4f40c73c2@googlegroups.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
To: vk en <yato.iacs@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On 06/06/2018 02:06 AM, vk en wrote:
> 
> 
> вторник, 5 июня 2018 г., 19:16:48 UTC+3 пользователь dave.jiang написал:
> 
>     On 06/05/2018 01:21 AM, vk en wrote:
>     > 1. I did not find the CBDMA in BIOS, it's not there.
>     > But we wrote to the manufacturer to find out where to find CBDMA.
> 
>     That is pretty unusual. All Intel E5 or higher based Xeon (or whatever
>     the equivalent is now, thanks marketing) has ioatdma (CBDMA). It's a
>     matter of whether your BIOS enable it or not. Of course if your
>     platform
>     has NTB, then you should have the DMA engine as well as they are
>     part of
>     the platform storage extension features. Which Xeon platform are you on
>     and who is your supplier?
> 
>  System Gooxi, Intel® Xeon® E5-2603 v4

Ok yes so you need to inquire with your vendor about your BIOS enabling
to turn the CBDMA devices on. I'm surprised it's not there since it's a
standard feature for E5 and is enabled in the base BIOS code that Intel
provides to BIOS vendors.
