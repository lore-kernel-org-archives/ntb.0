Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com. [2a00:1450:4864:20::242])
        by gmr-mx.google.com with ESMTPS id f26si1008549lfp.5.2019.07.08.08.57.19
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 08:57:19 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id r9so16451163ljg.5
        for <linux-ntb@googlegroups.com>; Mon, 08 Jul 2019 08:57:19 -0700 (PDT)
Return-Path: <fomichev.ru@gmail.com>
Date: Mon, 8 Jul 2019 18:57:17 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: [PATCH] ntb_hw_switchtec: Fix ntb_mw_clear_trans returning error if
 size == 0
Message-ID: <20190708155717.wh4vweidewab4dpz@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
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
