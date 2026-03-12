Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B916237C0F8
	for <ntb@lists.linux.dev>; Thu, 12 Mar 2026 17:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773335525; cv=none; b=V4oFqtGMYLx8CPAbww+yXOOXw2eaOuTMJy8t+YX8KXuCPR07F/gCQCH63f6Zxy6NVOrpzopGLk9f0Z4XSm6xHU83urlpsoUK9vE4aeajbvyoc8DpgKlC5DckRS7gcpHNgTAM4+Tdn1Q0UEcdv6CHT0HIFg2ZhHezFCqmY6oeVsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773335525; c=relaxed/simple;
	bh=fGLJI+IegtmizWs8bYgFL5B2F0zQMwLuVbtYZCM1SMo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NENEbJyG80e24g11a5fmtGdSAxNgYY6vhvRis9nVuBtzcTQ6jHLyjCGp4AABivTLg1Rejmej6/Z42BGTcTMFPxsNXztl7sizLi7cZgHkmel80g664ijqLdXK8vAd9IdSicHKhrSkvQcxWKF5w2oQyvFRyDAZ0pG4JYqWK8u8CJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nqDMBy5j; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nqDMBy5j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773335522; x=1804871522;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fGLJI+IegtmizWs8bYgFL5B2F0zQMwLuVbtYZCM1SMo=;
  b=nqDMBy5j/0yRpKfEN/u7ldReJs6chuUVzNDlRxCpf9mSKmzcJ4w1V6Tv
   MAWETotyjk6v2OAnDbKGGq7yb5VbpLN5hhEFEtxhN3cpf0JINUu3aUBer
   W8w7pxFQwZX6ME4nEFWTwH5ohzVmj8GKEj4F6fGhIsuf6YxRsH+0MrqbZ
   ta8XJlilkCbLilvpFQYyTkT20ImAJmwUExljxOMs9ZvwB6XTXONhBA/Yo
   OeFlvi0xY18PVMtla+lrC2BENr79vLmaycRmrhavEx2qJGGc4/hzwkbRA
   QNLhujjGBekbsU1CE6iZwN+uJiLmQz5aqUo+JsdrfCFoRXgrzThsu44Z0
   A==;
X-CSE-ConnectionGUID: kl9zQF8bTI6khJSS6VyzlQ==
X-CSE-MsgGUID: MB3oD48dT6CxVjJdi36/Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11727"; a="85139895"
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="85139895"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 10:12:01 -0700
X-CSE-ConnectionGUID: aMB5Lb4VTZacCC0mZawc6w==
X-CSE-MsgGUID: XZ3FpfUHSZSVd7htpbrVaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,116,1770624000"; 
   d="scan'208";a="221075070"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.142]) ([10.125.110.142])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2026 10:12:00 -0700
Message-ID: <e900da77-b277-4f40-9c6c-316805ca0b01@intel.com>
Date: Thu, 12 Mar 2026 10:11:59 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NTB: fix kernel-doc warnings in ntb.h
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev
References: <20260312051415.683874-1-rdunlap@infradead.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260312051415.683874-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/11/26 10:14 PM, Randy Dunlap wrote:
> Correct a function name and function parameter name to avoid
> kernel-doc warnings:
> 
> Warning: include/linux/ntb.h:575 expecting prototype for
>  ntb_default_port_count(). Prototype was for ntb_default_peer_port_count()
>  instead
> Warning: include/linux/ntb.h:590 function parameter 'pidx' not
>  described in 'ntb_default_peer_port_number'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
> Cc: Jon Mason <jdmason@kudzu.us>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Allen Hubbe <allenbh@gmail.com>
> Cc: ntb@lists.linux.dev

Acked-by: Dave Jiang <dave.jiang@intel.com>

> 
>  include/linux/ntb.h |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- linux-next-20260311.orig/include/linux/ntb.h
> +++ linux-next-20260311/include/linux/ntb.h
> @@ -563,7 +563,7 @@ void ntb_msg_event(struct ntb_dev *ntb);
>  int ntb_default_port_number(struct ntb_dev *ntb);
>  
>  /**
> - * ntb_default_port_count() - get the default number of peer device ports
> + * ntb_default_peer_port_count() - get the default number of peer device ports
>   * @ntb:	NTB device context.
>   *
>   * By default hardware driver supports just one peer device.
> @@ -578,7 +578,7 @@ int ntb_default_peer_port_count(struct n
>  /**
>   * ntb_default_peer_port_number() - get the default peer port by given index
>   * @ntb:	NTB device context.
> - * @idx:	Peer port index (should not differ from zero).
> + * @pidx:	Peer port index (should not differ from zero).
>   *
>   * By default hardware driver supports just one peer device, so this method
>   * shall return the corresponding value from enum ntb_default_port.

