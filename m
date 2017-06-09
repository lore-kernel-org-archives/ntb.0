Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x241.google.com (mail-qt0-x241.google.com. [2607:f8b0:400d:c0d::241])
        by gmr-mx.google.com with ESMTPS id y7si141389ywd.8.2017.06.09.13.33.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 13:33:18 -0700 (PDT)
Received: by mail-qt0-x241.google.com with SMTP id w1so17487312qtg.0
        for <linux-ntb@googlegroups.com>; Fri, 09 Jun 2017 13:33:18 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 9 Jun 2017 16:33:15 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: Correct modinfo usage statement for ntb_perf
Message-ID: <20170609203315.GA9847@kudzu.us>
References: <20170504163652.6904.47683.stgit@taos.amd.com>
 <c8b3198e-e38a-05a4-fa31-a8d074888f01@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8b3198e-e38a-05a4-fa31-a8d074888f01@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com, Allen.Hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, May 04, 2017 at 09:47:44AM -0700, Dave Jiang wrote:
> 
> 
> On 05/04/2017 09:36 AM, Gary R Hook wrote:
> > The order parameters are powers of 2; adjust the usage information
> > to use correct mathematical representations.
> > 
> > Signed-off-by: Gary R Hook <gary.hook@amd.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Sorry, I think I missed this one.  Adding to my ntb branch with the
following line

Fixes: 8a7b6a778a85 ("ntb: ntb perf tool")

This enables the stable kernels it is a bug fix and to pick it up.

> 
> > ---
> >  drivers/ntb/test/ntb_perf.c |    4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> > index 9c4a21f1a9d9..42756a98a728 100644
> > --- a/drivers/ntb/test/ntb_perf.c
> > +++ b/drivers/ntb/test/ntb_perf.c
> > @@ -91,11 +91,11 @@
> >  
> >  static unsigned int seg_order = 19; /* 512K */
> >  module_param(seg_order, uint, 0644);
> > -MODULE_PARM_DESC(seg_order, "size order [n^2] of buffer segment for testing");
> > +MODULE_PARM_DESC(seg_order, "size order [2^n] of buffer segment for testing");
> >  
> >  static unsigned int run_order = 32; /* 4G */
> >  module_param(run_order, uint, 0644);
> > -MODULE_PARM_DESC(run_order, "size order [n^2] of total data to transfer");
> > +MODULE_PARM_DESC(run_order, "size order [2^n] of total data to transfer");
> >  
> >  static bool use_dma; /* default to 0 */
> >  module_param(use_dma, bool, 0644);
> > 
