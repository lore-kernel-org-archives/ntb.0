Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com. [2607:f8b0:400c:c08::243])
        by gmr-mx.google.com with ESMTPS id 13si283037vkk.1.2016.08.23.09.43.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Aug 2016 09:43:12 -0700 (PDT)
Received: by mail-ua0-x243.google.com with SMTP id u13so13866875uau.0
        for <linux-ntb@googlegroups.com>; Tue, 23 Aug 2016 09:43:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1471885081.3770.129.camel@intel.com>
References: <1471884696-25558-1-git-send-email-hofrat@osadl.org>
 <1471884696-25558-2-git-send-email-hofrat@osadl.org> <1471885081.3770.129.camel@intel.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 23 Aug 2016 12:43:11 -0400
Message-ID: <CAPoiz9yv2jps3cgH+i_O1CotcQujQvkUKhnDKdqT76RtxKdgUg@mail.gmail.com>
Subject: Re: [PATCH 2/2] ntb: make DMA_OUT_RESOURCE_TO HZ independent
Content-Type: text/plain; charset=UTF-8
To: "Jiang, Dave" <dave.jiang@intel.com>
Cc: "hofrat@osadl.org" <hofrat@osadl.org>, "Allen.Hubbe@emc.com" <Allen.Hubbe@emc.com>, "logang@deltatee.com" <logang@deltatee.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "sudipm.mukherjee@gmail.com" <sudipm.mukherjee@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Aug 22, 2016 at 12:58 PM, Jiang, Dave <dave.jiang@intel.com> wrote:
>
> On Mon, 2016-08-22 at 18:51 +0200, Nicholas Mc Guire wrote:
>> schedule_timeout_* takes a timeout in jiffies but the code currently
>> is
>> passing in a constant which makes this timeout HZ dependent, so pass
>> it
>> through msecs_to_jiffies() to fix this up.
>>
>> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Pulled both patches into ntb-next

Thanks,
Jon

>
>> ---
>>
>> Problem found by coccinelle script
>>
>> The below patch sets the timeout to 50ms - not clear what HZ setting
>> was
>> assumed during design/testing, so this needs an ack by someone who
>> knows
>> the driver and can confirm that 50ms is reasonable to wait on DMA
>> retries.
>>
>> Patch was compile tested with: x86_64_defconfig + CONFIG_NTB=m,
>> CONFIG_NTB_PERF=m
>>
>> Patch is against 4.8.0-rc2 (localversion-next is -next-20160822)
>>
>>  drivers/ntb/test/ntb_perf.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/test/ntb_perf.c
>> b/drivers/ntb/test/ntb_perf.c
>> index 6a50f20..e065b69 100644
>> --- a/drivers/ntb/test/ntb_perf.c
>> +++ b/drivers/ntb/test/ntb_perf.c
>> @@ -72,7 +72,7 @@
>>  #define MAX_THREADS          32
>>  #define MAX_TEST_SIZE                SZ_1M
>>  #define MAX_SRCS             32
>> -#define DMA_OUT_RESOURCE_TO  50
>> +#define DMA_OUT_RESOURCE_TO  msecs_to_jiffies(50)
>>  #define DMA_RETRIES          20
>>  #define SZ_4G                        (1ULL << 32)
>>  #define MAX_SEG_ORDER                20 /* no larger than 1M for
>> kmalloc buffer */
>> --
>> 2.1.4
>>
