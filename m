Return-Path: <jdmason@kudzu.us>
Received: from mail-wm0-x235.google.com (mail-wm0-x235.google.com. [2a00:1450:400c:c09::235])
        by gmr-mx.google.com with ESMTPS id w129si188470wme.1.2016.01.06.06.56.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jan 2016 06:56:12 -0800 (PST)
Received: by mail-wm0-x235.google.com with SMTP id f206so62526468wmf.0
        for <linux-ntb@googlegroups.com>; Wed, 06 Jan 2016 06:56:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1450878191-9342-1-git-send-email-Xiangliang.Yu@amd.com>
References: <1450878191-9342-1-git-send-email-Xiangliang.Yu@amd.com>
Date: Wed, 6 Jan 2016 09:56:12 -0500
Message-ID: <CAPoiz9zQF4-sYNtARuYepodmQZP31xb1SMxXSGpWKQudYX09Zg@mail.gmail.com>
Subject: Re: [PATCH V2 2/3] NTB: Add AMD NTB support in Kconfig and Makefile
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: Dave Jiang <dave.jiang@intel.com>, "Hubbe, Allen" <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com, linux-kernel <linux-kernel@vger.kernel.org>, SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 23, 2015 at 8:43 AM, Xiangliang Yu <Xiangliang.Yu@amd.com> wrote:
> This patch is to enable AMD NTB support in Kconfig and Makefile.
>
> Signed-off-by: Xiangliang Yu <Xiangliang.Yu@amd.com>
> ---
>  drivers/ntb/hw/Kconfig  | 1 +
>  drivers/ntb/hw/Makefile | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/ntb/hw/Kconfig b/drivers/ntb/hw/Kconfig
> index 4d5535c..0c5c2a6 100644
> --- a/drivers/ntb/hw/Kconfig
> +++ b/drivers/ntb/hw/Kconfig
> @@ -1 +1,2 @@
>  source "drivers/ntb/hw/intel/Kconfig"
> +source "drivers/ntb/hw/amd/Kconfig"
> diff --git a/drivers/ntb/hw/Makefile b/drivers/ntb/hw/Makefile
> index 175d7c9..636be7d 100644
> --- a/drivers/ntb/hw/Makefile
> +++ b/drivers/ntb/hw/Makefile
> @@ -1 +1,2 @@
>  obj-$(CONFIG_NTB_INTEL)        += intel/
> +obj-$(CONFIG_NTB_AMD)  += amd/
> --
> 1.9.1
>

This should be part of the first patch.

Thanks,
Jon
