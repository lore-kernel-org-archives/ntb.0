Return-Path: <linus971@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com. [2607:f8b0:4001:c06::243])
        by gmr-mx.google.com with ESMTPS id v4si638409oth.4.2017.11.19.22.37.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 22:37:46 -0800 (PST)
Received: by mail-io0-x243.google.com with SMTP id w127so14625750iow.11
        for <linux-ntb@googlegroups.com>; Sun, 19 Nov 2017 22:37:46 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com>
References: <20171119152536.GA17838@graymalkin.kudzu.us> <CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
 <e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 19 Nov 2017 20:37:46 -1000
Message-ID: <CA+55aFwmGk=279M9D2XzpuVoMuB_MPw+2n4vb47ZYh72GM6gaw@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Sun, Nov 19, 2017 at 8:25 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 19/11/17 11:12 AM, Linus Torvalds wrote:
>> I am now traveling, and am not inclined to pull stuff that hasn't been
>> in linux-next unless it's just obviously bug-fixes.
>
> Sigh. This work has been held up for two cycles due to issues with the
> process.
>
> If it's of any consideration, my Switchtec NTB patches were in one of my
> repos which is subscribed to the kbuild test robot. I did receive a
> build success notification email on it a few months ago. It's also an
> isolated driver which shouldn't have any effect on any other systems.

Gaah. I guess I can take the pull request.

I do want to protest the timing and the lack of linux-next coverage.
If it has really been ready for months, why hasn't it been in
linux-next at all?

         Linus
