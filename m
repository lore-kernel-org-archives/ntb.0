Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAC62CA2
	for <ntb@lists.linux.dev>; Mon, 24 Apr 2023 15:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682350428; x=1713886428;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q6c/b6JvPvZ05H87DnLBjtNN0boRhEiG0scByVOexKA=;
  b=BpV1mWIWm4GyeCIqzbZ0QaiIrqmBzZysmYON+RJebrMMJIN5xETjr2IV
   gRXOnq2BoIL6K5xc37YMyPjQUc7/VE2y/eD+9jJ9qpLkjaVSshXhsJ9/g
   KcKsOP0+SZQAIsWiecjEcsbdekxd4A8Qf+Q6/cCbxIAo5KPgZRIAI2VBD
   tSaU2/Kyi1UUO2v92VI86x2A+2Y3yDXYCADL5WFviT2RhhkuDH5rjNxFS
   T/GahotNqcnG4E2u5IOV6HKcgcubQ6H4pBLLGkH4l+44GYArmZ4qAnZ8Y
   CKg7gyFU8ZHzPe/hAKuquvs4d9oSLwA3u1+BKep9TS+X2bkqxsAogRK+B
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="374432911"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="374432911"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:33:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10690"; a="817311279"
X-IronPort-AV: E=Sophos;i="5.99,223,1677571200"; 
   d="scan'208";a="817311279"
Received: from sridharn-mobl.amr.corp.intel.com (HELO [10.212.106.191]) ([10.212.106.191])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 08:33:47 -0700
Message-ID: <9479d2e4-8147-aee2-3a2b-1cd06a4ad4e0@intel.com>
Date: Mon, 24 Apr 2023 08:33:46 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] ntb: hw: intel: remove return value check of
 `ndev_init_debugfs`
To: Yinhao Hu <dddddd@hust.edu.cn>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>
Cc: hust-os-kernel-patches@googlegroups.com, Dongliang Mu
 <dzm91@hust.edu.cn>, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230422155634.483023-1-dddddd@hust.edu.cn>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230422155634.483023-1-dddddd@hust.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/22/23 8:56 AM, Yinhao Hu wrote:
> Smatch complains that:
> ndev_init_debugfs() warn: 'ndev->debugfs_dir' is an error pointer or valid
> 
> Debugfs checks are generally not supposed to be checked for errors
> and it is not necessary here.

Can you please provide source on where this is true?

> 
> Just delete the dead code.
> 
> Signed-off-by: Yinhao Hu <dddddd@hust.edu.cn>
> Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
> ---
> The issue is found by static analysis and remains untested.
> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 9ab836d0d4f1..9b0b2c43f1bb 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -778,13 +778,10 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
>   		ndev->debugfs_dir =
>   			debugfs_create_dir(pci_name(ndev->ntb.pdev),
>   					   debugfs_dir);
> -		if (!ndev->debugfs_dir)
> -			ndev->debugfs_info = NULL;
> -		else
> -			ndev->debugfs_info =
> -				debugfs_create_file("info", S_IRUSR,
> -						    ndev->debugfs_dir, ndev,
> -						    &intel_ntb_debugfs_info);
> +		ndev->debugfs_info =
> +			debugfs_create_file("info", S_IRUSR,
> +					    ndev->debugfs_dir, ndev,
> +					    &intel_ntb_debugfs_info);
>   	}
>   }
>   
