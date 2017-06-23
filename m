Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 23si249582ith.6.2017.06.23.09.51.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Jun 2017 09:51:12 -0700 (PDT)
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
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <5aa9c438-e152-4caa-2c6d-cbbd130a0eb2@deltatee.com>
Date: Fri, 23 Jun 2017 10:51:03 -0600
MIME-Version: 1.0
In-Reply-To: <000001d2ec23$2bd9f300$838dd900$@dell.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: New NTB API Issue
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>



On 23/06/17 07:18 AM, Allen Hubbe wrote:
> By "remote" do you mean the source or destination of a write?

Look at how these calls are used in ntb_transport and ntb_perf:

They both call ntb_peer_mw_get_addr to get the size of the BAR. The size
is sent via spads to the other side. The other side then uses
ntb_mw_get_align and applies align_size to the received size.

> Yes, clients should transfer the address and size information to the peer.

But then they also need to technically transfer the alignment
information as well. Which neither of the clients do.

> Maybe this is the confusion.  None of these api calls are to reach across to the peer port, as to get the size of the peer's bar.  They are to get information from the local port, or to configure the local port.

I like the rule that these api calls are not to reach across the port.
But then API looks very wrong. Why are we calling one peer_mw_get addr
and the other mw_get_align? And why does mw_get_align have a peer index?


> Some snippets of code would help me understand your interpretation of the api semantics more exactly.

I'm not sure the code to best show this in code, but let me try
describing an example situation:

Lets say we have the following mws on each side (this is something that
is possible with Switchtec hardware):

Host A BARs:
mwA0: 2MB size, aligned to 4k, size aligned to 4k
mwA1: 4MB size, aligned to 4k, size aligned to 4k
mwA2: 64k size, aligned to 64k, size aligned to 64k

Host B BARs:
mwB0: 2MB size, aligned to 4k, size aligned to 4k
mwB1: 64k size, aligned to 64k, size aligned to 64k

So on Host A: peer_mw_get_addr(idx=1) should return size=4M (from mwA1),
but it's not clear what mw_get_align(widx=1) should do. I see two
possibilities:

1) Given that it has the opposite sense of peer_mw_get_addr (ie. there
is no peer in it's name) and that this new api also has a peer index, it
should return align_size=64k (from mwB1). However, in order to do this,
Host B must be fully configured (technically the link doesn't have to be
fully up, but having a link up is the only way for a client to tell if
Host B is configured or not).

2) Given your assertion that these APIs should never reach across the
link, then one could say it should return align_size=4k. However, in
this situation the name is really confusing. And the fact that it has a
pidx argument makes no sense. And the way ntb_transport and ntb_perf use
it is wrong because they will end up masking the 64K size of mwB1 with
the 4k align_size from mwA1.

Does that make more sense?

Thanks,

Logan


