Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com. [2607:f8b0:4864:20::b41])
        by gmr-mx.google.com with ESMTPS id g2si101744pjp.2.2019.06.13.06.22.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Jun 2019 06:22:38 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id d2so7813639ybh.8
        for <linux-ntb@googlegroups.com>; Thu, 13 Jun 2019 06:22:38 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 13 Jun 2019 09:22:35 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 0/3] Redundant steps removal and bug fix of
 ntb_hw_switchtec
Message-ID: <20190613132234.GA1572@kudzu.us>
References: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
To: Kelvin Cao <kelvin.cao@microchip.com>
Cc: kurt.schwemmer@microsemi.com, logang@deltatee.com, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, kelvincao@outlook.com
List-ID: <linux-ntb.googlegroups.com>

On Thu, Jun 06, 2019 at 03:09:41PM +0800, Kelvin Cao wrote:
> Hi, Everyone,
> 
> This patch series remove redundant steps and fix one bug of the 
> ntb_hw_switchtec module.
> 
> When a re-initialization is caused by a link event, the driver will
> re-setup the shared memory windows. But at that time, the shared memory
> is still valid, and it's unnecessary to free, reallocate and then
> initialize it again. Remove these redundant steps.
> 
> In case of NTB crosslink topology, the setting of shared memory window
> in the virtual partition doesn't reset on peer's reboot. So skip the
> re-setup of shared memory window for that case.
> 
> Switchtec does not support setting multiple MWs simultaneously. However,
> there's a race condition when a re-initialization is caused by a link 
> event, the driver will re-setup the shared memory window asynchronously
> and this races with the client setting up its memory windows on the 
> link up event. Fix this by ensure do the entire initialization in a work
> queue and signal the client once it's done. 
> 
> Regard,
> Kelvin
> 
> --
> 
> Changed since v1:
>   - It's a second resend of v1

Sorry for the delay.  The series is now in the ntb branch.  We've
missed window for 5.2, but it will be in the 5.3 pull request.

Thanks,
Jon

> --
> 
> Joey Zhang (2):
>   ntb_hw_switchtec: Remove redundant steps of
>     switchtec_ntb_reinit_peer() function
>   ntb_hw_switchtec: Fix setup MW with failure bug
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
>     for crosslink case
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 80 +++++++++++++++++++++-------------
>  1 file changed, 49 insertions(+), 31 deletions(-)
> 
> -- 
> 2.7.4
> 
