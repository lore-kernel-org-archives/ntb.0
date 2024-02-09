Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AF2664C5
	for <ntb@lists.linux.dev>; Fri,  9 Feb 2024 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468704; cv=none; b=IlvP8eGw/R5OCCpcg39QVa4pEYKt272AACboljpJX1Ivb4rAuqd/Idd1rltWP+2p4NV6paHiTbbmkXWRhQgwxqWHpBlJcQOU8akAl42zVC7ftSU5VnWfl57DpjbuontpEXZz4gOYV0OdpwpTk9nG6KHDTRPB3pHv9+n2hNwOQc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468704; c=relaxed/simple;
	bh=9AzuDP0VLLPHn50Ebfzikmud3iPeTb7vb4a+4caxsEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=np08UyGXlVgWup102Dv0z9BxZu7o/Sn1hil4le+PkYzCyrhBNXBxpN7K2mtPhUzBOMKCoIG0F+WCB51dM7mpBAggaC/xTqrrgGmAODv/NCXGJRHgBQWeKCiZx/DVbiUEPf14OLA7MeUtqgG4s2A7RXDNR4xBr4lr91YSzOHtsMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QsDG5IEz; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QsDG5IEz"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3bb9d54575cso397026b6e.2
        for <ntb@lists.linux.dev>; Fri, 09 Feb 2024 00:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468701; x=1708073501; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TOxpM7+/7Mt2MJMv3CN+dNjLs92Ols1j+m9/bnLdB7M=;
        b=QsDG5IEzfkOWmGYjCq29CA1BIaBRtZrxQcPC1UF3kUZyI1dZAJjHNHLncOVH/McId3
         n8PjrVjxkIHJOAVndXFNdHtlIvjHk54FA+IFgwzfhR+N1KkBGu2PHUiSedjdbnYolgxo
         8xZcgaHAZiQnfCCVPfdHLlrL0cZoUMpklfnJU6Z2BrR47HhHF0Q9CbgMgsPXrT3SLInp
         6HnaJKULHWzoj1pN/taFtt6c3qn595BU+lhJDlWWAOZ/KccRZYzxB7fO67Ts5SMPvfTb
         T8JcLhm219qDTQNdBilV4+338KJ/LL0Dx7uRyzkCeYW/0stNVurGzG1oCLIhDK4f01Qx
         UyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468701; x=1708073501;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TOxpM7+/7Mt2MJMv3CN+dNjLs92Ols1j+m9/bnLdB7M=;
        b=DPGaP06T1NFdAf/ebmbZJ40pec9E8y/ElfORjP5IU2dknjYvcGeZxGGcK9lht25McP
         kFE9i5PWVcQoAPXM3Q2n3jGkvFOGp1wAcQgQfpzdAfPe5Cm/BlN2phyZRYQ4c2WqZ72j
         LDb0KdTGV3IrcgyYIAZrLFeE22njthoJxxYXoJr2e5Y+TbJo3Ndv+6SHvs495JnWH/62
         YeRPOLxNSh5szxlM5ec82xUDliBVFLIjd28I6YMzhplQJ94Eo4rVETBMvtH3IpqOo79q
         65W6askOzzeGD7KsgkBHSveNX7Udsbur8ITsRWrtDrpy5U3X35c71rTQxg+DC3tO7E4W
         ckdQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzXx8Zp4yCkEBbFs4CVJD1uYyI6DBLrLsFEDVjivYcyj4Dod9uFlXmBrR3ZkxwkCgkUAFeiLuMdOHYCRaaR3yIRczd
X-Gm-Message-State: AOJu0Yw5OoDzWrMWFo/HREM5rNdYddcknbhUyw4HAN506kVLGouura+n
	f9MO5esqVhjEje/mZwhYVhmQqXFJhMeJeLx88Ja3aGqvHVyLWiLMgMcSsIBGPw==
X-Google-Smtp-Source: AGHT+IEYaUKX1eNiYZimTKIJepWhK9ExPj0lALVcLY8cYe2ie+LUQ6nIeISX1ni9nsnnlgv0X0vSEA==
X-Received: by 2002:a05:6808:e85:b0:3bf:e050:9128 with SMTP id k5-20020a0568080e8500b003bfe0509128mr1188012oil.22.1707468701490;
        Fri, 09 Feb 2024 00:51:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWlG7nORhDRjlWa4C4rWmhk8Uh+JuDDNEx6j+DKxXnlANj82rRFvluT6Zm5B7FdO29D6+2Yp3K12sTZYWOAYXbpMypGNAxrzMtTrmtJbC1U27cJSsBwKxY8113H0O7iCp3NBWjeBPXzYeiHFLzbCYU2oNWfiyAvQFjA7L3txpjYPQ7awC7Ok6byNjntTKDwMkowgGYoZn8CV3y6abPWiJ3MfqnG9raVRXWoR/6jHwHOjDvOUzHJJ1v1oaHphXn01zHvhejHP2pjtWaNJ9nvNMMdfSt0YBVzQ6h0Vcv7DpD+HlEr9n0zesJMtuFVikiWnUcVKGbilljUwS52
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id z123-20020a626581000000b006e08d628e2asm702399pfb.19.2024.02.09.00.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:51:41 -0800 (PST)
Date: Fri, 9 Feb 2024 14:21:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/4] pci_epf_alloc_space() cleanups
Message-ID: <20240209085136.GF12035@thinkpad>
References: <20240207213922.1796533-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207213922.1796533-1-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:39:13PM +0100, Niklas Cassel wrote:
> Hello all,
> 
> Here comes some cleanups related to pci_epf_alloc_space().
> 

Applied to pci/endpoint!

- Mani

> Changes since v1:
> -Picked up Reviewed-by tags.
> -Fixed kdoc param name to match the actual param name in patch 1/4.
> -Split patch "improve pci_epf_alloc_space()" into one patch changing
>  pci-epf-core.c (patch 2/4 in V2) and pci-epf-test (patch 3/4 in V2).
> -Perform the alignment even for fixed size BARs. We need this since:
>  1) Some platforms have fixed_size_bars that are smaller than the
>     iATU MIN REGION.
>  2) No longer doing so would be a functional change and not a cleanup.
> 
> 
> Kind regards,
> Niklas
> 
> 
> Niklas Cassel (4):
>   PCI: endpoint: refactor pci_epf_alloc_space()
>   PCI: endpoint: improve pci_epf_alloc_space()
>   PCI: endpoint: pci-epf-test: remove superfluous checks
>   PCI: endpoint: pci-epf-vntb: remove superfluous checks
> 
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  2 +-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++-----------
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 15 ++-------------
>  drivers/pci/endpoint/pci-epf-core.c           | 15 +++++++++++++--
>  include/linux/pci-epf.h                       |  4 +++-
>  5 files changed, 21 insertions(+), 28 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்
