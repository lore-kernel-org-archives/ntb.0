Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com. [2607:f8b0:4002:c05::243])
        by gmr-mx.google.com with ESMTPS id r3si81337ywg.5.2016.12.21.08.40.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:40:43 -0800 (PST)
Received: by mail-yw0-x243.google.com with SMTP id a10so13149959ywa.1
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:40:43 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:40:41 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: correct ntb_peer_spad_read for case when callback
 is not supplied.
Message-ID: <20161221164040.GA32599@kudzu.us>
References: <2a1282ae9ad64a34b4795541a2c290b5@mspexmb1.Beer.Town>
 <b40a94020de44fb6974bfcc978d1ce52@mspexmb1.Beer.Town>
 <002101d25176$e14ac450$a3e04cf0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <002101d25176$e14ac450$a3e04cf0$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: "Wahl, Steve" <Steve.Wahl@dell.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 08, 2016 at 12:16:57PM -0500, Allen Hubbe wrote:
> From: Steven Wahl
> >
> > Signed-off-by: Steve Wahl <Steve.Wahl@dell.com>
> 
> The only thing lacking here is a commit comment, but the change is self-explanatory.  Thanks!
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

This didn't apply cleanly for some reason.  I hand applied it, as it
was a simple patch and duplicated the title into the body of the
commit.

Thanks,
Jon

> 
> > ---
> >  include/linux/ntb.h | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> > index 6f47562..816bd98 100644
> > --- a/include/linux/ntb.h
> > +++ b/include/linux/ntb.h
> > @@ -968,6 +968,9 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int idx,
> >   */
> >  static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int idx)
> >  {
> > +       if (!ntb->ops->peer_spad_read)
> > +               return 0;
> > +
> >         return ntb->ops->peer_spad_read(ntb, idx);
> >  }
> > 
> > --
> > 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/002101d25176%24e14ac450%24a3e04cf0%24%40dell.com.
> For more options, visit https://groups.google.com/d/optout.
