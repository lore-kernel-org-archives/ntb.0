Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432707C;
	Mon, 24 Jul 2023 06:01:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F046C433C8;
	Mon, 24 Jul 2023 06:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690178519;
	bh=X65YbH+8/ToJXqQYRJxJdodUWxzLkArXvZEQRJ/2ygs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hSaVJhkiMCaAThvfo4u+7LQYmF6oinsIfPtZ34k296vDWACwXoZOl/cw0QnDHfXny
	 +yUh6NofWqbTMv6Ek/18bl4lpp7ZJiBwBSfbOVVOguaXbn54y4yGefgb27DTPWEIG9
	 x/2HQEkQOTs/xPayMlZr6wlgd6Ktfl0szlfjLXAL7ZYqc7nVxJTbW3+xMFXxajLWf0
	 ESjwFpiMI9nuv7uIon1t5ND0mOvO9819RLjD8T1a18oSqIh53Cr8SLllf6T+YCu7ke
	 mmoH3bB7C99j0gCG8R65yLXqgnjWst+A1GW5JzQiBLoZzHtBUc6WqOiSNvP/ti34fq
	 jKclTyusvmmyA==
Date: Mon, 24 Jul 2023 11:31:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, mhi@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH 2/5] PCI: endpoint: pci-epf-mhi: Constify pci_epf_ops and
 pci_epf_event_ops
Message-ID: <20230724060145.GD2370@thinkpad>
References: <20230722230848.589428-1-lars@metafoo.de>
 <20230722230848.589428-2-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722230848.589428-2-lars@metafoo.de>

On Sat, Jul 22, 2023 at 04:08:45PM -0700, Lars-Peter Clausen wrote:
> Both the pci_epf_ops and pci_epf_evnt_ops structs for the PCI endpoint mhi
> driver are never modified. Mark them as const so they can be placed in the
> read-only section.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 9c1f5a154fbd..bb1c8e502a09 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -389,7 +389,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
>  	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
>  }
>  
> -static struct pci_epc_event_ops pci_epf_mhi_event_ops = {
> +static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
>  	.core_init = pci_epf_mhi_core_init,
>  	.link_up = pci_epf_mhi_link_up,
>  	.link_down = pci_epf_mhi_link_down,
> @@ -428,7 +428,7 @@ static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
>  	{},
>  };
>  
> -static struct pci_epf_ops pci_epf_mhi_ops = {
> +static const struct pci_epf_ops pci_epf_mhi_ops = {
>  	.unbind	= pci_epf_mhi_unbind,
>  	.bind	= pci_epf_mhi_bind,
>  };
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
