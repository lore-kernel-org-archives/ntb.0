Return-Path: <dave.jiang@intel.com>
Received: from mga01.intel.com (mga01.intel.com. [192.55.52.88])
        by gmr-mx.google.com with ESMTPS id f188si29104pfc.1.2017.05.04.09.47.46
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 May 2017 09:47:46 -0700 (PDT)
Subject: Re: [PATCH] ntb: Correct modinfo usage statement for ntb_perf
References: <20170504163652.6904.47683.stgit@taos.amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <c8b3198e-e38a-05a4-fa31-a8d074888f01@intel.com>
Date: Thu, 4 May 2017 09:47:44 -0700
MIME-Version: 1.0
In-Reply-To: <20170504163652.6904.47683.stgit@taos.amd.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Gary R Hook <gary.hook@amd.com>, linux-ntb@googlegroups.com
Cc: Allen.Hubbe@emc.com, jdmason@kudzu.us
List-ID: <linux-ntb.googlegroups.com>



On 05/04/2017 09:36 AM, Gary R Hook wrote:
> The order parameters are powers of 2; adjust the usage information
> to use correct mathematical representations.
> 
> Signed-off-by: Gary R Hook <gary.hook@amd.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/test/ntb_perf.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index 9c4a21f1a9d9..42756a98a728 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -91,11 +91,11 @@
>  
>  static unsigned int seg_order = 19; /* 512K */
>  module_param(seg_order, uint, 0644);
> -MODULE_PARM_DESC(seg_order, "size order [n^2] of buffer segment for testing");
> +MODULE_PARM_DESC(seg_order, "size order [2^n] of buffer segment for testing");
>  
>  static unsigned int run_order = 32; /* 4G */
>  module_param(run_order, uint, 0644);
> -MODULE_PARM_DESC(run_order, "size order [n^2] of total data to transfer");
> +MODULE_PARM_DESC(run_order, "size order [2^n] of total data to transfer");
>  
>  static bool use_dma; /* default to 0 */
>  module_param(use_dma, bool, 0644);
> 
