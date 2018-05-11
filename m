Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g48-v6si446468uaa.5.2018.05.11.16.11.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 May 2018 16:11:33 -0700 (PDT)
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
 <20180511224401.GA5458@mobilestation>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <98abfca8-f16d-67f1-85c8-66550069ae2e@deltatee.com>
Date: Fri, 11 May 2018 17:11:28 -0600
MIME-Version: 1.0
In-Reply-To: <20180511224401.GA5458@mobilestation>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
To: Serge Semin <fancer.lancer@gmail.com>, Atul Raut <araut@codeaurora.org>
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

>> +		mmiowb();
> 
>>> Allen Hubbe
>>> spad_write is like iowrite32, so writes are ordered without extra mmiowb.
> 
> Allen, I may misunderstand something, but according to the kernel Documentation in
> general they aren't (specifically for prefetchable MWs - hello to the emulated
> scratchpads) so we need the MMIO barrier here. See the doc about mmiowb():
> https://www.kernel.org/doc/Documentation/memory-barriers.txt
> We must make sure, that the data is sent before the status change and
> before the peer is notified by means of Doorbell setting.

Actually, I'm pretty sure Allen is right and I had meant to comment on 
this as well. I've also gotten this wrong before and have been corrected 
on it.

Read the "Acquires vs I/O accesses" section in the same document you 
quote as well as [1].

ioread and iowrites are guaranteed to be strongly ordered with each 
other as long as they happen from the same CPU. However, seeing the PCI 
bus does not typically interact with the cache coherency protocol, io 
requests are not guaranteed, on all arches, to be in order with accesses 
to RAM. This is what mmiowb() is for. So if you have an IO access that 
is protected with a spin lock you must make sure to call mmiowb() before 
releasing the spin lock otherwise IO writes might happen after the lock 
is released. As far as I know, this is the only common use for mmiowb().

Logan

[1] https://www.kernel.org/doc/Documentation/driver-api/device-io.rst
