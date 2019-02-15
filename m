Return-Path: <logang@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id z129si342539qka.2.2019.02.15.09.59.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Feb 2019 09:59:56 -0800 (PST)
References: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <83d5071f-cbf6-b382-8ebe-5184af044bb8@deltatee.com>
Date: Fri, 15 Feb 2019 10:59:48 -0700
MIME-Version: 1.0
In-Reply-To: <1550222224-26475-1-git-send-email-Sanju.Mehta@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 0/4] bug fixes in ntb_hw_amd and ntb_perf
To: "Mehta, Sanju" <Sanju.Mehta@amd.com>, "S-k, Shyam-sundar" <Shyam-sundar.S-k@amd.com>, "jdmason@kudzu.us" <jdmason@kudzu.us>, "dave.jiang@intel.com" <dave.jiang@intel.com>, "allenbh@gmail.com" <allenbh@gmail.com>
Cc: "linux-ntb@googlegroups.com" <linux-ntb@googlegroups.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>



On 2019-02-15 2:17 a.m., Mehta, Sanju wrote:
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


Looks fine to me. Thanks.

For all the ntb_perf changes:

Acked-by: Logan Gunthorpe <logang@deltatee.com>

Logan
