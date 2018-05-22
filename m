Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x241.google.com (mail-yw0-x241.google.com. [2607:f8b0:4002:c05::241])
        by gmr-mx.google.com with ESMTPS id a25-v6si1247310iod.3.2018.05.21.17.48.49
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 May 2018 17:48:49 -0700 (PDT)
Received: by mail-yw0-x241.google.com with SMTP id q7-v6so5037536ywd.9
        for <linux-ntb@googlegroups.com>; Mon, 21 May 2018 17:48:49 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 21 May 2018 20:48:47 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] ntb_transport: use put_device() instead of kfree()
Message-ID: <20180522004846.GC3255@kudzu.us>
References: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Mar 09, 2018 at 04:03:24PM +0530, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9878c48..8182a3a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -393,7 +393,7 @@ int ntb_transport_register_client_dev(char *device_name)
>  
>  		rc = device_register(dev);
>  		if (rc) {
> -			kfree(client_dev);
> +			put_device(dev);

Now we are leaking client_dev, which is bigger than just dev.  I think
we are going to need both now.

Thanks,
Jon

>  			goto err;
>  		}
>  
> -- 
> 1.9.1
> 
