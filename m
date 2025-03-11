Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367B11EB197
	for <ntb@lists.linux.dev>; Tue, 11 Mar 2025 18:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741716024; cv=none; b=b7JQrdb9joUUAUCB8DPhv8GESlLXowIY3m9zquSZ2AvDFPjvVtwPEFrWCEKtG6PYZaEV9j8LvJU9ApFE03DL6JWyfMILMOffMjcO00RWvm3s3jqMpJOfpCT6A5BDBiHd5KcUUaT53JMXzfnsjtn74uCA7P1xl7g3XEBopbm/RoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741716024; c=relaxed/simple;
	bh=zK+X0rLMJe99DMsG8rEJBHZTAHUuGiZFAHYc8EjC2l8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o4TG3VdeLs81N/Ub2JzuRFzXuVXzZ89PvFKFSt/8QpIF2jy0o9vWviOCSmX5OVrjuhFW6Bvi5rE69C6KA0B1kL1c1xWOFOWLj2ekw7VDWnb1T4gLyo9nDcdh0hIaE4kq05v9yCW2utEKpwJIjORYvgPEElSlbcMsa4UkMCJAu/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZC1gt6fkjz6HJjP;
	Wed, 12 Mar 2025 01:57:46 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F05B0140736;
	Wed, 12 Mar 2025 02:00:19 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Mar
 2025 19:00:19 +0100
Date: Tue, 11 Mar 2025 18:00:17 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas Gleixner <tglx@linutronix.de>
CC: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
	Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, "Santosh
 Shilimkar" <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	<ntb@lists.linux.dev>, Bjorn Helgaas <bhelgaas@google.com>,
	<linux-pci@vger.kernel.org>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
	<wei.liu@kernel.org>, <linux-hyperv@vger.kernel.org>, Wei Huang
	<wei.huang2@amd.com>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
	<James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
	<martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [patch 02/10] genirq/msi: Use lock guards for MSI descriptor
 locking
Message-ID: <20250311180017.00003fcc@huawei.com>
In-Reply-To: <20250309084110.267883135@linutronix.de>
References: <20250309083453.900516105@linutronix.de>
	<20250309084110.267883135@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Sun,  9 Mar 2025 09:41:44 +0100 (CET)
Thomas Gleixner <tglx@linutronix.de> wrote:

> Provide a lock guard for MSI descriptor locking and update the core code
> accordingly.
> 
> No functional change intended.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
One case in here made me go back to the helpful docs Dan wrote
after early confusion on how to use this stuff.  We might
want to consider updating as you've found a case that I at least
didn't consider when reviewing those.  +CC Dan.

Anyhow, this seems fine to me.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


>  
> --- a/kernel/irq/msi.c
> +++ b/kernel/irq/msi.c
> @@ -443,7 +443,6 @@ EXPORT_SYMBOL_GPL(msi_next_desc);

>  
> @@ -1037,25 +1032,23 @@ bool msi_create_device_irq_domain(struct
>  	if (msi_setup_device_data(dev))

Hmm. We might want to make the docs in cleanup.h more nuanced.
They specifically say to not mix goto and auto cleanup, but 
in the case of scoped_guard() unlikely almost any other case
it should be fine.

>  		goto free_fwnode;
>  
> -	msi_lock_descs(dev);
> -
> -	if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
> -		goto fail;
> -
> -	if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
> -		goto fail;
> -
> -	domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE, parent);
> -	if (!domain)
> -		goto fail;
> -
> -	domain->dev = dev;
> -	dev->msi.data->__domains[domid].domain = domain;
> -	msi_unlock_descs(dev);
> -	return true;
> +	scoped_guard(msi_descs_lock, dev) {
> +		if (WARN_ON_ONCE(msi_get_device_domain(dev, domid)))
> +			goto free_fwnode;
> +
> +		if (!pops->init_dev_msi_info(dev, parent, parent, &bundle->info))
> +			goto free_fwnode;
> +
> +		domain = __msi_create_irq_domain(fwnode, &bundle->info, IRQ_DOMAIN_FLAG_MSI_DEVICE,
> +						 parent);
> +		if (!domain)
> +			goto free_fwnode;
> +
> +		domain->dev = dev;
> +		dev->msi.data->__domains[domid].domain = domain;
> +		return true;
> +	}
>  
> -fail:
> -	msi_unlock_descs(dev);
>  free_fwnode:
>  	irq_domain_free_fwnode(fwnalloced);
>  free_bundle:





