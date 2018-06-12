Return-Path: <dave.jiang@intel.com>
Received: from mga05.intel.com (mga05.intel.com. [192.55.52.43])
        by gmr-mx.google.com with ESMTPS id u24-v6si70111pfn.3.2018.06.12.15.17.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jun 2018 15:17:46 -0700 (PDT)
Subject: Re: [PATCH] ntb_netdev: fix sleep time mismatch
References: <20180611203926.2666-1-jdmason@kudzu.us>
 <ab8d44fc-6cd6-724e-0429-e7b3a1afb8d6@deltatee.com>
 <CAPoiz9z=sgNccCt2ui7FroNrWFjTZhMcEZ+UjVAJA2E-Y+RJPw@mail.gmail.com>
 <d51b4fbc-3d56-2802-11f3-401876373b4c@deltatee.com>
 <CAOQPn8uFa6iCcP0rVNKV9Mvm7LpWr=jpNOGOopgHJvzX+kTQCw@mail.gmail.com>
 <9261d4bc-f5a5-8b54-2227-57e5a3cf9d5c@deltatee.com>
 <CAOQPn8s9khirf+2cgz2zLQrsx+gdkxtB-EiDwVmRyy7witLbzw@mail.gmail.com>
 <7f0e1c57-696f-44be-17f6-815fa5090774@deltatee.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <c8284602-9001-7daf-083b-53a1a794c838@intel.com>
Date: Tue, 12 Jun 2018 15:17:45 -0700
MIME-Version: 1.0
In-Reply-To: <7f0e1c57-696f-44be-17f6-815fa5090774@deltatee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Logan Gunthorpe <logang@deltatee.com>, Eric Pilmore <epilmore@gigaio.com>
Cc: Jon Mason <jdmason@kudzu.us>, linux-ntb <linux-ntb@googlegroups.com>
List-ID: <linux-ntb.googlegroups.com>



On 06/12/2018 03:04 PM, Logan Gunthorpe wrote:
> 
> 
> On 12/06/18 03:59 PM, Eric Pilmore wrote:
>> I agree. There are too many interrupts and too much bounce buffering.
>> We have played around with eliminating the interrupts all together, but haven't
>> seen a noticeable improvement, although our queue size is artificially small
>> for other reasons.  We're hoping to devote more resources to benchmarking
>> and improving it. Eliminating or reducing the bounce buffering would help
>> quite a bit also. Ideally the sender could copy straight into a skb on the
>> receiving side instead of the intermediate buffering into the shared memory.
>> Again, we're hoping to get time and resources to play around with some
>> ideas.
> 
> Awesome! I'm really glad someone is looking into this! I'd really
> appreciate it if you keep the list informed if you make progress.
> 
> The only idea I had was to start by writing an ntb_transport_perf to see
> if the slow down is in ntb_transport (due to bounce buffering, etc) or
> if it's all ntb_netdev/tcp layer.

The bounce buffering definitely decreases the performance. So the idea
of directly writing to the remote skbuff would be great. It would also
resolve issue of failing to allocate a large enough DMA region for the
bounce buffer. Allen and I talked about netpoll support but never got
around to look into it. So that may be another idea for performance
enhancement. I do wonder if we will have any resistance from upstream
due to security concerns since in order to do that we'll have to open up
a very large BAR and allow access to entire memory region of the
opposing node. Not an IOMMU expert, but will we have any issues when it
comes to DMA to the remote buffers in this way? Probably not since Allen
has NTRDMA doing something similar. I guess we can see what the change
looks like. Looking forward to that though.
