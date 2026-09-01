Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54A62F7EF3;
	Tue,  1 Sep 2026 03:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788233464; cv=none; b=UVMQFAJ5WtP8iVQDk7p6rtRap2ruLLK6wX4HU+yqNoRdJbsEz/SaXkPrHByU3GDdqClPAPzoeE+7jiqmNKbFhv5PF20ZkqbRiqi1itVKt45XnPkv7B5JynOH45S1uCxa19QWa/XbDEduePs2X87cXWZTsit15ohi9mWf4KQbLS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788233464; c=relaxed/simple;
	bh=6PKWgRn85c0GODN7zwDMX5YBhDWUg+88APfKgiR5is4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JFtQTP0dYIQIgv7dmLFvca/qsxZW0KSvJNwXTt0jvSpcMzUohrbkA+e0lMxiXiKKZMSMLt2gRzJkLiuZ4ZJBlPSKEv0fnxsBZ4Qv6GC3heWHWhmCSteSEbB3009iEHLc2tSerLYdi4m+8aAlF47U15lhs1hM6ewd60b/2e1dPFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czcJjxKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czcJjxKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D27C1F000E9;
	Tue,  1 Sep 2026 03:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788233463;
	bh=x2oi/fCxUN/JYQPvef49dsCZ0Qe9lM3pDNXCUyjk+ZU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=czcJjxKSE9aIqGmCVIVCEXTuylpy+nuj0st6ML9n0T9MZC1E67b4tQcuw8zUqUGVC
	 cI7tD+7wZZCo068hRv1ERXig8+DMmG8f7RA5iQkbsETzArZfvBiaNkbZSrfC0VOFx6
	 Vwo4PMF4FQvoRATRmVGUDtuA6qTqg162bnjJzEvMG3ZONAPqCqszB5zBK9gcMEqYn8
	 VOJJoHi6s4tuWqzemXDkMZTAFBAkE04PVmv106VUdxUVcyDoXnuLOp33KErapTYZ1t
	 I5XeM4PkV23PKejrhDCmmaGJ/M/gobdVFIdx5VJMXotHfUpuD1nGLlWToV1VTgLkt3
	 MZdvLVRO6LKXQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690D3924A51;
	Tue,  1 Sep 2026 03:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net: ntb_netdev: Fix statistics races
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178823340616.918931.14132728018779970969.git-patchwork-notify@kernel.org>
Date: Tue, 01 Sep 2026 03:30:06 +0000
References: <20260830151617.3546585-1-den@valinux.co.jp>
In-Reply-To: <20260830151617.3546585-1-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>
Cc: kuba@kernel.org, edumazet@google.com, horms@kernel.org, jdmason@kudzu.us,
 dave.jiang@intel.com, allenbh@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 31 Aug 2026 00:16:17 +0900 you wrote:
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
> [...]

Here is the summary with links:
  - [net,v3] net: ntb_netdev: Fix statistics races
    https://git.kernel.org/netdev/net/c/545b63503c69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


