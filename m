Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9D0227B94
	for <ntb@lists.linux.dev>; Mon,  1 Dec 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764615902; cv=none; b=JXElMqvHfGfufI2NEyKv0e439NGijDTJahGm8aszyUzzAuw/5jB5r7yDnIb4Cj1Irswq6N4M+sVNo3EXktptQ7vomj8g8g1SK+oU1VSkz/G+jWki9ID9SUM4CK77wbC0xbwk+u1tVvmYYsF68rzrzqS0P/u8E/xWft/YdHcUp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764615902; c=relaxed/simple;
	bh=x7D/sGmf/c/0gO6t24b1WDhlleJ8EXPnh9AOo3EpkkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZT+CU6a7t/nDFO8MhVUZoaXKpQh/duufQ9CJSYZ1zaVtk5zRBIW8TkZDeryXUght6KEWAGWulf7yzX8JcTPceudGm+4HteBrpU6N46xPzcNW97Sd/nv01S+waLJ3sOg/zpSvfY6GxBfd8wKT+A3QOuPxdBtL7sM18ZbHcTtEy9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ITYp9d7c; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ITYp9d7c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764615901; x=1796151901;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=x7D/sGmf/c/0gO6t24b1WDhlleJ8EXPnh9AOo3EpkkI=;
  b=ITYp9d7cptzyA53YscJJYZYy96lFEFrpPJVIhboGjBYlMZC1qXsek31P
   zUkNK2bVO86cB3RUkcZzfhH+GRlv/eIaXPGkXgYGoUBvVwAv2X8FNsWJu
   WvB/iU9bGmngJsh1XrEzNmuifLmXqsuhGCqDpUKfwAw2ibz5LnyVvn/s9
   SIpBckoz3CvihIJe+VO3pb9VfS0pCOVefBXMztkgnFYMXz0LQVdxw+lcL
   qwdUVv4soqoNzDbtlGJR28c61aB2CzQzd+tSuEO9CeqZ0AUAoKnjb1Ov6
   VbmSWGFmnMTq6h/ObipcSSUBxseyxtrtfIjq55FC9tFYixzH13K9/uOQ9
   A==;
X-CSE-ConnectionGUID: MDDZnCNaRMeD29/AgVY6eA==
X-CSE-MsgGUID: zwCgRzzpR5yYG8yY1moT2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11630"; a="66733564"
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="66733564"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 11:04:20 -0800
X-CSE-ConnectionGUID: cIG5fV+2RR6/hCPlNWAx3g==
X-CSE-MsgGUID: FO4hOtdoTHyn4WfWAIuVGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,241,1758610800"; 
   d="scan'208";a="194948662"
Received: from tfalcon-desk.amr.corp.intel.com (HELO [10.125.111.120]) ([10.125.111.120])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2025 11:04:19 -0800
Message-ID: <39d470c3-9e13-4ae6-9111-74ad7f4ef67b@intel.com>
Date: Mon, 1 Dec 2025 12:04:18 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] NTB: ntb_transport: DMA fixes and scalability
 improvements
To: Koichiro Den <den@valinux.co.jp>, ntb@lists.linux.dev,
 linux-kernel@vger.kernel.org
Cc: jdmason@kudzu.us, allenbh@gmail.com
References: <20251027004331.562345-1-den@valinux.co.jp>
 <uw7plhwaat2mpwydjle57ppzubwgvhiq7bvtsort7fic5jpgls@ba4hze2gtfqp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <uw7plhwaat2mpwydjle57ppzubwgvhiq7bvtsort7fic5jpgls@ba4hze2gtfqp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/30/25 9:58 PM, Koichiro Den wrote:
> On Mon, Oct 27, 2025 at 09:43:27AM +0900, Koichiro Den wrote:
>> This series contains two DMA-related fixes (Patch #1-2) and two scalability
>> improvements (Patch #3-4) for ntb_transport. Behavior remains unchanged
>> unless new module parameters are explicitly set.
>>
>> New module parameters
>> =====================
>>
>>   - use_tx_dma : Enable TX DMA independently (default: 0)
>>   - use_rx_dma : Enable RX DMA independently (default: 0)
>>   - num_tx_dma_chan : # of TX DMA channels per queue (default: 1)
>>   - num_rx_dma_chan : # of RX DMA channels per queue (default: 1)
>>
>>   Note: legacy 'use_dma' switch is kept and prioritized higher.
>>         Enabling it always implies use_tx_dma=1 and use_rx_dma=1
>> 	regardless of whether use_(tx|rx)_dma=0 is appended.
>>
>> Performance measurement
>> =======================
>>
>> Tested on R-Car S4. With the following patchsets applied [1]:
>>
>>   - [RFC PATCH 00/25] NTB/PCI: Add DW eDMA intr fallback and BAR MW offsets
>>     (https://lore.kernel.org/all/20251023071916.901355-1-den@valinux.co.jp/)
>>   - [PATCH 0/2] Add 'tx_memcpy_offload' option to ntb_transport
>>     (https://lore.kernel.org/all/20251023072105.901707-1-den@valinux.co.jp/)
>>
>> throughput became bound by RX DMA service rate. Increasing the number of
>> RX DMA channels (>1) improved throughput substantially:
>>
>>   - use_rx_dma=1 num_rx_dma_chan=1
>>                  ^^^^^^^^^^^^^^^^^
>>     (full command: $ sudo modprobe ntb_transport tx_memcpy_offload=1 use_rx_dma=1 num_rx_dma_chan=1 use_intr=1)
>>
>>     $ sudo sockperf tp -i $SERVER_IP -m 65400 -t 10 # RX DMA n_chan=1
>>     sockperf: == version #3.10-no.git == 
>>     [...]
>>     sockperf: Summary: Message Rate is 8636 [msg/sec], Packet Rate is about 388620 [pkt/sec] (45 ip frags / msg)
>>     sockperf: Summary: BandWidth is 538.630 MBps (4309.039 Mbps)
>>                                                   ^^^^^^^^^^^^^
>>
>>   - use_rx_dma=1 num_rx_dma_chan=2
>>                  ^^^^^^^^^^^^^^^^^
>>     (full command: $ sudo modprobe ntb_transport tx_memcpy_offload=1 use_rx_dma=1 num_rx_dma_chan=1 use_intr=1)
>>
>>     $ sudo sockperf tp -i $SERVER_IP -m 65400 -t 10 # RX DMA n_chan=2
>>     sockperf: == version #3.10-no.git == 
>>     [...]
>>     sockperf: Summary: Message Rate is 14283 [msg/sec], Packet Rate is about 642735 [pkt/sec] (45 ip frags / msg)
>>     sockperf: Summary: BandWidth is 890.835 MBps (7126.680 Mbps)
>>                                                   ^^^^^^^^^^^^^
>>
>> [1] Additional changes are required to use DMA on R-Car S4. Those will be
>>     posted separately.
>>
>>
>> Koichiro Den (4):
>>   NTB: ntb_transport: Handle remapped contiguous region in vmalloc space
>>   NTB: ntb_transport: Ack DMA memcpy descriptors to avoid wait-list
>>     growth
>>   NTB: ntb_transport: Add module parameters use_tx_dma/use_rx_dma
>>   NTB: ntb_transport: Support multi-channel DMA via module parameters
>>
>>  drivers/ntb/ntb_transport.c | 386 +++++++++++++++++++++++++-----------
>>  1 file changed, 270 insertions(+), 116 deletions(-)
>>
>> -- 
>> 2.48.1
>>
> 
> Hi Dave,
> 
> As a quick update, this series is likely to be superseded by another work
> on the "NTB transport backed by remote DW eDMA" series:
> https://lore.kernel.org/all/20251129160405.2568284-1-den@valinux.co.jp/
> On R-Car S4, the remote eDMA-based approach clearly outperforms the
> existing architecture that relied on DMA_MEMCPY engine.

Does it use a different transport?

> 
> Do you think it would be worth moving this older series forward?
> (I'm not sure whether there is an interest from others on this series,
> perhaps using some other platforms other than R-Car S4.)

I guess it doesn't hurt. Jon?

> 
> Thank you in advance,
> 
> Koichiro

