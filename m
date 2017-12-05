Return-Path: <jdmason@kudzu.us>
Received: from mail-ua0-x22f.google.com (mail-ua0-x22f.google.com. [2607:f8b0:400c:c08::22f])
        by gmr-mx.google.com with ESMTPS id 62si51259ybf.2.2017.12.05.11.15.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 11:15:26 -0800 (PST)
Received: by mail-ua0-x22f.google.com with SMTP id e10so1051274uah.10
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 11:15:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <f7df6ae6-6589-f88f-c1bf-c9f4e88b0495@deltatee.com>
References: <20171129175530.31032-1-logang@deltatee.com> <f7df6ae6-6589-f88f-c1bf-c9f4e88b0495@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Tue, 5 Dec 2017 14:15:25 -0500
Message-ID: <CAPoiz9wr6hKPxf5YgsH7TwPz-pbhNw01i3Mtthm5qXU+N3GyEw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Switchtec NTB Crosslink Support
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>, linux-kernel <linux-kernel@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Kelvin Cao <kelvin.cao@microsemi.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Nov 29, 2017 at 12:58 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> Also, I forgot to mention, this patch set is based on today's ntb-next.

All of these look sane to me.  Assuming they apply cleanly, adding to ntb-next.

Thanks,
Jon

>
> Logan
>
>
> On 29/11/17 10:55 AM, Logan Gunthorpe wrote:
>>
>> Hi,
>>
>> This patch series adds support for the Switchtec Crosslink feature.
>> Crosslink is similar to B2B in that it allows two switches to be
>> connected back to back.
>>
>> Two switches can already be connected between two hosts, however with this
>> setup, there would be no symmetry as one switch would handle NTB and the
>> other would just need to be a single partition switch. Our customers are
>> looking for a completely symmetric solution such that a host or switch
>> can be easily replaced without needing to worry about which half was
>> replaced.
>>
>> Crosslink solves this problem by having each of the switches configured
>> with two partitions. This results in a special host-less partition in
>> the middle of the connection which can be managed in such a way as
>> to forward all the traffic and still provide all the same NTB
>> functionality. In this way, both hosts and switches can be identical.
>>
>> Please see Patch 6 for a bit more detailed description of how Crosslink
>> works.
>>
>> Thanks,
>>
>> Logan
>>
>> Kelvin Cao (1):
>>    ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups
>>
>> Logan Gunthorpe (6):
>>    ntb_hw_switchtec: Keep track of the number of LUT windows used by the
>>      driver
>>    ntb_hw_switchtec: Create helper function to setup reserved LUT MWs
>>    ntb_hw_switchtec: Make switchtec_ntb_init_req_id_table() more general
>>    ntb_hw_switchtec: Expand PFF CSR registers
>>    ntb_hw_switchtec: Add initialization code for crosslink
>>    ntb_hw_switchtec: Crosslink doorbells and messages
>>
>>   drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 494
>> +++++++++++++++++++++++++++------
>>   include/linux/ntb.h                    |  15 +-
>>   include/linux/switchtec.h              |  23 +-
>>   3 files changed, 435 insertions(+), 97 deletions(-)
>>
>> --
>> 2.11.0
>>
>
