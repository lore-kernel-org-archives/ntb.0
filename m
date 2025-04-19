Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07671DA3D
	for <ntb@lists.linux.dev>; Sat, 19 Apr 2025 04:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745037258; cv=none; b=R66pUc5WVIX//wjZC51PItgKsted7BZOWVwOMf/ouXxZvux2m9gciBswxaoGa3x+mQr4RS/BAVAM6cm2wgvvXVvy5qEQmbu3+/Hj3MOpx90KIr5WSzu4UH/TJ3t0rfiLQ5YbPJnOM0tR3qqhd0o5sWw6/mnDjNzY2lcTZL0P0NA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745037258; c=relaxed/simple;
	bh=5tPkOfZzduiC15DP5jXeToXHofbdMRVLi2k4bBQyVyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gD3i/KWtYySjZ4M4Xe2iSiBbnoa4RqQGGieTfLCbJQq+afm1y3OvmO4pWMziOXDbe4OdDjEiJLh3rEpI0p9DhiEU4mahc5B9qZ6jvS7nwKI5TeDnIFwG5bBh3e4zabWkusPv1oAq0cXBJXAuei/Iz1vRdQjyIACUN48nSzTs5k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q348KEN2; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q348KEN2"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so2204829b3a.2
        for <ntb@lists.linux.dev>; Fri, 18 Apr 2025 21:34:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745037256; x=1745642056; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=;
        b=Q348KEN2U8SQYQKYm2SN+xn1ZL+9nK/2ux5RCyW/US8x7Ud8epJsCdQDOrsYXZE/wa
         8Y1uXYf81HkPSKXoN7M9VV/xDXbtAKidyZOzcx8e+Vqm6fuXiM4sd0KG4l/CPpUyLoBC
         j1ACB7xVGkW2/waC1WjYfQ0kHIc1tULaAwhBzyTsNB2IegZ+AMcwzFlEKOuDr3IEjzDI
         F32mQA0knRhw9YoQkPau4anwD+wQuGzbxhNe//mCWdwSP/bmuTMJbFYTqRhCauTAtQT0
         KGU2dTqkNkJHw7cqSEiDBUms8df4TUxICxqKV3AaFjGnGhDJ2ksXLWf5V20ytrY5Sy0M
         ws6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745037256; x=1745642056;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uXzOal0nfIQ8bFg2XccSM090HwsdWEh3UWZ58CwncMQ=;
        b=Heu1ddvSnx9ZzZMfl4NnJNMIKBPky/axho1Woi2pGkQfV+Sh7XCrMQ2RC60opZlYLj
         ladQMBXCSs6dDmAqTe4leMlXA+EykZwttJqfEE76n5divO3QkwvuJqR6Ply74x7LOzxY
         SHVxu+aEfXdKkGF2uhsZhKdAuTbbYvFwsF569pB+macGk4WH0APjYFtPKw+B8CjEgA2I
         AjnsFv9tAO51LAOVaOwmwnJBbx0DHk4ZDB0kF5PlZ0Vr1Nv92Jx1dI8l79tpZnyLT04V
         Cmrse/NwDl4iv7YpdEb1cS67j7AhRmEPwSNh/qw8LU1SvTgEPh6pBPsyJTn2CEHTra6c
         47fg==
X-Forwarded-Encrypted: i=1; AJvYcCVOqrOKhxLG+FT19HIKq5mzRj9XdRruEl7E8zLNLZWvvXeR+FZJwaVx4uhwaVvoE4heIaI=@lists.linux.dev
X-Gm-Message-State: AOJu0YysQPsyj8A+I05qkWyWsZ7zByjU0i8ZmXmmN7XmIl7yBIblW0iF
	r2UwdfR4HSQsN69iEQKDvdzhq2kVSfHdkGvwzcs2ChSHmwcPijrXy2iVC9WAHg==
X-Gm-Gg: ASbGncuPxMarC3RPDJMW0vhrBEY0z12MkcNpCjJmW4v8YWZz7R6TiLIkWYNl33NPd8b
	usk1813SdGAqCzRzgWvi0mwb0dilHX6DYNjjL5naNRJulAl0XDiceqH5pfcm4XlQA9f9Wb/OHfr
	0MRrzdKtnYovcZPBfTCErA4AeUMRrHxUNvERNUU8KEEZ8f53gX5a5CMoZoD2N2iB4OcIVPJa30/
	fw25Glrx9xOm9kobY/idjsUS93zEDco81DItU++1Pj/zWtSWXKGRXqXjPv2Uf5VuidvUNUev/H4
	hjvOUIal/NgIZrJgB3eLC96M2LbdB0/X9MvMZG+ebdA9/3zYejGx
X-Google-Smtp-Source: AGHT+IEP9iQj2KkpKrslEj+551ckgO39xK+3CJrtgDzGeG3sOciJvji42KgL9hedUsr1SldlGwzI4w==
X-Received: by 2002:a05:6a00:4606:b0:739:3f55:b23f with SMTP id d2e1a72fcca58-73dc14d3124mr5780129b3a.14.1745037256037;
        Fri, 18 Apr 2025 21:34:16 -0700 (PDT)
Received: from thinkpad ([220.158.156.81])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73dbfa58333sm2450467b3a.118.2025.04.18.21.34.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Apr 2025 21:34:15 -0700 (PDT)
Date: Sat, 19 Apr 2025 10:04:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jerome Brunet <jbrunet@baylibre.com>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
	Allen Hubbe <allenbh@gmail.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
Message-ID: <xzn36fjifrwgmxpymmn6v7truzan5of37oxvvriegitnqeuwwr@cgrckqiittfh>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
 <20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
 <Z_Pw3I2xO7BMSGWW@ryzen>
 <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
 <Z_TuIP-k1yLbjcys@ryzen>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_TuIP-k1yLbjcys@ryzen>

On Tue, Apr 08, 2025 at 11:36:32AM +0200, Niklas Cassel wrote:
> On Mon, Apr 07, 2025 at 05:43:00PM +0200, Jerome Brunet wrote:
> > On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:
> > 
> > > Hello Jerome,
> > >
> > > On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
> > >> When trying to allocate space for an endpoint function on a BAR with a
> > >> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
> > >> size. This is expected by pci_epc_set_bar().
> > >> 
> > >> However, if the fixed_size is smaller that the alignment, the size saved
> > >> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
> > >> pci_epc_set_bar().
> > >> 
> > >> To solve this, continue to allocate space that match the iATU alignment
> > >> requirement but save the size that matches what is present in the BAR.
> > >> 
> > >> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
> > >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> > >> ---
> > >>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
> > >>  1 file changed, 17 insertions(+), 8 deletions(-)
> > >> 
> > >> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
> > >> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
> > >> --- a/drivers/pci/endpoint/pci-epf-core.c
> > >> +++ b/drivers/pci/endpoint/pci-epf-core.c
> > >> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >>  	struct device *dev;
> > >>  	struct pci_epf_bar *epf_bar;
> > >>  	struct pci_epc *epc;
> > >> +	size_t size;
> > >>  
> > >>  	if (!addr)
> > >>  		return;
> > >> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
> > >>  		epf_bar = epf->sec_epc_bar;
> > >>  	}
> > >>  
> > >> +	size = epf_bar[bar].size;
> > >> +	if (epc_features->align)
> > >> +		size = ALIGN(size, epc_features->align);
> > >
> > > Personally, I think that you should just save the aligned_size / mem_size /
> > > backing_mem_size as a new struct member, as that avoids the risk that someone
> > > later modifies pci_epf_alloc_space() but forgets to update
> > > pci_epf_free_space() accordingly.

+1. It is always a better approach to store the aligned size during allocation
and use it while freeing. It indeed avoids the alloc/free to go unsymmetry in
the future.

> > 
> > I tried but it looked a bit silly to store that when it was only a
> > matter of calling ALIGN() with parameters we already had, and it is
> > supposed to be only used in those two functions.
> 
> Another advantage is that you could kill patch 1/3 in this series, as
> there would be no need to supply epc_features to pci_epf_free_space().
> 

Yes!

- Mani

-- 
மணிவண்ணன் சதாசிவம்
