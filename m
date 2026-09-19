Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183D635C1A0
	for <ntb@lists.linux.dev>; Sat, 19 Sep 2026 01:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780494; cv=none; b=TrfUJstcilzjh9PdBYJA0KJuk/ybaEHkJe9C0sWXSgoOu03FAQxRw+vXsKeP8REUYpd2RuR79yP4L2nchCiqpbEI61Bp7BK41rILEOe5zn6Peuut5eQS39cA701un/SjEpKo9ewy7ydEYbotrfLLsHFlsbusFhKvUg2dNbCvVCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780494; c=relaxed/simple;
	bh=tVD6I32X9o09LnLSiCTDoJRb9N9XzkPtf1rrJepbfPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mDFDNuuo6wp1b6PjfDZFlEw7zkOCxUwBwLseWP9OIwg0ue2ixLYvaaqJ7sMEUIIdXYpqZKzNVoQ9+w2H4PwsZiUicz//kATi/NSm8luC4/M79wm47O9k/2yNjrTs79N8OObPPOBaGHtzxfRHJqOj0kKtwK4TUuPQjbQn3N6L8aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=pmiwLbGz; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="pmiwLbGz"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b9184fa80so1323273a91.2
        for <ntb@lists.linux.dev>; Fri, 18 Sep 2026 18:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1789780477; x=1790385277; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ICHHulJUCBRD5f9GaFqjX1G74LjOBZZCUQAyH59jdAQ=;
        b=pmiwLbGz0EivcoZRx2qhBS7T8G8pG4bINUy3qXb+VyJ1DkzWEuaLqaF7AFS6nzZQco
         Dxlyb5jBdgTeP4TPooNWAH1FcNBb978LrUr4SnQ0l37lz1oG3vYl5y0m1F5JqEyVq93K
         3YeakuW8WwAWDpUKbs35xDQnHWFXMoxbfqjWJq1fICcvyZfqkYwnGNmWUqYkXeJ1trwo
         v9kyQ0fVBvsLvNjfrbplLxEWhDANj/i5wr3k7KjdwuqIy8OXgSlYTOsaeoEv3lrbtHRZ
         gkHf9LGBGTuKsrwSmSDNLs+8g49xMFEaqWCCAlkeMu+AR++Zap5yINssznBWa22teCAe
         Z2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789780477; x=1790385277;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ICHHulJUCBRD5f9GaFqjX1G74LjOBZZCUQAyH59jdAQ=;
        b=mrDO+Jh7inRTrbn+O9r6gLwOjxSh8TYElOgFcPWGQYZwzMqvdLYROsiGSzHeWt+R18
         pHDoWPpSeVY8ZNMM2RzpHw+lU4EiHO60DiXbdKwhoYZ7T67t+v2/u1p7dpOHojO7V+sy
         xO+XeX4b0eGfwOqa9XyghplZ4+DFq4t8zKa2hgNKPqVRAYiGAEGbSk/9OMUEUPKwicRg
         rZYsD8hHvrLtXZKUNdamlS0beCkq55CRs/l6hC1vO8G8IsCGGnQY1lyxOiUSrxKxVJGe
         V1n4/a13yrrxCy1ihS3gWIqd+WZ2rgebvRfqmV97a8ZoK3++QCTx9RdD/j53KPqOW9m8
         2bLQ==
X-Forwarded-Encrypted: i=1; AKwUvBzlunD8Bs7xZDW9ZFMJOqhLJhI1Iea9/Ol0QgGx2s88NY9iG9YfAr2VaupddqMZ5PQwlKU=@lists.linux.dev
X-Gm-Message-State: AFuF++lrZBjpFHZwUsyYEVD7IGKC92qCTxM2R0CNV2qgHuMtC/sI3yPA
	Tw23sLS11bgluqqD60Xl95G3qQTVuyyOuoEeGF+q3VheM0wJ+AMMRyDamup/zTwL9Bg=
X-Gm-Gg: AYBFou1BNjzL5m7EZlDYpK0nn6mui+iUsyu23eSv0+F5oNRPgG56qVGTuQNPoYhn0O9
	51NuaJY9YNhEVaWXx3D1lql9EiOFbvD9m/OvZZG92YkI14ET56881u2U8d5YlUIaUo/5v0H++Nj
	En5RLkySZ2XI3GErK//TtirM48xKFmBegCO4JwZoTVZ/4eKnig2eJ7vZNP6qlGO+nzHuoOV63vw
	3YIk91BC2AXVyfR5+7gnd+/+vhwE6XWbwruZQLTKxb/QNVPRWY80qgDkBUcX9kAMufEw6NG9cCO
	mDqHqfBaF+WwUgE4w/YS9nByXjOdOlz0jQI632dVRHFuA8z20xYikjgDkwLf/E89pPxmLIxf3IH
	U/oyiaUPQgkkimUrdThFehMZSM8uibN9JdW8rqh+mfx9OwmHJ8w+GP+NxcCcDKlhpVLs+NDDIRu
	2wr1EAA0i/2h5cv8d2h+s6MyTahjLojZxSCFYZ/9UD9LtAt9FkONA+
X-Received: by 2002:a17:90b:2dc3:b0:39d:e9b6:cec9 with SMTP id 98e67ed59e1d1-39e54d36756mr14388646a91.7.1789780476843;
        Fri, 18 Sep 2026 18:14:36 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:58::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e55f124d5sm2722789a91.4.2026.09.18.18.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 18:14:36 -0700 (PDT)
Date: Fri, 18 Sep 2026 18:14:34 -0700
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
Subject: Re: [PATCH net-next v4 07/10] net: ntb_netdev: Reject short RX frames
Message-ID: <aq3h+iaPkvy7n4Wg@devvm20253.cco0.facebook.com>
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
 <20260914084838.2158249-8-den@valinux.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914084838.2158249-8-den@valinux.co.jp>

On Mon, Sep 14, 2026 at 05:48:35PM +0900, Koichiro Den wrote:
> ntb_netdev passes RX frames shorter than ETH_HLEN to eth_type_trans(),
> which expects a complete Ethernet header.
> 
> Reject them as length errors.
> 
> Fixes: 548c237c0a99 ("net: Add support for NTB virtual ethernet device")
> Signed-off-by: Koichiro Den <den@valinux.co.jp>
> ---
> Changes in v4:
>   - New patch. Included here to fix the existing RX length check before
>     adding checks for ntb_netdev_hdr later in the series.
> 
>  drivers/net/ntb_netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
