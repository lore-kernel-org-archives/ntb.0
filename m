Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770F916DC17
	for <ntb@lists.linux.dev>; Mon, 22 Jul 2024 14:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721660042; cv=none; b=L2zB2v8rYxBo2CC1FQYffPvQbN+yLEIqRLEwKN+OZIsN7Uum8hcuauezsmiflBiCG7+Unfea/TyTQ/VJVuqepyNMiAM4P8MEk/WG+0oGDYGO136oPNJx0QoI5SUt3BHkvs2w8QP370aTxJNTKhrNcJfUSPDFbTVPCqNJ2Ew0hxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721660042; c=relaxed/simple;
	bh=1e0vV1UoVXTfp55GAjrIIBKq42BYmjjNqv/c6iRw9Pc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffMaqwHMjBoE+GreuZXlxEvGbBMGYrOWB9tMf1RgIX8OHOpq7OKxERXx2o/9eQzU88vCaxO9tIk+ZFBQxN8+6miU8pP6covY3WuYla9bFQTfJBjNYtGI01AaAvmPaT5u8lv/EdVYl3MPsLQGbAzQMlj1PqYwmzyeQP0NDqp7U5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V4VllzWq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V4VllzWq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1721660039; x=1753196039;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1e0vV1UoVXTfp55GAjrIIBKq42BYmjjNqv/c6iRw9Pc=;
  b=V4VllzWq4s/6Xcz0AWBCf2XhxBIK9XnmZDqRvpDfEf9Gx+7g72fmqnqI
   RNwXhSwnl0HtU6RD8/WD30CxCDgy54S/JO7AbcTIRRwLVVHbPbaeesMgk
   8xOgA1j9Q8lvsw+RaokL1gzIVzI2Ym0kFVlytI5Z7ZCY2QOorlewDhJ8a
   zDKLZ+r1fHaSrBneWyhBhNcUR3Gnw/eksKhuz+v1ANWvFB8bRppQUQUTE
   MbEzsSvXN08yVKOHCP8TJqQVdWJ8XIPpZyWNprblo2eJXJ/k4oHfQORMI
   AijVGbZBSgLtf4ThVUazTqwealmV3gMOKbHXwKxfpn2Kj0U6AF4eFapIP
   g==;
X-CSE-ConnectionGUID: Kfuvkb+RRUawCULX7DfRig==
X-CSE-MsgGUID: QhfRS57ZSVCXSMNVss/t5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11141"; a="36678543"
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="36678543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 07:53:58 -0700
X-CSE-ConnectionGUID: N8gUvA1JTg+HOj3rYIqe6w==
X-CSE-MsgGUID: yVQ10b+OQfu3aOpnlOw0bQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,228,1716274800"; 
   d="scan'208";a="57032016"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.109.188]) ([10.125.109.188])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2024 07:53:56 -0700
Message-ID: <7cb0179f-2b63-41c1-a17c-b3422feff501@intel.com>
Date: Mon, 22 Jul 2024 07:53:55 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: Constify struct bus_type
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 ntb@lists.linux.dev
References: <50a28f39b1f0d0201b2645d2a8239e1819dc924b.1721473166.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <50a28f39b1f0d0201b2645d2a8239e1819dc924b.1721473166.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/20/24 3:59 AM, Christophe JAILLET wrote:
> 'struct bus_type' is not modified in this driver.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   69682	   4593	    152	  74427	  122bb	drivers/ntb/ntb_transport.o
>    5847	    448	     32	   6327	   18b7	drivers/ntb/core.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   69858	   4433	    152	  74443	  122cb	drivers/ntb/ntb_transport.o
>    6007	    288	     32	   6327	   18b7	drivers/ntb/core.o
> 
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Compile tested-only.
> ---
>  drivers/ntb/core.c          | 4 ++--
>  drivers/ntb/ntb_transport.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/core.c b/drivers/ntb/core.c
> index d702bee78082..ed6f4adc6130 100644
> --- a/drivers/ntb/core.c
> +++ b/drivers/ntb/core.c
> @@ -72,7 +72,7 @@ MODULE_VERSION(DRIVER_VERSION);
>  MODULE_AUTHOR(DRIVER_AUTHOR);
>  MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
>  
> -static struct bus_type ntb_bus;
> +static const struct bus_type ntb_bus;
>  static void ntb_dev_release(struct device *dev);
>  
>  int __ntb_register_client(struct ntb_client *client, struct module *mod,
> @@ -298,7 +298,7 @@ static void ntb_dev_release(struct device *dev)
>  	complete(&ntb->released);
>  }
>  
> -static struct bus_type ntb_bus = {
> +static const struct bus_type ntb_bus = {
>  	.name = "ntb",
>  	.probe = ntb_probe,
>  	.remove = ntb_remove,
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 77e55debeed6..a79f68e18d3f 100644
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
