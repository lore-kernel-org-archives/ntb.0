Return-Path: <epilmore@gigaio.com>
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com. [2a00:1450:4864:20::42b])
        by gmr-mx.google.com with ESMTPS id y72si18364wmd.3.2019.04.24.15.04.16
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 15:04:16 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f7so4635325wrs.2
        for <linux-ntb@googlegroups.com>; Wed, 24 Apr 2019 15:04:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQPn8sX2G-Db-ZiFpP2SMKbkQnPyk63UZijAY0we+DoZsmDtQ@mail.gmail.com>
 <CAADLhr49ke_3s25gW11qZ+H-Jjje-E00WMHiMDbKU=mcCQtb3g@mail.gmail.com> <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
In-Reply-To: <cdcd00e9-056b-3364-cfbc-5bcb5bcff91e@amd.com>
From: Eric Pilmore <epilmore@gigaio.com>
Date: Wed, 24 Apr 2019 15:04:05 -0700
Message-ID: <CAOQPn8sQ+B97UptHpxJgdmcMxBZrqGynQR8qTc3q77fAODRH-A@mail.gmail.com>
Subject: Re: Fwd: AMD IO_PAGE_FAULT w/NTB on Write ops?
Content-Type: text/plain; charset="UTF-8"
To: Sanjay R Mehta <sanmehta@amd.com>
Cc: S Taylor <staylor@gigaio.com>, D Meyer <dmeyer@gigaio.com>, linux-ntb <linux-ntb@googlegroups.com>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-ID: <linux-ntb.googlegroups.com>

On Tue, Apr 23, 2019 at 4:00 AM Sanjay R Mehta <sanmehta@amd.com> wrote:
>
>
> > AMD-Vi: Event logged [IO_PAGE_FAULT device=23:01.2 domain=0x0000
> > address=0x00000000fde1c18c flags=0x0070]
>
> the address in the above log looks to be physical address of memory window. Am I Right?
>
> If yes then, the first parameter of dma_alloc_coherent() to be passed as below,
>
> dma_alloc_coherent(&ntb->pdev->dev, ...)instead of dma_alloc_coherent(&ntb->dev, ...).
>
> Hope this should solve your problem.

Hi Sanjay,

Thanks the for the response.  We are using the correct device for the
dma_alloc_coherent(). Upon further investigation what we are finding
is that apparently the AMD IOMMU support can only manage one alias, as
opposed to Intel IOMMU support which can support multiple. Not clear
at this time if it's a software limitation in the AMD IOMMU kernel
support or an imposed limitation of the hardware. Still investigating.

Thanks,
Eric
