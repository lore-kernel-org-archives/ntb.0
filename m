Return-Path: <wesley.sheng@microchip.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (mail-eopbgr820047.outbound.protection.outlook.com. [40.107.82.47])
        by gmr-mx.google.com with ESMTPS id q10-v6si1166241lji.4.2018.11.21.19.19.21
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Nov 2018 19:19:21 -0800 (PST)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH 0/3] ntb_hw_switchtec: Added support of >=4G memory windows
Date: Thu, 22 Nov 2018 17:01:59 +0800
Message-ID: <1542877322-24548-1-git-send-email-wesley.sheng@microchip.com>
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

