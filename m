Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA2B14A09C
	for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 19:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729711199; cv=none; b=ahh1LIKBtb/bZr8Xb65DKGp4UdUKZKgjSIuDNZl0eGIdORGPLWhsJzoEKWbMu/A4yHVkZAjsNZ7+V9TXMxfgGKo7g9XNhJGRv0Q7ZNJLPw+p5zCZ2sA9vol905WD3OmzmPO4ljNNZGDLQu079k5I5jMHSgzz3uRe1TdojnrTeEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729711199; c=relaxed/simple;
	bh=jVfaEMDiqxEbMojHP9PBFB3cC/z3et13Xb9WEIyCI8k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0iiwYcG86tECGeVGeyHrvRF9NL13rV6ijCmlE7p7p4DtIDPLYDSMB2YHsdEe8e5kxLV0M4Y5ivekjDqu9F2OBwRzJe3Up8F93zWsn0WG/iM6m6vKN3h5w8MND9zHmu42Kn7tdsXuanLL3k22hekoyLIzeQbZGBkz0fkZ3+WXKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=g3tqKieF; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="g3tqKieF"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a9a0ec0a94fso9480366b.1
        for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 12:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729711195; x=1730315995; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=g3tqKieFc6AGnlqNRqQ1UVGK9dhIboIoIT9mCafSLbW2iVKKEBq0nKZimpAEC5ATRT
         l+ySrrbLTCocMQq9nOTCrlXLuim9tGOyyZQNMko/133V+dPvpNrgvBYuFayvFP4LEMDz
         S1dKgX8rGYMMer7XQypzYrmwLc8MahyLgTEMM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729711195; x=1730315995;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hmLs1fnyFuhch9ym0D8390T3Il2G3hywHxmDwOxNics=;
        b=iVDGwPheKXE3ggPD8UvuaKYk5Xa8oQVby4drWucTzQb5bUwRiGpZqj3hj05wPW+e1q
         fOFuQ9p1fJoMhdLiIDcPK/BfzuApUA8QVWSyXH2E7BaAVsn8J+BAHK+EeP61cnt5c9VU
         UPj8d8mUGx81JGN6Hx5D8IwkC6wnTKss6G8DW5CKu0jtWVPMjz0243ufW10BBDWrOI6k
         L3l9pPfg058DphaGVjoUy5f+U16mTlupDFDzmNqhF9fzX4eAksLpvVI4CLTxvHObu6lN
         9/G4vyCBAe1B3sonVQkONGs+B0SxytIl2CMImMCYt1P/YoYHZd4miFs6UySafUV3cvMR
         fwkQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUwXTFxnScZ8hmnYPHIJSC27TVWOzDhXcD9PmkmbM5fa4+HwrDeT30pS203CICm8NIdYw=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw20GjDwy4DjylUlDDinReL+vUFSBwqLmqlwROSCJOo2Svn7km6
	4jr7DU/9J3Vum+SErJBvEHWcKcHOnJboVl1YNqdXZMYSaaG1aT7NLKlenqDEc3rJ36TqcPHaq7E
	hTwnhiw==
X-Google-Smtp-Source: AGHT+IGQ3KEhpAD7d553O2zdqzL84tuBvjEL8C9LIMhrToqdl9lfxYAsPOFgD12oxL8yjGPZuzrJjg==
X-Received: by 2002:a17:907:8692:b0:a99:e4a2:1cda with SMTP id a640c23a62f3a-a9abf95ca68mr365285766b.56.1729711195559;
        Wed, 23 Oct 2024 12:19:55 -0700 (PDT)
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com. [209.85.218.54])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a91370e91sm510362366b.123.2024.10.23.12.19.54
        for <ntb@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 12:19:55 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a9a6acac4c3so11653566b.0
        for <ntb@lists.linux.dev>; Wed, 23 Oct 2024 12:19:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVxE310alnvYGYvHr4F3lZ44Tu4Pv2FWzeZTkh5nJCdDgub+a1+oQP9BSBvdNSUhdtf/PA=@lists.linux.dev
X-Received: by 2002:a17:907:72d5:b0:a99:f4be:7a6a with SMTP id
 a640c23a62f3a-a9abf91ed4fmr407338266b.47.1729711194415; Wed, 23 Oct 2024
 12:19:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <a08dc31ab773604d8f206ba005dc4c7a@aosc.io> <20241023080935.2945-2-kexybiscuit@aosc.io>
 <124c1b03-24c9-4f19-99a9-6eb2241406c2@mailbox.org> <CAHk-=whNGNVnYHHSXUAsWds_MoZ-iEgRMQMxZZ0z-jY4uHT+Gg@mail.gmail.com>
 <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
In-Reply-To: <e25fb178-39fa-4b75-bdc8-a2ec5a7a1bf6@typeblog.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 23 Oct 2024 12:19:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Message-ID: <CAHk-=wjw0i-95S_3Wgk+rGu0TUs8r1jVyBv0L8qfsz+TJR8XTQ@mail.gmail.com>
Subject: Re: [PATCH] Revert "MAINTAINERS: Remove some entries due to various
 compliance requirements."
To: Peter Cai <peter@typeblog.net>
Cc: Tor Vic <torvic9@mailbox.org>, Kexy Biscuit <kexybiscuit@aosc.io>, jeffbai@aosc.io, 
	gregkh@linuxfoundation.org, wangyuli@uniontech.com, aospan@netup.ru, 
	conor.dooley@microchip.com, ddrokosov@sberdevices.ru, 
	dmaengine@vger.kernel.org, dushistov@mail.ru, fancer.lancer@gmail.com, 
	geert@linux-m68k.org, hoan@os.amperecomputing.com, ink@jurassic.park.msu.ru, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-media@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-spi@vger.kernel.org, manivannan.sadhasivam@linaro.org, 
	mattst88@gmail.com, netdev@vger.kernel.org, nikita@trvn.ru, 
	ntb@lists.linux.dev, patches@lists.linux.dev, richard.henderson@linaro.org, 
	s.shtylyov@omp.ru, serjk@netup.ru, shc_work@mail.ru, 
	tsbogend@alpha.franken.de, v.georgiev@metrotek.ru, 
	wsa+renesas@sang-engineering.com, xeb@mail.ru
Content-Type: text/plain; charset="UTF-8"

On Wed, 23 Oct 2024 at 12:15, Peter Cai <peter@typeblog.net> wrote:
>
> Again -- are you under any sort of NDA not to even refer to a list of
> these countries?

No, but I'm not a lawyer, so I'm not going to go into the details that
I - and other maintainers - were told by lawyers.

I'm also not going to start discussing legal issues with random
internet people who I seriously suspect are paid actors and/or have
been riled up by them.

              Linus
