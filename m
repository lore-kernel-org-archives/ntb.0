Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BAE3FB13
	for <ntb@lists.linux.dev>; Tue,  5 Dec 2023 09:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY9vk7rj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701770400; x=1733306400;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=+jPQaiS0CLFcu1huBYFsPOpZc/7ncj6I1Rcc/Iu6fms=;
  b=IY9vk7rj5UWD+MV+pimDhvQV8DtaOy1RW6no1JfkbyBGEVTdqfym6IBF
   lvMNpawlUNcOwsXCx8UOehIa2lgb30axAZpVnIWqjLk3wPXomwcyz1QYD
   wFb3OvwFsABh/oH0rd3tIRZMi9OC0XIEabfK0/honSIOYDs4JiqMFuddF
   NWntjFP3hjjVEa5lkR/g0P/GdKs2YEhPqIvS7VV5dik4DtA4voFVO4nOq
   WuhMLMtl6uSzH4xv+HPj9soPxnbzBA77rfbACreRDQGNgICD6ySVtTN+d
   1QksZjLnMALZ8Jt+ae7QcNRxecE4Dq6t+a0l582bs8ihFnbeEz/6WmP5k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="396667840"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="396667840"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:59:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="774582000"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="774582000"
Received: from nlawless-mobl.ger.corp.intel.com ([10.252.61.141])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:59:55 -0800
Date: Tue, 5 Dec 2023 11:59:53 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Yang Yingliang <yangyingliang@huaweicloud.com>
cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, jdmason@kudzu.us, 
    dave.jiang@intel.com, allenbh@gmail.com, lpieralisi@kernel.org, 
    kw@linux.com, mani@kernel.org, kishon@kernel.org, bhelgaas@google.com, 
    yangyingliang@huawei.com
Subject: Re: [PATCH 2/2] NTB: EPF: return error code in the error path in
 pci_vntb_probe()
In-Reply-To: <20231201033057.1399131-2-yangyingliang@huaweicloud.com>
Message-ID: <8eb01521-5eca-762c-c944-c7604564c54c@linux.intel.com>
References: <20231201033057.1399131-1-yangyingliang@huaweicloud.com> <20231201033057.1399131-2-yangyingliang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1611894948-1701770398=:1829"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1611894948-1701770398=:1829
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 1 Dec 2023, Yang Yingliang wrote:

> From: Yang Yingliang <yangyingliang@huawei.com>
> 
> If dma_set_mask_and_coherent() fails, return the error code instead
> of -EINVAL.
> 
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 2b7bc5a731dd..c6f07722cbac 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1272,7 +1272,7 @@ static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
>  	if (ret) {
>  		dev_err(dev, "Cannot set DMA mask\n");
> -		return -EINVAL;
> +		return ret;
>  	}
>  
>  	ret = ntb_register_device(&ndev->ntb);

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1611894948-1701770398=:1829--
