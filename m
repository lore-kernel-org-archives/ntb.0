Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTPS id m81si76698pfd.2.2020.05.26.10.28.56
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 10:28:56 -0700 (PDT)
Subject: [PATCH] ntb: intel: fix static declaration
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 26 May 2020 10:28:53 -0700
Message-ID: <159051413389.47606.2615869180413030098.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

intel_ntb4_link_disable() missing static declaration.

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen4.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen4.c b/drivers/ntb/hw/intel/ntb_hw_gen4.c
index dcbd6d3cf7ae..af5c8feb2df8 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen4.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen4.c
@@ -498,7 +498,7 @@ static int intel_ntb4_link_enable(struct ntb_dev *ntb,
 	return 0;
 }
 
-int intel_ntb4_link_disable(struct ntb_dev *ntb)
+static int intel_ntb4_link_disable(struct ntb_dev *ntb)
 {
 	struct intel_ntb_dev *ndev;
 	u32 ntb_cntl;

