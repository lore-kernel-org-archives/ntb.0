Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com. [2607:f8b0:4002:c05::243])
        by gmr-mx.google.com with ESMTPS id p22si2094267ywe.3.2016.12.21.08.48.10
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:48:10 -0800 (PST)
Received: by mail-yw0-x243.google.com with SMTP id s68so13184641ywg.0
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:48:10 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:48:07 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_transport: Remove unnecessary call to
 ntb_peer_spad_read.
Message-ID: <20161221164807.GB32599@kudzu.us>
References: <297aec6b47924ce9889abe4d6c51c173@mspexmb1.Beer.Town>
 <89e7f17cb62a4a62a02673b10bf4a967@mspexmb1.Beer.Town>
 <002001d25176$da7cabc0$8f760340$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002001d25176$da7cabc0$8f760340$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: "Wahl, Steve" <Steve.Wahl@dell.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 08, 2016 at 12:16:45PM -0500, Allen Hubbe wrote:
> From: Steven Wahl 
> > The results were previously ignored, anyway.
> > 
> > Signed-off-by: Steve Wahl <Steve.Wahl@dell.com>
> 
> Fixes: e26a5843f7f5014ae4460030ca4de029a3ac35d3
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>


This patch also didn't apply cleanly.  I hand applied it, as it was a
simple patch.

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 4eb8adb..cd9a392 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -960,7 +960,6 @@ static void ntb_qp_link_work(struct work_struct *work)
> >         ntb_peer_spad_write(nt->ndev, QP_LINKS, val | BIT(qp->qp_num));
> > 
> >         /* query remote spad for qp ready bits */
> > -       ntb_peer_spad_read(nt->ndev, QP_LINKS);
> >         dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
> > 
> >         /* See if the remote side is up */
> > --
> > 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/002001d25176%24da7cabc0%248f760340%24%40dell.com.
> For more options, visit https://groups.google.com/d/optout.
