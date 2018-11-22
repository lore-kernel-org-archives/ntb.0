Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id q8si2037288vsd.2.2018.11.22.08.54.54
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Nov 2018 08:54:54 -0800 (PST)
References: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <a386850a-6fe9-9cd6-72dd-c00e09405d51@deltatee.com>
Date: Thu, 22 Nov 2018 09:54:41 -0700
MIME-Version: 1.0
In-Reply-To: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] ntb_hw_switchtec: Added support of >=4G memory
 windows
To: Wesley Sheng <wesley.sheng@microchip.com>, kurt.schwemmer@microsemi.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com
List-ID: <linux-ntb.googlegroups.com>

Hey,

This entire series looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan

On 2018-11-22 2:01 a.m., Wesley Sheng wrote:
> Hi, Everyone,
> 
> This patch series adds support of >=4G memory windows.
> 
> Current Switchtec's BAR setup registers are limited to 32bits,
> corresponding to the maximum MW (memory window) size is <4G.
> Increase the MW sizes with the addition of the BAR Setup Extension
> Register for the upper 32bits of a 64bits MW size. This increases the MW
> range to between 4K and 2^63.
> 
> Additionally, we've made the following changes:
> 
> * debug print 64bit aligned crosslink BAR numbers
> * Fix the array size of NT req id mapping table
> 
> Tested with ntb_test.sh successfully based on NTB fixes series from
> Logan Gunthorpe <logang@deltatee.com> at 
> https://github.com/sbates130272/linux-p2pmem on branch of
> ntb_multiport_fixes
> 
> Regards,
> Wesley
> 
> 
> 
> Paul Selles (2):
>   ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
>   ntb_hw_switchtec: Added support of >=4G memory windows
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: NT req id mapping table register entry number should
>     be 512
> 
>  drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 ++++++++---
>  include/linux/switchtec.h              | 10 +++++++---
>  2 files changed, 15 insertions(+), 6 deletions(-)
> 
