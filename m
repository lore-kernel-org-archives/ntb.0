Return-Path: <dave.jiang@intel.com>
Received: from mga18.intel.com (mga18.intel.com. [134.134.136.126])
        by gmr-mx.google.com with ESMTPS id l26si682727pfe.2.2020.08.24.07.37.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2020 07:37:57 -0700 (PDT)
Subject: Re: [PATCH] ntb: intel: Fix memleak in intel_ntb_pci_probe
References: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <396e55a5-7ebe-1e81-b1b6-9a53cd885a8a@intel.com>
Date: Mon, 24 Aug 2020 07:37:56 -0700
MIME-Version: 1.0
In-Reply-To: <20200823065512.11626-1-dinghao.liu@zju.edu.cn>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Dinghao Liu <dinghao.liu@zju.edu.cn>, kjlu@umn.edu
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>



On 8/22/2020 11:55 PM, Dinghao Liu wrote:
> The default error branch of a series of pdev_is_gen calls
> should free ndev just like what we've done in these calls.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Thanks Dinghao
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index 3185efeab487..093dd20057b9 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -1893,7 +1893,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>   			goto err_init_dev;
>   	} else {
>   		rc = -EINVAL;
> -		goto err_ndev;
> +		goto err_init_pci;
>   	}
>   
>   	ndev_reset_unsafe_flags(ndev);
> 
