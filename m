Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0920E8
	for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 14:08:31 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3090d3e9c92so2153915f8f.2
        for <ntb@lists.linux.dev>; Fri, 14 Jul 2023 07:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689343710; x=1691935710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CCTxlwbQxhJI8AjrVEOUZWY0xdsbdlM7lzLUFvpZaOw=;
        b=Epxzr3XL5e4l4EW5F1qcJuGwFaWaAKMyUrJ6o8b9279TiYT1DPkVw9n9VyrGKX81VP
         4NMMaNt9bNTbaumv8RDjF4SPxWB2+OVYzGd+RorQnp4PSz0JVqwBsWY3ZvjV1c2+e319
         wLcI3SUl86ka89+CZQup0ABsPjOAO3BJRaRldRraShuo9NTqY8nBZ/ZBHaRF7+z1INi6
         wq20yT1l0CJRZ4zpVx8A6mE5Cuyo8AIK6EkYe+HlsLcefR5mfxjdPBn8R6+/HFAl+9O9
         KaD9e7obgvyO8cfpJfNwZuHuaXeyPCsbPQUvAVrDq6g3PnESr2GoKBe0pqt233Ed2LLT
         wIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689343710; x=1691935710;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CCTxlwbQxhJI8AjrVEOUZWY0xdsbdlM7lzLUFvpZaOw=;
        b=G8iKs4/0zI1KOAfxqmJ8mJvVyLm4H1hEAfk2Wd1ir+idbf9khNDDNRQHqp/IHdo+R7
         li215+aEsvyeXnU8ye5IwgmP/sQisg23n2zRfsn1MpflWJOBDXtu/kWCy9mRVICw57dA
         EZlGhYcT3jsg9QiDGHSjAjIaok/vaLU3fsqOuRyjylD/o+lCRn5ina6FGpzGVVUu//7N
         0pJ6FGhdVj5lBhT+JoZ/v1qVqPOAvr/2TwjW8lR2r3aIDRPA450yKetPHiXTHUVFPT5H
         TFvxj4V9hOxpb/aDxT0ooCuqIta/WaQ3b8brQlbtikPl7KLF9pl56z2n7g+AVpC8wZ2H
         Ieaw==
X-Gm-Message-State: ABy/qLabnNIbpU6IpR0l9VXtMECxjOdUoXdtcjHqt3y3RTdlYrXnFBVc
	NcAy2uEvxgNtlbE3rB/KY336Cw==
X-Google-Smtp-Source: APBJJlEpU6teBRxalbQaxqFA5Wcp9eZRMT6nz+si2nYovlnOj8Uco3YCmrFRlWeYn7N8iuMrMlbkbQ==
X-Received: by 2002:adf:f106:0:b0:316:efb9:101d with SMTP id r6-20020adff106000000b00316efb9101dmr1848531wro.25.1689343709864;
        Fri, 14 Jul 2023 07:08:29 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id s14-20020adfea8e000000b00301a351a8d6sm11057698wrm.84.2023.07.14.07.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 07:08:27 -0700 (PDT)
Date: Fri, 14 Jul 2023 17:08:24 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Serge Semin <fancer.lancer@gmail.com>, Wang Ming <machel@vivo.com>,
	opensource.kernel@vivo.com, kernel-janitors@vger.kernel.org,
	ntb@lists.linux.dev, Allen Hubbe <allenbh@gmail.com>,
	Dan Carpenter <error27@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Jiasheng Jiang <jiasheng@iscas.ac.cn>, Jon Mason <jdmason@kudzu.us>,
	LKML <linux-kernel@vger.kernel.org>, Minjie Du <duminjie@vivo.com>
Subject: Re: [PATCH v3] ntb: Remove error checking for debugfs_create_dir()
Message-ID: <5d0cd0e0-d92e-42d3-a6d9-ec9fc3229b7b@kadam.mountain>
References: <ag2uziaj2mbsqryo6ss25w5s3ryenshoylraejtgp46gxce6hh@qcggqjnqheb5>
 <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5139e22-cf5e-e95c-fd33-7e1b9b4d665b@web.de>

On Fri, Jul 14, 2023 at 02:44:11PM +0200, Markus Elfring wrote:
> > > It is expected that most callers should _ignore_ the errors
> > > return by debugfs_create_dir() in tool_setup_dbgfs()
> …
> > The patch itself is correct for sure:
> > Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
> 
> How does such information fit to the Linux development requirement
> for imperative change descriptions?
> 

Markus, you already replied to this thread.

Greg, HCH, Matthew Wilcox and Krzysztof Kozlowski have all asked you to
stop.  Those are respected kernel maintainers.  You should listen to
them.

If you see a bug, that's useful.  But if you're just nitpicking the
commit message, that's not useful.  We have explained this many times as
clearly as we know how.

> See also:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.5-rc1#n94
> 
> 
> How do you think about to add the tag “Fixes” because of the deletion
> of an inappropriate error detection?

No.  It's not a bug fix so a Fixes tag is innappropriate.

regards,
dan carpenter

