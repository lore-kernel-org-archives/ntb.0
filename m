Return-Path: <epilmore@gigaio.com>
Received: from mail-qt0-x236.google.com (mail-qt0-x236.google.com. [2607:f8b0:400d:c0d::236])
        by gmr-mx.google.com with ESMTPS id w4-v6si57846ioa.4.2018.06.12.14.33.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 14:33:24 -0700 (PDT)
Received: by mail-qt0-x236.google.com with SMTP id x34-v6so501954qtk.5
        for <linux-ntb@googlegroups.com>; Tue, 12 Jun 2018 14:33:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
References: <20180611203926.2666-1-jdmason@kudzu.us> <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com> <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Tue, 12 Jun 2018 14:33:23 -0700
Message-ID: <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 12, 2018 at 9:11 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 11/06/18 09:15 PM, Jon Mason wrote:
>> On Mon, Jun 11, 2018 at 6:33 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>>
>>>
>>> On 11/06/18 02:39 PM, Jon Mason wrote:
>>>> The tx_time should be in usecs (according to the comment above the
>>>> variable), but the setting of the timer during the rearming is done in
>>>> msecs.  Change it to match the expected units.
>>>
>>> I'm curious what the user visible effects of this bug were. Will this
>>> significantly improve the performance of ntb_netdev?
>>
>> Unknown.  I'm unable to benchmark it, but it could make the
>> performance more jittery.  Unless you have an objection, I'll apply it
>> to the ntb-next branch, and we can benchmark it (and if it is worse
>> then we can drop it or do a follow-on to find more optimal numbers for
>> the timeout).
>
> I tried it and didn't see any noticeable change but it's clear the
> author intended what you say so


How many entries are in your TX queue (tx_max_entry)?
I assume the tx_stop in ntb_netdev was still set to its default, 5.

If the TX queue is large then it may be difficult to go below the
tx_stop threshold.

Eric



>
> Reviewed-By: Logan Gunthorpe <logang@deltatee.com>
>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/d51b4fbc-3d56-2802-11f3-401876373b4c%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
