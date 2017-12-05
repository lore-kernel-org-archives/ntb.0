Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h187si49470vke.2.2017.12.05.09.22.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 09:22:02 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-3-fancer.lancer@gmail.com>
 <CAPoiz9xHuhynY-o7U_-ZQdSXsDFZdq7Xju6mC44eMPj9LOotkA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e9555775-f03d-de68-a49f-d0ae0a9fcd5a@deltatee.com>
Date: Tue, 5 Dec 2017 10:21:58 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9xHuhynY-o7U_-ZQdSXsDFZdq7Xju6mC44eMPj9LOotkA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 02/15] NTB: Set dma mask and dma coherent mask to NTB
 devices
To: Jon Mason <jdmason@kudzu.us>, Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 09:51 AM, Jon Mason wrote:
> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
>> The dma_mask and dma_coherent_mask fields of the NTB struct device
>> weren't initialized in hardware drivers. In fact it should be done
>> instead of PCIe interface usage, since NTB clients are supposed to
>> use NTB API only and left unaware of real hardware implementation.
>> In addition to that ntb_device_register() method shouldn't clear
>> the passed ntb_dev structure, since it dma_mask is initialized
>> by hardware drivers.
> 
> This seems like a bug fix.  Should this be broken out of this patch or
> is it not noticed without your changes?

I was digging into this a bit more and in addition to my earlier review 
comments I think the patch is incorrect for a couple reasons:

1) dma_set_mask() (and friends) are meant to inform the kernel of device 
specific restrictions it cannot know. Calling it with the parent PCI 
device's mask seems pointless.

2) Every dma_alloc() call in the NTB subsystem uses the PCI device's 
struct device. This is ugly in itself but until it changes this patch 
does nothing.

Logan

