Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com. [2607:f8b0:4864:20::b41])
        by gmr-mx.google.com with ESMTPS id v141si149391oif.2.2019.06.13.06.23.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:23:18 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id c7so7807350ybs.9
        for <linux-ntb@googlegroups.com>; Thu, 13 Jun 2019 06:23:18 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 13 Jun 2019 09:23:15 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] NTB: correct ntb_dev_ops and ntb_dev comment typos
Message-ID: <20190613132314.GB1572@kudzu.us>
References: <1556618669-2434-1-git-send-email-wesley.sheng@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556618669-2434-1-git-send-email-wesley.sheng@microchip.com>
To: Wesley Sheng <wesley.sheng@microchip.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, wesleyshenggit@sina.com, logang@deltatee.com
List-ID: <linux-ntb.googlegroups.com>

On Tue, Apr 30, 2019 at 06:04:29PM +0800, Wesley Sheng wrote:
> The comment for ntb_dev_ops and ntb_dev incorrectly referred to
> ntb_ctx_ops and ntb_device.
> 
> Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Sorry for the delay.  The series is now in the ntb branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request.

Thanks,
Jon

> ---
>  include/linux/ntb.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/ntb.h b/include/linux/ntb.h
> index 56a92e3..604abc8 100644
> --- a/include/linux/ntb.h
> +++ b/include/linux/ntb.h
> @@ -205,7 +205,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
>  }
>  
>  /**
> - * struct ntb_ctx_ops - ntb device operations
> + * struct ntb_dev_ops - ntb device operations
>   * @port_number:	See ntb_port_number().
>   * @peer_port_count:	See ntb_peer_port_count().
>   * @peer_port_number:	See ntb_peer_port_number().
> @@ -404,7 +404,7 @@ struct ntb_client {
>  #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
>  
>  /**
> - * struct ntb_device - ntb device
> + * struct ntb_dev - ntb device
>   * @dev:		Linux device object.
>   * @pdev:		PCI device entry of the ntb.
>   * @topo:		Detected topology of the ntb.
> -- 
> 2.7.4
> 
