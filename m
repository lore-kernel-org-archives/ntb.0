Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id y16si440381pll.0.2017.12.08.16.01.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Dec 2017 16:01:59 -0800 (PST)
References: <20171209000106.18259-1-logang@deltatee.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <9abd06be-fb6e-8acd-a954-db3ddd019ed9@deltatee.com>
Date: Fri, 8 Dec 2017 17:01:52 -0700
MIME-Version: 1.0
In-Reply-To: <20171209000106.18259-1-logang@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_netdev: set the net_device's parent
To: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Sorry ignore this. I sent an old patch :(

Logan

On 08/12/17 05:01 PM, Logan Gunthorpe wrote:
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
> ---
>   drivers/net/ntb_netdev.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index 4daf3d0926a8..0250aa9ae2cb 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -418,6 +418,8 @@ static int ntb_netdev_probe(struct device *client_dev)
>   	if (!ndev)
>   		return -ENOMEM;
>   
> +	SET_NETDEV_DEV(ndev, client_dev);
> +
>   	dev = netdev_priv(ndev);
>   	dev->ndev = ndev;
>   	dev->pdev = pdev;
> 
