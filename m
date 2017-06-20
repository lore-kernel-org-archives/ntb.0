Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com. [2607:f8b0:400c:c08::243])
        by gmr-mx.google.com with ESMTPS id x196si2415021vkx.6.2017.06.20.07.59.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Jun 2017 07:59:49 -0700 (PDT)
Received: by mail-ua0-x243.google.com with SMTP id j53so2878406uaa.2
        for <linux-ntb@googlegroups.com>; Tue, 20 Jun 2017 07:59:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFyghoL++4=b1v6qFV1wN+t6RsQX+oPhxy_w=GmDXFo5Pw@mail.gmail.com>
References: <20170619184245.GA20187@graymalkin.kudzu.us> <CA+55aFyghoL++4=b1v6qFV1wN+t6RsQX+oPhxy_w=GmDXFo5Pw@mail.gmail.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 20 Jun 2017 10:59:48 -0400
Message-ID: <CAPoiz9yuK1GM1dmx4fPEg=WbDx3paim+FMfgg713ioqX1XW=Vw@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v4.12
Content-Type: text/plain; charset="UTF-8"
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 19, 2017 at 11:06 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Tue, Jun 20, 2017 at 2:42 AM, Jon Mason <jdmason@kudzu.us> wrote:
>> Hello Linus,
>> Here are a few NTB bug fixes for 4.12.
>
> So I pulled this, mainly because it removed more lines than it added
> due to the revert.
>
> But generally I absolutely *hate* pulling stuff that I can see was
> committed just hours ago. Why was that branch so recent? It very
> obviously cannot have been in any linux-next or 0day or gotten any
> other exposure. Is there a reason for that behavior? And if there is,

This was in my ntb branch since June 9th.  Previously, it was based on
v4.12-rc4.  Immediately prior to doing the pull request, I did a
rebase to rc6 to avoid any potential issues you might have applying
them.

> just include it in the "please pull", because if it wasn't for the
> "removes more lines than adds" I probably would just have decided to
> ignore this.

In the future, I will endeavor to be more verbose.  I will include the
previous version that it was based on and the testing done by the NTB
developer community.  I apologize for not doing this in this pull
request, and I appreciate you asking me and not simply ignoring my
email.

Thanks,
Jon

>
>                Linus
