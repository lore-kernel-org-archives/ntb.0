Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x233.google.com (mail-vk0-x233.google.com. [2607:f8b0:400c:c05::233])
        by gmr-mx.google.com with ESMTPS id g6si98885pll.4.2017.11.27.07.46.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 07:46:08 -0800 (PST)
Received: by mail-vk0-x233.google.com with SMTP id s197so17627028vkh.11
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 07:46:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171122091902.6e2c3f84@canb.auug.org.au>
References: <20171119152536.GA17838@graymalkin.kudzu.us> <CA+55aFwOJziwpmsi1TN-CA2i7jrWQE_GC9DjPg9-8x3mwz3uHQ@mail.gmail.com>
 <e1e178fa-9da4-13bb-f070-0fa9094a74c7@deltatee.com> <CA+55aFwmGk=279M9D2XzpuVoMuB_MPw+2n4vb47ZYh72GM6gaw@mail.gmail.com>
 <338c8f27-369b-11c4-f764-b8f726038f35@deltatee.com> <20171121093719.211f8194@canb.auug.org.au>
 <da4e7995-817d-e996-afa4-22560f1d8aac@deltatee.com> <20171122091902.6e2c3f84@canb.auug.org.au>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 10:46:06 -0500
Message-ID: <CAPoiz9yDzO+2ZEiRUDwrCp8oaZx4t8Ak99HiH+OOwYa+VAWQ1A@mail.gmail.com>
Subject: Re: [GIT PULL] NTB bug fixes for v4.15
Content-Type: text/plain; charset="UTF-8"
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Logan Gunthorpe <logang@deltatee.com>, Linus Torvalds <torvalds@linux-foundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Nov 21, 2017 at 5:19 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Logan,
>
> On Mon, 20 Nov 2017 15:53:07 -0700 Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>> On 20/11/17 03:37 PM, Stephen Rothwell wrote:
>> > OK, all I need is the (git) URL for a tree/branch (or tag) and a
>> > contact (or more than one) to whom I can report conflicts and build
>> > problems.  I then fetch it every day (so all you have to do it add stuff
>> > to that branch when it is ready).
>> >
>> > I noticed that one of the current set of commits removed Jon as a
>> > MAINTAINER, so I am not sure what part he would play.
>> >
>>
>> The branch you would want to automatically fetch is
>>
>> https://github.com/jonmason/ntb.git ntb-next
>>
>> Jon's probably the contact you want for merge conflicts (Jon Mason
>> <jdmason@kudzu.us>) as he's the one who typically pushes to those
>> branches and submits PRs to Linus. You could also add the mailing list:
>> linux-ntb@googlegroups.com. Dave and Allen are also maintainers but I'll
>> let them speak up if they want to be contacted for this.
>
> So, I really need Jon to request this inclusion (sorry).  And I would
> prefer to not add it until after -rc1 has been released i.e. next week
> probably.

Thank you for doing this.  Please include this branch at your
convenience, and email me (and the NTB mailing list if possible) with
any merge conflicts.

Thanks,
Jon

> --
> Cheers,
> Stephen Rothwell
