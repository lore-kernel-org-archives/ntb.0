Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D42445ADD;
	Fri, 18 Sep 2026 18:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789754704; cv=none; b=UVOpTLG3bQd4svuXuEwEOWofFp9QNYBPAwO9ocf8uDswSwB626xXx0QlsWbpRd6U5hSUMG8Awb8TyE+dxtIcomFXpPvKzfGIhhUVnf5xJ4IpYwpThzMBZ/QhYvTeJ3feqRmlGRw586/APIg/m/57LG/8TtTgdsUWAUo65EfD1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789754704; c=relaxed/simple;
	bh=ZJB7lfKekQMzrZYARcNz7jLpPQI5qGEMlYdlrdCbdng=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=CBmfjKPB/EluwTgplqLJz/HibfOTkqWEqU0zVHvnVr3CvaBVEE5fd1tAvDD6JTT26QN0Y6C/buDeBctsAmgN6AmBl524qup/sVoN/iobqEPNkovQfwUm5V0vC4rtHT4uf4Tu4GtpCCfZlOyRnYw1U58GR0gFs97sXrD5FxYUaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=F95jwPCB; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="F95jwPCB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=3RVfamw1qRQMMqMg1u9s++MTOjZNVIjdzhiiMuQvBJE=; b=F95jwPCBtoEHBC4QmG5F2z8GrL
	3SUWG/MfA3+T8Ko0ufF1MMrjMC08fLSeBeT4LaWbvq8Auo3pnv1pfBenbCCMKdIYtz7FlqXuxszhr
	WnB6pGNILTUnV2eZC+S0elA5aRcREz5HSjU4gQ1cFSlP3fGF3/mFrc/xQMcTgNDMU5POnwIy/kXF0
	Xz6NG38sTSUQg6H1DwNrk360hsUMvLug0CqJRcbEQZb29pvvL/VWJEis+/vBGvoR4nYKxiMzYzksN
	fvLNlPaV+lVTzwCDAVE2IhkVTaigtQE3LJgu4zNiRHaA93qCu5wUNZxiOvBRrxWpJq4/dXCAOZsLa
	MJ9J10+w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x7cxB-0000000Cr7A-0hmB;
	Fri, 18 Sep 2026 12:04:53 -0600
Message-ID: <e369433b-8066-4c6b-9b98-a1106bcf4c43@deltatee.com>
Date: Fri, 18 Sep 2026 12:04:49 -0600
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
 <20260910040836.3792333-12-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-12-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 11/14] NTB: ntb_transport: Prepare remote RX info
 accesses for MW teardown
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> The next patch clears remote_rx_info when freeing its MW.
> ntb_transport_tx_free_entry() and debugfs stats reads can run during
> link cleanup, so make them handle a NULL pointer.
> 
> The pointer is accessed locklessly. Use READ_ONCE() and WRITE_ONCE()
> to prevent compiler-induced tearing, and retain the read value so
> the NULL check and dereference use the same pointer.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
