Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C337233D91
	for <ntb@lists.linux.dev>; Wed,  2 Apr 2025 13:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601480; cv=none; b=dKDxCLpu/TqMUeAJ3Kcc6Me0QbHSv+a0HLIRSnjEKczloitIsE6gVNLC3Bh9R455xpNFqXzsm7udXp+dsL4+mgeRxANFd+djDEZVlzclnV85i0lKxJQQExQ1iwciraJ9OyNmVR/X7X+GtFeer1U4ZArLLazSDttoZEIAz8d4UGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601480; c=relaxed/simple;
	bh=bAFtZQ4n74TeKqgW1UVgdxDBZQaL32TNRNDJ8hM/0w4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bUJmPAjkzxcu3TelJGEGLdfaHfEQbIIL7qNNuaXYICMJUNjWUZ6Fw4enbFJxoFAVL2cTHmr3B7frPrIDC76J4zwesvbd5D/VlYolM+t2oY9fP8WQvim4zaL8nrJ5aFcqmPPyA9QiD7m7+0/h723vN/DQklxfItvY2VBvnLRQIB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=JicM9Zr6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="JicM9Zr6"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43948f77f1aso48292915e9.0
        for <ntb@lists.linux.dev>; Wed, 02 Apr 2025 06:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743601476; x=1744206276; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=M+KPScMUK+AO9N4U8oKua6WTB7J2b7ytXODSOml94Zo=;
        b=JicM9Zr6wZ7bcnIMdbfLLY5U3vNV5zJXHvYgIlxgTfFIZQpQdPQcFwXt51VRQplzt7
         PYYlwTc4ukprlFmubOLbc+gV//LI2fEoEX0dxJ/ITGrG4hMqFGnSnz6G4/6bas0x42S6
         1vNaOteuCVDM912+ejsEJ62tn7aJzt3JJSqNhzcSRpUxosbtpTxW4IUU5cdFbu9IIXHS
         bKBEP/wv3sAgfKkLvMsgnkg1r69adakCxDhPGUgQ5FvC+tUOYD8A/8D8LQPqQA5UqqlP
         nHfxeCcPs8rwgbCDUGTujsQ4VD3tIiyl3n2dncJ9TNZMV4bBcReYf08kNrGq0rDR4ZcT
         QrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743601476; x=1744206276;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+KPScMUK+AO9N4U8oKua6WTB7J2b7ytXODSOml94Zo=;
        b=Q0SoqRa9wWjtOGMeB/7BIr6fEgf9U6yoC1r5gDM9UwV87Kf9PYzG8tt7X0dBOgO2jj
         5AJZJXuWFogCbiiAQuMXYeEIZr/zHSz5P219HBjD1puXJ8hBkncko4uTUq/zu/ffIMXK
         8Tq9GCNcL7mNxCRZiFlO8AZIAjXeRsa3TZiItObGEpG2R1mWI0z5YTYhu1KA8SjjK4Pd
         JO7xN3SNkSToeaVfVnaSDBjRtpAyDAwFV8mr4KsPTOZW3PFf8eleDqmReZzavDLmckif
         orFTS1t827YKXfYSonv7xC62A7mpthNv8OIvr8lxOeyp/6hKiLw7/UKf029R95oxTAPH
         45Wg==
X-Forwarded-Encrypted: i=1; AJvYcCWhS0F4RWI6U0MSd37Op8DSPvXEH7qFZzlNIqsOfnjVSUyZ7T6bG7I+zZ9hAEdgPFjrgh0=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCk/PxqLCScvEyJWxMiCWeBamuumOoTSCkIDwJTPQmwfhxeGEG
	OJ4RECZH2CZDcywObBHyuu25hkQii1GCOoMQitg/HXvi7q22YchDu8LABmSGoZ8=
X-Gm-Gg: ASbGnculpHkQadvpREDK1SA0usyIYK0r0A8fZsePLJ72tlXwsytvfXvpEy56XBjhXpp
	uixmNlYBV6OrecIVjnjEwaHUTLb5G3gWYUTX3KRXzua9ByDE3Osh2PX3spzp66H5ArBvNoGH2py
	4HHCEBoEUT43RbpKO/GD5n1XZrCrkHInFXBYz5bF9txuO6BIQzPQ3Xm3M54y2jJhVfpoiNh5JbE
	lQGlwCZwhbcv3zNey6lpb/I8IWi1uWJugYeWfbe6r42x/XKFSTEo19zcNU2hpnEm+MyChRRm4Ix
	1M7Tur3RRNFoCdVnIbPtViYzpCs35+gXFvEf+D7GM70=
X-Google-Smtp-Source: AGHT+IH2Shn9J0awqYD8blIWstPWQg0xn0kUnMPetVi0klBHYvCu+x/je/Jcfw4sK2CLrMVB6OxOdA==
X-Received: by 2002:a5d:6d84:0:b0:39c:dfa:d41f with SMTP id ffacd0b85a97d-39c120cb81fmr11722261f8f.3.1743601475734;
        Wed, 02 Apr 2025 06:44:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:bcc0:32e:c479:20d5])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-39c0b7a8e0asm16873922f8f.101.2025.04.02.06.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 06:44:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,  Krzysztof
 =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  Kishon Vijay Abraham I
 <kishon@kernel.org>,
  Bjorn Helgaas <bhelgaas@google.com>,  Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Jon Mason <jdmason@kudzu.us>,  Dave Jiang
 <dave.jiang@intel.com>,  Allen Hubbe <allenbh@gmail.com>,  Marek Vasut
 <marek.vasut+renesas@gmail.com>,  Yoshihiro Shimoda
 <yoshihiro.shimoda.uh@renesas.com>,  Yuya Hamamachi
 <yuya.hamamachi.sx@renesas.com>,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org,  ntb@lists.linux.dev
Subject: Re: [PATCH 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
In-Reply-To: <Z+v+Uni7PV9Nlstq@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 1 Apr 2025 10:55:14 -0400")
References: <20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com>
	<20250328-pci-ep-size-alignment-v1-2-ee5b78b15a9a@baylibre.com>
	<Z+qrWleCthbAfDxf@lizhi-Precision-Tower-5810>
	<1jr02ctjoh.fsf@starbuckisacylon.baylibre.com>
	<Z+v+Uni7PV9Nlstq@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 02 Apr 2025 15:44:34 +0200
Message-ID: <1jldsiu18d.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 01 Apr 2025 at 10:55, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, Apr 01, 2025 at 09:39:10AM +0200, Jerome Brunet wrote:
>> On Mon 31 Mar 2025 at 10:48, Frank Li <Frank.li@nxp.com> wrote:
>>
>> > On Fri, Mar 28, 2025 at 03:53:43PM +0100, Jerome Brunet wrote:
>> >> When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
>> >> should not try to handle the size quirks for the underlying BAR, whether it
>> >> is fixed size or alignment. This is already handled by
>> >> pci_epf_alloc_space().
>> >>
>> >> Also, when handling the alignment, this allocate more space than necessary.
>> >> For example, with a spad size of 1024B and a ctrl size of 308B, the space
>> >> necessary is 1332B. If the alignment is 1MB,
>> >> epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
>> >> been more than enough.
>> >>
>> >> Just drop all the handling of the BAR size quirks and let
>> >> pci_epf_alloc_space() handle that.
>> >>
>> >> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> >> ---
>> >>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 24 ++----------------------
>> >>  1 file changed, 2 insertions(+), 22 deletions(-)
>> >>
>> >> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..c20a60fcb99e6e16716dd78ab59ebf7cf074b2a6 100644
>> >> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> >> @@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
>> >>   */
>> >>  static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>> >>  {
>> >> -	size_t align;
>> >>  	enum pci_barno barno;
>> >>  	struct epf_ntb_ctrl *ctrl;
>> >>  	u32 spad_size, ctrl_size;
>> >> -	u64 size;
>> >>  	struct pci_epf *epf = ntb->epf;
>> >>  	struct device *dev = &epf->dev;
>> >>  	u32 spad_count;
>> >> @@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>> >>  								epf->func_no,
>> >>  								epf->vfunc_no);
>> >>  	barno = ntb->epf_ntb_bar[BAR_CONFIG];
>> >> -	size = epc_features->bar[barno].fixed_size;
>> >> -	align = epc_features->align;
>> >> -
>> >> -	if ((!IS_ALIGNED(size, align)))
>> >> -		return -EINVAL;
>> >> -
>> >>  	spad_count = ntb->spad_count;
>> >>
>> >>  	ctrl_size = sizeof(struct epf_ntb_ctrl);
>> >
>> > I think keep ctrl_size at least align to 4 bytes.
>>
>> Sure, makes sense
>>
>> > keep align 2^n is more safe to keep spad area start at align
>> > possition.
>>
>> That's something else. Both region are registers (or the emulation of
>> it) so a 32bits aligned is enough, AFAICT.
>>
>> What purpose would 2^n aligned serve ? If it is safer, what's is the risk
>> exactly ?
>
> After second think, it should be fine if 4 bytes align.
>
> Frank

Ok. Thanks for the feedback.

I think the same type of change should probably be applied to the NTB
endpoint function. It also tries to handle the alignment on its own, but
that's mixed up with msix doorbell things

I don't have the necessary HW to test that function so it would be a bit
risky for me to modify it, but it would be nice for the two endpoint
functions to be somehow aligned, especially since they share the same RC
side driver.

If anyone is able to help on this, that would be greatly appreciated :)

>
>>
>> >
>> > 	ctrl_size = roundup_pow_of_two(sizeof(struct epf_ntb_ctrl));
>> >
>> > Frank
>> >
>> >>  	spad_size = 2 * spad_count * sizeof(u32);
>> >>
>> >> -	if (!align) {
>> >> -		ctrl_size = roundup_pow_of_two(ctrl_size);
>> >> -		spad_size = roundup_pow_of_two(spad_size);
>> >> -	} else {
>> >> -		ctrl_size = ALIGN(ctrl_size, align);
>> >> -		spad_size = ALIGN(spad_size, align);
>> >> -	}
>> >> -
>> >> -	if (!size)
>> >> -		size = ctrl_size + spad_size;
>> >> -	else if (size < ctrl_size + spad_size)
>> >> -		return -EINVAL;
>> >> -
>> >> -	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
>> >> +	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
>> >> +				   barno, epc_features, 0);
>> >>  	if (!base) {
>> >>  		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
>> >>  		return -ENOMEM;
>> >>
>> >> --
>> >> 2.47.2
>> >>
>>
>> --
>> Jerome

-- 
Jerome
