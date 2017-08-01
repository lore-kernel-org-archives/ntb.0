Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x22f.google.com (mail-qt0-x22f.google.com. [2607:f8b0:400d:c0d::22f])
        by gmr-mx.google.com with ESMTPS id e186si1581006ywh.4.2017.08.01.11.28.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Aug 2017 11:28:15 -0700 (PDT)
Received: by mail-qt0-x22f.google.com with SMTP id 16so14122422qtz.4
        for <linux-ntb@googlegroups.com>; Tue, 01 Aug 2017 11:28:15 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 1 Aug 2017 14:28:12 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v3 06/16] ntb: ensure ntb_mw_get_align() is only called
 when the link is up
Message-ID: <20170801182812.GG4186@kudzu.us>
References: <20170725205753.4735-1-logang@deltatee.com>
 <20170725205753.4735-7-logang@deltatee.com>
 <20170801181452.GE4186@kudzu.us>
 <c4235dc9-90d0-1e68-7c73-c2a5bec83712@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4235dc9-90d0-1e68-7c73-c2a5bec83712@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Stephen Bates <sbates@raithlin.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Aug 01, 2017 at 12:17:47PM -0600, Logan Gunthorpe wrote:
> Hey,
> 
> On 01/08/17 12:14 PM, Jon Mason wrote:
> > This also looks like a bug fix.  However, given that it is a little more
> > invasive and no one reporting any problems with it, I'm less apt to
> > pull it into the bug-fixes branch without anyone compilaining of a
> > bug (lest I break something in -stable).
> 
> Yes, 6 and 7 change a semantic of that function. I wouldn't call them
> bug fixes. But you can't pull 7 without pulling 6, as 7 would break
> everything unless the change in 6 occurs.

Okay, then I'll hold off on 7 then.  It wasn't clear to me, based on
the patch descriptions, that this was fallout from the previous patch.
Thanks for clearing this up for me.

Thanks,
Jon

> 
> Thanks,
> 
> Logan
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/c4235dc9-90d0-1e68-7c73-c2a5bec83712%40deltatee.com.
> For more options, visit https://groups.google.com/d/optout.
