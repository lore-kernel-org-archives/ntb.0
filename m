Return-Path: <jdmason@kudzu.us>
Received: from mail-vk0-x244.google.com (mail-vk0-x244.google.com. [2607:f8b0:400c:c05::244])
        by gmr-mx.google.com with ESMTPS id 96si131483otr.1.2017.11.27.09.00.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:00:09 -0800 (PST)
Received: by mail-vk0-x244.google.com with SMTP id 138so6491364vko.13
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 09:00:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com> <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 12:00:08 -0500
Message-ID: <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ThanhTuThai <cruisethai@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Nov 27, 2017 at 11:47 AM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 27/11/17 09:39 AM, Jon Mason wrote:
>>
>> It sounds like the link down/up isn't working properly.  Is the
>> Microsemi NTB not able to detect a link down?
>
>
> It can detect a link down, but the link doesn't actually go down in a lot of
> cases. If the host is just soft rebooted after a crash, I don't think the
> link will go down.

This is really not optimal :(

We can have a SW watchdog timer to poll it (aka heartbeat) to detect
this, but that's going to eat cycles and could allow for a windows
where the link is down and the sender is writing into oblivion.
Thoughts?

>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups
> "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/linux-ntb/37fc41d9-5191-6f41-fd65-e175f0c661fa%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
