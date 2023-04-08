Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8531841
	for <ntb@lists.linux.dev>; Sat,  8 Apr 2023 09:33:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30B75C4339C;
	Sat,  8 Apr 2023 09:33:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1680946421;
	bh=5LHQVHYel5tv55ztru138A8JQd/HYVLUrFnHcljVTiA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BjHM/Kr07XN8ck+U7nzCJ7/fg/No4INN7jFcELLVWWxOrrUreQHQXDtdAGVkXe6mj
	 7CldqvrsdV8Mt9O2WiGLSXhQZDiqPn0stBgKcyXhxQujSuNH8HAYcfhJUHYDgxRuwT
	 tUChXCxb0HbYIoMLFcXoawGO5fRNeojKLK1Wcjb0vL8fz5XbxU9jZL/S5r5m7P9OuI
	 mJW6R49z5ZPqciLtB7doeZhNCm8JIcf8sXIDORahroxAGuA4WprDHHNfHG0YQW9aNS
	 IA2q1xK65boss1LShXSz+m55/j7bJfri5RvAUcSIhHf3hHbgQhWYUqtE93uTPqS7RK
	 TXCXG7hEeIR+g==
Date: Sat, 8 Apr 2023 15:03:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	lpieralisi@kernel.org, kw@linux.com, kishon@kernel.org,
	bhelgaas@google.com, ntb@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: Add missing check for
 alloc_workqueue
Message-ID: <20230408093330.GF11124@thinkpad>
References: <20230104090808.46085-1-jiasheng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104090808.46085-1-jiasheng@iscas.ac.cn>

On Wed, Jan 04, 2023 at 05:08:08PM +0800, Jiasheng Jiang wrote:
> Add check for the return value of alloc_workqueue since it may return
> NULL pointer.
> 
> Fixes: e35f56bb0330 ("PCI: endpoint: Support NTB transfer between RC and EP")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>

Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 04698e7995a5..05c99185ba65 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1441,6 +1441,9 @@ static int __init epf_ntb_init(void)
>  
>  	kpcintb_workqueue = alloc_workqueue("kpcintb", WQ_MEM_RECLAIM |
>  					    WQ_HIGHPRI, 0);
> +	if (!kpcintb_workqueue)
> +		return -ENOMEM;
> +
>  	ret = pci_epf_register_driver(&epf_ntb_driver);
>  	if (ret) {
>  		destroy_workqueue(kpcintb_workqueue);
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
