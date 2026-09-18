Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901265013DD;
	Fri, 18 Sep 2026 15:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745349; cv=none; b=D8n4tWAcFGF8TjlpdUrXe0bF2yNGBlcTeDLQhiy3W4vntLmHVsV9z0+9joI5GluzNSQnlr2ulzX0+U9j0+XetT29xNivigu8fdaCEk6Ja3e92yic7zUu3UKba7TrtX2F+V/8zWfcAIaQinYF2eZpBYv6o8zfAxwPscU+IJiGcgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745349; c=relaxed/simple;
	bh=i888St0tDInwTetEm0iRJx82Hh/b9cTT6BhIHnODogw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=dBJlKemF7QG9fhGa2c8DdBQaXS7biGr+kr2RoCQA1gEvvWaxvTykmD/B23cWYrOP0JBQTs7b2cNEWMKdgatLePisMQ7y5tDweIcwyvr+LcvIWj/vtNJ0Tp3ufFIS2XM7PLDcgdvqaWuVyjJUDzuGKRnLVUOsk4UPasEIqNKTsFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=S4lAREne; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="S4lAREne"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=bl2kbsLgwYbFHSYaeEVfPecu3oRu5V20KQAuzu+WuaI=; b=S4lAREneSsd6yFALVQS09/0YIh
	dUutyJf6UcguI4+9OsaW8sa1hqBuhe4Ayg3RYy9BevyXrjStjobryF40Kg/POC3avfjUknDe7PsPk
	GX6FQ7VzNr3t0f7RELovDBoaMGR6tfVw0Lao7xIIZr+Jsm0vSHaGYmq4oJO+PGABJx7IWMPna7RwK
	0Rg6HfZC3dl7hL+ovHkWz8I+Nlm1493gLV0/0NeaNZQ7UN4kdDi9TARKnL4qOKKyr4273yM2qcVtq
	dHc5eqCDGwbqUTSU1xybKtdgguUJHVTXrSjyeA2n1QWWIBmRQaFrAibBWCRckODsExKh2LDVoQm+4
	gD9FV0OA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7aWO-0000000CpMg-3B4n;
	Fri, 18 Sep 2026 09:29:05 -0600
Message-ID: <8579d08d-b4f0-4306-9720-610021caff7a@deltatee.com>
Date: Fri, 18 Sep 2026 09:28:57 -0600
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
 <20260910040836.3792333-9-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-9-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 08/14] NTB: ntb_transport: Stop RX tasklet scheduling
 before freeing a queue
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> A caller can read qp->active before teardown clears it, then schedule
> the RX tasklet after tasklet_kill() returns. The MSI handler does not
> check active at all. Teardown also releases DMA channels before
> draining the tasklet.
> 
> Protect active updates and the check-and-schedule sequence with
> rx_sched_lock, including the MSI path. Clear active under the lock,
> then drain the tasklet before releasing DMA channels or queue entries.
> QP link work is already disabled, so it cannot reactivate RX. Use a
> separate lock to avoid contention with RX list operations.
> 
> Fixes: e902133162af ("ntb: stop tasklet from spinning forever during shutdown.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Looks good to me.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
