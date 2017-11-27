Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x234.google.com (mail-ua0-x234.google.com. [2607:f8b0:400c:c08::234])
        by gmr-mx.google.com with ESMTPS id e18si535418qtc.5.2017.11.27.09.38.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Nov 2017 09:38:36 -0800 (PST)
Received: by mail-ua0-x234.google.com with SMTP id g12so19591167uaa.1
        for <linux-ntb@googlegroups.com>; Mon, 27 Nov 2017 09:38:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e4c00ca2-3d74-5d88-1824-c517250d164f@deltatee.com>
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com> <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
 <e4c00ca2-3d74-5d88-1824-c517250d164f@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 27 Nov 2017 12:38:35 -0500
Message-ID: <CAPoiz9xvMQC7qJERUW2=mhED9=E6SLSR7g-7-SoLdkTywZhVZQ@mail.gmail.com>
Subject: Re: Ntb Transport Driver Problem After Power-up
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: ThanhTuThai <cruisethai@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Nov 27, 2017 at 12:09 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 27/11/17 10:00 AM, Jon Mason wrote:
>>
>> We can have a SW watchdog timer to poll it (aka heartbeat) to detect
>> this, but that's going to eat cycles and could allow for a windows
>> where the link is down and the sender is writing into oblivion.
>> Thoughts?
>
>
> I think the easiest way is if we get a link up event, and we already think
> the link is up, then we just put the link down before sending a second link
> up event. I can probably look at doing something like that shortly. However,
> unfortunately, my setup isn't suited to test this as I'm actually looping
> back both partitions to a single host :(. I'll submit a patch that others
> can test though.

Sounds great.  ThanhTuThai, can you test this?

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
> https://groups.google.com/d/msgid/linux-ntb/e4c00ca2-3d74-5d88-1824-c517250d164f%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
