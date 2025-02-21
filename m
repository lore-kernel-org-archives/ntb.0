Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C512F399;
	Fri, 21 Feb 2025 13:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143838; cv=none; b=Gm/l30L+eqXCoBsym8odI9jRk1IWuC/FI+nB0A6SANaBhTHzn+kvMQz2HeVE0w9EwsBNASH1wBKcvXKbWG4UQ5R1lMa3Z4R5jCqtnitz2WYsBl49MDP60bvnazucEnTmEGSEMx9cJu+UN6u3gTmzY8B4lUHXnf+OMILo9NjvNgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143838; c=relaxed/simple;
	bh=IzQqM/tThZ0C5KtPCUAq1uZgnfCzsKn9/uiesSAdNLQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RimnY3UNaC7uLXbyW5vK1GRxrf8dQh/eRQ0IeWVdxKXsYIQW4iat+u2O/Yt/tfEbeG1NAaEPwkXe7LmwQg71j0Ly/LW1RtfImDNDRAwD0W0zVCv5sfT8CVheMbQjSUgOLls7GPMYGoQ9dNfVYpi+Ky9n5VcP+iMeUu5iaVWHg90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4pbgy9n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4pbgy9n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F780C4CED6;
	Fri, 21 Feb 2025 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143835;
	bh=IzQqM/tThZ0C5KtPCUAq1uZgnfCzsKn9/uiesSAdNLQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J4pbgy9nCMrcYruxoSOBTEqSbk9lpOOgmjbKXe/w8ZDhrOsfkdw+hskl6DqWJ/AQB
	 SW9yRSy6Vl2hCEkdlxSRNo2UJ0fnCC9/Ri8fYbHyQFYKKFIDIkkTNsgWBzaM166a0J
	 Rs9OSQURw5RhYgSs8fxCDGBz9Q2CctVJrtQSc/2PmU0CL6MXFUQ/3pWNJ5OtK+YbqB
	 Z5EtNtv86ovmulECI08Z/CswDbBXfynQpOkx5TdHmEHHGPCaNXmnurDRa2j4rD1fGX
	 astxXDF8SKrZ+bfLNr2/phTjEIKbTbKvoAHBf3CGbRM2NPHdKlT/u1yrOZrjqQjAvy
	 5lFAtQwgT1UOA==
Message-ID: <5f4b6e0e-cbeb-460e-ae03-34c678866c85@kernel.org>
Date: Fri, 21 Feb 2025 22:17:13 +0900
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: reduce stack usage in idt_scan_mws
To: Arnd Bergmann <arnd@kernel.org>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, kernel test robot <lkp@intel.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 zhang jiao <zhangjiao2@cmss.chinamobile.com>,
 Philipp Stanner <pstanner@redhat.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20250221085748.2298463-1-arnd@kernel.org>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20250221085748.2298463-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/21/25 17:57, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> idt_scan_mws() puts a large fixed-size array on the stack and copies
> it into a smaller dynamically allocated array at the end. On 32-bit
> targets, the fixed size can easily exceed the warning limit for
> possible stack overflow:
> 
> drivers/ntb/hw/idt/ntb_hw_idt.c:1041:27: error: stack frame size (1032) exceeds limit (1024) in 'idt_scan_mws' [-Werror,-Wframe-larger-than]
> 
> Change it to instead just always use dynamic allocation for the
> array from the start. It's too big for the stack, but not actually
> all that much for a permanent allocation.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/all/202205111109.PiKTruEj-lkp@intel.com/
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Looks good to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research
