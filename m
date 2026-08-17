Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAB144239E;
	Mon, 17 Aug 2026 15:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981169; cv=none; b=OXWOQhBBGALUPmzOr7mE+N32UMlIqL14BengXldISrrUJQkG+pFzDH3qvM9nSZrcbA72pektYixUwJj7WR3JUqCxLajwGDQMD6xtoc1VJcWvY4EaCvJ4CzIoGK7MiJtT1CNHoS8dv7VgPHKqHWP+flUs3rYky37D9geiNSGRjq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981169; c=relaxed/simple;
	bh=gLqafw0tl9nU9NvsdDHh9/VHiMafczT3GIkqu6LQ8u0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWthGNhZaih3fw3UaqV6OlOYymAdzW8qEugniJ/AE/30N5MQuFbFupFQDpqbSpAzEkCow35LVnwODxMVuFd3cC5BAHQjFg8CLTmoYoqiDOxllkUmbMzquxGMrrFGOnK8XqoVVpSZhzMnAeJ8fPMe4Yd14+cMLCLWHS/HKLBMDuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PMzh435w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PMzh435w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BA71F000E9;
	Mon, 17 Aug 2026 15:39:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981166;
	bh=JrPy+D0C2SuyXPrDX+RudtY/w8/5axQQxhOy21MWkow=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=PMzh435wcB8A/5GSydimj+HGikTOzE6BE+BryHNs/NLdnY8btaTIMVsiKcE06oDNz
	 5WvU1RLAWC8TrGt+TsZeDeik154MhpZb4b1wadNM0r6fFrIL8nnYFw9M8hQGvsTZdO
	 BS03ksNY1agzzsmhHytrnAK0Rr0iVSgHClYdTK8hlx+pwy5bFLR0mx1GnD8VDQXhJH
	 17P5sAg60B7KBFQ1ShzJrEYpqYHeO8gaJbKg3OQhk2SH6jEO9qmLdkHKwh6MwsRx29
	 pDOMkwkmTDIdSt5wfa6AEpBkvp+sDnghTvTMMmW2wuJB7JFcA2/GtuWaXiLpuUTTDf
	 +ueKCVnzUBeGw==
Date: Mon, 17 Aug 2026 08:39:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 0/4] net: ntb_netdev: Preserve checksum
 offload across NTB
Message-ID: <20260817083925.045c7439@kernel.org>
In-Reply-To: <20260817064916.13278-1-den@valinux.co.jp>
References: <20260817064916.13278-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 15:49:12 +0900 Koichiro Den wrote:
> Subject: [PATCH net-next v2 0/4] net: ntb_netdev: Preserve checksum offload across NTB

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

