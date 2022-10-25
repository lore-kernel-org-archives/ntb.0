Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7DFB23AC
	for <ntb@lists.linux.dev>; Tue, 25 Oct 2022 14:22:04 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id b29so7520681pfp.13
        for <ntb@lists.linux.dev>; Tue, 25 Oct 2022 07:22:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vZVnPGsAheVchMmW+27sKWAExzhNFnjGwmynQxqPwGo=;
        b=ICUkuoioTTbT4J3PQNG+F2mm8o+HTAEkYCXtGoXB2o+mCQfo7DmlBXq9deAQi2YA0d
         DXO1h6CakTsqFcctttj6fLpfnlvnTCU+vbdOY2r7v6GpUAQchYPKU9hmtIauunE10RLa
         urTKrDuq7mYXhbP5CTE4YzU8j3SlzXpGnWLrlFzHk/sJ4mkKIaubrfsvc016XlPIL+MT
         KtlHDsb1hOofH3vZ0cEhh7FUuXRh/TllJxI4pXhtEcHn0OEuxxCS6UHZ+vzlVniYtvg4
         WQ74Ev0UEg5iRVT9eFFBJhkOmoUuRR+b83dOxu3w3AoKFoQlC6DRm2d/Usk8gRsb9Hip
         RxhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vZVnPGsAheVchMmW+27sKWAExzhNFnjGwmynQxqPwGo=;
        b=gbJ6CDTuseVwH1utl5JOc6IxoywqIlXIzOqtHK/+s3+CuHwlLgE52HIaTdI6ymE/Mh
         8NPvbXdgjC4N5HkbWZONVzoqECiU+8X+7CzVJOKxGv1IfNa0wuPZYWkWMqToqOczBqve
         fbCf0Lj4AVdZsnUPdUSoV3Se5eDVfw0KkPz8KQ5iDkVQnlN1bL0K2akic5qmdC8fkW4t
         9li163V0fhi5VuwbNI1hhrKyXSFDzCuCkmU5kB9u8SEeBYJDPZAOHXtJuFTaLtVr40qA
         x2yv4sowWbbFxBKprdYcPboHkAz+MRPFE0iT7pLAgiL7sbjiphFFo4Gsbv/Xe1ufHwS2
         OnXg==
X-Gm-Message-State: ACrzQf1yflZNANFjgbG4WTmlTUm7XbzahE/4m99qZJGJlnu7g55SmwGn
	AgJcwuHRVVxDq9uCGEIxHgRZVkXuTwPLX1cisQ==
X-Google-Smtp-Source: AMsMyM5y60S7QrNea7GsbgN5+3CO8qxmJZ5wOr77JsZm8qxHaKY9g3W64Y1U52K5AOMxzWE1dDdrdw==
X-Received: by 2002:a17:902:9684:b0:17e:71b2:bd16 with SMTP id n4-20020a170902968400b0017e71b2bd16mr38661973plp.163.1666707713299;
        Tue, 25 Oct 2022 07:21:53 -0700 (PDT)
Received: from thinkpad ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id r17-20020a63ce51000000b0041a6638b357sm1322578pgi.72.2022.10.25.07.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 07:21:52 -0700 (PDT)
Date: Tue, 25 Oct 2022 19:51:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Shunsuke Mie <mie@igel.co.jp>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, ntb@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-{,v}ntb: fix a check for no
 epc alignment constraint
Message-ID: <20221025142143.GA109941@thinkpad>
References: <20220922092357.123732-1-mie@igel.co.jp>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220922092357.123732-1-mie@igel.co.jp>

On Thu, Sep 22, 2022 at 06:23:57PM +0900, Shunsuke Mie wrote:
> Some PCI endpoint controllers have no alignment constraints, and the
> epc_features->align becomes 0. In this case, IS_ALIGNED() in
> epf_ntb_config_spad_bar_alloc() doesn't work well. Check for this before
> IS_ALIGNED().
> 
> Signed-off-by: Shunsuke Mie <mie@igel.co.jp>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v2:
> * Fix the commit message in phrasings and words.
> ---
> ---
>  drivers/pci/endpoint/functions/pci-epf-ntb.c  | 2 +-
>  drivers/pci/endpoint/functions/pci-epf-vntb.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> index 9a00448c7e61..f74155ee8d72 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
> @@ -1021,7 +1021,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb,
>  	peer_size = peer_epc_features->bar_fixed_size[peer_barno];
>  
>  	/* Check if epc_features is populated incorrectly */
> -	if ((!IS_ALIGNED(size, align)))
> +	if (align && (!IS_ALIGNED(size, align)))
>  		return -EINVAL;
>  
>  	spad_count = ntb->spad_count;
> diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> index 0ea85e1d292e..5e346c0a0f05 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
> @@ -418,7 +418,7 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
>  	size = epc_features->bar_fixed_size[barno];
>  	align = epc_features->align;
>  
> -	if ((!IS_ALIGNED(size, align)))
> +	if (align && !IS_ALIGNED(size, align))
>  		return -EINVAL;
>  
>  	spad_count = ntb->spad_count;
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்
