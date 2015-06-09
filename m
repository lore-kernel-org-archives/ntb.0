Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id gt9si107109wib.2.2015.06.09.07.45.33
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jun 2015 07:45:33 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v3 12/18] NTB: Rate limit ntb_qp_link_work
Date: Tue,  9 Jun 2015 05:44:39 -0400
Message-Id: <d5916febc226f9b885869c430b670c6de05dd634.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1433838377.git.Allen.Hubbe@emc.com>
References: <cover.1433838377.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

When the ntb transport is connecting and waiting for the peer, the debug
console receives lots of debug level messages about the remote qp link
status being down.  Rate limit those messages.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 2efd1eae9a7c..8ce0bf67ac20 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -850,7 +850,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 	/* query remote spad for qp ready bits */
 	ntb_peer_spad_read(nt->ndev, QP_LINKS);
-	dev_dbg(&pdev->dev, "Remote QP link status = %x\n", val);
+	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
 
 	/* See if the remote side is up */
 	if (val & BIT(qp->qp_num)) {
-- 
2.4.0.rc0.43.gcf8a8c6

