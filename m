Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E260213776B;
	Fri, 28 Aug 2026 20:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787950199; cv=none; b=Xl9BNSND8xBTnjlXcjjbxIL7LcHTJuDrGj2VU3koER8/XCXZphZQyd2PyJmFZdsYjC9OHhXmyJeukEBOzr1hVOnfy5Zb5m5/ZcjU/op7aqyJgpk9klYhBDheWJtCH+80jnFxjWYyLDTzVBJZ6liZLK/4kw8th336paBaIscKBj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787950199; c=relaxed/simple;
	bh=PNV9ra2T3+7ZHgwPl5ee8QGlyln39L8l2QJKfaloF0E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=up5B7MGWEAlUepUj4LK4C/+XrCj7SOqNX5XC+c20spZFdODuJWazxa8rtT78LOfVDAWOPTu0P/XCUBEyLZgX+hp4rkHx9C1pz2+f1s2s2qYvQSYgN1OjyfnsUO132bzMRUrUEKrp15froIET4F5o/tYpwMzLL4UZHfEITH3ltPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LBMDHFkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LBMDHFkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086CA1F000E9;
	Fri, 28 Aug 2026 20:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787950198;
	bh=/iJ6o0nlELUFzcGlXlSysf21oUrI5Luh4Z+JPvaZCfk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LBMDHFkJn0SFGT8lx0+ngoVho96iPl9ipq62zXFH30kn/4Uo4n1QrZjNDFbXH8k3j
	 sPiI6qwAZ18tdx7aIwTRoYahPEP7UvRIFHQTSYvxYNto25x+o4k5Vao+1FDvJJj1a4
	 OB245WcdaFAktrdSg5jhcVCasYC8BTctlHXsGYMIJiL94e/Yfa6Dv9uRxZPIyYDn1j
	 rU4g2kii1FAgcVU50yXCXkZxJ4AZXRD1bINl8zvoG0PPHxnI/sG4P95cpFEkbY9svV
	 M+v9AX7La9buploYlcaqkX35rX5RUcYdZJGJ1Vot0MNjr+a9vQZ8KrolMPNkY6PWnN
	 klXJ3RLtQe86A==
Date: Fri, 28 Aug 2026 13:49:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave
 Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ntb_netdev: Fix statistics races
Message-ID: <20260828134957.5b95472b@kernel.org>
In-Reply-To: <20260828154122.2643578-1-den@valinux.co.jp>
References: <20260828154122.2643578-1-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 29 Aug 2026 00:41:22 +0900 Koichiro Den wrote:
> Note that transport callbacks may still complete after
> unregister_netdev(), so tie the tstats lifetime to the client device.

We shouldn't really call devm_netdev_alloc_pcpu_stats() for types
of stats declared by netdev core. We should set the pointer type
like you did in v1.

Could you instead fix the fact that the Tx callback runs on 
an unregistered device? Maybe just wrap the whole body of
ntb_netdev_tx_handler() in RCU and check 

	READ_ONCE(ndev->reg_state) == NETREG_REGISTERED

?
