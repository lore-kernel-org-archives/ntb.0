Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC174189911
	for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729799484; cv=none; b=rUYHrwdWF6bU3Opy5BXoUW2iBz/plf51C8e8lg1xQMwG/JMwbHzhHb2ovLPVrJ0VjM90gbO7s62MyGp072/WnSmybZJpjjkwXuZbj5Mu9bquYcniXnhl474D+684912McDlJupwgnNpUbJK77pHj9rDitLOzKKmZkMKEZ0f4xWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729799484; c=relaxed/simple;
	bh=hDZLP8PRZ/QWIIhqrw8i0QlBmFDEwE7SofCdl0cHI94=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l6hw1Q7M0yjwfme4JBk/M1qbdYt8mLWyRzG5fYW65180go8eXtje05g2xA+xigFHTWLckvxNsX04YYvNl04QE/Je5a1GFmqN+TAlP9X3t8ccqkS8g+j3JhTIl5kmNJYbnoCW048UFsQYZFofWStEokP5h8ALS6XXTk6F9L1sKoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8nRte76; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8nRte76"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2e2ee0a47fdso239782a91.2
        for <ntb@lists.linux.dev>; Thu, 24 Oct 2024 12:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729799482; x=1730404282; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hDZLP8PRZ/QWIIhqrw8i0QlBmFDEwE7SofCdl0cHI94=;
        b=i8nRte76s/q1gqfRtFvm9FMGuTua/KhInMatf5KI92SivCrbz89FhCuf6CIYpgot4f
         YJP4O4M0mh3uV+t+zmK03uhD9tTgpecun0z1lmpLS+N8JogTcYI+moJ80dMtnqUUUs63
         XIr0aqotBF3g91O9f5P7jdfblFP4SrfI8khuO2cKNAGjhkYB1luxw/icVD+HurVGDGbz
         xJ20CXC5JPKD5gHzfe3BCkzSofpV3wUjI1azY1R6k0N1VxpD8eg5hvqhjiXL0lg0Tgux
         okMTSA8Sfn43d3BCpIPmwi+CE2y6H4we90ZY1IhACdieRcitnd8cPkv38UzZV0FYdI3m
         XBRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729799482; x=1730404282;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hDZLP8PRZ/QWIIhqrw8i0QlBmFDEwE7SofCdl0cHI94=;
        b=U53t8H1wyFglnpe0lUS3thtTYX/nGBnBj+qkfY1skzZ+Y6VA4V2/4Km9r/g2DvXDB1
         u2/NiU4cEV3B9gNmdt+/oZS0b5O7Rd4Ji23DTVKr6CHF/Ut3yDKl/5tPF4Hj0y9TKp9+
         yS1S0RU6rvDbl3398hNZaT55mpFrHXDEwsS00NO9t7KtxhqqfA1kvg7qVBptwUYtKZDJ
         TPF8OHbjTXH5TK1e5z2i+y3AyNYG/fNmgD+0poXQJTBa8BrVp5xSDdXbvfIVSKh83zPR
         p8FamkmhYyAZixwI86C5zVOX2Zd8BfkKDcNgacsL24SeXcWbFa6GfAcLyBpSeHE4QosB
         F3OA==
X-Forwarded-Encrypted: i=1; AJvYcCWWj0XTAtRdYjR01YF9J1sekB1tRhz+Lo6yLOkI8KDJqKhxHL0YnvtTROEZprhe6FHUUSg=@lists.linux.dev
X-Gm-Message-State: AOJu0YxgnqYdnd+ZaMOCkwRrrWJTL33Ek+PCM7oqxUTlSD+ZoDvp4mRO
	l9wtR6unGOe4gJ7Punokf01Buks/QIlwTWFcpDJhfhzEzoa1ac90yLoXohmD1nRwC8UKcQ8BjAQ
	0msCbGvxx/DVetCLJkqw2haOfE6E=
X-Google-Smtp-Source: AGHT+IFLn362eXA2alAIz2ois1hme8vmMzAr/A4Q67tgGIjhwo4c/Uwrf7x2Y1gjJusyhIkVGgJ2HbVgUBZrDoJcR7M=
X-Received: by 2002:a17:90b:4a83:b0:2e2:e929:e8d2 with SMTP id
 98e67ed59e1d1-2e76b6c3194mr3396949a91.4.1729799482088; Thu, 24 Oct 2024
 12:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <2m53bmuzemamzc4jzk2bj7tli22ruaaqqe34a2shtdtqrd52hp@alifh66en3rj> <20241024185246.315631-1-elfy.ua@gmail.com>
In-Reply-To: <20241024185246.315631-1-elfy.ua@gmail.com>
From: =?UTF-8?Q?Dragan_Milivojevi=C4=87?= <d.milivojevic@gmail.com>
Date: Thu, 24 Oct 2024 21:51:10 +0200
Message-ID: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
Subject: Re: linux: Goodbye from a Linux community volunteer
To: Oleksiy Protas <elfy.ua@gmail.com>
Cc: fancer.lancer@gmail.com, ajhalaney@gmail.com, allenbh@gmail.com, 
	andrew@lunn.ch, andriy.shevchenko@linux.intel.com, andy@kernel.org, 
	arnd@arndb.de, bhelgaas@google.com, bp@alien8.de, broonie@kernel.org, 
	cai.huoqing@linux.dev, dave.jiang@intel.com, davem@davemloft.net, 
	dlemoal@kernel.org, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	geert@linux-m68k.org, gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru, 
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

> It's quite apalling that this needs to be broken down to adult people.
>
> Take care and consider rethinking your life choices.

Does the same apply for Raytheon, Boeing etc employees?
