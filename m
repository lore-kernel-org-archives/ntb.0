Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94B922B64B
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 20:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729800110; cv=none; b=GKLUZsfWgW5n5+OFavw3Y6mFf78h3hb8lHkbjL139ZtbowhK487m06hJY8S94HIdyhAHoLwdPiKp49p8r8inooY1XYhNvxsXBSG+mFV6z0JfsvPxfK367udV+R//hxSUkdTlHZtmKSuy/VKVraKLKQsTFH3C/xDMn+HLej0zJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729800110; c=relaxed/simple;
	bh=eBIPSKxTj4L55q8JXEMDBFoYpoOyhZ0BDvxuOtJ2jWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cv5K4dejdNqNz3+mEJJzV9AQcI09aHZqBgUAJF8FAmWNQvE+sd37LKYCyWNka5csQTj5T0E4PQA8rYB3EAm+RpZus5GgcvYqHZjboe5+HcPonUWQ0t3JWj/bP097LWXDSEobSFZq9Jdlx0aIf6jmmCPXKTzK6uRfCRDiURKojck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dZ5MDmTo; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZ5MDmTo"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2d83f15f3so189186a91.0
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 13:01:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729800108; x=1730404908; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YIraNitrENzrz97ijmN+xBP2tly+1JEciLY9B2SGV94=;
        b=dZ5MDmToT/wCd0Mm7kf4phs8gEKMaxhJsn0oNJYGqixLTyzzCmafNEbiNk08Mni0b+
         ZFEhl2nonmI1az7I/GFvKzNzRSb/pbku6cIRUH50S5HKoE20Yh7a5PzwS6fmucSDTTDI
         yu7s0HuHYwKrwTuWs0mZ8e+JUPPDKiMnDCwylkosxYL1ic65RvBzIHmW+dBjLJeivANL
         ykGe+8T6f8yKch/afeEUx1IZSQsiXkfoDjlybV87WhE5x2K1BPCpKqAvRv3f6EQfMRe1
         Ceo9pz32wuB2aExvmiYO3kZqOVd56Yon1h8ez1ZoOUw+YBUVlqh6tQwHstUeaCc+yif6
         4O9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729800108; x=1730404908;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YIraNitrENzrz97ijmN+xBP2tly+1JEciLY9B2SGV94=;
        b=DAk2nSg0JWn6XnsI1fuBZw9uprQF7RLzrqKvw5mHapG3gTHjEZxQKiwoBvLHGVpZRj
         PjSHBUbufvaqrD8ZdVjWcneZJ9qS2MmfR99jWlNsM+Go5P/anrrhopCLVkL8jETtHB8u
         nVigPs27+KyBExSURvXV3Mq4+fZhRhcEZiNkcUPKF8ZsroQ5qMdkixjNKCEfwG9sK54z
         fcCyWrouvADj+6rjNiUYtVjVmKP1btEMcm3jo0rJOUwbm+RjzHnUEUP8Qo8f/+w/s1bU
         ZsnXmEel/nvW9psCiFODueY/3LEAscC5eh2ttsNxRY3ahZU+Cmjw5jzj8fnigyjWOndS
         8leQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEpYNGQxSQX49t/RYSn3ZuzGf4/4ThUmq4agxxtYr7AxeIgkGkWQ8ig3FQTyiHopMstHU=@lists.linux.dev
X-Gm-Message-State: AOJu0YxCmylxXI1EkK4JG+3+/C4eQ2/kW8NDngrhXAgzso4f8BR4S9mn
	k2t+7mTiIpTHkee0TbAPUxG/+demTX2O8/Ci3osUDfBnPu5idLdKpk7wmT78V3WB+cVbEN0mE5N
	TS5eVMraNRBmeavde1FX8u6Pxbvo=
X-Google-Smtp-Source: AGHT+IEnjgfg/aT6yQAgrTdR83/TW/L0fkHcUWiZIccgc7uZM+RpEvNTF7mOftbuDo5SWQyG+GHyEYQwLQJDF3dcyr8=
X-Received: by 2002:a17:90a:6286:b0:2e2:b20b:59de with SMTP id
 98e67ed59e1d1-2e76b5e039bmr3727816a91.3.1729800108009; Thu, 24 Oct 2024
 13:01:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241024173504.GN3204734@mit.edu> <20241024181917.1119-1-cxwdyx620@gmail.com>
 <20241024193729.GP3204734@mit.edu>
In-Reply-To: <20241024193729.GP3204734@mit.edu>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 22:01:36 +0200
Message-ID: <CALtW_aiicDv89h-m0h4dO-QKjoopittMc5ZvF3wd2dg8Wc_WVA@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Hantong Chen <cxwdyx620@gmail.com>, ajhalaney@gmail.com, allenbh@gmail.com, 
	andrew@lunn.ch, andriy.shevchenko@linux.intel.com, andy@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, broonie@kernel.org, 
	cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net, 
	dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, gregkh@linuxfoundation.org, 
	ink@jurassic.park.msu.ru, james.bottomley@hansenpartnership.com, 
	jdmason@kudzu.us, jiaxun.yang@flygoat.com, keguang.zhang@gmail.com, 
	kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org, 
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, 
	linux-spi@vger.kernel.org, linux@armlinux.org.uk, linux@roeck-us.net, 
	manivannan.sadhasivam@linaro.org, netdev@vger.kernel.org, 
	nikita.shubin@maquefel.me, nikita@trvn.ru, ntb@lists.linux.dev, 
	olteanv@gmail.com, pabeni@redhat.com, paulburton@kernel.org, robh@kernel.org, 
	s.shtylyov@omp.ru, sergio.paracuellos@gmail.com, shc_work@mail.ru, 
	siyanteng@loongson.cn, tsbogend@alpha.franken.de, xeb@mail.ru, 
	yoshihiro.shimoda.uh@renesas.com
Content-Type: text/plain; charset="UTF-8"

> Hypothetically, if someone was a Russian Citizen, and there was a
> Russian Law forbidding them to provide technical assistance to US
> entities, then that person would be obliged to respect that law, and
> not send any patches to US-based open source projects.  Depending on
> how that law was worded, a Russian-based open source project might not
> be allowed to accept changes from US entities, and again, if you were
> a Russian open source project maintainer, you would be obliged to
> follow that law --- or maybe you would be thrown into a Russian jail.
> Whether you are a Russian patriot and are 100% behind the Russian law,
> or think that perhaps it's not the best policy, doesn't really matter;
> you are still obliged to follow the law one way or another.

But they are not, neither is China and I only see blatant approved racism on
the western side.

> In the ideal world, one country would't be invading another conutry,
> and we wouldn't have these sanctions regimes.  But they were not
> *caused* by the decisions of the LF and Linus.  The sanctions regimes
> were enacted by multiple countries' legal governmnts, and now the
> question is how can we best protect the Linux development comunity,
> the operators of web and git servers that are redistributing Linux
> kernel sources. etc.

In an ideal world the USA would not be a hegemon that invades, bombs
and overthrows foreign governments, threatens the security of other nuclear
powers, expands its hostile alliance and sanctions half of the world.

Anyway you fail to understand that is not the topic. The rage comes
from LF actions
and Linus words. All they had to do was to say: Thank you people for
your contribution
but we have no other choice, this is the law.

But they did quite the opposite and Linus showed his true ugly
white western supremacy face for all to see.
That is the cause of the rage.
The real danger is the split in the open source community and the
"software Iron Curtain" erected by the USA.
