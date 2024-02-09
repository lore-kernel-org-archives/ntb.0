Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC767C5D
	for <ntb@lists.linux.dev>; Fri,  9 Feb 2024 08:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707468047; cv=none; b=BUuGY/jBU5ZB/BKehYMFjCjGjYZfXBZNdJ4jXY+Jn33D3isOO2Al4zc3Rp+ughn655jyo2eNUjzvIHYXAL3f2iPFiNThKJAc0z4soVSsksgxRRPPyYUH0WMHeqsNVB9JVVXObegGEicQURCCiRdAkJkK11+HCrOot75TvKpHKvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707468047; c=relaxed/simple;
	bh=L03SiEDixVoCXTpd/RTYIrFTUuUxJJDE2yFlLIzPwgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idSJY132lexnV0Nkw81okMWM1OU7uJyjaRijmZJ9GaYHPZF2Gc4BAI6ydtXupTXFkvlxQTH7eSLwrEKAwGHdoeXkawMpInlW5x67ho5UItHlbZR6BTtokRz7Uo33/zuwsoTsL0FWqUuU8JpahbOXR8mSq36eX4QfAFLekpfVqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n0VTFOzW; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n0VTFOzW"
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e2bd54b7f6so362777a34.3
        for <ntb@lists.linux.dev>; Fri, 09 Feb 2024 00:40:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707468045; x=1708072845; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+allSi6dNgOI5NZL+tvSAcPNcxZb8/83v0dMPt+LNgM=;
        b=n0VTFOzW6hJHh5a3m0exZ1eo1d4cMY/PvQxz4oYAHFjw/Eg6VL4LZmsLs4AESkCXpS
         Pb3JrcCUkxA3jZCW4oAO+m4GyT/YwpmATHvn3aN0p1jCtJGUpZVGEC2YEP2fFb1factt
         4mbpvqB24ZFMlOWVoXsLJ0zMACVEByWDkxQAABJxtZFdumc7PLlLV7z+91OQy4WH0iHW
         +IooWfCKvJJJUStuKnNJ+QU/zHM1T8k/RVMW8j5VEBjObjWqQEMVGInXRIvjC3cqbCfA
         pDVwcHCUgp/D9XrlasCiqprWH4+EVWNDyxMBjh4g+Y5Hojt2RSr/Xq4vuuRnfSzl+u+G
         NFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707468045; x=1708072845;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+allSi6dNgOI5NZL+tvSAcPNcxZb8/83v0dMPt+LNgM=;
        b=CE2S7HIGWOXhBrxyzHYdLi9JkYLxy0U2wGyVAQfEkciQH7wUrSgizA/c8/iQsf6/Jg
         NZWfSyUIymeLMiSHxM7ATnVSBGSZVqFxWcbV9pOSbPYab1QsC+zoL1x867kbhevXKLYB
         MRUbCFj5SkjUp0OlhKyUvn5UZFjzyi+m/KGvlEUeL1eBiYhxu1rIVjmfN0MwrDhfxMCj
         bpTDf8EQP19Aog+1Qh35Kj/LdqG2wnCXZ1F2IYLhGbnj6J7XtirfH0ssN0CVD/bO+IfC
         SxnbOQ86shQPHeJRFsSGjcn29emUExsHMvqRg0Y+TDG0hUxckt6GejvB1eE5gkEGyaB+
         Vw5A==
X-Gm-Message-State: AOJu0Yynsy0UORy0Mara5bT3xLgGJiSZpaity9FjJvhsnNqgWaLxD2R4
	qySdob6BmWJ6rqSb6jApV97DIMnxfyGW3Wq87hxnVgIxjzHmdzB7RO6SgsUyjQ==
X-Google-Smtp-Source: AGHT+IEL/WiMV9BROlTfuJQzV+HukGeXp9zIsgMMifzgDpaLRJ7Ov4fqalCTwSIVKauCxnDfiqBC9A==
X-Received: by 2002:a05:6358:8a3:b0:176:d0a8:8df with SMTP id m35-20020a05635808a300b00176d0a808dfmr924032rwj.8.1707468045150;
        Fri, 09 Feb 2024 00:40:45 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVFmitalR00woA5PwCCf0fiytsYvIAsD2pwl0lT9B4TsloVDvLV24nUw7wEQh9iWMOW2rXvZugRmiLrrqEXu6yF4Wu1hrGfNvmMnNzYyhi6WQCTYXJueg1tO7AfbBJoDY3bkzXystS6EEYWEQfV0vrIj2nOe2dLwuHjVToRcrO7Ad1c4eSU2sYvuJubfro/bb1Uu7FIn7iJvDfvj6ZOxLKEZvSQv5CmNuo2uvLipwDQ80aB15EfTrIY9ZP1yDnXcQctRVW76zraGoXiJCGpnvs8BbhJmzZdR2zKWg8+gd0YVz9dw6ZH3lUaMHiUmpGgLQ32auKGjw0Z0qTb
Received: from thinkpad ([120.138.12.20])
        by smtp.gmail.com with ESMTPSA id qn13-20020a17090b3d4d00b002960e3745d9sm1188318pjb.13.2024.02.09.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 00:40:44 -0800 (PST)
Date: Fri, 9 Feb 2024 14:10:40 +0530
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
Subject: Re: [PATCH v2 4/4] PCI: endpoint: pci-epf-vntb: remove superfluous
 checks
Message-ID: <20240209084040.GE12035@thinkpad>
References: <20240207213922.1796533-1-cassel@kernel.org>
 <20240207213922.1796533-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240207213922.1796533-5-cassel@kernel.org>

On Wed, Feb 07, 2024 at 10:39:17PM +0100, Niklas Cassel wrote:
> Remove superfluous alignment checks, these checks are already done by
> pci_epf_alloc_space().
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 11 -----------
>  1 file changed, 11 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index ba509d67188b..eda4b906868b 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -527,7 +527,6 @@ static int epf_ntb_configure_interrupt(struct epf_ntb *ntb)
>  static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  {
>  	const struct pci_epc_features *epc_features;
> -	u32 align;
>  	struct device *dev = &ntb->epf->dev;
>  	int ret;
>  	struct pci_epf_bar *epf_bar;
> @@ -538,16 +537,6 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
>  	epc_features = pci_epc_get_features(ntb->epf->epc,
>  					    ntb->epf->func_no,
>  					    ntb->epf->vfunc_no);
> -	align = epc_features->align;
> -
> -	if (size < 128)
> -		size = 128;
> -
> -	if (align)
> -		size = ALIGN(size, align);
> -	else
> -		size = roundup_pow_of_two(size);
> -
>  	barno = ntb->epf_ntb_bar[BAR_DB];
>  
>  	mw_addr = pci_epf_alloc_space(ntb->epf, size, barno, epc_features, 0);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்
