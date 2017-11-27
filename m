Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id j129si153505oib.5.2017.11.27.08.47.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 08:47:25 -0800 (PST)
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
Date: Mon, 27 Nov 2017 09:47:19 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: Ntb Transport Driver Problem After Power-up
To: Jon Mason <jdmason@kudzu.us>, ThanhTuThai <cruisethai@gmail.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 27/11/17 09:39 AM, Jon Mason wrote:
> It sounds like the link down/up isn't working properly.  Is the
> Microsemi NTB not able to detect a link down?

It can detect a link down, but the link doesn't actually go down in a 
lot of cases. If the host is just soft rebooted after a crash, I don't 
think the link will go down.

Logan
