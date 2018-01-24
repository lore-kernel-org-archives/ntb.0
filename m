Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x22d.google.com (mail-qt0-x22d.google.com. [2607:f8b0:400d:c0d::22d])
        by gmr-mx.google.com with ESMTPS id k4si8278iti.1.2018.01.23.20.07.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jan 2018 20:07:31 -0800 (PST)
Received: by mail-qt0-x22d.google.com with SMTP id z11so7200807qtm.3
        for <linux-ntb@googlegroups.com>; Tue, 23 Jan 2018 20:07:31 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 23 Jan 2018 23:07:29 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_perf: Fix an error code in perf_copy_chunk()
Message-ID: <20180124040728.GC20474@kudzu.us>
References: <20180123083356.GC10091@mwanda>
 <20180123085531.GA17853@mobilestation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180123085531.GA17853@mobilestation>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Dan Carpenter <dan.carpenter@oracle.com>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Gary R Hook <gary.hook@amd.com>, Logan Gunthorpe <logang@deltatee.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jan 23, 2018 at 11:55:31AM +0300, Serge Semin wrote:
> On Tue, Jan 23, 2018 at 11:33:56AM +0300, Dan Carpenter <dan.carpenter@oracle.com> wrote:
> > We accidentally return success if dmaengine_submit() fails.  The fix is
> > to preserve the error code from dma_submit_error().
> > 
> 
> Yep, absolutely right. Thanks!
> 
> Acked-by: Serge Semin <fancer.lancer@gmail.com>

Applied to ntb-next

Thanks,
Jon

> 
> > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > 
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index 8de72f3fba4d..387e685063fc 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> > @@ -828,7 +828,8 @@ static int perf_copy_chunk(struct perf_thread *pthr,
> >  	tx->callback_param = pthr;
> >  	dma_set_unmap(tx, unmap);
> >  
> > -	if (dma_submit_error(dmaengine_submit(tx))) {
> > +	ret = dma_submit_error(dmaengine_submit(tx));
> > +	if (ret) {
> >  		dmaengine_unmap_put(unmap);
> >  		goto err_free_resource;
> >  	}
