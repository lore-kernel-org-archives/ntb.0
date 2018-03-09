Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id i86si127803pfi.1.2018.03.09.08.47.02
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Mar 2018 08:47:03 -0800 (PST)
References: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <81eaa48f-2d47-6e4e-9445-356930d974a3@deltatee.com>
Date: Fri, 9 Mar 2018 09:46:54 -0700
MIME-Version: 1.0
In-Reply-To: <6717325ea580df9a0294db6f83fd72a5db3daad9.1520591515.git.arvind.yadav.cs@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ntb_transport: use put_device() instead of kfree()
To: Arvind Yadav <arvind.yadav.cs@gmail.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Looks correct to me. Thanks!

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

On 09/03/18 03:33 AM, Arvind Yadav wrote:
> Never directly free @dev after calling device_register(), even
> if it returned an error! Always use put_device() to give up the
> reference initialized.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>   drivers/ntb/ntb_transport.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 9878c48..8182a3a 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -393,7 +393,7 @@ int ntb_transport_register_client_dev(char *device_name)
>   
>   		rc = device_register(dev);
>   		if (rc) {
> -			kfree(client_dev);
> +			put_device(dev);
>   			goto err;
>   		}
>   
> 
