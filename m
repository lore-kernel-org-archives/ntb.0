Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818E12FAF
	for <ntb@lists.linux.dev>; Fri, 15 Jul 2022 21:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4A98C34115;
	Fri, 15 Jul 2022 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657919182;
	bh=3rMAJ2lVe/XGnRSOvqbNg+N96brIGh5qsH92ulpVn00=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RN3wplA05RkAtDtZSdAWzbo5g67gU4NFy+F+e7ZQXWxQqiInonor1+zpUUbOeK29L
	 NqH5IQ4vGRM1QGzNkc4tDLfHLYGDBBr1OcZ/EEwfdyrQBZIfAzSqWWkStM/+6DuziL
	 cBuiRDZNiuNPSznKzKcZKMVcJzyJJPZ/GuDUuSps4ANKLcWI83hhgaQOc8zqXktqa2
	 D0KDzTfu35ip4DitN9zjOZePcX62LrOzdhpCN5Kb/aCYSRfdZqIZTfk97+WMRhpdN1
	 xk4oF1qAjOEeq9j80hK+NLArigGm09MoNJRI15EIOcvKgQ2cnVMoOtCXM1S+ed7cfZ
	 O2bqUEFGWhNmg==
Date: Fri, 15 Jul 2022 16:06:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>
Cc: maz@kernel.org, tglx@linutronix.de, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
	s.hauer@pengutronix.de, kw@linux.com, bhelgaas@google.com,
	kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	peng.fan@nxp.com, aisheng.dong@nxp.com, kernel@pengutronix.de,
	festevam@gmail.com, linux-imx@nxp.com, kishon@ti.com,
	lorenzo.pieralisi@arm.com, ntb@lists.linux.dev
Subject: Re: [PATCH v2 4/4] pcie: endpoint: pci-epf-vntb: add endpoint msi
 support
Message-ID: <20220715210619.GA1190861@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220715192219.1489403-5-Frank.Li@nxp.com>

[+to Jon, since I guess he will apply or at least review this, not me]

On Fri, Jul 15, 2022 at 02:22:19PM -0500, Frank Li wrote:
> This patch add msi support for ntb endpoint(EP) side.
> EP side driver query if system have msi controller.
> Setup doorbell address according to struct msi_msg.
> 
> So PCIe host can write this doorbell address to EP
> side's irq.
> 
> If no msi controller exist, failback software polling.

s/This patch add/Add/
s/msi/MSI/ (several)
s/ntb/NTB/
s/irq/IRQ/
s/failback/fall back to/

Rewrap commit log to fill 75 columns to make it easier to read.

> +static int epf_ntb_db_size(struct epf_ntb *ntb)
> +{
> +	const struct pci_epc_features *epc_features;
> +	size_t	size = 4 * ntb->db_count;
> +	u32	align;

Replace tabs with spaces in these declarations , since that's what
code below does, e.g., in epf_ntb_db_bar_init(), etc.

> +		dev_info(dev, "Can't allocate MSI, failure back to poll mode\n");

s/failure/fall/

> +		return;
> +	}
> +
> +	dev_info(dev, "vntb use MSI as doorbell\n");

> +		ret = devm_request_irq(dev, virq,
> +			       epf_ntb_interrupt_handler, 0,
> +			       "ntb", ntb);
> +
> +		if (ret)
> +			dev_err(dev, "request irq failure\n");

s/irq/IRQ/ (or spell out "devm_request_irq()").

Capitalize all messages or none of them.  Match the prevailing style
of the file.
