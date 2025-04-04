Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BDA1CD3F;
	Fri,  4 Apr 2025 21:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743802700; cv=none; b=M5YjglKWW2h/ZXwUTr83clPQOZusGfIUqUiIJi2vqPWs+1KxuaD3F3NtoUEXYUo3ZixgHTZFE/U0RtOdxut8Fyx1Gcw3njjYFvJ65nTMcN1Vm0RGqbziH7DPj/9tMBsjbw3IWgVlvRTr4uTiZfQEghb+r2bQ9ulzCG74ilYGO+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743802700; c=relaxed/simple;
	bh=BhHlmx5+S3oyg/EQAetIuS/lExqoZ8ZUNaBYi7BE6zY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=FI9OWDxwrigMrtDKjrBiWz3PlNVb4HANRLc3iEBicgal1z9lRAc5Jwlu91lENHVn+YwzmVeg2ZcIyZPuRrnuc3hAbPf6lY++c6ENl8X03q6V2Y7NE5gcmcJS8C77tbt4sX6MkVUmoW6pSv/1PAG/FUETKTUW0IBWJZ/cM10LAn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sq8JqX7F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sq8JqX7F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0FEAC4CEDD;
	Fri,  4 Apr 2025 21:38:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743802699;
	bh=BhHlmx5+S3oyg/EQAetIuS/lExqoZ8ZUNaBYi7BE6zY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Sq8JqX7Fyg2jUl1NtO5geHVff/RRNazuuRjyEeSzqev748U+wUEHzQjIvSMubUv2H
	 DhHaStIJ9pbMbsuqJ86LNxPlLN20TBaI2wATxGRGsOQNf5RA47ko9KqVf45CamopWM
	 32RYx0FIEmL4qpSDRGqKwVuGHgs7cnpx3qy7rnjdUwGzdlDUOt/41EsTIZWp2V1bka
	 2qDyYNPhAB7OoEKiBnjeehiBde/QhV1ZR0/XUi6Yuq+949vYnkZ4RUxnMe+d/MYzI8
	 aMF4Lbx2Meg1as2i/ao9O/W5Q2mVqY+5MSOXwjsy9jS97AdE46sWhqpgyL9yBt/VFF
	 g3Wr9bzpJHQ5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 343A03822D19;
	Fri,  4 Apr 2025 21:38:58 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 6.15
From: pr-tracker-bot@kernel.org
In-Reply-To: <Z_A6RauUQ2sczSMr@athena.kudzu.us>
References: <Z_A6RauUQ2sczSMr@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <Z_A6RauUQ2sczSMr@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-6.15
X-PR-Tracked-Commit-Id: bf8a7ce7e4c7267a6f5f2b2023cfc459b330b25e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a52a3c18cdf369a713aca7593332bbb998c71d96
Message-Id: <174380273672.3445149.3554880654461945314.pr-tracker-bot@kernel.org>
Date: Fri, 04 Apr 2025 21:38:56 +0000
To: Jon Mason <jdmason@kudzu.us>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 4 Apr 2025 16:00:05 -0400:

> https://github.com/jonmason/ntb tags/ntb-6.15

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a52a3c18cdf369a713aca7593332bbb998c71d96

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
