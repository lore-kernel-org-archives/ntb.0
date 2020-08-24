Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com. [2607:f8b0:4864:20::843])
        by gmr-mx.google.com with ESMTPS id u9si557737ilg.0.2020.08.24.07.58.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:58:59 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id v91so964832qte.2
        for <linux-ntb@googlegroups.com>; Mon, 24 Aug 2020 07:58:59 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 24 Aug 2020 10:58:38 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH][next] NTB: Use struct_size() helper in devm_kzalloc()
Message-ID: <20200824145837.GC27238@kudzu.us>
References: <20200619172514.GA1074@embeddedor>
 <268330b2-e42b-4d62-1ff0-8462d68e498e@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <268330b2-e42b-4d62-1ff0-8462d68e498e@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Jun 19, 2020 at 01:10:55PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2020-06-19 11:25 a.m., Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes. Also, remove unnecessary
> > variable _struct_size_.
> > 
> > This code was detected with the help of Coccinelle and, audited and
> > fixed manually.
> > 
> > Addresses-KSPP-ID: https://github.com/KSPP/linux/issues/83
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Cool, I didn't know that existed! Thanks!
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Added to the ntb-next branch.

Thanks,
Jon


> 
> > ---
> >  drivers/ntb/test/ntb_msi_test.c | 5 +----
> >  1 file changed, 1 insertion(+), 4 deletions(-)
> > 
> > diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
> > index 99d826ed9c34..7095ecd6223a 100644
> > --- a/drivers/ntb/test/ntb_msi_test.c
> > +++ b/drivers/ntb/test/ntb_msi_test.c
> > @@ -319,7 +319,6 @@ static void ntb_msit_remove_dbgfs(struct ntb_msit_ctx *nm)
> >  static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
> >  {
> >  	struct ntb_msit_ctx *nm;
> > -	size_t struct_size;
> >  	int peers;
> >  	int ret;
> >  
> > @@ -352,9 +351,7 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
> >  		return ret;
> >  	}
> >  
> > -	struct_size = sizeof(*nm) + sizeof(*nm->peers) * peers;
> > -
> > -	nm = devm_kzalloc(&ntb->dev, struct_size, GFP_KERNEL);
> > +	nm = devm_kzalloc(&ntb->dev, struct_size(nm, peers, peers), GFP_KERNEL);
> >  	if (!nm)
> >  		return -ENOMEM;
> >  
> > 
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/268330b2-e42b-4d62-1ff0-8462d68e498e%40deltatee.com.
