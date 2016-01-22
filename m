Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-x244.google.com (mail-yk0-x244.google.com. [2607:f8b0:4002:c07::244])
        by gmr-mx.google.com with ESMTPS id j19si345225ywg.7.2016.01.21.16.53.20
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jan 2016 16:53:20 -0800 (PST)
Received: by mail-yk0-x244.google.com with SMTP id k129so4870056yke.3
        for <linux-ntb@googlegroups.com>; Thu, 21 Jan 2016 16:53:20 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 21 Jan 2016 19:52:03 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [Resend PATCH V5 0/1] AMD NTB V5 changes
Message-ID: <20160122005201.GA18163@kudzu.us>
References: <1453377190-10533-1-git-send-email-Xiangliang.Yu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1453377190-10533-1-git-send-email-Xiangliang.Yu@amd.com>
To: Xiangliang Yu <Xiangliang.Yu@amd.com>
Cc: Allen.Hubbe@emc.com, dave.jiang@intel.com, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, SPG_Linux_Kernel@amd.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jan 21, 2016 at 07:53:10PM +0800, Xiangliang Yu wrote:
> Resend V5 for more convenient pick up.
> Main changes in V5
> Only change Signed-off-by to Reviewed-by.

Included in the NTB git tree.

Thanks,
Jon

> 
> Xiangliang Yu (1):
>   [Resend patch V5] NTB: Add support for AMD PCI-Express Non-Transparent Bridge
> 
>  MAINTAINERS                     |    6 +
>  drivers/ntb/hw/Kconfig          |    1 +
>  drivers/ntb/hw/Makefile         |    1 +
>  drivers/ntb/hw/amd/Kconfig      |    7 +
>  drivers/ntb/hw/amd/Makefile     |    1 +
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 1143 +++++++++++++++++++++++++++++++++++++++
>  drivers/ntb/hw/amd/ntb_hw_amd.h |  217 ++++++++
>  7 files changed, 1376 insertions(+)
>  create mode 100644 drivers/ntb/hw/amd/Kconfig
>  create mode 100644 drivers/ntb/hw/amd/Makefile
>  create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.c
>  create mode 100644 drivers/ntb/hw/amd/ntb_hw_amd.h
> 
> -- 
> 1.9.1
> 
