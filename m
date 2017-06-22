Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id n194si131929itg.3.2017.06.22.15.49.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Jun 2017 15:49:28 -0700 (PDT)
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170619200659.GA20437@kudzu.us>
 <9615f074-5b81-210b-eb88-218a59d65198@deltatee.com>
 <000001d2eb85$daecdea0$90c69be0$@dell.com>
 <8a1ff94c-8689-0d4c-cc33-7b495daa065a@deltatee.com>
 <000101d2eba4$b45b1e40$1d115ac0$@dell.com>
 <aec6f161-eaf8-19cf-ee5a-155d67da38ba@deltatee.com>
 <000201d2eba8$dade4ac0$909ae040$@dell.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <4d932597-3592-2ce1-5a5f-cb5ba36a3a93@deltatee.com>
Date: Thu, 22 Jun 2017 16:49:16 -0600
MIME-Version: 1.0
In-Reply-To: <000201d2eba8$dade4ac0$909ae040$@dell.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: New NTB API Issue
To: Allen Hubbe <Allen.Hubbe@dell.com>, 'Jon Mason' <jdmason@kudzu.us>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, 'Dave Jiang' <dave.jiang@intel.com>, 'Serge Semin' <fancer.lancer@gmail.com>, 'Kurt Schwemmer' <kurt.schwemmer@microsemi.com>, 'Stephen Bates' <sbates@raithlin.com>, 'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
List-ID: <linux-ntb.googlegroups.com>

On 6/22/2017 4:42 PM, Allen Hubbe wrote:
> From: Logan Gunthorpe
>> Any thoughts on changing the semantics of mw_get_align so it must be
>> called with the link up?
>
> The intention of these is that these calls return information from the local port.  The calls themselves don't reach across the link to the peer, but the information returned from the local port needs to be communicated for setting up the translation end-to-end.

Ok, well if it's from the local port, then splitting up mw_get_range 
into peer_mw_get_addr and mw_get_align is confusing because one has the 
peer designation and the other doesn't. And all the clients apply the 
alignments to the remote bar so they'd technically need to transfer them 
across the link somehow.

> I would like to understand why this hardware needs link up.  Are there registers on the local port that are only valid after link up?

We only need the link up if we are trying to find the alignment 
requirements (and max_size) of the peer's bar. In theory, switchtec 
could have different sizes of bars on both sides of the link and 
different alignment requirements. Though, in practice, this is probably 
unlikely.

> Can you post snippets of how ntb_mw_get_align and ntb_peer_mw_get_addr might be implemented for the Switchtec?

Hmm, yes, but lets sort out my confusion on the semantics per above first.

Logan

