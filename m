Return-Path: <epilmore@gigaio.com>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com. [2607:f8b0:400d:c0d::241])
        by gmr-mx.google.com with ESMTPS id v11-v6si45533pgr.5.2018.06.12.15.55.36
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 15:55:36 -0700 (PDT)
Received: by mail-qt0-x241.google.com with SMTP id o9-v6so693235qtp.3
        for <linux-ntb@googlegroups.com>; Tue, 12 Jun 2018 15:55:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9f354d1f-af37-b378-b4f8-a8286adfe5ee@deltatee.com>
References: <20180611203926.2666-1-jdmason@kudzu.us> <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
 <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com> <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
 <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com> <CAOQPn8s9khirf+2cgz2zLQrsx+gdkxtB-EiDwVmRyy7witLbzw@mail.gmail.com>
 <7f0e1c57-696f-44be-17f6-815fa5090774@deltatee.com> <c8284602-9001-7daf-083b-53a1a794c838@intel.com>
 <9f354d1f-af37-b378-b4f8-a8286adfe5ee@deltatee.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Tue, 12 Jun 2018 15:55:35 -0700
Message-ID: <CAOQPn8vSB1zLO56fRWopKhLr97q9qXnAsy2-v+E7vUw5t1JLdQ@mail.gmail.com>
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
Content-Type: text/plain; charset="UTF-8"
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Dave Jiang <dave.jiang@intel.com>, Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 12, 2018 at 3:27 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 12/06/18 04:17 PM, Dave Jiang wrote:
>> The bounce buffering definitely decreases the performance. So the idea
>> of directly writing to the remote skbuff would be great. It would also
>> resolve issue of failing to allocate a large enough DMA region for the
>> bounce buffer. Allen and I talked about netpoll support but never got
>> around to look into it. So that may be another idea for performance


Well, our original motivation for eliminating the interrupts was that our
particular switch's firmware was having issues with getting inundated with
doorbell requests. Eliminating the usage of interrupts (doorbells) was not
too painful in ntb_transport, although our approach was kind of a work
around hack to get around the switch firmware issues. I set up a RX side
tasklet to effectively poll for work to do. As you might imagine this has the
drawbacks of a slight latency in getting a stream started and a waste of cpu
cycles when there is no activity in the pipe. You really want a hybrid
approach, but for our temporary work around this was sufficient for us at the
time so we could move on to other things. We want to revisit this and
maybe take a NAPI approach (if you're familiar with that hybrid approach
of polling and minimizing interrupts).


>> enhancement. I do wonder if we will have any resistance from upstream
>> due to security concerns since in order to do that we'll have to open up
>> a very large BAR and allow access to entire memory region of the
>> opposing node. Not an IOMMU expert, but will we have any issues when it
>> comes to DMA to the remote buffers in this way? Probably not since Allen
>> has NTRDMA doing something similar. I guess we can see what the change
>> looks like. Looking forward to that though.
>
> Yeah, it's a pain and the large BAR idea is a huge security risk for
> systems that are not using an IOMMU. The RDMA guys inadvertently did the
> same thing once (allow remote hosts to DMA to any address) and
> developers went berserk when they found out.
>
> I really wish the hardware guys would just give us an NTB aware high
> performance DMA engine in a switch. That would simplify things
> considerably. If it was well designed, it could make it really easy to
> implement RDMA between partitions and then NTB transport would be
> trivial to implement -- not only in a performant way but also for
> multi-port systems.


I'm not quite seeing how a DMA in the switch would eliminate the security
risk of a wide open memory. Are you suggesting that the driver for the DMA
would have more control over filtering what source/dest addresses are
allowed and you wouldn't advertise the entire address space via a BAR?

Eric


>
> Logan
>
> --
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/9f354d1f-af37-b378-b4f8-a8286adfe5ee%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
