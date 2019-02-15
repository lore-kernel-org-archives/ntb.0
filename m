Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com. [2a00:1450:4864:20::242])
        by gmr-mx.google.com with ESMTPS id q10-v6si450291lji.4.2019.02.15.13.21.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Feb 2019 13:21:30 -0800 (PST)
Received: by mail-lj1-x242.google.com with SMTP id g80so9554642ljg.6
        for <linux-ntb@googlegroups.com>; Fri, 15 Feb 2019 13:21:30 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
Date: Sat, 16 Feb 2019 00:21:26 +0300
From: Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
Message-ID: <20190215212123.mqne3sjy2rrngiij@mobilestation>
References: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
To: "Mehta, Sanju" <Sanju.Mehta@amd.com>
Cc: "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>, "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Fri, Feb 15, 2019 at 09:17:51AM +0000, Mehta, Sanju wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Add bug fix for ntb_perf and ntb_hw_amd
> 
> Sanjay R Mehta (4):
>   NTB: ntb_perf: Increased the number of message retries to 1000
>   NTB: ntb_perf: Disable NTB link after clearing peer XLAT registers
>   NTB: ntb_perf: Clear stale values in doorbell and command SPAD
>     register
>   NTB: ntb_hw_amd: set peer limit register
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c |  8 ++++----
>  drivers/ntb/test/ntb_perf.c     | 14 +++++++++++---
>  2 files changed, 15 insertions(+), 7 deletions(-)
> 

Thanks for the fixes.

Acked-by: Serge Semin <fancer.lancer@gmail.com>

> -- 
> 2.7.4
> 
> -- 
> You received this message because you are subscribed to the Google Groups "linux-ntb" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to linux-ntb+unsubscribe@googlegroups.com.
> To post to this group, send email to linux-ntb@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/linux-ntb/1550222224-26475-1-git-send-email-Sanju.Mehta%40amd.com.
> For more options, visit https://groups.google.com/d/optout.
