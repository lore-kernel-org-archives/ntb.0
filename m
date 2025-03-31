Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E32218E91
	for <ntb@lists.linux.dev>; Mon, 31 Mar 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431978; cv=none; b=hDNn9pXRgWDqP3fGAhf2DS5hM4/vtwti9sAWCSDsNgT3hOEYdnB9nhl2tiPDR2veN8WnbaNOdpgc0uHI2HFL2aezGwt5yP/GywrhvaLL/PxRJUPdNvZfdr5wbo/gVNHF5f4Qf+i/Z/C2EQPazId8CM35/N+Mau7r7+q/rfiC8v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431978; c=relaxed/simple;
	bh=ibQs+2z/9wxImQljXJmUepINT8PM9pQOCQn3UePZQE0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Hi1VTRfTVOUx8PyOY8OAitVFrHrJw0tNwnNUYfShR6qWXqlG7iLnQLz4Bpr3ANwMc4p01nFZWAPgssLQrNcyHXSjRV0wRNUlrKuiPSHGCrmt43pYu5Vudiq8b/FIW4YznVRvByhY4SL0Y7PCidxHITFsdshIkWTkr8kBdficq0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=PVYyWfuQ; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="PVYyWfuQ"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3914a5def6bso2546442f8f.1
        for <ntb@lists.linux.dev>; Mon, 31 Mar 2025 07:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743431974; x=1744036774; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aH1MmO7i2EM9dG0Zv4KTfxBqqxe5CAwWZFTr2eT74Go=;
        b=PVYyWfuQtbZuBYVDPNL4ZwaUIlmHRtwk2rZRjLdEeqbNYeN/GrwwvARLd2mlvZRVsJ
         EiREuozV/H1BLZvf1g7BV/QNJpsOVS/k12+x7oSmV2O3+A4ZhZcg27P6xDhG8n7fpiuw
         ErF4N844pvhhkjEswzXWbt0XPzchb10NWOsZ8e9JhhiP+gdFQb1orYpUmYuWVTrvZEXi
         AXM7pz+VhVgQKnzmErnh+83jRak+S1W5ziCv7FOM3QIAF/L2vFqIF9Ye7VePAXHCIEas
         FG5binsS67aSXWT/Q/TWQavaWxYxOsH+kqdiYB128x7grDCGjFkTQ/IL7O+1J91DxYJw
         XMAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743431974; x=1744036774;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH1MmO7i2EM9dG0Zv4KTfxBqqxe5CAwWZFTr2eT74Go=;
        b=A2J4dG7y1DiRXqN/XRfDgmZLj13uVALguOzX1zPrz+BZ9BGJ1t5ivwwuVusWx9NvO2
         aeakByfDnwjDNknxBXTGs5y4aYx+fD/d+JMh2pirh4yKrwytnzDTbfuWfggCYK8jeNgR
         RXrxyooRpKvwF4+0WWSoioAdmB1QABtOJug22YUAfkROtctr/iPS3jr20ryegioISf0e
         1TwWgo+AGMYyYtXxY6ltkASlmh3m1SOll2WP+sfX9mHEO3nZPqJzGTSmUTATKsNz78ZW
         psvrzpYMhqSy7sgFfyF2soiRODJjQCXUPvCvgx8lNUzmTYg8GkC+BrOYdNjbTgwUD37T
         lfTw==
X-Forwarded-Encrypted: i=1; AJvYcCVd0/NK94xb12Dl/kUDP8dAqPavvwJNFzbGiz+/1+zxERAUeMYfQPFsCobj3bt8rdRz1Qw=@lists.linux.dev
X-Gm-Message-State: AOJu0YzkWvhg3FxoFeE9sRbqKhdLr0Z4VFuJ7BBe0mwRTXTlrFdxVNpX
	mZyLuiv/OAsoAryi+qshcL+SLzCxKDiO5CL8X4zjq3Maogo+ZY01oPyFesGHAao=
X-Gm-Gg: ASbGncuSDAkQXlDi4GLMtXlXK822gYp5sCFyIHsEXT9/0XDY20kx3KJkkL44KByG3sy
	QsDTZM3mhHii8FfIZY/S6TFjAbMEw02LQ4J+0fdHiMRv/g2lyXRpirViEp+0Wq5jch3ZjfifV/8
	VALDf2DvX7JsXnCd2FoxXqsv/uA4xCsCk6S9etX3kIfiAqyUXVNLO0dJsyHeiD3aEVOCsl/h/2P
	a3Tjq2VY5MrAU83eXh1tA2Q9LG+aGqC2QG0D5EVZVHsL39vTvcC232pYL+BbeZGRGzCGJuSAD3t
	/JxthI8DETJYhWk7QQECHVyFUPC2akJV/fDZ1/T7//mf
X-Google-Smtp-Source: AGHT+IEQ/uIqH9TixYrcpDyssxC9uv+FPOAFMaFbCicsPzmrZZQcMc04/p5NwViA6XXeBDzftKYg8w==
X-Received: by 2002:a5d:6d8d:0:b0:39a:ca04:3dff with SMTP id ffacd0b85a97d-39c1211805dmr6850731f8f.40.1743431974481;
        Mon, 31 Mar 2025 07:39:34 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:93ce:f27b:6168:641b])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b658b7bsm11306445f8f.20.2025.03.31.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 07:39:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Marek Vasut
 <marek.vasut+renesas@gmail.com>,  Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev,  dlemoal@kernel.org
Subject: Re: [PATCH 1/2] PCI: endpoint: strictly apply bar fixed size to
 allocate space
In-Reply-To: <Z-pO_c2zXxDqvIsU@ryzen> (Niklas Cassel's message of "Mon, 31 Mar
	2025 10:14:53 +0200")
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
	<20250328-pci-ep-size-alignment-v1-1-ee5b78b15a9a@baylibre.com>
	<Z-pO_c2zXxDqvIsU@ryzen>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 31 Mar 2025 16:39:33 +0200
Message-ID: <1jwmc5tgbe.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 31 Mar 2025 at 10:14, Niklas Cassel <cassel@kernel.org> wrote:

> Hello Jerome,
>
> On Fri, Mar 28, 2025 at 03:53:42PM +0100, Jerome Brunet wrote:
>> When trying to allocate space for an endpoint function on a BAR with a
>> fixed size, that size should be used regardless of the alignment.
>
> Why?
>
>
>> 
>> Some controller may have specified an alignment, but do have a BAR with a
>> fixed size smaller that alignment. In such case, pci_epf_alloc_space()
>> tries to allocate a space that matches the alignment and it won't work.
>
> Could you please elaborate "won't work".
>

As I explained in the cover letter, I'm trying to enable vNTB on the
renesas platform. It started off with different Oopses, apparently
accessing unmapped area, so I started digging in the code for anything
that looked fishy. There was several problems leading to this but it
ended with errors in pci_epc_set_bar() as you are pointing out bellow.

>
>> 
>> When the BAR size is fixed, pci_epf_alloc_space() should not deviate
>> from this fixed size.
>
> I think that this commit is wrong.
>
> In your specific SoC:
>  	.msix_capable = false,
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> 	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256 },
>  	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	.align = SZ_1M,
>
> fixed_size is 256B, inbound iATU alignment is 1 MB, which means that the
> smallest area that the iATU can map is 1 MB.
>
> I do think that it makes sense to have backing memory for the whole area
> that the iATU will have mapped.
>
> The reason why the the ALIGN() is done, is so that the size sent in to
> dma_alloc_coherent() will return addresses that are aligned to the inbound
> iATU alignment requirement.
>

Makes sense and thanks a lot for the detailed explanation. Much appreciated.

>
> I guess the problem is that your driver has a fixed size BAR that is smaller
> than the inbound iATU alignment requirement, something that has never been a
> problem before, because no SoC has previously defined such a fixed size BAR.
>

There is always a first I guess ;)

> I doubt the problem is allocating such a BAR, so where is it you actually
> encounter a problem? My guess is in .set_bar().

pci_epc_set_bar() indeed. It seems the underlying dwc-ep driver does not
care too much what it is given for a fixed bar:

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-ep.c#n409

>
> Perhaps the solution is to add another struct member to struct pci_epf_bar,
> size (meaning actual BAR size, which will be written to the BAR mask register)
> and backing_mem_size.
>
> Or.. we modify pci_epf_alloc_space() to allocate an aligned size, but the
> size that we store in (struct pci_epf_bar).size is the unaligned size.

I tried this and it works. As pointed above, as long as pci_epc_set_bar() is
happy, it will work for me since the dwc-ep driver does not really care for
the size given with fixed BARs.

However, when doing so, it gets a bit trick to properly call
dma_free_coherent() as we don't have the size actually allocated
anymore. It is possible to compute it again but it is rather ugly.

It would probably be best to add a parameter indeed, to track the size
allocated with dma_alloc_coherent(). What about .aligned_size ? Keeping
.size to track the actual bar size requires less modification I think.

>
>
> Kind regards,
> Niklas

-- 
Jerome
