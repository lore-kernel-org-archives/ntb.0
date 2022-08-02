Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E69297F
	for <ntb@lists.linux.dev>; Tue,  2 Aug 2022 19:52:49 +0000 (UTC)
Received: by mail-qt1-f174.google.com with SMTP id b21so11121856qte.12
        for <ntb@lists.linux.dev>; Tue, 02 Aug 2022 12:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aG2QNcVXuB2r2q5voKvzNrwPDnLoG3eQsLfbpqqQ1v4=;
        b=oQGXboiGD3g2UmaJT7bo3wItgqn6SFt8o4ZCh26IrXBo/QCf4+Lof7yoi2H+hteqPU
         wtsRVV2C7KWMiPRXk30gm04lvW44dbirF3XMqAB2kavwdHe3I8LooaUyLygjOFSYNrdR
         7tl6pFjIBgwx7lHSF5VZ5yBuGKnosK2CU6MBuIUzJds1f5rM6lHxOjM82gto6E3EiMX3
         vCAb7kZ3d4Iy6aW8T7v2bNu0FaKfzlB4qlwDORWZqT0xyv+nhll8/KPfuXSwainBTQes
         a1tEOikuNHxn84aAMY+/jHrc675VBATlNd0b9SVYgh9c0MGR57U/XwdzHtvopjyJ+h6t
         ZDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aG2QNcVXuB2r2q5voKvzNrwPDnLoG3eQsLfbpqqQ1v4=;
        b=Kek1HPG//b4FJSY3GbG1Feqvqg6/MeujcNDM+GAtM4X9BJjSS5avzExkS8uoAUSjDq
         /Q5beK9pLZIXL3kvOiKLvR+o2J1cUkZQK3ard3tGRGMUiF/BbNM8HpDdMUCW/Y44C3R2
         uMA0lfL5IqbzwhSn/iJG3iFQAEbPcok9yJIJm+Xa89jt+W4fDBh5b4l0E2ju2DwGSuAt
         tH8Zp5koUFTaESDFSBAf0Xqk03wR0S52UOTgjtobBK8TwN3dVVl/4r9oHgze06nCNdnL
         mVVPQgZQBTqfKXG+92Vlfe4DJJjEw7Yxohqs7m+NFj0Xvzf0ntTfU/qybXtp4HkVOqIt
         LFyg==
X-Gm-Message-State: AJIora8lAvI/8ARrqhiIOLa0vxGsIp4lpMjvnytrrEzjVGKJOm14S4n1
	viViVHVrZiwyzhM5UcPUtYaur9dAd9LeT/MUMZKXJWjgLGE=
X-Google-Smtp-Source: AGRyM1sKtRhZrqwDCbb2GkXrXYcC86Zp0I10RcN9HLZjO71hDzEkpJ08m3pTVxIQvoXiMTshom/+6Ed2XUrUEgPK7do=
X-Received: by 2002:ac8:5848:0:b0:31e:f4d3:fe59 with SMTP id
 h8-20020ac85848000000b0031ef4d3fe59mr20128253qth.662.1659469968794; Tue, 02
 Aug 2022 12:52:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <165938663353.3660206.14823522095818743981.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <165938663353.3660206.14823522095818743981.stgit@djiang5-desk3.ch.intel.com>
From: Allen Hubbe <allenbh@gmail.com>
Date: Tue, 2 Aug 2022 15:52:37 -0400
Message-ID: <CAJ80savTwSK49YPdLDTgXsUqOF3+P5vcU6_sjc4Kaz_3_dF0ng@mail.gmail.com>
Subject: Re: [PATCH v2] ntb: intel: add GNR support for Intel PCIe gen5 NTB
To: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>, ntb@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Mon, Aug 1, 2022 at 4:53 PM Dave Jiang <dave.jiang@intel.com> wrote:
> @@ -2047,6 +2047,8 @@ static const struct pci_device_id intel_ntb_pci_tbl[] = {
>
>         /* GEN4 */
>         {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)},
> +       /* SPR has same dev id has ICX but different revision id */
> +       {PCI_VDEVICE(INTEL, PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)},

comment says SPR but the id is GNR ?

> @@ -70,6 +70,8 @@
>  #define PCI_DEVICE_ID_INTEL_NTB_SS_BDX 0x6F0F
>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_SKX        0x201C
>  #define PCI_DEVICE_ID_INTEL_NTB_B2B_ICX        0x347e
> +#define PCI_DEVICE_ID_INTEL_NTB_B2B_SPR        0x347e

PCI_DEVICE_ID_INTEL_NTB_B2B_SPR is added here, but not used?

pdev_is_SPR(pdev) already exists.
Should that use PCI_DEVICE_ID_INTEL_NTB_B2B_SPR?

> @@ -225,7 +227,14 @@ static inline int pdev_is_gen4(struct pci_dev *pdev)
>  {
>         if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_ICX)
>                 return 1;
> +       return 0;

return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_ICX;

> +}
>
> +static inline int pdev_is_gen5(struct pci_dev *pdev)
> +{
> +       if (pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR)
> +               return 1;
>         return 0;

return pdev->device == PCI_DEVICE_ID_INTEL_NTB_B2B_GNR;
