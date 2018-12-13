Return-Path: <jdmason@kudzu.us>
Received: from mail-it1-x141.google.com (mail-it1-x141.google.com. [2607:f8b0:4864:20::141])
        by gmr-mx.google.com with ESMTPS id e2si27941uah.0.2018.12.12.16.26.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 16:26:05 -0800 (PST)
Received: by mail-it1-x141.google.com with SMTP id a6so1215031itl.4
        for <linux-ntb@googlegroups.com>; Wed, 12 Dec 2018 16:26:05 -0800 (PST)
MIME-Version: 1.0
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
 <CAPoiz9yN9zHXxyuwmopfSwBLGr39bQ1SJjGq_ku-w_b9V13OFQ@mail.gmail.com>
 <f22b6112-920b-37f1-68fe-f43164a18f05@deltatee.com> <CAPoiz9xesBdtgVg1UGF8LuD28tjMp6VpVuHVjdwcWJq93Phi3w@mail.gmail.com>
 <ff7019a0-bac2-2de2-d06c-d54a82286b90@deltatee.com>
In-Reply-To: <ff7019a0-bac2-2de2-d06c-d54a82286b90@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 12 Dec 2018 19:25:53 -0500
Message-ID: <CAPoiz9wB4d6bL9=C9uQWrkeo8PwdXoWN0ridoEyiC1yHAg32Eg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: wesley.sheng@microchip.com, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, wesleyshenggit@sina.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 12, 2018 at 7:01 PM Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
>
> On 2018-12-12 4:57 p.m., Jon Mason wrote:
> > On Wed, Dec 12, 2018 at 6:42 PM Logan Gunthorpe <logang@deltatee.com> wrote:
> >>
> >>
> >>
> >> On 2018-12-12 4:00 p.m., Jon Mason wrote:
> >>> So, you based your patches on a series of patches not in the
> >>> ntb/ntb-next branch?  Please don't do this.  I see nothing in these
> >>> patches which requires that series, which makes this even more
> >>> unnecessary.  Since these are fairly trivial, I'm taking them and
> >>> pushing to the ntb-next branch to give these more time to be tested
> >>> (due to not being tested on the proper branch).  I would really
> >>> appreciate you testing the ntb-next branch as a sanity check.
> >>
> >> The NTB test tools don't work with switchtec hardware without that patch
> >> set, so there's no way to test the changes without that branch.
> >
> > Then let's get those patches in.  IIRC, I asked you to split up the
> > patch series to be bugfixes and features (or at least reorder the
> > series so I can split it up that way in my branches).  Also, I think
> > Serge had some comments that may/may not need to be addressed.  Could
> > you please reorder and resend (and Serge can comment as needed on the
> > resend)?
>
> I resent a while back and responded to all the feedback. Every patch in
> that series fixes a bug. None of them add features.

Per https://lkml.org/lkml/2018/6/12/552, I asked the series be split
up and the comments to be cleaned-up.  You repushed without addressing
this (or Serge's comments), which caused me to ignore the series.
Again, I'm happy to take it as a single series and split it up on my
end, I just need the patches reordered to have the bugfixes I
specified in the front to allow for this to be easily done.

Alternatively, you can rebase and resend them as-is to the ntb mailing
list and we can rehash it out there.

Thanks,
Jon

>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/ff7019a0-bac2-2de2-d06c-d54a82286b90%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
