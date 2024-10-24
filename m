Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D173208968
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 18:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729795975; cv=none; b=C91ij7zDK9SCG/sneTtDwokOoOTJLOQ/H9CVc8J/BSmwAtu4mYbg8V0p7zoGm1WjJBQ0sY+ih1aKj7h5HgR/goYBCWZM0+pkpZEb2xOiGmyvjqFI0uyWq/EkGzLYeTrvSVRvecXLVYeyAk4Sm7ioKSwTCcq1QacC4QstCvuuQHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729795975; c=relaxed/simple;
	bh=r74jz5+bt7Kz/XerhmjUfwWYh22pkCkRhE9To457D2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SE63dyp9nxMJev/C+tg9E0Tvq0yaiNEmQVVz+CXUDyEUT/3P416GZYfQLd78A7+vtxAxSGFXHkoyLONGsfNuaTAz4+niU9o6+k3474gF6ygaQddhSNQqIdBbhe6BngJiIq8mo+SHyoT6xf+oZz6hnttck8rIdj1c5hCP/7Lmjf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L2e2IHwm; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2e2IHwm"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539983beb19so1687381e87.3
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 11:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729795971; x=1730400771; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r74jz5+bt7Kz/XerhmjUfwWYh22pkCkRhE9To457D2o=;
        b=L2e2IHwmRsWY8Sdrwuw2hVAaSFbzx85SUUJ7KErEn6qUD0NJEseNFBNY+02AeqeTw5
         Echz9AnlkyKQuV5r92DK0zc5AFeVRUYm0gzOxfz8IVl6Ups9JGpntHv+VgcqaDvoUYa5
         XAdRpS4jXlKyqtOgvtFm1DaGLzH9mCJQKukgQ/A0ecQtBh2/DGgY1VH5uTimJvvnpKMr
         8e96+1kVz4FvImwPe0FJzuDjQkixEHogxfbHyJyFbkVfUpsZee3OJrnpGgOF3L1sv+dE
         O0at5u5LNTV017UsyFv4mgGhZ8sdoD+D+/Z+EZqSoZTFtV/BSObJdnEkuQmSbRPjTahN
         5ttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729795971; x=1730400771;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r74jz5+bt7Kz/XerhmjUfwWYh22pkCkRhE9To457D2o=;
        b=key7EZbldsBinAQ7lK79YPdZV8j9j5HWT1JCpcaN4XG+ptmFBa8IVC+fIOPp5fYeTi
         34q49deHFlc8QgYVLlR5jxMQUO3SA24S0NBqrirf+DA9besHeE6EOZaMRfvlPCiKKYZD
         LlLHHw+q2juSSIx/7HDrdD45ELsF0DrXBlizwNfwjbpTh68PbyJz0KqQ/4AAzllrvxEO
         IhzNcIDiAw6Q1Ae8YYpTduQiOn5lUzLShbBOjP4TmAik79JrnAW/xuOO5zKs8xCQIHu2
         H3CHdbI91kab2NuOKQGZ/lJNkCDhrVJPx3tfzIYvaRgKCDeWyKQcTPuk8LLdhs8du9hY
         9L/A==
X-Forwarded-Encrypted: i=1; AJvYcCUdw3ahySKSP2hOVfDqHrAK8E7Hy0kJdyHsZub0hIPietKDcWrnYWWRpNNVjroklCjc2O8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxYG+Hxc229/tn9817684aCTOa/38+WtlNDF6NA2Ugjfq0latt7
	b4iIGf1/kdsPK+intDvV1Q9twyiaSaJFcEKiPAhRJv2xOH5sWM5r
X-Google-Smtp-Source: AGHT+IHshdOlG57FQEvIzmi2L21uI7l2qUqICJxK2F+XyFQ9DK63Vd7m8czfNiZl0Og14v2rRrY6/A==
X-Received: by 2002:a05:6512:1599:b0:539:f26f:d285 with SMTP id 2adb3069b0e04-53b1a2fb015mr4711374e87.3.1729795970834;
        Thu, 24 Oct 2024 11:52:50 -0700 (PDT)
Received: from localhost.localdomain ([193.106.59.42])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53a223f029bsm1441196e87.119.2024.10.24.11.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2024 11:52:49 -0700 (PDT)
From: Oleksiy Protas <elfy.ua@gmail.com>
To: fancer.lancer@gmail.com
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
Date: Thu, 24 Oct 2024 21:52:46 +0300
Message-ID: <20241024185246.315631-1-elfy.ua@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Dear Serge,

On behalf of a long time Linux user and developer I thank you for your hard work and contributions to the kernel.

> For that reason I have no any (company) lawyer to talk to

I think you should contact the lawyers of Baikal Electronics JSC which are listed as your work place in your GitHub profile and which is under sanctions due to it being directly involved in the ongoing war. Specifically the production of your company makes its way into rockets and drones which I see explode out of my window every night. Given your history contributing Baikal patches in 2023 you do not seemed to have a problem with this fact I suppose.

It's quite apalling that this needs to be broken down to adult people.

Take care and consider rethinking your life choices.

Oleksiy
