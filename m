Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com. [2607:f8b0:4864:20::b42])
        by gmr-mx.google.com with ESMTPS id m33si491161qte.5.2019.02.11.06.40.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 06:40:37 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 7so4218139ybp.13
        for <linux-ntb@googlegroups.com>; Mon, 11 Feb 2019 06:40:37 -0800 (PST)
Return-Path: <jdmason@kudzu.us>
Date: Mon, 11 Feb 2019 09:40:34 -0500
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v3 0/8]  Fix breakage caused by the NTB multi-port
 patchset
Message-ID: <20190211144034.GC13951@kudzu.us>
References: <20190109192233.5752-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190109192233.5752-1-logang@deltatee.com>
To: Logan Gunthorpe <logang@deltatee.com>
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

On Wed, Jan 09, 2019 at 12:22:25PM -0700, Logan Gunthorpe wrote:
> Hey,
> 
> I'm resending this because I've recently found out that the change we
> made to use the NTB struct device in DMA allocations is wrong and
> needs to be reverted. Turns out that, when running with an IOMMU,
> dma_alloc_coherent() will always fail if you pass it the NTB struct
> device. This is because the device has not been assigned an IOMMU
> group and the Intel IOMMU at least expect the devices to be on the PCI
> bus and be able to find a proper bus-dev-fn number through a struct
> pci device. Therefore, we must revert the change and I've changed
> patch 2 to do this and remove the no longer necessary DMA mask
> adjustments.
> 
> I'm not sure if we can get past the impass in getting this series merged:
> I still maintain every patch in this series is necessary to fix a
> regression and there's no way to add port numbers to switchtec in the
> crosslink configuration so it can't be fixed in the other way that was
> suggested.

Given the need for this to get in (as it does fix actual problems) and
the absence of comments on v3, I'm adding this to the ntb-next branch.
If there is anyone that has anything more to say on this, please do so
immediately.  Otherwise, I think this probably needs to be moved to the
ntb branch and go into 5.1-rc1.

Thoughts?

Thanks,
Jon

> 
> Logan
> 
> --
> 
> Changes since v2:
> - Rebased on v5.0-rc1
> - Modify Patch 2 to revert back to using the PCI struct device
>   instead of the NTB struct device in DMA calls
> - Collected Allen's Acks
> - Collected Alexander's Tested-By
> 
> Changes since v1:
> - Rebased onto ntb-next (there was a minor conflict in a recent change
>   to the intel driver)
> - Collected Dave's Ack
> 
> --
> 
> Logan Gunthorpe (8):
>   NTB: ntb_tool: reading the link file should not end in a NULL byte
>   NTB: Revert the change to use the NTB device dev for DMA allocations
>   NTB: Fix the default port and peer numbers for legacy drivers
>   NTB: ntb_pingpong: Choose doorbells based on port number
>   NTB: perf: Don't require one more memory window than number of peers
>   NTB: perf: Fix support for hardware that doesn't have port numbers
>   NTB: perf: Fix race condition when run with ntb_test
>   NTB: ntb_test: Fix bug when counting remote files
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c         |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c         |  6 -----
>  drivers/ntb/hw/intel/ntb_hw_gen1.c      |  4 ----
>  drivers/ntb/ntb.c                       |  9 ++------
>  drivers/ntb/test/ntb_perf.c             | 29 +++++++++++++++++++------
>  drivers/ntb/test/ntb_pingpong.c         | 14 +++++-------
>  drivers/ntb/test/ntb_tool.c             |  9 ++++----
>  tools/testing/selftests/ntb/ntb_test.sh |  2 +-
>  8 files changed, 35 insertions(+), 42 deletions(-)
> 
> --
> 2.19.0
