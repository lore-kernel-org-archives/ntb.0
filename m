Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249BA221F06
	for <ntb@lists.linux.dev>; Mon, 24 Feb 2025 12:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740400757; cv=none; b=myCwYXt/s0XDfMyKfn86HLb/gOyLYMKH4hOHv+GDY1rZKbsxL+hcvkHYVpeXSfGwdXDM6GtiVyVcCiNCWy6bDmTKjKCLqDBuFgiJhMo3w9aMPw1Swrq0wLpo8cDMsT6ncvqjWUgW/i4yjCA4ld0pxeFYesXgx1hKqSCilp2MyrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740400757; c=relaxed/simple;
	bh=I4zwzRfgVjDsqL3gEcvnfx+MpbnW+WUPLHL5AHyvtfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Od0cmn+HYCETcU4oIsI16avCAch5rKtOMUdvdiuuXvH5fdTodCpQNiaJVxbMm4f8KFUDn9fAaNenqIFklAGf9UlzzaKY9H6kjw9zWEzMl/rZRbV+1Lx++m7DZuo0JeBmPWdBbiWBXz7eVEp7zAhI1M6aYRjZaft8SLee1PqlOa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fqQm/rdz; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fqQm/rdz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740400756; x=1771936756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=I4zwzRfgVjDsqL3gEcvnfx+MpbnW+WUPLHL5AHyvtfs=;
  b=fqQm/rdznhrdaUvQt4N+jmIdFnl02dBl1Ho0tLrFxBlyztyiZA35RBqN
   Xejv6yfYQU+gQGuj1LbJPr8Hz2LeAloAis9L4/12TkCsXF6O3CFij5wAI
   SaU5GLOk7AjGm6WnWV0zW7VqpVZVuhf6EkNOD5gOuW5YGsJP7GLJKXlPP
   g7a5wiApr5tNYyBWp+iFQLk3fQVrlIaAsgxrFYKY14tLIF8rHp2FommHf
   WassxP9QXt/yTjFpqTVx9RFjFKLfpN6WBewllXfD2+Aexqgs+iffHBJ89
   ES2lCrbWI8LrN88v8kJwhqyEX5XjuFrRxRtSXoQyEoA9EO5WygLVyWRch
   Q==;
X-CSE-ConnectionGUID: iHofekWZQhSLEuU0SURHRg==
X-CSE-MsgGUID: hGBLkd1iRludo9mBeK5tAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="44804203"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="44804203"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:39:16 -0800
X-CSE-ConnectionGUID: TOwLHXo3SgmVXIMwNmb0vQ==
X-CSE-MsgGUID: z2UkMDxrQkWgeU8zvFf0YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="121321317"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 04:39:10 -0800
Date: Mon, 24 Feb 2025 14:39:07 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: perex@perex.cz, tiwai@suse.com, broonie@kernel.org, lgirdwood@gmail.com,
	deller@gmx.de, andriy.shevchenko@linux.intel.com, sre@kernel.org,
	sakari.ailus@linux.intel.com, mchehab@kernel.org,
	hverkuil-cisco@xs4all.nl, jdmason@kudzu.us, fancer.lancer@gmail.com
Cc: linux-sound@vger.kernel.org, linux-fbdev@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-media@vger.kernel.org,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 00/13] Convert to use devm_kmemdup_array()
Message-ID: <Z7xoa9FbuvIaTJFt@black.fi.intel.com>
References: <20250221165333.2780888-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221165333.2780888-1-raag.jadav@intel.com>

On Fri, Feb 21, 2025 at 10:23:20PM +0530, Raag Jadav wrote:
> This series is the second wave of patches to add users of newly introduced
> devm_kmemdup_array() helper. Original series on [1].
> 
> This depends on changes available on immutable tag[2]. Feel free to pick
> your subsystem patches with it, or share your preferred way to route them.
> 
> [1] https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com
> [2] https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com

Update: Anyone wishing to pull from this series, please use the updated
tag[3]. I'll wait for a few days for review comments and send out a v2
with fbdev fix.

[3] https://lore.kernel.org/r/Z7xGpz3Q4Zj6YHx7@black.fi.intel.com

Apologies for the inconvenience.

Raag
