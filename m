Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99CA429CCF;
	Tue, 15 Sep 2026 19:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789502397; cv=none; b=V62QkA9tMP01aY3EXej4ke8gCWL43Jta+lc2HtdvsaafD/gEW1JCRsr2hrHjjFi/1Tcue/zyErjNIsyhsc67AsY10D4k2LNDXWyXXfNgLeXNZmcmuNRo1CBmcxV0kAGsZ4t3GJMPhXDuOjU03CZ9bfQtx9GHtimrgiEM5quT/aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789502397; c=relaxed/simple;
	bh=Ke+n6750Csq7zwHZB3qJ0htvbSs/M84PuKQ3Wcf6W2A=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=sLQutiIRJ9ORV85wYMiDeKFEqVEbizFBGOtGq6tzFzoxnwjnxtlG8Ln5Gy6I9pHfP8/P4GC2DFYINHWc5Kzyi+jy2Sf4BWBiPEQ6x99NY5V6n9DLhP8OCjpM4yr+00gUmIiKMNtohg5TuWGTpVawYIodbFbnTBkap2nQcUKcVDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=OBUYoQ4q; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="OBUYoQ4q"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=eE3oegc4um/1NofrJF92xyMTUWSjoKQeOwOq0rL0H38=; b=OBUYoQ4qZvZcQDihJckGSFJR2x
	+y/Wb0AJQrNvTrHT+LNiwxElerWYS8ucrDv/+FQ0v5glXvkkQZIyQKml1ZNL4teiC6k1wWuiFgnB/
	8frjLr7SuF//gCj6kCPWYVqWtL0H5718FYo0gOlb9pE7Af5ArGjXKrpVl0IKHRad7CL42jd4dDuEG
	2s86YPe6p95BNiP39X6Vqp/BeojLzZrwmRAueIg7jNZ88mtzafZSgKriK888eTFpTcjogCw+C5U1H
	D23tYiml4k0AkI1vjY04nO+nn44Tor4gqWVULZCNXMxOq7lAHsEsuv0YiWIdbAVBLuuHHr8aWMwKO
	V8Q6m2PA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6ZJh-0000000AZUG-2enc;
	Tue, 15 Sep 2026 13:59:46 -0600
Message-ID: <59d5af73-71da-4273-ba01-28d725f28e47@deltatee.com>
Date: Tue, 15 Sep 2026 13:59:36 -0600
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
 <20260910040836.3792333-8-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-8-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 07/14] NTB: ntb_transport: Stop QP work before freeing
 a queue
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> ntb_transport_free_queue() cancels qp->link_work but not qp->link_cleanup.
> A peer link-down message can queue cleanup while ntb_netdev is freeing
> the QP. Cleanup can then requeue link work after the queue resources
> have been freed.
> 
> Disable and wait for cleanup, then link work, before freeing resources.
> Unlike cancel, disable also prevents the RX tasklet and transport link
> setup from queuing more work. Enable the works only after queue creation
> succeeds.
> 
> Clear client_ready first so RX completions and transport link setup see
> that the client is no longer ready. Clear link_is_up and active after
> the workers stop, since link work can set both back to true.
> 
> Fixes: 7b4f2d3c3b82 ("NTB: No sleeping in interrupt context")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
