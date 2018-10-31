Return-Path: <jdmason@kudzu.us>
Received: from mail-yb1-xb41.google.com (mail-yb1-xb41.google.com. [2607:f8b0:4864:20::b41])
        by gmr-mx.google.com with ESMTPS id q14si115406otg.1.2018.10.31.14.27.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 14:27:25 -0700 (PDT)
Received: by mail-yb1-xb41.google.com with SMTP id f15-v6so6786540ybq.13
        for <linux-ntb@googlegroups.com>; Wed, 31 Oct 2018 14:27:25 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Wed, 31 Oct 2018 17:27:22 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH 0/4] ntb: idt: Add hwmon temperature sensor interface
Message-ID: <20181031212721.GA2565@kudzu.us>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180714115834.3350-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Sat, Jul 14, 2018 at 02:58:30PM +0300, Serge Semin wrote:
> IDT PCIe-switches are equipped with an embedded temperature sensor. It
> works within the range [0; 127.5]C with a resolution of 0.5C. It can
> be used to monitor the chip core temperature so to have prevent it from
> possible overheating. It might be very topical for the chip, since it
> gets heated like in hell especially if ASPM isn't enabled.
> 
> Other than the current sampled temperatur, the sensor interface exposes
> history registors with lowest and highest measured temperature, thresholds
> and alarm IRQs enabled/disable bits, ADC/filter settings. The device manual
> states that the switch is able to generate a msi interrupt on PCIe upstreams
> if the temperature crosses one of three configurable thresholds. But in
> practice we discovered that the enable/disable threshold IRQs bits interface
> is very broken (see the third patch commit message), so it can't be used
> to create the hwmon alarm interface. As the result we had to remove the
> already available temperature sensor IRQ handler and disable the corresponding
> interrupt.
> 
> Current version of the driver provides following standard hwmon sysfs
> files: temperature input, lowest and highest measured temperature
> with possibility to reset the history, temperature offset. The rest of the
> nodes can't be safely implemented for the chip due to the described issues.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

FYI, I'm waiting on you to correct the kbuild issues.  I have been
assuming you knew this, but given the lack of follow-up patches I am
beginning to this you might believe I'm ignoring them.  I'm not :)

Thanks,
Jon

> 
> Serge Semin (4):
>   ntb: idt: Alter temperature read method
>   ntb: idt: Add basic hwmon sysfs interface
>   ntb: idt: Discard temperature sensor IRQ handler
>   ntb: idt: Alter the driver info comments
> 
>  drivers/ntb/hw/idt/Kconfig      |   4 +-
>  drivers/ntb/hw/idt/ntb_hw_idt.c | 317 ++++++++++++++++++++++++++++++++++------
>  drivers/ntb/hw/idt/ntb_hw_idt.h |  87 ++++++++++-
>  3 files changed, 353 insertions(+), 55 deletions(-)
> 
> -- 
> 2.12.0
> 
