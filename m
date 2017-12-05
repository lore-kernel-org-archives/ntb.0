Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x22b.google.com (mail-ua0-x22b.google.com. [2607:f8b0:400c:c08::22b])
        by gmr-mx.google.com with ESMTPS id f15si54665plr.1.2017.12.05.09.08.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 09:08:25 -0800 (PST)
Received: by mail-ua0-x22b.google.com with SMTP id v20so752453uaj.0
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 09:08:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <8859c11b-6c6b-3780-c13a-2ae0affd7033@deltatee.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-4-fancer.lancer@gmail.com> <CAPoiz9yuX+d1Bt1ioy_u9jLXzkWfHwKjoJ+hH5t4BN88YKrRsQ@mail.gmail.com>
 <8859c11b-6c6b-3780-c13a-2ae0affd7033@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 12:08:23 -0500
Message-ID: <CAPoiz9yPMBCwv0gvUgWbJj_Ue-67w6h0JyGALtx=E_4Hpbh+eA@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] NTB: Fix UB/bug in ntb_mw_get_align()
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Serge Semin <fancer.lancer@gmail.com>, Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 5, 2017 at 12:01 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 05/12/17 09:52 AM, Jon Mason wrote:
>>
>> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com>
>> wrote:
>>>
>>> Simple (1 << pidx) operation causes undefined behaviour when
>>> pidx >= 32. It must be casted to u64 to match the actual return
>>> value of ntb_link_is_up() method, so to have all the possible
>>> peer indexes covered and to get rid of undefined behaviour.
>>> Additionally there are special macros in "linux/bitops.h" to perform
>>> the bit-set-shift operations, so it's recommended to have them used
>>> for proper bit setting.
>>
>>
>> This looks good to me, but also seems like a bug fix.  Please comment
>> on if this is not noticed.
>
>
> It would be a bug on any system that has more than 32 partitions which is
> run on a 32 bit machine (or 64 partitions on a 64bit machine). Such a system
> is theoretical for the foreseeable future. But it would be good to fix it
> now.

Seems like a non-issue then.  Disregard.

>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/8859c11b-6c6b-3780-c13a-2ae0affd7033%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
