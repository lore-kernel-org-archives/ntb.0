Return-Path: <dan.carpenter@oracle.com>
Received: from aserp2130.oracle.com (aserp2130.oracle.com. [141.146.126.79])
        by gmr-mx.google.com with ESMTPS id 62si1288707ybf.2.2019.03.25.02.23.40
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 02:23:40 -0700 (PDT)
Date: Mon, 25 Mar 2019 12:23:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] NTB: amd: Silence shift wrapping warning in
 amd_ntb_db_vector_mask()
Message-ID: <20190325092326.GE16023@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

This code triggers a Smatch warning:

    drivers/ntb/hw/amd/ntb_hw_amd.c:336 amd_ntb_db_vector_mask()
    warn: should '(1 << db_vector)' be a 64 bit type?

I don't think "db_vector" can be higher than 16 so this doesn't affect
runtime, but it's nice to silence the static checker warning and we
might increase "ndev->db_count" in the future.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 16c10dfe0919..84aec5500df3 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -333,7 +333,7 @@ static u64 amd_ntb_db_vector_mask(struct ntb_dev *ntb, int db_vector)
 	if (db_vector < 0 || db_vector > ndev->db_count)
 		return 0;
 
-	return ntb_ndev(ntb)->db_valid_mask & (1 << db_vector);
+	return ntb_ndev(ntb)->db_valid_mask & (1ULL << db_vector);
 }
 
 static u64 amd_ntb_db_read(struct ntb_dev *ntb)
-- 
2.17.1

