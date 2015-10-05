Return-Path: <jdmason@kudzu.us>
Received: from mail-qg0-f44.google.com (mail-qg0-f44.google.com. [209.85.192.44])
        by gmr-mx.google.com with ESMTPS id i77si2229093ywg.4.2015.10.04.19.30.57
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Oct 2015 19:30:57 -0700 (PDT)
Received: by qgt47 with SMTP id 47so138219816qgt.2
        for <linux-ntb@googlegroups.com>; Sun, 04 Oct 2015 19:30:57 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 4 Oct 2015 22:29:08 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: unify translation addresses
Message-ID: <20151005022907.GA5256@kudzu.us>
References: <20150924200304.3052.96889.stgit@djiang5-desk3.ch.intel.com>
 <00c401d0f706$786a4800$693ed800$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00c401d0f706$786a4800$693ed800$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Sep 24, 2015 at 04:20:34PM -0400, Allen Hubbe wrote:
> From: Dave Jiang [dave.jiang@intel.com]
> > There is no need for the upstream and downstream addresses to be
> > different
> > for the NTB configs. Go to using a single set of address. It is still
> > possible to configure them differently using module parameter override
> > however.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Thanks for leaving in the separately configurable usd/dsd addrs, even though the defaults are now the same.
> 
> Acked and (pick one)
> Tested-by: Allen Hubbe <Allen.Hubbe@emc.com>

Since this is changing existing behavior, I'm going to push this one
into ntb-next (for 4.4).

Thanks,
Jon

> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/00c401d0f706%24786a4800%24693ed800%24%40emc.com.
> For more options, visit https://groups.google.com/d/optout.
