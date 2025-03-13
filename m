Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4958F1E51EB
	for <ntb@lists.linux.dev>; Thu, 13 Mar 2025 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741867640; cv=none; b=Y5KkVa8BWGLwQRGMLdvLJtuIi8e8W1Q3+7HKt9Ivks7MLhVAlJjPJh9HXyE4pIcqXBC34SUvL/Dt1RqUn0pzJK2SHqIrAPMz1vw+UM/ZDtdKR/MRLoCy6lbwxjhCS0O0rwjRlaj94MCtTMxS038pb/NuNwSsvhdLcRPE76oP2TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741867640; c=relaxed/simple;
	bh=Ne9bu4AIDTj8Q9X7Md4hyfZO5+zIRYhUdbapdiAxKLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5jXYNTMmXKtZ3QExkQtNyAMk05O/mIojZJ/nYpvknTAJGnwB/yMFBY6uoBVl3+JA3SVeSuk+BIU8xMVpucOOALRUWsRKtp/q8o+8psZ69fXN6Bbqo5RHHijzFwEq+pdvutrXHtn0HzHMSfAXlQ2H7vvLW9VcsH4qLyLhFx3kBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=GxCw559e; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GxCw559e"
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52DC74d11863344
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:07:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741867624;
	bh=jjf48QJ5dtYgMD1JQM2Mlfhy8pxv4LcRNvoLveym56k=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=GxCw559eoPGYb9fX3q4TLyLRN2QNZ3S0+Mp0sJZ0CVOXqdHZDb5zRTXy1y8DLJ+2P
	 vACo6EtyFGTCaD2I++3Gnwe4mxvcpytLATrP20+FeQTeYzyCjN/VdoNbrl27qUk+y/
	 DDCtbO8j/X+ta/0pgoes46okh5M1FIKNP9GCZwlc=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52DC74bk004764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Mar 2025 07:07:04 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Mar 2025 07:07:04 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Mar 2025 07:07:04 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.227.226])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52DC73mJ113302;
	Thu, 13 Mar 2025 07:07:04 -0500
Date: Thu, 13 Mar 2025 17:37:03 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Santosh
 Shilimkar <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
        <ntb@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu
	<wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>,
        Wei Huang
	<wei.huang2@amd.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [patch 03/10] soc: ti: ti_sci_inta_msi: Switch MSI descriptor
 locking to guard()
Message-ID: <20250313120703.nchgmrvgx2dt5fjc@lcpd911>
References: <20250309083453.900516105@linutronix.de>
 <20250309084110.330984023@linutronix.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250309084110.330984023@linutronix.de>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

On Mar 09, 2025 at 09:41:46 +0100, Thomas Gleixner wrote:
> Convert the code to use the new guard(msi_descs_lock).
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Tero Kristo <kristo@kernel.org>
> Cc: Santosh Shilimkar <ssantosh@kernel.org>
> ---
>  drivers/soc/ti/ti_sci_inta_msi.c |   10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> --- a/drivers/soc/ti/ti_sci_inta_msi.c
> +++ b/drivers/soc/ti/ti_sci_inta_msi.c
> @@ -103,19 +103,15 @@ int ti_sci_inta_msi_domain_alloc_irqs(st
>  	if (ret)
>  		return ret;
>  
> -	msi_lock_descs(dev);
> +	guard(msi_descs_lock)(dev);
>  	nvec = ti_sci_inta_msi_alloc_descs(dev, res);
> -	if (nvec <= 0) {
> -		ret = nvec;
> -		goto unlock;
> -	}
> +	if (nvec <= 0)
> +		return nvec;
>  
>  	/* Use alloc ALL as it's unclear whether there are gaps in the indices */
>  	ret = msi_domain_alloc_irqs_all_locked(dev, MSI_DEFAULT_DOMAIN, nvec);
>  	if (ret)
>  		dev_err(dev, "Failed to allocate IRQs %d\n", ret);
> -unlock:
> -	msi_unlock_descs(dev);
>  	return ret;
>  }
>  EXPORT_SYMBOL_GPL(ti_sci_inta_msi_domain_alloc_irqs);
> 
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
