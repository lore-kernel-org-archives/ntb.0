Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g70si870312ywh.3.2017.12.11.12.38.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 12:38:36 -0800 (PST)
References: <20171209000217.18366-1-logang@deltatee.com>
 <20171209000217.18366-2-logang@deltatee.com>
 <000201d37290$81605eb0$84211c10$@dell.com>
 <d06cf74e-125c-6281-9361-22bac3468251@deltatee.com>
 <000301d372b4$b6042100$220c6300$@dell.com>
 <2ec869d2-caca-e283-b7b5-a28b5908a4db@deltatee.com>
 <000401d372bb$84a34620$8de9d260$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <7367b046-e1ce-3840-7376-60092486439c@deltatee.com>
Date: Mon, 11 Dec 2017 13:38:32 -0700
MIME-Version: 1.0
In-Reply-To: <000401d372bb$84a34620$8de9d260$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer
 in mw_set_trans()
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 11/12/17 01:06 PM, Allen Hubbe wrote:
> In switchtec_ntb_mw_get_align, for the lut case it seems to require alignment the same as Intel, aligned to mw size, but for the non-lut case you are saying that SZ_4K is not necessarily correct.  The SZ_4K is the minimum, but the actual alignment restriction depends on the size of the buffer actually translated.  Right?

Yes, that is correct.

> Also, for the lut case, it looks like the size also has to be the same size as the mw.  So, a client can't allocate a smaller buffer, assume we can get one that is aligned, point the start of the mw at it, and limit the size of the mw?

The LUT case is much simpler. The size must be exactly 64K (as chosen by 
the driver... it may be a module parameter later) and therefore the 
alignment must also be exactly 64k.

> For the non-lut case I wonder, with the restriction that addr needs to be aligned to the size of the buffer, does the size of the buffer also need to be some power of two?  That would make sense, if it determines the alignment.  If so, SZ_4K wouldn't be correct for size_align, either.

It would be weird not to make the size a power of two but this is not a 
requirement of the hardware. The alignment must be the next highest 
power of two after the size. For example, you could have a 768KB buffer 
but it would need to be aligned to 1M. This is how dma_alloc_coherent() 
behaves as well.

Think of it this way: in the hardware we program the number of 
translation bits (xlate_pos in the code). That number of low bits in the 
destination address are replaced with the same bits in the source 
address. So if any of the translated bits in the destination address 
were not zero, they will be after the replacement. Do you know if Intel 
hardware does something similar?

> Do you need the intended buffer size passed in as another parameter to ntb_mw_get_align?  The point of ntb_mw_get_align is to figure out all the alignment restrictions before allocating memory.

We could, but I don't really see the point of doing that. There's really 
nothing the client would/could do differently if we added that. Remember 
this restriction is already (mostly) satisfied by dma_alloc_coherent and 
if that wasn't the case then all the tricks that the client currently 
does to try and obey ntb_mw_get_align would not work.

Actually, if we were going to change anything, I'd suggest creating an 
API that's something like:

void *ntb_mw_alloc(struct ntb_dev *ntb, int pidx, int widx,
     size_t buf_size, dma_addr_t *dma_addr, int flags);

This would do the DMA allocation and adjust the size as necessary to 
satisfy the alignment requirements.

Then there would be a common place that enforces the alignment issues 
instead of expecting every client to get that right. Takes a lot of the 
boiler plate out of the clients as well.

Logan
