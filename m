Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3436C377ABB;
	Sat, 22 Aug 2026 20:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787430067; cv=none; b=mT/fiG7yB2Ww6IPHPQqRa9BKJsFUJg04FxSsaIDtZ7llZrCTCGVpDGL89BdjSDIcuCEH2bnJZ6qlWQVzkakXeVFG35NnIr+gLPQAsPwDEQy6H05KhhZeASICibJmIcoZP7QGPxYJk+4mqWDhAP48wIr5eCeGaTR4t6wC2g9eUIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787430067; c=relaxed/simple;
	bh=/9CKKYQCqdY4XiCUMpdNyxh3//jzavoT9DFZ6LVJg1o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XlLHQ7DSu7d4BAPp/lVsfwaarh4o2WEnho9NvXzeJth/O0ozgr0yFjTak2Q30f7ZUrRhwuEeg+TtZjcgwjLVPuCsMrwCXSaxKzMedtY7mhZBOGcTsCMft2rF4x3I2p/KeuJEX5SGLF682RpBgIgTo2HQVyQ/nVfSm2w4KMxk6sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NmugawC5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NmugawC5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915F71F000E9;
	Sat, 22 Aug 2026 20:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787430065;
	bh=4WD0WogA0oMH6MbCYigBK7N/MMl6KmyuJndmemunepQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=NmugawC53XgcrQ7MADx3D7JeVCGGnzrly9P78M9yAdBDNLBr1SgFL2mO6ujMA1m+0
	 5z3jvie03sEWxlfPQFW7Gq6/KxdKBGKwg/xUQF1CG6mLmHtna+h2qddoEQKmfZAfIh
	 tCehlVh5aC+rz+Er5VB7XwiEBqo6dZOrbhbwg8vTePpMQIupz8WkBD+KHOjOAD3+fz
	 V0HPj26u287X1+BJubcl4NXJ0BdFIoQ5RRCPqZvAywgvMfpBuN8VGcD2h5EkEEVrb4
	 kcsE0ddCwSKbvIOBV9kbzDz+1k+PljPN99etzFA88ra7EWsRyzY59VYdNHzghr2tVm
	 rcTYRCoyDCMvw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93AD4380CEF9;
	Sat, 22 Aug 2026 20:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] net: ntb_netdev: Fix RX statistics accounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178743001413.1816901.4726144309192201411.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:20:14 +0000
References: <20260819172539.1450821-1-den@valinux.co.jp>
In-Reply-To: <20260819172539.1450821-1-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>
Cc: kuba@kernel.org, jdmason@kudzu.us, dave.jiang@intel.com,
 allenbh@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org,
 nab@linux-iscsi.org, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 20 Aug 2026 02:25:37 +0900 you wrote:
> Hi,
> 
> This series addresses Jakub's comment on ntb_netdev RX statistics
> accounting:
> https://lore.kernel.org/r/20260818092938.4121c220@kernel.org/
> 
> It fixes the double counting and also the related packet/byte accounting
> on RX refill failure.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net: ntb_netdev: Avoid double-accounting netif_rx() drops
    https://git.kernel.org/netdev/net/c/82e15be2d8b9
  - [net,2/2] net: ntb_netdev: Count packets dropped on RX refill failure
    https://git.kernel.org/netdev/net/c/31ded341c375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


