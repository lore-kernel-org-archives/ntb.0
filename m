Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79DC85260
	for <ntb@lists.linux.dev>; Tue, 18 Mar 2025 08:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742287255; cv=none; b=sGL3/P5DKvVviLrG2sXZGggtVWsyAp0wX9sElObaLmK8wt5hXxMW4VQ1g2XNI6c/yxVuZCgVK9rpM/kANMXFMl0rFAI+sYooKxmtwMB6YyfR6MsooyGPUijl3Gc6026O6BtPcjinhxyJvoeY/E7KvrsR209CESWzM9chWGeOfgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742287255; c=relaxed/simple;
	bh=00oO4NJygkGCwvYi+iixq/x2rxibsNa7ZjTK2XrnEVg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HVaToEIS8FO1VyMI2kEZRTacMf1Z13hOKo+AzJ1kvAdFh8gPAVkDSXTtVgZnJlB8BxYt+hE3X1ARGRUiV+tPFu57gqkvy6KUKj6MKWXh/YTo1192AVahJZlSzEwGtdEMLF6AlgeRr1yNeJkUiCK/ueW05eAI0OHylQprAe4l5EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GVpkqIjj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Z3jihJq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GVpkqIjj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Z3jihJq"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742287248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6tlA+JIwmYuDSDTpt3KpVNqXfTV+Xj+SxXbNDkR7Eo=;
	b=GVpkqIjjN6pplIKKz3DtpUrvXd6vng+yCYaUQV0qtCh2wquejtcTVEz5qY0Up+suyNBS8U
	EH7R9fjjbPpGEev+5eVaFDYXi2GzXGaOAckMZaB2Y97TO5oX+nALkZL4We8Y3mawQAuO9y
	zWvQhoIARQbbWJfeE53s8ByfQ/4A/mbvbLx758CUGZE9h0cdgUzFAORuYFXSBV6GjoUcsN
	/suYjaoKU/qRbWli9uUZeK2bqtU0RRX750Q8f1R56n4m9RkoVCvELRBxPtYCowQXUe4HnX
	xTmJ5KO+3HH081prjXYP/W4gTTYfgvUiRrFNTtXCmBR0VUo8VohPKnT1fsqqWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742287248;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m6tlA+JIwmYuDSDTpt3KpVNqXfTV+Xj+SxXbNDkR7Eo=;
	b=9Z3jihJqufUIje0s3LxBI2+XpLO6aDR57YFV9aliuzjtdSgdEGdtRQCUWAfKBLIJZdj6Ma
	NQzw2N8u24dR5eBg==
To: James Bottomley <James.Bottomley@HansenPartnership.com>, LKML
 <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, "Martin K.
 Petersen" <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, Nishanth Menon
 <nm@ti.com>, Dhruva Gole <d-gole@ti.com>, Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>, Logan Gunthorpe
 <logang@deltatee.com>, Dave Jiang <dave.jiang@intel.com>, Jon Mason
 <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Michael
 Kelley <mhklinux@outlook.com>, Wei Liu <wei.liu@kernel.org>, Haiyang Zhang
 <haiyangz@microsoft.com>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [patch V3 09/10] scsi: ufs: qcom: Remove the MSI descriptor abuse
In-Reply-To: <609eeb873fdef6171c71f3beda289d799cb7172c.camel@HansenPartnership.com>
References: <20250317092919.008573387@linutronix.de>
 <20250317092946.265146293@linutronix.de>
 <609eeb873fdef6171c71f3beda289d799cb7172c.camel@HansenPartnership.com>
Date: Tue, 18 Mar 2025 09:40:41 +0100
Message-ID: <87o6xy4tpy.ffs@tglx>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17 2025 at 12:26, James Bottomley wrote:
>> =C2=A0	nr_irqs =3D hba->nr_hw_queues - hba-
>> >nr_queues[HCTX_TYPE_POLL];
>> +	qi =3D devm_kcalloc(hba->dev, nr_irqs, sizeof(*qi),
>> GFP_KERNEL);
>> +	if (qi)
>
> Typo causing logic inversion: should be !qi here (you need a more
> responsive ! key).

Duh.

>> +cleanup:
>> +	for (int idx =3D 0; qi[idx].irq; idx++)
>> +		devm_free_irq(hba->dev, qi[idx].irq, hba);
>> +	platform_device_msi_free_irqs_all(hba->dev);
>> +	devm_kfree(hba->dev, qi);
>> =C2=A0	return ret;
>> =C2=A0}
>
> This does seem to be exactly the pattern you describe in 1/10, although

True.

> I'm not entirely convinced that something like the below is more
> readable and safe.

At least the cleanup wants to be in a C function and not hideously
hidden in the DEFINE_FREE() macro.

Let me respin that.

Thanks,

        tglx
