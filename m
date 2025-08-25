Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40BB3019C6;
	Mon, 25 Aug 2025 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141209; cv=none; b=S5QOiFgG+yAYo0NUYcETZyVDCZ4/opZmaR60ePqkc/9aSTJKGZVRcUcJdfYxaJUx8Wj/+vUWipMOa5l+tlVlnlFYQ28MiiDyRnuFM1api/knbI/WfFsxTtLidnMptRRButQlUD/p6HoUCWJ/YKSMSu6Ii+ExScsRPKp0ymy6FPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141209; c=relaxed/simple;
	bh=4EDOzHtjFquOXpBd3J1DV13NauPx9JoAQoEmD+Nz3MA=;
	h=Message-ID:Date:MIME-Version:To:References:From:In-Reply-To:
	 Content-Type:Subject; b=PQvCELs2VlW2KmZ1A99Sf0lFKrAK1TQDuZ64jpqsAukvV6V0F5yNYiedUO85p0JZWTzDIioAqVfUFpzjPPEAizteQyXZbOGz0L4t1MJgVQ8JHD4iMJ3SO6g8vrmNRgMIqoXbCcUAGvc5+ZWaKyWi0+LEjRDv5o/rbVG3dmNZq2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=IdQxIvZO; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="IdQxIvZO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:To:
	MIME-Version:Date:Message-ID:cc:content-disposition;
	bh=PIr0YEGATBYAb0T7QUNMh4SydRiREFnxIn0wlAGjgi0=; b=IdQxIvZO6idSUOQ0eXDGNMn+QB
	4R5FeyMihkoZb3D50u0DUSfvqzmJGj9ZfLNhzpRuhPpx/vPpqQos0/rpBIu7ImWrc79q4Odc0qkyG
	Wms/sPQUa+EMyebsoIxXU7bfPJ6KP1EEqhSX4KFmbUZRK8fcvmylGIok+BC2GRfwzbKskcYq8lSD4
	N5VmZElzbTC7ykZzezUfAvbUwGp62tLcAw+1bTt7iBvprKGXaewgW8QfnRVVotpXkBOugITm9am/0
	5KN+DPhdmA6VMfc31leg1znuBfWuHGL+ErzUgQWMKD8gY/CacJprWW6GPCspmSNYhCnoYo46Q0/PH
	CV+S1JgA==;
Received: from d104-157-31-28.abhsia.telus.net ([104.157.31.28] helo=[192.168.1.250])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <logang@deltatee.com>)
	id 1uqZuK-005MYC-28;
	Mon, 25 Aug 2025 10:18:55 -0600
Message-ID: <e039337b-0bf7-4238-aa5e-21100a2646ac@deltatee.com>
Date: Mon, 25 Aug 2025 10:18:53 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
 ntb@lists.linux.dev, linux-kernel@vger.kernel.org, fuyuanli0722@gmail.com
References: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 104.157.31.28
X-SA-Exim-Rcpt-To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, fuyuanli0722@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2] ntb: Add mutex to make link_event_callback executed
 linearly.
X-SA-Exim-Version: 4.2.1 (built Wed, 06 Jul 2022 17:57:39 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-08-25 03:15, fuyuanli wrote:
> Since the CPU selected by schedule_work is uncertain, multiple link_event
> callbacks may be executed at same time. For example, after peer's link is
> up, it is down quickly before local link_work completed. If link_cleanup
> is added to the workqueue of another CPU, then link_work and link_cleanup
> may be executed at the same time. So add a mutex to prevent them from being
> executed concurrently.
> 
> Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>

Looks good to me, thanks

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
