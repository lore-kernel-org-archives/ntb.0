Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com. [2607:f8b0:400c:c08::241])
        by gmr-mx.google.com with ESMTPS id 13si1984901vkk.1.2016.08.08.07.59.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Aug 2016 07:59:00 -0700 (PDT)
Received: by mail-ua0-x241.google.com with SMTP id 74so7710326uau.3
        for <linux-ntb@googlegroups.com>; Mon, 08 Aug 2016 07:59:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <000001d1f175$cae862f0$60b928d0$@emc.com>
References: <1470649680-29533-1-git-send-email-weiyj.lk@gmail.com> <000001d1f175$cae862f0$60b928d0$@emc.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 8 Aug 2016 10:59:00 -0400
Message-ID: <CAPoiz9yFPv=0nFZrk7JoM-m3WYH+scgu0KWQc8qvu247iNYWKA@mail.gmail.com>
Subject: Re: [PATCH] ntb_pingpong: Fix db_init parameter description
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Logan Gunthorpe <logang@deltatee.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Aug 8, 2016 at 9:07 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> From: Wei Yongjun
>> Fix 'db_init' parameter description.
>>
>> Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
>
> Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

Good catch!  Applied to the ntb branch.

Thanks,
Jon

>
>> ---
>>  drivers/ntb/test/ntb_pingpong.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
>> index 7d31179..4358611 100644
>> --- a/drivers/ntb/test/ntb_pingpong.c
>> +++ b/drivers/ntb/test/ntb_pingpong.c
>> @@ -88,7 +88,7 @@ MODULE_PARM_DESC(delay_ms, "Milliseconds to delay the response to
>> peer");
>>
>>  static unsigned long db_init = 0x7;
>>  module_param(db_init, ulong, 0644);
>> -MODULE_PARM_DESC(delay_ms, "Initial doorbell bits to ring on the peer");
>> +MODULE_PARM_DESC(db_init, "Initial doorbell bits to ring on the peer");
>>
>>  struct pp_ctx {
>>       struct ntb_dev                  *ntb;
>
