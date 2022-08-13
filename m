Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE35A2595
	for <ntb@lists.linux.dev>; Sat, 13 Aug 2022 21:48:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8F1ECC4347C;
	Sat, 13 Aug 2022 21:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1660427286;
	bh=loKMlfzRt4o3HnwPVSZ5in4GmUivDV+CrE9quqJTiQw=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=AhvFk/tq9kQob//WQ8C0K1tScaXir9Nb0G5Q3zltZk7ieAYSR/ISU17fJAu0qAQxk
	 Q5nM8/5nfNnXHgM3frzqbgFr0Zjy8l/iPNcp60lBefNwHw4ahmFTp80SXApwGraBZv
	 w/iligKL+5WGS1DHE6zsIEyF8jBVVWL6pPeSwZHwwuwhjDaC+CUzBfb60iSBjSVkf5
	 76o137Y6gebcfV3+1gw5vvc1TrZczH2+D+xCYW4kkV4r6anGJGcNX0HoGFHMg0IemI
	 8qwOBxX9IFEFeFSP8eMySair3io3dblt+rF9treL6K/HtnRTpl3SeB/UlCxoIDrNWE
	 21U6nBrpp34SA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7D258C43141;
	Sat, 13 Aug 2022 21:48:06 +0000 (UTC)
Subject: Re: [GIT PULL] NTB patches for v5.20
From: pr-tracker-bot@kernel.org
In-Reply-To: <YvcedivdOTR1dsik@athena.kudzu.us>
References: <YvcedivdOTR1dsik@athena.kudzu.us>
X-PR-Tracked-List-Id: <ntb.lists.linux.dev>
X-PR-Tracked-Message-Id: <YvcedivdOTR1dsik@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-5.20
X-PR-Tracked-Commit-Id: e4fe2a2fc423cb51bfd36c14f95f3ca1d279ca92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a976835fdb312590ee5c085567a4e2b06da7ac33
Message-Id: <166042728650.29926.15227519255426738757.pr-tracker-bot@kernel.org>
Date: Sat, 13 Aug 2022 21:48:06 +0000
To: Jon Mason <jdmason@kudzu.us>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 12 Aug 2022 23:45:58 -0400:

> https://github.com/jonmason/ntb tags/ntb-5.20

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a976835fdb312590ee5c085567a4e2b06da7ac33

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
