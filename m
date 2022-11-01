Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8911D7E;
	Tue,  1 Nov 2022 11:59:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D6ECC433C1;
	Tue,  1 Nov 2022 11:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667303970;
	bh=jE2un0Sz/ysAPdWfNQruk9QmhmYI1Sr+/LKCWpOOlWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kk/lfsrrExZHeqKWIiVyavCryh2/yVKVq+BhUY+NEXfY7TIgxd6/5KuCdc7X8OlVK
	 ae8LeA/RAaqT9fhUAZX0CWMewDcr1StcO3eTefVjMZm3XyBQbfJaQeu0B+xawYuSDt
	 uzlMKXkFm7irV5ijcRZk7sJxRpQslUAw1FGJUh/bNLnnOu0E/UmCuDOLd0rVaMx6mO
	 sgyIgo9WWHrg2o7XJJnHZ2TExJLM7AcNDLPsOkqFeSgzgdKG6VAz1x6dMYoI+CPObh
	 P6iOztgIoQIEg9x5fwbYJgqrEZpWoYhb8nxMTkeV+2EufAxiIOfFAqiaDT935/fBsA
	 lGRoTIHiwHnFw==
Date: Tue, 1 Nov 2022 17:28:48 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: allenbh@gmail.com, bhelgaas@google.com, dave.jiang@intel.com,
	helgaas@kernel.org, imx@lists.linux.dev, jdmason@kudzu.us,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v14 4/7] PCI: endpoint: pci-epf-vntb: remove unused field
 epf_db_phy
Message-ID: <20221101115848.GH54667@thinkpad>
References: <20221028155703.318928-1-Frank.Li@nxp.com>
 <20221028155703.318928-5-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221028155703.318928-5-Frank.Li@nxp.com>

On Fri, Oct 28, 2022 at 11:57:00AM -0400, Frank Li wrote:
> From: Frank Li <frank.li@nxp.com>
> 
> None use epf_db_phy and remove it.

"epf_db_phy is not used, so remove it"

> 
> Signed-off-by: Frank Li <frank.li@nxp.com>

With that,

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

Thanks,
Mani

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

-- 
மணிவண்ணன் சதாசிவம்
