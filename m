Return-Path: <jdmason@kudzu.us>
Received: from mail-io0-x244.google.com (mail-io0-x244.google.com. [2607:f8b0:4001:c06::244])
        by gmr-mx.google.com with ESMTPS id y1-v6si928084pfm.2.2018.06.11.20.15.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Jun 2018 20:15:35 -0700 (PDT)
Received: by mail-io0-x244.google.com with SMTP id r24-v6so26364192ioh.9
        for <linux-ntb@googlegroups.com>; Mon, 11 Jun 2018 20:15:35 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
References: <20180611203926.2666-1-jdmason@kudzu.us> <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
From: Jon Mason <jdmason@kudzu.us>
Date: Mon, 11 Jun 2018 23:15:34 -0400
Message-ID: <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jun 11, 2018 at 6:33 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 11/06/18 02:39 PM, Jon Mason wrote:
>> The tx_time should be in usecs (according to the comment above the
>> variable), but the setting of the timer during the rearming is done in
>> msecs.  Change it to match the expected units.
>
> I'm curious what the user visible effects of this bug were. Will this
> significantly improve the performance of ntb_netdev?

Unknown.  I'm unable to benchmark it, but it could make the
performance more jittery.  Unless you have an objection, I'll apply it
to the ntb-next branch, and we can benchmark it (and if it is worse
then we can drop it or do a follow-on to find more optimal numbers for
the timeout).

Thanks,
Jon

>
> Logan
