Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74189D527
	for <ntb@lists.linux.dev>; Mon,  7 Nov 2022 15:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667834957; x=1699370957;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=1UGfF4hhxEaq5QVK3COLUJ0astinOQk1dpdonNbGjcc=;
  b=DAoIufdLZ1Rwt/IhIAhL40b59yTMCs3DRiEmyrSwEKv+6ltYHQGFNflJ
   o/oXvtoWbXZ59DGPEqa/D3ujzCyxMnXFKLjO/2Bu1vFwrbSSWPoAygE9p
   Rk2Bk/dLlpe0ly8uQXwN99Ve/XHskAvUDObzJ613mora/XooV8TS2mmWN
   hhc5MWLbhR0lMZRtIROrpu7jb8SReBKSw8HTlzL8jjD/OTQs61TmKBnAX
   ZXRIu9Cps8cyedhVCs6LcoYZMoDu9G1Ow1MHbruo6k0Yh8sUhNvk/y3SB
   Jia9QFnvg18o6oMmfRNKY1y71BoZBXKR5ZgP+trqZt01F/NPmY0foY+2A
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290160737"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290160737"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 07:29:01 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="725176494"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="725176494"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.213.168.235]) ([10.213.168.235])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 07:28:59 -0800
Message-ID: <1bbf45ff-38bd-989c-d938-f7ce094b6197@intel.com>
Date: Mon, 7 Nov 2022 07:28:58 -0800
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH] ntb: intel: Fix error handling in
 intel_ntb_pci_driver_init()
Content-Language: en-US
To: Yuan Can <yuancan@huawei.com>, jdmason@kudzu.us, allenbh@gmail.com,
 ntb@lists.linux.dev
References: <20221105094322.106585-1-yuancan@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221105094322.106585-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/2022 2:43 AM, Yuan Can wrote:
> A problem about ntb_hw_intel create debugfs failed is triggered with the
> following log given:
> 
>   [  273.112733] Intel(R) PCI-E Non-Transparent Bridge Driver 2.0
>   [  273.115342] debugfs: Directory 'ntb_hw_intel' with parent '/' already present!
> 
> The reason is that intel_ntb_pci_driver_init() returns
> pci_register_driver() directly without checking its return value, if
> pci_register_driver() failed, it returns without destroy the newly created
> debugfs, resulting the debugfs of ntb_hw_intel can never be created later.
> 
>   intel_ntb_pci_driver_init()
>     debugfs_create_dir() # create debugfs directory
>     pci_register_driver()
>       driver_register()
>         bus_add_driver()
>           priv = kzalloc(...) # OOM happened
>     # return without destroy debugfs directory
> 
> Fix by removing debugfs when pci_register_driver() returns error.
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Signed-off-by: Yuan Can <yuancan@huawei.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 84772013812b..60a4ebc7bf35 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -2064,12 +2064,17 @@ static struct pci_driver intel_ntb_pci_driver = {
>   
>   static int __init intel_ntb_pci_driver_init(void)
>   {
> +	int ret;
>   	pr_info("%s %s\n", NTB_DESC, NTB_VER);
>   
>   	if (debugfs_initialized())
>   		debugfs_dir = debugfs_create_dir(KBUILD_MODNAME, NULL);
>   
> -	return pci_register_driver(&intel_ntb_pci_driver);
> +	ret = pci_register_driver(&intel_ntb_pci_driver);
> +	if (ret)
> +		debugfs_remove_recursive(debugfs_dir);
> +
> +	return ret;
>   }
>   module_init(intel_ntb_pci_driver_init);
>   
