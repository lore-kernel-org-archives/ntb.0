Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com. [2607:f8b0:4864:20::843])
        by gmr-mx.google.com with ESMTPS id u9si555570ilg.0.2020.08.24.07.48.51
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:48:51 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id k18so6299841qtm.10
        for <linux-ntb@googlegroups.com>; Mon, 24 Aug 2020 07:48:51 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 24 Aug 2020 10:48:45 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb: intel: Fix memleak in intel_ntb_pci_probe
Message-ID: <20200824144844.GA27238@kudzu.us>
References: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
 <396e55a5-7ebe-1e81-b1b6-9a53cd885a8a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <396e55a5-7ebe-1e81-b1b6-9a53cd885a8a@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Mon, Aug 24, 2020 at 07:37:56AM -0700, Dave Jiang wrote:
> 
> 
> On 8/22/2020 11:55 PM, Dinghao Liu wrote:
> > The default error branch of a series of pdev_is_gen calls
> > should free ndev just like what we've done in these calls.
> > 
> > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> 
> Thanks Dinghao
> Acked-by: Dave Jiang <dave.jiang@intel.com>

Added to my ntb branch.
I added 
    Fixes: 26bfe3d0b227 ("ntb: intel: Add Icelake (gen4) support for Intel NTB")

Thanks,
Jon


> 
> > ---
> >   drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > index 3185efeab487..093dd20057b9 100644
> > --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> > @@ -1893,7 +1893,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
> >   			goto err_init_dev;
> >   	} else {
> >   		rc = -EINVAL;
> > -		goto err_ndev;
> > +		goto err_init_pci;
> >   	}
> >   	ndev_reset_unsafe_flags(ndev);
> > 
