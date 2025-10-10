Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED4E2BE7AF;
	Fri, 10 Oct 2025 18:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760120794; cv=none; b=fkGzqDoc8F+gEqI0KkOh7iqfQ/P/ugl3gR/W5lT5vZh4Si+OR7XM/mUQCWS7gqdpFlm/+zdf7dAMKarRtdFX/vDtuspPhgia9WCeCxclrciZBDaop9yJRspi27AHHiS+5F11mkYf4kx7STkqbSHxTf08lVd2uP13rYZ+Md4FlfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760120794; c=relaxed/simple;
	bh=dZqBGvLHyVCVNYTbb9Tk7glDD7tQm16LfHBEx9TzXrI=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SUbmEZ+Lx9l2fLWu2fxsWICH4llRsa81LhrmaBIRhAU1LxEFTMJZYmsgGPDLKuol+qRnz/9VimjFPdW/66tIj+B6u1L090mDX16SpL6eoVP4/CEzdXj/TqoikLOq4IPENFnTmGvxksEhy8je6WIExqbRxlRexlgRllMRoEN4W0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p0sqdtlK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0sqdtlK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C823FC4CEF1;
	Fri, 10 Oct 2025 18:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760120792;
	bh=dZqBGvLHyVCVNYTbb9Tk7glDD7tQm16LfHBEx9TzXrI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p0sqdtlKX4O664Ou2gKmqOb7oojsrXTdEGaZH8olgCuMW7FNsfIZYWnhNS+u5Zo6R
	 YyMMBj6hcZ/GMl+AjxIK6EwJ/paivpNdRrBIqCFf/UfwWo3ZzH40ZcqUBmlrKIbsAW
	 4EmNWxZihT/2JsIlzO0Kq+d9x0E0DNKF+ZNXulMXQdSrkbcDY8/JJH8F9BJgFaqPKl
	 7ieA6G/tKbIfFNmdVN+TrN6YyYy7kPLtIrs2Pt6R7wMSOkex9ACfBxFpgRtcTapAfB
	 2ZCyFKLW1L0/kTLGH+HCo8r49v5HLeZwjEU8szvdE8m8wsvGPvipD/LCoK4F4oZNpj
	 /havLMvAS7RtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 714343809A00;
	Fri, 10 Oct 2025 18:26:21 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 6.18
From: pr-tracker-bot@kernel.org
In-Reply-To: <aOj7glAc85SXWodE@athena.kudzu.us>
References: <aOj7glAc85SXWodE@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <aOj7glAc85SXWodE@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-6.18
X-PR-Tracked-Commit-Id: 006824a1cb3bd4001745a2b1cc83c43fad522851
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: dcf50ca7823506fb3f20b8ffd3f928003cddaeed
Message-Id: <176012078001.1074429.13724167832628111344.pr-tracker-bot@kernel.org>
Date: Fri, 10 Oct 2025 18:26:20 +0000
To: Jon Mason <jdmason@kudzu.us>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 10 Oct 2025 08:26:42 -0400:

> https://github.com/jonmason/ntb tags/ntb-6.18

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/dcf50ca7823506fb3f20b8ffd3f928003cddaeed

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
