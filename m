Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com. [2607:f8b0:400d:c0d::241])
        by gmr-mx.google.com with ESMTPS id o206si127892ywb.12.2017.06.09.14.08.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 14:08:23 -0700 (PDT)
Received: by mail-qt0-x241.google.com with SMTP id x58so17723269qtc.2
        for <linux-ntb@googlegroups.com>; Fri, 09 Jun 2017 14:08:23 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 9 Jun 2017 17:08:20 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2] ntb: ntb_hw_intel: Skylake doorbells should be
 32bits, not 64bits
Message-ID: <20170609210819.GB9847@kudzu.us>
References: <149695115133.26451.13997592259493006219.stgit@djiang5-desk3.ch.intel.com>
 <000001d2e127$7fb8d740$7f2a85c0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d2e127$7fb8d740$7f2a85c0$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com, ujjal.singh@intel.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 09, 2017 at 09:51:30AM -0400, Allen Hubbe wrote:
> From: Dave Jiang 
> > Fixing doorbell register length to 32bits per spec. On Skylake NTB, the
> > doorbell registers are 32bit write only registers. The source for the doorbell is
> > a 64bit register that shows the interrupt bits.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Adding to my ntb branch with the following line:
Fixes: 783dfa6cc41b ("ntb: Adding Skylake Xeon NTB support")

This enables the stable kernels it is a bug fix and to pick it up.

Thanks,
Jon

> 
> > ---
> > 
> > v2: Allen: remove unnecessary change to code.
> > 
> >  drivers/ntb/hw/intel/ntb_hw_intel.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c
> > b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > index c002384..7b3b6fd 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > @@ -2878,7 +2878,7 @@ static const struct intel_ntb_reg skx_reg = {
> >  	.link_is_up		= xeon_link_is_up,
> >  	.db_ioread		= skx_db_ioread,
> >  	.db_iowrite		= skx_db_iowrite,
> > -	.db_size		= sizeof(u64),
> > +	.db_size		= sizeof(u32),
> >  	.ntb_ctl		= SKX_NTBCNTL_OFFSET,
> >  	.mw_bar			= {2, 4},
> >  };
> 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/000001d2e127%247fb8d740%247f2a85c0%24%40dell.com.
> For more options, visit https://groups.google.com/d/optout.
