Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id r62si1290908oig.1.2019.04.08.09.00.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 08 Apr 2019 09:00:50 -0700 (PDT)
References: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <921720bb-4e56-0c19-a29c-565d2fa85185@deltatee.com>
Date: Mon, 8 Apr 2019 10:00:45 -0600
MIME-Version: 1.0
In-Reply-To: <1554734722-7833-1-git-send-email-wesley.sheng@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/3] Redundant steps removal and bug fix of
 ntb_hw_switchtec
To: Wesley Sheng <wesley.sheng@microchip.com>, kurt.schwemmer@microsemi.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, kelvin.cao@microchip.com
List-ID: <linux-ntb.googlegroups.com>



On 2019-04-08 8:45 a.m., Wesley Sheng wrote:
> Joey Zhang (2):
>   ntb_hw_switchtec: Remove redundant steps of
>     switchtec_ntb_reinit_peer() function
>   ntb_hw_switchtec: Fix setup MW with failure bug
> 
> Wesley Sheng (1):
>   ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
>     for crosslink case

Looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

Logan
