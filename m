Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26571371
	for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 14:14:41 +0000 (UTC)
Received: by mail-qk1-f182.google.com with SMTP id c28so834830qko.9
        for <ntb@lists.linux.dev>; Fri, 12 Aug 2022 07:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kudzu-us.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=0kUQWjsRxfYcrrlivO3q6IGok3XN3uI+g6sW5XGlvv0=;
        b=YQDtB4aNmJduNsjXtffSrvEOksS/sOzGX65n5uDI/XIWseIV/y47Mg4pCldoVOPGiN
         hM1vYt3QRfn71jCV4OmbrcqXPwoHQe/lVvKGLXa+UDAGrVwjAQuSRhS3Epku5rM0I5yi
         uy23mTCG4Z/kTt2bBfkI4ohW4VDsFdQlxNctV/f9rgTPs+Z5tJSVjk6eFrXaBkQmG1he
         o0rauPmV3wqftDNkJvNHepmC4qtQVMyHUJIB6KJrf/jnkiNRAX+d2Pvuy0nHp/E02eH5
         FmS3T1Uhq27yAdFVKkxD5QNK6LopO3AVQtao7aP3h/kCeURuPcfnYF7+cQAjAV/t5262
         23dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=0kUQWjsRxfYcrrlivO3q6IGok3XN3uI+g6sW5XGlvv0=;
        b=oH8kv6aFat1bcQ+j1vz28Dfvg2NPmkhaR9E3Vm+wHIR7I/t5PR1ge5/JtN9rcoqk+R
         6u6ypuVRhWWJ0iGqvtyrAvIZGWo3Q6SlZyDezUkGz7dG7N5jy66p98kwZgl1P72JGiMP
         4UQDH87TZBOCTgup2kf9XCn90UhFXuP7RFQguHbAq9ZuBRFFEmYrOd0pwRhOEhjwc4Tw
         sy98ryuZ/sZH0m2e7XKEru3/kUItO6jRgh5ZSuoA1jZOPHxX7W9Wuh45amZRySM9X1t3
         4wHBQ/mSnyajbgP5N7TsnA1uS5ByxyaQ7BexMA7GrNiJ9cj7cB210qH6r5bZzU12SX1p
         aAuQ==
X-Gm-Message-State: ACgBeo0E0iADz18aA01gkjEBqKiDbJHtHfH4R4MMhCqqa7gfNjjj8VfW
	dcZfYVc0Hy0ZOtOaZqbzQeTpFJ/JDhzH2gidmrU=
X-Google-Smtp-Source: AA6agR6uVK2GgB4/yYCPwysLujYwn5+pi66EwHQxY2m9YNTE2S1VaUXtetfw8gYpJ0wm1oF/4cjx3A==
X-Received: by 2002:a05:620a:1595:b0:6b9:c032:fee9 with SMTP id d21-20020a05620a159500b006b9c032fee9mr3052038qkk.704.1660313680636;
        Fri, 12 Aug 2022 07:14:40 -0700 (PDT)
Received: from kudzu.us ([2605:a601:a608:5600::59])
        by smtp.gmail.com with ESMTPSA id g18-20020a05620a40d200b006b93ff541dasm1792844qko.8.2022.08.12.07.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 07:14:40 -0700 (PDT)
Date: Fri, 12 Aug 2022 10:14:38 -0400
From: Jon Mason <jdmason@kudzu.us>
To: Dave Jiang <dave.jiang@intel.com>
Cc: allenbh@gmail.com, ntb@lists.linux.dev
Subject: Re: [PATCH] ntb: intel: add GNR support for Intel PCIe gen5 NTB
Message-ID: <YvZgTmDTm+e6lIxK@kudzu.us>
References: <165765900595.1786187.5476611141315542956.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165765900595.1786187.5476611141315542956.stgit@djiang5-desk3.ch.intel.com>

On Tue, Jul 12, 2022 at 01:50:06PM -0700, Dave Jiang wrote:
> Add Intel Granite Rapids NTB PCI device ID and related enabling.
> Expectation is same hardware interface as Saphire Rapids Xeon platforms.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Sorry for the extremely long delay in response.  This series is in my
ntb branch and will be in my pull request for v5.20 which should be
going out later today.

Thanks,
Jon

> ---
>  drivers/ntb/hw/intel/ntb_hw_gen1.c  |    4 +++-
>  drivers/ntb/hw/intel/ntb_hw_gen4.c  |    2 +-
>  drivers/ntb/hw/intel/ntb_hw_intel.h |    9 +++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> index e5f14e20a9ff..72e2027a71c4 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
> @@ -1874,7 +1874,7 @@ static int intel_ntb_pci_probe(struct pci_dev *pdev,
>  		rc = gen3_init_dev(ndev);
>  		if (rc)
>  			goto err_init_dev;
> -	} else if (pdev_is_gen4(pdev)) {
> +	} else if (pdev_is_gen4(pdev) || pdev_is_gen5(pdev)) {
>  		ndev->ntb.ops = &intel_ntb4_ops;
>  		rc = intel_ntb_init_pci(ndev, pdev);
>  		if (rc)
> @@ -2047,6 +2047,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
>  
>  	/* GEN4 */
>  	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
> +	/* SPR has same dev id has ICX but different revision id */
> +	{PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)},
>  	{0}
>  };
>  MODULE_DEVICE_TABLE(pci, intel_ntb_pci_tbl);
> diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> index 4081fc538ff4..22cac7975b3c 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
> +++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
> @@ -197,7 +197,7 @@ int gen4_init_dev(struct intel_ntb_dev *ndev)
>  	ppd1 = ioread32(ndev->self_mmio + GEN4_PPD1_OFFSET);
>  	if (pdev_is_ICX(pdev))
>  		ndev->ntb.topo = gen4_ppd_topo(ndev, ppd1);
> -	else if (pdev_is_SPR(pdev))
> +	else if (pdev_is_SPR(pdev) || pdev_is_gen5(pdev))
>  		ndev->ntb.topo = spr_ppd_topo(ndev, ppd1);
>  	dev_dbg(&pdev->dev, "ppd %#x topo %s\n", ppd1,
>  		ntb_topo_string(ndev->ntb.topo));
> diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.h b/drivers/ntb/hw/intel/ntb_hw_intel.h
> index b233d1c6ba2d..380ec0d8e0d9 100644
> --- a/drivers/ntb/hw/intel/ntb_hw_intel.h
> +++ b/drivers/ntb/hw/intel/ntb_hw_intel.h
> @@ -70,6 +70,8 @@
>  #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX	0x6F0F
>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX	0x201C
>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX	0x347e
> +#define PCI_DEVICE_ID_INTEL_NTB_B2B_SPR	0x347e
> +#define PCI_DEVICE_ID_INTEL_NTB_B2B_GNR	0x0db4
>  
>  /* Ntb control and link status */
>  #define NTB_CTL_CFG_LOCK		BIT(0)
> @@ -225,7 +227,14 @@ static inline int pdev_is_gen4(struct pci_dev *pdev)
>  {
>  	if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)
>  		return 1;
> +	return 0;
> +}
>  
> +static inline int pdev_is_gen5(struct pci_dev *pdev)
> +{
> +	if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)
> +		return 1;
>  	return 0;
>  }
> +
>  #endif
> 
> 
