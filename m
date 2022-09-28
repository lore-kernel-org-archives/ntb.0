Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05FFD7B
	for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 11:00:39 +0000 (UTC)
Received: by mail-lf1-f51.google.com with SMTP id bu25so17903210lfb.3
        for <ntb@lists.linux.dev>; Wed, 28 Sep 2022 04:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=OcX91QSmfcORtUJuhjxsYlI4jDkm84+aPMTKqsh2mFg=;
        b=B22A+5wg/gpUg3toqo4rJeKFnUzSSnLoGxNGs8VRO3g0wdmQbtK6mgG/i3q14yO2vo
         gQKY919BK1PBejNcNheYfn98WzgaSHM15ncLgQfaiSv2DhBcSYTHuRUVylsKvh8oVAxq
         bAr9bG39yRRyRQIQG8hcT29xbgJhsghWNtUnP6zh6Nh2y3Y6R23E2SKY3OnbiNrlV9Hv
         vBzjNHfwCIT+m791PM9xrvBJbhxLMcthuomHcNynvO/4FmtiwC+48v2C+CtK/9rKShPn
         uZFVYF2G1sUIX2kXFCxThLI5i9YqGPzJtxXnhlK+hNJPnXFPNX51P8567jqadv01p1Cm
         ahoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=OcX91QSmfcORtUJuhjxsYlI4jDkm84+aPMTKqsh2mFg=;
        b=pzKBFNGFkJK9YxMZDhKTkZXiz50SC9OfOUd2QTlWq5niAMvghxYlwJRd4/Dq3Sbsgv
         0gLtB6wxKjh4MlCoBCTQU4qUQNuENtlSMhrV7IbV8MKBOzEctMmGk6FeNFzcHS3jnIrl
         e2oCP5I1a8uDab6pDz4AFXHF8gu3MHn2OD+sOPh1YejxlZMBGrGMYpRuz6eTqutmwPKV
         isfETFetjhGkUPrehG67ao3FByb8wWoobLXnixoqzoOgdwVPnvO2ahtolYUPQZqymrKc
         0wvvU/GNlmvt6Lh2iw758kCtxRKC64njOuFKJPPxuBCooZtANm70PoZx41ZTazIduzCs
         2N6A==
X-Gm-Message-State: ACrzQf2AUmwdSxc5PB3cjoFrDi/1btL2tyYaF3Q47B/8Ako4S/6NGtTf
	TptBf0ix/mzC2fzRmtQ4WL4=
X-Google-Smtp-Source: AMsMyM7JGXbsNz0x5dE7UU8ItndkkQoelLZGntJ1miWPln8EohyuyG9V5ZZNjSRdJrKF5P6xSXVViQ==
X-Received: by 2002:a05:6512:12c8:b0:49b:8005:1d9d with SMTP id p8-20020a05651212c800b0049b80051d9dmr13713891lfg.489.1664362838099;
        Wed, 28 Sep 2022 04:00:38 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id z18-20020a19f712000000b00494a11c5f52sm442697lfe.256.2022.09.28.04.00.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 04:00:37 -0700 (PDT)
Date: Wed, 28 Sep 2022 14:00:35 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Zhuo Chen <chenzhuo.1@bytedance.com>
Cc: bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
	jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	james.smart@broadcom.com, dick.kennedy@broadcom.com,
	jejb@linux.ibm.com, martin.petersen@oracle.com,
	linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
	linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2 3/9] NTB: Change to use
 pci_aer_clear_uncorrect_error_status()
Message-ID: <20220928110035.ehbdxvpzkitbomoe@mobilestation>
References: <20220927153524.49172-1-chenzhuo.1@bytedance.com>
 <20220927153524.49172-4-chenzhuo.1@bytedance.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220927153524.49172-4-chenzhuo.1@bytedance.com>

On Tue, Sep 27, 2022 at 11:35:18PM +0800, Zhuo Chen wrote:
> Status bits for ERR_NONFATAL errors only are cleared in
> pci_aer_clear_nonfatal_status(), but we want clear uncorrectable
> error status in idt_init_pci(), so we change to use
> pci_aer_clear_uncorrect_error_status().

Have the modification changed since:
https://lore.kernel.org/linux-pci/20220901181634.99591-2-chenzhuo.1@bytedance.com/
?
AFAICS it hasn't. Then my ab-tag should have been preserved on v2.
One more time:
Acked-by: Serge Semin <fancer.lancer@gmail.com>

Don't forget to add it should you have some more patchset re-spins.

-Sergey

> 
> Signed-off-by: Zhuo Chen <chenzhuo.1@bytedance.com>
> ---
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
> index 0ed6f809ff2e..d5f0aa87f817 100644
> --- a/drivers/ntb/hw/idt/ntb_hw_idt.c
> +++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
> @@ -2657,8 +2657,8 @@ static int idt_init_pci(struct idt_ntb_dev *ndev)
>  	ret = pci_enable_pcie_error_reporting(pdev);
>  	if (ret != 0)
>  		dev_warn(&pdev->dev, "PCIe AER capability disabled\n");
> -	else /* Cleanup nonfatal error status before getting to init */
> -		pci_aer_clear_nonfatal_status(pdev);
> +	else /* Cleanup uncorrectable error status before getting to init */
> +		pci_aer_clear_uncorrect_error_status(pdev);
>  
>  	/* First enable the PCI device */
>  	ret = pcim_enable_device(pdev);
> -- 
> 2.30.1 (Apple Git-130)
> 
