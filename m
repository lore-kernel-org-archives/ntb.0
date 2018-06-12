Return-Path: <epilmore@gigaio.com>
Received: from mail-qt0-x231.google.com (mail-qt0-x231.google.com. [2607:f8b0:400d:c0d::231])
        by gmr-mx.google.com with ESMTPS id t63-v6si66082pgd.2.2018.06.12.14.59.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 14:59:08 -0700 (PDT)
Received: by mail-qt0-x231.google.com with SMTP id d3-v6so576423qto.1
        for <linux-ntb@googlegroups.com>; Tue, 12 Jun 2018 14:59:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com>
References: <20180611203926.2666-1-jdmason@kudzu.us> <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
 <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com> <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
 <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Tue, 12 Jun 2018 14:59:07 -0700
Message-ID: <CAOQPn8s9khirf+2cgz2zLQrsx+gdkxtB-EiDwVmRyy7witLbzw@mail.gmail.com>
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 12, 2018 at 2:44 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 6/12/2018 3:33 PM, Eric Pilmore wrote:
>> How many entries are in your TX queue (tx_max_entry)?
>> I assume the tx_stop in ntb_netdev was still set to its default, 5.
>>
>> If the TX queue is large then it may be difficult to go below the
>> tx_stop threshold.
>
> That makes sense. I didn't really dig into it too much. All I know is
> the performance of ntb_netdev has always been slower than I wanted it to
> be (almost an order of magnitude slower than ntb_perf) and I was hoping
> this would help that.


I agree. There are too many interrupts and too much bounce buffering.
We have played around with eliminating the interrupts all together, but haven't
seen a noticeable improvement, although our queue size is artificially small
for other reasons.  We're hoping to devote more resources to benchmarking
and improving it. Eliminating or reducing the bounce buffering would help
quite a bit also. Ideally the sender could copy straight into a skb on the
receiving side instead of the intermediate buffering into the shared memory.
Again, we're hoping to get time and resources to play around with some
ideas.

Eric



>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
