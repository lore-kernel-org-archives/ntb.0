Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x234.google.com (mail-ua0-x234.google.com. [2607:f8b0:400c:c08::234])
        by gmr-mx.google.com with ESMTPS id j24si166535iod.4.2017.11.27.08.07.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 08:07:22 -0800 (PST)
Received: by mail-ua0-x234.google.com with SMTP id f14so19374408uaa.5
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 08:07:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <dda6fccc-093a-7f1c-87a1-d01a8d8aacb8@deltatee.com>
References: <20171121225945.29377-1-colin.king@canonical.com> <dda6fccc-093a-7f1c-87a1-d01a8d8aacb8@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 11:07:20 -0500
Message-ID: <CAPoiz9wKGv9+Y9PF2mBqFYuUzvb1bnKodHvONUpa5OCM0TSiHg@mail.gmail.com>
Subject: Re: [PATCH] NTB: switchtec_ntb: fix spelling mistake: "peforming" -> "performing"
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Colin King <colin.king@canonical.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Nov 21, 2017 at 6:06 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Thanks Colin!
>
> Reviewed-By: Logan Gunthorpe <logang@deltatee.com>
>
> On 21/11/17 03:59 PM, Colin King wrote:
>>
>> From: Colin Ian King <colin.king@canonical.com>
>>
>> Trivial fix to spelling mistake in dev_err error message
>>
>> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to my ntb-next branch

>> ---
>>   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> index afe8ed6f3b23..d46d113210b5 100644
>> --- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> +++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
>> @@ -172,7 +172,7 @@ static int switchtec_ntb_part_op(struct switchtec_ntb
>> *sndev,
>>         if (ps == status) {
>>                 dev_err(&sndev->stdev->dev,
>> -                       "Timed out while peforming %s (%d). (%08x)",
>> +                       "Timed out while performing %s (%d). (%08x)",
>>                         op_text[op], op,
>>                         ioread32(&ctl->partition_status));
>>
>
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/dda6fccc-093a-7f1c-87a1-d01a8d8aacb8%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
