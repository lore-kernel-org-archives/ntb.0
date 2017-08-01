Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x244.google.com (mail-qk0-x244.google.com. [2607:f8b0:400d:c09::244])
        by gmr-mx.google.com with ESMTPS id q126si379699ywg.13.2017.08.01.10.33.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 10:33:17 -0700 (PDT)
Received: by mail-qk0-x244.google.com with SMTP id a77so2222906qkb.2
        for <linux-ntb@googlegroups.com>; Tue, 01 Aug 2017 10:33:17 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 1 Aug 2017 13:33:14 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: transport shouldn't disable link due to bogus
 values in SPADs
Message-ID: <20170801173313.GA3124@kudzu.us>
References: <150127984807.48385.10962784387437107365.stgit@djiang5-desk3.ch.intel.com>
 <000001d30a0b$d3b52b20$7b1f8160$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d30a0b$d3b52b20$7b1f8160$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 31, 2017 at 10:46:42AM -0400, Allen Hubbe wrote:
> From: Dave Jiang
> > It seems that under certain scenarios the SPAD can have bogus values caused
> > by an agent (i.e. BIOS or other software) that is not the kernel driver, and
> > that causes memory window setup failure. This should not cause the link to
> > be disabled because if we do that, the driver will never recover again. We
> > have verified in testing that this issue happens and prevents proper link
> > recovery.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Added to my ntb branch

Also, I added this line
Fixes: 84f766855f61 ("ntb: stop link work when we do not have memory")

Thanks,
Jon

> > ---
> >  drivers/ntb/ntb_transport.c |    4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 9a03c58..f0dd5a7 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -924,10 +924,8 @@ static void ntb_transport_link_work(struct work_struct *work)
> >  		ntb_free_mw(nt, i);
> > 
> >  	/* if there's an actual failure, we should just bail */
> > -	if (rc < 0) {
> > -		ntb_link_disable(ndev);
> > +	if (rc < 0)
> >  		return;
> > -	}
> > 
> >  out:
> >  	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
> > 
> > --
> > You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> > To unsubscribe from this group and stop receiving emails from it, send an email to linux-
> > ntb+unsubscribe@googlegroups.com.
> > To post to this group, send email to linux-ntb@googlegroups.com.
> > To view this discussion on the web visit https://groups.google.com/d/msgid/linux-
> > ntb/150127984807.48385.10962784387437107365.stgit%40djiang5-desk3.ch.intel.com.
> > For more options, visit https://groups.google.com/d/optout.
> 
