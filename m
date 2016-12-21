Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com. [2607:f8b0:4002:c05::244])
        by gmr-mx.google.com with ESMTPS id h18si770539ywc.2.2016.12.21.08.52.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:52:15 -0800 (PST)
Received: by mail-yw0-x244.google.com with SMTP id b66so13145627ywh.2
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:52:15 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:52:12 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: Fix 'request_irq()' and 'free_irq()' inconsistancy
Message-ID: <20161221165212.GC32599@kudzu.us>
References: <20161219055255.21418-1-christophe.jaillet@wanadoo.fr>
 <56b16dd5-b83b-e8b0-bf79-2dd2bc56f1e1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56b16dd5-b83b-e8b0-bf79-2dd2bc56f1e1@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, Xiangliang.Yu@amd.com, Allen.Hubbe@emc.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Dec 19, 2016 at 10:04:24AM -0700, Dave Jiang wrote:
> 
> 
> On 12/18/2016 10:52 PM, Christophe JAILLET wrote:
> > 'request_irq()' and 'free_irq()' should have the same 'dev_id'.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Acking the Intel driver portion.
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Applied to the ntb git branch

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/hw/amd/ntb_hw_amd.c     | 2 +-
> >  drivers/ntb/hw/intel/ntb_hw_intel.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > index 6ccba0d862df..a48c3e085eab 100644
> > --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > @@ -598,7 +598,7 @@ static int ndev_init_isr(struct amd_ntb_dev *ndev,
> >  
> >  err_msix_request:
> >  	while (i-- > 0)
> > -		free_irq(ndev->msix[i].vector, ndev);
> > +		free_irq(ndev->msix[i].vector, &ndev->vec[i]);
> >  	pci_disable_msix(pdev);
> >  err_msix_enable:
> >  	kfree(ndev->msix);
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > index 7310a261c858..2413600aae30 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > @@ -472,7 +472,7 @@ static int ndev_init_isr(struct intel_ntb_dev *ndev,
> >  
> >  err_msix_request:
> >  	while (i-- > 0)
> > -		free_irq(ndev->msix[i].vector, ndev);
> > +		free_irq(ndev->msix[i].vector, &ndev->vec[i]);
> >  	pci_disable_msix(pdev);
> >  err_msix_enable:
> >  	kfree(ndev->msix);
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/56b16dd5-b83b-e8b0-bf79-2dd2bc56f1e1%40intel.com.
> For more options, visit https://groups.google.com/d/optout.
