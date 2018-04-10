Return-Path: <baijiaju1990@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com. [2607:f8b0:400e:c00::241])
        by gmr-mx.google.com with ESMTPS id z65si235980ioi.5.2018.04.10.06.17.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Apr 2018 06:17:39 -0700 (PDT)
Received: by mail-pf0-x241.google.com with SMTP id o16so8270082pfk.9
        for <linux-ntb@googlegroups.com>; Tue, 10 Apr 2018 06:17:39 -0700 (PDT)
Return-Path: <baijiaju1990@gmail.com>
From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH 1/2] ntb: ntb_transport: Replace GFP_ATOMIC with GFP_KERNEL in ntb_transport_setup_qp_mw
Date: Tue, 10 Apr 2018 21:17:29 +0800
Message-Id: <1523366249-31692-1-git-send-email-baijiaju1990@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

ntb_transport_setup_qp_mw() is never called in atomic context.

ntb_transport_setup_qp_mw() is only called by ntb_transport_link_work(), 
which is set as a parameter of INIT_DELAYED_WORK() 
in ntb_transport_probe().

Despite never getting called from atomic context,
ntb_transport_setup_qp_mw() calls kzalloc_node() with GFP_ATOMIC,
which does not sleep for allocation.
GFP_ATOMIC is not necessary and can be replaced with GFP_KERNEL,
which can sleep and improve the possibility of sucessful allocation.

This is found by a static analysis tool named DCNS written by myself.
And I also manually check it.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f58d8e3..08c9157 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -639,7 +639,7 @@ static int ntb_transport_setup_qp_mw(struct ntb_transport_ctx *nt,
 	 */
 	node = dev_to_node(&ndev->dev);
 	for (i = qp->rx_alloc_entry; i < qp->rx_max_entry; i++) {
-		entry = kzalloc_node(sizeof(*entry), GFP_ATOMIC, node);
+		entry = kzalloc_node(sizeof(*entry), GFP_KERNEL, node);
 		if (!entry)
 			return -ENOMEM;
 
-- 
1.9.1

