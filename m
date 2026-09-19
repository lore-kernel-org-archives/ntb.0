Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50373537C7
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 01:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780246; cv=none; b=bCvnKGpJQJFv5d7Kj3PfHTXbJVCk81kRlKc0gGz/PdgoQDqNZ9CdAZ/DLVYw5p4pbjcPwAk2l7oU9jZWYRfHm+0mf4VjjdsAZOw8QzLPiB+JSrvIZKBJ6zTbOdF0k9h+2L9c6yrboNzQoRVxdK5auB027hsi6MkrcsHvWn7o+2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780246; c=relaxed/simple;
	bh=PD17Y3XeERkph6rr6sHZAKy4DsdPrdxQEx/QDmuRqzo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLoSed2GwcHMGYq4lI26Hyf6qtX7DmYIAPKjKBxelpH1IaqAL+XVsT3HebUYwj2feRGzAgxaJCLfFtz8ZVNelkpZu1IZPGGhS8FcOFz9bpxFTyzDV1gj2qj8exiWxDLhXdEF2mJPpc08MGJ6KVOzcGBXYWp/QTqgkCAuw5URoEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=ul/JGRnu; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="ul/JGRnu"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d747ec6188so8613435ad.3
        for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 18:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789780241; x=1790385041; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=a49yaJ/GGjwIg6ibC7aTwVaBRLcdBDhKbI1sakT8d8k=;
        b=ul/JGRnuQOkfqRBOKBIFxNEQTngUO0pMyN042YZfFZcplChZa/tgnx/A0U1exyEGZR
         sqywCW4OAsJ2iRz1MmNYyQjExXgg1nbHATOwl0ZicyrOefshyfwG7oEfg888RB/eDcRe
         jxJEUeXlApmBsYEbpo0I4zb2Am8heR7jNcgcYQCd62gsXf50wevJNKXAOb3hYJXP4R2R
         6RkOjIw3e7DmqcjOJ98V2GnfV1Z5CmzBqdQfOpfwn+OrD9vIHsj8aX0Wqh/bExDo9HNd
         Pi7bdht0K6SLiM5hMSFvPMgW5TYTpnWVJrMqBwCeqOr2z0D+Pz9jNS65uEUDrRroLIvq
         jCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789780241; x=1790385041;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=a49yaJ/GGjwIg6ibC7aTwVaBRLcdBDhKbI1sakT8d8k=;
        b=aPm1UIWw3mAl6Kjm6lPXPjluRhCtIeO9sYRDRCSwYT+ht/LJsWzbAvQ5NsMXHGEiHJ
         PoIyPOhYvzETK4VEkUBCmTOBLFOQEz6n4ToufLzn9SFKu74OrX94IlT7sWMgXFvVQRyB
         i/CEqUBLKexTs4Ob7ymdQ4yVsdZlABtVe63lKQ4cgW9N6ivP/Zod/8zTV+zPL90tWHsj
         B1vJWW+Gb1lpEONRJoF7fzDJQFk2txy1dQwpjQGUGbHt8OJ/n7VCSxG/auTfKQ+7sTwR
         co8eNKRU3AFjFK/iauKEkCHcSuXrWRdn9TucDo9zVvuYdem+39Utweg27csDzpq2Pztn
         SwXw==
X-Forwarded-Encrypted: i=1; AKwUvByvhLsl6N+PqIfSvhY0qAV+veoKYpLULZnFolIbUWHXLyptPGejsxJdc/FJPWPCVWJ2KEY=@lists.linux.dev
X-Gm-Message-State: AFuF++lzKFbFNcsmdJXllF9Hou7sEom1z2f7AmmMkiapdNqOhH0muOPs
	dw7L61r3rU1kHHe3yul7EReUtibOUNH8Gq55lfKI62Y605tzze0jd4mvDRlxZ/1dnXY=
X-Gm-Gg: AYBFou2Q6+wHm8QGPlepf8Fdsx92dnf+OZ+Vpz5JoNsKWnC5qV8cHc7Nc9ua4I53+t2
	ziUpqzh9LTwc9txGT0iCRBWV+fR8caQ/CFPlCURRIbvRT4BHyIrGJu2d8klyw5w5UqzTDIGPQiR
	P65YUYeFCj+6ir1l2EjBPudlPKpx8BvTputibNUIp7gyBL0Zd2mpVdIXLbYehF26BEHwqyUrYY+
	QF4O5XVYVAPspxr03O4jWVilj090zLChOjiwN8tM7BOUY9Ik2ViGzqn/J8CFNLe7nAfqDQcJybs
	CvpMkJNq0Z+60mYXEXfFeugms0EPXc9BbPtPdWQjhtVHYDm8BXfz94B2xIyyIX7sQccuq+gGL4N
	tKpxFNIHNSap5J/ePe+VI26UoOgGDU5Y7LYCJKQT7heOQ4RrJCCk5oEOoDjUHr47kK+m6yiSdMK
	G3wP8R+LBxtMOzmOq+VzA0+T9B1pDTNnVm+Jh3yCgORgeu+wTPc6r2
X-Received: by 2002:a17:90b:57d0:b0:39e:6c69:f470 with SMTP id 98e67ed59e1d1-39e6c69f4d2mr1917003a91.47.1789780240973;
        Fri, 18 Sep 2026 18:10:40 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:40::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm1680612a91.0.2026.09.18.18.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:10:40 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:10:39 -0700
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
Subject: Re: [PATCH net-next v4 03/10] NTB: ntb_transport: Order RX entry
 completion
Message-ID: <aq3hD4D+VfMUd7vq@devvm20253.cco0.facebook.com>
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
 <20260914084838.2158249-4-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-4-den@valinux.co.jp>

On Mon, Sep 14, 2026 at 05:48:31PM +0900, Koichiro Den wrote:
> RX entries are added to rx_post_q before their fields are filled in.
> The overflow path sets DONE without a write barrier, and
> ntb_complete_rxc() has no read barrier after checking DONE. A concurrent
> completion can therefore consume stale entry fields.
> 
> Publish DONE with release ordering and check it with acquire ordering in
> ntb_complete_rxc(). Use the same publication rule in the copy callback.
> 
> Fixes: da2e5ae56164 ("NTB: Fix ntb_transport out-of-order RX update")
> Cc: stable@vger.kernel.org
> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904052134.2970111-1-den%40valinux.co.jp?part=3
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - New patch (Sashiko)
> 
>  drivers/ntb/ntb_transport.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
> index 3f497a62673f..b69e8ac8047d 100644
> --- a/drivers/ntb/ntb_transport.c
> +++ b/drivers/ntb/ntb_transport.c

[...]

> -	entry->flags |= DESC_DONE_FLAG;
> +	/* Pair with the acquire load in ntb_complete_rxc(). */
> +	smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
                                          ^^^^^^^^^^^


>  
>  	ntb_complete_rxc(entry->qp);
>  }
> @@ -1664,7 +1666,8 @@ static int ntb_process_rxc(struct ntb_transport_qp *qp)
>  		qp->rx_err_oflow++;
>  
>  		entry->len = -EIO;
> -		entry->flags |= DESC_DONE_FLAG;
> +		/* Pair with the acquire load in ntb_complete_rxc(). */
> +		smp_store_release(&entry->flags, entry->flags | DESC_DONE_FLAG);
                                                 ^^^^^^^^^^^^

are these two smp_store_release lines right? i am asking because it looks like
they do a load ? i honestly have no idea if there is a race here but it looks
sus to me
