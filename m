Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTPS id 7si2493341par.0.2016.10.27.11.06.44
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 27 Oct 2016 11:06:44 -0700 (PDT)
Subject: [PATCH] ntb: ntb_hw_intel: init peer_addr in struct intel_ntb_dev
From: Dave Jiang <dave.jiang@intel.com>
Date: Thu, 27 Oct 2016 11:06:44 -0700
Message-ID: <147759160406.148101.6570617851207590619.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

The peer_addr member of intel_ntb_dev is not set, therefore when
acquiring ntb_peer_db and ntb_peer_spad we only get the offset rather
than the actual physical address. Adding fix to correct that.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/hw/intel/ntb_hw_intel.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/ntb/hw/intel/ntb_hw_intel.c b/drivers/ntb/hw/intel/ntb_hw_intel.c
index 0d5c29a..d6fe7ab 100644
--- a/drivers/ntb/hw/intel/ntb_hw_intel.c
+++ b/drivers/ntb/hw/intel/ntb_hw_intel.c
@@ -1755,6 +1755,8 @@ static int xeon_setup_b2b_mw(struct intel_ntb_dev *ndev,
 					    XEON_B2B_MIN_SIZE);
 		if (!ndev->peer_mmio)
 			return -EIO;
+
+		ndev->peer_addr = pci_resource_start(pdev, b2b_bar);
 	}
 
 	return 0;
@@ -2019,6 +2021,7 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 		goto err_mmio;
 	}
 	ndev->peer_mmio = ndev->self_mmio;
+	ndev->peer_addr = pci_resource_start(pdev, 0);
 
 	return 0;
 

