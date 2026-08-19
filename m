Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E41E2FB0B2
	for <ntb@lists.linux.dev>; Wed, 19 Aug 2026 21:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787174175; cv=none; b=b9IZ6JCytojbkiXrNMbHDD8ycMPRPtHJpPlVBNMONvIkrfrDD42UAV+erQkJLVfVESvz8BNhcoYoF1PVv4fd9qsvIAjvVDAj707DGNQY4Rp2aama281K/SbcyiqQYQv4bm8H7M+uG8lflYqxoFDewvLNan0dGq3C0U0E1eouCT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787174175; c=relaxed/simple;
	bh=znKp6FFW6e4vloCf/TZGsoTX7/wCAKLPkbIxWejDXZI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyza0xAt6IOlMiiFnvcVoaPDKcY7cOKcZxqcCKxd6FXTrj5+/XSFUujmWjXgkszbFtOXqJZ33bXXQc0Nn7BrrW5aCpExVVf2Tk/KlosfiBoF7nRluwPCbUuNKHg4GPTw7j0PoEzPHcjKH+7l74gtUxzpNz8yRRDLEJ4z/BMxpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJcAuzQV; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJcAuzQV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787174174; x=1818710174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=znKp6FFW6e4vloCf/TZGsoTX7/wCAKLPkbIxWejDXZI=;
  b=OJcAuzQVCiid9WekaK6hBYfF1OCg2GB+rdWVQ+9gHsEewgCbsvB6B+Ie
   1Pl5L9ZqvuOF//ZUnT+94QCOLpwpHhakrCOmISK5vmZCTAMVh38RReCoY
   7VRatNx9r/y0IP4zjspNvxRpzgQR7DMeQmWaMc82c5v5Xurw/KmxdKT5A
   zI+i0vYEzcHJrUasYrvwd19J2zQX7R+reM7D9BC5Z0GDtmlZnCSWetPyu
   BiE73qr9MXOLEcpQ6AF26ZoreaULC9WnbPZH164+9g4DS7NvDAcVbB4vA
   GxpeOV0fPbwIR6VrSl3UNVUaTLL3hZS8OaTH4d8Y20QvsFkq+7qjTMZ3e
   w==;
X-CSE-ConnectionGUID: oO+GOlfBT+OGRtNQgDBhFw==
X-CSE-MsgGUID: dG9pjOGkTdm3GT0dmzPsIg==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99060878"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="99060878"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 14:16:12 -0700
X-CSE-ConnectionGUID: hfLa0FnjSjWDP00ZujihIw==
X-CSE-MsgGUID: vWx5l7aUSFyYCRFDUq4TpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="269179100"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 14:16:11 -0700
Message-ID: <5571c4ba-aa12-442a-aa2f-3b3e073e1305@intel.com>
Date: Wed, 19 Aug 2026 14:16:09 -0700
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/4] NTB: ntb_transport: Recycle TX entries before
 client callbacks
To: Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: ntb@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260817053519.4135287-1-den@valinux.co.jp>
 <20260817053519.4135287-2-den@valinux.co.jp>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260817053519.4135287-2-den@valinux.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/16/26 10:35 PM, Koichiro Den wrote:
> ntb_tx_copy_callback() invokes the client callback before returning the
> entry to tx_free_q. The callback may wake a stopped client queue, only
> for the next enqueue to find no local entry and return -EBUSY. The window
> is narrow, but the retry is unnecessary.
> 
> Save the callback data and length, then return the entry to tx_free_q
> before invoking the client. A completion callback then means both the
> client buffer and transport entry are ready for reuse.
> 
> Fixes: fce8a7bb5b4b ("PCI-Express Non-Transparent Bridge Support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Koichiro Den <den@valinux.co.jp>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/ntb/ntb_transport.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index f59f926d4bfa..e92b96f4afad 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c
> @@ -1719,9 +1719,16 @@ static void ntb_transport_rxc_db(unsigned long data)
>  static void ntb_tx_copy_callback(void *data,
>  				 const struct dmaengine_result *res)
>  {
> +	struct ntb_payload_header __iomem *hdr;
>  	struct ntb_queue_entry *entry = data;
> -	struct ntb_transport_qp *qp = entry->qp;
> -	struct ntb_payload_header __iomem *hdr = entry->tx_hdr;
> +	struct ntb_transport_qp *qp;
> +	unsigned int len;
> +	void *cb_data;
> +
> +	qp = entry->qp;
> +	hdr = entry->tx_hdr;
> +	cb_data = entry->cb_data;
> +	len = entry->len;
>  
>  	/* we need to check DMA results if we are using DMA */
>  	if (res) {
> @@ -1768,15 +1775,13 @@ static void ntb_tx_copy_callback(void *data,
>  	 * "link down" or similar.  Since no payload is being sent in these
>  	 * cases, there is nothing to add to the completion queue.
>  	 */
> -	if (entry->len > 0) {
> -		qp->tx_bytes += entry->len;
> -
> -		if (qp->tx_handler)
> -			qp->tx_handler(qp, qp->cb_data, entry->cb_data,
> -				       entry->len);
> -	}
> +	if (len > 0)
> +		qp->tx_bytes += len;
>  
>  	ntb_list_add(&qp->ntb_tx_free_q_lock, &entry->entry, &qp->tx_free_q);
> +
> +	if (len > 0 && qp->tx_handler)
> +		qp->tx_handler(qp, qp->cb_data, cb_data, len);
>  }
>  
>  static void ntb_memcpy_tx_on_stack(struct ntb_queue_entry *entry, void __iomem *offset)

