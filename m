Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FC04A1E08;
	Tue, 15 Sep 2026 18:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789495721; cv=none; b=AQfV2waJzccR/VCg/wrLevA+sirZegWtFu7ZqASt9OFopAt+zeaaM/xhZ9o6jc/kPyPq0SYEoeJwFGVx3uOKdPUPGkJ2nrq1RSyGCWuDfEloYVrFiEzlA9SgdqgAhy/4FIPpTQ5UsPyAWbe6Vbtwj4ase1/yw2DZWUwII591WbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789495721; c=relaxed/simple;
	bh=Ll1myl92c8a2MWo/XPZM9bX9GPKLeQFu6v9T9lRltvA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=RVekpJ2bxxcHLTFUxhThhN1V8FaTAQ+kNOmqzuttb7ethkfxfeehxU9wlZxhLCDRuVylHmnxcFTOFdZjIvV3endfxiQ5zifY1R1GlinlTfcSXzeEQFFSRJs8ZENOY44ttEcYYoYsNIaKvBMwxuinJvN3S1LgzhmqQBN+HjD7wpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=Afh8Shre; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="Afh8Shre"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=Y3QqdiKwzzwnOLVu0cz4e5ckPEkkS+wXR/bk2dD+t0Q=; b=Afh8Shre5B0WOOEsmVnV09tl/V
	pyAC5sTZp4+Q/AbXIzwMkL0VmYZ8m9GXnkiptsv700wMoBFfLN3Fh7s1/YYhLTNTC6qpUgvFOhBqh
	ui4uAKAp/JQGnMZ9qDW2GsY+NxpsT0FLgAA3axWeOYMli7t1MJBB8WdSvVlM58kTN8kaUsZBsEVTN
	nHB+LOBxtvc+O5znqfn4WbmQvzsymeTs2pbxkyCyLjAyUtqZRUNys8lxFXpDFOO1gx2CorQyCUOe+
	seFxldpsQ14SMBtLxw/cy3Of0qLN9mY0MLgkY2mqoGifIPjgGVKu4iol8iIrBw67wuKXgC6kPIB4W
	lvhWHi0w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6Xa9-0000000AYR6-0ZA9;
	Tue, 15 Sep 2026 12:08:37 -0600
Message-ID: <e8da7017-7065-4be3-bcc7-88bd6348d2e0@deltatee.com>
Date: Tue, 15 Sep 2026 12:08:34 -0600
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
 <20260910040836.3792333-3-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-3-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 02/14] NTB: ntb_transport: Start TX offload thread
 after queue setup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> ntb_transport_create_queue() starts the per-QP TX offload thread before
> DMA mappings and queue entries are allocated. If later setup fails, the
> error path returns the QP to the free bitmap without stopping the
> thread. A retry can then reinitialize its waitqueue while the old thread
> is still waiting on it.
> 
> Start the thread after queue setup.
> 
> Fixes: 322617a06c97 ("NTB: ntb_transport: Add 'tx_memcpy_offload' module option")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
