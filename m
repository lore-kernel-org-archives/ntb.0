Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEEC7460
	for <ntb@lists.linux.dev>; Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 60289C433C7;
	Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694285618;
	bh=cCV8o8RZexR54ir2GzMaNx/SEO2Z+AihK2w/aA88Z7c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=X6V5TGJq3w1GGm4TYcbOl/eVbJArlqv/bD3oHtzK/6uk7y5IXkSoNL0yfekhhwKds
	 euV0vkVyQSC7/N0qKAI7KVyA/0XONwQOpEX4+UiI2DJsv3WNyUySxfo2pughqD/HpT
	 fw+Gs6AGXtyoePxThYDcT5yZLOWRdrtJI7vcLuw/Nok2OPYdjhSS9wAJmfCcyNLxU6
	 FSbK/35w9tmbi/vWPyYrob+wNQBQjp4JYLauBtwpAC+pgrg7aIZmVWaY3JXz3gsasP
	 Z9hdPWsUUlFglkik+vkWdPBu6U50TsKMq6GgFJ1MQ93xKbTgkOqzfJqKrsfg8cWudy
	 lm1tlqisOsrmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5008FE22AFC;
	Sat,  9 Sep 2023 18:53:38 +0000 (UTC)
Subject: Re: [GIT PULL] NTB bug fixes for 6.6
From: pr-tracker-bot@kernel.org
In-Reply-To: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
References: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
X-PR-Tracked-List-Id: <ntb.lists.linux.dev>
X-PR-Tracked-Message-Id: <ZPvOgFe6+hUx9SUC@athena.kudzu.us>
X-PR-Tracked-Remote: https://github.com/jonmason/ntb tags/ntb-6.6
X-PR-Tracked-Commit-Id: 643982232860887fed493144957ea5794b6557d1
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: fa9d4bf5b738a7fa852bbeabfd8889b127ca3193
Message-Id: <169428561831.13340.2444899037468848459.pr-tracker-bot@kernel.org>
Date: Sat, 09 Sep 2023 18:53:38 +0000
To: Jon Mason <jdmason@kudzu.us>
Cc: torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

The pull request you sent on Fri, 8 Sep 2023 21:46:40 -0400:

> https://github.com/jonmason/ntb tags/ntb-6.6

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/fa9d4bf5b738a7fa852bbeabfd8889b127ca3193

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
