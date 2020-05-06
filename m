Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id a205si171026vsd.2.2020.05.06.08.35.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:35:37 -0700 (PDT)
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <2197ff4b-be91-7c73-ad2e-f3849a088953@deltatee.com>
Date: Wed, 6 May 2020 09:35:31 -0600
MIME-Version: 1.0
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 0/5] ntb perf, ntb tool and ntb-hw improvements
To: Sanjay R Mehta <sanju.mehta@amd.com>, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2020-05-05 10:21 p.m., Sanjay R Mehta wrote:
> v3: 
> - Increased ntb_perf command re-try sleep time
> - avoid false dma unmap of dst address.
> 
> v2: Incorporated improvements suggested by Logan Gunthorpe
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

Looks good to me. For these 4 patches:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Thanks!

Logan
