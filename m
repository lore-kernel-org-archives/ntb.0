Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id g196si301489itb.1.2017.06.23.13.39.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 13:39:08 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170619200659.GA20437@kudzu.us>
 <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
 <000001d2eb85$daecdea0$90c69be0$@dell.com>
 <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
 <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
 <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
 <000201d2eba8$dade4ac0$909ae040$@dell.com>
 <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
 <000001d2ec23$2bd9f300$838dd900$@dell.com>
 <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
 <000101d2ec53$f2830840$d78918c0$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <eeaed83a-cd2b-91f1-e199-eaa6452edd17@deltatee.com>
Date: Fri, 23 Jun 2017 14:39:01 -0600
MIME-Version: 1.0
In-Reply-To: <000101d2ec53$f2830840$d78918c0$@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: New NTB API Issue
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>



On 23/06/17 01:07 PM, Allen Hubbe wrote:
> The client's haven't been fully ported to the multi-port api yet.  They were only minimally changed to call the new api, but so far other than that they have only been made to work as they had before.

So is it intended to eventually send the align parameters via spads?
This seems like it would take a lot of spads or multiplexing the spads
with a few doorbells. This gets a bit nasty.


> If those are BARs, that corresponds to "outbound", writing something to the BAR at mwA0.
> A more complete picture might be:
> 
> Host A BARs (aka "outbound" or "peer" memory windows):
> peer_mwA0: resource at 0xA00000000 - 0xA00200000 (2MB)
> peer_mwA1: resource at 0xA10000000 - 0xA10400000 (4MB)
> peer_mwA2: resource at 0xA20000000 - 0xa20010000 (64k)
> 
> Host A MWs (aka "inbound" memory windows):
> mwA0: 64k max size, aligned to 64k, size aligned to 64k
> mwA1: 2MB max size, aligned to 4k, size aligned to 4k

I don't really like the separation of inbound and output as you describe
it. It doesn't really match my hardware. In switchtec, each partition
has some number of BARs and each BAR has a single translation which sets
the peer and destination address. The translation really exists inside
the switch hardware, not on either side. But any translation can be
programmed by any peer. Saying that there's an opposite inbound window
to every outbound window is not an accurate abstraction for us.

I _suspect_ the IDT hardware is similar but, based on Serge's driver, I
think the translation can only be programmed by the peer that the BAR is
resident in (as opposed to from any side like in the switchtec hardwer).
(This poses some problems for getting the IDT code to actually work with
existing clients.)

> Outbound memory (aka "peer mw") windows come with a pci resource.  We can get the size of the resource, it's physical address, and set up outbound translation if the hardware has that (IDT).
> 
> Inbound memory windows (aka "mw") are only used to set up inbound translation, if the hardware has that (Intel, AMD).
> 
> To set up end-to-end memory window so that A can write to B, let's use peer_mwA1 and mwB0.
> 
> A: ntb_peer_mw_get_addr(peer_mwA1) -> base 0xA10000000, size 4MB
> B: ntb_mw_get_align(port4**, mwB0) -> aligned 4k, aligned 4k, max size 1MB
> ** Serge: do we need port info here, why?
> 
> Side A has a resource size of 4MB, but B only supports inbound translation up to 1MB.  Side A can only use the first quarter of the 4MB resource.
> 
> Side B needs to allocate memory aligned to 4k (the dma address must be aligned to 4k after dma mapping), and a multiple of 4k in size.  B may need to set inbound translation so that incoming writes go into this memory.  A may also need to set outbound translation.
> 
> A: ntb_peer_mw_set_trans(port1**, peer_mwA1, dma_mem_addr, dma_mem_size)
> B: ntb_mw_set_trans(port4**, mwB0, dma_mem_addr, dma_mem_size)
> ** Serge: do we also need the opposing side MW index here?
> 
> ** Logan: would those changes to the api suit your needs?

Not really, no. Except for the confusion with the mw_get_align issue the
new API, as it is, suits my hardware well. What you're proposing doesn't
fix my issue and doesn't match my hardware. Though, I interpreted
ntb_peer_mw_set_trans somewhat differently from what you describe. I did
not expect the client would need to call both functions but some clients
could optionally use ntb_peer_mw_set_trans to set the translation from
the opposite side (thus needing to send the DMA address over spads or
msgs). Though, without an actual in-kernel user it's hard to know what
is actually intended.

It's worth noticing that the IDT driver only provides peer_mw_set_trans
and not mw_set_trans. I assumed it's because the hardware's memory
windows can only be configured from the opposite side.

Pragmatically, the only change I need for everything to work as I expect
is for mw_get_align to be called only after link up. However, given all
the confusion I'm wondering if these changes are even ready for
upstream. Without actual in-kernel client code it's hard to know if the
API is correct or that everyone is even interpreting it in the same way.

Logan
