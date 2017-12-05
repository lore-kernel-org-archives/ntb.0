Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y16si69003pll.0.2017.12.05.13.48.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 13:48:53 -0800 (PST)
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171203191736.3399-2-fancer.lancer@gmail.com>
 <CAPoiz9xTRToABuuop77j7GcsLaZjYWD1Ght9kGc-Bo9A0w5ddw@mail.gmail.com>
 <20171205173154.GB1701@mobilestation>
 <CAPoiz9zcDS6Au4xSTAxgC7v3ghWX6WX+6AV5=zd78q4q2Fqovw@mail.gmail.com>
 <20171205205402.GJ1701@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <87c96df1-eb87-5fd0-2f45-15df0a446cba@deltatee.com>
Date: Tue, 5 Dec 2017 14:48:46 -0700
MIME-Version: 1.0
In-Reply-To: <20171205205402.GJ1701@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 01/15] NTB: Rename NTB messaging API methods
To: Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>, Gary R Hook <gary.hook@amd.com>, Sergey.Semin@t-platforms.ru, linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 01:54 PM, Serge Semin wrote:

>> Just because no one said anything before, doesn't mean it's
>> acceptable.  I think that is the official Linux code review mantra ;-)
>>
>> Okay, if we are going to do it this way, then return ~0 instead.  At
>> least that way there is no ugly cast.
>>
> 
> Ok. I'll replace it with ~(u32)0.

That's exactly the same just more confusing. I'm still in favor of 
leaving it the way it was.

Logan
