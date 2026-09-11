Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E30A1A682A;
	Fri, 11 Sep 2026 00:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789085938; cv=none; b=lcbLUz8GfC8h9ZxizwMVerI+DpKnckMBDSLSZsblPU+fcHbnbr+2iDRnD8+GhD9iD9EFwwH4cA5IA8q6B1byEqs9caqutnoNVV3VAFIuFukXhwUh3F+f85Oc+jZCrH9WYOVkopnj/X+HL09F1PozALUdyaPElcGLkpIrsJgNvQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789085938; c=relaxed/simple;
	bh=n4+Y57pHoMZxug9xVevg0q4F1+iMOn5yLGrcAUCn6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXCB0cX9fmuah0XqOQSO+rKBnUi+O8cqCkTLllhQieTAXPe9rxG+fQj/nm4Y71LdWPOcPuMPIx/ZQUtArjNoDvOb8ymWNPSbiCQ12WMW/t4vvpaE+WB8lij55HnV2Jt5r/we39p1svVDB/lP/c/4a6VNWStN0bKvuCWwcMFUSo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEFNFHjW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEFNFHjW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C84501F000FF;
	Fri, 11 Sep 2026 00:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789085937;
	bh=+MIc9uIZIBa/ez6VNHWj6uN8xj7Wa1rLAWgxbNI8Pkg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FEFNFHjWBzoeIqzCLYLmE1BrKvFLJVFzhPQwvYxjFrwbzaym9FSysKEl7gI9dbofJ
	 OwJOE4L39S82DfkgJ7tzPc9aEcdjcoGSce/rmK9p17RDt2F00+P7OV0s2pRozCDee2
	 uM5LQL2hQHBnfBlKWiNLoAG64jofnWW0H/eWmM6bNRWxXoY6ISPciZxCSzdIGRYJ2Z
	 9Hdz3/p92rMqBTLDcjNy5rFQGXtc2r+/RQBo8STdkX710XXJJIVbTymXUOm/7rU9fv
	 sAPUM4F49HSxMVVZAVjPJ1PoQvI6ZrNF+nd2PGHummldLvv4OLzmpBxXR4LtVFE97e
	 ywsE0WdsdPYLg==
Date: Thu, 10 Sep 2026 17:18:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/4] NTB: ntb_transport: Add per-payload
 client metadata
Message-ID: <20260910171856.251c90d3@kernel.org>
In-Reply-To: <20260904052134.2970111-4-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
	<20260904052134.2970111-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 14:21:33 +0900 Koichiro Den wrote:
> +/* Reserve the low byte for transport flags. */
> +#define DESC_META_SHIFT		8
> +#define DESC_META_MASK		(~0U << DESC_META_SHIFT)

IMHO the code would be more readable if you defined this with 
one GENMASK and then used FILED_GET() / _PREP() / _MAX() on it
