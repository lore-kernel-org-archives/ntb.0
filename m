Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com. [2607:f8b0:400d:c0d::243])
        by gmr-mx.google.com with ESMTPS id o187si140137ywd.1.2017.06.09.14.09.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 14:09:17 -0700 (PDT)
Received: by mail-qt0-x243.google.com with SMTP id s33so17740506qtg.3
        for <linux-ntb@googlegroups.com>; Fri, 09 Jun 2017 14:09:17 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 9 Jun 2017 17:09:09 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_transport: fix bug calculating num_qps_mw
Message-ID: <20170609210908.GC9847@kudzu.us>
References: <20170605200053.6912-1-logang@deltatee.com>
 <20170605200053.6912-3-logang@deltatee.com>
 <000101d2dec6$0648f060$12dad120$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d2dec6$0648f060$12dad120$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 06, 2017 at 09:08:43AM -0400, Allen Hubbe wrote:
> From: Logan Gunthorpe
> > A divide by zero error occurs if qp_count is less than mw_count because
> > num_qps_mw is calculated to be zero. The calculation appears to be
> > incorrect.
> > 
> > The requirement is for num_qps_mw to be set to qp_count / mw_count
> > with any remainder divided among the earlier mws.
> > 
> > For example, if mw_count is 5 and qp_count is 12 then mws 0 and 1
> > will have 3 qps per window and mws 2 through 4 will have 2 qps per window.
> > Thus, when mw_num < qp_count % mw_count, num_qps_mw is 1 higher
> > than when mw_num >= qp_count.
> > 
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Jon Mason <jdmason@kudzu.us>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Adding to my ntb branch with the following line:
Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")

This enables the stable kernels it is a bug fix and to pick it up.

Thanks,
Jon
> 
> > ---
> >  drivers/ntb/ntb_transport.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index 0a778d2cab94..5b6b00ea6ed9 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -623,7 +623,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
> >  	if (!mw->virt_addr)
> >  		return -ENOMEM;
> > 
> > -	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
> > +	if (mw_num < qp_count % mw_count)
> >  		num_qps_mw = qp_count / mw_count + 1;
> >  	else
> >  		num_qps_mw = qp_count / mw_count;
> > @@ -1000,7 +1000,7 @@ static int ntb_transport_init_queue(struct ntb_transport_ctx *nt,
> >  	qp->event_handler = NULL;
> >  	ntb_qp_link_down_reset(qp);
> > 
> > -	if (qp_count % mw_count && mw_num + 1 < qp_count / mw_count)
> > +	if (mw_num < qp_count % mw_count)
> >  		num_qps_mw = qp_count / mw_count + 1;
> >  	else
> >  		num_qps_mw = qp_count / mw_count;
> > --
> > 2.11.0
> 
> 
