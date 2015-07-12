Return-Path: <jdmason@kudzu.us>
Received: from mail-ig0-f177.google.com (mail-ig0-f177.google.com. [209.85.213.177])
        by gmr-mx.google.com with ESMTPS id x1si444976igb.2.2015.07.12.11.31.30
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2015 11:31:30 -0700 (PDT)
Received: by igvi1 with SMTP id i1so18896387igv.1
        for <linux-ntb@googlegroups.com>; Sun, 12 Jul 2015 11:31:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
Date: Sun, 12 Jul 2015 14:31:29 -0400
Message-ID: <CAPoiz9x9d1FG4uayD=tVs+moD_svfg=o+m1sxjtj60LZURQXiA@mail.gmail.com>
Subject: Re: [PATCH 00/12] NTB: Performance and bug fixes in ntb drivers
From: Jon Mason <jdmason@kudzu.us>
Content-Type: text/plain; charset=UTF-8
To: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

On Mon, Jul 6, 2015 at 11:30 AM, Allen Hubbe <Allen.Hubbe@emc.com> wrote:
> This series includes the following changes to fix bugs, add new hardware
> support, and improve usability and performance of the ntb drivers.
>
> Bug Fixes (issues preexisting the new ntb api):
> NTB: Fix ntb_transport out-of-order RX update
> NTB: Schedule to receive on QP link up
> NTB: Fix zero size or integer overflow in ntb_set_mw
> NTB: ntb_netdev not covering all receive errors
> NTB: Fix oops in debugfs when transport is half-up
>
> Bug Fixes (regressions since the new ntb api):
> NTB: Fix transport stats for multiple devices
>
> Additions and Performance Improvements:
> NTB: Remove dma_sync_wait from ntb_async_rx
> NTB: Add PCI Device IDs for Broadwell Xeon
> NTB: Add flow control to the ntb_netdev
> NTB: Make the transport list in order of discovery
> NTB: Clean up QP stats info
> NTB: Use unique DMA channels for TX and RX
>

Ignoring the outstanding quesiton on patch 2, these patches look acceptable.

For clarity, patches 1, 2, and 4 are bug fixes and can be sent to
Linus now.  Patches 3, 5, 6, 9 and 10 look to be features, and should
hit the next merge window.  How would you like patches 7, 8, and/or 12
handled?

Thanks,
Jon



> Allen Hubbe (4):
>   NTB: Fix ntb_transport out-of-order RX update
>   NTB: Schedule to receive on QP link up
>   NTB: Remove dma_sync_wait from ntb_async_rx
>   NTB: Fix zero size or integer overflow in ntb_set_mw
>
> Dave Jiang (8):
>   NTB: Add flow control to the ntb_netdev
>   NTB: Fix transport stats for multiple devices
>   NTB: ntb_netdev not covering all receive errors
>   NTB: Fix oops in debugfs when transport is half-up
>   NTB: Add PCI Device IDs for Broadwell Xeon
>   NTB: Make the transport list in order of discovery
>   NTB: Clean up QP stats info
>   NTB: Use unique DMA channels for TX and RX
>
>  drivers/net/ntb_netdev.c            |  89 +++++++++-
>  drivers/ntb/hw/intel/ntb_hw_intel.c |  15 ++
>  drivers/ntb/hw/intel/ntb_hw_intel.h |   3 +
>  drivers/ntb/ntb_transport.c         | 322 ++++++++++++++++++++++++------------
>  include/linux/ntb_transport.h       |   1 +
>  5 files changed, 320 insertions(+), 110 deletions(-)
>
> --
> 2.4.0.rc0.43.gcf8a8c6
>
