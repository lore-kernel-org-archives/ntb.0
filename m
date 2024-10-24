Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5111AB6CC
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729786731; cv=none; b=lrHzq/W0OAB2ETaseZVpwLcd+cUL/5BkTIiHx/oKdb/n7mJw2sYcNvGDP7gy2YXZWLNowd1Sbcz+FEjn4hw0nJTw/7Mdb6IZ5nvVAuyDy6L59j21ISOq94aKv98wtzrcpptALauTQ4s+5ssQ/Bflhk75Bnrk8U9GlE5wZ3Ayky0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729786731; c=relaxed/simple;
	bh=GaKXHgPo31a1TphARebtjbluqPyOSoJy0zOVsaOeRCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mC43ps0JK0tJbQCsRkVVKIO1TZbPxqelKWauTpYc9JZ2wSw3+s/t56IIRSUIZgplGDn0RMFQDJ+5rPmOLsr1A9stdH3fKioduMaI1nJQv5Mx8P3yBeUYLD6eF+y5jc7QgG3bzd2nlPHEZCSWK/1fAWWo8qRW8AG/eVzAqrvbwJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4bToa9/; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4bToa9/"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so165372a91.0
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 09:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729786728; x=1730391528; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GaKXHgPo31a1TphARebtjbluqPyOSoJy0zOVsaOeRCs=;
        b=W4bToa9/oamAzSVNyUO6RL31QkK/JQLsatiIRafr7h3ncKwsHjlCxoADbifF2mU0vn
         q34BELOSf76GC7bofKU11qLWrO3g5AkRYnuUhGqN4+RdbEibguby5l0R+1Yc+x8ND1kv
         kuAyDh003zL5/gaZosp84tiydp2rsNMviKKdzDPQ9pTQhJZjrHj0EGOAPpHSSt53f5cE
         hj5ufdZnSL1RyfPCYyjzafvaLUVavs/FbaxvNXU4BA/3Iqg0/yO392XHGJah9mad3L4s
         CM6co/Jn4yfuEXlLJoZIzy0OJgS6M5POEHNcBA8ye8qiNkMyQ0gdk1qCBTJOdXP8TUtY
         YuGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729786728; x=1730391528;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GaKXHgPo31a1TphARebtjbluqPyOSoJy0zOVsaOeRCs=;
        b=gGmuu+BGZsdH2b06d+CF2zmmWAM0TwXN2q7MnLjlxVo9FFn3SgVKX2PFS8tccVHayh
         8o7xmeBC+vhbsnqRtLFArEu460KvwbiMz4G3z63Fgag3S08V9GoNUj2XWLEA5x5rHAs2
         kquFUIbhQgDoYhiQYf7RRlsgxL65yFw9MpJrFVYJzUTdSVTN3719bjbLtI+xZX1pV9KT
         6E+NXBtdX5AB+x0XrlYGihrDnruWpPuqmlBWOAuM+ei2taVl1v2RprT1qLFOStM2+w5h
         gZbKlAcQV4evk3jJy98nurTdiMUALe2agX1PbU2sxNsMNnlJJgdMtLoIETBDEFpc9MKK
         RHZg==
X-Forwarded-Encrypted: i=1; AJvYcCVZYvlNZvOzuoCe5Hd4Pci4SW7XgmKonMXyQDli42YsRt5GP3S1pV6PG2GYvoLpo4tM6+k=@lists.linux.dev
X-Gm-Message-State: AOJu0YxdaKet3Kj700X7JRW7vqiYjn6YNL58Tv6o4YCb0OC52v+q0XAZ
	Zz3AWjG7aOjfF84OCna+jpt7ARjlqxFoSusRk4cX2ucXvhw6UQW5zXidiecrl6rVVAQmMUCORSe
	UQS8sDYhuhdMis4KWxFdHvnG8cAA=
X-Google-Smtp-Source: AGHT+IGwQoYu8jU0A8Seg0m6K5s4gCJzmA1d6LWFyNxT6v2L0ZL8B5/jlWz644nhMDNM5pjG7/4zlnFaQ4bagHvBeV8=
X-Received: by 2002:a17:90a:6286:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e76b5e039bmr3425664a91.3.1729786728192; Thu, 24 Oct 2024
 09:18:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj>
 <e7d548a7fc835f9f3c9cb2e5ed97dfdfa164813f.camel@HansenPartnership.com> <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
In-Reply-To: <753d203a-a008-4cd3-b053-38b5ce31281b@app.fastmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 18:18:36 +0200
Message-ID: <CALtW_aggEMXB=aiOe3XD2Y3U5qK62q_zxQjyg4k-mKdJsCLo0w@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: James Bottomley <James.Bottomley@hansenpartnership.com>, 
	Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, ntb@lists.linux.dev, 
	Andy Shevchenko <andy@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Kory Maincent <kory.maincent@bootlin.com>, Cai Huoqing <cai.huoqing@linux.dev>, 
	dmaengine@vger.kernel.org, Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org, 
	Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org, 
	"paulburton@kernel.org" <paulburton@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Arnd Bergmann <arnd@arndb.de>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-pci <linux-pci@vger.kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Andrew Lunn <andrew@lunn.ch>, Russell King <linux@armlinux.org.uk>, 
	Vladimir Oltean <olteanv@gmail.com>, Kelvin Cheung <keguang.zhang@gmail.com>, 
	Yanteng Si <siyanteng@loongson.cn>, netdev@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	linux-hwmon@vger.kernel.org, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, 
	Andrew Halaney <ajhalaney@gmail.com>, Nikita Travkin <nikita@trvn.ru>, 
	Ivan Kokshaysky <ink@jurassic.park.msu.ru>, Alexander Shiyan <shc_work@mail.ru>, Dmitry Kozlov <xeb@mail.ru>, 
	Sergey Shtylyov <s.shtylyov@omp.ru>, Evgeniy Dushistov <dushistov@mail.ru>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Sergio Paracuellos <sergio.paracuellos@gmail.com>, 
	Nikita Shubin <nikita.shubin@maquefel.me>, linux-renesas-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> HUAWEI TECHNOLOGIES CO., LTD. Under CMIC-EO13959 sanction program.
>
> Although it's a Non-SDN sanction, it can still be interpreted as
> "subject to an OFAC sanctions program".
>
> How should we handle it?

It has already been "handled" using the same vague justifications
with a cherry on top: some good old American bigotry and supremacy about the
"free world".

https://lore.kernel.org/all/20241024032637.34286-1-quake.wang@gmail.com/
