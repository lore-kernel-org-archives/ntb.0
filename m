Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DEAB7C;
	Mon, 24 Jul 2023 06:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F2E0C433C7;
	Mon, 24 Jul 2023 06:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690178610;
	bh=9wos/qYbisNIf8X7qlZuN3x+iNys+HSTfdq4nyJw1+Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UXrzuiQti9wk8XGirwx45RKsVK7bvs2kfiP3agqSt3MtHtCSWDCEhAGzC0Jk5fPGV
	 cB2aebtAeFiNuGzsbJQx8HKnkm3oYpQ61+vbDjBED7Ez8/67fmHfn1cplKLYJ6JGsP
	 WLSGwpYGJGtAXZd75PBYHVNKvQ43RHp+BqJaeKRj59JjOQTitJZmKSwyFdCtpJz6Yz
	 2lpihiORU6kZPBGEzYy+e4fcFsrbsL6veSPutaVQy1nAKBOtNyloQ73bDznIqx4OpR
	 1XnVMmG38CMx2hZhl18+1tGTgRWd/vAakkhl8KgfWshvLeyaa2cONMUoa5UkQDEzUJ
	 7adFLew2SkYOg==
Date: Mon, 24 Jul 2023 11:33:15 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	linux-pci@vger.kernel.org, mhi@lists.linux.dev, ntb@lists.linux.dev
Subject: Re: [PATCH 5/5] PCI: endpoint: pci-epf-test: Constify pci_epf_ops
Message-ID: <20230724060315.GG2370@thinkpad>
References: <20230722230848.589428-1-lars@metafoo.de>
 <20230722230848.589428-5-lars@metafoo.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230722230848.589428-5-lars@metafoo.de>

On Sat, Jul 22, 2023 at 04:08:48PM -0700, Lars-Peter Clausen wrote:
> The pci_epf_ops struct for the PCI endpoint test driver is never modified.
> Mark it as const so it can be placed in the read-only section.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1f0d2b84296a..7cc1c5c70afc 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -973,7 +973,7 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  	return 0;
>  }
>  
> -static struct pci_epf_ops ops = {
> +static const struct pci_epf_ops ops = {
>  	.unbind	= pci_epf_test_unbind,
>  	.bind	= pci_epf_test_bind,
>  };
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்
