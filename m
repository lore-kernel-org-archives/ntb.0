Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id c3si400633wiz.2.2015.07.13.10.07.39
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:39 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 0/7] NTB: Bug Fixes
Date: Mon, 13 Jul 2015 08:07:07 -0400
Message-Id: <cover.1436788051.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

I split the v1 series into two series.  These patches are bug fixes.

These are in github.com/allenbh/linux.git branch ntb/master.

Allen Hubbe (4):
  NTB: Fix ntb_transport out-of-order RX update
  NTB: Schedule to receive on QP link up
  NTB: Fix zero size or integer overflow in ntb_set_mw
  NTB: Fix dereference before check

Dave Jiang (3):
  NTB: Fix transport stats for multiple devices
  NTB: ntb_netdev not covering all receive errors
  NTB: Fix oops in debugfs when transport is half-up

 drivers/net/ntb_netdev.c    |   9 +-
 drivers/ntb/ntb_transport.c | 201 +++++++++++++++++++++++++++-----------------
 2 files changed, 132 insertions(+), 78 deletions(-)

-- 
2.5.0.rc1

