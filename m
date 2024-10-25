Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43C814A4C3
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 16:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729872657; cv=none; b=XElT9mCQOSw8IwYxRr5LHBvEeUdDdDsNk6+TUi3EXfIwof/QN3CouvYGFKIYldSI5/R7w4r8lSwljl4VDyUKGYUbsuxtDCqHCU+gLQCX9obyWciS4klAWyPNrpkAQsqeCYmzl3X1LM2wF96PVrDES/WT1U5kGxEOrTBM+YxLg/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729872657; c=relaxed/simple;
	bh=ZluFTjUHb5NQJslRWKhfGGiwPQCQKR8P7QJv8VCiVAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b6Q2L/7tJlkPlD4W46vAFO05lXahDG8Fu0w2oOzLlMM19FIQ7SOeGllpEjCNpapn/iHuv2v6CajVckQCtBC5WdWh9CaLhFKaLaRvgn+0YiPEUDDjGDtoLvfeG30/qOFhrPyhweWf2OMLPxYxT06oVo/MckfH2KS2NS2EaNubU7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KeGf227g; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KeGf227g"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-539f7606199so2805197e87.0
        for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 09:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729872654; x=1730477454; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZluFTjUHb5NQJslRWKhfGGiwPQCQKR8P7QJv8VCiVAQ=;
        b=KeGf227gDfwuUbsreYIZE9DbaoVOckAVm3L0t/QH48Y+RDlUQkno1LJrRzDEFxNbCs
         njXVJtikquG9YjSruPDZVDgJUAv/r/owrgXrlPRsM3tu9y/9ha6hH+70lPsPmYJopKPz
         h8cx4+O2mI0gIJPsombpIvrmvOQNqU3+JrLzGmtz0jG3Y5kqqZE6JHkdGTvPKFNte7xY
         kZZJEuwFwC7nQ0X3Mfg+5GpoQrRxoYNn5S23V0IrPvRuDCK9k+S2xUrxVVVwryrblNz9
         EOUpgg9olRLJIPUpGvXbm1WPGE2cGvbN1K97DYN/41On/vIFDKuGEQZxusyx28Sw744G
         0Htg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729872654; x=1730477454;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZluFTjUHb5NQJslRWKhfGGiwPQCQKR8P7QJv8VCiVAQ=;
        b=tJkJH3Xcux8YzWLAonWfCwor9PeR2UPGEPwxR98Bn9yC2rVaD/yQwt4InkQX/2QrUM
         dNtdey0CCixQs3MK3aUiFg1Muia1nftQxKXihgn4O0vvltgSFaHw+RRejbJZP9vZbHxu
         SHQajsB/a2NRaQFj//Y8OVRnaZ03/1E0QxC4YZ7BFg8ku7fhEars9lhMYs4UAU2yRYcC
         SXQdoVZ0I/t3/O1qgq5WwVee2ZHDZ+1fQYCRKGPIpXFzESpOfIlB4ZQ9PspS5N2yH0kw
         NAeVK8OmkdEnQOnE0moDEU7V0APcLw3Xi6AYZhuCzESme5b9gm2KAjFymyYxWOkSGJxt
         z/Lw==
X-Forwarded-Encrypted: i=1; AJvYcCX4Q2SCuGJuGANZsAQnCN0B71tfAS3Z6TLjf0xyfW3dSwRJ9B1u47Mma3TpHoHmprK/gBo=@lists.linux.dev
X-Gm-Message-State: AOJu0Yxleo2teMsoeaZvlSV1bxsIc0aqzDtuf0smuYhZvjES9uRxMdEM
	xgpgnu7oS/7m68tYQ2BOlk0Gmm0TlRg0UBQp/MrVftc2IdnMugYe
X-Google-Smtp-Source: AGHT+IEmCTGCwN6K9pQ3iSetR+mNImL5rR1c3V5LVNYK3uoq3APkW+2SExfNUH0cNfIdopoaOZh13Q==
X-Received: by 2002:a05:6512:ad3:b0:539:f5b3:f87c with SMTP id 2adb3069b0e04-53b1a375bfemr6363948e87.46.1729872653315;
        Fri, 25 Oct 2024 09:10:53 -0700 (PDT)
Received: from localhost.localdomain ([193.106.59.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53b2e10a7efsm228124e87.56.2024.10.25.09.10.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 09:10:52 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: andriy.shevchenko@linux.intel.com
Cc: ajhalaney@gmail.com,
	allenbh@gmail.com,
	andrew@lunn.ch,
	arnd@arndb.de,
	bhelgaas@google.com,
	bp@alien8.de,
	broonie@kernel.org,
	cai.huoqing@linux.dev,
	d.milivojevic@gmail.com,
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
Date: Fri, 25 Oct 2024 19:10:48 +0300
Message-ID: <20241025161048.330741-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <ZxuazYt5GMJWJ8xP@smile.fi.intel.com>
References: <ZxuazYt5GMJWJ8xP@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> P.S. "Don't feed the trolls"

Don't you worry. Our friend here tried to reply to this message, he did so twice in fact with slightly different wording, but it was full of political rage and tu quoque so I assume he fell victim to the spam filter thanks to you special counter-baiting operation so to speak.

That aside, I did a very superficial search and it seems that the original author had already had a pull being rejected on the grounds it was coming straight from his Baikal credentials. It's a real pity that an apparently very able engineer is just playing pretend despite knowing full well why is it so that LF migh not want to be associated with Baikal in any way.
