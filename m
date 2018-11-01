Return-Path: <jdmason@kudzu.us>
Received: from mail-yw1-xc2d.google.com (mail-yw1-xc2d.google.com. [2607:f8b0:4864:20::c2d])
        by gmr-mx.google.com with ESMTPS id v9-v6si1135048plp.1.2018.11.01.07.35.23
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Nov 2018 07:35:23 -0700 (PDT)
Received: by mail-yw1-xc2d.google.com with SMTP id d126-v6so7966722ywa.5
        for <linux-ntb@googlegroups.com>; Thu, 01 Nov 2018 07:35:22 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Date: Thu, 1 Nov 2018 10:35:20 -0400
From: Jon Mason <jdmason@kudzu.us>
Subject: Re: [PATCH v2 0/4] ntb: idt: Add hwmon temperature sensor interface
Message-ID: <20181101143520.GA1939@kudzu.us>
References: <20180714115834.3350-1-fancer.lancer@gmail.com>
 <20180717092437.18918-1-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180717092437.18918-1-fancer.lancer@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: dave.jiang@intel.com, allenbh@gmail.com, Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

On Tue, Jul 17, 2018 at 12:24:33PM +0300, Serge Semin wrote:
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
> Changelog v2:
> - Add "select HWMON" to the NTB_IDT kconfig
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

 was waiting on you to address the kbuild errors, and it appears you
 did already.  Somehow I missed v2 of this series and just found it now.
 Sorry :(

Applied to the ntb-next branch

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
