Return-Path: <kelvin.cao@microchip.com>
Received: from esa6.microchip.iphmx.com (esa6.microchip.iphmx.com. [216.71.154.253])
        by gmr-mx.google.com with ESMTPS id o26si67991qtk.3.2019.06.06.00.09.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 00:09:50 -0700 (PDT)
From: Kelvin Cao <kelvin.cao@microchip.com>
Subject: [PATCH 0/3] Redundant steps removal and bug fix of ntb_hw_switchtec
Date: Thu, 6 Jun 2019 15:09:41 +0800
Message-ID: <1559804984-24698-1-git-send-email-kelvin.cao@microchip.com>
Return-Path: kelvin.cao@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: kurt.schwemmer@microsemi.com, logang@deltatee.com, jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: kelvin.cao@microchip.com, kelvincao@outlook.com
List-ID: <linux-ntb.googlegroups.com>

Hi, Everyone,

This patch series remove redundant steps and fix one bug of the 
ntb_hw_switchtec module.

When a re-initialization is caused by a link event, the driver will
re-setup the shared memory windows. But at that time, the shared memory
is still valid, and it's unnecessary to free, reallocate and then
initialize it again. Remove these redundant steps.

In case of NTB crosslink topology, the setting of shared memory window
in the virtual partition doesn't reset on peer's reboot. So skip the
re-setup of shared memory window for that case.

Switchtec does not support setting multiple MWs simultaneously. However,
there's a race condition when a re-initialization is caused by a link 
event, the driver will re-setup the shared memory window asynchronously
and this races with the client setting up its memory windows on the 
link up event. Fix this by ensure do the entire initialization in a work
queue and signal the client once it's done. 

Regard,
Kelvin

--

Changed since v1:
  - It's a second resend of v1

--

Joey Zhang (2):
  ntb_hw_switchtec: Remove redundant steps of
    switchtec_ntb_reinit_peer() function
  ntb_hw_switchtec: Fix setup MW with failure bug

Wesley Sheng (1):
  ntb_hw_switchtec: Skip unnecessary re-setup of shared memory window
    for crosslink case

 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 80 +++++++++++++++++++++-------------
 1 file changed, 49 insertions(+), 31 deletions(-)

-- 
2.7.4

