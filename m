Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACE113E04F;
	Thu, 27 Jun 2024 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719532477; cv=none; b=BELkQl60yHhtfrpDGbSiboU1qWVkeHYXtaIB39pFYUt+b+rDS2umgo8y/YvUXJEhChE3aMQ/+qScoYo63Ixhd+SOzNzuhTG2VA+UgEtnhdQ4IoykmOeZuK/G6IdE3gNCehKP4zKGterVpiuKaTPBCweC8+gVOCM1zAcqWtf52c0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719532477; c=relaxed/simple;
	bh=8YD3fRsmvin8BvYC7HOuVSn9h/+y7oa38GWcnSUZnwY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mTK4ykfKxUDsU0L+EhM0wUfXYYChYiMziG/6/q+B7ncz8Znp90766T0KXxTtPkXPLUiTVESLHbkU4J2YiPvZ/qg9lM/cFnvVdjRSKVEaWAbNztw81A2eLzCSAbRKm2Tk3Aw1dfJk/323fMtS2hLLNZfuYd68v4IDoI1FL2Ju+W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rHzUi15s; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rHzUi15s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D4BC2BBFC;
	Thu, 27 Jun 2024 23:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719532477;
	bh=8YD3fRsmvin8BvYC7HOuVSn9h/+y7oa38GWcnSUZnwY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rHzUi15sctZZIYnz0BR+R++NaE7VX1ZbZXWzR5B/VF5uo5urFiiIeNzpJEbsXA/UW
	 yuTSwk3vDSQeYvG5+J1/TUKIvtsr4ezajrh955iXAJkWpzjWakrsBw742eHnSqRpfm
	 IHtBGWp/QaIVVf39JoIcmPEtbPinaHkDhirziLbHWXLC4eKoxOPkHyFemdZCrNiO9D
	 6e5sJT/oF6RdTbEvChPNDTms1OS7SXBkbvnTL5xwtH6+hUlEw73JcHeXrTLHTdv0s8
	 SBbreNrz6/UA5WM7wfkhNTBk1AykKTvkJxTAWjI0TrX2z5rmp1VpfSV+WmIuUoIBRX
	 /3EiuCzfZ5NAQ==
Date: Thu, 27 Jun 2024 16:54:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dave Jiang <dave.jiang@intel.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, jdmason@kudzu.us,
 allenbh@gmail.com, davem@davemloft.net, edumazet@google.com,
 abeni@redhat.com, Jerry Dai <jerry.dai@intel.com>
Subject: Re: [PATCH] net: ntb_netdev: Move ntb_netdev_rx_handler() to call
 netif_rx() from __netif_rx()
Message-ID: <20240627165436.19e82af5@kernel.org>
In-Reply-To: <20240626180613.3190229-1-dave.jiang@intel.com>
References: <20240626180613.3190229-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Jun 2024 11:06:13 -0700 Dave Jiang wrote:
> Fixes: baebdf48c360 ("net: dev: Makes sure netif_rx() can be invoked in any context.")

Patch LGTM, but I think the Fixes tag needs to go back further.
Sebastian renamed and flipped semantics at the same time, so
what he did for this driver should be a noop.
IOW prior to his change netif_rx() expected to be called with
BH disabled, and the driver should have been using netif_rx_ni()
or netif_rx_any_context().
Maybe add this extra info to the commit message, there's also a way
to point out a dependency via a special tag..
But the Fixes tag should point to where the bug was introduced.
-- 
pw-bot: cr
