Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B2CA147C91
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799232; cv=none; b=oY5ifSi5mw3wE6P848sGCUceshIBHBZSC9l6qDNFunrb5xCX/PyiYvt6PWKOu/VMKXet8KqfQz/JU3Ig3Odh3VVeDUqmpmalR0KWavgb+6mrUFOeiT29COLYrfhZVoTvTsFgVFKH+iRESBPRUBraTLB5lDkXCxkyzC+sj+b8kds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799232; c=relaxed/simple;
	bh=lIMOl16Oc+gkmljkhXJFmkCvewir3f7Gjx9L1UYJb1g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SJVoo2mzBn3T/OKggFGQXk+tMh0g6cuDoFp1PIlSBPoRJ1JCPvmofhyU+HswAxyyONbzQeIUKvwUA6Z0r6mXe4faAjMwtoe04s3BC8f9I14laupZV5t/58oElSVocOvQ4TTwq5NJuYdAyHHeRvyQLUA0RsiTpb8hlQYIHXlrsp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q8eQ+DUl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q8eQ+DUl"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e5b1aaad96so218504a91.0
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799230; x=1730404030; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lIMOl16Oc+gkmljkhXJFmkCvewir3f7Gjx9L1UYJb1g=;
        b=Q8eQ+DUlROaZLguZjts4IAy96pzXgDmXlbFpZ9qb8de8ymT88eA2b6cR5mnCQOZCHb
         zEXlO1cCeavOR0XsIAkqVDRu37dwE5kS4d5MNhys9t8ziqZQNO1L8Krm9NoFP+PKW0f1
         8KFYbm77n8mQnWmpziLtdfsavENWpeAvicZqgJ23EiEGybE40jQ6IrI48u9yJUVdDVup
         TV2+AXfcTTC1QU6QY8WFWzIt44uaKWXySGoFaJWfJQ1YMgWDnOG0y3CWSMYxQYcSYb/h
         +hY9HQmfRgGpD0s+g1AqhIZq9pTph12J0BDJ2G5otx+Q1qEYGKW7mP8PIciKe4Me+kkV
         xjkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799230; x=1730404030;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lIMOl16Oc+gkmljkhXJFmkCvewir3f7Gjx9L1UYJb1g=;
        b=oQZl452nJzlTm5kGduC8HbdBuErr3s1C5sNqzjYhHjnqklkvvntFkmqvPv7PLHMvQd
         oYTExhKde8npy1EmHDEdlwqnWTNWBh6v+PDWucyhFSGsH1m49beIT4dfAoUCG2ksxXBL
         hfP6vfU++iDidM5WSxQHXIKbSG3XZTWgWjnTPCuSPQ4poNQsIwSwYMvsFqaQygKclPiS
         tE1yF3EOkAo6CBkLrgYnPjUrQr9q2BS+RjQhwpgi9rRsg4gEScMUY2I0rDXmJJfi9n1Y
         DL5FicFhbc+TL+jPvriKHUZD60XKZ5wQWkqqi9noeN4PAA84F1JTtcs6qWfdzXxyPAuq
         vQwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTyiKuJjKmxKWEoVymGnopLBT+vn8TPkn+sOah0PiUKLwEblyLPfCsWZYTDBMK+ukN/oA=@lists.linux.dev
X-Gm-Message-State: AOJu0YzfFHIxHUVHCBZQmRvZRv+evGqASt0C1FDuQYtXmoCbduCa59M8
	3xE8wdFExyCzdh/eqzYSAZnANj/IIxqTmU5PG3uf3fCZ2tVsxs2YCNjp1mQnSbQOk6AXyxq6iE9
	nkHmUWVSMnWbGAp3CJ3h38tBA6Lc=
X-Google-Smtp-Source: AGHT+IGNwTEvTbFWLMloYKQZCr/zKAp0DdNKMjGQfdnRQjfPBj0mdcky5TmmQt/Pc5lbMRaat58vPrZb6iSfoQeDocM=
X-Received: by 2002:a17:90a:474f:b0:2e2:9026:8bee with SMTP id
 98e67ed59e1d1-2e76b84f393mr3469899a91.9.1729799229802; Thu, 24 Oct 2024
 12:47:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com>
 <6beb4070-1946-4387-bd0e-34608a76b19e@typeblog.net> <CALtW_agj1rurb3DRrPd9o2mkfku5fq_M3CEKY5sW+Zz7shKYHA@mail.gmail.com>
 <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
In-Reply-To: <ZxqK75WdFBod0rZ9@smile.fi.intel.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 21:46:58 +0200
Message-ID: <CALtW_ajKAYYwYVGnEArPWz_XaCkEiMFwpoCtzeiO1OLbAk77Sw@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Andy Shevchenko <andy@kernel.org>
Cc: Peter Cai <peter@typeblog.net>, 
	James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, 
	Kory Maincent <kory.maincent@bootlin.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	Paul Burton <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Arnd Bergmann <arnd@arndb.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	Vladimir Oltean <olteanv@gmail.com>, Keguang Zhang <keguang.zhang@gmail.com>, 
	Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"

> Yeah, with my hat of the person whose home town is under (Russian) attack for
> the 10+ years (don't be surprised, please, the war lasts more than a decade
> already) on I am fully understand Linus' arguments about history and being not
> very friendly about Russians.

How about your hat off to the people in the Donbas,
~12K of them that had died from Ukrainian artillery fire,
that were under imminent threat of being overrun by
the Ukrainian forces in February 2022? Are you going
to scream about Russian propaganda when I link
the OSCE reports about a 10 fold increase in attacks
at that same time?

BTW can I be racist towards Germans and Croats since
their ancestors exterminated my kin in their death camps?

>
> As you showed above seems like you also will benefit from digging to the
> history a bit. The nice questions to be answered (but not limited to) are:
> 1) What had happened to Finland in 1939?
> 2) Has Finland territory been changed (occupied by another country) in time?
> 2a) (bonus Q) How many times and by which countries / empires?
> 3) (speaking of WW II) How many Jews were killed by Finland?

Maybe you should look up the Finnish concentration camps
 (they called them work camps), that had death percentages
similar to some of Nazi death camps, where Russians, Roma,
Serbs and plenty of other E.Europeans perished, including children?

The fact that they fought alongside Nazis and that they were allowed
to remain independent (and neutral) after the war is, I hope, common
knowledge.

How TF in this day and age is it considered acceptable to be openly
racist towards some people
because you hold historical grievances from 70 years ago?

And for those of you doubting my words, here is a test: Replace the
statements from various
prominent figures, including USA officials, about Russians and Russia
with Jews and Israel and post
them on your social media accounts. See how fast you will be denounced
as a racist.

To paraphrase Noam Chomsky: Approved racism.
