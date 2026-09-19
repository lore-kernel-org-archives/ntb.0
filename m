Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8E9A366051
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 00:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779281; cv=none; b=fTtQXLw35uIZB2/edziukEbDToRQxOBPwnVkvMzccbwhBvFREzs1lAQWeq/xSOQq2kndZcg3k4r6JdrV6/oWyQ9aaKXeiEON/7IbvH9HrGCiyBh5HfV/6VpumeWHh3Wa61ms1NQER6x4etLOQh4l5p4AGXkJg5fgMGp7ZVIkMsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779281; c=relaxed/simple;
	bh=QOhBEfG4yrhp+FTxVrBTMzSlWRARVPYUlGxnIlFF3kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VAomg6ckhDVVxdZbcb6SSAwMCem3x9Hfq03UkVzkpPFuHRZOW+yoBLPuLEqqrterRdJdO9mflAnGIqHmP4WWMXDsgcmPTbYODcdQR40qD3VU8X8y4fh0BdMp6b/kOhU434DWTGkDZZAVjCuUzqOX0gZKF3foFB5mLNEPmAkDvCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=qDiih7Ly; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="qDiih7Ly"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4bdf8abaaso1067484a12.2
        for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 17:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789779276; x=1790384076; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aS8vpLbCC+UV4B+QKFVqLQosffbfcP7BnnH9D7Kwu74=;
        b=qDiih7LyxG3nH8M1rUS+liNFBDz7bCrZBwDkRP7NcJHtyh+8LEhnor7A1V2a8ql+VS
         sUzUsGYJHceCaoRdecX2AD14zzDyx+chSHUMDTHFO7XkvEkzyUmfPDjZDkfmmxruXDsD
         dJnPj1k+yiqLW978LOeqO8gEZIP5pSyiYJZmJnl3S5BPcx8dRrDCXfX/CoQtuekfz0ML
         kg+wRxmwd/pYwP6fyUS2UlMgL4rRByRXo6TP0z0D6bdB01hYYqNHdGOqAzMamq0vcrUg
         cN20Wgmb5WIbAS0fp3pnvx+QDe21R15OhjTdOMYy4ZJzq3/zKArDY4ROiHOb1R3AO2s1
         8gYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789779276; x=1790384076;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aS8vpLbCC+UV4B+QKFVqLQosffbfcP7BnnH9D7Kwu74=;
        b=IEDkZYR93xhnLgh6UL/3sWwNGc9xjl7Kok0/87oJ1Cqg0wSRB2V3zwmUC3LZNVSwY8
         ltMhSDdHUyVrXxqzD85+PPRjmkQSmbLHqhup++B23ydmr7RoNROhUNjapFyyi4OQEoKG
         p4MxDWggdFa8L0vZM1CfBlwTv1BQDmxYD+Uyc8ZlR6x304dd4cdogRY51S0kjXSwxQRY
         xWivsozAJdcug2/7zjznVS01cU8nwZ26VnsrEOZVfYFv3M3Ff62Bu9nWlTeRHepL2hHH
         zhDo+pv6IQBGIn/crHOIQmIblOzPg5umvnLTqLm8wSERxQa8TphXGquqDdpite0X4UGN
         nVOg==
X-Forwarded-Encrypted: i=1; AKwUvBwdBhznMxDXk2KeO7DhE07ZaTQMsZgP9R22rTORivNMwf+AYsZuGm10sTj3wLbFitLtsc8=@lists.linux.dev
X-Gm-Message-State: AFuF++l+i6tRPUq63aU0CuJ+cnx1LSNEC0PncYtszFVlZVgnGCfyH9eI
	VFBDC4JLR06qLWH6FC9r2YvOpWkocrT3oM4kyOBaFvOR+doblsr49EoNfHJvnRC0joY=
X-Gm-Gg: AYBFou38USm5ln2ikIhzI6BB8LHBkOpnos8BdXkSZBe1EQ4t4NZEQWpvQ0FSrYTPtUr
	uwJv5OBHuj4MThXnWbzrIbxGsy9Ib+LhmWXKYY/i6dkw2PFTzDDkZ4BDrf5YzX/adECS9leV1Bp
	6JzY1VIcjkc4aHL1MP8C1WNi9LDr6/cDtnUv0FIeMfvOPyv2ZWnPNEDpp1Uz+vrfBMHIGz4Mwc7
	5u2vjx0rU324mXd82k14zrgZZbBbFHPuBDH6dRsG6Gk/pULlm29zRmCiB8aJHUgwvlS76uyAB/1
	DWNL7DzhxPeVQHMSysO00gLzH9k8iHImvYUWM2N7oOaqmqnX8OHzmDealiq9FRCBAkWUk/4e/XC
	DZtQ1XiEDCGU3A/OC710R5HrS/haMDUXntAMgdpbetBwc8iOTslzp/Enkorj3yKakiwhTFkC9ja
	0S6fEJyISTgSc3OT+uWxw73RouAc+VeO4LpIksTdwJvu3qhhawnN+b
X-Received: by 2002:a17:90a:c089:b0:39e:6c68:c78c with SMTP id 98e67ed59e1d1-39e6c68ca3bmr1516708a91.66.1789779276128;
        Fri, 18 Sep 2026 17:54:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c5b3932sm1706421a91.13.2026.09.18.17.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 17:54:35 -0700 (PDT)
Date: Fri, 18 Sep 2026 17:54:34 -0700
From: Joe Damato <joe@dama.to>
To: Koichiro Den <den@valinux.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4 02/10] NTB: ntb_transport: Use little-endian
 shared fields
Message-ID: <aq3dSqE2euoxQeQr@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Koichiro Den <den@valinux.co.jp>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	ntb@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20260914084838.2158249-1-den@valinux.co.jp>
 <20260914084838.2158249-3-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-3-den@valinux.co.jp>

On Mon, Sep 14, 2026 at 05:48:30PM +0900, Koichiro Den wrote:
> ntb_transport writes payload headers and the RX ring tail with
> iowrite32(), but reads peer-written copies from coherent memory as native
> integers. The values are therefore byte-swapped when read on a big-endian
> system.
> 
> Mark the shared fields as __le32 and convert coherent-memory accesses
> accordingly. Read hdr->ver and hdr->len once so their checks and later
> uses see the same values.
> 
> Fixes: 74465645cdb4 ("NTB: Fix Sparse Warnings")
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://lore.kernel.org/r/20260815032932.151F11F000E9@smtp.kernel.org/
> Link: https://lore.kernel.org/r/20260818064951.7EA231F000E9@smtp.kernel.org/
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - No changes.
> 
>  drivers/ntb/ntb_transport.c | 47 +++++++++++++++++++++----------------
>  1 file changed, 27 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 74f4f8c1c7be..3f497a62673f 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[...]

> @@ -514,7 +514,8 @@ static int ntb_qp_debugfs_stats_show(struct seq_file *s, void *v)
>  	seq_printf(s, "tx_err_no_buf - %llu\n", qp->tx_err_no_buf);
>  	seq_printf(s, "tx_mw - \t0x%p\n", qp->tx_mw);
>  	seq_printf(s, "tx_index (H) - \t%u\n", qp->tx_index);
> -	seq_printf(s, "RRI (T) - \t%u\n", qp->remote_rx_info->entry);
> +	seq_printf(s, "RRI (T) - \t%u\n",
> +		   le32_to_cpu(qp->remote_rx_info->entry));

it looks like the code READ_ONCE's this field below.... is that needed here
too?


>  	seq_printf(s, "tx_max_entry - \t%u\n", qp->tx_max_entry);
>  	seq_printf(s, "free tx - \t%u\n", ntb_transport_tx_free_entry(qp));
>  	seq_putc(s, '\n');
> @@ -633,7 +634,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
>  		qp->rx_alloc_entry++;
>  	}
>  
> -	qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> +	qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);

you read_once below, do you need a write_once too ?

i wonder if the read_once / write_once with endian conversion can be wrapped
up in a helper or something to simplify? not sure, it might introduce more
code than really necessary.

>  	/* setup the hdr offsets with 0's */
>  	for (i = 0; i < qp->rx_max_entry; i++) {
> @@ -919,7 +920,7 @@ static void ntb_qp_link_down_reset(struct ntb_transport_qp *qp)
>  {
>  	ntb_qp_link_context_reset(qp);
>  	if (qp->remote_rx_info)
> -		qp->remote_rx_info->entry = qp->rx_max_entry - 1;
> +		qp->remote_rx_info->entry = cpu_to_le32(qp->rx_max_entry - 1);

same as above with the onces ?

>  }
>  
>  static void ntb_qp_link_cleanup(struct ntb_transport_qp *qp)
> @@ -1445,7 +1446,7 @@ static void ntb_complete_rxc(struct ntb_transport_qp *qp)
>  		if (!(entry->flags & DESC_DONE_FLAG))
>  			break;
>  
> -		entry->rx_hdr->flags = 0;
> +		entry->rx_hdr->flags = cpu_to_le32(0);

this looked weird to me but grep says this is a common idiom, so TIL
cpu_to_le32(0) is a thing.

[...]

> @@ -2490,7 +2495,9 @@ EXPORT_SYMBOL_GPL(ntb_transport_max_size);
>  unsigned int ntb_transport_tx_free_entry(struct ntb_transport_qp *qp)
>  {
>  	unsigned int head = qp->tx_index;
> -	unsigned int tail = qp->remote_rx_info->entry;
> +	unsigned int tail;
> +
> +	tail = le32_to_cpu(READ_ONCE(qp->remote_rx_info->entry));

see above re: read_once and write_once on this field...

i didn't really try prototyping anything but seeing this repeated pattern
makes me wonder if

static inline u32 ntb_remote_rx_entry(blah)
{
  return le32_to_cpu(READ_ONCE(....));
}

would make the code clearer ... or less clear. not sure.
