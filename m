Return-Path: <jdmason@kudzu.us>
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com. [2607:f8b0:4002:c09::244])
        by gmr-mx.google.com with ESMTPS id u66si2073948ywg.1.2016.12.21.08.58.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:58:39 -0800 (PST)
Received: by mail-yb0-x244.google.com with SMTP id s74so618540ybi.3
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:58:39 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:58:36 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 2/2] NTB: Register and offset values fix for memory window
Message-ID: <20161221165836.GG32599@kudzu.us>
References: <7f3cc2fa-7899-a387-4822-d515c403fcfa@amd.com>
 <000001d24c42$f407cc70$dc176550$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d24c42$f407cc70$dc176550$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Shyam Sundar S K' <ssundark@amd.com>, "'Yu, Xiangliang'" <Xiangliang.Yu@amd.com>, 'Dave Jiang' <dave.jiang@intel.com>, "'Shah, Nehal-bakulchandra'" <Nehal-bakulchandra.Shah@amd.com>, "'Sen, Pankaj'" <Pankaj.Sen@amd.com>, "'Agrawal, Nitesh-kumar'" <Nitesh-kumar.Agrawal@amd.com>, "'Su, Richard (Bin)'" <Richard1.Su@amd.com>, "'Subramaniyan, Ramkumar'" <ramkumar.ks@amd.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Dec 01, 2016 at 09:22:37PM -0500, Allen Hubbe wrote:
> From: Shyam Sundar S K
> > Due to incorrect limit and translation register values, NTB link was
> > going down when the memory window was setup. Made appropriate changes
> > as per spec.
> > 
> > Fix limit register values for BAR1, which was overlapping
> > with the BAR23 address.
> > 
> > Reviewed-by: Sen, Pankaj <Pankaj.Sen@amd.com>
> > Reviewed-by: Shah, Nehal-bakulchandra <Nehal-bakulchandra.Shah@amd.com>
> > Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> > Signed-off-by: S-k, Shyam-sundar <Shyam-sundar.S-k@amd.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Applied to my NTB branch

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/hw/amd/ntb_hw_amd.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > index 6ccba0d..d59f494 100644
> > --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> > +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> > @@ -138,11 +138,11 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> >  	base_addr = pci_resource_start(ndev->ntb.pdev, bar);
> > 
> >  	if (bar != 1) {
> > -		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 3);
> > -		limit_reg = AMD_BAR23LMT_OFFSET + ((bar - 2) << 3);
> > +		xlat_reg = AMD_BAR23XLAT_OFFSET + ((bar - 2) << 2);
> > +		limit_reg = AMD_BAR23LMT_OFFSET + ((bar - 2) << 2);
> > 
> >  		/* Set the limit if supported */
> > -		limit = base_addr + size;
> > +		limit = size;
> > 
> >  		/* set and verify setting the translation address */
> >  		write64(addr, peer_mmio + xlat_reg);
> > @@ -164,14 +164,8 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int idx,
> >  		xlat_reg = AMD_BAR1XLAT_OFFSET;
> >  		limit_reg = AMD_BAR1LMT_OFFSET;
> > 
> > -		/* split bar addr range must all be 32 bit */
> > -		if (addr & (~0ull << 32))
> > -			return -EINVAL;
> > -		if ((addr + size) & (~0ull << 32))
> > -			return -EINVAL;
> > -
> >  		/* Set the limit if supported */
> > -		limit = base_addr + size;
> > +		limit = size;
> > 
> >  		/* set and verify setting the translation address */
> >  		write64(addr, peer_mmio + xlat_reg);
> > --
> > 2.7.4
> 
