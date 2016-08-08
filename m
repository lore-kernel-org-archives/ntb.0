Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com. [2607:f8b0:400c:c08::242])
        by gmr-mx.google.com with ESMTPS id a132si1004975vki.0.2016.08.08.08.00.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 08:00:40 -0700 (PDT)
Received: by mail-ua0-x242.google.com with SMTP id u13so2004772uau.0
        for <linux-ntb@googlegroups.com>; Mon, 08 Aug 2016 08:00:40 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000101d1f175$e9d800d0$bd880270$@emc.com>
References: <1470649722-29709-1-git-send-email-weiyj.lk@gmail.com> <000101d1f175$e9d800d0$bd880270$@emc.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 8 Aug 2016 11:00:39 -0400
Message-ID: <CAPoiz9zPKX3Qcph6ddvPK=d3bHQJw5HB39CCRNW3AawgM_KrOA@mail.gmail.com>
Subject: Re: [PATCH] NTB: ntb_hw_intel: Fix typo in module parameter descriptions
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Aug 8, 2016 at 9:08 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> From: Wei Yongjun
>> Fix typo in module parameter descriptions.
>>
>> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
>
> Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

Another good catch.  Applied to the ntb branch.

Thanks,
Jon

>
>> ---
>>  drivers/ntb/hw/intel/ntb_hw_intel.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
>> index 0d5c29a..1ee61d9 100644
>> --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
>> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
>> @@ -112,17 +112,17 @@ MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
>>
>>  module_param_named(xeon_b2b_usd_bar4_addr64,
>>                  xeon_b2b_usd_addr.bar4_addr64, ullong, 0644);
>> -MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
>> +MODULE_PARM_DESC(xeon_b2b_usd_bar4_addr64,
>>                "XEON B2B USD BAR 4 64-bit address");
>>
>>  module_param_named(xeon_b2b_usd_bar4_addr32,
>>                  xeon_b2b_usd_addr.bar4_addr32, ullong, 0644);
>> -MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
>> +MODULE_PARM_DESC(xeon_b2b_usd_bar4_addr32,
>>                "XEON B2B USD split-BAR 4 32-bit address");
>>
>>  module_param_named(xeon_b2b_usd_bar5_addr32,
>>                  xeon_b2b_usd_addr.bar5_addr32, ullong, 0644);
>> -MODULE_PARM_DESC(xeon_b2b_usd_bar2_addr64,
>> +MODULE_PARM_DESC(xeon_b2b_usd_bar5_addr32,
>>                "XEON B2B USD split-BAR 5 32-bit address");
>>
>>  module_param_named(xeon_b2b_dsd_bar2_addr64,
>> @@ -132,17 +132,17 @@ MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
>>
>>  module_param_named(xeon_b2b_dsd_bar4_addr64,
>>                  xeon_b2b_dsd_addr.bar4_addr64, ullong, 0644);
>> -MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
>> +MODULE_PARM_DESC(xeon_b2b_dsd_bar4_addr64,
>>                "XEON B2B DSD BAR 4 64-bit address");
>>
>>  module_param_named(xeon_b2b_dsd_bar4_addr32,
>>                  xeon_b2b_dsd_addr.bar4_addr32, ullong, 0644);
>> -MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
>> +MODULE_PARM_DESC(xeon_b2b_dsd_bar4_addr32,
>>                "XEON B2B DSD split-BAR 4 32-bit address");
>>
>>  module_param_named(xeon_b2b_dsd_bar5_addr32,
>>                  xeon_b2b_dsd_addr.bar5_addr32, ullong, 0644);
>> -MODULE_PARM_DESC(xeon_b2b_dsd_bar2_addr64,
>> +MODULE_PARM_DESC(xeon_b2b_dsd_bar5_addr32,
>>                "XEON B2B DSD split-BAR 5 32-bit address");
>>
>>  #ifndef ioread64
>
