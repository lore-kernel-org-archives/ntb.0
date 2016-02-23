Return-Path: <dave.jiang@intel.com>
Received: from mga02.intel.com (mga02.intel.com. [134.134.136.20])
        by gmr-mx.google.com with ESMTP id u66si4619378pfa.2.2016.02.23.13.11.18
        for <linux-ntb@googlegroups.com>;
        Tue, 23 Feb 2016 13:11:18 -0800 (PST)
Subject: [PATCH] ntb: stop link work when we do not have memory
From: Dave Jiang <dave.jiang@intel.com>
Date: Tue, 23 Feb 2016 14:11:12 -0700
Message-ID: <20160223211111.196243.73270.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com, jdmason@kudzu.us
Cc: alex@pernixdata.com, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Instead of keep trying to go through the init routine when we aren't able
to allocate memory, we should just stop and go down.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Tested-by: Alex Depoutovitch <alex@pernixdata.com>
---
 drivers/ntb/ntb_transport.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 06d4e58..50ecbd6 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -829,7 +829,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 	struct pci_dev *pdev = ndev->pdev;
 	resource_size_t size;
 	u32 val;
-	int rc, i, spad;
+	int rc = 0, i, spad;
 
 	/* send the local info, in the opposite order of the way we read it */
 	for (i = 0; i < nt->mw_count; i++) {
@@ -899,6 +899,14 @@ static void ntb_transport_link_work(struct work_struct *work)
 out1:
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
+
+	/* if there's an actual failure, we should just bail */
+	if (rc < 0) {
+		nt->link_is_up = false;
+		ntb_transport_link_cleanup(nt);
+		return;
+	}
+
 out:
 	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
 		schedule_delayed_work(&nt->link_work,

