Return-Path: <jdmason@kudzu.us>
Received: from mail-wi0-f179.google.com (mail-wi0-f179.google.com. [209.85.212.179])
        by gmr-mx.google.com with ESMTPS id w6si20583wiy.0.2015.09.07.12.41.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 07 Sep 2015 12:41:45 -0700 (PDT)
Received: by wicgb1 with SMTP id gb1so55199972wic.1
        for <linux-ntb@googlegroups.com>; Mon, 07 Sep 2015 12:41:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1441027457.git.Allen.Hubbe@emc.com>
References: <cover.1441027457.git.Allen.Hubbe@emc.com>
Date: Mon, 7 Sep 2015 15:41:44 -0400
Message-ID: <CAPoiz9yAUBtvyaKFR3P-u0adWAg1DyU=GPFnxC9NezD-ie+x-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] NTB: Fix/improve memory window index validation
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Aug 31, 2015 at 9:30 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> Fix a range check on validating a memory window index, and make validation more
> strict for using memory window as a hardware errata workaround.
>
> Allen Hubbe (2):
>   NTB: Improve index handling in B2B MW workaround
>   NTB: Fix range check on memory window index

Both of these look fine to me.  Applying to my tree for 4.3.

Thanks,
Jon

>  drivers/ntb/hw/intel/ntb_hw_intel.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)
>
> --
> 2.5.0.rc1
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/cover.1441027457.git.Allen.Hubbe%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
