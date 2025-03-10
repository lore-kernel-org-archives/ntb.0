Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CEF3230BF0
	for <ntb@lists.linux.dev>; Mon, 10 Mar 2025 17:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627873; cv=none; b=ZkrmOo5nd5NyHfLDU+eQV/Wj/rtLsZxpf0nMOB+yRBoA9+JA/nJPUi1G0e+tT3tJTir5DJLDckQ2op3Y6rAbSINoT/kmuh5lxfDczPY9BwRPG7xtTC/ZRErg1ipBSpTu2W19JcAoLoudoehIs7/qQ1zjH1eFdq8oKrpXBRuo/LA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627873; c=relaxed/simple;
	bh=K5a/n3k2IMqq05srX3keh8AHLyS8gdBd7xrkRpohd/k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=piLixFh0XJdaEC3j2+y+0rQM1IgF+QUSa8iMvFRDc/dMOWcknghcSWc36/V5M7T9tO9O4w5x8cuR5WBcrz1pj5oC5oVyfyQmPRvsLfua577/wlUDGIyMJVwX7PsPbmcAM3P4f6cm80VsazU6gdsQ9JcNTHbG9Rgfmg7kcx7L/pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ul565pyZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+1cZvXlr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ul565pyZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+1cZvXlr"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741627869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5a/n3k2IMqq05srX3keh8AHLyS8gdBd7xrkRpohd/k=;
	b=ul565pyZF89oi4JPI3tSen6XWAClieQ3+K2Jw0ulUf9HsyzlA9tTrswXT1P+mYPUizhFlZ
	UfFMAsBZuk9tbR+Zx4PuGnwQ7vtqL40FjUsEblDTCwDdSI9iRd1DnOCbVBzd5o83YP6vPZ
	fyaDNG9XrU+RmIJ6mtn1zC+WwTwVuEj9dH35opr9agmxNva/49B47aXTx2exzj2sfdowEb
	tAUCvnesb6/+q96pvKa5OaQxsTDU7WgGXu6e1GGThxpHayqYCE+O5Mk+Fb7wxlPTqsLo+T
	PiQ1MCddzDQht5fvF1dyFxGL+0bv+wHBIcURKLd3nq5v3bOiP8yxY87OjP0KsA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741627869;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=K5a/n3k2IMqq05srX3keh8AHLyS8gdBd7xrkRpohd/k=;
	b=+1cZvXlrO7xL17nKz0wAoF3KK5YeFS9Q7mzVtMeDAU1hO4zhZyymaYoKjN/77vVzbho1hb
	zzTSCVhRPHG6TNAg==
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Marc Zyngier <maz@kernel.org>,
 Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, Santosh
 Shilimkar <ssantosh@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu
 <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org, Wei Huang
 <wei.huang2@amd.com>, Manivannan Sadhasivam
 <manivannan.sadhasivam@linaro.org>, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, linux-scsi@vger.kernel.org
Subject: Re: [patch 00/10] genirq/msi: Spring cleaning
In-Reply-To: <20250310165146.GA553858@bhelgaas>
References: <20250310165146.GA553858@bhelgaas>
Date: Mon, 10 Mar 2025 18:31:08 +0100
Message-ID: <87r03423oj.ffs@tglx>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 10 2025 at 11:51, Bjorn Helgaas wrote:
> For the drivers/pci/ parts:
>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
>
> I assume you'll merge this somewhere, let me know if otherwise.

Yes. I intend to get it through tip.
