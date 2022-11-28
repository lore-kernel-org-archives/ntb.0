Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3652112
	for <ntb@lists.linux.dev>; Mon, 28 Nov 2022 11:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 99383C433D6;
	Mon, 28 Nov 2022 11:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669633831;
	bh=fOjsi0iGI85AQ4DAURLcIdpNX9GY6k9KslooUp1aOuA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A/3PA51qxl7Vjo+uoqx++7r6UEKwlZIVcGlDAY2Zb6iy/3+/ZJrrNNYlcrDev/+ug
	 rztYpsM5uh/Vez7+qLJsL3ujqrYG535qC+3++YpzLwcveauD8iUA5WV7jBrOVtKx2S
	 hBlrZOwnyNtxIch4uiTVWld/BydsFEIEziDW2U+uHjkmT6h/9Rlhuwla3ZOrTdOpZ8
	 5HHlYamqqlZmmfr4j0U3jaOI14v1KzkcgepuWdxbPYk02+oiRAlMMKQUz2qDa5B6xA
	 393fsUlCyuxj/9mLSVQz1ikmJZffWch8ZrfZvrOAtKjUYrn8GeQRX9ipr8zGFdyoQh
	 A+ZTdmiXgfMbA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 783EFE270C8;
	Mon, 28 Nov 2022 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: net_netdev: Fix error handling in
 ntb_netdev_init_module()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <166963383148.22058.3258303081621006754.git-patchwork-notify@kernel.org>
Date: Mon, 28 Nov 2022 11:10:31 +0000
References: <20221124070917.38825-1-yuancan@huawei.com>
In-Reply-To: <20221124070917.38825-1-yuancan@huawei.com>
To: Yuan Can <yuancan@huawei.com>
Cc: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nab@linux-iscsi.org, gregkh@linuxfoundation.org, ntb@lists.linux.dev,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (master)
by David S. Miller <davem@davemloft.net>:

On Thu, 24 Nov 2022 07:09:17 +0000 you wrote:
> The ntb_netdev_init_module() returns the ntb_transport_register_client()
> directly without checking its return value, if
> ntb_transport_register_client() failed, the NTB client device is not
> unregistered.
> 
> Fix by unregister NTB client device when ntb_transport_register_client()
> failed.
> 
> [...]

Here is the summary with links:
  - net: net_netdev: Fix error handling in ntb_netdev_init_module()
    https://git.kernel.org/netdev/net/c/b8f79dccd38e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


