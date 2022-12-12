Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B746D2F58
	for <ntb@lists.linux.dev>; Mon, 12 Dec 2022 21:00:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69CA3C4339B;
	Mon, 12 Dec 2022 21:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670878816;
	bh=YRd0tagvi9BC26uw6x2m0UsaWZT0o6bEr0lMaqUgtfM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J3weV9Tbfg3+i0T2i/gD9bP7ZSz+UFtFLtcatrB20cYkH6NHR0QbcKhkk96zLmD36
	 k5USjBYx+M2WnEMYVyOYbjkmBQWPgXS0GMEXiLywW2css6MdySWlhqAkYsiPxSzL5s
	 MP86Jjzv22falC87oJ6AUdy71Z7k3ZhgDRsGqYvruiy9rX1DKYEZH9ymnLgUQAgdpK
	 E27+3tnWHPFJ9R8KcT+ZHkulF6K/7781OXVeEP6JXfLWRw/eVpv5VR8aTFscHO274i
	 DPxTWD5bsDSyc2JwF6I79ywKoD9/b/+7enP4TruL8O/F1hssNEzosCfIRVKu4YHjgl
	 xWJlZgS7mkvtA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 563CCC41606;
	Mon, 12 Dec 2022 21:00:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] ntb_netdev: Use dev_kfree_skb_any() in interrupt context
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <167087881634.21711.12961648575460625809.git-patchwork-notify@kernel.org>
Date: Mon, 12 Dec 2022 21:00:16 +0000
References: <20221209000659.8318-1-epilmore@gigaio.com>
In-Reply-To: <20221209000659.8318-1-epilmore@gigaio.com>
To: Eric Pilmore (GigaIO) <epilmore@gigaio.com>
Cc: netdev@vger.kernel.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, allenbh@gmail.com,
 dave.jiang@intel.com, jdmason@kudzu.us

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  8 Dec 2022 16:06:59 -0800 you wrote:
> From: Eric Pilmore <epilmore@gigaio.com>
> 
> TX/RX callback handlers (ntb_netdev_tx_handler(),
> ntb_netdev_rx_handler()) can be called in interrupt
> context via the DMA framework when the respective
> DMA operations have completed. As such, any calls
> by these routines to free skb's, should use the
> interrupt context safe dev_kfree_skb_any() function.
> 
> [...]

Here is the summary with links:
  - [v2] ntb_netdev: Use dev_kfree_skb_any() in interrupt context
    https://git.kernel.org/netdev/net/c/5f7d78b2b12a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


