Return-Path: <jdmason@kudzu.us>
Received: from mail-qk0-x243.google.com (mail-qk0-x243.google.com. [2607:f8b0:400d:c09::243])
        by gmr-mx.google.com with ESMTPS id f187si1088938ywc.0.2017.02.16.17.14.08
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Feb 2017 17:14:08 -0800 (PST)
Received: by mail-qk0-x243.google.com with SMTP id u25so4776454qki.2
        for <linux-ntb@googlegroups.com>; Thu, 16 Feb 2017 17:14:08 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 16 Feb 2017 20:14:05 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: ntb_transport: Pick an unused queue
Message-ID: <20170217011405.GB1207@kudzu.us>
References: <742181292.969165.1487025986540.JavaMail.zimbra@xes-inc.com>
 <000001d286cd$6d62e0e0$4828a2a0$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d286cd$6d62e0e0$4828a2a0$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Aaron Sierra' <asierra@xes-inc.com>, 'Dave Jiang' <dave.jiang@intel.com>, linux-ntb@googlegroups.com, 'Thomas Vanselus' <tvanselus@xes-inc.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Feb 14, 2017 at 09:20:00AM -0500, Allen Hubbe wrote:
> From: Aaron Sierra
> > From: Thomas VanSelus <tvanselus@xes-inc.com>
> > 
> > Fix typo causing ntb_transport_create_queue to select the first
> > queue every time, instead of using the next free queue.
> > 
> > Signed-off-by: Thomas VanSelus <tvanselus@xes-inc.com>
> > Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Good catch!  This has been in there from the beginning.

Add a
    Fixes: fce8a7bb5 ("PCI-Express Non-Transparent Bridge Support")
and applied to my ntb branch.

Thanks,
Jon

> 
> > ---
> >  drivers/ntb/ntb_transport.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> > index f81aa4b..95b5540 100644
> > --- a/drivers/ntb/ntb_transport.c
> > +++ b/drivers/ntb/ntb_transport.c
> > @@ -1802,7 +1802,7 @@ ntb_transport_create_queue(void *data, struct device *client_dev,
> > 
> >  	node = dev_to_node(&ndev->dev);
> > 
> > -	free_queue = ffs(nt->qp_bitmap);
> > +	free_queue = ffs(nt->qp_bitmap_free);
> >  	if (!free_queue)
> >  		goto err;
> > 
> 
