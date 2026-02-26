Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4545B2C08C4;
	Thu, 26 Feb 2026 03:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772077806; cv=none; b=SFV1dSJCD6AUzcKTfYrS+tf5iIcLtiBe1+KcIZlPWuN2cBIvVTrRAzLvSWNnbHltOCcH2Emfr+0M47IcXuzv2p53KNszL/G1lxs6gayD1YBvRKU4VITIR/0J9LnZj8tCpBAtvEZBMLcUaVhIWHNC3NLcVCGLrRbmqFEFSiLHuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772077806; c=relaxed/simple;
	bh=xxHKk4q36A/mXOTAolHsUTG9EkGS8bqo95HONHTr6K4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gYzXrIvltHa1pN97JGReVW8Ri5+5mL/tr4+AO3ZOTBmDVSw7FLHnHXhxiZGkThFffMbHf75F5w8Z8AP2iKlKym4B+7N6JQoUXzl9fswu5ObFNSo0p2zvlKpoQsP5b3L1w0noh3WaWFk1hwhxJMVUVoPX7bz3faFAG9MdJ+rEwjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeRQCogR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeRQCogR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D01C116C6;
	Thu, 26 Feb 2026 03:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772077806;
	bh=xxHKk4q36A/mXOTAolHsUTG9EkGS8bqo95HONHTr6K4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jeRQCogRYffBWqKh4OgzlrBJlyTnCOuPaYCdt2oF4B1/Q069D3p3lYcrRyUplT76V
	 D8ybdk6SR6KcSlHu6DbVHqfGkDr9xvNtHEnQIkaksLPqCoPrz8Uukv0cdg+HnjTB9/
	 X3eg1Shf8wh3mhqVic8iyz96sT1dbIn0BMOcAWMs+DzXIsAZwJhIr4FjAXZ4rop5qR
	 wC2oGU7K5RXT2NZf/DRVA53SZOTCqBo7JKGQGdi5oe4YPSBwognG7twhfSUG2qqPq4
	 WIWCDbKmRhEyEG4bJH3V6oeLfYDguYq6A8nIem6ZVl61JNiyK8bmD0UijiKn3hZEBV
	 Y/9YGvVId6oIQ==
Date: Wed, 25 Feb 2026 19:50:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] net: ntb_netdev: Add Multi-queue support
Message-ID: <20260225195004.7e9c8b3a@kernel.org>
In-Reply-To: <20260224152809.1799199-1-den@valinux.co.jp>
References: <20260224152809.1799199-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 25 Feb 2026 00:28:06 +0900 Koichiro Den wrote:
> Usage (example):
>   - modprobe ntb_netdev ntb_num_queues=<N> # Patch 2 takes care of it
>   - ethtool -l <ifname> # Patch 3 takes care of it

Module parameters are not a very user friendly choice for uAPI.
You use ethtool -l for GET, what's the challenge with implementing SET
via ethtool -L?
