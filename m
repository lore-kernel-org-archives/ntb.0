Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45BF2264CA;
	Fri, 11 Sep 2026 00:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789086052; cv=none; b=PGQpH+/JmRxriGdKEtrMrz7R0ZHCiel+tlfQwfDVE9koX6aldqBLRp/irdxyM5orSrMxdji+zE9BHYsZuJ9D23l6oFCOdyadOK8ygTBOjL7/NhU7gWXkIz4EVPoFm92OKTHrFKFjz4ZScn8jYfYBCH6yI2HLPMQkE3bMEajjvO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789086052; c=relaxed/simple;
	bh=fVe5wHeKVo+lXZ7TSwSHKuaV2ucQjtCmE1dtDR+ueIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n3mhusghLvy1AYZHOyRZFl2Ur0WIzv2vC/7pCVYAvrvJd0i7qLynBINlvyAoFwwimg9Ov/oApQ/lCX83gkbkzWEbeA2aCpFefbIHVjieoBq3fQhQYWXEOARm38yHK298tW1XF2pgc/fsI+U5dU3WTwBpqPRu4jebYPGpofmM2sQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SZnJN6wR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SZnJN6wR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 756161F000FF;
	Fri, 11 Sep 2026 00:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789086048;
	bh=GX2T0EKR6xCoEgvcA8PLeQklBZSiTzTr3RFvmA2OzfE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SZnJN6wRftf2+DTFNotAQsT4CLDsZIU7vncgYgglFMGeZIt2/qhaOHqGfCHZ2v2gb
	 mb39TZ00eyiuHh+GZ2T+aKZLIWwoNdyixHPnCwBlaGAR4JhB+ExQb/IhGAz1khBHOw
	 ba5IExradTcx9R46OHzDCrGVLMsDIkwRqTsCE7o1UhgkyZyuhcAzm9uQN/yTyM+Qqp
	 uSZeFCIdLQgsgsWDjiX+d62F3qYH7QfvmSno2EQLIUsBjjW0rH1F5YkjzOvNbwAj0y
	 F2JSkNT/6Sra5qGqrwshc2aQpEZ7R30EgcvHFSzZsReIUdIZOe5WR57TjF4pCi79S+
	 H2KQOUBEVfrEg==
Date: Thu, 10 Sep 2026 17:20:47 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen
 Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 4/4] net: ntb_netdev: Preserve
 CHECKSUM_PARTIAL across NTB
Message-ID: <20260910172047.167225eb@kernel.org>
In-Reply-To: <20260904052134.2970111-5-den@valinux.co.jp>
References: <20260904052134.2970111-1-den@valinux.co.jp>
	<20260904052134.2970111-5-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  4 Sep 2026 14:21:34 +0900 Koichiro Den wrote:
> Calculating L4 checksums can limit ntb_netdev throughput especially on
> embedded systems, where CPU resources are often limited. A trusted PCIe
> fabric can avoid that work.

Would it make more sense to prepend something like a virtio_net_hdr
to the data so you can cheaply express more offloads?
