Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z1si65640pfh.0.2017.12.05.11.46.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 11:46:09 -0800 (PST)
References: <20171204175721.10322-1-logang@deltatee.com>
 <CAPoiz9x=sKryUszkSiPwTGW0fENpHKky_O708bA_zXLYZi0HoA@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e7631424-9274-532d-fe21-bbd55f33958f@deltatee.com>
Date: Tue, 5 Dec 2017 12:46:06 -0700
MIME-Version: 1.0
In-Reply-To: <CAPoiz9x=sKryUszkSiPwTGW0fENpHKky_O708bA_zXLYZi0HoA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] ntb_hw_switchtec: Force down the link before
 initializing
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb <linux-ntb@googlegroups.com>, ThanhTuThai <cruisethai@gmail.com>
List-ID: <linux-ntb.googlegroups.com>



On 05/12/17 12:30 PM, Jon Mason wrote:
> On Mon, Dec 4, 2017 at 12:57 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>> If one host crashes and soft reboots, the other host may not see a
>> link down event. Then when the crashed host comes back up, the
>> surviving host may not know the link was reset and the NTB clients
>> may not work without being reset.
>>
>> To solve this, we send a LINK_FORCE_DOWN message to each peer every
>> time we come up, before we register the NTB device. If a surviving
>> host still thinks the link is up it will take it down immediately.
>> In this way, once the crashed host comes up fully, it will send a
>> regular link up event as per usual and the link will be properly
>> restarted.
>>
>> While we are in the area, this also fixes the MSG_LINK_UP message that
>> was in the link down function that was reported by Doug Meyers.
> 
> So, this only applies on the ntb-next branch, and applying it after
> your multi-partition patch series causes it to fail to apply.  The
> fixup appears to be trivial, but please double check me.

Oops sorry. I think I checked that v1 merged cleanly but didn't look at 
v2. I double checked the merged commit in ntb-next and it looks good. 
I'll do some testing on ntb-next later in the week.

Thanks,

Logan
