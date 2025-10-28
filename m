Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE9341645;
	Tue, 28 Oct 2025 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666337; cv=none; b=syeDeqK035h81EP8EtbyeRjmuxB4VoSblD6GJGlYoYioOjxwe36gtmpEwrKW6H4BSQHkdybdbPH1Uk/L//2M19hGgIUB/ZPrJJCNtJfDzz8VSOR4eiBtXAuzzJkrQ058V1ZfX5xsQGNUiSyTeYZvfI5++3JQJVq14iwoCtpNAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666337; c=relaxed/simple;
	bh=6WiB144KsJVXeBDhoMclCvhoQmc+eegowM0wCzx1XSY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=mV9C6IrTbxKBcP0RmEvvJZZzLzV2GpMWH0Zrp0IC4IBAbrY664f8CcqTT0MeSWgLWtfdjbyYk7jS5QA3RI8f0eIA29oU6Mq1KND0iMPF2DaAUsMPoffNVLF9mbDqe7HIV7AKn0/CUd4b3wvy3uvoIQk84Gybx/4G6Mqhkw/vRIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=icNNY0CV; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="icNNY0CV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=WJo3GVWLACnx0YUpPldjRjgsTLl0VT/EbYDZ0mVgjhY=; b=icNNY0CVsCBr7IrTJpo4AzHAvK
	/VNXieqfry/mCDE3N92F04Cm0sYT3F57laljqT7O+6OyVIt/xuX+F7sFLDTD12/CeQiywZRwwVsme
	Kwcb98MMpuLHJ7ITsiAYMnPdTiKsTroxa05iCZRZuBioCuET5opb4R6NR1n5/ea2Iam/7Tlxhrsdc
	vP84TWHDaH5k8uXRzg36/P8nBsTp7x/1BoarMIuuzpSEcb8AzoJWbTZO9+ukVrvcHKMCcAowlVGdx
	Oaby9IeTVWI3NOim3qahnLZiqO7TJMSSBH+pOzB2ot8RaD2SOu+xpcwul8Bk4vA7aSTyLWrZm9w7l
	gbNkZ65g==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1vDlt7-00000005gXB-3x1D;
	Tue, 28 Oct 2025 09:45:34 -0600
Message-ID: <f32278ea-a1e0-4ef3-b611-da4d68b2658d@deltatee.com>
Date: Tue, 28 Oct 2025 09:45:30 -0600
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Koichiro Den <den@valinux.co.jp>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us,
 dave.jiang@intel.com, allenbh@gmail.com
References: <20251027004331.562345-1-den@valinux.co.jp>
 <20251027004331.562345-2-den@valinux.co.jp>
 <030a4195-ed20-4f5f-8841-ea5385bb4a8c@deltatee.com>
 <b527bouvdp3a54jkvwiqhfe62nlllsbxrkvstrea3lem5c46ab@bdn67yrw3yen>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <b527bouvdp3a54jkvwiqhfe62nlllsbxrkvstrea3lem5c46ab@bdn67yrw3yen>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, ntb@lists.linux.dev, linux-kernel@vger.kernel.org, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH 1/4] NTB: ntb_transport: Handle remapped contiguous region
 in vmalloc space
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2025-10-27 19:14, Koichiro Den wrote:
> 
> I agree there's room for improvement around this "double" mapping.
> I'll think about a follow-up patch to clean this up.
> 
>>
>> At the very least, I think these issues need to be mentioned in the
>> commit message.
> 
> As for the commit message, I think adding one more line like:
> "See relevant commit 061a785a114f ("ntb: Force physically contiguous allocation of rx ring buffers")"
> should be sufficient. What do you think?

Ah, I see why that is now. Thanks for the explanation.

Adding the link helps, but I still think the commit message needs to
mention why the memory is guaranteed to be physically contiguous.

Thanks,

Logan
