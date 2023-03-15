Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6543B6FC3
	for <ntb@lists.linux.dev>; Wed, 15 Mar 2023 21:29:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA22C433D2;
	Wed, 15 Mar 2023 21:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678915783;
	bh=Yckfzy+k6leZIz3lpyhOzkGl4+G0fpYDMqkxdZUVMOU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VagIOalEaXYkmeCS3Th9wPfp87XAWM99rfWwSGlfUuWCY8ew7Dc5FlMXPm2vTEMsI
	 MSf4rXWQlZn4yQTNNqh+cwR7LV3R2oWQ43Vjy1JednQnTzwzOf5OgpPhKJzLzjE/kY
	 /QqjTsUMijVG+9vLmxnxAjdedQdIlwVXhZXC+lEk4f4WsDAbsKUxA59aUkBbK7dZQC
	 yvBTEnTKztmx2XiNeIE4rwvEM/w7qig8Dnq0jaj3fECFJLFd5/dqRomzfCSzZ5qIe0
	 IDUS+N0YfIIpMzfMoTnpsMD2mqjN7dnAxCfoP5LZ8uhjxAUH3bFGz9+1VsRUS8N+Y+
	 INFJ5IimL/lwg==
Date: Wed, 15 Mar 2023 16:29:41 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Zhuo Chen <chenzhuo.1@bytedance.com>
Cc: sathyanarayanan.kuppuswamy@linux.intel.com, bhelgaas@google.com,
	ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	linux-scsi@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/9] PCI/AER: Add
 pci_aer_clear_uncorrect_error_status() to PCI core
Message-ID: <20230315212941.GA1788160@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220928105946.12469-2-chenzhuo.1@bytedance.com>

On Wed, Sep 28, 2022 at 06:59:38PM +0800, Zhuo Chen wrote:
> In lpfc_aer_cleanup_state(), uncorrectable error status needs to be
> cleared, which can be done by calling pci_aer_clear_nonfatal_status()
> and pci_aer_clear_fatal_status(). Meanwhile they can be combined in
> one function (the same in dpc_process_error). So add
> pci_aer_clear_uncorrect_error_status() function to PCI core and
> export symbol to other modules which wants to use it.

Sorry for getting back to this so late.

Why does lpfc need this?  I think AER error status should be cleared
by the PCI core, not by individual drivers, so I really would rather
not add a new interface for drivers to use.

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
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_aer_clear_uncorrect_error_status);
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
> -- 
> 2.30.1 (Apple Git-130)
> 
