Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z18si407138iti.0.2017.12.11.09.14.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 09:14:51 -0800 (PST)
References: <20171209000217.18366-1-logang@deltatee.com>
 <20171209000217.18366-2-logang@deltatee.com>
 <000201d37290$81605eb0$84211c10$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d06cf74e-125c-6281-9361-22bac3468251@deltatee.com>
Date: Mon, 11 Dec 2017 10:14:48 -0700
MIME-Version: 1.0
In-Reply-To: <000201d37290$81605eb0$84211c10$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer
 in mw_set_trans()
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 11/12/17 07:58 AM, Allen Hubbe wrote:
> !IS_ALIGNED(addr, BIT_ULL(xlate_pos))
> 

Ok, yes, that's much better. I'll change it. Thanks.

>> +		/*
>> +		 * In certain circumstances we can get a buffer that is
>> +		 * not aligned to its size. (Most of the time
>> +		 * dma_alloc_coherent ensures this). This can happen when
>> +		 * using large buffers allocated by the CMA
>> +		 * (see CMA_CONFIG_ALIGNMENT)
>> +		 */
>> +		dev_err(&sndev->stdev->dev,
>> +			"ERROR: Memory window address is not aligned to it's size!\n");
> 
> This would be the only ntb hw driver that prints an error in this situation.  The ntb_mw_get_align() should provide enough information to client drivers to determine the alignment requirements before calling ntb_mw_set_trans().  IMO no need to print here, but let's see what others say.


mw_get_align doesn't communicate the fact that the buffer has to be 
aligned by its size. It may also be that all hardware does not have this 
restriction (ie. if the hardware adds to the base address instead of 
just replacing the lower bits).

There is definitely a need to print this error somewhere as I hit this 
case and it caused very weird behavior. It was a huge pain to debug. 
Also, it's a security issue and huge bug if we end up mapping the memory 
we didn't think we were mapping. I don't think it's a good idea for us 
to require clients to check this as that requires a number of checks and 
a client author may forget to add it to their driver. I'd maybe go with 
a check in ntb_mw_set_trans before calling the driver, but that only 
makes sense if all hardware has the same requirement.

Logan
