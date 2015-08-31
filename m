Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id r124si285680ywb.0.2015.08.31.11.31.02
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Aug 2015 11:31:02 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 0/2] NTB: Fix/improve memory window index validation
Date: Mon, 31 Aug 2015 09:30:58 -0400
Message-Id: <cover.1441027457.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Fix a range check on validating a memory window index, and make validation more
strict for using memory window as a hardware errata workaround.

Allen Hubbe (2):
  NTB: Improve index handling in B2B MW workaround
  NTB: Fix range check on memory window index

 drivers/ntb/hw/intel/ntb_hw_intel.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

-- 
2.5.0.rc1

