Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 229CA306490
	for <ntb@lists.linux.dev>; Fri, 12 Sep 2025 15:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690851; cv=none; b=Ihyw7WbXN7vRWAlNvZihpcgVB6IYVWQqB+W9jBp/WL+CWVH+EWZskZHBBH6wkZlL7f5UQGVUQtepISOUMimlSG9vDK0qE6NR/Reof4F4zeB4ss2ZbIqrFnDxVvuGArrG/N8t8Es2iW1hPsLhCaVAQR4BF1+sa7Hr4l1x2IZNkhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690851; c=relaxed/simple;
	bh=ajRTRdD1cAkTeFduOgoqyCAzuHJ96CvSwSYmMufCNXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L0xLFa/WYIVUDrP9OT34oE7Cs0LCz6+8xt5TH1jhhDhyswq4fkbv9Hqenk+Ujb8qJxAubqR1TR7VfGt5OKH1U6RZDbIPoFUNmFzK5GXK5VG7hRuk7goutfplEkfnaMqm1DCJ47FgoRRJi7sGm9TbM/JqkpGJc7T5eesFU+H41xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEt9n0/G; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEt9n0/G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757690850; x=1789226850;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ajRTRdD1cAkTeFduOgoqyCAzuHJ96CvSwSYmMufCNXo=;
  b=OEt9n0/GEt5sPGq9WYPuE3UqOCsauDN7Vi8DS2/QBSU6gDyCjkPNWfgp
   EX6EOUkBb4w/xJzCxjVYnXuWYuriWFYJsosAakTwCGZvFf7rotLD9uYVv
   aG+ln0KGr6wELHhq/81ef3CmPS14mTy5cIbRI0OxdhALUqKJXfNsMogP1
   hhYIfLTUGrX76TAIFlnsCBWE+qM70l38fXGVjT07xOWm2trx7MYK/ZjMP
   fyqzUeEXoDhqdYtZYVNl2v4jLblMFVSg7uegfE2yIDstuW0DLXTA1G6vU
   1o6vlaCUG2iqh3TtTZVlqwcatVoNRmTVhzGoXWe51xZnFwdFADSXxGxGx
   Q==;
X-CSE-ConnectionGUID: 6cpgi5eISya+li6PFf4g7Q==
X-CSE-MsgGUID: gt+YJdGORYWSLi4Wpe4PXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11551"; a="59901127"
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="59901127"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:27:29 -0700
X-CSE-ConnectionGUID: BbSrCd0/RrqME01wGFMtLw==
X-CSE-MsgGUID: fC4UgzswShqgJ+jUfE4cMQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="174385812"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:27:28 -0700
Message-ID: <500ad0ff-a924-4323-b6ac-4be4ef695e36@intel.com>
Date: Fri, 12 Sep 2025 08:27:27 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntb_hw_amd: Update amd_ntb_get_link_status to support
 latest generation secondary topology
To: Basavaraj Natikar <Basavaraj.Natikar@amd.com>, Shyam-sundar.S-k@amd.com,
 jdmason@kudzu.us, allenbh@gmail.com, ntb@lists.linux.dev
Cc: Sanath S <Sanath.S@amd.com>
References: <20250912102604.765444-1-Basavaraj.Natikar@amd.com>
 <20250912102604.765444-2-Basavaraj.Natikar@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912102604.765444-2-Basavaraj.Natikar@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 3:26 AM, Basavaraj Natikar wrote:
> In the NTB secondary topology configuration of the latest generation,
> the device behaves like an endpoint. Hence, add endpoint support and
> update amd_ntb_get_link_status to accommodate endpoint devices.
> 
> Co-developed-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Sanath S <Sanath.S@amd.com>
> Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
> ---
>  drivers/ntb/hw/amd/ntb_hw_amd.c | 45 +++++++++++++++++++++------------
>  drivers/ntb/hw/amd/ntb_hw_amd.h |  1 +
>  2 files changed, 30 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
> index 63ceed89b62e..39dfe089bf59 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.c
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
> @@ -197,32 +197,38 @@ static int amd_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
>  
>  static int amd_ntb_get_link_status(struct amd_ntb_dev *ndev)
>  {
> -	struct pci_dev *pdev = NULL;
> +	struct pci_dev *pdev = ndev->ntb.pdev;
>  	struct pci_dev *pci_swds = NULL;
>  	struct pci_dev *pci_swus = NULL;
>  	u32 stat;
>  	int rc;
>  
>  	if (ndev->ntb.topo == NTB_TOPO_SEC) {
> -		/* Locate the pointer to Downstream Switch for this device */
> -		pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
> -		if (pci_swds) {
> -			/*
> -			 * Locate the pointer to Upstream Switch for
> -			 * the Downstream Switch.
> -			 */
> -			pci_swus = pci_upstream_bridge(pci_swds);
> -			if (pci_swus) {
> -				rc = pcie_capability_read_dword(pci_swus,
> -								PCI_EXP_LNKCTL,
> -								&stat);
> -				if (rc)
> +		if (ndev->dev_data->is_endpoint) {
> +			rc = pcie_capability_read_dword(pdev, PCI_EXP_LNKCTL, &stat);
> +			if (rc)
> +				return 0;
> +		} else {
> +			/* Locate the pointer to Downstream Switch for this device */
> +			pci_swds = pci_upstream_bridge(ndev->ntb.pdev);
> +			if (pci_swds) {
> +				/*
> +				 * Locate the pointer to Upstream Switch for
> +				 * the Downstream Switch.
> +				 */
> +				pci_swus = pci_upstream_bridge(pci_swds);
> +				if (pci_swus) {
> +					rc = pcie_capability_read_dword(pci_swus,
> +									PCI_EXP_LNKCTL,
> +									&stat);
> +					if (rc)
> +						return 0;
> +				} else {
>  					return 0;
> +				}
>  			} else {
>  				return 0;
>  			}

I think you can reformat this entire block to reduce indenting by returning early

	if (!pci_swds)
		return 0;

	pci_swus = pci_upstream_bridge(..);
	if (!pci_swus)
		return 0;

	rc = pcie_capability_read_dword(...);
	if (rc)
		return 0;

Also, why return 0 instead of errno on failure?

DJ

> -		} else {
> -			return 0;
>  		}
>  	} else if (ndev->ntb.topo == NTB_TOPO_PRI) {>  		/*
> @@ -1311,6 +1317,11 @@ static const struct ntb_dev_data dev_data[] = {
>  		.mw_count = 2,
>  		.mw_idx = 2,
>  	},
> +	{ /* for device 0x17d7 */
> +		.mw_count = 2,
> +		.mw_idx = 2,
> +		.is_endpoint = true,
> +	},
>  };
>  
>  static const struct pci_device_id amd_ntb_pci_tbl[] = {
> @@ -1319,6 +1330,8 @@ static const struct pci_device_id amd_ntb_pci_tbl[] = {
>  	{ PCI_VDEVICE(AMD, 0x14c0), (kernel_ulong_t)&dev_data[1] },
>  	{ PCI_VDEVICE(AMD, 0x14c3), (kernel_ulong_t)&dev_data[1] },
>  	{ PCI_VDEVICE(AMD, 0x155a), (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x17d4), (kernel_ulong_t)&dev_data[1] },
> +	{ PCI_VDEVICE(AMD, 0x17d7), (kernel_ulong_t)&dev_data[2] },
>  	{ PCI_VDEVICE(HYGON, 0x145b), (kernel_ulong_t)&dev_data[0] },
>  	{ 0, }
>  };
> diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.h b/drivers/ntb/hw/amd/ntb_hw_amd.h
> index 5f337b1572a0..e8c3165fa38b 100644
> --- a/drivers/ntb/hw/amd/ntb_hw_amd.h
> +++ b/drivers/ntb/hw/amd/ntb_hw_amd.h
> @@ -168,6 +168,7 @@ enum {
>  struct ntb_dev_data {
>  	const unsigned char mw_count;
>  	const unsigned int mw_idx;
> +	const bool is_endpoint;
>  };
>  
>  struct amd_ntb_dev;

