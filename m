Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com. [2607:f8b0:400c:c08::243])
        by gmr-mx.google.com with ESMTPS id z1si54210pfh.0.2017.12.05.10.08.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 10:08:45 -0800 (PST)
Received: by mail-ua0-x243.google.com with SMTP id e10so888548uah.10
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 10:08:45 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171205175607.GD1701@mobilestation>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-4-fancer.lancer@gmail.com> <CAPoiz9yuX+d1Bt1ioy_u9jLXzkWfHwKjoJ+hH5t4BN88YKrRsQ@mail.gmail.com>
 <20171205175607.GD1701@mobilestation>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 13:08:44 -0500
Message-ID: <CAPoiz9zg1jSKMGi=HpYZSOajkfLhUyHR+oxVabDbNkCRY19fcg@mail.gmail.com>
Subject: Re: [PATCH v2 03/15] NTB: Fix UB/bug in ntb_mw_get_align()
Content-Type: text/plain; charset="UTF-8"
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Dec 5, 2017 at 12:56 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
> On Tue, Dec 05, 2017 at 11:52:32AM -0500, Jon Mason <jdmason@kudzu.us> wrote:
>> On Sun, Dec 3, 2017 at 2:17 PM, Serge Semin <fancer.lancer@gmail.com> wrote:
>> > Simple (1 << pidx) operation causes undefined behaviour when
>> > pidx >= 32. It must be casted to u64 to match the actual return
>> > value of ntb_link_is_up() method, so to have all the possible
>> > peer indexes covered and to get rid of undefined behaviour.
>> > Additionally there are special macros in "linux/bitops.h" to perform
>> > the bit-set-shift operations, so it's recommended to have them used
>> > for proper bit setting.
>>
>> This looks good to me, but also seems like a bug fix.  Please comment
>> on if this is not noticed.
>>
>
> The consequences of the bug isn't noticeable at the moment, but potentially
> it can be seen on the devices like Switchtec (when multi-portness is finally
> added). Anyway it's better to fix it now, than to wait for obvious bug.
> Additionally as I said the originator of the code should have used BIT_ULL
> instead of the pure bit shifting.

This is more of a question of whether it should go into -stable and be
outside this patch set.  If this is impossible to ever hit, then
including it here instead of fast tracking it in -stable is fine.

Thanks,
Jon

>
> Thanks,
> -Sergey
>
>> Thanks,
>> Jon
>>
>> >
>> > Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
>> > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>> > ---
>> >  include/linux/ntb.h | 2 +-
>> >  1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
>> > index c1646f2c6344..488e586fb76c 100644
>> > --- a/include/linux/ntb.h
>> > +++ b/include/linux/ntb.h
>> > @@ -764,7 +764,7 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
>> >                                    resource_size_t *size_align,
>> >                                    resource_size_t *size_max)
>> >  {
>> > -       if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
>> > +       if (!(ntb_link_is_up(ntb, NULL, NULL) & BIT_ULL(pidx)))
>> >                 return -ENOTCONN;
>> >
>> >         return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
>> > --
>> > 2.12.0
>> >
