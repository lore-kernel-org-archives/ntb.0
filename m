Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l11-v6si866323iti.0.2018.06.12.09.11.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 09:11:03 -0700 (PDT)
References: <20180611203926.2666-1-jdmason@kudzu.us>
 <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
Date: Tue, 12 Jun 2018 10:11:00 -0600
MIME-Version: 1.0
In-Reply-To: <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
To: Jon Mason <jdmason@kudzu.us>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 11/06/18 09:15 PM, Jon Mason wrote:
> On Mon, Jun 11, 2018 at 6:33 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>> On 11/06/18 02:39 PM, Jon Mason wrote:
>>> The tx_time should be in usecs (according to the comment above the
>>> variable), but the setting of the timer during the rearming is done in
>>> msecs.  Change it to match the expected units.
>>
>> I'm curious what the user visible effects of this bug were. Will this
>> significantly improve the performance of ntb_netdev?
> 
> Unknown.  I'm unable to benchmark it, but it could make the
> performance more jittery.  Unless you have an objection, I'll apply it
> to the ntb-next branch, and we can benchmark it (and if it is worse
> then we can drop it or do a follow-on to find more optimal numbers for
> the timeout).

I tried it and didn't see any noticeable change but it's clear the
author intended what you say so

Reviewed-By: Logan Gunthorpe <logang@deltatee.com>

Logan
