Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7581E9E4;
	Tue,  1 Nov 2022 17:20:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55712C433D6;
	Tue,  1 Nov 2022 17:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667323208;
	bh=6Ox0RK2nHYNTq+CojRZxn6uouOLCK0z2hofyLg6s9pw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=aEqSnZK9GHE9Ki2EeNO3PXNWlzGZ7ienJ9IatNJOFvk+GT03v5syVeix1XS5mmdKl
	 pAhtLIAzKWp5sm/4HLiTb9CyhE7Waqey4R16fVfN1xD9/Z/aV55mr4xoEiSDjpUeH8
	 CuOLWXpZNN660V8VvgPKTZL2dTeQtHFuabJboFzb9fopg0KWQZi1AwNIV/JeqzOBi3
	 71LBPx6Z4p+oeZhyAWcs/NOVIFus1/2/nb2EQ3TGqvYcR5Yg3dK5nQIxuZqum53WRs
	 R/PHg9t8yc7vjcYyDgOsQe+fnNwAmNgIId38CkIUyS2QdD0eDf2JrD0MOaS5+DPbLa
	 hSEpz/bqUKpeg==
Date: Tue, 1 Nov 2022 12:20:06 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: mani@kernel.org, allenbh@gmail.com, bhelgaas@google.com,
	dave.jiang@intel.com, imx@lists.linux.dev, jdmason@kudzu.us,
	kw@linux.com, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, lpieralisi@kernel.org,
	ntb@lists.linux.dev
Subject: Re: [PATCH v15 0/7]  pci-epf-vntb clean up
Message-ID: <20221101172006.GA1264778@bhelgaas>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101165709.983416-1-Frank.Li@nxp.com>

On Tue, Nov 01, 2022 at 12:57:02PM -0400, Frank Li wrote:
> continue patch series https://www.spinics.net/lists/linux-pci/msg130372.html
> https://www.spinics.net/lists/linux-pci/msg130924.html
> 
> Lorenzo suggest create new series. Version number continue from old one
> 
> Change from v14-v15
>   Fixed according to Manivannan Sadhasivam's comments, except endian
> problem. Endian problem is out of this patch series scope.
>   kernel test robot report sparse build warning problem already fixed
> at patch 6 and 7.
> 
> Change from v13-v14
>   split spare warning fix to two patch
>   remove local variable reorder
> 
> Frank Li (7):
>   PCI: endpoint: pci-epf-vntb: Clean up kernel_doc warning
>   PCI: endpoint: pci-epf-vntb: Fix indentation of the struct
>     epf_ntb_ctrl
>   PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr at err
>     path
>   PCI: endpoint: pci-epf-vntb: remove unused field epf_db_phy
>   PCI: endpoint: pci-epf-vntb: replace hardcode 4 with sizeof(u32)
>   PCI: endpoint: pci-epf-vntb: fix sparse build warning at epf_db
>   PCI: endpoint: pci-epf-vntb: fix sparse build warning at ntb->reg

Please capitalize your subject lines consistently.  You have two
capitalized:

> PCI: endpoint: pci-epf-vntb: Clean up ...
> PCI: endpoint: pci-epf-vntb: Fix indentation ...

and a bunch that aren't:

> PCI: endpoint: pci-epf-vntb: fix call ...
> PCI: endpoint: pci-epf-vntb: remove unused ...
> ...

Also add "()" after function names:

  PCI: endpoint: pci-epf-vntb: fix call pci_epc_mem_free_addr() ...
