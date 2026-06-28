Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA98C3AD510;
	Sun, 28 Jun 2026 14:54:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782658457; cv=none; b=u13ONiyQrSZXzDBF5jNaSHjlZ26GZSwTC5EtWXuLpu33X56hCcKkuRGQcrcKLGcEun+kVXeR9sLlIb0t+KFadtmS/f4/S6/8gNd2vJpEqu96FN/ncCjYMndghmlRsf3QKVMBBUKqhOHQGEV7+ZFBTfS9GA5Hefdy7lUxEfn4RO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782658457; c=relaxed/simple;
	bh=Qj0RYpg9BEPzE7Unyo+UpU2FCwUSIFr+U50wakB1xJE=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=XNDo79FftcVUVEtvA0xcM/Z1vwtzE0CaAHjU4Xk9hb2mY7AfIFMnI+Qd7I4ZBYla9qS8xKFw4ifdoO+plNLXAm1tuUQ+bPY8WvA5+swSqvi/t/wckqYrtzLtpbVjyDsg+70mFLUviBcNpvt75GZT6OHMWG0pTo9nl+FgLYTEadQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVEaZ8Jh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVEaZ8Jh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8761F00A3A;
	Sun, 28 Jun 2026 14:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782658456;
	bh=SiICblDQqEN3XHLZCvq2jK6VnePEYlMJNM0qxFeq3sI=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=AVEaZ8JhHrr1L6YuIPXWAHmCQ47Uy+dZPY+MJR1dqFBWgTZ0K3K2F1fSlejXFs7zl
	 U3KdJxFOVjWONUjYNLZX4fXmLgQ5du168jC4bIHPkRbqZjE0floXrbz7qmf/NFJaOX
	 o3O7r5oWq2jupqzkrc5yH314P3kERHxkB82aVJl8L5Z5w6Iwk9EX31Ci2HKKAcgrL9
	 v+18DzhMtoUPio0ulckpYJJBWDtH6tdFM379BmcFoeeN8jkhDLZj7z6eRwM2EMdi2M
	 p+0FYSc4QXC36vRW13Ac69oxJzXImfi0n4EguNEooY6IOPAVov2tGQrrA4h5+xN23+
	 pOQIZwixxBCBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C873938470;
	Sun, 28 Jun 2026 14:54:02 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 7.2
From: pr-tracker-bot@kernel.org
In-Reply-To: <akEm-BhGQDImHcmQ@athena.kudzu.us>
References: <akEm-BhGQDImHcmQ@athena.kudzu.us>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <akEm-BhGQDImHcmQ@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-7.2
X-PR-Tracked-Commit-Id: d1c3d45f87e89e5c1fa0769a72a48d1ad99106fc
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 0716f9b9338a86dd27796e00ed0fd560c653323a
Message-Id: <178265844130.1649077.16322176888970488677.pr-tracker-bot@kernel.org>
Date: Sun, 28 Jun 2026 14:54:01 +0000
To: Jon Mason <jdmason@kudzu.us>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

The pull request you sent on Sun, 28 Jun 2026 09:51:52 -0400:

> https://github.com/jonmason/ntb tags/ntb-7.2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/0716f9b9338a86dd27796e00ed0fd560c653323a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
