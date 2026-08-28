Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 853581DF748;
	Fri, 28 Aug 2026 21:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787951453; cv=none; b=EZ73zrlCjo4PogIJEWR+SV6Oa1WNYJ/Y9rSP59Ll5FJ2Q1U7YjB0xMIrZrnSBL0ERD1NMqt2R7HntbVfhW+TOuHulrv8qhPOFN2JUmQfOFsSH45FTS2CXpV7nJNPTeASM7WP0vosHjNbn4+ze3fK/onxQVsdmU3kRJD1sDb0HAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787951453; c=relaxed/simple;
	bh=jFCYYogPn69RHp3jRKyMwzrEZ4QKviFJIW0f5F87m88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jhfuh3hrcj+ABbpDjbQOhl3dIDCJoHhwqX73n0Elq3SoITY5LtYhZ8F/GLQ9ehhdpkAEggxlPgwXeBU8Rc+J6Oi7QIXit2mK1uZkwrdB++v4MMp9vGWeey1VOS/DjjEraNYu0pYutQOHdiOg9sR8GJrWYEHlxxlYNcBgQenESBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQJpAB54; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQJpAB54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED7171F000E9;
	Fri, 28 Aug 2026 21:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787951450;
	bh=4vYxI4Q7eCU/58CIgu/gmc8VB+/PmRUGYhQL3U/MCrA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BQJpAB54RGsFSB/H7VvhH1awi9fMycZgpOmjg9RdpYHARRJ0e5301hzvfvAydvjRD
	 bs/tR7So8EUkP2ntESADBuXVvlmxJZWGkKPg08HO6Zzufn43o/UXu8sIlB1ZPs63HL
	 whVOwKAbTvCSpd6wQGJN1Gy8VTAqO+MLRcZetJVUvbEIh4YgGqo3+jmsEyY7l1/ZKV
	 9M5rJsYjHxkqXq/QiNEmM90zl47w+A9/ARjFQly14Pd1iw9hlSWH82Tf7Qbxp5vzWB
	 8OkXmYCIrgGyqwvAOHjlE+YW2JIYJfiOB10o2voPuBhxxYT9Ftl47eySsA7638hkug
	 CzKjSwQkGPb9g==
Date: Fri, 28 Aug 2026 14:10:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Koichiro Den <den@valinux.co.jp>
Cc: Simon Horman <horms@kernel.org>, Jon Mason <jdmason@kudzu.us>, Dave
 Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: ntb_netdev: Fix statistics races
Message-ID: <20260828141048.685b9e9a@kernel.org>
In-Reply-To: <20260828134957.5b95472b@kernel.org>
References: <20260828154122.2643578-1-den@valinux.co.jp>
	<20260828134957.5b95472b@kernel.org>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 28 Aug 2026 13:49:57 -0700 Jakub Kicinski wrote:
> On Sat, 29 Aug 2026 00:41:22 +0900 Koichiro Den wrote:
> > Note that transport callbacks may still complete after
> > unregister_netdev(), so tie the tstats lifetime to the client device.  
> 
> We shouldn't really call devm_netdev_alloc_pcpu_stats() for types
> of stats declared by netdev core. We should set the pointer type
> like you did in v1.
> 
> Could you instead fix the fact that the Tx callback runs on 
> an unregistered device? Maybe just wrap the whole body of
> ntb_netdev_tx_handler() in RCU and check 
> 
> 	READ_ONCE(ndev->reg_state) == NETREG_REGISTERED
> 
> ?

Maybe it's over-complicating. IDK.
