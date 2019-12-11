Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (mail-eopbgr690073.outbound.protection.outlook.com. [40.107.69.73])
        by gmr-mx.google.com with ESMTPS id d135si38743qke.7.2019.12.11.04.12.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Dec 2019 04:12:55 -0800 (PST)
Subject: Re: [PATCH] ntb_perf: pass correct struct device to
 dma_alloc_coherent
References: <1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com>
 <fd958d1b-5abc-b936-2f21-429326a6e5de@deltatee.com>
From: Sanjay R Mehta <sanmehta@amd.com>
Message-ID: <c70955ba-516f-19e6-6dbf-3bf864114fb1@amd.com>
Date: Wed, 11 Dec 2019 17:42:40 +0530
In-Reply-To: <fd958d1b-5abc-b936-2f21-429326a6e5de@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Return-Path: sanmehta@amd.com
MIME-Version: 1.0
To: Logan Gunthorpe <logang@deltatee.com>, Sanjay R Mehta <Sanju.Mehta@amd.com>, Shyam-sundar.S-k@amd.com, fancer.lancer@gmail.com, jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, will@kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>


On 12/10/2019 11:01 PM, Logan Gunthorpe wrote:
> [CAUTION: External Email]
>
> On 2019-12-10 6:07 a.m., Sanjay R Mehta wrote:
>> From: Sanjay R Mehta <sanju.mehta@amd.com>
>>
>> Currently, ntb->dev is passed to dma_alloc_coherent
>> and dma_free_coherent calls. The returned dma_addr_t
>> is the CPU physical address. This works fine as long
>> as IOMMU is disabled. But when IOMMU is enabled, we
>> need to make sure that IOVA is returned for dma_addr_t.
>> So the correct way to achieve this is by changing the
>> first parameter of dma_alloc_coherent() as ntb->pdev->dev
>> instead.
>>
>> Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
>> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Yes, I did the same thing as one of the patches in my fix-up series that
> never got merged. See [1].
>
> Hopefully you can make better progress than I did.
>
> While you're at it I think it's worth doing the same thing in ntb_tool
> as well as removing the dma_coerce_mask_and_coherent() calls that are in
> the NTB drivers which are meaningless once we get back to using the
> correct DMA device.
Yes, What you said make sense. I will address your comment in the next version of patch, but I will break them down into two separate patches.
>
> Thanks,
>
> Logan
>
> [1] https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Flkml%2F20190109192233.5752-3-logang%40deltatee.com%2F&amp;data=02%7C01%7CSanju.Mehta%40amd.com%7C1f043932c1c1425a836908d77d96e265%7C3dd8961fe4884e608e11a82d994e183d%7C0%7C0%7C637115959326469198&amp;sdata=BoDyfqTML39JhIvO7%2FvYGnKNRKe2rSKgZxJ0uT6dtsQ%3D&amp;reserved=0
>
>> ---
>>  drivers/ntb/test/ntb_perf.c | 7 ++++---
>>  1 file changed, 4 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
>> index f5df33a..8729838 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -559,7 +559,7 @@ static void perf_free_inbuf(struct perf_peer *peer)
>>               return;
>>
>>       (void)ntb_mw_clear_trans(peer->perf->ntb, peer->pidx, peer->gidx);
>> -     dma_free_coherent(&peer->perf->ntb->dev, peer->inbuf_size,
>> +     dma_free_coherent(&peer->perf->ntb->pdev->dev, peer->inbuf_size,
>>                         peer->inbuf, peer->inbuf_xlat);
>>       peer->inbuf = NULL;
>>  }
>> @@ -588,8 +588,9 @@ static int perf_setup_inbuf(struct perf_peer *peer)
>>
>>       perf_free_inbuf(peer);
>>
>> -     peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
>> -                                      &peer->inbuf_xlat, GFP_KERNEL);
>> +     peer->inbuf = dma_alloc_coherent(&perf->ntb->pdev->dev,
>> +                                      peer->inbuf_size, &peer->inbuf_xlat,
>> +                                      GFP_KERNEL);
>>       if (!peer->inbuf) {
>>               dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
>>                       &peer->inbuf_size);
>>
