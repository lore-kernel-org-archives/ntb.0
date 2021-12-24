Return-Path: <Kelvin.Cao@microchip.com>
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com. [68.232.154.123])
        by gmr-mx.google.com with ESMTPS id q2si170721ljc.0.2021.12.23.17.25.06
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Dec 2021 17:25:06 -0800 (PST)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 0/6] Switchtec NTB Fixes and Improvements
Date: Thu, 23 Dec 2021 17:23:28 -0800
Message-ID: <20211224012334.89173-1-kelvin.cao@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: kelvin.cao@microchip.com
Content-Type: text/plain
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: Kelvin Cao <kelvin.cao@microchip.com>, kelvincao@outlook.com, Jeremy
 Pallotta <jmpallotta@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Hi,

Please find a bunch of patches for the Switchtec NTB driver.

Patche 1, 2 and 6 fix three minor bugs. Patch 3 works around a minor
firmware issue. Patch 4 updates the method of getting management VEP
instance ID based on a new firmware change. Patch 5 removes code that
disables ID protection to avoid conflict with static Switchtec config
settings.

This patchset is based on 5.16.0-rc5.

Thanks,
Kelvin

Jeremy Pallotta (2):
  ntb_hw_switchtec: Fix pff ioread to read into mmio_part_cfg_all
  ntb_hw_switchtec: AND with the part_map for a valid tpart_vec

Kelvin Cao (3):
  ntb_hw_switchtec: Update the way of getting VEP instance ID
  ntb_hw_switchtec: Remove code for disabling ID protection
  ntb_hw_switchtec: Fix a minor issue in config_req_id_table()

Wesley Sheng (1):
  ntb_hw_switchtec: Fix bug with more than 32 partitions

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 24 +++++++++++-------------
 include/linux/switchtec.h              |  2 --
 2 files changed, 11 insertions(+), 15 deletions(-)

-- 
2.25.1

