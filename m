Return-Path: <yuehaibing@huawei.com>
Received: from huawei.com (szxga06-in.huawei.com. [45.249.212.32])
        by gmr-mx.google.com with ESMTPS id e124si125242pgc.3.2019.03.20.07.21.17
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 07:21:17 -0700 (PDT)
From: Yue Haibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ntb: intel: Make intel_ntb3_peer_db_addr static
Date: Wed, 20 Mar 2019 22:08:12 +0800
Message-ID: <20190320140812.5952-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
To: dave.jiang@intel.com, jdmason@kudzu.us, allenbh@gmail.com
Cc: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, YueHaibing <yuehaibing@huawei.com>
List-ID: <linux-ntb.googlegroups.com>

From: YueHaibing <yuehaibing@huawei.com>

Fix sparse warning:

drivers/ntb/hw/intel/ntb_hw_gen3.c:535:5: warning:
 symbol 'intel_ntb3_peer_db_addr' was not declared. Should it be static?

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen3.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen3.c b/drivers/ntb/hw/intel/ntb_hw_gen3.c
index f475b56..c339716 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen3.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen3.c
@@ -532,9 +532,9 @@ static int intel_ntb3_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 	return 0;
 }
 
-int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
-				resource_size_t *db_size,
-				u64 *db_data, int db_bit)
+static int intel_ntb3_peer_db_addr(struct ntb_dev *ntb, phys_addr_t *db_addr,
+				   resource_size_t *db_size,
+				   u64 *db_data, int db_bit)
 {
 	phys_addr_t db_addr_base;
 	struct intel_ntb_dev *ndev = ntb_ndev(ntb);
-- 
2.7.0


