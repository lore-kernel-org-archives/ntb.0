Return-Path: <dan.carpenter@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com. [156.151.31.85])
        by gmr-mx.google.com with ESMTPS id 192si1036997pgc.0.2019.03.25.02.17.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 02:17:48 -0700 (PDT)
Date: Mon, 25 Mar 2019 12:17:26 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH] ntb_hw_switchtec: potential shift wrapping bug in
 switchtec_ntb_init_sndev()
Message-ID: <20190325091726.GD16023@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Kelvin Cao <kelvin.cao@microsemi.com>
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

This code triggers a Smatch warning:

    drivers/ntb/hw/mscc/ntb_hw_switchtec.c:884 switchtec_ntb_init_sndev()
    warn: should '(1 << sndev->peer_partition)' be a 64 bit type?

The "part_map" and "tpart_vec" variables are u64 type so this seems like
a valid warning.

Fixes: 3df54c870f52 ("ntb_hw_switchtec: Allow using Switchtec NTB in multi-partition setups")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index d905d368d28c..26a88731b0cb 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -881,7 +881,7 @@ static int switchtec_ntb_init_sndev(struct switchtec_ntb *sndev)
 		}
 
 		sndev->peer_partition = ffs(tpart_vec) - 1;
-		if (!(part_map & (1 << sndev->peer_partition))) {
+		if (!(part_map & (1ULL << sndev->peer_partition))) {
 			dev_err(&sndev->stdev->dev,
 				"ntb target partition is not NT partition\n");
 			return -ENODEV;
-- 
2.17.1

