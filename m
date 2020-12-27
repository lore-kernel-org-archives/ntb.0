Return-Path: <torvalds@linuxfoundation.org>
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com. [2a00:1450:4864:20::12c])
        by gmr-mx.google.com with ESMTPS id u25si985985lfd.11.2020.12.27.09.38.41
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:38:41 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id h22so19415083lfu.2
        for <linux-ntb@googlegroups.com>; Sun, 27 Dec 2020 09:38:41 -0800 (PST)
Return-Path: <torvalds@linuxfoundation.org>
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com. [209.85.167.54])
        by smtp.gmail.com with ESMTPSA id v28sm5044735lfd.57.2020.12.27.09.38.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:38:40 -0800 (PST)
Received: by mail-lf1-f54.google.com with SMTP id o13so19375690lfr.3
        for <linux-ntb@googlegroups.com>; Sun, 27 Dec 2020 09:38:39 -0800 (PST)
MIME-Version: 1.0
References: <20201227141638.GA11393@athena.kudzu.us>
In-Reply-To: <20201227141638.GA11393@athena.kudzu.us>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Dec 2020 09:38:23 -0800
Message-ID: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
Content-Type: text/plain; charset="UTF-8"
To: Jon Mason <jdmason@kudzu.us>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 27, 2020 at 6:16 AM Jon Mason <jdmason@kudzu.us> wrote:
>
> Wang Qing (1):
>       ntb: idt: fix error check in ntb_hw_idt.c

So this patch seems to be at least partially triggered by a smatch
warning that is a bit questionable.

This part:

     if (IS_ERR_OR_NULL(dbgfs_topdir)) {
         dev_info(&ndev->ntb.pdev->dev, "Top DebugFS directory absent");
-        return PTR_ERR(dbgfs_topdir);
+        return PTR_ERR_OR_ZERO(dbgfs_topdir);
     }

works, but is very non-optimal and unnecessary.

The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
return random garbage for those. But if you've tested for
IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.

And PTR_ERR_OR_ZERO() potentially generates an extraneous pointless
tests against zero (to check for the ERR case).

A compiler may be able to notice that the PTR_ERR_OR_ZERO() is
unnecessary and remove it (because of the IS_ERR_OR_NULL() checks),
but in general we should assume compilers are "not stupid" rather than
"really smart".

So while this patch isn't _wrong_, and I've already pulled it, the
fact that apparently some smatch test triggers these pointless and
potentially expensive patches is not a good idea.

I'm not sure what the smatch tests should be (NULL turns to 0, which
may be confusing), but I'm cc'ing Dan in case he has ideas.

              Linus
