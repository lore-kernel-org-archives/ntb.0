Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A148212167
	for <ntb@lists.linux.dev>; Fri, 25 Oct 2024 13:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862382; cv=none; b=FUvBikk8ubF/oVMQohNdLgUgyx2DeDnWbLIdMbEiPSnGtoUQZgTUEDDQ4kMjKDquBrAAJsGKgny64sKe9BQw874D0FE1BVz8ixWHW1azHmHqWZ6iEA/jLTDbeDwSD/p8wpa7K5ECiGlLGHVm4dM305KCMeH9lKdIiABGEE2Ecss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862382; c=relaxed/simple;
	bh=V1sOFV4W/vYmfHOo/YccbeoVgUSseDX9b1vcA4AQoKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iI1w9L89lecfu8bEqa4TkaplchlLVdmsaIgXBs4ASLf5fpJmfEW+md0BiLsrGfo53YAGiI2Vb73AB28NJYIZBQKOk5BjenEFOO9bA+xnDIIZZjlvi19acy0DSLKfkNOSfkYzO6AO4Aj1pnarPiKThNw5q+RgFvwtOrqiUXt2f7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TjXQUrQ5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TjXQUrQ5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729862381; x=1761398381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=V1sOFV4W/vYmfHOo/YccbeoVgUSseDX9b1vcA4AQoKM=;
  b=TjXQUrQ5X3A7Xgj0wIE/WDTs1/8vq09bW89yeN6nwaRUiFa8OHBiYdWy
   UJskO34pGEWUwNJN81oe4D3aIpDznHsV3r7tZtSoWvpQC7KYCibpRWb9n
   szjE7Gsb7WL00Oe8U4sbXPerX5IzNHZqC5mG6e/x1xPU48kCGElyWVdm6
   yiSXQvmt5Ije1g4T+RjhYt1TguxTfTG5n9lPH9t9z6r7UVbawUdipyda8
   7/4bSlBm0k5E239h/A2T5lm5QrqUgegKj3xUbjQLvWtxIxkOeag1YoBZ9
   PXWoQKAsn+wo8CkNYFWCg7AU0o38h2/Hl/NhNHVJlFStMu2Urz2mmbn9L
   A==;
X-CSE-ConnectionGUID: u9tIK48USoCDU6Wud5wt9g==
X-CSE-MsgGUID: BKUeHb2YSDu9gpW/EkTtBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11236"; a="40145728"
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="40145728"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:19:24 -0700
X-CSE-ConnectionGUID: Bl0XnzdTSbukqiK0fd1Znw==
X-CSE-MsgGUID: f6sOCNSFReipYddQD8BK3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,231,1725346800"; 
   d="scan'208";a="80931768"
Received: from smile.fi.intel.com ([10.237.72.154])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 06:19:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t4KDd-00000006vFW-1Hxw;
	Fri, 25 Oct 2024 16:19:09 +0300
Date: Fri, 25 Oct 2024 16:19:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Oleksiy Protas <elfy.ua@gmail.com>
Cc: d.milivojevic@gmail.com, ajhalaney@gmail.com, allenbh@gmail.com,
	andrew@lunn.ch, arnd@arndb.de, bhelgaas@google.com, bp@alien8.de,
	broonie@kernel.org, cai.huoqing@linux.dev, dave.jiang@intel.com,
	davem@davemloft.net, dlemoal@kernel.org, dmaengine@vger.kernel.org,
	dushistov@mail.ru, fancer.lancer@gmail.com, geert@linux-m68k.org,
	gregkh@linuxfoundation.org, ink@jurassic.park.msu.ru,
	jdmason@kudzu.us, jiaxun.yang@flygoat.com, keguang.zhang@gmail.com,
	kory.maincent@bootlin.com, krzk@kernel.org, kuba@kernel.org,
	linux-edac@vger.kernel.org, linux-hwmon@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org,
	linux-spi@vger.kernel.org, linux@armlinux.org.uk,
	linux@roeck-us.net, manivannan.sadhasivam@linaro.org,
	netdev@vger.kernel.org, nikita.shubin@maquefel.me, nikita@trvn.ru,
	ntb@lists.linux.dev, olteanv@gmail.com, pabeni@redhat.com,
	paulburton@kernel.org, robh@kernel.org, s.shtylyov@omp.ru,
	sergio.paracuellos@gmail.com, shc_work@mail.ru,
	siyanteng@loongson.cn, tsbogend@alpha.franken.de, xeb@mail.ru,
	yoshihiro.shimoda.uh@renesas.com
Subject: Re: linux: Goodbye from a Linux community volunteer
Message-ID: <ZxuazYt5GMJWJ8xP@smile.fi.intel.com>
References: <CALtW_ahkg9W0wm09cxkJxiSQCH=42smeK=fqh5cQ9sRSNsjeXA@mail.gmail.com>
 <20241025030102.319485-1-elfy.ua@gmail.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241025030102.319485-1-elfy.ua@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Oct 25, 2024 at 06:01:02AM +0300, Oleksiy Protas wrote:
> Brate Dragane,
> 
> I was not aware of the fact that either Raytheon or Boeing are directly supplying the Russian invasion. That would be a concerning development indeed.
> 
> If you possess any information of that being the case, I urge you to contact GUR anonymously at their official whistleblowing email: gur_official@proton.me
> 
> Thank you for your diligence, only together we can stop the war.

Bravo!

P.S. "Don't feed the trolls".

-- 
With Best Regards,
Andy Shevchenko


