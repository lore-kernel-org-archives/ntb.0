Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9211551CF4F;
	Fri, 18 Sep 2026 18:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789755479; cv=none; b=ruxznLG7i48+MoPtD+JXN+e3nYxY8sjMC+ZNKAsC6az+Sp1MAyQlcA69gYDioTuH8QOt1Wf6xh7F9WyOBt4dpq2WtmGlx5K5gMHolzj5AgJ44IXYjw32Lnr3Er/UvmttF1IxaYhuZ0fOpiNQ93+X30U5f2SkUCljdJUOWH+M2gE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789755479; c=relaxed/simple;
	bh=k4B8t17iNakHVS7H1Kyv3GlOCmhAyEfMVl/OjaXjxhY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Uf9TzE/Y8UeZ7GOlfEoFkbqojFqrNHl8Ncrtp826m3cYjk4l01XYcvZ3epl8e+VKh/RjJ5eJaDENrDArgviOk4Ect3ztJvETdmIyLH7YUyfEjivKRE4nrFQ5Jh0QTwmayDB0u1yBmWBTmZ0UUBIpNhkOcMe42ALogDBQ4rtxRWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=G9lUPyFu; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="G9lUPyFu"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=tCu1Cwm4Jv+7/G0BvSmkHgBxFcR/JNpqpYrJQmXiAW0=; b=G9lUPyFufCeRkt7FZX7hALr4L9
	WuQDvBHct4kUHIoRsG9SE+uHz62AdCkbd7gMQDmfCNGm03NOhauN7wUD7+drVVF3sOY14FCf622K5
	rG9HWlfWJBb8PoanesYKDSXob8FZ3t9iO7KEpgS8XN0wy3rYFSqac9/Wq+9PjxhrUxebbS9W0tH2d
	TZTvwD4EGC4earz4XqAeE/2vNYoHMgMscUHPmyldp2cYIV0auPtSqICFMpJ5LnGMK1DQKdt17n75H
	EVz+fjX3aKdaPms0FIOrnkRwLR9ltJmLMJH2KvJfmnn/iuPf+EG90OIDLAQW2DLfNo/drpJdYGxZL
	GtTyGKgQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7d9m-0000000CrCG-1v5L;
	Fri, 18 Sep 2026 12:17:55 -0600
Message-ID: <8de189f4-f93d-4ab1-a1d8-150079445258@deltatee.com>
Date: Fri, 18 Sep 2026 12:17:53 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Frank Li <Frank.Li@kernel.org>, fuyuanli <fuyuanli0722@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Bellinger <nab@linux-iscsi.org>,
 Joey Zhang <joey.zhang@microchip.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260910040836.3792333-1-den@valinux.co.jp>
 <20260910040836.3792333-14-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-14-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 13/14] NTB: ntb_transport: Abort link setup on QP MW
 allocation failure
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> ntb_transport_setup_qp_mw() can fail while growing a QP's RX entry pool,
> but the link worker ignores that error. The worker can consequently
> publish a QP whose memory-window state is only partly initialized.
> 
> Abort on the first QP setup error and release the MWs through the
> existing error path instead of publishing the transport link.
> 
> Fixes: a754a8fcaf38 ("NTB: allocate number transport entries depending on size of ring size")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Makes sense to me

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

