Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11B6502D4F;
	Fri, 18 Sep 2026 17:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789752129; cv=none; b=PYwnN5ESg8bO5E8EFO07YKNt+N4UtkAHqAfHBnZs6VVVX/U//DQglHTkDB7ZSnLqhpQ9Cn132XEf6xjkPLheoL7peKeH5mo4iJnFZ13u7hG6uCrmLzegRhr0o2vOpd6nNFAxcjeulHKXjAGp43jds0A05pPXhJrNg+DSaY8Z79c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789752129; c=relaxed/simple;
	bh=m1kavMsIrsbFpp6YX3ATPXQIXgFOXcMDXNsdmsVwvB8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=pFIZgGdiR9Ig4AB7M0VasYLCn9Z8kEcuVfpmSlqftBar0hvBzmpZeQ4MlC5or0sOGv271/YNPaMFX73rO9Ojkfax2IuKpS+Yk5eIzz++6eI0nX6I1PbN38RHG8dWwcBrG51Q8kZvDQt2cnC6aUx8fw/cUnfEL/X2R0il4mu+Eec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=iZ507tbQ; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="iZ507tbQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=lMD3gvYRvDZDQq/d47q9h3oOHm+fflUw2oDq6EM9/iM=; b=iZ507tbQ6UwaCLR9bwbV2AWeK1
	0q60/cJUG1IrORMndMeMmCx/IJ3Uyg3gX7pbqjoPw5C+TVyV8UjBIeVCUHNmfivANq52tCK0A70V+
	eKRPRoE7QF/LAiIdQ+ihrVk1dWEpFazxZJ1JmYdT6RgFoUbfJ+kCf620XW/6dd+h7VBBsVfHd6Mvx
	36QIS+hZsP54tsY/osS8S99VsMF9QxjmF2nOLWU6ZQaC/gDCXq8fcAzeNdM77E3vD0AvwTmuetIqY
	P2cgBsxpysYr7sppz7q9uY3VDNBYsc2c41xDODCW/tlLs4Bc9LJ+6G1+IgPZY1/UJxjmFgLQCBUe0
	QFkt7I3Q==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7cHa-0000000CqZc-3KEN;
	Fri, 18 Sep 2026 11:21:55 -0600
Message-ID: <0cf58fd0-8a41-443e-ae0f-f47f7bd8a1fc@deltatee.com>
Date: Fri, 18 Sep 2026 11:21:48 -0600
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
 <20260910040836.3792333-11-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-11-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 10/14] NTB: ntb_transport: Wait for RX completions
 before resetting a QP
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> Transport link cleanup can free an MW still used by RX DMA or its
> completion path. QP-only cleanup retains the MW, but can restart RX
> on ring slots whose old completion callbacks have not yet cleared
> the headers.
> 
> Wait for rx_post_q to empty before resetting the QP. ntb_complete_rxc()
> finishes its MW accesses before removing each entry under ntb_rx_q_lock,
> so cleanup can free the MW without racing with these RX accesses.
> Using dmaengine_terminate_sync() instead would not work with drivers
> such as IOAT that lack the required ops. Cookie-based waits would
> not work with DMA_COMPLETION_NO_ORDER either.
> 
> DMA teardown in ntb_transport_free_queue() is unchanged.
> 
> Fixes: 9143595a7e05 ("NTB: ntb_transport: Free MWs in ntb_transport_link_cleanup()")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260907144257.767281F00A3A@smtp.kernel.org/
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Looks good to me,

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
