Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q125si129344ywg.4.2017.11.27.09.09.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 09:09:29 -0800 (PST)
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
 <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e4c00ca2-3d74-5d88-1824-c517250d164f@deltatee.com>
Date: Mon, 27 Nov 2017 10:09:23 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: Ntb Transport Driver Problem After Power-up
To: Jon Mason <jdmason@kudzu.us>
Cc: ThanhTuThai <cruisethai@gmail.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 27/11/17 10:00 AM, Jon Mason wrote:
> We can have a SW watchdog timer to poll it (aka heartbeat) to detect
> this, but that's going to eat cycles and could allow for a windows
> where the link is down and the sender is writing into oblivion.
> Thoughts?

I think the easiest way is if we get a link up event, and we already 
think the link is up, then we just put the link down before sending a 
second link up event. I can probably look at doing something like that 
shortly. However, unfortunately, my setup isn't suited to test this as 
I'm actually looping back both partitions to a single host :(. I'll 
submit a patch that others can test though.

Logan
