Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78827369990
	for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 15:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787932286; cv=pass; b=rnpZERsNqI+4Rybi4Q/V7UnVRqRyye3r1kR81uhoVILL5+GnXjR9HTTevcb8377J90V9BCOmiNRhCTviU9RLixdLZpx7a1EKRCU4pBiPEqiq6snk+2khpur4fosl36PPn+vFOZUGQyF50clgDl2vZXUtPVBFNYNPl4h0C19YISE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787932286; c=relaxed/simple;
	bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pYsxwgBsORwZCy4CHJCfXL9u0xEMVJxjEV/9CdbNhbcgdNceJGW/rANXCpQ9F6pS9OzWAVzD13hGKjqIlteISZZQkdnzTgxQBOi9+ME52i20AmtWxpy0zMwt4PA17PTVc3LlLNTPoJzGyf6a2dtRG1xGXcBRyAL7K6DMYpB5h3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YAgPT2or; arc=pass smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YAgPT2or"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-92e50a650a0so91834185a.1
        for <ntb@lists.linux.dev>; Fri, 28 Aug 2026 08:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787932276; cv=none;
        d=google.com; s=arc-20260327;
        b=kc2fedXs1qw3V5vyX/7HaD8+HBppjrrOA5hwA1fRkotzKUCk6/1SUzcNk8U1ApH1XM
         7nAVeMUSvGXy1HDo5KW5aqHA7u6j8QLS74pivtF3vvU9p/VMDfopEa1ufT3b0ZQ3HI2v
         dQ3PgxBtNKq2/6bACXVC2Sc9L/lr5le+20cW1uHYqAT2NSlqUVyBdCtKw19MNpx8NH8e
         epdt35glAQO6X8HvVMkLHi1sl9/NrY8jiREe2djtXt9SJzzy8BZwuUrElA2hARIjrBeX
         iMvGWracz7Y34zUQBI96B8/rOMPpbV8okA/2QRR+MPCf83fGOyItYMwFo7YNn/pp/jbP
         gnUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
        fh=AmVptKmBT9o8D87RelO/xlzIbWpuC9uYSUQ10jMMDes=;
        b=JLGZJfFnyfEd+atgE6Lb5I+fDa9kuaie5qHC3p0FbtpRKBgxY5q2TKg1ikP4NIGpUq
         pREuXDf1eIw1IAcdLuVFgZkQSXdwbk6FkMq/8MRMLvqecboJgxkGNlNQZRlNDz9QiDHa
         e4Vc5wZEuV8J7liJd00vW7wKwm7xPXrIRxsw0++Xo0MyRuKxwn6KI0HhEYgkEn1KcKS3
         wjAyfgA4h4a99rYxYNxKKTHvrDuO8l7IrT1K71tc8Js181tJ85+9+risu6crKm0qqaBw
         lvATa5JilTVQJzEWwcgcdl34PvhRxImj19OlaPB7sXtzCp7HpRBZXBaCelzbz2HbAmTG
         l1pg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787932276; x=1788537076; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
        b=YAgPT2orfCfnayyLgj/ivEoljzMcIqxzrkQ5XvKezn/rD+VlT6na88ZRX8/p62iZz7
         x/JU1F3eKtJc5SEHCgmIX/gusJnA3/sGaFUOG16bu4pwfJe13uFIaNYo3caCI3DpIGf8
         /zT0de6c6gyK1rOj5JXhkhMNVG9ffK+JSYqgcAAWxnREx7aUGOMWMnBc4wMmxglf9y16
         9VcCFpGj1xJl2aZGiE+MzWtu6MYer/aoF1YD41l3Ldh3SjIDVkOC8kLdnYRIGvRSj/Q6
         NZfpRtAXMIqhJe5EN1UrdFRIi4X74V/HcfZ6wCgtlPjcKrtZZ+ttq6B7hR/mZ/Yn7SlQ
         qTCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787932276; x=1788537076;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW5q6ZLsxds0VUrvn8NMSUMzUGvnhoS2GgnvUjYsdVI=;
        b=Y4dsEUd4czVLvxYSxP7VKCihd9jXFk0wBBNGkxsyUu6FHfuL4xUTWRvkk9nPmvr7+W
         7V1fcTIPj8XEqyfjfVNCtL/gb9O7poaXvDUC6tXbTmQ50WUPdhyu0vJ4h/B+0/jJwCel
         iz7ulxu9HVH8kw3MEpLi+J7bWqv6rsk3Q3GXzyLaEmen0s7xlob4bO25rOwmpHaCTFBT
         KbHF6iur5DVpQoL26Nkc1UrQC0b5cmnDsD4wCUvi027IsA/OkhOgajDhgmc2saq+8NYa
         +3cQx1qsnz6Et07olKlZdq6Vr54XDw40PxEOY+EEEmoyJZ6qML8JlMOFrbj/oFNoPLkT
         ACLA==
X-Forwarded-Encrypted: i=1; AHgh+RqvY+SBtjGV/Pr1G3XpDM1ZpllWB7lQSOw/iSTAEKI+2dUmz1qrNvfPzdu4a9u92MwsjzE=@lists.linux.dev
X-Gm-Message-State: AFuF++m0AK/nhLrPp/f+sdJBYFt1eGWRFxaaUjNda9sRfjHL8HpmydTe
	bTXQH1E/UxN1kJEtKvj/kVwtlbMVwTfYdTx9YisjAGalf2AtjVT8dKiftcM44Gxt1dBpBLi4U2f
	YF1WMwvk/v4dV4r1i6WbkzVlkeseXfrfponCLi7ZO
X-Gm-Gg: AR+sD10pSQoJJ9e0SWvOqS81hMrNR20HBzQC8FRRwfgD2jAImnz+Y0MmY4Qvr3CNQKw
	S7EjHlsRUWy4EVorKKLbZawb0AkvyXrIRa0aUuvtj67MhpYaZxbeJwS1udvSorPLLyuT8LFFzPy
	3uxjxmpaanBY03r4XYS3qucmoQfqgKEXooIJDyZkCbHubLWSfDDbVWR8OvYOLW5wIpPYREieLgP
	Q1BeLUnJgl/np/acqT0pQugWbjdMYQuqmyFT7qmASouPZpBaha+e4wFrK9LxiygA1+kVIPZnQdq
	SspDH0wwPUXIm60oF4gQTYNRbEJNf12TxbW9wD9WrwdsJDJGWRK9XXsjjCRf8qNi7iML8v5cE97
	7KGuHR+kBxc0U1uTspLLyzVKBvdHzKyLlh/NHx4Hf/TxtAi+pzDQY0DznjUY=
X-Received: by 2002:a05:620a:4548:b0:936:e71a:db90 with SMTP id
 af79cd13be357-939138aaf3dmr785852285a.29.1787932274998; Fri, 28 Aug 2026
 08:51:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260828154122.2643578-1-den@valinux.co.jp>
In-Reply-To: <20260828154122.2643578-1-den@valinux.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 28 Aug 2026 17:51:03 +0200
X-Gm-Features: AcwNN1UrJtJ6iduqn0ujw97pAkDqT2wuWCSxNAQwH8z3egHVmruiIVqnB7mRr-o
Message-ID: <CANn89iK1U8wzTTQAvGCP8Fff9r4StUB_JFiTdFJZctQUQHE9cg@mail.gmail.com>
Subject: Re: [PATCH net v2] net: ntb_netdev: Fix statistics races
To: Koichiro Den <den@valinux.co.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 5:41=E2=80=AFPM Koichiro Den <den@valinux.co.jp> wr=
ote:
>
> ntb_netdev updates shared net_device stats from per-QP RX and TX
> callbacks. Once multiple queues are enabled, concurrent updates can be
> lost.
>
> Use per-CPU tstats for packet and byte counters and DEV_STATS_INC() for
> less frequent drop and error counters. Callbacks can run synchronously
> in the xmit path or asynchronously from a tasklet or the memcpy kthread.
> Pin TX updates against migration in the kthread path. Use the IRQ-safe
> u64_stats helpers because netpoll can invoke the synchronous path with
> IRQs disabled.
>
> Note that transport callbacks may still complete after
> unregister_netdev(), so tie the tstats lifetime to the client device.
>
> Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi=
-queue")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Eric Dumazet <edumazet@google.com>
