Return-Path: <linjiasen@hygon.cn>
Received: from spam2.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id z5si68151ywg.5.2019.12.17.23.35.04
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Dec 2019 23:35:05 -0800 (PST)
Subject: Re: [PATCH] NTB: ntb_perf: Add more debugfs entries for ntb_perf
References: <1576550536-84697-1-git-send-email-linjiasen@hygon.cn>
 <d4f679cd-739b-fd80-8344-7da475937835@deltatee.com>
From: Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <fd3efeba-40f0-3933-af48-d74486ddea86@hygon.cn>
Date: Wed, 18 Dec 2019 15:32:11 +0800
MIME-Version: 1.0
In-Reply-To: <d4f679cd-739b-fd80-8344-7da475937835@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, jdmason@kudzu.us
Cc: allenbh@gmail.com, dave.jiang@intel.com, sanju.mehta@amd.com
List-ID: <linux-ntb.googlegroups.com>



On 2019/12/18 0:42, Logan Gunthorpe wrote:
> 
> 
> On 2019-12-16 7:42 p.m., Jiasen Lin wrote:
>> Currently, read input and output buffer is not supported yet in
>> debugfs of ntb_perf. We can not confirm whether the output data is
>> transmitted to the input buffer at peer memory through NTB.
>>
>> This patch add new entries in debugfs which implement interface to read
>> a part of input and out buffer. User can dump output and input data at
>> local and peer system by hexdump command, and then compare them manually.
> 
> Do we even initialize inbuf and outbuf? Probably not a good idea to
> expose them to userspace if it's not initialized.
> 

Good catch! Input buffer(peer->inbuf) should be initialized after call
dma_alloc_coherent in perf_setup_inbuf, but output buffer(peer->outbuf)
that point to NTB BARx MMIO address can not be initialized. The address 
of memory request that fall in NTB memory windown will be translated 
into an address that point to input buffer at peer memory system through 
NTB XLAT register in ntb_perf. In other words, only input buffer should 
be initialized.
Will fix it for v2 as a separate patch.

> Really, ntb_tool should be used to check if memory windows work,
> ntb_perf is just to see the maximum transfer rate.
> 

Yes, you are right! ntb_tool could be used to check memory window
by hexdmup mw and peer_mw after write mw_trans and peer_mw_trans,
but this is only one ntb client be probed although we can insmod both
ntb_tool.ko and ntb_perf.ko, That's to say, only one modulue can create
files in debugFS. So, I suggest that add debugfs entries that can read
input and output buffer in ntb_perf.

Thanks,
Jiasen Lin

> Logan
> 
