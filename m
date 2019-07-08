Return-Path: <fomichev.ru@gmail.com>
Received: from alfbook-pro.local ([89.207.88.249])
        by gmr-mx.google.com with ESMTP id s30si640733eda.4.2019.07.08.06.17.22
        for <linux-ntb@googlegroups.com>;
        Mon, 08 Jul 2019 06:17:22 -0700 (PDT)
Date: Mon, 8 Jul 2019 16:17:20 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: [PATCH] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning error if
 size == 0
Message-ID: <20190708131720.z4tt2a2hofpbl4dc@alfbook-pro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com
Cc: linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

ntb_mw_set_trans should work as ntb_mw_clear_trans when size == 0 and/or
addr == 0. But error in xlate_pos checking condition prevents this.
Fix the condition to make ntb_mw_clear_trans working.
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index 1e2f627d3bac..19d46af19650 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -299,7 +299,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (widx >= switchtec_ntb_mw_count(ntb, pidx))
 		return -EINVAL;
 
-	if (xlate_pos < 12)
+	if (size != 0 && xlate_pos < 12)
 		return -EINVAL;
 
 	if (!IS_ALIGNED(addr, BIT_ULL(xlate_pos))) {
-- 
2.17.1
