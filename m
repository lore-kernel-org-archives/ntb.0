Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024667C;
	Mon, 24 Jul 2023 06:03:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED5E9C433CC;
	Mon, 24 Jul 2023 06:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690178582;
	bh=CvMlmwUTKbn+WYX0ksba8VbKF+8uttgryndWZw9Dpw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NkXSuInN1tQjZ76afG8tnNsZ6AIA6UYcYucqwql3hd56FI7vRV2GgBVQte9zxv3OP
	 v+0Q7vM/+mNx+cxy+O+nkUEr14ZQf1U98hIAPDQklHY7rBpIpphLiryaCGDg9elyPk
	 Ifd0GzYY05rt6O/I5Isu3F7Wm/iMN3CAx58Fe+qqkbtouY8dnQOJfMMzAwm9Jn1zNl
	 ygLgvEj6ziCfnqV6sGXjogkSag7g/6EtM/2jPhlNdrtCwYmAUzP9T5RarsJWt+/Bzb
	 f8VChDb/2QKO0YYBgscp0Cw2KgXy8lofkZseXuPeA0QPqJXH8e8gPerYws/IHJjKTZ
	 FwHRgrzfv7eUQ==
Date: Mon, 24 Jul 2023 11:32:49 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, mhi@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH 4/5] PCI: endpoint: pci-epf-vntb: Constify pci_epf_ops
Message-ID: <20230724060249.GF2370@thinkpad>
References: <20230722230848.589428-1-lars@metafoo.de>
 <20230722230848.589428-4-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722230848.589428-4-lars@metafoo.de>

On Sat, Jul 22, 2023 at 04:08:47PM -0700, Lars-Peter Clausen wrote:
> The pci_epf_ops struct for the PCI endpoint vntb driver is never modified.
> Mark it as const so it can be placed in the read-only section.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index c8b423c3c26e..ff4b43af4487 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1387,7 +1387,7 @@ static void epf_ntb_unbind(struct pci_epf *epf)
>  }
>  
>  // EPF driver probe
> -static struct pci_epf_ops epf_ntb_ops = {
> +static const struct pci_epf_ops epf_ntb_ops = {
>  	.bind   = epf_ntb_bind,
>  	.unbind = epf_ntb_unbind,
>  	.add_cfs = epf_ntb_add_cfs,
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
