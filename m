Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.175.65.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793662968;
	b=fmWMHNt5WsAVbZLhtn2nHnbGK69LGzmWMukLeHcKdZoF1QclD4P2Z65lswejFDlBJ3W5
	 NgiDOuKjz/WYAUF2VZ+mM8B5vqpQO4V97MumuByYsnzzlWb6iSddxV29EowodhcRVYsNr
	 FoPU/2LFXaCNym2UqNSzeYyzoC/Qoih2Vwr28IuqgrbOINskIaSdoz+Afwn6pOKviK08n
	 tEtxwuSV8D8Rzp/zbzfypIk/sVhWXISt/YHyH6cxrsWWGr4cs6dblQ1J5t0SwpUhpTlRh
	 QfHQj3oIX0/gx0DsFW+OfzE3m1pcpAbNc0NNgD6aLAu86K5ZD1zyuTnZuwrtf7MzR8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793662968;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
	 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=o3AyBdMUkVdCCJKAQY/1TakIHf1rsXe0QcmI773jn9M=;
	b=SuThOoqvSjZHisVGAFNJ/rFpOcD+xntfEDbTYOMHqP1x4pLgqYyGVZbXQcD4k2DPPOcm
	 3VgEhr0a57rTdkhdD5Pbzto+ZctrvvzFGHGzPnvDRd/u7lvFpFQoeswNVjRxcEb/IExsl
	 BgYEhGivP6Tf7CGt3+q4QQjrSHMp4LggFtp9ufHQJ1DwZiSr1Gb6XLgTY1gZ90+RmujRG
	 3rtemDqrVqN7y5kLn3XrWBT+DjgCGyeoT3fWx0fo78MQON1Vaq3mJCYJCNMAEoIlMxrs0
	 ZwtkA1FE9UlHPuxmTVBrtX7dbV3CFzfcOggdW8bWoKEN85/vBB1Ri+jq3rrOIsPQqUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=intel.com;
	spf=pass smtp.mailfrom=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ibl1EM8b;
	arc=none smtp.remote-ip=198.175.65.16
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE9F606A326;
	Mon,  2 Nov 2026 23:42:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CE9F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ibl1EM8b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1793662952; x=1825198952;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LXChv3V1vRZYD43vc5i6FcOX7rjeKYnWqEFenVJgnkE=;
  b=ibl1EM8bw6yRMyaWDGjWfTHdXPm87QlLvtV24LuYOAYqGAKXVWb8uqcH
   RYNoDRsl7iDDseunhSRP2inERugcJnSUMcd/q+bOcDVITHf11VN/LoIdq
   BxvtFpMAi6bcrIzSxFoF5IUSa9eRDRX77Ra9xpkKHR0zCmGG7uDc0B9ja
   FC10G++fh6po2NLXMSRsSMTqGvYHsGnUuJqVRvsNJfuADWJZeycs4z7WX
   HoC7LcheKtjMllu5Mbo9AhR6fhRmrkWHgNQogKKamAZ1SRrZbuDBovkAg
   xOemEAhrG+TA8Ol2/EKLDstWPzOiTvZYhYV8heGAohPGCWnURc6ref3+o
   g==;
X-CSE-ConnectionGUID: TkDBvWztRteIjtTsBUMCAA==
X-CSE-MsgGUID: GpAOsJPMRxK1J+6jZ1XfzQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2366701"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2366701"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:42:31 -0800
X-CSE-ConnectionGUID: gLubmmTpTOCBojPNKbMtGw==
X-CSE-MsgGUID: jh+VBy3gRB6jV2futItRiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6097933"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.109.163]) ([10.125.109.163])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 15:42:31 -0800
Message-ID: <84b07585-6dec-45c5-ba5a-784d0da7a961@intel.com>
Date: Mon, 2 Nov 2026 16:42:29 -0700
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Post: <mailto:ntb@lists.linux.dev>
List-Help: <mailto:ntb+help@lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
List-Owner: <mailto:ntb+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ntb: use dmaengine_desc_set_callback()
To: Frank.Li@oss.nxp.com, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Matt Porter <mporter@kernel.crashing.org>,
 Alexandre Bounine <alex.bou9@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Andrew Morton <akpm@linux-foundation.org>, James Kim
 <james010kim@gmail.com>, Dan Carpenter <error27@gmail.com>,
 "open list:NTB DRIVER CORE" <ntb@lists.linux.dev>,
 open list <linux-kernel@vger.kernel.org>
Cc: imx@lists.linux.dev, vkoul@kernel.org
References: <20261102195748.4092882-1-Frank.Li@oss.nxp.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20261102195748.4092882-1-Frank.Li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/2/26 12:57 PM, Frank.Li@oss.nxp.com wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Replace open-coded assignments to callback and callback_param fields
> of struct dma_async_tx_descriptor with calls to the
> dmaengine_desc_set_callback() helper across ntb drivers.
> 
> No functional change intended. Prepare to make struct
> dma_async_tx_descriptor private to the DMA engine.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

For the NTB bits:
Acked-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c              | 6 ++----
>  drivers/ntb/test/ntb_perf.c              | 3 +--
>  drivers/rapidio/devices/rio_mport_cdev.c | 3 +--
>  3 files changed, 4 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f9caa1a653c5b..370196ecf8f9d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1557,8 +1557,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
>  	if (!txd)
>  		goto err_get_unmap;
>  
> -	txd->callback_result = ntb_rx_copy_callback;
> -	txd->callback_param = entry;
> +	dmaengine_desc_set_callback(txd, NULL, ntb_rx_copy_callback, entry);
>  	dma_set_unmap(txd, unmap);
>  
>  	cookie = dmaengine_submit(txd);
> @@ -1889,8 +1888,7 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
>  	if (!txd)
>  		goto err_get_unmap;
>  
> -	txd->callback_result = ntb_tx_copy_callback;
> -	txd->callback_param = entry;
> +	dmaengine_desc_set_callback(txd, NULL, ntb_tx_copy_callback, entry);
>  	dma_set_unmap(txd, unmap);
>  
>  	cookie = dmaengine_submit(txd);
> diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
> index dfd175f79e8f0..862b3dffa2b17 100644
> --- a/drivers/ntb/test/ntb_perf.c
> +++ b/drivers/ntb/test/ntb_perf.c
> @@ -834,8 +834,7 @@ static int perf_copy_chunk(struct perf_thread *pthr,
>  		goto err_free_resource;
>  	}
>  
> -	tx->callback = perf_dma_copy_callback;
> -	tx->callback_param = pthr;
> +	dmaengine_desc_set_callback(tx, perf_dma_copy_callback, NULL, pthr);
>  	dma_set_unmap(tx, unmap);
>  
>  	ret = dma_submit_error(dmaengine_submit(tx));
> diff --git a/drivers/rapidio/devices/rio_mport_cdev.c b/drivers/rapidio/devices/rio_mport_cdev.c
> index 40d2953a9a7f9..585e3f9ff29ca 100644
> --- a/drivers/rapidio/devices/rio_mport_cdev.c
> +++ b/drivers/rapidio/devices/rio_mport_cdev.c
> @@ -717,8 +717,7 @@ static int do_dma_request(struct mport_dma_req *req,
>  		goto err_out;
>  	}
>  
> -	tx->callback = dma_xfer_callback;
> -	tx->callback_param = req;
> +	dmaengine_desc_set_callback(tx, dma_xfer_callback, NULL, req);
>  
>  	req->status = DMA_IN_PROGRESS;
>  	kref_get(&req->refcount);

