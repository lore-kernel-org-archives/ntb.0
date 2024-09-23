Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746A71494A3;
	Mon, 23 Sep 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727130878; cv=none; b=BF+0tswhEuLCkmWS0NOJmtnQ1pZzgM3BcEqiQagEfrRy19Pb8iBOH2fMWhwLd+EbMQLthRMqQh8bF9WCA1mEhLLRxJZ2j/pjn7nI7E/l/TdGt2K2fFd9ayXyq4ix4Wg962nQUTnO7xt5woPRqdUtI+Jeo0Q9zwgqij0btVXXUxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727130878; c=relaxed/simple;
	bh=mNl9ZW/8x/9Bmdu0puULKIllYIXv6qMujAu2N1qxPmc=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=aEZETVe5fJdLNzpmOrR35klsyd8OFNtjnLElb9u38eAJ+boJ/YkuHaEKsQChc10W5h6NnWlyTkLsuFoe1tZ1buALSd/vk6UBWJJq0RphsQ7+e8r7I4yUzqZQ9wMq89e19sKcGK3BjhL09imvYZAq4pw3j9Gb4ruZmaugqbxCOZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EXFeWsO0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EXFeWsO0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56861C4CEC4;
	Mon, 23 Sep 2024 22:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727130878;
	bh=mNl9ZW/8x/9Bmdu0puULKIllYIXv6qMujAu2N1qxPmc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EXFeWsO0qADEl3IkmOdBq/OtLBeEVXUx3qWSn2qILrsl2XAvZ+6FC0/9NMLH3KT6Q
	 hVVfw0F/7z3uc+a4nmm1rxPVhQPzhDu8bxxdgMNEzMXLxUCcDXa/8LgGJ9+kpHfVqE
	 h8ETikoSijt6g6AcX42uP6GdNmfXRpwm/p0pGIWF9odUAZBRaAaS5wtidbG1b7Ssxe
	 LZXFgUlBGA0FmCHvE++ifCOPtFylK7XZ9bV2/CwKAvSt5eWNzh0XC61AC2dnF4Xdly
	 m/G2XRB7MtD1I9ytYADGfrK3LztDkKYLbIuPnxu+HFNRSF1Dhek7wN6vuhpc/b+GCl
	 ov93jUaUUcBPA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E3B643809A8F;
	Mon, 23 Sep 2024 22:34:41 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for v6.12
From: pr-tracker-bot@kernel.org
In-Reply-To: <Zu9yehc5ZdgUO_Ws@athena.kudzu.us>
References: <Zu9yehc5ZdgUO_Ws@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Zu9yehc5ZdgUO_Ws@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-6.12
X-PR-Tracked-Commit-Id: 061a785a114f159e990ea8ed8d1b7dca4b41120f
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5f153b63302af24e7f807b0208f380f5c8654df4
Message-Id: <172713088085.3509221.7076363341498174269.pr-tracker-bot@kernel.org>
Date: Mon, 23 Sep 2024 22:34:40 +0000
To: Jon Mason <jdmason@kudzu.us>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

The pull request you sent on Sat, 21 Sep 2024 21:27:22 -0400:

> https://github.com/jonmason/ntb tags/ntb-6.12

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5f153b63302af24e7f807b0208f380f5c8654df4

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
