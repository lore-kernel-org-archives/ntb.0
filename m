Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x244.google.com (mail-qt0-x244.google.com. [2607:f8b0:400d:c0d::244])
        by gmr-mx.google.com with ESMTPS id o206si128404ywb.12.2017.06.09.14.12.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Jun 2017 14:12:39 -0700 (PDT)
Received: by mail-qt0-x244.google.com with SMTP id w1so17692360qtg.0
        for <linux-ntb@googlegroups.com>; Fri, 09 Jun 2017 14:12:39 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Fri, 9 Jun 2017 17:12:37 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_netdev: set the net_device's parent
Message-ID: <20170609211236.GE9847@kudzu.us>
References: <20170605200053.6912-1-logang@deltatee.com>
 <000001d2dec6$0531db10$0f959130$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d2dec6$0531db10$0f959130$@dell.com>
To: Allen Hubbe <Allen.Hubbe@dell.com>
Cc: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jun 06, 2017 at 09:08:40AM -0400, Allen Hubbe wrote:
> From: Logan Gunthorpe
> > At present, ntb_netdev devices end up under /sys/devices/virtual/net
> > completely unconnected to the ntb trees below them. This patch sets the
> > parent of the net_device (using SET_NETDEV_DEV) to the client_dev
> > device. This results in a better connected sysfs path for the network
> > device:
> > 
> > /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.1/0000:03:00.1/ntb_netdev0/net/eth2
> > 
> > Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> > Cc: Jon Mason <jdmason@kudzu.us>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Allen Hubbe <Allen.Hubbe@emc.com>
> 
> Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

Adding to my ntb branch with the following line:
Fixes: a9c59ef77458 ("ntb_test: Add a selftest script for the NTB subsystem")

This enables the stable kernels it is a bug fix and to pick it up.

Thanks,
Jon
> 
> > ---
> >  drivers/net/ntb_netdev.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> > index 4daf3d0926a8..0250aa9ae2cb 100644
> > --- a/drivers/net/ntb_netdev.c
> > +++ b/drivers/net/ntb_netdev.c
> > @@ -418,6 +418,8 @@ static int ntb_netdev_probe(struct device *client_dev)
> >  	if (!ndev)
> >  		return -ENOMEM;
> > 
> > +	SET_NETDEV_DEV(ndev, client_dev);
> > +
> >  	dev = netdev_priv(ndev);
> >  	dev->ndev = ndev;
> >  	dev->pdev = pdev;
> > --
> > 2.11.0
> 
> 
