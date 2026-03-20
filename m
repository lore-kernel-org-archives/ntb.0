Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBB175A63;
	Fri, 20 Mar 2026 00:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773966628; cv=none; b=N5xvgUU3MmJsYORdmdPEzoET9y5fAwJ0JY7T64+CWAv0QXJZRGxRxbTFmzzvN8tc5OMSs18GDF3u2TpJhHyMITndaQnCjSTeTilJVDWY20NJCl4icpBpz+MMAzRMPEiCmJ41VCYWeC5AxlPcqdRLHKINkrRlYSKWEMOcfFLu0j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773966628; c=relaxed/simple;
	bh=bpwLxbWAaBvQD1DQg+qTwXh/UD8+oR7zVauZRKZ7Lxc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VDzZXqOaKD7hmSM9AYqtSVYPQ7NQGNCZ6LVcLVGWWn22Ma38Wii+Dae3Q3MqtXy6hH+b99LZ85QD+SHXAFBmXmp9DlRW/OlpYaVjhzAtVwpSkK6B3f8eL2aD/mkHUYirl50GomvHQUVpirQf7MCvGApokSoa6jO6hSKjq8BiB68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hOv1pp24; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hOv1pp24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A9BDC2BC9E;
	Fri, 20 Mar 2026 00:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773966628;
	bh=bpwLxbWAaBvQD1DQg+qTwXh/UD8+oR7zVauZRKZ7Lxc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hOv1pp24WPYuQ6PQl6ltBTE0UK97fuY0KVmmCAzalLFBqfYs8tbCdpmiHY5eiEQJy
	 JNx0DAkj0bk92mfwcw9IrZcy9IA1xK/FqnPoVhBR0e0mFt7qFIksOsuKa8YJahDgNT
	 fjhl78foW0Uxiq7sZ8Pp1+iTfeOcMVdEtMnNdug4P4OpnWDsRXnHrqi+IBfN3hfSTz
	 6fBwpdQ8Ugj4mwZZGjXBfexJ4IsOYL11qFZzv7ofodBHJ7JYDkvx6HqmiFgvbJVL95
	 73+onivV04uus48TggQ/kvft6laM1pB+ei7F7m58033Et/nFj16fZPnyl4JHHM4rWz
	 xYXGpCYHNhUgg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FE2D39302F6;
	Fri, 20 Mar 2026 00:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: ntb_netdev: add SPDX tag and remove
 boilerplate
 license text
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177396661903.1861152.6006865353004444253.git-patchwork-notify@kernel.org>
Date: Fri, 20 Mar 2026 00:30:19 +0000
References: <20260318211153.9460-1-rayfraytech@gmail.com>
In-Reply-To: <20260318211153.9460-1-rayfraytech@gmail.com>
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 davem@davemloft.net, kuba@kernel.org, stephen@networkplumber.org,
 ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Mar 2026 22:11:53 +0100 you wrote:
> Add SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license, remove the redundant
> boilerplate license text and contact information, keeping
> only the driver description.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> 
> [...]

Here is the summary with links:
  - [net,v4] net: ntb_netdev: add SPDX tag and remove boilerplate license text
    https://git.kernel.org/netdev/net-next/c/b29580d58be6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


