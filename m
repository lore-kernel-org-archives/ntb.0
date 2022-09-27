Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C4F4C64
	for <ntb@lists.linux.dev>; Tue, 27 Sep 2022 19:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664308658; x=1695844658;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YJq7VoMFPOHGklVVnPw2e/A3qO2QBSWiCy9Vm7kXyOA=;
  b=kc+6MqeSUcCbwQre76dRB4iXuPYFl/szaOQZ7kQelqxQ/dXWjU+7MVPF
   lGAtWbgHBPXGypclPn69APBAfkq2vnuVkEvTfMdCQQy5rua1QgzE0DXZh
   Z0mLRQcXtQI5U4FYFHENAcuIm/bKhQDn2pky1Cc0o87BwNnfSKUdIMkfn
   JkkLz/gBv3BSA1mDl3zKyOnblBBVhgs/XRSAh0E9uTNyEctJMP3xRCZPQ
   DSBnI1nZDP+lSD3ymxEAxjAatevXdqdrpWbqigoJhS8j8mbDagaBsvoTf
   E3rJ2mwdv4nPhdXehCjwbJ1f3aQtVsWY9w5tSzespD2HtfOyEVBVGiRCy
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="288571916"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="288571916"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:57:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="684116192"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="684116192"
Received: from weimingg-mobl.amr.corp.intel.com (HELO [10.212.244.112]) ([10.212.244.112])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 12:57:35 -0700
Message-ID: <14057120-a6d6-8726-80f1-8e60328fbf36@linux.intel.com>
Date: Tue, 27 Sep 2022 12:57:35 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.11.0
Subject: Re: [PATCH v2 4/9] scsi: lpfc: Change to use
 pci_aer_clear_uncorrect_error_status()
Content-Language: en-US
To: Zhuo Chen <chenzhuo.1@bytedance.com>, bhelgaas@google.com,
 ruscur@russell.cc, oohall@gmail.com, fancer.lancer@gmail.com,
 jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 james.smart@broadcom.com, dick.kennedy@broadcom.com, jejb@linux.ibm.com,
 martin.petersen@oracle.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, linux-scsi@vger.kernel.org
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-5-chenzhuo.1@bytedance.com>
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20220927153524.49172-5-chenzhuo.1@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/27/22 8:35 AM, Zhuo Chen wrote:
> Status bits for ERR_NONFATAL errors only are cleared in
> pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
> error status in lpfc_aer_cleanup_state(), so we change to use
> pci_aer_clear_uncorrect_error_status().

I think you don't need to mention status bits here. Just use terms
"fatal" and "non-fatal" errors.

lpfc_aer_cleanup_state() requires clearing both fatal and non-fatal
uncorrectable error status. But using  pci_aer_clear_nonfatal_status()
will only clear non-fatal error status. To clear both fatal and non-fatal
error status, use pci_aer_clear_uncorrect_error_status().

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/scsi/lpfc/lpfc_attr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/scsi/lpfc/lpfc_attr.c b/drivers/scsi/lpfc/lpfc_attr.c
> index 09cf2cd0ae60..d835cc0ba153 100644
> --- a/drivers/scsi/lpfc/lpfc_attr.c
> +++ b/drivers/scsi/lpfc/lpfc_attr.c
> @@ -4689,7 +4689,7 @@ static DEVICE_ATTR_RW(lpfc_aer_support);
>   * Description:
>   * If the @buf contains 1 and the device currently has the AER support
>   * enabled, then invokes the kernel AER helper routine
> - * pci_aer_clear_nonfatal_status() to clean up the uncorrectable
> + * pci_aer_clear_uncorrect_error_status() to clean up the uncorrectable
>   * error status register.
>   *
>   * Notes:
> @@ -4715,7 +4715,7 @@ lpfc_aer_cleanup_state(struct device *dev, struct device_attribute *attr,
>  		return -EINVAL;
>  
>  	if (phba->hba_flag & HBA_AER_ENABLED)
> -		rc = pci_aer_clear_nonfatal_status(phba->pcidev);
> +		rc = pci_aer_clear_uncorrect_error_status(phba->pcidev);
>  
>  	if (rc == 0)
>  		return strlen(buf);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
