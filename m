Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060FE426EDA;
	Tue, 11 Aug 2026 09:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440051; cv=none; b=RVN3A5cxPc0oqfnpMn2EI8qy80+OysyjOEUmX3E76V4UINHmgVZ/SwcAO1B/kQmhgjywKBL/Wk8YJ0dGv1ma9ku29oUl1zzBgztwDEvT45JwrS8f9uWtrRsf2gRH5SNQRrZ+I3dqwzBId2aXyw1fP9K9qUG5OTUuY47/fCN9A2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440051; c=relaxed/simple;
	bh=CCPosKDEcRpiOSZsIW89jDHVrEpSvXgoF7dk6W+U1Kg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gs+yGfI1wWIz5DlZSTyzngd+HJ2QnG83fJf5zz9lg81vxo3p7gBvnkuweRDPCvM66kU9P6ag05RPT4tyu4q1tVkbOqxGwek6OoW6/yD42cbJ0B/4QWT2Ad6GCYYOZjejZH238YBZHqcwEz+V+PSyi9kXxcr9eVD9stfCRSCGqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xbcwz1W0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xbcwz1W0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 991CD1F000E9;
	Tue, 11 Aug 2026 09:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440049;
	bh=JaCsuIqmMtztWGoAbmUG1r3h1ZkYPSuSdLdCmceZM00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Xbcwz1W0Hr2/x40lCW9FclOK4tcZErQSqncmVoTI3XiEQq14KEPBlXmR+CzO4J8fX
	 UlsmrKSBGfc06JifJSQ+zQUtX+6naErMZeitcn0Bwl1vcipulDmG58MpGtqbgqIYd7
	 tN1zLO2hI8pci3fsTUwhSMlGBkBnQfK1KqrSpjf1oTfERkvDQF2bkYPG+AYDdkyg9h
	 XrTrikE8eP8YfSIT4QhMtpGpGjaehHN0ZNrEK9O5xHKbnmkfiQLUBT4QbttDZaHa4I
	 goHHUmzurnbRak4bCmYFWweboE1FNRrJmz1ikrUJPhqArRoak5Bkq9xruRc/qjN2GW
	 H5AHItDvU2Orw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1997939263A6;
	Tue, 11 Aug 2026 09:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] NTB: ntb_netdev: Preserve RX queue depth on
 allocation
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178644000589.433486.12965345737157483071.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 09:20:05 +0000
References: <20260806032537.3526498-1-den@valinux.co.jp>
In-Reply-To: <20260806032537.3526498-1-den@valinux.co.jp>
To: Koichiro Den <den@valinux.co.jp>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, nab@linux-iscsi.org,
 gregkh@linuxfoundation.org, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  6 Aug 2026 12:25:37 +0900 you wrote:
> ntb_netdev_rx_handler() hands the received skb to the network stack
> before allocating its replacement. If the allocation fails, nothing is
> reposted. Every failure therefore takes one buffer out of the RX queue
> while the interface remains up, and enough failures eventually stall
> reception.
> 
> A retry path could refill the queue later, but ntb_netdev has none.
> Allocate the replacement first instead. If that fails, drop the packet
> and repost the same skb. This keeps the queue full and lets packet
> delivery resume as soon as memory is available again.
> 
> [...]

Here is the summary with links:
  - [net] NTB: ntb_netdev: Preserve RX queue depth on allocation failure
    https://git.kernel.org/netdev/net/c/d2121faf133a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


