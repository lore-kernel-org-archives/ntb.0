Return-Path: <jdmason@kudzu.us>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com. [2607:f8b0:4003:c06::236])
        by gmr-mx.google.com with ESMTPS id k15si933620igt.3.2016.03.07.13.36.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Mar 2016 13:36:38 -0800 (PST)
Received: by mail-oi0-x236.google.com with SMTP id d205so89175610oia.0
        for <linux-ntb@googlegroups.com>; Mon, 07 Mar 2016 13:36:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1453832409.3824.59.camel@intel.com>
References: <1453800729-2501235-1-git-send-email-arnd@arndb.de>
	<1453832409.3824.59.camel@intel.com>
Date: Mon, 7 Mar 2016 16:36:38 -0500
Message-ID: <CAPoiz9zh5LrKV=+ZWgCMm-6ng5KM3gab1t6xPheO5CM40tznJA@mail.gmail.com>
Subject: Re: [PATCH] ntb: perf test: fix address space confusion
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 26, 2016 at 1:20 PM, Jiang, Dave <dave.jiang@intel.com> wrote:
> On Tue, 2016-01-26 at 10:31 +0100, Arnd Bergmann wrote:
>> The ntb driver assigns between pointers an __iomem tokens, and
>> also casts them to 64-bit integers, which results in compiler
>> warnings on 32-bit systems:
>>
>> drivers/ntb/test/ntb_perf.c: In function 'perf_copy':
>> drivers/ntb/test/ntb_perf.c:213:10: error: cast from pointer to
>> integer of different size [-Werror=pointer-to-int-cast]
>>   vbase = (u64)(u64 *)mw->vbase;
>>           ^
>> drivers/ntb/test/ntb_perf.c:214:14: error: cast from pointer to
>> integer of different size [-Werror=pointer-to-int-cast]
>>   dst_vaddr = (u64)(u64 *)dst;
>>               ^
>>
>> This adds __iomem annotations where needed and changes the temporary
>> variables to iomem pointers to avoid casting them to u64. I did not
>> see the problem in linux-next earlier, but it show showed up in
>> 4.5-rc1.
>>
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Sorry for the delay.  Applied.

Thanks,
Jon

>> Fixes: 8a7b6a778a85 ("ntb: ntb perf tool")
>> ---
>>  drivers/ntb/test/ntb_perf.c | 21 +++++++++++----------
>>  1 file changed, 11 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c
>> b/drivers/ntb/test/ntb_perf.c
>> index c8a37ba4b4f9..6bdc1e7b7503 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -178,7 +178,7 @@ static void perf_copy_callback(void *data)
>>       atomic_dec(&pctx->dma_sync);
>>  }
>>
>> -static ssize_t perf_copy(struct pthr_ctx *pctx, char *dst,
>> +static ssize_t perf_copy(struct pthr_ctx *pctx, char __iomem *dst,
>>                        char *src, size_t size)
>>  {
>>       struct perf_ctx *perf = pctx->perf;
>> @@ -189,7 +189,8 @@ static ssize_t perf_copy(struct pthr_ctx *pctx,
>> char *dst,
>>       dma_cookie_t cookie;
>>       size_t src_off, dst_off;
>>       struct perf_mw *mw = &perf->mw;
>> -     u64 vbase, dst_vaddr;
>> +     void __iomem *vbase;
>> +     void __iomem *dst_vaddr;
>>       dma_addr_t dst_phys;
>>       int retries = 0;
>>
>> @@ -204,14 +205,14 @@ static ssize_t perf_copy(struct pthr_ctx *pctx,
>> char *dst,
>>       }
>>
>>       device = chan->device;
>> -     src_off = (size_t)src & ~PAGE_MASK;
>> -     dst_off = (size_t)dst & ~PAGE_MASK;
>> +     src_off = (uintptr_t)src & ~PAGE_MASK;
>> +     dst_off = (uintptr_t __force)dst & ~PAGE_MASK;
>>
>>       if (!is_dma_copy_aligned(device, src_off, dst_off, size))
>>               return -ENODEV;
>>
>> -     vbase = (u64)(u64 *)mw->vbase;
>> -     dst_vaddr = (u64)(u64 *)dst;
>> +     vbase = mw->vbase;
>> +     dst_vaddr = dst;
>>       dst_phys = mw->phys_addr + (dst_vaddr - vbase);
>>
>>       unmap = dmaengine_get_unmap_data(device->dev, 1,
>> GFP_NOWAIT);
>> @@ -261,13 +262,13 @@ err_get_unmap:
>>       return 0;
>>  }
>>
>> -static int perf_move_data(struct pthr_ctx *pctx, char *dst, char
>> *src,
>> +static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst,
>> char *src,
>>                         u64 buf_size, u64 win_size, u64 total)
>>  {
>>       int chunks, total_chunks, i;
>>       int copied_chunks = 0;
>>       u64 copied = 0, result;
>> -     char *tmp = dst;
>> +     char __iomem *tmp = dst;
>>       u64 perf, diff_us;
>>       ktime_t kstart, kstop, kdiff;
>>
>> @@ -324,7 +325,7 @@ static int ntb_perf_thread(void *data)
>>       struct perf_ctx *perf = pctx->perf;
>>       struct pci_dev *pdev = perf->ntb->pdev;
>>       struct perf_mw *mw = &perf->mw;
>> -     char *dst;
>> +     char __iomem *dst;
>>       u64 win_size, buf_size, total;
>>       void *src;
>>       int rc, node, i;
>> @@ -364,7 +365,7 @@ static int ntb_perf_thread(void *data)
>>       if (buf_size > MAX_TEST_SIZE)
>>               buf_size = MAX_TEST_SIZE;
>>
>> -     dst = (char *)mw->vbase;
>> +     dst = (char __iomem *)mw->vbase;
>>
>>       atomic_inc(&perf->tsync);
>>       while (atomic_read(&perf->tsync) != perf->perf_threads)
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1453832409.3824.59.camel%40intel.com.
> For more options, visit https://groups.google.com/d/optout.
