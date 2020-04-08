Return-Path: <linjiasen@hygon.cn>
Received: from spam1.hygon.cn ([110.188.70.11])
        by gmr-mx.google.com with ESMTPS id t125si517141iof.4.2020.04.07.21.38.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:38:04 -0700 (PDT)
Subject: Re: [bug report] NTB: ntb_perf: Fix address err in perf_copy_chunk
References: <20200406104105.GA34519@mwanda>
From: Jiasen Lin <linjiasen@hygon.cn>
Message-ID: <a00ff0fe-8451-67fc-7abf-53501cdc0fcd@hygon.cn>
Date: Wed, 8 Apr 2020 12:33:04 +0800
MIME-Version: 1.0
In-Reply-To: <20200406104105.GA34519@mwanda>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-ntb@googlegroups.com, zhangpanyong@hygon.cn
List-ID: <linux-ntb.googlegroups.com>



On 2020/4/6 18:41, Dan Carpenter wrote:
> Hello Jiasen Lin,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch 99a06056124d: "NTB: ntb_perf: Fix address err in
> perf_copy_chunk" from Nov 20, 2019, leads to the following Smatch
> complaint:
> 
>      drivers/ntb/test/ntb_perf.c:1017 perf_clear_test()
>      warn: variable dereferenced before check 'pthr->dma_chan' (see line 1011)
> 
> drivers/ntb/test/ntb_perf.c
>    1010		 */
>    1011		(void)dmaengine_terminate_sync(pthr->dma_chan);
>                                                 ^^^^^^^^^^^^^^
> "pthr->dma_chan" is dereferenced inside the function.
> 
>    1012		if (pthr->perf->test_peer->dma_dst_addr)
>    1013			dma_unmap_resource(pthr->dma_chan->device->dev,
>    1014					   pthr->perf->test_peer->dma_dst_addr,
>    1015					   pthr->perf->test_peer->outbuf_size,
>    1016					   DMA_FROM_DEVICE, 0);
>    1017		if (pthr->dma_chan)
>                      ^^^^^^^^^^^^^^
> This new NULL check is too late.
Hi Dan
Nice catch!

As pthr->dma_chan can't be NULL in this context, so there is no need to 
check pthr->dma_chan.
Will fix it in next patch.

Thanks,
Jiasen Lin
> 
>    1018			dma_release_channel(pthr->dma_chan);
>    1019	
> 
> regards,
> dan carpenter
> 
