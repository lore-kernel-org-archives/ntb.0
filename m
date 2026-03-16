Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E4533A9DD
	for <ntb@lists.linux.dev>; Mon, 16 Mar 2026 17:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773683920; cv=none; b=bJWfb8900fHmBjgFGyEewd6G9CaC3GIKQ7W/kPyrJF3KTOBUl9T1qmHvg+YdAz/INsJt2kJikM9ZwHyPZM3EAC5P2T4qbBFbKtEpGqD/OnDmghoC1uPrYvLv5bv7YCB/puQQsRUZzv7BXz1r/Z2WDDunkEGI3hnlmNRtF5DyZTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773683920; c=relaxed/simple;
	bh=Gto/l0/mxDGERh7ixmeRcFGaRfvxQQNvElUoQhaP+RQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dqj4YSX9sWCuhUa0FuD1iJ9voCBLwfZvEA3uOu/wODNyo4bUeglGsXREonB3TAyvSaTSfmmHr81ZcXuzeSzuOqVt3Q2xai6bDC1TQMWyHR3Vq0Ljy44TiDnvquXCMMtXPM9l5rBcDnGngON/y1RTb8FlwnRGPRcxEBVvGIZE9t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YkjweDg+; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YkjweDg+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1773683919; x=1805219919;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Gto/l0/mxDGERh7ixmeRcFGaRfvxQQNvElUoQhaP+RQ=;
  b=YkjweDg+Dy0uSDPUqa05SKBt146rcfBQLZVUlCAw2o/zzP7A5G4w9lzv
   vsSJWfqT1+mtnaf52encI87o/1qU4ZuzvMuCe0OYEAa6SMsCpHkywYaHT
   PbRbJSm1mX/U8GaSxUTuf2Xru3v/4nZC8MjFd0GMIuATY99gcH5UlCLTb
   nQaVQQbfQFGeSzHIiYLLhqyK5aX1AEQpEbLCwQc9gbqLIQcTyn3Aw7Kl9
   Q1FvoDXUkUd3pvQmvpohvv2FA5afOuI0RXMn22BF3Oel3POBjGI8psv2J
   UyQdXboopezuTIy1cSBjnpCuEd05rwLbZFXoyx0egTTeJwduvyr+zBciD
   A==;
X-CSE-ConnectionGUID: hoAxyepuTWe5tFzF7jdFyw==
X-CSE-MsgGUID: 2Y9gbS9DTwWdHXOHJvK6Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11731"; a="74414819"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="74414819"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:58:39 -0700
X-CSE-ConnectionGUID: ME1Upy3sTwi/ilQHI0BPHw==
X-CSE-MsgGUID: UvV2OwBLQdKkhcVRPb/Bvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; 
   d="scan'208";a="259888243"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.124.223.96]) ([10.124.223.96])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2026 10:58:38 -0700
Message-ID: <c207d845-ef03-4f8a-82f3-031eaad3e10f@intel.com>
Date: Mon, 16 Mar 2026 10:58:37 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: ntb_netdev: add SPDX tag and remove boilerplate
 license text
To: Oskar Ray-Frayssinet <rayfraytech@gmail.com>, jdmason@kudzu.us
Cc: allenbh@gmail.com, davem@davemloft.net, kuba@kernel.org,
 stephen@networkplumber.org, ntb@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260316170141.1792-1-rayfraytech@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260316170141.1792-1-rayfraytech@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/16/26 10:01 AM, Oskar Ray-Frayssinet wrote:
> Add SPDX-License-Identifier tag to reflect the dual
> GPL-2.0-only/BSD-3-Clause license and remove the redundant
> boilerplate license text.
> 
> Signed-off-by: Oskar Ray-Frayssinet <rayfraytech@gmail.com>
> Acked-by: Dave Jiang <dave.jiang@intel.com>
> ---
> v2: Also remove redundant boilerplate license text as
>     suggested by Stephen Hemminger
> v1: Add SPDX-License-Identifier tag only
> 
>  drivers/net/ntb_netdev.c | 50 +---------------------------------------
>  1 file changed, 1 insertion(+), 49 deletions(-)
> 
> diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
> index fbeae05817e9..76806d1c5e69 100644
> --- a/drivers/net/ntb_netdev.c
> +++ b/drivers/net/ntb_netdev.c
> @@ -1,52 +1,4 @@
> -/*
> - * This file is provided under a dual BSD/GPLv2 license.  When using or
> - *   redistributing this file, you may do so under either license.
> - *
> - *   GPL LICENSE SUMMARY
> - *
> - *   Copyright(c) 2012 Intel Corporation. All rights reserved.
> - *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> - *
> - *   This program is free software; you can redistribute it and/or modify
> - *   it under the terms of version 2 of the GNU General Public License as
> - *   published by the Free Software Foundation.
> - *
> - *   BSD LICENSE
> - *
> - *   Copyright(c) 2012 Intel Corporation. All rights reserved.
> - *   Copyright (C) 2015 EMC Corporation. All Rights Reserved.
> - *
> - *   Redistribution and use in source and binary forms, with or without
> - *   modification, are permitted provided that the following conditions
> - *   are met:
> - *
> - *     * Redistributions of source code must retain the above copyright
> - *       notice, this list of conditions and the following disclaimer.
> - *     * Redistributions in binary form must reproduce the above copy
> - *       notice, this list of conditions and the following disclaimer in
> - *       the documentation and/or other materials provided with the
> - *       distribution.
> - *     * Neither the name of Intel Corporation nor the names of its
> - *       contributors may be used to endorse or promote products derived
> - *       from this software without specific prior written permission.
> - *
> - *   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> - *   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> - *   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> - *   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> - *   OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> - *   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> - *   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> - *   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> - *   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> - *   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> - *   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> - *
> - * PCIe NTB Network Linux driver

I would leave this line

> - *
> - * Contact Information:
> - * Jon Mason <jon.mason@intel.com>
> - */
> +// SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause
>  #include <linux/etherdevice.h>
>  #include <linux/ethtool.h>
>  #include <linux/module.h>

