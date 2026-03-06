Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE6E93B5842
	for <ntb@lists.linux.dev>; Fri,  6 Mar 2026 15:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810696; cv=none; b=UKIxLCqcege3tQ2LjEkIxJsP0mdXNgHeMPT3puDolUuGH6rpnV0/8TaoRS0U4hv8kiwejpD0VbBXdbXpZ5uFGd6sAyFIL0pQsZyTNVwKOzomFpA1qo91yYfuc7II6uubod0S4KU3CD+hkzuRTaKMhZgubGy1BWr2mcryZ/QcAhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810696; c=relaxed/simple;
	bh=M+XEIPcFRnNfKXGVqQa3O2jUSFoP+59bk0GS4PRRcJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F2nWslYyBTjRTa9kbBt+K035Ytrm88KzOlN7UwiEkchGOIGltQj/2I6AXpFIgtKaHqaYmC4c9tq1QCaC+tZiLMpZHmVSh8sAsHFrg1PzODEx2VQ0aT9CL6xxdaHMUtfm5gkeSKBCl7A390FrwTserBT+vOBqWkl6iwqD1ZJZ9os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UbAbUaFf; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UbAbUaFf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772810692; x=1804346692;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M+XEIPcFRnNfKXGVqQa3O2jUSFoP+59bk0GS4PRRcJY=;
  b=UbAbUaFfrxLj5lOwUuU948WtRO+0lJAJdB/tEFHqDGFgCmDMzJK8NpSh
   f3lOwfSFBsSWK9Y92wLF0SBZFboF77paJTWcx48k4NGE5npq7aD69kTze
   C8xOKZPnzVTj/fey988li3kPaRYaXripkXfPbnR3z7zHHHQlNNgJZIgOt
   rUyTf0Mqvc6nHlIQEXuJ8/uLqwK614TayLuzMYZHtUIsWEGKaXMTC1hcj
   WfTCfw7vCE2P+j5Gk4sI4twkLtaSeuzQt2G8eJeLDnRW9AIAyhlSZCsmt
   fbPykjcLihTnVhr+IZlY6KgRG5k0+abtShAdss/DgiahSNfQ8cSQesgdV
   w==;
X-CSE-ConnectionGUID: //oMmrjKQfqqFEyhemiWgg==
X-CSE-MsgGUID: nIMMYerpSJuOW8zCBBvYYg==
X-IronPort-AV: E=McAfee;i="6800,10657,11721"; a="73115317"
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="73115317"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:24:51 -0800
X-CSE-ConnectionGUID: 3HLiMIY0SNCPpmAkz+N8+A==
X-CSE-MsgGUID: +0Ku9DjRQ3uA+3tgKFkcDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,105,1770624000"; 
   d="scan'208";a="223736764"
Received: from jdoman-mobl3.amr.corp.intel.com (HELO [10.125.109.87]) ([10.125.109.87])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2026 07:24:50 -0800
Message-ID: <1ff2c42c-73b2-43f3-a520-fcc3c16cc0a2@intel.com>
Date: Fri, 6 Mar 2026 08:24:48 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: Implement
 .get_dma_dev()
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>,
 Niklas Cassel <cassel@kernel.org>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20260306031443.1911860-1-den@valinux.co.jp>
 <20260306031443.1911860-4-den@valinux.co.jp>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260306031443.1911860-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/5/26 8:14 PM, Koichiro Den wrote:
> When vNTB is used as a PCI endpoint function, the NTB device is backed
> by a virtual PCI function. For DMA API allocations and mappings, NTB
> clients must use the device that is associated with the IOMMU domain.
> 
> Implement ntb_dev_ops->get_dma_dev() for pci-epf-vntb and return the EPC
> parent device.
> 
> Suggested-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 20a400e83439..e5433404f573 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -1436,6 +1436,14 @@ static int vntb_epf_link_disable(struct ntb_dev *ntb)
>  	return 0;
>  }
>  
> +static struct device *vntb_epf_get_dma_dev(struct ntb_dev *ndev)
> +{
> +	struct epf_ntb *ntb = ntb_ndev(ndev);
> +	struct pci_epc *epc = ntb->epf->epc;
> +
> +	return epc->dev.parent;
> +}
> +
>  static const struct ntb_dev_ops vntb_epf_ops = {
>  	.mw_count		= vntb_epf_mw_count,
>  	.spad_count		= vntb_epf_spad_count,
> @@ -1457,6 +1465,7 @@ static const struct ntb_dev_ops vntb_epf_ops = {
>  	.db_clear_mask		= vntb_epf_db_clear_mask,
>  	.db_clear		= vntb_epf_db_clear,
>  	.link_disable		= vntb_epf_link_disable,
> +	.get_dma_dev		= vntb_epf_get_dma_dev,
>  };
>  
>  static int pci_vntb_probe(struct pci_dev *pdev, const struct pci_device_id *id)

