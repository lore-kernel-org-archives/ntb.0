Return-Path: <jdmason@kudzu.us>
Received: from mail-yw0-x242.google.com (mail-yw0-x242.google.com. [2607:f8b0:4002:c05::242])
        by gmr-mx.google.com with ESMTPS id r3si85244ywg.5.2016.12.21.08.54.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Dec 2016 08:54:59 -0800 (PST)
Received: by mail-yw0-x242.google.com with SMTP id r204so13210374ywb.3
        for <linux-ntb@googlegroups.com>; Wed, 21 Dec 2016 08:54:59 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 21 Dec 2016 11:54:57 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH] MAINTAINERS: Change in maintainer for AMD NTB
Message-ID: <20161221165457.GE32599@kudzu.us>
References: <4da90a74-8e13-41e0-5568-6bca4d4404c6@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4da90a74-8e13-41e0-5568-6bca4d4404c6@amd.com>
To: Shyam Sundar S K <ssundark@amd.com>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>, Dave Jiang <dave.jiang@intel.com>, linux-ntb@googlegroups.com, "Yu, Xiangliang" <Xiangliang.Yu@amd.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 07, 2016 at 10:48:39PM +0530, Shyam Sundar S K wrote:
> I would like to take maintainership for AMD NTB
> 
> Signed-off-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> Acked-by: Xiangliang Yu <Xiangliang.Yu@amd.com>

Applied to my ntb branch

Thanks,
Jon

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4012c2f..4ce9cfe 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8634,7 +8634,7 @@ T:	git git://github.com/jonmason/ntb.git
>  F:	drivers/ntb/hw/intel/
> 
>  NTB AMD DRIVER
> -M:	Xiangliang Yu <Xiangliang.Yu@amd.com>
> +M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
>  L:	linux-ntb@googlegroups.com
>  S:	Supported
>  F:	drivers/ntb/hw/amd/
> -- 
> 2.7.4
