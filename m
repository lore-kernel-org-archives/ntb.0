Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g1-v6si1174964pfk.0.2018.05.14.15.04.09
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 15:04:10 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
 <20180511224401.GA5458@mobilestation>
 <98abfca8-f16d-67f1-85c8-66550069ae2e@deltatee.com>
 <20180514202542.GC24717@mobilestation>
 <9373c212-433c-818d-3fbd-b1f95cede59d@deltatee.com>
 <20180514213940.GA2636@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5067aadd-64f6-747a-660b-6f0c99948158@deltatee.com>
Date: Mon, 14 May 2018 16:04:06 -0600
MIME-Version: 1.0
In-Reply-To: <20180514213940.GA2636@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 5/14/2018 3:39 PM, Serge Semin wrote:
> Even if current users do it for initialization only, it doesn't mean it
> should not be thread-IRQ-safe (see Alen and my comments sent within this patch).
> It is especially true, if the library is going to be created for generic data
> transfer, as you also suggested to implement.

IMO this should be up to the caller to do the locking at least until we
have a _lot_ of example clients that need it. Generally, in the kernel
we wait for users to need instead of trying to predict the future.

IRQ safe is probably more than overkill...

> Yes, it does. But we don't use load instruction here either. That was my
> concern. (see the next comment as continue of this one)

Then add a load instruction and a comment. mmiowb() raises eyebrows
these days.

> Of course configuration space should be memory-mapped to a non-prefetchable
> region. But as far as I remember the Switchtec driver uses one of the memory
> windows to emulate the Scratchpad registers. So if that memory window mapped
> to a prefetchable region (which is always true for 64-bit BARs), then we
> either need to have a fake load instruction or mmiowb() to flush all the
> stores. I can judge by IDT devices, which MW BARs can be setup either as
> prefetchable or non-prefetchable. If you are sure, that that the Swithtec
> Scratchpad MW is always mapped to a non-prefetcable I/O memory (it should
> be accessed through a 32-bits BAR with non-prefetchable bit set), then we can
> close the discussion.

Switchtec uses pci_iomap() which does not map it prefetchable in anyway.
If it was prefetchable, the scratchpads would probably be very buggy,
even with current clients.

Logan
