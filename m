Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690C04CC60C;
	Tue, 15 Sep 2026 18:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789498530; cv=none; b=nMc0Oizo76FPCyKTC1NFZUHR/QrT0ooc9gw7ABNpgKPD0B5WApi8Ook9m9KjtIgJ4AvC9k1aMdHz1NGIcuFCvz4/1uqJDjzGCfVtlysRpBA51iwesM1usQMXaNOt1VOF4d9eeulUgPeeY7rTFoUSJvCdtl0Be2ZNGADw2VkBlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789498530; c=relaxed/simple;
	bh=t/KHLRhmhmuKBX8bF+8VIDj6oCnSEBQh311H5lqOPek=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=Nn7027bAXzjhcP5vlRT1Us3isBTKELU0GcoasW7chf0g+DOzThlP8yJBKuh21relt13+oQ3FTuZiuip0RO6vCVHXRfnz7WgormPkM9Nj/XCrHnQhCoXjX8PoQ59JRrfHHSaIggB7Hl+f40LbH8QDNHxjHU75m369qZ9VRLDS0hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=aZJ0szJM; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="aZJ0szJM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=fyO9XAWR64DykI6KokwiFtXo+VX4c8FM668+QfO/kXk=; b=aZJ0szJMhoKEbwaItpholzX8DD
	hZShwOtcyxEJTgVRE11c/bfn4G/hPVWBFXn23fnLdI/EYuiCiTdItZXqDEc5bkjR7bRzsOLLdeSc/
	de2Mip7inuSSe0+kC2y0XfqFjJZ3mIn2kvYLg0nhE4dHDsWRmd75L9LjUogNP2YvQC/Yu7Y9sR9r+
	qGTdlYuKgvGpV0kGudSBvymM+NJZC+SjgfYPy3+SkutoeQGNnk00BcVV1b3OSTutHvEZ3NbzoGmZW
	SvVYT95oCEGklNbduEVduWoPsp/gE40Nah8atD944PG1BRT6tU+pIj49BceUq64L4Qcc7CvTWBDcm
	GR/COL/w==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6YJR-0000000AYkL-1PQD;
	Tue, 15 Sep 2026 12:55:26 -0600
Message-ID: <932bedee-b070-4c18-bb56-83830a11d2b4@deltatee.com>
Date: Tue, 15 Sep 2026 12:55:23 -0600
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
 <20260910040836.3792333-7-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-7-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 06/14] NTB: ntb_transport: Clear link state before QP
 cleanup
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> Cleanup leaves the transport link marked up after releasing its MWs.
> A subsequent client link-up request can therefore start QP link work
> before the transport has been set up again.
> 
> Clear link_is_up before cancelling QP work and releasing the MWs.
> Have QP link work return if the transport went down after it was
> queued.
> 
> Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

This makes sense to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
