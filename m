Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F3A348C7B
	for <ntb@lists.linux.dev>; Wed, 10 Jun 2026 17:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113506; cv=none; b=jEWTR9anvRxaoBxnF8O9Ht4vwklM7CslPMQ1XvZDhYCTUapx+aNzgIFM2U1pgDm0Q3a6Zkd0xm6Li0O4676BNNfB5ZHzRpJMCOLDoCgVfX46vconfbXe+McFgF/xPYsV73/yU/jSU3H+qOf5tJ1t4dySug/yOBH/aqQYOZwfsIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113506; c=relaxed/simple;
	bh=d358o27sYm6o48uuXbim2n+sI/4Po27rnMvBoy/ZIgY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7PZ9hKSH0eF9ZQ77O5u6kwCyLbZGmb2xwYyrbEMtLt6TQQ2n42wch75nvLuh4+/kzBnS82XO9TF+xaFa859I9EqQUKRCttRckZC4qyCb6KSR0gQhGODEQsjH3QTVIejH/MQ8LE8HzK7RqoWYJN7+wEa2RY06MxarC4/LoQcZmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BkULI8Yn; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BkULI8Yn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781113504; x=1812649504;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=d358o27sYm6o48uuXbim2n+sI/4Po27rnMvBoy/ZIgY=;
  b=BkULI8YnAxoRVJybdSemHgnCI01xVbLTACn0P2XvSutfCH8IofN4qDT0
   Z8d3kQd2qG5NhaRIsEUhfwEJxwfIgLbSOmGsQ3B4w2j+0DUQXakWEYPmO
   pF5HvrjhwlChQjvRN827ZrvvtXC2a7sjlg6L5JGE+VqIPmA33jh1wCYXF
   cgqtOdtCGvS9i92n2rrBnZ+MhO7g5S7Y6i7vDY+cGIZRFUflQ5a0dP6p7
   Y+Ejix8J1eDMEQ1m9j+avWJ93rZRBwplLFQiuxcLyhsc31gWBPc8HEY+9
   kjGwn/uur0/lBDuGJtNBMLuikYjRi9qGfexIjQTu9yYw38+mbG/7GICh+
   w==;
X-CSE-ConnectionGUID: SkpOUzPyQN6uSJybixj2Kw==
X-CSE-MsgGUID: HhPJCvfBT16nDM12r9sPyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11813"; a="104579973"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="104579973"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:45:03 -0700
X-CSE-ConnectionGUID: r17n33nwRRmBX36uiJ8jEw==
X-CSE-MsgGUID: qxuAefw1T0uVbVvCIZLsSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; 
   d="scan'208";a="269917965"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.110.25]) ([10.125.110.25])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2026 10:45:02 -0700
Message-ID: <3eb87591-50c7-4a00-9599-882c7fefc72f@intel.com>
Date: Wed, 10 Jun 2026 10:45:01 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ntb: amd: Use named initializer for
 pci_device_id::driver_data
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig_=28The_Capable_Hub=29?=
 <u.kleine-koenig@baylibre.com>, Basavaraj Natikar
 <Basavaraj.Natikar@amd.com>, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Jon Mason <jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
Cc: Markus Schneider-Pargmann <msp@baylibre.com>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20260507074102.2654314-2-u.kleine-koenig@baylibre.com>
 <aimYgZgy5w5gwDMA@monoceros>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aimYgZgy5w5gwDMA@monoceros>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/10/26 10:02 AM, Uwe Kleine-König (The Capable Hub) wrote:
> Hello,
> 
> On Thu, May 07, 2026 at 09:41:01AM +0200, Uwe Kleine-König (The Capable Hub) wrote:
>> The current list initialisation depends on the well hidden two zeros in
>> the PCI_VDEVICE macro. Instead use a named initialisation that is more
>> robust and easier to understand.
>>
>> Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
> 
> who would be the one responsible to pick up this patch?

Jon should for 7.2 merge window opening next week.


> 
> Best regards
> Uwe

