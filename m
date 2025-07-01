Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B092741DA
	for <ntb@lists.linux.dev>; Tue,  1 Jul 2025 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751377144; cv=none; b=Fkg5kFhR7rAXs9ZvzLJcaCinmtRhd1ybMyx5Bz9XHnmt8YBhT9LlWB2u98zklYFb7aKd+4BZvMmplmCN0HvuC4vbkupjcilh//5cPWN9YfR74cMo/Ot2gqUVvtfzxD3bbsHFROe1aMTMShMxTid/ZTtqpRecXUo4TCAFKVz+rmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751377144; c=relaxed/simple;
	bh=ibGwhtiJ8cVFBay6kJDzISuN07x1ov3VtA8N2wC6f6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2nePsVRB72UejsEfwXk3wvuT+p4TFSct174WSW3c0Qrbt6Uf/aohXz20xcKFGpAAaL38bJG/MnemZppD/GECen9My3YPNJOur8LU87CK6cgaCyJbX4CtVoYbEyUUhiKV6PV6mClcbsuA/VOmrAl7R1Pm7YMYFYCdyXLikU4vtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=z/XPgWFZ; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="z/XPgWFZ"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4539cd7990cso13297305e9.0
        for <ntb@lists.linux.dev>; Tue, 01 Jul 2025 06:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751377139; x=1751981939; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3x62e+wGkvPyUJlGyyDzPotc9gk/sxa1tvutDh+K+6w=;
        b=z/XPgWFZy4zMd+lz3Xzanewka24Wbbt0iFUHxiEthINQXTvomOZC2JaLwaoJ23Zm3J
         oTrLNb5QKSv1Hv39/7e6EX5ccGvkE8unH71EMoJPSXTi8SBkWA43Xr2MA2TDos0C2wDO
         aZM5W2bN0tSs+NzDox4B7QXcchQwKpJH0N0sXIwoIAT8b1i+NsIId/FDkMzOQ+3rsDUo
         JyaKg9rm/rTG85+rWQnIwf3Y4fcTGdPZCag2Hz8OZ9kp/+3B7tbZ3/tNiwYucYowZLZK
         otzLv/S5LheoDZxjtFl/qXuDSPyH1dmtaFUJ7xdC74X3JTyv3rQxQQdhg2B3pSDYo983
         whaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751377139; x=1751981939;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3x62e+wGkvPyUJlGyyDzPotc9gk/sxa1tvutDh+K+6w=;
        b=N6lkJT84fGHQmL89XA2kXo1LA+8S8DCyLfJDmtk03SzCtaQx0Rdk+n/+yXePXtPviC
         Y9qSwIN696Vz+wEis9MY4sffkiQ3ha+rlkr7OM0NpWdj0J/9hFxh+LXsk2wxO2Wfc84E
         y5ooR097tJzn3O6Mz3kmiARZYIjbTxlcLOw6/NQh9xAatPY/LmbyWk8QkdoxoQ1UHjGH
         yZgqsUpd+y2yA1ZwWC5SLfNv2gfSr6dFVuFOwXf80KB6fyhoYu7noPpSkli3qltkkfQ1
         ADCbXU9cgaE/uB88X5Jh8qELZ3/gQnjeGFWDSt+aAcggQCmj50DCl+3jr3POWmNBe4eL
         x+0g==
X-Forwarded-Encrypted: i=1; AJvYcCUuDabwNfkwrGp8gk2iNgLKallnVyHl/p0nS3c1Xy3g7QL3ytiA6dmLgce/qwQCz933C9g=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxg7Hg1gECob2O4wnw/HgWjKQZevmS+Slu0u15+4weFbO6e9YeU
	8k10cPDGSU3xQqfII65qEtV7VufyxhfONNCm6gUcxQYDQngmKPxVCRMVIIOD1F04MEQ=
X-Gm-Gg: ASbGncuvANwwYSyecs2U0PpZOPBO5kDK0XkUw+AN6wFhOkdt7KHCBuXj4Aozhga0aR/
	L0SjutQPk/pa3apPcLVulb2pdJAggYCwV/um/H29XZrFl9fZjtkeLh/oaSHqTLncoAlDhkjWw8V
	Y1iDGbDzAKm/B6ky8a1YuZwDVAM9VLSlRSNNhPjhotoaAsGa3yMuDQeGqqhNlsFnWHCHhHY+Tsw
	q0Gihvl2sVNn8Th28PvGpH7xlozOivjxrMi3xigGRHAMq6+GKYJbodG1uZDW9bDbxqkd0n79Z6S
	v6RvnQe4TkNt8dn8Wlhz9/osfXx3sZSC4S2Q/c/2IvUJBSY5BwVk/gcvNbKWpA==
X-Google-Smtp-Source: AGHT+IEepcG+cGqZUnzs59GW5Hq5J8kBkSOuGp9K3NiUmdRqn94I5Ku+rylMpUxJMmWSK5/5CmBghg==
X-Received: by 2002:a05:600c:64c5:b0:43c:f509:2bbf with SMTP id 5b1f17b1804b1-453a79a70ddmr34244375e9.15.1751377138791;
        Tue, 01 Jul 2025 06:38:58 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:fbe8:19b9:f06d:d64c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4538234b30dsm196089495e9.12.2025.07.01.06.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 06:38:58 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  ntb@lists.linux.dev,
  linux-kernel@vger.kernel.org,  Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>
Subject: Re: [PATCH v2 2/2] NTB: epf: Add Renesas rcar support
In-Reply-To: <aFsEOl83Abw9kVAA@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 24 Jun 2025 16:02:02 -0400")
References: <20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com>
	<20250624-ntb-rcar-support-v2-2-8c0e5cf69c4d@baylibre.com>
	<aFsEOl83Abw9kVAA@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Tue, 01 Jul 2025 15:38:57 +0200
Message-ID: <1jcyakdo9a.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 24 Jun 2025 at 16:02, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, Jun 24, 2025 at 06:06:17PM +0200, Jerome Brunet wrote:
>> Add virtual non-transparent bridge support for Renesas rcar platform
>>
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/ntb/hw/epf/ntb_hw_epf.c | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>
>> diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
>> index e8eb3adc6cecd2d52235a3f0b6b5a59ec58f1d73..97c9ed7e4dc27dabd21d3f083cc70d55bb280df8 100644
>> --- a/drivers/ntb/hw/epf/ntb_hw_epf.c
>> +++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
>> @@ -747,6 +747,16 @@ static const enum pci_barno mx8_map[NTB_BAR_NUM] = {
>>  	[BAR_MW4]	= NO_BAR
>>  };
>>
>> +static const enum pci_barno rcar_barno[NTB_BAR_NUM] = {
>
> Nit: suppose neend't NTB_BAR_NUM.

Not strictly no, but it does not hurt.
It's an obvious reminder that of that table is fixed.

I'll keep it that way if you don't mind.

>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
>
>> +	[BAR_CONFIG]	= BAR_0,
>> +	[BAR_PEER_SPAD]	= BAR_0,
>> +	[BAR_DB]	= BAR_4,
>> +	[BAR_MW1]	= BAR_2,
>> +	[BAR_MW2]	= NO_BAR,
>> +	[BAR_MW3]	= NO_BAR,
>> +	[BAR_MW4]	= NO_BAR,
>> +};
>> +
>>  static const struct pci_device_id ntb_epf_pci_tbl[] = {
>>  	{
>>  		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
>> @@ -758,6 +768,11 @@ static const struct pci_device_id ntb_epf_pci_tbl[] = {
>>  		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>>  		.driver_data = (kernel_ulong_t)mx8_map,
>>  	},
>> +	{
>> +		PCI_DEVICE(PCI_VENDOR_ID_RENESAS, 0x0030),
>> +		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
>> +		.driver_data = (kernel_ulong_t)rcar_barno,
>> +	},
>>  	{ },
>>  };
>>
>>
>> --
>> 2.47.2
>>

-- 
Jerome
