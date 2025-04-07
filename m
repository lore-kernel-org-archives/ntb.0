Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7652C201258
	for <ntb@lists.linux.dev>; Mon,  7 Apr 2025 15:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744040587; cv=none; b=YBz+S15VNjGEa1ZZLDMPjJF5/tHpqSiM78wPqNdl4dskbWnf3EsgAQNness/cKUjMVRMLG1V1683sVq4BpdBGmNJZYhBJi6SvvN93fXt42NCk+82SnvBcKRhg6Dw0+p320xX/nOK0Q80P3s5OXJdRmNnj2yz7ouX5kcmhg59gOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744040587; c=relaxed/simple;
	bh=icEhyVJTzHXg7jgkZ1zmlJ9l7uEXbXUXe7dmfY43wT0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XbKK+SxAOUIZV+q5A7e0HQoH1QodV4Sc/hpwKKeVcGuZ5Ml0JkrkC8gmGKuuqWAAA31VCwGaKPvosdSQhNuUhSjAfcifsbBr+2iHztapA+tTrCqV6g+lVn+XW2Y/x8TPfzIDdgsSxuLguF0Rkit4WL20auQATx/oOa7e2yZ0nfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=YsRWgJbG; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="YsRWgJbG"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43d2d952eb1so31056795e9.1
        for <ntb@lists.linux.dev>; Mon, 07 Apr 2025 08:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744040582; x=1744645382; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=;
        b=YsRWgJbGTq78suZ6PgET0wljXUw9DjKG6SSm6OqwYTMozyBSBvJ2ApTsTm4dssppDF
         rI6ftALs5lEFu8lhtCkBoAfQvh8zv59kjNNLeNTnVo+/A/S+m0UrCmMumEl/9EeWfJuv
         uDIXaaMnWojGComw34BW/vlSAOFzEqn2u5e8o0EOsyZzNUJGUpR3kecMBSwE80wC7czs
         rEF/mDWh44vwDuckJVf93TpAoQwhQCeA6/FTov/f6shlSQHkaC+jDJYmiLkebZhHvaSi
         ODpI75+HkZEZ7kcwUdqIKsPapECV26EYXwQbSjgDHgpDKS8ZVmkTeH2LiPpov2IIQh6v
         Xqlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744040582; x=1744645382;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UwKS83gjL8otXan3IgVJgr6hS9y5Lec7kMgl8CrxX/s=;
        b=sWDEK6CUzMrR1C/QxkVlNxK5JJ70EEOAEGX45qv6+pb1r2x+N85fr/3SsCIsW36GJm
         7gwMNOKFb0WFXNHknQVXrYYna3OTlIADlEQZv3u4FXDnp6PJixE+Ql6RgeQqxJcLX1RK
         BC3cEnWPmtFfxNdkL3mMmyg0OeqLql4CZwZSxklITzAj3lca4Y2unEdvxD7TJ/DVCTi2
         8UwLqFWTij9/KFP0invoONT+5tBvyVBdAIAoNgF1P4Zun0+nkpSFuVOdB1cdjqe5NSJX
         71B8nuRHZ9OEyHcg1gTemOanhOfdwSZlqxDZs9GZeNnqZWVzIfHqEDLZkPNA0y713JN7
         lj8Q==
X-Forwarded-Encrypted: i=1; AJvYcCUUfvYZb1mUQruczVzrORZGaYWej3RJzGfq7dYPI2zvEij7cEqo7qJx7+aWKR1fQZtOqa4=@lists.linux.dev
X-Gm-Message-State: AOJu0YwUJkgPb0pL6h+rcRdhof762N0USbqsuFUvbySxgOTmB8MBvP09
	aWh1CbD9MwL1dpwn4Agkx+FDzjdivCNPPOQ16vXrbulvhSsa1EuuUZB5rJEM+3w=
X-Gm-Gg: ASbGnctD7PhPd9wI5FAHOXWua9M6qF4CPHs4jI7kt3cazLPGUjd1tD0njyTp4UNBpex
	/x2fyW0C3V5hW3XUyUzSn2GqplequH8EBuQtxKVORR9i2dwjeOPvCBZ82X0PYXl6Y0u5eHgZi5s
	q0EggkdqbcRwdRwT/S5Fj3Eq23fF2FzvcDkbEYw1QE7CntZpQ1ZzgkzZaTWWwOagn5EWEPNakjV
	6LiHMs57ewV//1BNT9caykTjzfxJMObpCaG/W+E//Lm42nYAlmZbwise/iDLF8ae8CQziN/bWkN
	YgKs3Yq64HLVS9E/kkuldtu0jjFQInsHbA7Y6+bI9+8pCHL29kZy8A8=
X-Google-Smtp-Source: AGHT+IEvLb0NTyDHj4c780QWtXn9xkplpLX5dvvjj3YvSoxW0R3QPk0BF940mrnTtyAAxjx1VydCvA==
X-Received: by 2002:a05:6000:2a5:b0:39a:ca04:3e4d with SMTP id ffacd0b85a97d-39d6fc00aabmr7580240f8f.7.1744040581642;
        Mon, 07 Apr 2025 08:43:01 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c301a0a90sm12335092f8f.21.2025.04.07.08.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 08:43:01 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Christoph
 Hellwig <hch@lst.de>,  Sagi Grimberg <sagi@grimberg.me>,  Chaitanya
 Kulkarni <kch@nvidia.com>,  Marek Vasut <marek.vasut+renesas@gmail.com>,
  Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev,
  linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 2/3] PCI: endpoint: improve fixed_size bar handling
 when allocating space
In-Reply-To: <Z_Pw3I2xO7BMSGWW@ryzen> (Niklas Cassel's message of "Mon, 7 Apr
	2025 17:35:56 +0200")
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
	<20250407-pci-ep-size-alignment-v3-2-865878e68cc8@baylibre.com>
	<Z_Pw3I2xO7BMSGWW@ryzen>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Mon, 07 Apr 2025 17:43:00 +0200
Message-ID: <1jjz7wvuyj.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Mon 07 Apr 2025 at 17:35, Niklas Cassel <cassel@kernel.org> wrote:

> Hello Jerome,
>
> On Mon, Apr 07, 2025 at 04:39:08PM +0200, Jerome Brunet wrote:
>> When trying to allocate space for an endpoint function on a BAR with a
>> fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
>> size. This is expected by pci_epc_set_bar().
>> 
>> However, if the fixed_size is smaller that the alignment, the size saved
>> in the 'struct pci_epf_bar' matches the alignment and it is a problem for
>> pci_epc_set_bar().
>> 
>> To solve this, continue to allocate space that match the iATU alignment
>> requirement but save the size that matches what is present in the BAR.
>> 
>> Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
>>  1 file changed, 17 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
>> index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
>> --- a/drivers/pci/endpoint/pci-epf-core.c
>> +++ b/drivers/pci/endpoint/pci-epf-core.c
>> @@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>>  	struct device *dev;
>>  	struct pci_epf_bar *epf_bar;
>>  	struct pci_epc *epc;
>> +	size_t size;
>>  
>>  	if (!addr)
>>  		return;
>> @@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
>>  		epf_bar = epf->sec_epc_bar;
>>  	}
>>  
>> +	size = epf_bar[bar].size;
>> +	if (epc_features->align)
>> +		size = ALIGN(size, epc_features->align);
>
> Personally, I think that you should just save the aligned_size / mem_size /
> backing_mem_size as a new struct member, as that avoids the risk that someone
> later modifies pci_epf_alloc_space() but forgets to update
> pci_epf_free_space() accordingly.

I tried but it looked a bit silly to store that when it was only a
matter of calling ALIGN() with parameters we already had, and it is
supposed to be only used in those two functions.

>
> But I will leave the decision to the PCI endpoint maintainers.
>

Ultimately, I do not have a strong opinion on this. Either way is fine
by me.

>
> Kind regards,
> Niklas
>
>
>> +
>>  	dev = epc->dev.parent;
>> -	dma_free_coherent(dev, epf_bar[bar].size, addr,
>> -			  epf_bar[bar].phys_addr);
>> +	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
>>  
>>  	epf_bar[bar].phys_addr = 0;
>>  	epf_bar[bar].addr = NULL;
>> @@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  			  enum pci_epc_interface_type type)
>>  {
>>  	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
>> -	size_t align = epc_features->align;
>> +	size_t aligned_size, align = epc_features->align;
>>  	struct pci_epf_bar *epf_bar;
>>  	dma_addr_t phys_addr;
>>  	struct pci_epc *epc;
>> @@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  			return NULL;
>>  		}
>>  		size = bar_fixed_size;
>> +	} else {
>> +		/* BAR size must be power of two */
>> +		size = roundup_pow_of_two(size);
>>  	}
>>  
>> -	if (align)
>> -		size = ALIGN(size, align);
>> -	else
>> -		size = roundup_pow_of_two(size);
>> +	/*
>> +	 * Allocate enough memory to accommodate the iATU alignment requirement.
>> +	 * In most cases, this will be the same as .size but it might be different
>> +	 * if, for example, the fixed size of a BAR is smaller than align
>> +	 */
>> +	aligned_size = align ? ALIGN(size, align) : size;
>>  
>>  	if (type == PRIMARY_INTERFACE) {
>>  		epc = epf->epc;
>> @@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
>>  	}
>>  
>>  	dev = epc->dev.parent;
>> -	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
>> +	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
>>  	if (!space) {
>>  		dev_err(dev, "failed to allocate mem space\n");
>>  		return NULL;
>> 
>> -- 
>> 2.47.2
>> 

-- 
Jerome
