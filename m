Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B20A3CDBD3;
	Fri, 18 Sep 2026 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789746124; cv=none; b=PhUretX3oMrdFPCshnC7gDRX7T+eiv0V0ankNE/UvQMeoss5oTNaOfT8gSBT1oGmbRqtGITpbb4zjDs/xvofyk0SPgivPP0lk4AVUBGtxBC3Gk75aHghuqLk3aAIO8FaAbyE3eyPnah2EieqlHcHkA0UKcra8GPhAChiKpkK5fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789746124; c=relaxed/simple;
	bh=EQunglJ6d2uWjOThs1jFL9G7GW/APxwBG0oncswVQ1s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=t3+xecf8GnFmAc69XMVZnoaYfLqyCbAhKAHlQHWbp7PfTBvgWQylSDq6u3X1T3F05tSw3YugjbYAtQm1ebqOd9h0RNnNm83KzmEVa7X9Ph7q55iRBI0s/021iBDQRZHnSJMq0/4GmWzXc37X+Bchul0nVPMmRGwN6EBbXPQIbNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=AvDp9G4F; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="AvDp9G4F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=vw84dLxE2GFLg805xqWaA3ak0rK2tQ1LuNCiF+Dru5E=; b=AvDp9G4Fkj/J98CK4VSs4mQylk
	mRjNNX4uljtBEgxOJAWp9+Ci5FhxBUanBzLIK3rR51U6zf3vaczT3L+O3oCd+MX0ir/0BB/LMKLQF
	rmS5QELKtoxonZJLIjUwwRT9JxDpAJln29/SGhQK0cQlrQc2s68o8AKJdQ627ep6x0htUgJMD+8vz
	IfiDQzuLmDDtzv8DRqW7VVsLlXRzh1N53+VjxkDIUtsQIwwq3Aq2Jp9a/wlrgU4D2y3YADqUv+KRm
	xssweV8Mr041fftNtNKkfwkMSkJFpXt/jWcNEci5nqqAo/U3nNAJ9uIV3CgvndPiXXoRNgWx/CnH9
	PCi1xgjQ==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7aiu-0000000CpT6-40DK;
	Fri, 18 Sep 2026 09:42:01 -0600
Message-ID: <27bf3e0a-2e29-4f96-bf87-f863649d1751@deltatee.com>
Date: Fri, 18 Sep 2026 09:41:53 -0600
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
 <20260910040836.3792333-10-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-10-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 09/14] NTB: ntb_transport: Drain RX tasklets during
 link cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> ntb_qp_link_cleanup() cancels QP link work but does not wait for the RX
> tasklet. The tasklet can still be processing the ring while cleanup
> resets the QP, and transport link cleanup can free the MW before the
> tasklet finishes.
> 
> Clear active under rx_sched_lock and drain the tasklet before resetting
> the QP. Temporarily disable QP link work so a concurrent client link-up
> request cannot reactivate RX during cleanup, then re-enable it for the
> existing link setup paths.
> 
> This does not drain RX DMA transfers or their completion callbacks.
> 
> Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Looks good.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
