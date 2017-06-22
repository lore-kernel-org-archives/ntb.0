Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z4si132764ita.5.2017.06.22.15.19.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 15:19:21 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170619200659.GA20437@kudzu.us>
 <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
 <000001d2eb85$daecdea0$90c69be0$@dell.com>
 <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
 <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
Date: Thu, 22 Jun 2017 16:19:09 -0600
MIME-Version: 1.0
In-Reply-To: <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: New NTB API Issue
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

On 6/22/2017 4:12 PM, Allen Hubbe wrote:
> The resource size given by peer_mw_get_addr might be different than the max_size given by ntb_mw_get_align.
>
> I am most familiar with the ntb_hw_intel driver and that type of ntb hardware.  The peer_mw_get_addr size is of the primary bar on the side to be the source of the translated writes (or reads).  In b2b topology, at least, the first translation of that write lands it on the secondary bar of the peer ntb.  That size of that bar could different than the first.  The second translation lands the write in memory (eg).  So, the end-to-end translation is limited by the first AND second sizes.
>
> The first point is, the *max_size returned by intel_ntb_mw_get_align looks wrong.  That should be the size of the secondary bar, not the resource size of the primary bar, of that device.
>
> The second point is, because the sizes returned by peer_mw_get_addr, and ntb_mw_get_align, may be different, the two sides should communicate and reconcile the address and size information when setting up the translations.

Ok, that makes some sense. So drivers that don't need this should return 
-1 or something like that? Though, I'd still suggest that until a driver 
actually needs this, and it's implemented correctly in the clients, we 
should leave it out.

Any thoughts on changing the semantics of mw_get_align so it must be 
called with the link up?

Logan




