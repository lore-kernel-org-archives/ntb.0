Return-Path: <jdmason@kudzu.us>
Received: from mail-qt0-x22c.google.com (mail-qt0-x22c.google.com. [2607:f8b0:400d:c0d::22c])
        by gmr-mx.google.com with ESMTPS id e12si736446oth.5.2018.01.18.14.28.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 14:28:52 -0800 (PST)
Received: by mail-qt0-x22c.google.com with SMTP id x27so26275902qtm.12
        for <linux-ntb@googlegroups.com>; Thu, 18 Jan 2018 14:28:52 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 18 Jan 2018 17:28:49 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v4 00/15] NTB: Add full multi-port API support to the
 test drivers
Message-ID: <20180118222849.GA25893@kudzu.us>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Wed, Dec 06, 2017 at 05:31:51PM +0300, Serge Semin wrote:
> The multi-port NTB API was introduced in kernel 4.13 as well as the
> first driver for the true multi-port devices of IDT PCIe-switches
> series. But the test drivers still were left almost unchanged. Yes,
> they didn't fail being used with new NTB API, but they only worked
> with two-ports NTB devices. This patchset is intended to fix the
> issue by amending the NTB test drivers and script so they would be
> fully compatible with multi-port NTB API.
> 
> Additionally I found a few NTB subsystem issues while developing the
> submitted patches. So they are also fixed in this patchset.
> 
> The patchset is applied on top of the recent Jon Mason's repo state:
> https://github.com/jonmason/ntb
> Particularly the "ntb/ntb-next" branch is used. The last commit hash
> had been:
> commit <c47963de5204> ("ntb_hw_switchtec: Force down the link before")

Series applied to ntb-next.

Thanks,
Jon

> 
> Serge Semin (15):
>   NTB: Rename NTB messaging API methods
>   NTB: Set dma mask and dma coherent mask to NTB devices
>   NTB: Fix UB/bug in ntb_mw_get_align()
>   NTB: ntb_pp: Add full multi-port NTB API support
>   NTB: ntb_tool: Add full multi-port NTB API support
>   NTB: ntb_perf: Add full multi-port NTB API support
>   NTB: ntb_test: Safely use paths with whitespace
>   NTB: ntb_test: Add ntb_tool port tests
>   NTB: ntb_test: Update ntb_tool link tests
>   NTB: ntb_test: Update ntb_tool DB tests
>   NTB: ntb_test: Update ntb_tool Scratchpad tests
>   NTB: ntb_test: Add ntb_tool Message tests
>   NTB: ntb_test: Update ntb_tool MW tests
>   NTB: ntb_test: Update ntb_perf tests
>   NTB: ntb_hw_idt: Set NTB_TOPO_SWITCH topology
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |    4 +
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |   37 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.c     |    4 +
>  drivers/ntb/ntb.c                       |    1 -
>  drivers/ntb/test/ntb_perf.c             | 1820 +++++++++++++++++++++----------
>  drivers/ntb/test/ntb_pingpong.c         |  447 +++++---
>  drivers/ntb/test/ntb_tool.c             | 1820 +++++++++++++++++++++----------
>  include/linux/ntb.h                     |   36 +-
>  tools/testing/selftests/ntb/ntb_test.sh |  307 ++++--
>  9 files changed, 3018 insertions(+), 1458 deletions(-)
> 
> -- 
> 2.12.0
> 
