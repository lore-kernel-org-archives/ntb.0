Return-Path: <dave.jiang@intel.com>
Received: from mga06.intel.com (mga06.intel.com. [134.134.136.31])
        by gmr-mx.google.com with ESMTPS id l86si897652pfi.1.2017.07.28.15.10.48
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 15:10:48 -0700 (PDT)
Subject: [PATCH] ntb: transport shouldn't disable link due to bogus values
 in SPADs
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 28 Jul 2017 15:10:48 -0700
Message-ID: <150127984807.48385.10962784387437107365.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com, allen.hubbe@emc.com
List-ID: <linux-ntb.googlegroups.com>

It seems that under certain scenarios the SPAD can have bogus values caused
by an agent (i.e. BIOS or other software) that is not the kernel driver, and
that causes memory window setup failure. This should not cause the link to
be disabled because if we do that, the driver will never recover again. We
have verified in testing that this issue happens and prevents proper link
recovery.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 9a03c58..f0dd5a7 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -924,10 +924,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 		ntb_free_mw(nt, i);
 
 	/* if there's an actual failure, we should just bail */
-	if (rc < 0) {
-		ntb_link_disable(ndev);
+	if (rc < 0)
 		return;
-	}
 
 out:
 	if (ntb_link_is_up(ndev, NULL, NULL) == 1)

