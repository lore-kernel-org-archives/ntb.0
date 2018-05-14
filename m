Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g9-v6si1322915pfh.2.2018.05.14.13.59.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 May 2018 13:59:28 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
 <20180511224401.GA5458@mobilestation>
 <98abfca8-f16d-67f1-85c8-66550069ae2e@deltatee.com>
 <20180514202542.GC24717@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9373c212-433c-818d-3fbd-b1f95cede59d@deltatee.com>
Date: Mon, 14 May 2018 14:59:23 -0600
MIME-Version: 1.0
In-Reply-To: <20180514202542.GC24717@mobilestation>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On 5/14/2018 2:25 PM, Serge Semin wrote:
> Hello Logan,
> I've read that manual many times and do know about the case you've cited. First
> of all, if Atul left the same design of the code, he would have needed to add
> spin-locks inside the send/recv methods while accessing the scratchpads/message
> anyway, which means he must have added 'mmiowb' as well before releasing the lock.*

Well, we shouldn't be using any locking in the library but, even if we
did, a spin lock would probably not be appropriate. Locking would only
be necessary if multiple CPUs could be accessing the interface at the
same time and seeing current users only use it for initialization this
should not be necessary. If future users want to use this API in a
concurrent manner I think they should have to do the locking themselves.


>  However, intermediary hardware (such as a PCI bridge) may indulge in
>  deferral if it so wishes; to flush a store, a load from the same location
>  is preferred."

Read this more carefully. It says a load from the same device is the
preferred way to order stores (when necessary). Not a call to mmiowb()
which is much more expensive.

> "Used with prefetchable I/O memory, an mmiowb() barrier may be required to
>  force stores to be ordered."

NTB drivers should not be using prefetchable memory for registers. If
one does, it's probably very broken.

See also [1], especially quiz #4.

Logan

[1] https://lwn.net/Articles/698014/
