Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id w195si253289ywa.13.2017.06.23.12.07.42
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 12:07:42 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170615203729.9009-1-logang@deltatee.com> <20170619200659.GA20437@kudzu.us> <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com> <000001d2eb85$daecdea0$90c69be0$@dell.com> <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com> <000101d2eba4$b45b1e40$1d115ac0$@dell.com> <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com> <000201d2eba8$dade4ac0$909ae040$@dell.com> <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com> <000001d2ec23$2bd9f300$838dd900$@dell.com> <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
In-Reply-To: <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
Subject: RE: New NTB API Issue
Date: Fri, 23 Jun 2017 15:07:19 -0400
Message-ID: <000101d2ec53$f2830840$d78918c0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> On 23/06/17 07:18 AM, Allen Hubbe wrote:
> > By "remote" do you mean the source or destination of a write?
>=20
> Look at how these calls are used in ntb_transport and ntb_perf:
>=20
> They both call ntb_peer_mw_get_addr to get the size of the BAR. The =
size
> is sent via spads to the other side. The other side then uses
> ntb_mw_get_align and applies align_size to the received size.
>=20
> > Yes, clients should transfer the address and size information to the =
peer.
>=20
> But then they also need to technically transfer the alignment
> information as well. Which neither of the clients do.

The client's haven't been fully ported to the multi-port api yet.  They =
were only minimally changed to call the new api, but so far other than =
that they have only been made to work as they had before.

> > Maybe this is the confusion.  None of these api calls are to reach =
across to the peer port, as to
> get the size of the peer's bar.  They are to get information from the =
local port, or to configure the
> local port.
>=20
> I like the rule that these api calls are not to reach across the port.
> But then API looks very wrong. Why are we calling one peer_mw_get addr
> and the other mw_get_align? And why does mw_get_align have a peer =
index?

I regret that the term "peer" is used to distinguish the mw api.  Better =
names perhaps should be ntb_outbound_mw_foo, ntb_inbound_mw_foo; or =
ntb_src_mw_foo, ntb_dest_mw_foo.  I like outbound/inbound, although the =
names are longer, maybe out/in would be ok.

> And why does mw_get_align have a peer index?

Good question.  Serge?

For that matter, why do we not also have peer mw idx in the set of =
parameters.  Working through the example below, it looks like we are =
lacking a way to say Outbound MW1 on A corresponds with Inbound MW0 on =
B.  It looks like we can only indicate that Port A (not which Outbound =
MW of Port A) corresponds with Inbound MW0 on B.

> > Some snippets of code would help me understand your interpretation =
of the api semantics more
> exactly.
>=20
> I'm not sure the code to best show this in code, but let me try
> describing an example situation:
>=20
> Lets say we have the following mws on each side (this is something =
that
> is possible with Switchtec hardware):
>=20
> Host A BARs:
> mwA0: 2MB size, aligned to 4k, size aligned to 4k
> mwA1: 4MB size, aligned to 4k, size aligned to 4k
> mwA2: 64k size, aligned to 64k, size aligned to 64k
>=20
> Host B BARs:
> mwB0: 2MB size, aligned to 4k, size aligned to 4k
> mwB1: 64k size, aligned to 64k, size aligned to 64k

If those are BARs, that corresponds to "outbound", writing something to =
the BAR at mwA0.

A more complete picture might be:

Host A BARs (aka "outbound" or "peer" memory windows):
peer_mwA0: resource at 0xA00000000 - 0xA00200000 (2MB)
peer_mwA1: resource at 0xA10000000 - 0xA10400000 (4MB)
peer_mwA2: resource at 0xA20000000 - 0xa20010000 (64k)

Host A MWs (aka "inbound" memory windows):
mwA0: 64k max size, aligned to 64k, size aligned to 64k
mwA1: 2MB max size, aligned to 4k, size aligned to 4k

Host A sees Host B on port index 1


Host B BARs (aka "outbound" or "peer" memory windows):
peer_mwB0: resource at 0xB00000000 - 0xB00200000 (2MB)
peer_mwB1: resource at 0xB10000000 - 0xB10010000 (64k)

Host B MWs (aka "inbound" memory windows):
mwB0: 1MB size, aligned to 4k, size aligned to 4k
mwB1: 2MB size, aligned to 4k, size aligned to 4k

Host B sees Host A on port index 4


Outbound memory (aka "peer mw") windows come with a pci resource.  We =
can get the size of the resource, it's physical address, and set up =
outbound translation if the hardware has that (IDT).

Inbound memory windows (aka "mw") are only used to set up inbound =
translation, if the hardware has that (Intel, AMD).

To set up end-to-end memory window so that A can write to B, let's use =
peer_mwA1 and mwB0.

A: ntb_peer_mw_get_addr(peer_mwA1) -> base 0xA10000000, size 4MB
B: ntb_mw_get_align(port4**, mwB0) -> aligned 4k, aligned 4k, max size =
1MB
** Serge: do we need port info here, why?

Side A has a resource size of 4MB, but B only supports inbound =
translation up to 1MB.  Side A can only use the first quarter of the 4MB =
resource.

Side B needs to allocate memory aligned to 4k (the dma address must be =
aligned to 4k after dma mapping), and a multiple of 4k in size.  B may =
need to set inbound translation so that incoming writes go into this =
memory.  A may also need to set outbound translation.

A: ntb_peer_mw_set_trans(port1**, peer_mwA1, dma_mem_addr, dma_mem_size)
B: ntb_mw_set_trans(port4**, mwB0, dma_mem_addr, dma_mem_size)
** Serge: do we also need the opposing side MW index here?

** Logan: would those changes to the api suit your needs?

> So on Host A: peer_mw_get_addr(idx=3D1) should return size=3D4M (from =
mwA1),
> but it's not clear what mw_get_align(widx=3D1) should do. I see two
> possibilities:
>=20
> 1) Given that it has the opposite sense of peer_mw_get_addr (ie. there
> is no peer in it's name) and that this new api also has a peer index, =
it
> should return align_size=3D64k (from mwB1). However, in order to do =
this,
> Host B must be fully configured (technically the link doesn't have to =
be
> fully up, but having a link up is the only way for a client to tell if
> Host B is configured or not).
>=20
> 2) Given your assertion that these APIs should never reach across the
> link, then one could say it should return align_size=3D4k. However, in
> this situation the name is really confusing. And the fact that it has =
a
> pidx argument makes no sense. And the way ntb_transport and ntb_perf =
use
> it is wrong because they will end up masking the 64K size of mwB1 with
> the 4k align_size from mwA1.
>=20
> Does that make more sense?
>=20
> Thanks,
>=20
> Logan
>=20

