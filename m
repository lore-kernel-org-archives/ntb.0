Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c139si79980itb.2.2017.06.22.09.17.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 09:17:50 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170619200659.GA20437@kudzu.us>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
Date: Thu, 22 Jun 2017 10:17:43 -0600
MIME-Version: 1.0
In-Reply-To: <20170619200659.GA20437@kudzu.us>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: New NTB API Issue
To: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

Hey Guys,

I've run into some subtle issues with the new API:

It has to do with splitting mw_get_range into mw_get_align and
peer_mw_get_addr.

The original mw_get_range returned the size of the /local/ memory
window's size, address and alignment requirements. The ntb clients then
take the local size and transmit it via spads to the peer which would
use it in setting up the memory window. However, it made the assumption
that the alignment restrictions were symmetric on both hosts seeing they
were not sent across the link.

The new API makes a sensible change for this in that mw_get_align
appears to be intended to return the alignment restrictions (and now
size) of the peer. This helps a bit for the Switchtec driver but appears
to be a semantic change that wasn't really reflected in the changes to
the other NTB code. So, I see a couple of issues:

1) With our hardware, we can't actually know anything about the peer's
memory windows until the peer has finished its setup (ie. the link is
up). However, all the clients call the function during probe, before the
link is ready. There's really no good reason for this, so I think we
should change the clients so that mw_get_align is called only when the
link is up.

2) The changes to the Intel and AMD driver for mw_get_align sets
*max_size to the local pci resource size. (Thus making the assumption
that the local is the same as the peer, which is wrong). max_size isn't
actually used for anything so it's not _really_ an issue, but I do think
it's confusing and incorrect. I'd suggest we remove max_size until
something actually needs it, or at least set it to zero in cases where
the hardware doesn't support returning the size of the peer's memory
window (ie. in the Intel and AMD drivers).

Thoughts?

Logan
