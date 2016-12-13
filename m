Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id d199si364106wmd.1.2016.12.13.15.49.27
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Dec 2016 15:49:27 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id 96so224886lfs.1
        for <linux-ntb@googlegroups.com>; Tue, 13 Dec 2016 15:49:27 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 0/9] NTB: Alter kernel API to support multi-port devices
Date: Wed, 14 Dec 2016 02:49:12 +0300
Message-Id: <1481672961-10753-1-git-send-email-fancer.lancer@gmail.com>
In-Reply-To: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
References: <1481576902-21091-1-git-send-email-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Xiangliang.Yu@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

There are devices, like IDT PCIe-switches, which have more than just two ports.
Particularly one device can have up to eight ports with NTB-function activated.
In order to support such devices, NTB kernel API should be altered since
currently it's optimized to work with two-ports devices only.

Changelog v2:
 - Move comments from cover letter to individual patches
 - Combine patches to make code buildable
 - Alter patchset to support Intel SKX driver
 - Make sure all the API uses the same midx/widx/pidx/sidx arguments notation
 - Move new MW API usage description into Documention
 - Alter Spad/Msg API checking valid function to make spad and msg interfaces optional
 - Alter comments in ntb.h
 - Split: add NTB_SPEED_GEN4 and ntb.h comments into separate patches
 - Put copyrights into some of the existing patches
 - Get rid of TOPO updates

Changelog v3:
 - Get rid of code rearrangements within Intel/AMD drivers
 - Make two-ports NTB API being default
 - Check pidx argument for negative values
 - Translation address methods should return zero in case if not implemented
 - Simplify Scratchpad alterations of ntb_tool client driver
 - ntb.h comments are altered in compliance with port-related API changes
 - Spell check the text

Serge Semin (9):
  NTB: Make link-state API being declared first
  NTB: Add indexed ports NTB API
  NTB: Alter link-state API to support multi-port devices
  NTB: Alter MW API to support multi-ports devices
  NTB: Alter Scratchpads API to support multi-ports devices
  NTB: Add Messaging NTB API
  NTB: Add new Memory Windows API documentation
  NTB: Add PCIe Gen4 link speed
  NTB: Add ntb.h comments

 Documentation/ntb.txt               |  99 ++++-
 drivers/ntb/hw/amd/ntb_hw_amd.c     |  84 +++--
 drivers/ntb/hw/intel/ntb_hw_intel.c | 106 ++++--
 drivers/ntb/ntb.c                   |  69 ++++
 drivers/ntb/ntb_transport.c         |  44 ++-
 drivers/ntb/test/ntb_perf.c         |  27 +-
 drivers/ntb/test/ntb_pingpong.c     |  14 +-
 drivers/ntb/test/ntb_tool.c         |  69 +++-
 include/linux/ntb.h                 | 724 ++++++++++++++++++++++++++++++------
 9 files changed, 1026 insertions(+), 210 deletions(-)

-- 
2.6.6

