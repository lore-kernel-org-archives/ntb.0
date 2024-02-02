Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881E253E2E
	for <ntb@lists.linux.dev>; Fri,  2 Feb 2024 08:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706863032; cv=none; b=tPpbYW31LfcZI2qe4CFu+lQ/32+16YFG9g1BVpDfe5OT3sYfBoWmfkAsY7GPD/WcTecvYGz24jY5xsgytov6PL+F3h2y8z3E/qPo4OV43Z2DhNJPZ59KrU5cDQE41Abn7RiZZzd6BI1KDw1Vno0DjxElizyqC3T+N+QJGfZSMSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706863032; c=relaxed/simple;
	bh=Czyfyr+8UKrQ+XX6ruEHTKv5D+HXacJ7bTJvUHfQlFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EQu6uNfQcPdRSNqVKlPNzdy/+i9Gr4IkhPlGfHNQ8TOk/e8HXVOknmVeXmDxgaR/NCNKcvMbKfrjb9btYITW5limh1IgzZO5Hgzgy3+yP2906D8GgPln9HQiwJO56U9V7XvMpL3N8JgQDJHIiy1A3lk6qN+Mvsefa2sf0LA59xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fqd3iGmP; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fqd3iGmP"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3bda741ad7dso1521418b6e.1
        for <ntb@lists.linux.dev>; Fri, 02 Feb 2024 00:37:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706863028; x=1707467828; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bSVa4tdnarzL2RCty+6WSO/tCFxJU0zF/PeB4CCvMzU=;
        b=Fqd3iGmPjSKF54EhCxlJITpExDJ2XGrAUX41KI8/3hIoG5pixnz8X/x/O60BIxFSk1
         7yuW3tbCXPN5PNRzbNDn5OamSXDZmMQEQlyUwfAvSFJLJIVMvhHsHha4J/A2oSOPj2qR
         oxhdszw0x/oLNCyq2SiCZZ0U123CAFoJuHyjtoYFRj+NDmgDbkQCt0h+wavN3DP5dks0
         4r3MK+HORc7QWCaAaQ8r7Gjas3S8oicZ50+RDU6WLHGMt1v0sGE98n5773/DrLPfpMEn
         TLF9v4jvYQW2fPzhTtsRvuBJhZyvCaJjJ4Mg9NKQY3FiW21ai5+BkMzvpMV/7sQF3KMH
         6PEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706863028; x=1707467828;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSVa4tdnarzL2RCty+6WSO/tCFxJU0zF/PeB4CCvMzU=;
        b=xBEzUjKaFC4n2KuEq4qikQSuq5ad6UY+dX9Mi1nkXczzOAFcDRMlFIHWcXUt2Z4nVi
         yIomysA8pA9LS2q2ZZjiXrzbr8BNFU9ZGBeZkHWHW5LXH9DzIKDEYHcl+hj/p8XG62Sa
         vH1JxMV7fNf13dVpOz2NtnxppU09oU3gHVXwtqhmKqnV1leB9OjQcea3juzlF79a8yzi
         Ch+3X28KM5eG+V7hT6HuYa1yfSrh1UnLJ5hN3Nw7HU3TDojz7K3qUAg5EGGHaz0GQvqZ
         ZwBbPMnJOYyA7W4oOzY3NclXsA9qQhGWED0WyjPpbrEhnOFaPcpoKTjzRpEsCpArMtfT
         498Q==
X-Gm-Message-State: AOJu0YzbaFwgWC/yBHHF9/IQUn0AEAXA05fnDXahtUTg61UWlnmSLaOA
	qkDjbi59kfXHewPIY4gU8Z4HTnPK4sdmIK22Q+4T6ZmRTthdMCHUvYl1zJsmBw==
X-Google-Smtp-Source: AGHT+IGPn26W49Y/fv0406NegzmywFht1rc4/4sVvSA2xSWRrwV8LyXlXjr6gVQA5zWJm3hYY+2P2Q==
X-Received: by 2002:a05:6808:1a8c:b0:3be:5d77:cfa7 with SMTP id bm12-20020a0568081a8c00b003be5d77cfa7mr7226958oib.1.1706863028549;
        Fri, 02 Feb 2024 00:37:08 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWTL1PQAzxV0geR3WrgESJkz78kNMxmsYVbPIJbqltu/GulAojCJxjGumkUXdnOo1LrWQvIcQCDj5QQuoRAJrqrtt33m1Uk6GK510HfYKN2iC/Hla7bOdQx+UWR3U0Kmwlgn0zPdiFg98KhF6pmTYlMi08LO+KIK5ERvScCAhrBI3OK5LT01n1wjSJ7hC9VLQS2tD0Gb78QcQXxB/ju4B62VsdjMyN9BOSxq0cDTDLCFL7sO5RBXGxQs6aAdfqqYIYkIjshpISuPjhCShbLd/iO/M0XTOxJREtJp8OTjB6uvznF3bZpOda+
Received: from thinkpad ([120.56.198.122])
        by smtp.gmail.com with ESMTPSA id g3-20020a62e303000000b006d9a6a9992dsm1044148pfh.123.2024.02.02.00.37.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 00:37:08 -0800 (PST)
Date: Fri, 2 Feb 2024 14:07:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/3] PCI: endpoint: refactor pci_epf_alloc_space()
Message-ID: <20240202083701.GC2961@thinkpad>
References: <20240130193214.713739-1-cassel@kernel.org>
 <20240130193214.713739-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240130193214.713739-2-cassel@kernel.org>

On Tue, Jan 30, 2024 at 08:32:09PM +0100, Niklas Cassel wrote:
> Refactor pci_epf_alloc_space() to take epc_features as a parameter.
> This is a preparation patch needed for further cleanups.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

One comment below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 5 ++---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>  drivers/pci/endpoint/pci-epf-core.c           | 6 ++++--
>  include/linux/pci-epf.h                       | 4 +++-
>  5 files changed, 12 insertions(+), 9 deletions(-)
> 

[...]

> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> index 2c32de667937..e44f4078fe8b 100644
> --- a/drivers/pci/endpoint/pci-epf-core.c
> +++ b/drivers/pci/endpoint/pci-epf-core.c
> @@ -251,14 +251,16 @@ EXPORT_SYMBOL_GPL(pci_epf_free_space);
>   * @epf: the EPF device to whom allocate the memory
>   * @size: the size of the memory that has to be allocated
>   * @bar: the BAR number corresponding to the allocated register space
> - * @align: alignment size for the allocation region
> + * @epc: the features provided by the EPC specific to this endpoint function
>   * @type: Identifies if the allocation is for primary EPC or secondary EPC
>   *
>   * Invoke to allocate memory for the PCI EPF register space.
>   */
>  void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
> -			  size_t align, enum pci_epc_interface_type type)
> +			  const struct pci_epc_features *epc_features,

s/epc/epc_features

- Mani

-- 
மணிவண்ணன் சதாசிவம்
