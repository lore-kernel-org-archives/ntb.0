Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920B03DDAF3;
	Thu, 20 Aug 2026 21:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260262; cv=none; b=QhmBeJVTCMuvliynWeUBqk4tAY+3882MeNekfy3loWQ0hkdj2akqbqA1mtGdJp5zXZAPYjxptSaZWJQ3+N1gdhQkIzarL6nxRzSadWMJI7s/ujhMDBO6sZBSc/qzxya3oe3VGkLRL7phpJpp8pJq93wiYBikXYNOnLn+r2pEblo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260262; c=relaxed/simple;
	bh=1k3XshCbvuRdT990W6KeiR2WJjU5Kulco224n4RUm4I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OVdObrdzfEkCUnRrPRFSVPOoc7GwOpuubBSQPrukbTxklyvJJxp+yx76hQnibVg3ev4X7YTIb5LSlTxPdmdzEv9hVtX5251wdM7O8uefYIzxdaG6eQhzdl/2kRfYhH7KX5G/YPQh8iptcINGfHFUNjbmOZarE3IMv+ViK9Jwxhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8fpfD1g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8fpfD1g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3715F1F000E9;
	Thu, 20 Aug 2026 21:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260261;
	bh=0ARn2AcHVzV+py5rhXP/0XwbF7h7BDw+xextYWTKsHQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N8fpfD1gMCAqTnfX6W5fk4I5TTX21ZMGkGJtqmkuRNb8/VXKE7YAexpLM2Kw++qyc
	 JKx/bNt/ym6Zzj3m1gCYQ7YfmDi7FPHMr60mun6Nmn6wlLOHBIUBi9JM+bq4lJsu0t
	 v16QO9s4pk1pyr07wu+vPWsyXQS7C6jRLdMA794gUPfSnfmoIwUMXXUs2wtW+QVhBX
	 Hfc1rLIe+6k3EIzr8iy2trt2rgT6JE3vwETdfEHcBXrgc8oA28SzkyqXc0/lpg82Xz
	 KSapNIHPQILlVfdvPE9cQRqZgqcNLJH2FjCd2b79kp+bQ00zSo705UMGG47FeXvD+K
	 lDXDFXWRvgLeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93BF63924468;
	Thu, 20 Aug 2026 21:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] net: ntb_netdev: Fix TX completion and error
 handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178726021114.486152.12111105007357162569.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 21:10:11 +0000
References: <20260817053519.4135287-1-den@valinux.co.jp>
In-Reply-To: <20260817053519.4135287-1-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ntb@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 14:35:15 +0900 you wrote:
> Hi,
> 
> This small series fixes several TX buffer ownership and queue handling
> bugs in ntb_netdev and ntb_transport.
> 
> Patch 4 first appeared in my "NTB: Add direct TX/RX using PCI endpoint
> DMA" series. Sashiko later reported the same pre-existing leak while
> reviewing another series, so I moved the fix here. See:
> https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
> 
> [...]

Here is the summary with links:
  - [net,1/4] NTB: ntb_transport: Recycle TX entries before client callbacks
    https://git.kernel.org/netdev/net/c/256496397287
  - [net,2/4] net: ntb_netdev: Fix TX busy and drop handling
    https://git.kernel.org/netdev/net/c/8aaa47351db0
  - [net,3/4] NTB: ntb_transport: Fail TX enqueue when the QP link is down
    https://git.kernel.org/netdev/net/c/873ce713fef5
  - [net,4/4] NTB: ntb_transport: Reject oversized TX buffers
    https://git.kernel.org/netdev/net/c/a4f2387db6f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


