Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 769B84C64
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 19:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664308769; x=1695844769;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hHMW6dKcSr50LmzJxBbJqerolMIPg6Gn2+JmAaKAzHQ=;
  b=cZVUmT9YVZE9BbpSbIGoTtOCcnfkd6IUlj6qoNcufpbEPYnTdKNbBilF
   mlTOOfBHA/CIebf2sdwkDqbNgxK8a8ctRyE5EfI6X+OmYxsdZgbYzawik
   CIq0urj06zcTp5f7L9N9nVpdSJSDhjGg+6RcCSsE/0+VoSn1BaMVHUeY6
   9dTk7UtT+nxyNApeYWXaliE5cxRHCMlSg6CPcR+H0jWj1ZyrP9qokKloI
   /T49twnEoISVFb2gKZnoDYjuatB6940N9LTaNxD8Lhb+BXyfB0Lja+ECJ
   TkEOq/M8KJa9Vz2JSB8Hm3OzN+PgL+JJ1WZHVGor5x+4QtPofWWrWKlfG
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="387703039"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="387703039"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:59:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684116462"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="684116462"
Received: from weimingg-mobl.amr.corp.intel.com (HELO [10.212.244.112]) ([10.212.244.112])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:59:28 -0700
Message-ID: <8bf3e3c0-78b6-7121-1951-300175ede3b9@linux.intel.com>
Date: Tue, 27 Sep 2022 12:59:27 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 5/9] PCI/AER: Unexport pci_aer_clear_nonfatal_status()
Content-Language: en-US
To: Zhuo Chen <chenzhuo.1@bytedance.com>, bhelgaas@google.com,
 ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
 jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-6-chenzhuo.1@bytedance.com>
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220927153524.49172-6-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/22 8:35 AM, Zhuo Chen wrote:
> Since pci_aer_clear_nonfatal_status() is used only internally, move
> its declaration to the PCI internal header file. Also, no one cares
> about return value of pci_aer_clear_nonfatal_status(), so make it void.
> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---

Looks good to me.

>  drivers/pci/pci.h      | 2 ++
>  drivers/pci/pcie/aer.c | 7 ++-----
>  include/linux/aer.h    | 5 -----
>  3 files changed, 4 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 785f31086313..a114175d08e4 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -684,6 +684,7 @@ void pci_aer_init(struct pci_dev *dev);
>  void pci_aer_exit(struct pci_dev *dev);
>  extern const struct attribute_group aer_stats_attr_group;
>  void pci_aer_clear_fatal_status(struct pci_dev *dev);
> +void pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pci_aer_clear_status(struct pci_dev *dev);
>  int pci_aer_raw_clear_status(struct pci_dev *dev);
>  #else
> @@ -691,6 +692,7 @@ static inline void pci_no_aer(void) { }
>  static inline void pci_aer_init(struct pci_dev *d) { }
>  static inline void pci_aer_exit(struct pci_dev *d) { }
>  static inline void pci_aer_clear_fatal_status(struct pci_dev *dev) { }
> +static inline void pci_aer_clear_nonfatal_status(struct pci_dev *dev) { }
>  static inline int pci_aer_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  static inline int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
>  #endif
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4e637121be23..e2ebd108339d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -251,13 +251,13 @@ int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  }
>  EXPORT_SYMBOL_GPL(pci_disable_pcie_error_reporting);
>  
> -int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> +void pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  {
>  	int aer = dev->aer_cap;
>  	u32 status, sev;
>  
>  	if (!pcie_aer_is_native(dev))
> -		return -EIO;
> +		return;
>  
>  	/* Clear status bits for ERR_NONFATAL errors only */
>  	pci_read_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, &status);
> @@ -265,10 +265,7 @@ int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>  	status &= ~sev;
>  	if (status)
>  		pci_write_config_dword(dev, aer + PCI_ERR_UNCOR_STATUS, status);
> -
> -	return 0;
>  }
> -EXPORT_SYMBOL_GPL(pci_aer_clear_nonfatal_status);
>  
>  void pci_aer_clear_fatal_status(struct pci_dev *dev)
>  {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 154690c278cb..f638ad955deb 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -44,7 +44,6 @@ struct aer_capability_regs {
>  /* PCIe port driver needs this function to enable AER */
>  int pci_enable_pcie_error_reporting(struct pci_dev *dev);
>  int pci_disable_pcie_error_reporting(struct pci_dev *dev);
> -int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>  int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev);
>  void pci_save_aer_state(struct pci_dev *dev);
>  void pci_restore_aer_state(struct pci_dev *dev);
> @@ -57,10 +56,6 @@ static inline int pci_disable_pcie_error_reporting(struct pci_dev *dev)
>  {
>  	return -EINVAL;
>  }
> -static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> -{
> -	return -EINVAL;
> -}
>  static inline int pci_aer_clear_uncorrect_error_status(struct pci_dev *dev)
>  {
>  	return -EINVAL;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
