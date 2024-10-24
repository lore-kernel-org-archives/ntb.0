Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E18281FF7B6
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729794026; cv=none; b=bztvwwixf0r7LK6cX/JKlAay3amxaDg4YJbTVacl2gx/DsvSxVVvXh8hvh/yEbV6ERNrA1yWcUuGNcocmnIdUg3KgsnVCbvtoROPXhKGXzti59lt6TwIK0K82gm3p28Y+gietKy9/h7pDdb7N4zsJPg6jgdgeE+1e33Wx9uIxeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729794026; c=relaxed/simple;
	bh=wEkB3zq4LCxabrUV4KO/q95T5XBmhZmXXKdUWSfGc14=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GLuE/Oi45QRHDk2B5Ngtewx5T97rkW0Cb3DVhEnqXptdue3NeN0hfG5sE6GFgx8D1Fc0JKg+fdgrZ65YGK77q5tljAog6Y0Nrdvx4+oVx4WsQ1sKyDSBUzzfjtnlkW5eClW68IRRoszoz9o26Fp69VRFsb6YaU+rSoMP3vhr/60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cpda5qcs; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cpda5qcs"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20caea61132so9311365ad.2
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 11:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729794024; x=1730398824; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJRMzi03Xu9OgYRc3CEyzmmOuaUb/klqYsHXiTiyAMg=;
        b=Cpda5qcsbGLZIvYs8WbHllq9UrnMMUiY7mLLSsBClUu60nuzQtvKm1IBHGCaqjnJYO
         eJMrewl7RSrxUKPSZi1Vk3fAhrJtL0rK+p8MsPJIH2CZZx+PRM6OMjJxlRqUT7nuz04d
         TBDXE+IWscJ8PsNmXomVQjc2jKMK/4wcIQUYYKoMLiHzyaCv0mFfxibJUk5NHLcX05Z+
         2GzyYubzSobMl3uWUMeysFPNlOLJiiNoKYXT+2+nwV9HKzFpBfNXaBxjCNlCYVyMB/WH
         AYJy2IU/7k7z1wM3R8nqCNHQS0nv5/NCE5DRw1RI14rQksYUrAoq4rx1O18+fBPbPQIa
         5/sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729794024; x=1730398824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BJRMzi03Xu9OgYRc3CEyzmmOuaUb/klqYsHXiTiyAMg=;
        b=cV+TCdig1IGY9hL4W8LV+d8SL7EPfFzGLAr+PxXZuvO/xO40CifE+iQtXKGECpXztG
         pWhbh6aI14KfMt8ljuiadWU/9BgrQqaJQ3A43xZSCRXjWVZ5+OroE1jV+76Y0/1G2mV3
         VKdwLn1WLD+uueXrTR8Mf0QHzob4h67LniGIm6UDOYr+xn3E1tzEdrqAsrfC8rH1HDQz
         gT3e7pmP+Yiw9rk2q5Ywv0pn7isfccWT4vBKmbfzqCgFMyVP1cytFRF3w89hY8PDGyip
         nUiaa92cmX4GDACOkuumCvq8zNOdAe+NzVDCw3aX6apkyQOmHhxAFq8A8g0VbCrc3tZr
         wf3A==
X-Forwarded-Encrypted: i=1; AJvYcCXB5YR8BE2khttyYcnGNxBIerFF6E7iKrjwo70i4zncP4bIwDBjbokFryN1x5bCeTQ0qvg=@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/jAj5WNee9cvoKfmEq5B7sAdxKRTPaIBLnqbSaygDi1rzFKwx
	DjrtUR1OhMC1sCmP/C0jJT/caZ+Z0miJ812Nu8mm1SRs08S8ADes
X-Google-Smtp-Source: AGHT+IGYKpMxQstbgNZ3LiMaRt+C1kt3vQ5CO9mGWGwaEAcyM8hDC2KY72x67dsHopqzCGRceRlU4w==
X-Received: by 2002:a17:902:f785:b0:1fb:57e7:5bb4 with SMTP id d9443c01a7336-20fa9e9f8c6mr74829205ad.37.1729794024010;
        Thu, 24 Oct 2024 11:20:24 -0700 (PDT)
Received: from localhost.localdomain ([240b:4001:20c:6000::1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd53dsm74915625ad.122.2024.10.24.11.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:20:23 -0700 (PDT)
From: Hantong Chen <cxwdyx620@gmail.com>
To: tytso@mit.edu
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	andriy.shevchenko@linux.intel.com,
	andy@kernel.org,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	cxwdyx620@gmail.com,
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
	james.bottomley@hansenpartnership.com,
	jdmason@kudzu.us,
	jiaxun.yang@flygoat.com,
	keguang.zhang@gmail.com,
	kory.maincent@bootlin.com,
	krzk@kernel.org,
	kuba@kernel.org,
	linux-edac@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux@armlinux.org.uk,
	linux@roeck-us.net,
	manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org,
	nikita.shubin@maquefel.me,
	nikita@trvn.ru,
	ntb@lists.linux.dev,
	olteanv@gmail.com,
	pabeni@redhat.com,
	paulburton@kernel.org,
	robh@kernel.org,
	s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com,
	shc_work@mail.ru,
	siyanteng@loongson.cn,
	tsbogend@alpha.franken.de,
	xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Date: Thu, 24 Oct 2024 18:19:16 +0000
Message-ID: <20241024181917.1119-1-cxwdyx620@gmail.com>
X-Mailer: git-send-email 2.47.0.windows.1
In-Reply-To: <20241024173504.GN3204734@mit.edu>
References: <20241024173504.GN3204734@mit.edu>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

> However, note that China is *not* actively attacking Taiwai=0D
> militarily, while there are Russian missiles and drones, some of which=0D
> may controlled by embedded Linux systems, that are being used against=0D
> Ukraine even as we speak.  Hence, it should not be surprising that the=0D
> rules imposed by the US Government might be different for Huawei=0D
> compared to other sanctioned entities that are directly or indirectly=0D
> controlled by the Russian Military-Industrial complex.=0D
=0D
I wonder some of Ukrainian misiles and drones might also be using=0D
the embedded Linux controllers, and why aren't there any sanctions.=0D
This cannot be used as an excuse.=0D
=0D
What LF and Linus done will inevitably create a climate of fear where=0D
contributors and maintainers from the *Countries of Particular Concern*=0D
feels endangered.=0D
=0D
This is clearly NOT what contributors truly want. People from around the wo=
rld=0D
once firmly believed that Linux was a free and open-source project. However=
, =0D
Greg's commit and Linus' response deeply disappoint them.=0D
=0D
Open-source projects might be international, but the people or organization=
s=0D
controlling them are not. This is the source of concern and disappointment.=
=0D
=0D
> Of course, if China were to militarily attack Taiwan or some other=0D
> country in Asia, circumstances might change at some point in the=0D
> future.  Hopefully Chinese leaders will pursue a path of wisdom and=0D
> those consequences won't come to pass.  Ultimately, though, that's not=0D
> up to any of us on this mail thread.=0D
=0D
Finally, I must point out that Taiwan's status as part of China has never=0D
changed and will never change. The term "military attack" is therefore=0D
**inappropriate**. The move to solve the Taiwan question and achieve=0D
China's reunification is coming soon and before that China must make full=0D
preparation for the upcoming *sanctions* from the U.S. government, includin=
g=0D
handling the issue of high dependence on any international open-source=0D
projects.=0D
