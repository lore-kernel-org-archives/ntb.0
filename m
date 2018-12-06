Return-Path: <wesley.sheng@microchip.com>
Received: from NAM05-CO1-obe.outbound.protection.outlook.com (mail-eopbgr720052.outbound.protection.outlook.com. [40.107.72.52])
        by gmr-mx.google.com with ESMTPS id c140si1010917qkb.0.2018.12.05.23.48.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 05 Dec 2018 23:48:05 -0800 (PST)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH v2 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
Date: Thu, 6 Dec 2018 21:30:49 +0800
Message-ID: <1544103052-28191-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@microchip.com
List-ID: <linux-ntb.googlegroups.com>

Hi, Everyone,

This patch series adds support of >=4G memory windows.

Current Switchtec's BAR setup registers are limited to 32bits,
corresponding to the maximum MW (memory window) size is <4G.
Increase the MW sizes with the addition of the BAR Setup Extension
Register for the upper 32bits of a 64bits MW size. This increases the MW
range to between 4K and 2^63.

Additionally, we've made the following changes:

* debug print 64bit aligned crosslink BAR numbers
* Fix the array size of NT req id mapping table

Tested with ntb_test.sh successfully based on NTB fixes series from
Logan Gunthorpe <logang@deltatee.com> at 
https://github.com/sbates130272/linux-p2pmem on branch of
ntb_multiport_fixes

Regards,
Wesley

--

Changed since v1:
  - Using upper_32_bits() and lower_32_bits() marcos makes it easier
    to read and avoids compiler warning on 32-bit arch
  - Reorder the patches to make the bug fixes first and add a "Fixes"
    line to the commit messages

--
Paul Selles (2):
  ntb_hw_switchtec: debug print 64bit aligned crosslink BAR Numbers
  ntb_hw_switchtec: Added support of >=4G memory windows

Wesley Sheng (1):
  ntb_hw_switchtec: NT req id mapping table register entry number should
    be 512

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 11 ++++++++---
 include/linux/switchtec.h              | 10 +++++++---
 2 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.7.4

