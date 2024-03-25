Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBF7E80056
	for <ntb@lists.linux.dev>; Mon, 25 Mar 2024 12:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711371434; cv=none; b=LgmIXifW6qvnXtwAiJmwL4kdc4HD/6WQnnxBVgNBdu5PqCIVn9HiGI6YzItD0IC61GdhPzyZkqvXhvo/vZ5PpSfCEI0O8nsz0lQ8CHVIt/5VF9LVNKz7n8tEa1Z/8AKvnQENYJcNUEP0G9K4NjWBUw1XCp3liQ1HJbaQ0LMosbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711371434; c=relaxed/simple;
	bh=HUjKdQlxom6P1m/TBqTuw6g6vhOkoQNgKeUZCY9XFh8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=T3pMrG/WdMkZ14cWmLQq3YQsKSDFHjjhz1rGD41iZz3RIrRl/sqhYOfCBRA+8hZsB7/RyXznZOyH1XV0kcBNGBwQRxZ3Qg3tsya8OUuxM5yowsbSOdksfMIlN3+7rdh+BZ8iEEOhaf4WOXLJ6x1CnerQp913tQIAbE5RXW6x5l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MPBbzQLI; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MPBbzQLI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711371432; x=1742907432;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=HUjKdQlxom6P1m/TBqTuw6g6vhOkoQNgKeUZCY9XFh8=;
  b=MPBbzQLIsl0kulVKe/oIUwJsmvnWs8iDb1fQWA2bzGGVzs3ptiEZS4on
   t8O+JxWUT4YSVE7nIY6OwS7fE2tHLs1EndOMBg8WaWYZZwlPIYgRePXJg
   tzXj2t41KZqTi9sb71ntLzgZDn8zUp3t1iG3EAfvxzttE2QzqbUWHVzMO
   kFE/ainD8RAPWeJeJID/vK/iRJroxaxep2keFcAPefQrFeyx0/GWicjVS
   DeOCsLdlm2JW5Ua/Nl96Ls6/Gnjop41DlKp3vEgcVfN8JyC7IfLsYoDRc
   Meu6EhrxXMCOk9jFIAYChxoIQFCNSbs5B54ts5A5Chnmqq6VYEZrraklK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11023"; a="6552945"
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="6552945"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,153,1708416000"; 
   d="scan'208";a="15637244"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 05:57:06 -0700
Message-ID: <b99a99be-d5f3-4e7a-a83a-e29722cd79dc@linux.intel.com>
Date: Mon, 25 Mar 2024 13:57:04 +0100
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/28] sound: intel: Use PCI_IRQ_INTX
From: =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?=
 <amadeuszx.slawinski@linux.intel.com>
To: Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Manivannan Sadhasivami <manivannan.sadhasivam@linaro.org>,
 linux-scsi@vger.kernel.org, "Martin K . Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>,
 linux-sound@vger.kernel.org, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org,
 linux-serial@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
 platform-driver-x86@vger.kernel.org, ntb@lists.linux.dev,
 Lee Jones <lee@kernel.org>, David Airlie <airlied@gmail.com>,
 amd-gfx@lists.freedesktop.org, Jason Gunthorpe <jgg@ziepe.ca>,
 linux-rdma@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Cezary Rojewski <cezary.rojewski@intel.com>
References: <20240325070944.3600338-1-dlemoal@kernel.org>
 <20240325070944.3600338-5-dlemoal@kernel.org>
 <3edd5823-bf54-4898-bcee-e1628c863388@linux.intel.com>
Content-Language: en-US
In-Reply-To: <3edd5823-bf54-4898-bcee-e1628c863388@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/25/2024 1:34 PM, Amadeusz Sławiński wrote:
> On 3/25/2024 8:09 AM, Damien Le Moal wrote:
>> Use the macro PCI_IRQ_INTX instead of the deprecated PCI_IRQ_LEGACY
>> macro.
>>
>> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
>> ---
>>   sound/soc/intel/avs/core.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/sound/soc/intel/avs/core.c b/sound/soc/intel/avs/core.c
>> index d7f8940099ce..69818e4b43da 100644
>> --- a/sound/soc/intel/avs/core.c
>> +++ b/sound/soc/intel/avs/core.c
>> @@ -343,7 +343,7 @@ static int avs_hdac_acquire_irq(struct avs_dev *adev)
>>       int ret;
>>       /* request one and check that we only got one interrupt */
>> -    ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | 
>> PCI_IRQ_LEGACY);
>> +    ret = pci_alloc_irq_vectors(pci, 1, 1, PCI_IRQ_MSI | PCI_IRQ_INTX);
>>       if (ret != 1) {
>>           dev_err(adev->dev, "Failed to allocate IRQ vector: %d\n", ret);
>>           return ret;
> 
> Reviewed-by: Amadeusz Sławiński <amadeuszx.slawinski@linux.intel.com>

Sorry, one more thing, can you adjust commit title to:
ASoC: Intel: avs: Use PCI_IRQ_INTX

and with that, you can add above Reviewed-by:

Thanks!
