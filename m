Return-Path: <torvalds@linuxfoundation.org>
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com. [2a00:1450:4864:20::129])
        by gmr-mx.google.com with ESMTPS id v16si388836wmh.1.2020.12.27.09.42.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:42:23 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id o17so19378414lfg.4
        for <linux-ntb@googlegroups.com>; Sun, 27 Dec 2020 09:42:23 -0800 (PST)
Return-Path: <torvalds@linuxfoundation.org>
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id m21sm5973816ljb.108.2020.12.27.09.42.22
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Dec 2020 09:42:22 -0800 (PST)
Received: by mail-lf1-f51.google.com with SMTP id o19so19429655lfo.1
        for <linux-ntb@googlegroups.com>; Sun, 27 Dec 2020 09:42:22 -0800 (PST)
MIME-Version: 1.0
References: <20201227141638.GA11393@athena.kudzu.us> <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
In-Reply-To: <CAHk-=wjxQzF3eWank1r7F6+EqSRsO+kvibPqDbzxjHv3wzZt0A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 27 Dec 2020 09:42:06 -0800
Message-ID: <CAHk-=wgdcA-gADjaqp5KZChRjwKGStOo_MVEu3MSi7HiRDGS9g@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v5.11
Content-Type: text/plain; charset="UTF-8"
To: Jon Mason <jdmason@kudzu.us>, Dan Carpenter <dan.carpenter@oracle.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, Dec 27, 2020 at 9:38 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> The thing is, "PTR_ERR()" works just fine on a IS_ERR_OR_NULL pointer.
> It doesn't work on a _regular_ non-NULL and non-ERR pointer, and will
> return random garbage for those. But if you've tested for
> IS_ERR_OR_NULL(), then a regular PTR_ERR() is already fine.

Side note: no, standard C does not guarantee that a NULL pointer would
cast to the integer 0 (despite a cast of the constant 0 turning into
NULL), but the kernel very much does. And our ERR_PTR() games in
particular already violate all the standard C rules, and we very much
depend on the pointer bit patterns to begin with.

             Linus
