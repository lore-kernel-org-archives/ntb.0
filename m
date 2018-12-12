Return-Path: <jdmason@kudzu.us>
Received: from mail-it1-x134.google.com (mail-it1-x134.google.com. [2607:f8b0:4864:20::134])
        by gmr-mx.google.com with ESMTPS id 17si2791otj.4.2018.12.12.15.00.47
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 15:00:47 -0800 (PST)
Received: by mail-it1-x134.google.com with SMTP id i145so934179ita.4
        for <linux-ntb@googlegroups.com>; Wed, 12 Dec 2018 15:00:47 -0800 (PST)
MIME-Version: 1.0
References: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
In-Reply-To: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Wed, 12 Dec 2018 18:00:35 -0500
Message-ID: <CAPoiz9yN9zHXxyuwmopfSwBLGr39bQ1SJjGq_ku-w_b9V13OFQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
Content-Type: text/plain; charset="UTF-8"
To: wesley.sheng@microchip.com
Cc: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, wesleyshenggit@sina.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 6, 2018 at 1:47 AM Wesley Sheng <wesley.sheng@microchip.com> wrote:
>
> Hi, Everyone,
>
> This patch series adds support of >=4G memory windows.
>
> Current Switchtec's BAR setup registers are limited to 32bits,
> corresponding to the maximum MW (memory window) size is <4G.
> Increase the MW sizes with the addition of the BAR Setup Extension
> Register for the upper 32bits of a 64bits MW size. This increases the MW
> range to between 4K and 2^63.
>
> Additionally, we've made the following changes:
>
> * debug print 64bit aligned crosslink BAR numbers
> * Fix the array size of NT req id mapping table
>
> Tested with ntb_test.sh successfully based on NTB fixes series from
> Logan Gunthorpe <logang@deltatee.com> at
> https://github.com/sbates130272/linux-p2pmem on branch of
> ntb_multiport_fixes

So, you based your patches on a series of patches not in the
ntb/ntb-next branch?  Please don't do this.  I see nothing in these
patches which requires that series, which makes this even more
unnecessary.  Since these are fairly trivial, I'm taking them and
pushing to the ntb-next branch to give these more time to be tested
(due to not being tested on the proper branch).  I would really
appreciate you testing the ntb-next branch as a sanity check.

Thanks,
Jon

>
> Regards,
> Wesley
>
> --
>
> Changed since v1:
>   - Using upper_32_bits() and lower_32_bits() marcos makes it easier
>     to read and avoids compiler warning on 32-bit arch
>   - Reorder the patches to make the bug fixes first and add a "Fixes"
>     line to the commit messages
>
> --
> Paul Selles (2):
>   ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
>   ntb_hw_switchtec: Added support of >=4G memory windows
>
> Wesley Sheng (1):
>   ntb_hw_switchtec: NT req id mapping table register entry number should
>     be 512
>
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 ++++++++---
>  include/linux/switchtec.h              | 10 +++++++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
>
> --
> 2.7.4
>
