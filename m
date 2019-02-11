Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc33.google.com (mail-yw1-xc33.google.com. [2607:f8b0:4864:20::c33])
        by gmr-mx.google.com with ESMTPS id m189si514907pfb.0.2019.02.11.06.35.01
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:35:01 -0800 (PST)
Received: by mail-yw1-xc33.google.com with SMTP id n12so4229561ywn.13
        for <linux-ntb@googlegroups.com>; Mon, 11 Feb 2019 06:35:01 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 11 Feb 2019 09:34:58 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: ntb_transport: Free MWs in
 ntb_transport_link_cleanup()
Message-ID: <20190211143458.GA13951@kudzu.us>
References: <1546830776-3138-1-git-send-email-joey.zhang@microchip.com>
 <2dccf9e6-d9d7-200e-f689-56c962ea5e7e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2dccf9e6-d9d7-200e-f689-56c962ea5e7e@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: Joey Zhang <joey.zhang@microchip.com>, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jan 07, 2019 at 06:16:02PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 06/01/19 08:12 PM, Joey Zhang wrote:
> > If NTB peer host crashes or reboots, the NTB transport link will be
> > down and the MWs of NTB transport will be invalid. But the
> > ntb_transport_link_cleanup() does not free these invalid MWs. When
> > the NTB peer host is recovered later, NTB transport link will be
> > up and the ntb_set_mw() will not reset up MWs. Because the MWs of
> > NTB transport are invalid, the NTB transport will not work.
> > 
> > We can fix it by freeing MWs when NTB transport link is down, then
> > the ntb_set_mw() will reset up MWs when NTB transport link is up.
> > 
> > Signed-off-by: Joey Zhang <joey.zhang@microchip.com>
> 
> Looks ok to me.

Added to the ntb branch, thanks!

> Reviewed By: Logan Gunthorpe <logang@deltatee.com>

Looks like your missed the '-' ;-)
I took the liberity of adding it

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 3bfdb45..6e8902d 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -862,6 +862,9 @@ static void ntb_transport_link_cleanup(struct ntb_transport_ctx *nt)
> >  	if (!nt->link_is_up)
> >  		cancel_delayed_work_sync(&nt->link_work);
> >  
> > +	for (i = 0; i < nt->mw_count; i++)
> > +		ntb_free_mw(nt, i);
> > +
> >  	/* The scratchpad registers keep the values if the remote side
> >  	 * goes down, blast them now to give them a sane value the next
> >  	 * time they are accessed
> > 
