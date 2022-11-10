Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628B1323E;
	Thu, 10 Nov 2022 15:29:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53EA3C433C1;
	Thu, 10 Nov 2022 15:28:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1668094143;
	bh=b1tXEdAkG7FjFwcJznZTpiZu17tiittNuwu2BIgCp3U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qe4srMJqydGdXXK1KXUKd7JrqnhJl+z0eatx1nK/Ecm/ErzRKIS2BZ2ZwhyJeYTmx
	 veW26JSCd1QjWQ+7gg7hzR6tIL5G+55ALlPVG8UoECvZPlhle1wzIQnPg9/FCAVebR
	 YG/egHpEtYw//zAAEAn1iwpWPWMkAoEPDa+68OCO4JeCfNnVudn6I21uPPm7aQvslK
	 2UGnzEOE962gsPkRoPna2uLi2tfTWK5wp83ng45xYY+Une/tX6H1/D6jXOaAZo2ur0
	 rmJ8EoX5WvRGX8yDfvpJQyDktWOpmEYPFGhIREsGwb/iEXsLARwqMlP/BD54FVDkbv
	 jQkVymI/2wczg==
Date: Thu, 10 Nov 2022 16:28:55 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, helgaas@kernel.org, imx@lists.linux.dev,
	jdmason@kudzu.us, kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH v16 4/7] PCI: endpoint: pci-epf-vntb: remove unused field
 epf_db_phy
Message-ID: <Y20Yt7T0bivqUvop@lpieralisi>
References: <20221102141014.1025893-1-Frank.Li@nxp.com>
 <20221102141014.1025893-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221102141014.1025893-5-Frank.Li@nxp.com>

On Wed, Nov 02, 2022 at 10:10:11AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> epf_db_phy is not used, so remove it

Sentences end with a period (.). I can fix these things but
we can't spend our lives telling you how to write a commit log,
check how they are written in the PCI subsystem and follow the
pattern.

https://lore.kernel.org/all/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

> 
> Signed-off-by: Frank Li <frank.li@nxp.com>
> Acked-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 191924a83454..ee66101cb5c4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -136,7 +136,6 @@ struct epf_ntb {
>  
>  	struct epf_ntb_ctrl *reg;
>  
> -	phys_addr_t epf_db_phy;
>  	void __iomem *epf_db;
>  
>  	phys_addr_t vpci_mw_phy[MAX_MW];
> -- 
> 2.34.1
> 
