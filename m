Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018F11D63C4
	for <ntb@lists.linux.dev>; Wed, 12 Mar 2025 18:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741802418; cv=none; b=IohBoBsooq54QJnfVCgkCSSXCJT6G9khagR248y4CSM9KR21Q5sogvXwe0eyHodn4QtSaV3E6AjGynkz7UyDh5Z9YWp0DJIaO0fXY7kw24DvssIKo3ANe6PA3i9A2AZdrbe54ZMovv5ElReYDW3psdrqe1P5kXkmWNxGZi2oW4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741802418; c=relaxed/simple;
	bh=oV1jKXyKCcmGjWlSIr3cbhebDw/eEAZ7VyyVaXDSRPY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elpxPYpEt9yuTCSaFnj5a+lU6J+3hFFvfP78wQT2qNA0EnjmmhAAKZ4znDgGSyMSeIYhxCxBBlOuHcHLOSCKuZ1nnMIDY5Bx5NEHC7lihPWkPkRCBsZWc0RdASSGUMPBFEKBMC3dIwn2GD+LHC/G0KYFz4GJlcPzRIaIq2gnSsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=hkfrrJSp; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hkfrrJSp"
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 52CHxlo71652549
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 12:59:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741802387;
	bh=1gu2hLHkw3oXjZ+lNcFWEL88KOjDXH3qbsIRgSuLXZg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To;
	b=hkfrrJSptdQGA2ajD0QInTrYQ0AvrhJbV/4wNXT71IyQVlLn7+gaicisEVPcNXdcj
	 UpLXeNvJ4rG688hK+jp2dIm51qMfXCLsWxzVR1jad0tn7eR0dak1KDrrLukZWm6/3Y
	 Sx0jdQ/CfwH5Fjq9k0hhO2WnFXZ4rjl6ho4NLS7g=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 52CHxlZ9002568
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 12 Mar 2025 12:59:47 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Mar 2025 12:59:46 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Mar 2025 12:59:47 -0500
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 52CHxk4p048636;
	Wed, 12 Mar 2025 12:59:46 -0500
Date: Wed, 12 Mar 2025 12:59:46 -0500
From: Nishanth Menon <nm@ti.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
        Tero
 Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>, Jon
 Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>, Allen Hubbe
	<allenbh@gmail.com>,
        <ntb@lists.linux.dev>, Bjorn Helgaas
	<bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, Haiyang Zhang
	<haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>,
        Wei Huang <wei.huang2@amd.com>,
        Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [patch 03/10] soc: ti: ti_sci_inta_msi: Switch MSI descriptor
 locking to guard()
Message-ID: <20250312175946.mirwklpli45qsqd5@brittle>
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

On 09:41-20250309, Thomas Gleixner wrote:
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

Quick test of the series for basic NFS boot (which uses INTR/INTA MSI
for Ethernet) on TI K3 platforms against linux-next:
https://gist.github.com/nmenon/26ea6eb530de34808ab04b1958a0b28b

Tested-by: Nishanth Menon <nm@ti.com>

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
