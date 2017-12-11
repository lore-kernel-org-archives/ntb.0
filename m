Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z13si574002pfe.2.2017.12.11.11.28.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Dec 2017 11:28:40 -0800 (PST)
References: <20171209000217.18366-1-logang@deltatee.com>
 <20171209000217.18366-2-logang@deltatee.com>
 <000201d37290$81605eb0$84211c10$@dell.com>
 <d06cf74e-125c-6281-9361-22bac3468251@deltatee.com>
 <000301d372b4$b6042100$220c6300$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2ec869d2-caca-e283-b7b5-a28b5908a4db@deltatee.com>
Date: Mon, 11 Dec 2017 12:28:34 -0700
MIME-Version: 1.0
In-Reply-To: <000301d372b4$b6042100$220c6300$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 2/2] ntb_hw_switchtec: Check for alignment of the buffer
 in mw_set_trans()
To: Allen Hubbe <Allen.Hubbe@dell.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: 'Jon Mason' <jdmason@kudzu.us>
List-ID: <linux-ntb.googlegroups.com>



On 11/12/17 12:17 PM, Allen Hubbe wrote:
> From: Logan Gunthorpe
> 
>> mw_get_align doesn't communicate the fact that the buffer has to be
>> aligned by its size.
> 
> Is that not the purpose of the addr_align out parameter of ntb_mw_get_align()?

addr_align provides the minimum alignment required by the device but it 
has no idea how big a buffer the caller is trying to create so it can't 
express that it needs to be aligned by its size.

To be clear, the minimum alignment the Switchtec device requires is 4KB 
so it will return 4k in addr_align. Thus, if you have a 4KB buffer it 
may be aligned to 4KB. But if you have a 1MB buffer it must be aligned 
to the nearest 1M.

>> It may also be that all hardware does not have this
>> restriction (ie. if the hardware adds to the base address instead of
>> just replacing the lower bits).
>>
>> There is definitely a need to print this error somewhere as I hit this
>> case and it caused very weird behavior. It was a huge pain to debug.
>> Also, it's a security issue and huge bug if we end up mapping the memory
>> we didn't think we were mapping.
> 
> Of course the driver should validate its parameters not allow bad mappings.  I was only commenting on the dev_err() message to the console.

Ok. I still feel like it would be difficult to debug if ntb_transport 
simply was unable to establish a connection without some message in 
dmesg telling the user why.

Also, keep in mind this is a somewhat unusual occurrence. In most cases 
dma_alloc_coherent() always provides a buffer that is aligned to it's 
size. It's just that the CMA (if used) provides a tunable config option 
which allows for larger buffers to not be aligned to their size.

Logan

