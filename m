Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F13E47F
	for <ntb@lists.linux.dev>; Mon,  5 Feb 2024 17:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707153808; cv=none; b=nzUyM+sIEfdnIiGBz0ZHEVnnRf57z3jgz3ymHK8nPFl4WD0Q5+UIzIzkVwUlL848Yblq3Vd2UZv1QNP2/qVEUr0xUGXTFN2mE6vV3okggEPlVjZN/lxpQEWdDZWHWfxN16CTed57b0+t3cDV4qf2rC9Wr8S9f2SNGiU+pPuLNYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707153808; c=relaxed/simple;
	bh=pvhRBveZIxmIvXofDZgkcTjrT0DCrv+aueCyX37D5vo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CM0UKaMLHfXdtBiLsiudNRCrcOZrO2WxZh4TUEWICE/2WA0y1rWlFrAlNSi8yPQhPA2RF7z9dmuIRz2LcCnMaK0YIbBQCSDJkE0m2wAyN0ZA1vmBAXjc5ObdhBvgioMLitwNJtJjFCNB60jgSjgvfOSheJpcZLMB1eYSEYWniqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HZjYSgSk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HZjYSgSk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707153807; x=1738689807;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=pvhRBveZIxmIvXofDZgkcTjrT0DCrv+aueCyX37D5vo=;
  b=HZjYSgSkKrIg9oC0z/5e7MVLa8ewS9gmkdOltoqswT1LmHmb8/hVOOfF
   dWV6A88gs3lRVXRnLPnY7/n2Tedn/BECOdv3XlbZmt8lkJnyylXqLHrNX
   Kmm0OAJDs8KGqHG6/z3VCVf/pid8+lgxg7qvEnVZasRJCp7pXNQeJqd47
   XcDoNm/IBy6I3U/aWWbJof1WOprEXpdWAVHXvRVWwLs8dRrX97y+ttRg0
   uUwn3/hAgIdcsWSDQ8zvQztkCUxMtTymyc7qKFYf/c73fh6ojgBgW9xZa
   CdOEoZyWWQwXGGaAEPpRnTsIwmsegtN5cuHKNtS/bxkkTP5Gb612YH5gL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="11304157"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="11304157"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:23:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="5390987"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.246.112.181]) ([10.246.112.181])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 09:23:25 -0800
Message-ID: <98ff5cce-a0bb-4ee6-839f-ce64589ffee6@intel.com>
Date: Mon, 5 Feb 2024 10:23:24 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ntb: ntb_transport: make ntb_transport_bus const
Content-Language: en-US
To: "Ricardo B. Marliere" <ricardo@marliere.net>, Jon Mason
 <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240204-bus_cleanup-ntb-v1-0-155184f60d5f@marliere.net>
 <20240204-bus_cleanup-ntb-v1-1-155184f60d5f@marliere.net>
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240204-bus_cleanup-ntb-v1-1-155184f60d5f@marliere.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/4/24 9:22 AM, Ricardo B. Marliere wrote:
> Now that the driver core can properly handle constant struct bus_type,
> move the ntb_transport_bus variable to be a constant structure as well,
> placing it into read-only memory which can not be modified at runtime.
> 
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Signed-off-by: Ricardo B. Marliere <ricardo@marliere.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/ntb/ntb_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9e7847a378e..0291d80611dc 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -314,7 +314,7 @@ static void ntb_transport_bus_remove(struct device *dev)
>  	put_device(dev);
>  }
>  
> -static struct bus_type ntb_transport_bus = {
> +static const struct bus_type ntb_transport_bus = {
>  	.name = "ntb_transport",
>  	.match = ntb_transport_bus_match,
>  	.probe = ntb_transport_bus_probe,
> 
