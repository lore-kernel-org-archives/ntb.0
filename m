Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5015243DEA1;
	Tue, 15 Sep 2026 17:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=204.191.154.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494752; cv=none; b=uYohkzIOmZHlBHBWCk0NsVEQE8CZ6YjjC+1evgbv+rwtdF/30+IgHXuRi8udKKU/WwzG4idh5zKX8ETLQ+ccT6EntDPrrkpmqi1z39EaI4domQlNMlMINBrBx7bbHkF3SdzN112usjqg1mO5Hpd4QDwwQBuZl2DD9YTZzxqcLGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494752; c=relaxed/simple;
	bh=lc/0vagjt36v/IrjbBsGSlJ1oZABTNViiMmeOlqxSZY=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:In-Reply-To:
	 Content-Type:Subject; b=A6+zWNfMRta7drrMzCwcPPp2uXkRsr5aRQMiPKJTJyBvPBOHLvMFHy8BTgT09uhIALtjTVuVXrePNKJIaWuTsVffiuTMtU3y/pwoBDaz1O78YzdtaDQLNXlzIc2FU1DytFo3Y3jBkKhDR65E8XuNJ8HrJbaMbIRvo9EsmHl+xNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com; spf=pass smtp.mailfrom=deltatee.com; dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b=LY9vFxtc; arc=none smtp.client-ip=204.191.154.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=deltatee.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=deltatee.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=deltatee.com header.i=@deltatee.com header.b="LY9vFxtc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=deltatee.com; s=20200525; h=Subject:In-Reply-To:From:References:Cc:To:
	MIME-Version:Date:Message-ID:content-disposition;
	bh=BC+z32DSLcVpUUv9ncqhrJMmgXadALSV7DcDyh6zZ9w=; b=LY9vFxtc7t1MJqa1yfHtH52zEn
	b4NtOCQFhYdJGjHBM/L/OC0l/gUFnv5F+6xk4qFXGFxrc2tLS5QNOoNt3NeiCVZZ554ZcMKBmBYUB
	ca6FLQH2nNqkrRI1/Z7k8Jgo85Ua8dWABdUL1+QuHZq6/hXcgJX/2PCmrZJFZUd0/ocKBBeamZx+O
	B9GhIGMYa3TNKiHAzPeiaqe2FU7sygsTYV0Uoe6SHkmNn+XNV48YumoPonZSHlBa7xSuWmdhFi+9I
	X9H8iOe8QjUs9ydwLirQkDk/CVwf2zCByj6tx3M+amv8lbvEqYjucOiBMdbD7oXQGIbuMsJtOPYCk
	61NaspmA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
	by ale.deltatee.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.98.2)
	(envelope-from <logang@deltatee.com>)
	id 1x6XKS-0000000AY2Y-39tC;
	Tue, 15 Sep 2026 11:52:25 -0600
Message-ID: <83611140-c6bd-4e75-bc56-65e7985e08c0@deltatee.com>
Date: Tue, 15 Sep 2026 11:52:17 -0600
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
 <20260910040836.3792333-2-den@valinux.co.jp>
Content-Language: en-CA
From: Logan Gunthorpe <logang@deltatee.com>
In-Reply-To: <20260910040836.3792333-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: den@valinux.co.jp, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, Frank.Li@kernel.org, fuyuanli0722@gmail.com, gregkh@linuxfoundation.org, nab@linux-iscsi.org, joey.zhang@microchip.com, ntb@lists.linux.dev, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Level: 
Subject: Re: [PATCH v2 01/14] NTB: ntb_transport: Remove the device debugfs
 directory
X-SA-Exim-Version: 4.2.1 (built Sun, 23 Feb 2025 07:57:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)



On 2026-09-09 22:08, Koichiro Den wrote:
> ntb_transport_free() removes QP debugfs directories but leaves the
> device directory. On rebind, debugfs_create_dir() fails with -EEXIST
> and QP statistics files are not recreated. Module unload masks this
> by removing the entire debugfs tree.
> 
> To reproduce:
> 
>   # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
>   qp0
>   # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/unbind
>   # ls /sys/kernel/debug/ntb_transport/
>   0001:10:00.0   <-- should not remain
>   # echo 0001:10:00.0 > /sys/bus/ntb/drivers/ntb_transport/bind
> 
>   .. and then dmesg shows:
>   debugfs: '0001:10:00.0' already exists in 'ntb_transport'
> 
>   # ls /sys/kernel/debug/ntb_transport/0001:10:00.0/
>   (nothing)      <-- should be 'qp0'
> 
> Remove the device debugfs tree on teardown and probe failure.
> 
> Verified that unbind removes the directory and rebind recreates qp0.
> 
> Fixes: c8650fd03d32 ("NTB: Fix transport stats for multiple devices")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Looks good to me:

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
