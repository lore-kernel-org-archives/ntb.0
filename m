Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0B73F105B
	for <ntb@lists.linux.dev>; Sun, 30 Aug 2026 18:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788113649; cv=pass; b=a9pzGj+77XTGpONBuLe3V/9ZwiAJRtyuqGQNLTZAJEVuNcJhPadZ9jSDSCPVzdBgLvYfWCxDyr/29CGN2nCXq10iZeD3Ozt1FAqlFkYPnc+bqzVBWsioQuNDvn65xnmq/lSEpnfkP+3MeGuOONIVhQUmC/l53y+lany9Mfvgp3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788113649; c=relaxed/simple;
	bh=HdzWhpqTNOBl+oorJBrdklXOW54bPXg89ysssBhka1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mmtF2/u+lwLCRlhVSUUimV801tHI6hmyRtndYgQgZMwR9u9TJ+hAXgPVz3/7mIAO8LnzTn5I0lBvd9S7VPk9DYthtBmolQ+W0Rqx19xVzdsfFjEzh58pF23WwNue0r95PFUH67cdgMtdfDhBlGG1ffPW2cOhbkK2HoYzA8wrYc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U+t80gb3; arc=pass smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U+t80gb3"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-936e8bd9caaso223530885a.2
        for <ntb@lists.linux.dev>; Sun, 30 Aug 2026 11:14:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788113647; cv=none;
        d=google.com; s=arc-20260327;
        b=FapkQUkgoYXQ2xBCDnxj3rns2zAhFRFN015m/9vTvzENW1Lcd23W5Drane8Jw2Pnk5
         oL0VdTLWEwNz0rWZ3hysl3vfLW61S64SvmZ3Lqb+Js9kiojmrGL5zGiYHEU6hdjw6n7R
         ibd5rjKVP7XWKMTstseNCwl8/PeFH/atNnOJB5Wk+DWKY1FZhqqq9GmXQbvdwHgwaHL7
         Vff2J5UUbjNp0UNOoZW5djtJe864v1HRNtguz84wK7AFrXfEpSDwznkmnFq8sF0QWIMT
         mjtNES2OOfz7V9v9oFxEBg06yjclwga9qIw4JqEYhMKKkoCxwjgAvWu8l7GpEGhp1RD9
         hH6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sAmNPF/JjH9F41LuxYyTcqwhseN26JSfCU5penkd+pY=;
        fh=fjv0jZ2pSe14i4IqUIRdQ61/Q5lbJ/Kh+YBR2kgSuuQ=;
        b=lBWtzvzXF+ZNizPWfParA0rKQ2bhbAP+QwAMdlIuA8GOqzDm8UafGtPh/BWcjN2k+i
         LQx8YIQxfaVTIbYSfFr7tIWw26/Wxo2t6KSb/CWUXX5Vd7sxeg74JaHUJIHvdASE27Q4
         8Kst7RS74fFcr1mb1QeZVWvhV4ppTsQcBtfYONegWL23RsK+XPkk/qlGoQix1BFn1t7h
         UzWMttyQwUrYwUPkCzbTgrsI88IpfwBWdH59H3tzA8fZgegNTY1Xc7e0WF+hgiIOZhps
         DdE01QVfKlZLoUoL4aCWfrFQFC1FzjUqokoRZgiq3nkfk5ahZgerXHAPLrq3YbPgqpTL
         LVwQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788113647; x=1788718447; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sAmNPF/JjH9F41LuxYyTcqwhseN26JSfCU5penkd+pY=;
        b=U+t80gb3GuEnJTb969kFQ8JyfoqHv5cZov24AqdGuBXXKnQronn4/adw5HLLeq/OGt
         rQDsMA7ZDSmlHZz0Divky+7yq4LKGkU/NXSUb8FXEh6EAtT0x3YAj2pKm2FboXAKyD5K
         Y5JlJmsR+EadL0KigubBDAs1q7F2PcbZ5TzrvkAcECEsGJrMgogYLeVucyq3cM6NzXNQ
         8hzvF5MVJBrlGqglFu81tlihfpEXpruS47/ZnL9gxMwIjnPUwIcyu6D6ebUq2c7V5sFN
         wSOLaEJ6WjwJVa2ntl9mgSu8+jsmu8bMBnCkQNRM9P5n/l2dLzRj82w8Z2RZSWhzD50F
         i3yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788113647; x=1788718447;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sAmNPF/JjH9F41LuxYyTcqwhseN26JSfCU5penkd+pY=;
        b=DObCMxcIeEUakrkwKHRSoKVa9IoUC30hY3dDYTpjJpjHzPqIbrNYVMzqELk8e/NOw4
         bMdtrAeVz3fYL06LQmQRoCkcrCRJAQGGqL+rt+8d81+6SF7QYNzQ9WMM6tzf0Zb0pkmo
         NvmF1YY6PPTgsc0+XjT2f8WjufSeJRO/kTkDiO1J/ahFMl0mIcAlNdOwBP4np9vOGNSv
         oFXDeuj56k6r8Ylw+35mAddQYWdvHgUu0l86XdX0tQyD0x3CSm59Y9fj1j5kKA4aCaqB
         JaijkRRxvebpZYzxcS5VEt1V1Ert8c6cSZHIV3az4H2J9YHDPjgQeQT0LWFKz2MWAMG2
         If9Q==
X-Forwarded-Encrypted: i=1; AHgh+RqQ+44LQXxudgaN/FGObhL1ujmHGuDJ7ebvvars6aVSAVyvG5p0yCiEg5kKhDfl71h4cNw=@lists.linux.dev
X-Gm-Message-State: AFuF++mxhcb4JauE15T5eZd9WIMszkjV7/o31+LfSZH+W5cufh/20H71
	YlFT7kX8ce1BkFGdDmHKD1FKcQlEgpwGmER0bw+fp15ESWjI+qXpn3AoCNwDe5e8W+8Lcy+2Ih9
	nyLtOcfom/9FOidpoHvWFYszmz/COERH80MjVMQiG
X-Gm-Gg: AR+sD11IDxmHIBn8pff5WuBIi0ttsojdX85pwkoMXgb7L7R6gCFfFN1Cf51EGcRMDhC
	4ZSMe3HIV2uA6PrXZ7WYHSARSA5z9NzUd2Bc+eE1xuOCo3lk2xgTopqIOn5XozurRjxUg9rkIHZ
	cS+offGabP9GMWDjSZxUpVB/9i0Zh4epMGghEie838OutETS27TPYbV5dC944XKUTSmv0W/pvtd
	2HGoI2lPKFH/S9FoosPTXyMalp3OHHLQtM/ROxB7T76iaL03hFDI7SsD+xpVoJSKP7cFxTuQ/YS
	VZoL2ifTA1SnTT3r1Xo/Y3wIQwTFIII5dfuGTvlihLFRCGAcG8Ot/jn58Wb2H+lPCagBPcTOalz
	lebTzrYk0JZzRnNmTYIDHNsWcER1jIhXAsfXKEBsnylfkW71tbulyZJ9tbaQ=
X-Received: by 2002:a05:620a:4553:b0:934:970a:beb2 with SMTP id
 af79cd13be357-93913904111mr2296320885a.26.1788113641282; Sun, 30 Aug 2026
 11:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260830151617.3546585-1-den@valinux.co.jp>
In-Reply-To: <20260830151617.3546585-1-den@valinux.co.jp>
From: Eric Dumazet <edumazet@google.com>
Date: Sun, 30 Aug 2026 20:13:49 +0200
X-Gm-Features: AcwNN1V16jcKxWw-kvVgE7bYpkcZejTegRvsFb9cvbrFA76wK31yO_UJFO7y4ic
Message-ID: <CANn89iLWSa-4_Agcpmt61FEV=X7YY42nLzW9OLv8=aWycF01-w@mail.gmail.com>
Subject: Re: [PATCH net v3] net: ntb_netdev: Fix statistics races
To: Koichiro Den <den@valinux.co.jp>
Cc: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, ntb@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:16=E2=80=AFPM Koichiro Den <den@valinux.co.jp> wr=
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
> Let the core manage tstats while keeping transport teardown after
> unregister_netdev(), outside RTNL. RCU lets unregister wait for TX
> completions already updating stats, while later completions only consume
> the skb and skip accounting and queue wake.
>
> Fixes: 24d9e73c7e00 ("net: ntb_netdev: Support ethtool channels for multi=
-queue")
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v3:
>   - Use core-managed tstats and gate TX callback work under RCU (Jakub)
>   - Fix reverse xmas tree ordering overlooked in v2
>
> Changes in v2:
>   - Make packet and byte updates IRQ-safe in netpoll context (Simon, Sash=
iko)
>   - Use device-managed tstats and restore the original teardown order
>
> @Eric, thanks for reviewing v2. v3 moves tstats management back to the
> core and adds RCU protection following Jakub's suggestion, so I did not
> carry your R-b tag. Would appreciate another look when you have cycles.

SGTM, but at some point we probably want to make dev_isalive()
available instead of copy/pasting it.

Reviewed-by: Eric Dumazet <edumazet@google.com>
