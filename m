Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319884A18
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 19:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664307110; x=1695843110;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Uboi46HtitzGzAeJcxV+sy5FI8yISydqs8FYVzxay40=;
  b=axBGpAL5IzW3XNcvNboi/4a0TXnZsM9BQ+WaR041Lc0tEV2nMaVrzCX+
   mWvj+aL5FlRknWZdlreE6REOCn9ySCaj+tVRRreCizeA5NaMVLiXbPsml
   BHR+DtlH65Jz/eHQSUFUpd/zqWWb7G8KIGYxb6mmJgSoYMnQWqhOTBkS2
   FyGqtrVj2bvRqS9QJ5oWF6vaZyJ5wqNFNKpG/8SEU/auleOSeE8P2GRIx
   GQUB0wy4G9Mf6m61g+QUjLi43VWFqHDBKc4BTnvjWetaGhNhhqPXHrbsL
   IyT3PxkQZMUVKK6JJ/QwR9AgtvqC2fjem2LVvjozgrwG/7uyS+nIfMHAR
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="365455660"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="365455660"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:31:49 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="652399393"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="652399393"
Received: from weimingg-mobl.amr.corp.intel.com (HELO [10.212.244.112]) ([10.212.244.112])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:31:49 -0700
Message-ID: <564e778a-4ed8-3907-1cb3-34af109d0ce0@linux.intel.com>
Date: Tue, 27 Sep 2022 12:31:48 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 1/9] PCI/AER: Add
 pci_aer_clear_uncorrect_error_status() to PCI core
Content-Language: en-US
To: Zhuo Chen <chenzhuo.1@bytedance.com>, bhelgaas@google.com,
 ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
 jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-2-chenzhuo.1@bytedance.com>
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220927153524.49172-2-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 9/27/22 8:35 AM, Zhuo Chen wrote:
> Sometimes we need to clear aer uncorrectable error status, so we add

Adding n actual use case will help.

> pci_aer_clear_uncorrect_error_status() to PCI core.

If possible, try to avoid "we" usage in commit log. Just say "so add
pci_aer_clear_uncorrect_error_status() function" 

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/pci/pcie/aer.c | 16 ++++++++++++++++
>  include/linux/aer.h    |  5 +++++
>  2 files changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e2d8a74f83c3..4e637121be23 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -286,6 +286,22 @@ void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
>  }
>  
> +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
> +{
> +	int aer = dev->aer_cap;
> +	u32 status;
> +
> +	if (!pcie_aer_is_native(dev))
> +		return -EIO;
> +
> +	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> +	if (status)
> +		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);

Why not just write all '1' and clear it? Why read and write?

> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);

Add details about why you want to export in commit log.

> +
>  /**
>   * pci_aer_raw_clear_status - Clear AER error registers.
>   * @dev: the PCI device
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 97f64ba1b34a..154690c278cb 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -45,6 +45,7 @@ struct aer_capability_regs {
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> +int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
>  void pci_save_aer_state(struct pci_dev *dev);
>  void pci_restore_aer_state(struct pci_dev *dev);
>  #else
> @@ -60,6 +61,10 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> +static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
> +{
> +	return -EINVAL;
> +}
>  static inline void pci_save_aer_state(struct pci_dev *dev) {}
>  static inline void pci_restore_aer_state(struct pci_dev *dev) {}
>  #endif

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
