Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com. [2607:f8b0:400c:c05::242])
        by gmr-mx.google.com with ESMTPS id 105si437936uas.1.2017.11.27.08.33.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 08:33:37 -0800 (PST)
Received: by mail-vk0-x242.google.com with SMTP id 22so17770096vkq.4
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 08:33:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d87f10be-053d-44df-b320-524ef07eaeef@googlegroups.com>
References: <d87f10be-053d-44df-b320-524ef07eaeef@googlegroups.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 11:33:36 -0500
Message-ID: <CAPoiz9xoT-bqFT_=1svO-EVOyymOKzAJeUFsF4s9W+cpH7k3eA@mail.gmail.com>
Subject: Re: PLX NTB driver
Content-Type: text/plain; charset="UTF-8"
To: Karl Kao <karl.kao@tintri.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

Hello Karl,
The process is the standard Linux process. Assuming the code is in
git, rebase to the latest kernel tag (v4.15-rc1), test, and email this
mailing list.  We'll make comments for you to correct, you correct
them, and then you'll email an updated version of the patch (and this
loops until it is accepted).

Before emailing, please make sure ./scripts/checkpatch.pl does not
have any errors (and preferably no warnings).

Thanks,
Jon



On Mon, Nov 20, 2017 at 11:16 AM, Karl Kao <karl.kao@tintri.com> wrote:
> Hi Folks,
>
> I am preparing the ntb driver for plx switch.
> Could anyone let me know the process to submit the changes? Should I just
> send the patch to this group, or create a GitHub tree? What's process about
> the linux-next?
>
> Thanks,
> Karl
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/d87f10be-053d-44df-b320-524ef07eaeef%40googlegroups.com.
> For more options, visit https://groups.google.com/d/optout.
