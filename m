Return-Path: <jdmason@kudzu.us>
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com. [2607:f8b0:4864:20::843])
        by gmr-mx.google.com with ESMTPS id o9si782923plk.0.2020.05.31.12.54.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 May 2020 12:54:43 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j32so6155986qte.10
        for <linux-ntb@googlegroups.com>; Sun, 31 May 2020 12:54:43 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Sun, 31 May 2020 15:54:40 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v3 0/5] ntb perf, ntb tool and ntb-hw improvements
Message-ID: <20200531195439.GB4620@kudzu.us>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
To: Sanjay R Mehta <sanju.mehta@amd.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, May 05, 2020 at 11:21:47PM -0500, Sanjay R Mehta wrote:
> v3: 
> - Increased ntb_perf command re-try sleep time
> - avoid false dma unmap of dst address.
> 
> v2: Incorporated improvements suggested by Logan Gunthorpe

Pulled into the ntb branch.

Thanks,
Jon

> 
> Links of the review comments for v3:
> 1. https://lkml.org/lkml/2020/3/11/981
> 2. https://lkml.org/lkml/2020/3/10/1827
> 
> Logan Gunthorpe (1):
>   ntb: hw: remove the code that sets the DMA mask
> 
> Sanjay R Mehta (4):
>   ntb_perf: pass correct struct device to dma_alloc_coherent
>   ntb_tool: pass correct struct device to dma_alloc_coherent
>   ntb_perf: increase sleep time from one milli sec to one sec
>   ntb_perf: avoid false dma unmap of destination address
> 
>  drivers/ntb/hw/amd/ntb_hw_amd.c    |  4 ----
>  drivers/ntb/hw/idt/ntb_hw_idt.c    |  6 ------
>  drivers/ntb/hw/intel/ntb_hw_gen1.c |  4 ----
>  drivers/ntb/test/ntb_perf.c        | 23 ++++++++---------------
>  drivers/ntb/test/ntb_tool.c        |  6 +++---
>  5 files changed, 11 insertions(+), 32 deletions(-)
> 
> -- 
> 2.7.4
> 
