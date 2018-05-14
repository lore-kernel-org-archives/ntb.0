Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x233.google.com (mail-lf0-x233.google.com. [2a00:1450:4010:c07::233])
        by gmr-mx.google.com with ESMTPS id v13-v6si514315lji.0.2018.05.14.13.25.35
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 May 2018 13:25:35 -0700 (PDT)
Received: by mail-lf0-x233.google.com with SMTP id p85-v6so19961388lfg.7
        for <linux-ntb@googlegroups.com>; Mon, 14 May 2018 13:25:35 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Mon, 14 May 2018 23:25:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v2 2/4] NTB : Add message library NTB API
Message-ID: <20180514202542.GC24717@mobilestation>
References: <1525634420-19370-1-git-send-email-araut@codeaurora.org>
 <1525634420-19370-3-git-send-email-araut@codeaurora.org>
 <20180511224401.GA5458@mobilestation>
 <98abfca8-f16d-67f1-85c8-66550069ae2e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <98abfca8-f16d-67f1-85c8-66550069ae2e@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Atul Raut <araut@codeaurora.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, May 11, 2018 at 05:11:28PM -0600, Logan Gunthorpe <logang@deltatee.com> wrote:
> >>+		mmiowb();
> >
> >>>Allen Hubbe
> >>>spad_write is like iowrite32, so writes are ordered without extra mmiowb.
> >
> >Allen, I may misunderstand something, but according to the kernel Documentation in
> >general they aren't (specifically for prefetchable MWs - hello to the emulated
> >scratchpads) so we need the MMIO barrier here. See the doc about mmiowb():
> >https://www.kernel.org/doc/Documentation/memory-barriers.txt
> >We must make sure, that the data is sent before the status change and
> >before the peer is notified by means of Doorbell setting.
> 
> Actually, I'm pretty sure Allen is right and I had meant to comment on this
> as well. I've also gotten this wrong before and have been corrected on it.
> 
> Read the "Acquires vs I/O accesses" section in the same document you quote
> as well as [1].
> 
> ioread and iowrites are guaranteed to be strongly ordered with each other as
> long as they happen from the same CPU. However, seeing the PCI bus does not
> typically interact with the cache coherency protocol, io requests are not
> guaranteed, on all arches, to be in order with accesses to RAM. This is what
> mmiowb() is for. So if you have an IO access that is protected with a spin
> lock you must make sure to call mmiowb() before releasing the spin lock
> otherwise IO writes might happen after the lock is released. As far as I
> know, this is the only common use for mmiowb().
> 
> Logan
> 
> [1] https://www.kernel.org/doc/Documentation/driver-api/device-io.rst

Hello Logan,
I've read that manual many times and do know about the case you've cited. First
of all, if Atul left the same design of the code, he would have needed to add
spin-locks inside the send/recv methods while accessing the scratchpads/message
anyway, which means he must have added 'mmiowb' as well before releasing the lock.*

* Getting ahead a bit If I took the following case incorrectly, Alen' design of
data ring-buffer will set us free of mmiowb usage at all.

Still there is another place in the document [2], which concerns mmiowb usage.
I may still misunderstand something, but according to the section
'KERNEL I/O BARRIER EFFECTS' (see "(*) readX(), writeX():" description):
"Whether these are guaranteed to be fully ordered and uncombined with
 respect to each other on the issuing CPU depends on the characteristics
 defined for the memory window through which they're accessing."
 ...
"Ordinarily, these will be guaranteed to be fully ordered and uncombined,
 provided they're not accessing a prefetchable device.

 However, intermediary hardware (such as a PCI bridge) may indulge in
 deferral if it so wishes; to flush a store, a load from the same location
 is preferred."
 ...
"Used with prefetchable I/O memory, an mmiowb() barrier may be required to
 force stores to be ordered."

So to speak, the readX()/writeX() ordering rules depend on the CPU
characteristics of the memory windows. Particularly the doc mentions
prefetchable I/O memory regions, which might be our case if the Scratchpads
are emulated using memory windows. If I am not mistaken if memory region
is mapped by 64-bits BARs it can be prefetchable only. It means, that
at least the pure writeX() instructions can be reordered by an intermediate
bridge internal logic, so mmiowb() should be used to flush the stores.
Correct me if I'm wrong.

[2] https://www.kernel.org/doc/Documentation/memory-barriers.txt
