Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C2C23814D
	for <ntb@lists.linux.dev>; Wed,  9 Jul 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049000; cv=none; b=SzfRiESGiqWnWnXXEy5d8vms+dMJRq64vIfOPthhob1SNp8ONSPtC7ysTu5369+n/OsMxmQpwlk9i1ok1pQfmGZGRmdWYFrgrLFejBvNYYpgC4lb2GAaggCoih2imDXA9D5DTHIFBoUd/CwasT4sHR8l7YUQq4w3z0Azv2OZD+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049000; c=relaxed/simple;
	bh=ESjLO9Zhed1cl1ztCJTIT/ZnAfHW/V/nC+V20hNxkao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UCuA47JE0i5mfNXiNWNB9/ptjjA/fvGlhyNAGVLSOTv/I6pJ7KP8UZm4PpNbFZY7b5GPESwoq6ydME5c7GfqQx+udYI0HoVqaUWQGl2/MaC0lGdlmiQ/1add1Qughl68TAlDXg/FlPK7+Mgs42MOEx7bKFsn284mt2M5bxXmmDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=UdNidBfs; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="UdNidBfs"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a57ae5cb17so3322112f8f.0
        for <ntb@lists.linux.dev>; Wed, 09 Jul 2025 01:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752048995; x=1752653795; darn=lists.linux.dev;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqD2PBdEEtL61TcBWPiwuwUSzaM44PpR+jAvOgLtSbk=;
        b=UdNidBfsEIWlVLWqli4+N8k3M/swXnnH+PzXCP18CKieYYrho4iP2FG0EMfJfu6swz
         WHUgGBNKhj/5kXUK/nE8yb6QZQvlT3QSvFu8EkFjKR1frSAvKu7n9xKiR4yxsUeua9WJ
         dZOgM+WwsH/wUnn5Z7iPH+Wv5rBB+W5FeVKcwsBLe3pU76o7h6g+wb0CRCLVL67Fmbu7
         pbBwqCj+sVveMBxJykJCpDy5WidyiARlhzUPea8kOvb08BXnrpFwxu+Yu196gSlFYL1n
         Mf62VafX5is9Y52Ka4FMliWAF1N6ir4XikWyNXiTf0jR2sgMHb/mNiL9MRILGqQek2La
         GZ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752048995; x=1752653795;
        h=mime-version:message-id:date:user-agent:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqD2PBdEEtL61TcBWPiwuwUSzaM44PpR+jAvOgLtSbk=;
        b=rS3ZLjgI+rXD8p8/GRylLbIZQjcgsLoS9Nz0KtaCe6ttGilT4lnnyhJ0q10ChNXb0N
         v7Y8k2DgHFuww4ac69W6P2o6kigkycN7oH/U9woeviav23w8GB4DctTCNrW3Cb1wVjtq
         JaCA1cGaXkJ1XatMnK0HAq6UOiaX5a4uDcAv7yo88/GKWDLBQjfPT751PVLZwDw4kMqE
         8XWdIIthxOFUYTwdGcFfVRfJQLysB2e2O48XzspakKcRKwpR17D8nrqnkonuzl5ed42Y
         ijPozxRDuM5GtHHG+nYytoLV92YY6XGrh3Owiq4Q0GLb9X/aXkIyT2vdXJ13inNAJ4hc
         dUaw==
X-Forwarded-Encrypted: i=1; AJvYcCXezaKGTBZ6cbRyRbKNYcrTjsBRmssU9PbV2XsmrYh01kzKGNdVBl0Iedq5AsEd/pkjK0I=@lists.linux.dev
X-Gm-Message-State: AOJu0YwvatO16eU+uz0kiXueGTRUUUjinV9nLYKR+iEw+s/d09ZRddYG
	VJnlNTMvGrd7QeefpVo1WtrYltMTS//fuDTqq46osMR43Y3pOXnFkjACYxhRMkcR+G4=
X-Gm-Gg: ASbGnctZpFpPoAoL4XwqEpBGrutRBmfq4Oiata+Hl9g+M9uPIFU4QhkQr9Mi8x8odTo
	LPnAFTyGpc5SR8qs3IA6jIgeNIRvcIP/Shxh5GezYmvRLF3WcJWb2pdaq1F1K9J5hz/+Ymkx35w
	C4TPzB6I16eMrKATZ4tn3uxU4F5IhbVXrsjqQmobiZMoXnKMp+J7OfnHizm8Pv/wsmScdR3uc9F
	N4WSg4+/+o+DI7kySauwOtEPkRyb4789dyxrToewBd/tA7WJCdMfF7tfCFjh5MrfRH/S+vMlQJf
	MtON8g82gc2dWOduTWwIw+uu+qXunHPDM0wPEu8Si4+rrbn0wIk08jvaAkU9HA==
X-Google-Smtp-Source: AGHT+IFDWgOyd6TctRhGyDf/BFXl84n44wynt3pzJXN6haPyohv/Z6jjdLJP43b8OIYqGclCOkgE7A==
X-Received: by 2002:a05:6000:2313:b0:3b3:9cb4:43f9 with SMTP id ffacd0b85a97d-3b5e4528344mr1167851f8f.16.1752048995397;
        Wed, 09 Jul 2025 01:16:35 -0700 (PDT)
Received: from localhost ([2a01:e0a:3c5:5fb1:6015:b265:edf6:227e])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b472259842sm15150123f8f.72.2025.07.09.01.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:16:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Jon Mason <jdmason@kudzu.us>,  Dave Jiang <dave.jiang@intel.com>,  Allen
 Hubbe <allenbh@gmail.com>,  Manivannan Sadhasivam <mani@kernel.org>,
  Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,  Kishon
 Vijay Abraham I
 <kishon@kernel.org>,  Bjorn Helgaas <bhelgaas@google.com>,
  ntb@lists.linux.dev,  linux-pci@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
In-Reply-To: <aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810> (Frank Li's message
	of "Tue, 8 Jul 2025 13:52:26 -0400")
References: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
	<aG1a2iy1/2RWd2FX@lizhi-Precision-Tower-5810>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 09 Jul 2025 10:16:34 +0200
Message-ID: <1jh5zlrd7h.fsf@starbuckisacylon.baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Tue 08 Jul 2025 at 13:52, Frank Li <Frank.li@nxp.com> wrote:

> On Tue, Jul 08, 2025 at 04:49:57PM +0200, Jerome Brunet wrote:
>> The id associated with MW2 configfs entry is wrong.
>> Trying to use MW2 will overwrite the existing BAR setup associated with
>> MW1.
>
> :%s/id/ID
>
> need new line between two paragraph.
>

I'll do the v2 to speed things up but the description looks fine as it is.
The comment looks rather like a personal preference.

> Frank
>>
>> Just put the correct id for MW2 to fix the situation
>>
>> Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
>> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
>> ---
>>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
>> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
>> @@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
>>  EPF_NTB_BAR_W(db_bar, BAR_DB)
>>  EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
>>  EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
>> -EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
>> -EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
>> +EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
>> +EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
>>  EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
>>  EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
>>  EPF_NTB_BAR_R(mw4_bar, BAR_MW4)
>>
>> ---
>> base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
>> change-id: 20250708-vntb-mw-fixup-bc30a3e29061
>>
>> Best regards,
>> --
>> Jerome
>>

-- 
Jerome
