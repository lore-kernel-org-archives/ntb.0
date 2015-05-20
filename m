Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id dw9si957738qcb.2.2015.05.20.13.42.07
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 May 2015 13:42:07 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 08/16] ntb_transport: rate limit ntb_qp_link_work
Date: Wed, 20 May 2015 11:41:09 -0400
Message-Id: <d52524026887f4138260b305bbbe046bcdad8956.1432135632.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1432135631.git.Allen.Hubbe@emc.com>
References: <cover.1432135631.git.Allen.Hubbe@emc.com>
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
index bb2eb85..833f5b6 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -830,7 +830,7 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 	/* query remote spad for qp ready bits */
 	ntb_peer_spad_read(nt->ndev, QP_LINKS);
-	dev_dbg(&pdev->dev, "Remote QP link status = %x\n", val);
+	dev_dbg_ratelimited(&pdev->dev, "Remote QP link status = %x\n", val);
 
 	/* See if the remote side is up */
 	if (val & BIT(qp->qp_num)) {
-- 
2.4.0.rc0.43.gcf8a8c6

