Return-Path: <Allen.Hubbe@dell.com>
Received: from esa7.dell-outbound.iphmx.com (esa7.dell-outbound.iphmx.com. [68.232.153.96])
        by gmr-mx.google.com with ESMTPS id l193si711470ywe.9.2017.06.06.06.08.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Jun 2017 06:08:54 -0700 (PDT)
From: "Allen Hubbe" <Allen.Hubbe@dell.com>
References: <20170605200053.6912-1-logang@deltatee.com>
In-Reply-To: <20170605200053.6912-1-logang@deltatee.com>
Subject: RE: [PATCH] ntb_netdev: set the net_device's parent
Date: Tue, 6 Jun 2017 09:08:40 -0400
Message-ID: <000001d2dec6$0531db10$0f959130$@dell.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
To: 'Logan Gunthorpe' <logang@deltatee.com>, linux-ntb@googlegroups.com
Cc: 'Jon Mason' <jdmason@kudzu.us>, 'Dave Jiang' <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Logan Gunthorpe
> At present, ntb_netdev devices end up under /sys/devices/virtual/net
> completely unconnected to the ntb trees below them. This patch sets the
> parent of the net_device (using SET_NETDEV_DEV) to the client_dev
> device. This results in a better connected sysfs path for the network
> device:
> 
> /sys/devices/pci0000:00/0000:00:03.0/0000:03:00.1/0000:03:00.1/ntb_netdev0/net/eth2
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <Allen.Hubbe@emc.com>

Acked-by: Allen Hubbe <Allen.Hubbe@dell.com>

> ---
>  drivers/net/ntb_netdev.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 4daf3d0926a8..0250aa9ae2cb 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -418,6 +418,8 @@ static int ntb_netdev_probe(struct device *client_dev)
>  	if (!ndev)
>  		return -ENOMEM;
> 
> +	SET_NETDEV_DEV(ndev, client_dev);
> +
>  	dev = netdev_priv(ndev);
>  	dev->ndev = ndev;
>  	dev->pdev = pdev;
> --
> 2.11.0


