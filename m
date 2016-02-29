Return-Path: <dave.jiang@intel.com>
Received: from mga11.intel.com (mga11.intel.com. [192.55.52.93])
        by gmr-mx.google.com with ESMTP id 12si3791412pfb.1.2016.02.29.08.35.36
        for <linux-ntb@googlegroups.com>;
        Mon, 29 Feb 2016 08:35:36 -0800 (PST)
Subject: [PATCH v2] ntb: stop link work when we do not have memory
From: Dave Jiang <dave.jiang@intel.com>
Date: Mon, 29 Feb 2016 09:35:26 -0700
Message-ID: <20160229163526.199357.42464.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: allen.hubbe@emc.com--to=jdmason, @kudzu.us, allen.hubbe@emc.com, jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Instead of keep trying to go through the init routine when we aren't able
to allocate memory, we should just stop and go down.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 06d4e58..a44fb09 100644
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
@@ -899,6 +899,13 @@ static void ntb_transport_link_work(struct work_struct *work)
 out1:
 	for (i = 0; i < nt->mw_count; i++)
 		ntb_free_mw(nt, i);
+
+	/* if there's an actual failure, we should just bail */
+	if (rc < 0) {
+		ntb_link_disable(ndev);
+		return;
+	}
+
 out:
 	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
 		schedule_delayed_work(&nt->link_work,

