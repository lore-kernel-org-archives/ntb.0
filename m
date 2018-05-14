Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x232.google.com (mail-lf0-x232.google.com. [2a00:1450:4010:c07::232])
        by gmr-mx.google.com with ESMTPS id e17-v6si433190wri.1.2018.05.14.14.39.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 14:39:34 -0700 (PDT)
Received: by mail-lf0-x232.google.com with SMTP id h197-v6so20206823lfg.11
        for <linux-ntb@googlegroups.com>; Mon, 14 May 2018 14:39:34 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Tue, 15 May 2018 00:39:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
Message-ID: <20180514213940.GA2636@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
 <20180511224401.GA5458@mobilestation>
 <98abfca8-f16d-67f1-85c8-66550069ae2e@deltatee.com>
 <20180514202542.GC24717@mobilestation>
 <9373c212-433c-818d-3fbd-b1f95cede59d@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9373c212-433c-818d-3fbd-b1f95cede59d@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, May 14, 2018 at 02:59:23PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> On 5/14/2018 2:25 PM, Serge Semin wrote:
> > Hello Logan,
> > I've read that manual many times and do know about the case you've cited. First
> > of all, if Atul left the same design of the code, he would have needed to add
> > spin-locks inside the send/recv methods while accessing the scratchpads/message
> > anyway, which means he must have added 'mmiowb' as well before releasing the lock.*
> 
> Well, we shouldn't be using any locking in the library but, even if we
> did, a spin lock would probably not be appropriate. Locking would only
> be necessary if multiple CPUs could be accessing the interface at the
> same time and seeing current users only use it for initialization this
> should not be necessary. If future users want to use this API in a
> concurrent manner I think they should have to do the locking themselves.
> 

Even if current users do it for initialization only, it doesn't mean it
should not be thread-IRQ-safe (see Alen and my comments sent within this patch).
It is especially true, if the library is going to be created for generic data
transfer, as you also suggested to implement.

> 
> >  However, intermediary hardware (such as a PCI bridge) may indulge in
> >  deferral if it so wishes; to flush a store, a load from the same location
> >  is preferred."
> 
> Read this more carefully. It says a load from the same device is the
> preferred way to order stores (when necessary). Not a call to mmiowb()
> which is much more expensive.
> 

Yes, it does. But we don't use load instruction here either. That was my
concern. (see the next comment as continue of this one)

> > "Used with prefetchable I/O memory, an mmiowb() barrier may be required to
> >  force stores to be ordered."
> 
> NTB drivers should not be using prefetchable memory for registers. If
> one does, it's probably very broken.
> 

Of course configuration space should be memory-mapped to a non-prefetchable
region. But as far as I remember the Switchtec driver uses one of the memory
windows to emulate the Scratchpad registers. So if that memory window mapped
to a prefetchable region (which is always true for 64-bit BARs), then we
either need to have a fake load instruction or mmiowb() to flush all the
stores. I can judge by IDT devices, which MW BARs can be setup either as
prefetchable or non-prefetchable. If you are sure, that that the Swithtec
Scratchpad MW is always mapped to a non-prefetcable I/O memory (it should
be accessed through a 32-bits BAR with non-prefetchable bit set), then we can
close the discussion.

-Sergey

> See also [1], especially quiz #4.
> 
> Logan
> 
> [1] https://lwn.net/Articles/698014/
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/9373c212-433c-818d-3fbd-b1f95cede59d%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
