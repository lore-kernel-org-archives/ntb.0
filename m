Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com. [2607:f8b0:400d:c0d::241])
        by gmr-mx.google.com with ESMTPS id y7si146697ywd.8.2017.06.09.14.09.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 14:09:56 -0700 (PDT)
Received: by mail-qt0-x241.google.com with SMTP id s33so17743751qtg.3
        for <linux-ntb@googlegroups.com>; Fri, 09 Jun 2017 14:09:56 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 9 Jun 2017 17:09:54 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_transport: fix qp count bug
Message-ID: <20170609210954.GD9847@kudzu.us>
References: <20170605200053.6912-1-logang@deltatee.com>
 <20170605200053.6912-2-logang@deltatee.com>
 <000201d2dec6$08e211d0$1aa63570$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000201d2dec6$08e211d0$1aa63570$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 06, 2017 at 09:08:47AM -0400, Allen Hubbe wrote:
> From: Logan Gunthorpe
> > In cases where there are more mw's than spads/2-2, the mw count gets
> > reduced to match the limitation. ntb_transport also tries to ensure that
> > there are fewer qps than mws but uses the full mw count instead of
> > the reduced one. When this happens, the math in
> > 'ntb_transport_setup_qp_mw' will get confused and result in a kernel
> > paging request bug.
> > 
> > This patch fixes the bug by reducing qp_count to the reduced mw count
> > instead of the full mw count.
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
> > index 02ca45fdd892..0a778d2cab94 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1128,8 +1128,8 @@ static int ntb_transport_probe(struct ntb_client *self, struct
> > ntb_dev *ndev)
> >  	qp_count = ilog2(qp_bitmap);
> >  	if (max_num_clients && max_num_clients < qp_count)
> >  		qp_count = max_num_clients;
> > -	else if (mw_count < qp_count)
> > -		qp_count = mw_count;
> > +	else if (nt->mw_count < qp_count)
> > +		qp_count = nt->mw_count;
> > 
> >  	qp_bitmap &= BIT_ULL(qp_count) - 1;
> > 
> > --
> > 2.11.0
> 
> 
