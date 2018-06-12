Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id t2-v6si93166iog.2.2018.06.12.15.27.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 15:27:11 -0700 (PDT)
References: <20180611203926.2666-1-jdmason@kudzu.us>
 <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
 <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
 <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
 <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com>
 <CAOQPn8s9khirf+2cgz2zLQrsx+gdkxtB-EiDwVmRyy7witLbzw@mail.gmail.com>
 <7f0e1c57-696f-44be-17f6-815fa5090774@deltatee.com>
 <c8284602-9001-7daf-083b-53a1a794c838@intel.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9f354d1f-af37-b378-b4f8-a8286adfe5ee@deltatee.com>
Date: Tue, 12 Jun 2018 16:27:08 -0600
MIME-Version: 1.0
In-Reply-To: <c8284602-9001-7daf-083b-53a1a794c838@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
To: Dave Jiang <dave.jiang@intel.com>, Eric Pilmore <epilmore@gigaio.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 12/06/18 04:17 PM, Dave Jiang wrote:
> The bounce buffering definitely decreases the performance. So the idea
> of directly writing to the remote skbuff would be great. It would also
> resolve issue of failing to allocate a large enough DMA region for the
> bounce buffer. Allen and I talked about netpoll support but never got
> around to look into it. So that may be another idea for performance
> enhancement. I do wonder if we will have any resistance from upstream
> due to security concerns since in order to do that we'll have to open up
> a very large BAR and allow access to entire memory region of the
> opposing node. Not an IOMMU expert, but will we have any issues when it
> comes to DMA to the remote buffers in this way? Probably not since Allen
> has NTRDMA doing something similar. I guess we can see what the change
> looks like. Looking forward to that though.

Yeah, it's a pain and the large BAR idea is a huge security risk for
systems that are not using an IOMMU. The RDMA guys inadvertently did the
same thing once (allow remote hosts to DMA to any address) and
developers went berserk when they found out.

I really wish the hardware guys would just give us an NTB aware high
performance DMA engine in a switch. That would simplify things
considerably. If it was well designed, it could make it really easy to
implement RDMA between partitions and then NTB transport would be
trivial to implement -- not only in a performant way but also for
multi-port systems.

Logan
