Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id i63si1552846wmf.0.2017.06.23.14.46.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 14:46:48 -0700 (PDT)
Received: by mail-lf0-x244.google.com with SMTP id u62so7920039lfg.0
        for <linux-ntb@googlegroups.com>; Fri, 23 Jun 2017 14:46:48 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 24 Jun 2017 00:47:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: New NTB API Issue
Message-ID: <20170623214708.GA26488@mobilestation>
References: <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
 <000001d2eb85$daecdea0$90c69be0$@dell.com>
 <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
 <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
 <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
 <000201d2eba8$dade4ac0$909ae040$@dell.com>
 <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
 <000001d2ec23$2bd9f300$838dd900$@dell.com>
 <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
 <000101d2ec53$f2830840$d78918c0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d2ec53$f2830840$d78918c0$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 23, 2017 at 03:07:19PM -0400, Allen Hubbe <Allen.Hubbe@dell.com> wrote:
Hello Allen,

> From: Logan Gunthorpe
> > On 23/06/17 07:18 AM, Allen Hubbe wrote:
> > > By "remote" do you mean the source or destination of a write?
> > 
> > Look at how these calls are used in ntb_transport and ntb_perf:
> > 
> > They both call ntb_peer_mw_get_addr to get the size of the BAR. The size
> > is sent via spads to the other side. The other side then uses
> > ntb_mw_get_align and applies align_size to the received size.
> > 
> > > Yes, clients should transfer the address and size information to the peer.
> > 
> > But then they also need to technically transfer the alignment
> > information as well. Which neither of the clients do.
> 
> The client's haven't been fully ported to the multi-port api yet.  They were only minimally changed to call the new api, but so far other than that they have only been made to work as they had before.
> 
> > > Maybe this is the confusion.  None of these api calls are to reach across to the peer port, as to
> > get the size of the peer's bar.  They are to get information from the local port, or to configure the
> > local port.
> > 
> > I like the rule that these api calls are not to reach across the port.
> > But then API looks very wrong. Why are we calling one peer_mw_get addr
> > and the other mw_get_align? And why does mw_get_align have a peer index?
> 
> I regret that the term "peer" is used to distinguish the mw api.  Better names perhaps should be ntb_outbound_mw_foo, ntb_inbound_mw_foo; or ntb_src_mw_foo, ntb_dest_mw_foo.  I like outbound/inbound, although the names are longer, maybe out/in would be ok.
> 

As you remember we discussed the matter when new NTB API was being developed.
So we decided to have the following designation:
ntb_mw_*      - NTB MW API connected with inbound memory windows configurations,
ntb_peer_mw_* - NTB MW API connected with outbound memory windows configurations.
Yes, suffixes like "in/out" might give better notion of the methods purpose,
but the current notation is in coherency with the rest of API, and as long as
user gets into NTB API, one won't have much difficulties with understanding.

> > And why does mw_get_align have a peer index?
> 
> Good question.  Serge?
> 
> For that matter, why do we not also have peer mw idx in the set of parameters.  Working through the example below, it looks like we are lacking a way to say Outbound MW1 on A corresponds with Inbound MW0 on B.  It looks like we can only indicate that Port A (not which Outbound MW of Port A) corresponds with Inbound MW0 on B.
> 

Before I give any explanation, could you please study the new NTB API documentation:
https://github.com/jonmason/ntb/blob/ntb-next/Documentation/ntb.txt
Particularly you are interested in lines 31 - 111. It will give you a better
description of the way all MW-related methods work for the start. The detailed
multi-port example is given in the end of this email.

> > > Some snippets of code would help me understand your interpretation of the api semantics more
> > exactly.
> > 
> > I'm not sure the code to best show this in code, but let me try
> > describing an example situation:
> > 
> > Lets say we have the following mws on each side (this is something that
> > is possible with Switchtec hardware):
> > 
> > Host A BARs:
> > mwA0: 2MB size, aligned to 4k, size aligned to 4k
> > mwA1: 4MB size, aligned to 4k, size aligned to 4k
> > mwA2: 64k size, aligned to 64k, size aligned to 64k
> > 
> > Host B BARs:
> > mwB0: 2MB size, aligned to 4k, size aligned to 4k
> > mwB1: 64k size, aligned to 64k, size aligned to 64k
> 
> If those are BARs, that corresponds to "outbound", writing something to the BAR at mwA0.
> 
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
> 
> Host A sees Host B on port index 1
> 
> 
> Host B BARs (aka "outbound" or "peer" memory windows):
> peer_mwB0: resource at 0xB00000000 - 0xB00200000 (2MB)
> peer_mwB1: resource at 0xB10000000 - 0xB10010000 (64k)
> 
> Host B MWs (aka "inbound" memory windows):
> mwB0: 1MB size, aligned to 4k, size aligned to 4k
> mwB1: 2MB size, aligned to 4k, size aligned to 4k
> 
> Host B sees Host A on port index 4
> 
> 
> Outbound memory (aka "peer mw") windows come with a pci resource.  We can get the size of the resource, it's physical address, and set up outbound translation if the hardware has that (IDT).
> 
> Inbound memory windows (aka "mw") are only used to set up inbound translation, if the hardware has that (Intel, AMD).
> 
> To set up end-to-end memory window so that A can write to B, let's use peer_mwA1 and mwB0.

That's not actually right. We can't connect any outbound to any inbound MW,
since each of them can be of different type, thus having different
restrictions. Like IDT got MWs with direct address translation and MWs
based on Look-up tables (I suppose the same might be with Switchtec). All
inbound MWs information provided by new NTB API actually belongs to
corresponding outbound MWs.

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
> 

Alright folks. I'll explain the whole architecture by example of simple
multi-port device. Suppose we got some abstract three-NTB-ports
device Z: {Port A, Port B, Port C}. For our particular case lets say, that each
port can have up to three outbound memory windows configured (obviously it's more
than enough to have ports connected to each other, but in general each port can
have different number of outbound memory windows). So to speak each port
can access up to three remote memory regions. In this way, each port
shall have the following set of inbound and outbound memory windows:
Port A: 3 outbound MWs to access Port B or Port C memory,
        6 inbound MWs to have Port B and Port C accessing Port A memory
Port B: 3 outbound MWs to access Port A or Port C memory,
        6 inbound MWs to have Port A and Port C accessing Port B memory
Port C: 3 outbound MWs to access Port A or Port B memory,
        6 inbound MWs to have Port A and Port B accessing Port C memory
Suppose also, that each outbound memory window got different restrictions like:
translation address alignment, memory window size alignment and maximum size of
memory window. Lets say, that our abstract device has some similarity with
Intel/AMD device (I'll explain the difference with IDT later), but obviously
got multiple ports.

Now when description is over, I would like to have Port A accessing Port B memory
over outbound memory window with index 1 - midx1 (index starts from zero).
To set the connection up, the following steps must be performed within new NTB API.

1) Port B needs to allocated a memory region for inbound memory window. But first
it needs to know what kind of address and size should be of this region. For this
purpose it calls:
ntb_mw_get_align(Port A, midx1, &addr_align, &size_align, &size_max);
As you can see, we get translation address alignment (addr_align), memory region
alignment (size_align) and its maximum possible size (size_max) to have inbound
memory allocated properly for Port A outbound memory windows - midx1.

2) The actual inbound memory region can be allocated using say
dma_alloc_coherent() or something else. Using the restrictions from 1) we can
make sure, that it is correct for corresponding outbound MW.

3) Now the translation address of the memory window needs to be set to NTBi device.
For this purpose we need to call:
ntb_mw_set_trans(Port A, midx1, trans_addr, mw_size);
Which actually implies, that the memory region with translation address trans_addr
and size mw_size is set for outbound memory window midx1 of Port A.

4) Since Port B finished the inbound memory window configuration, Port A
needs to be somehow notified of it and informed about inbound memory window
parameters, particularly memory window index (if it isn't predefined by logic)
and memory window size (again if it isn't predefined by logic). It might be done
using any of preferable API methods like doorbell and scratchpads or message
registers. After this Port A start it's configuration.

5) Port A got information from Port B about inbound MW configured for its
outbound memory window midx1. The only thing left to do is to get actual
mapping info like outbound memory window base address and size. It's done
by calling
ntb_peer_mw_get_addr(midx1, map_base, map_size);
From now map_base and map_size can be used to map actual outbound MW using
for instance ioremap_wc(), so to have Port B memory accessed over retrieved
virtual address.
It must be noted in this matter, that in general map_size doesn't need to
be equal to mw_size. But obviously Port A logic needs to know mw_size for
proper communications.


Hopefully the explanation was full enough to grab a gist of multi-port NTB API.
As I said it was based on assumption, that the abstract device got more
similarities with Intel/AMD hardware (except multiportness of course).
On the other way, the IDT hardware is configured a bit different.
The difference is located at step 3) of the algorithm above. Due to
IDT hardware peculiarity (particularly due to Lookup table entry access
registers), the translation address and size of memory region can't
be setup on the inbound MW side. Instead the translation address (trans_addr)
and size (mw_addr) must be transfered to Port A, so it would set them up using
the method:
ntb_peer_mw_set_trans(Port B, midx1, trans_addr, mw_size);
The rest of the configuration steps are the same.

Regards,
-Sergey

> > So on Host A: peer_mw_get_addr(idx=1) should return size=4M (from mwA1),
> > but it's not clear what mw_get_align(widx=1) should do. I see two
> > possibilities:
> > 
> > 1) Given that it has the opposite sense of peer_mw_get_addr (ie. there
> > is no peer in it's name) and that this new api also has a peer index, it
> > should return align_size=64k (from mwB1). However, in order to do this,
> > Host B must be fully configured (technically the link doesn't have to be
> > fully up, but having a link up is the only way for a client to tell if
> > Host B is configured or not).
> > 
> > 2) Given your assertion that these APIs should never reach across the
> > link, then one could say it should return align_size=4k. However, in
> > this situation the name is really confusing. And the fact that it has a
> > pidx argument makes no sense. And the way ntb_transport and ntb_perf use
> > it is wrong because they will end up masking the 64K size of mwB1 with
> > the 4k align_size from mwA1.
> > 
> > Does that make more sense?
> > 
> > Thanks,
> > 
> > Logan
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/000101d2ec53%24f2830840%24d78918c0%24%40dell.com.
> For more options, visit https://groups.google.com/d/optout.
