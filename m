Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324FC16D9B6
	for <ntb@lists.linux.dev>; Mon,  1 Jul 2024 20:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719866072; cv=none; b=MaAN83I54hhnT2JThxVwCFsIBEiPPJ3Itlwl55wSZT6/+NJfrb2M9pI9QPvsHfi4HdyLF3EJ1A3+Z86U0PhQxpI7QzSNL3DcS/w2EBOPQL5EV4yCIkUj2bXP8Sa3XSc5md/XsXdWXNoYMKyMCzukGWdQgLoT2Tn3oEimjxisa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719866072; c=relaxed/simple;
	bh=Wo6jYVKWt1XsfvW2kocRWwhdmJB1ArOA1W+ONgrcPUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeeTpVpQJILQUzP8XTq2bj4s3TzkB1JvVEK2tV5f5TRQfKECpXl0W35j7W6V+nx6Ao86LmhMck87rKc7Gcjqk+2HqUGMh5AOohZVbEfJR5ycEK6n5YtHcAUGs5gZEnDFfMmevC4roNwNlYV+cCsxeYqXiQxN6DK3qJQuc2JMEsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c81ce83715so2540678a91.3
        for <ntb@lists.linux.dev>; Mon, 01 Jul 2024 13:34:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719866070; x=1720470870;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gt/VCLG0XE9tYQ4KowekIVt6Vm28X9Pkg8zs7uMqPhA=;
        b=Z+T8GBJdKAozyyWdC98YIz8tOAG+jFFiACzR+bl9zRZiYqxnwjRDNJ0RaMhhZZXJKT
         xp6KR4ROBc8VIY2Z7RIPpoLspRMucuVVbp+vvTiIRf98saX3iaBF0sHSdqb8eH4T9QlL
         /VJevVlzgwQPX+AOI/pUvtSh7h3svgs84T4RyxRosK70+FH3R0YDscIsLwPtcFTALn8M
         RhK+ifDWlONmo7CnefIMxkSz/SrW64SKrupOvLEJ8F+4HufFulCe+fiYqXQfYynko6sb
         w01i7LABvjm9RkvBIDWx5HpXceSCIU5sQzVyuxhXkZ7hBD9rNIDJT6GRI0cNrCHs3D+U
         1ISQ==
X-Forwarded-Encrypted: i=1; AJvYcCUyDn4Jm0mcIYqhlmwdAOXuHoS5qyrlspPBcDOa3RWAAHwHb2rISixHmGya90eAjYpVtarfObZViRMuu5brpeDcR5pR
X-Gm-Message-State: AOJu0YxejAdroQtkNVxrnp9Ldv1FHnkCB2PXJlvgfFgYl+FRYI9fF12L
	Ex0fVvxBqhAfdJ3E/nZU465376O164PRVHWeKWhvZwqFpsJ5gAAL
X-Google-Smtp-Source: AGHT+IH37dM54+qflq0oEXeW4Muag9hwYXpu9YtpKLmCGG+T0D5FT3KmTqCArx3LOlD6TcYfx9xJMw==
X-Received: by 2002:a17:90a:d70b:b0:2c2:d8d7:bf65 with SMTP id 98e67ed59e1d1-2c93d6d72famr5079101a91.7.1719866070429;
        Mon, 01 Jul 2024 13:34:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91ce425bdsm7306981a91.14.2024.07.01.13.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 13:34:30 -0700 (PDT)
Date: Tue, 2 Jul 2024 05:34:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Frank Li <Frank.Li@nxp.com>, Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: endpoint: fix a couple error handling bugs
Message-ID: <20240701203428.GA412915@rocinante>
References: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6eacdf8e-bb07-4e01-8726-c53a9a508945@moroto.mountain>

Hello,

> Two small error error handling and cleanup patches.  The first one fixes
> an incorrect error message printed on success.  The other one fixes some
> cleanup.  Which is probably not required because PCI code is generally
> required for a functioning system...

Applied to endpoint, thank you!

[01/02] PCI: endpoint: Clean up error handling in vpci_scan_bus()
        https://git.kernel.org/pci/pci/c/72705e5b5957

[02/02] PCI: endpoint: Fix error handling in epf_ntb_epc_cleanup()
        https://git.kernel.org/pci/pci/c/05214340e133

	Krzysztof
