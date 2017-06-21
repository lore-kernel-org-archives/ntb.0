Return-Path: <linus971@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com. [2607:f8b0:4001:c06::229])
        by gmr-mx.google.com with ESMTPS id 23si984934ith.6.2017.06.21.12.05.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Jun 2017 12:05:51 -0700 (PDT)
Received: by mail-io0-x229.google.com with SMTP id e63so756735iod.3
        for <linux-ntb@googlegroups.com>; Wed, 21 Jun 2017 12:05:51 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAPoiz9yuK1GM1dmx4fPEg=WbDx3paim+FMfgg713ioqX1XW=Vw@mail.gmail.com>
References: <20170619184245.GA20187@graymalkin.kudzu.us> <CA+55aFyghoL++4=b1v6qFV1wN+t6RsQX+oPhxy_w=GmDXFo5Pw@mail.gmail.com>
 <CAPoiz9yuK1GM1dmx4fPEg=WbDx3paim+FMfgg713ioqX1XW=Vw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Jun 2017 12:05:50 -0700
Message-ID: <CA+55aFxdun0-H13L+KCQ-Gn5kVAiyth=a+6NBcwcH5Ff8kHCcQ@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v4.12
Content-Type: text/plain; charset="UTF-8"
To: Jon Mason <jdmason@kudzu.us>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 20, 2017 at 7:59 AM, Jon Mason <jdmason@kudzu.us> wrote:
>
> This was in my ntb branch since June 9th.  Previously, it was based on
> v4.12-rc4.  Immediately prior to doing the pull request, I did a
> rebase to rc6 to avoid any potential issues you might have applying
> them.

Please don't do that.

There are valid reasons for rebasing, but "just because" is not one of
them. The valid reasons are things like "I noticed that a completely
broken patch had made it into my queue, so I rebased to remove it" or
similar.

One common theme for valid reasons tends to be "..and I needed to
rerun all the testing", so in general I get very suspicious if things
are very recent, because clearly they didn't get very well tested.

                  Linus
