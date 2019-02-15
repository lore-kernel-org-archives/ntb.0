Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 184si276676iou.3.2019.02.14.21.29.11
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Feb 2019 21:29:11 -0800 (PST)
References: <20190119001001.13087-1-logang@deltatee.com>
 <4bddaad3-14e2-4ceb-90d0-2955ea76b442@googlegroups.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <59788265-b815-f22f-d64d-c120a55ea7e7@deltatee.com>
Date: Thu, 14 Feb 2019 22:29:07 -0700
MIME-Version: 1.0
In-Reply-To: <4bddaad3-14e2-4ceb-90d0-2955ea76b442@googlegroups.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NTB: ntb_transport: Ensure the destination buffer is
 mapped for TX DMA
To: lravich@gmail.com, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 2019-02-14 6:44 a.m., lravich@gmail.com wrote:
> Hi Logan , 
> I took a look on the dma_map_resource() you used in this patch , looks
> like ops->map_resource not implemented for intel 
> if I see it right, this will not fix the issue for Intel NTB .

> Please let me know if I am right 

Yes, but I've already fixed that[1] ;)

Logan

[1]
https://lore.kernel.org/lkml/20190122213045.5667-1-logang@deltatee.com/T/#u
