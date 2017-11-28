Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y25si386601uaa.2.2017.11.27.19.02.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Nov 2017 19:02:36 -0800 (PST)
Message-ID: <5A1CD1A7.5040104@deltatee.com>
Date: Mon, 27 Nov 2017 20:01:59 -0700
From: Logan Gunthorpe <logang@deltatee.com>
MIME-Version: 1.0
References: <CAJQW-Q4_hJ+23T0qhK9BRMbcfqdF7rnJkWWPmGKfN5WzyD-eJg@mail.gmail.com> <CAPoiz9zzL6jZeCa4o+AQN2j8J-5nMxQkojWdVEAb96==+v+awg@mail.gmail.com> <37fc41d9-5191-6f41-fd65-e175f0c661fa@deltatee.com> <0557295a-c60c-4aff-95ec-cb93296066ce@googlegroups.com> <87e0fa6c-025c-d5b6-b683-dbb6be9cb115@deltatee.com> <e663c6ad-64cc-407d-8c05-f4d62fa8ac9e@googlegroups.com>
In-Reply-To: <e663c6ad-64cc-407d-8c05-f4d62fa8ac9e@googlegroups.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: Ntb Transport Driver Problem After Power-up
To: Karl Kao <karl.kao@tintri.com>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 2017-11-27 7:16 PM, Karl Kao wrote:
> I meant to say the "peer" which was suddenly powered off. Once the
> "peer" is being reset or power cycled, the peer's hardware chip is
> supposed to be reset, correct

There's only one hardware chip in an NTB configuration. If you reset it, 
you reset all the peers (which you do not want to do).

Logan
