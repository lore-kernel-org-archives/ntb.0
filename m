Return-Path: <jdmason@kudzu.us>
Received: from mail-yb0-x241.google.com (mail-yb0-x241.google.com. [2607:f8b0:4002:c09::241])
        by gmr-mx.google.com with ESMTPS id b67si1036364ywc.2.2016.11.01.13.33.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Nov 2016 13:33:33 -0700 (PDT)
Received: by mail-yb0-x241.google.com with SMTP id f97so2552265ybi.1
        for <linux-ntb@googlegroups.com>; Tue, 01 Nov 2016 13:33:33 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Tue, 1 Nov 2016 16:33:31 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: ntb_hw_intel: init peer_addr in struct intel_ntb_dev
Message-ID: <20161101203330.GA25928@kudzu.us>
References: <147207338678.160450.10674653800874976448.stgit@djiang5-desk3.ch.intel.com>
 <000101d1fe53$8112f920$8338eb60$@emc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000101d1fe53$8112f920$8338eb60$@emc.com>
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Aug 24, 2016 at 06:04:36PM -0400, Allen Hubbe wrote:
> From: Dave Jiang
> > The peer_addr member of intel_ntb_dev is not set, therefore when
> > acquiring ntb_peer_db and ntb_peer_spad we only get the offset rather
> > than the actual physical address. Adding fix to correct that.
> > 
> > Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@emc.com>

Sorry for missing this one.  In my tree now.

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/hw/intel/ntb_hw_intel.c |    3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > index 40d04ef..3ad1f15 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_intel.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
> > @@ -1718,6 +1718,8 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
> >  					    XEON_B2B_MIN_SIZE);
> >  		if (!ndev->peer_mmio)
> >  			return -EIO;
> > +
> > +		ndev->peer_addr = pci_resource_start(pdev, b2b_bar);
> >  	}
> > 
> >  	return 0;
> > @@ -1982,6 +1984,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct
> > pci_dev *pdev)
> >  		goto err_mmio;
> >  	}
> >  	ndev->peer_mmio = ndev->self_mmio;
> > +	ndev->peer_addr = pci_resource_start(pdev, 0);
> > 
> >  	return 0;
> > 
> 
> 
