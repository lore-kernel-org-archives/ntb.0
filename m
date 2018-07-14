Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com. [2a00:1450:4864:20::232])
        by gmr-mx.google.com with ESMTPS id d18-v6si698952wrq.4.2018.07.14.04.58.57
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Jul 2018 04:58:57 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 203-v6so15301678ljj.13
        for <linux-ntb@googlegroups.com>; Sat, 14 Jul 2018 04:58:57 -0700 (PDT)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH 0/4] ntb: idt: Add hwmon temperature sensor interface
Date: Sat, 14 Jul 2018 14:58:30 +0300
Message-Id: <20180714115834.3350-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

IDT PCIe-switches are equipped with an embedded temperature sensor. It
works within the range [0; 127.5]C with a resolution of 0.5C. It can
be used to monitor the chip core temperature so to have prevent it from
possible overheating. It might be very topical for the chip, since it
gets heated like in hell especially if ASPM isn't enabled.

Other than the current sampled temperatur, the sensor interface exposes
history registors with lowest and highest measured temperature, thresholds
and alarm IRQs enabled/disable bits, ADC/filter settings. The device manual
states that the switch is able to generate a msi interrupt on PCIe upstreams
if the temperature crosses one of three configurable thresholds. But in
practice we discovered that the enable/disable threshold IRQs bits interface
is very broken (see the third patch commit message), so it can't be used
to create the hwmon alarm interface. As the result we had to remove the
already available temperature sensor IRQ handler and disable the corresponding
interrupt.

Current version of the driver provides following standard hwmon sysfs
files: temperature input, lowest and highest measured temperature
with possibility to reset the history, temperature offset. The rest of the
nodes can't be safely implemented for the chip due to the described issues.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Serge Semin (4):
  ntb: idt: Alter temperature read method
  ntb: idt: Add basic hwmon sysfs interface
  ntb: idt: Discard temperature sensor IRQ handler
  ntb: idt: Alter the driver info comments

 drivers/ntb/hw/idt/Kconfig      |   4 +-
 drivers/ntb/hw/idt/ntb_hw_idt.c | 317 ++++++++++++++++++++++++++++++++++------
 drivers/ntb/hw/idt/ntb_hw_idt.h |  87 ++++++++++-
 3 files changed, 353 insertions(+), 55 deletions(-)

-- 
2.12.0

