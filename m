Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id h4si49601ilf.3.2020.02.05.10.44.13
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2020 10:44:13 -0800 (PST)
References: <cover.1580921119.git.arindam.nath@amd.com>
 <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <761e76e0-2e5e-6c71-3384-1ec10dcf8e88@deltatee.com>
Date: Wed, 5 Feb 2020 11:44:05 -0700
MIME-Version: 1.0
In-Reply-To: <aa4e69feffab2fd3cd846569e0546c5cf8f8f6b4.1580921119.git.arindam.nath@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/4] ntb_perf: pass correct struct device to
 dma_alloc_coherent
To: Arindam Nath <arindam.nath@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Sanjay R Mehta <sanju.mehta@amd.com>
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 2020-02-05 10:16 a.m., Arindam Nath wrote:
> From: Sanjay R Mehta <sanju.mehta@amd.com>
> 
> Currently, ntb->dev is passed to dma_alloc_coherent
> and dma_free_coherent calls. The returned dma_addr_t
> is the CPU physical address. This works fine as long
> as IOMMU is disabled. But when IOMMU is enabled, we
> need to make sure that IOVA is returned for dma_addr_t.
> So the correct way to achieve this is by changing the
> first parameter of dma_alloc_coherent() as ntb->pdev->dev
> instead.
> 
> Fixes: 5648e56 ("NTB: ntb_perf: Add full multi-port NTB API support")
> Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
> Signed-off-by: Arindam Nath <arindam.nath@amd.com>

Ugh, this has been fixed repeatedly and independently by a number of
people. I sent a fix[1] in more than a year ago and Sanjay repeated the
effort a couple months ago[2].

I have the same feed back for you that I had for him: once we fix the
bug we should also go in and remove the now unnecessary
dma_coerce_mask_and_coherent() calls in the drivers at the same time
seeing it no longer makes any sense. My patch did this already.

Thanks,

Logan

[1] https://lore.kernel.org/lkml/20190109192233.5752-3-logang@deltatee.com/
[2]
https://lore.kernel.org/lkml/1575983255-70377-1-git-send-email-Sanju.Mehta@amd.com/
