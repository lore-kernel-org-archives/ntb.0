Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F8F13D896
	for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 17:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729705570; cv=none; b=g7bvuqvD6jzDlE7ESASg/XBHOkvFNLDKj6hcBDQF5OlUdD2D+X67guwnsv22Yk7ub/FzSMnlvOaS3ltMCUChZTfv90ftVX+AYPPnIN6nvwixt1ToKbxh7TXU9EvEWQ+IDjMN2DmiFe7tZCRVEto5CDtrUbADZfDVS7UwPZiY42I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729705570; c=relaxed/simple;
	bh=HhCRM8LXsD648EezB/Ag71ruZTVUBPWIrjPd9FGl4yA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VR3u+LjUzu+oLwO2Ua3XmihS/USdDGjUAmr3STf/RIino9/1L1A2v05hhr7BdOTNCrIrZYJkMVG0qlWXkABc+GZNZaaEhQnsKwxXas/rLuibtosew39Z6nXMPxq6MLWydpV/b2hgkNmKQrU0ZSrcmm9fUzhhgi9kLVcJGZNJU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=e86hb2GE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="e86hb2GE"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5cb15b84544so32251a12.2
        for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 10:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729705566; x=1730310366; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=e86hb2GEwu4AgLYgP5J6VJ06Dge4nY5eilIaq3nbEx4rvsQLvDF33MJPl1ivyjP5eC
         5JqJL4nmvux/kAEhHDZLDnBqq1c/D9HnDbnidu7ZL+qGljEDyHamzbwik8dHZPjzSZxY
         jr0wTWUfgUnWgaugmPhRrmOfg9bEHg8iay8VY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729705566; x=1730310366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLwni55Q0o3LkpPoGPWHU+nZClL0F1PcEd+W91uMukA=;
        b=lGE742CPrl37rv0jd7iCaaX58A6YcO2zr2IiUkJWh5kCQxAJPH4ftYMcwEpoZz8+qL
         WUGy2+HKetBHzgcxtRG2fEn3DIWrRC52+ND+DuTWeKtAINuWE2JlrKKV4PSNYWr+on8C
         GtZNY4oikR7gff/eVC9bHKoENV+UoHKS/AXb6mk8FAvIgiowVBWHof5jZBVb0sGzXO0D
         yUkHyryrt84agk9rj6maszSQ8wKQ+yvKYupEgjYsNyS0w4S24lQ050rHqX3d4vuDjIy3
         u3sQPTxA+4DMyp24H1YU+DqXD4mjyVW+S2CXs2pnFSL7f21UB42Y1bA3g5Z4dwP+HEDt
         WGrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOwgGWdQRwrwP+3Y9fZsNkjM4Sdcb73sieqvWB9rBTyUts5Czcd+1LhLGdlP7BQK7wtb0=@lists.linux.dev
X-Gm-Message-State: AOJu0YwhGomy/U+q4V0EfNGyYbrOxg3uzLP+TDCr7tEi4ygYKTPrW8+l
	sxlweFnQsGmyV/r4CZzvGrNCYfWsLjYQY6nJyrNZUqwPuqITOto3/usDyue26jQCeG9Lpb6VW8A
	q1eFGmQ==
X-Google-Smtp-Source: AGHT+IG9EN6gWm98rOpLk9Pk3+yKBT2tWCUg53VA1E1CsblV+UQ63ovUwYvnyDHDuYEDFpjMs49+nQ==
X-Received: by 2002:a05:6402:278c:b0:5c9:85dc:5b9f with SMTP id 4fb4d7f45d1cf-5cb8af7f4d9mr2426171a12.2.1729705566172;
        Wed, 23 Oct 2024 10:46:06 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b553sm4714659a12.3.2024.10.23.10.46.04
        for <ntb@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9a0f198d38so983211266b.1
        for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 10:46:04 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVg9RouHNp8aojTW8VFXEsxJYa4E8oziKh012UPgKLTZfxFNS1l0hooo1HD4UH+Ys7/ELM=@lists.linux.dev
X-Received: by 2002:a17:907:94c3:b0:a9a:8042:bbb8 with SMTP id
 a640c23a62f3a-a9abf94d4b2mr369489566b.47.1729705563762; Wed, 23 Oct 2024
 10:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
In-Reply-To: <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 10:45:47 -0700
X-Gmail-Original-Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Message-ID: <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Tor Vic <torvic9@mailbox.org>
Cc: Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, gregkh@linuxfoundation.org, 
	wangyuli@uniontech.com, aospan@netup.ru, conor.dooley@microchip.com, 
	ddrokosov@sberdevices.ru, dmaengine@vger.kernel.org, dushistov@mail.ru, 
	fancer.lancer@gmail.com, geert@linux-m68k.org, hoan@os.amperecomputing.com, 
	ink@jurassic.park.msu.ru, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-fpga@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-hwmon@vger.kernel.org, 
	linux-ide@vger.kernel.org, linux-iio@vger.kernel.org, 
	linux-media@vger.kernel.org, linux-mips@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, linux-spi@vger.kernel.org, 
	manivannan.sadhasivam@linaro.org, mattst88@gmail.com, netdev@vger.kernel.org, 
	nikita@trvn.ru, ntb@lists.linux.dev, patches@lists.linux.dev, 
	richard.henderson@linaro.org, s.shtylyov@omp.ru, serjk@netup.ru, 
	shc_work@mail.ru, tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

Ok, lots of Russian trolls out and about.

It's entirely clear why the change was done, it's not getting
reverted, and using multiple random anonymous accounts to try to
"grass root" it by Russian troll factories isn't going to change
anything.

And FYI for the actual innocent bystanders who aren't troll farm
accounts - the "various compliance requirements" are not just a US
thing.

If you haven't heard of Russian sanctions yet, you should try to read
the news some day.  And by "news", I don't mean Russian
state-sponsored spam.

As to sending me a revert patch - please use whatever mush you call
brains. I'm Finnish. Did you think I'd be *supporting* Russian
aggression? Apparently it's not just lack of real news, it's lack of
history knowledge too.

                      Linus
