Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6367F18A6DC
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 03:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729825272; cv=none; b=sjCRQLvUz9c9lcWaulysIdw7L+Lw12gUj6fDRqwUAeKbkQApnSYzEcTVDvRIP8h/qx51Gc6JJWfJCjknq6yWHDwRupvY6mvYagblNKALmVEvI2F4MdsQV+hS/GVlU72fDFfxzUQ2WaPLdTrW+g5ec/hGW6HrZR+ILRHSWYrQ9x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729825272; c=relaxed/simple;
	bh=6MTJVFMqnnCJNbM2dONSU/ki5kij5KTFX4y1XsBSR7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEXtMH/7LHLY/4ml85GKi6EQY1OjLTXnSebhoo1LVBYT9vEGsxEbmpuF7hxtZKx7IiR/cCGOVQTLakazUIt3bTBSJk7RTuW4juNQtcsFH2AMVoGPmGkGswBauXR8Pqu3KpOJUoneW2eGla4bl9qH4O6oceCL5WmJqI7aah/YLos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NrFSGo1o; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NrFSGo1o"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c903f5bd0eso2887136a12.3
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 20:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729825269; x=1730430069; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6MTJVFMqnnCJNbM2dONSU/ki5kij5KTFX4y1XsBSR7o=;
        b=NrFSGo1oAd0pMNOUkCSgvTVIjtAr48BuhOMDHiljPE8UheftexXG/xkx4eVEP885lh
         hnCe1poQRbxZpsSJS5N911KXkfUh01DOkOc6OOKNYnb6oCUqHeIfFv2Xvz1eRFwsWc1J
         uDBXLbkgXmWVrux8+HzLi+ucagqxPOtkVG7k5DpJMw22VVd4dtdRYPjsd3I2l8GgozMg
         KNlszTQNgNxopDAXspW9SM0y+DOyN7m3W5epR33NVvaJzEIb3sNjMJFUA1im/SnHVLwc
         sUC+jvvreo/3Mhv4c5IG4ZE7Rf9FL/Y6s6Tuov3nQixb6xpSximA42BDnpeOLAPOSyWL
         CHzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729825269; x=1730430069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6MTJVFMqnnCJNbM2dONSU/ki5kij5KTFX4y1XsBSR7o=;
        b=TOGvcGcdWba3Q1nZwBqsJx0kHR6M77ZAEJbPBQlh0S7Bfs1P466vTi76XG8U4uu7YD
         G5c2SII/m+IrZdsY4868ssm+D5xlQp/Qxw4Yf2tO5whgV1Txbgbyu+qBy8eTpdmf6hRa
         2A16Ydm3RFNmTwPCxSPPth8O3Gr1Qfiko0OwfdqZel1GmXBoJ/0iHo9ghOoFqCf3IyGj
         KzaG7A4TtfhOVj+T3vcyUWgE3QLN/R1EcqqqNVGOuBYr0T7Dr4pvlRCpCzYCh4UiEX08
         ipxmBDlQyw42YcSvuOpe2+FRkh5kZYiecj0Czv/eygyAbZA66ovgu8RuEkuZAJkvxdZR
         doMA==
X-Forwarded-Encrypted: i=1; AJvYcCW3RasNtt2iL3znZmofhyfKAOD0YN4EOxxKmzIcVvGSOsKBQt5rIBNgvTiRGvTdExPl4zs=@lists.linux.dev
X-Gm-Message-State: AOJu0Yx+z0XGTOGQxP/i1y484YbCSi7I721w0aI6o414gWTaKejCcLWg
	q9fwKhOf+WEBBA4F+6rmo6uKJqKv5yGjVjdlNPIHTQ9sDWMm0g4K
X-Google-Smtp-Source: AGHT+IG9lTruoJuiWvD3/I0nGa0uNZQNR6Vtf4xab40cqpRDyyMRJml+6D/43J5oPu7AIVVa2dAxUA==
X-Received: by 2002:a05:6402:84a:b0:5cb:674f:b0a2 with SMTP id 4fb4d7f45d1cf-5cb8b1b1f0amr5688194a12.36.1729825268315;
        Thu, 24 Oct 2024 20:01:08 -0700 (PDT)
Received: from localhost.localdomain ([92.60.187.5])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cbb631b0bcsm121582a12.60.2024.10.24.20.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 20:01:06 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: d.milivojevic@gmail.com
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
	dave.jiang@intel.com,
	davem@davemloft.net,
	dlemoal@kernel.org,
	dmaengine@vger.kernel.org,
	dushistov@mail.ru,
	elfy.ua@gmail.com,
	fancer.lancer@gmail.com,
	geert@linux-m68k.org,
	gregkh@linuxfoundation.org,
	ink@jurassic.park.msu.ru,
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
Date: Fri, 25 Oct 2024 06:01:02 +0300
Message-ID: <20241025030102.319485-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
References: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Brate Dragane,

I was not aware of the fact that either Raytheon or Boeing are directly supplying the Russian invasion. That would be a concerning development indeed.

If you possess any information of that being the case, I urge you to contact GUR anonymously at their official whistleblowing email: gur_official@proton.me

Thank you for your diligence, only together we can stop the war.

Kind regards,
Olekiy
