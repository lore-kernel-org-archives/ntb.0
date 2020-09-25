Return-Path: <arnd@arndb.de>
Received: from mout.kundenserver.de (mout.kundenserver.de. [212.227.126.135])
        by gmr-mx.google.com with ESMTPS id w10si74950wma.1.2020.09.25.04.25.55
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 04:25:55 -0700 (PDT)
Received: from mail-qk1-f169.google.com ([209.85.222.169]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MuUza-1kdi7N1KAE-00rbB7 for <linux-ntb@googlegroups.com>; Fri, 25 Sep
 2020 13:25:55 +0200
Received: by mail-qk1-f169.google.com with SMTP id f142so2317791qke.13
        for <linux-ntb@googlegroups.com>; Fri, 25 Sep 2020 04:25:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200925072630.8157-1-sherry.sun@nxp.com>
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 25 Sep 2020 13:25:38 +0200
Message-ID: <CAK8P3a3fog3jE_cPUTELDkFKoO2FbCJufQiDZhfL2FsZ5s5q3Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add noncoherent platform support for vop driver
Content-Type: text/plain; charset="UTF-8"
To: Sherry Sun <sherry.sun@nxp.com>
Cc: Sudeep Dutt <sudeep.dutt@intel.com>, Ashutosh Dixit <ashutosh.dixit@intel.com>, gregkh <gregkh@linuxfoundation.org>, wang.yi59@zte.com.cn, huang.zijiang@zte.com.cn, Rikard Falkeborn <rikard.falkeborn@gmail.com>, Lee Jones <lee.jones@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>, linux-pci <linux-pci@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Kishon Vijay Abraham I <kishon@ti.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

On Fri, Sep 25, 2020 at 9:27 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> Change the way of allocating vring to support noncoherent platform for vop
> driver, and add some related dma changes to make sure noncoherent platform works
> well.

Could you describe why you are doing this? Are you using Intel MIC
devices on Arm hosts, or trying to reuse the code for other add-on
cards?

Note that we have a couple of frameworks in the kernel that try to
do some of the same things here, notably the NTB drivers and the
PCI endpoint support, both of which are designed to be somewhat
more generic than the MIC driver.

Have you considered using that instead?

         Arnd

> Sherry Sun (5):
>   misc: vop: change the way of allocating vring for noncoherent platform
>   misc: vop: change the way of allocating used ring
>   misc: vop: simply return the saved dma address instead of virt_to_phys
>   misc: vop: set VIRTIO_F_ACCESS_PLATFORM for nocoherent platform
>   misc: vop: mapping kernel memory to user space as noncached
>
>  drivers/misc/mic/bus/vop_bus.h    |   2 +
>  drivers/misc/mic/host/mic_boot.c  |   8 ++
>  drivers/misc/mic/vop/vop_main.c   |  51 +++++++++----
>  drivers/misc/mic/vop/vop_vringh.c | 117 ++++++++++++++++++++----------
>  4 files changed, 125 insertions(+), 53 deletions(-)
>
> --
> 2.17.1
>
