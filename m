Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id b6si131792plm.3.2017.11.27.15.35.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 15:35:24 -0800 (PST)
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com>
 <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com>
 <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com>
 <CAPoiz9wEseVS9-MD7ZwmQGABXD-uYL0EH+oQfqYTqLR-YT+=8w@mail.gmail.com>
 <e4c00ca2-3d74-5d88-1824-c517250d164f@deltatee.com>
 <CAPoiz9xvMQC7qJERUW2=mhED9=E6SLSR7g-7-SoLdkTywZhVZQ@mail.gmail.com>
 <CAJQW-Q4oji8=TW2sB_fyP7dZAsptWGzwOKK4vOth23CxcodB9w@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <1a460ce1-f37e-a4b8-994d-1e20d9f8e19f@deltatee.com>
Date: Mon, 27 Nov 2017 16:35:21 -0700
MIME-Version: 1.0
In-Reply-To: <CAJQW-Q4oji8=TW2sB_fyP7dZAsptWGzwOKK4vOth23CxcodB9w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: Ntb Transport Driver Problem After Power-up
To: ThanhTuThai <cruisethai@gmail.com>, Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>



On 27/11/17 04:33 PM, ThanhTuThai wrote:
> No, it doesn't.
> 
> I've also thought about this strategy, and implemented it in my setup.
> For the soft-reboot, it works well, I can receive the link up event when 
> it complete rebooting.
> But for power-on reset ( in this case, the switchtec is also power-reset 
> ), I don't receiver any message of linking-up. So the good peer cannot 
> reset link status as mention above. But if I reload the drivers on the 
> good peer, they work perfectly.

That's because it's filtering out the link up because it already thinks 
the link is up. Please wait until I send a patch and test that. It'll be 
in the next day or two.

Thanks,

Logan
