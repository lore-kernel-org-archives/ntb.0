Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id ec7si995523wib.3.2015.07.06.08.31.25
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jul 2015 08:31:25 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH 06/12] NTB: Schedule to receive on QP link up
Date: Mon,  6 Jul 2015 11:30:29 -0400
Message-Id: <0107669542dad7e25116d0892faa6beeb49ee9ad.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436196351.git.Allen.Hubbe@emc.com>
References: <cover.1436196351.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

Schedule to receive on QP link up, to make sure that the doorbell is
properly cleared for interrupts.

Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 drivers/ntb/ntb_transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 73bb58bbcaec..4bba3c4a4a3a 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -902,6 +902,8 @@ static void ntb_qp_link_work(struct work_struct *work)
 
 		if (qp->event_handler)
 			qp->event_handler(qp->cb_data, qp->link_is_up);
+
+		tasklet_schedule(&qp->rxc_db_work);
 	} else if (nt->link_is_up)
 		schedule_delayed_work(&qp->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
-- 
2.4.0.rc0.43.gcf8a8c6

