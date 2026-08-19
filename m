Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D065632B120
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 23:46:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787183174; cv=none; b=Y8oFmWAKUty9RHPA7UeVoN4wYYTCll+AU4MTKcxMT+4bAADgAjlBOolVkrxFilFCY7AzVQYF1VFoa/syFsz1JhxHWIkErna3FKE2UaS0Yam9o9HkmJMbDNDITjV9qqavxKksdZttiSia8QVHfXpmcD1RTF1qd51j/R9+M2zvhr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787183174; c=relaxed/simple;
	bh=cTA3PHnOJJeih2mK0UbQNfwDOB3+Skd+oBXosgCJGEY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQSrvy88rcTTrPt+8xHYdp4Fk3DzPpkn3WIC4DOZCsi4y5RCPQSxxcboam/7puVKLFi3JR+Y8i85ZhxzpUnjEFtTbq9WwO7U1mgLUt7QODmw0PnkwMqywTq3Eq1Ba+/km7JTV3kpPJP41VtX8507+3oAb/onM7BoSgcTTbUjsHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T1+gAsQY; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T1+gAsQY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787183173; x=1818719173;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cTA3PHnOJJeih2mK0UbQNfwDOB3+Skd+oBXosgCJGEY=;
  b=T1+gAsQYTwUbFRjjviT1jVhNEIDpRi2PihS/j2uRjPlCmruYRFLHsSqj
   /z4H2arp8YZDxSYffWAhsBbgthb6NOyZN/HuEGQRKebXI8qa8lBWU6jQm
   Tj9zJa4wPERRkPxAEHj4oTx5C/66WKqu8I8DnIV9ayy6BgZTrtTNnh3jJ
   gjo8em+DJZ5IPJzAkCXlKysIgtw8DSU4ZrqQ4Zf77Sig80gIHQvSuB6Cq
   pZklxIj+n/aNnpv/qO8dkdP6KUn54U7ey/53rEoksRrGhArw7wFdi4IZ3
   M1aLWtWKjc43BfSPpMr8S2UfpVyPTJvZ8SK1+0lLxAjGepTykqJGtkUpt
   A==;
X-CSE-ConnectionGUID: WdSipi5XRgiKZxUIAguWwQ==
X-CSE-MsgGUID: zBX9kO58TAm0MUd8zAao4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="113252294"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="113252294"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:46:12 -0700
X-CSE-ConnectionGUID: DUqrzO/MSKSy9mM4HunmsA==
X-CSE-MsgGUID: VZAEhUhGQ2Omc9ZvTHNbww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="266352334"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 16:46:10 -0700
Message-ID: <6cbd0910-533c-4167-bc30-106d532eb8af@intel.com>
Date: Wed, 19 Aug 2026 16:46:09 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/4] NTB: ntb_transport: Fail TX enqueue when the QP
 link is down
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-4-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817053519.4135287-4-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 10:35 PM, Koichiro Den wrote:
> Commit f195a1a6fe41 ("ntb: Drop packets when qp link is down") meant to
> make ntb_transport_tx_enqueue() drop packets submitted while the QP link
> is down, but it only returns 0 without consuming the packet. Zero means
> success by this function's contract, so ntb_netdev reports NETDEV_TX_OK
> and forgets the skb: nothing queued it, nothing frees it, and it leaks,
> one skb for every transmit racing a link-down.
> 
> Return -ENOLINK instead, restoring the contract that a non-zero return
> leaves the buffer owned by the caller. With the preceding patch,
> ntb_netdev frees the skb on non-retryable enqueue failures and returns
> NETDEV_TX_OK, so a packet racing with link-down is dropped without leaking
> or entering a busy retry loop.
> 
> Fixes: f195a1a6fe41 ("ntb: Drop packets when qp link is down")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index e92b96f4afad..4bdd81edcb87 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -2353,9 +2353,8 @@ int ntb_transport_tx_enqueue(struct ntb_transport_qp *qp, void *cb, void *data,
>  	if (!qp || !len)
>  		return -EINVAL;
>  
> -	/* If the qp link is down already, just ignore. */
>  	if (!qp->link_is_up)
> -		return 0;
> +		return -ENOLINK;
>  
>  	entry = ntb_list_rm(&qp->ntb_tx_free_q_lock, &qp->tx_free_q);
>  	if (!entry) {

