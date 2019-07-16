Return-Path: <fomichev.ru@gmail.com>
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com. [2a00:1450:4864:20::244])
        by gmr-mx.google.com with ESMTPS id z18si1055370lfh.1.2019.07.16.10.34.50
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 10:34:50 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id x25so20813393ljh.2
        for <linux-ntb@googlegroups.com>; Tue, 16 Jul 2019 10:34:50 -0700 (PDT)
Return-Path: <fomichev.ru@gmail.com>
Date: Tue, 16 Jul 2019 20:34:48 +0300
From: Alexander Fomichev <fomichev.ru@gmail.com>
Subject: [PATCH] ntb_hw_switchtec: make ntb_mw_set_trans() work when addr == 0
Message-ID: <20190716173448.eswemneatvjwnxny@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org
Cc: Logan Gunthorpe <logang@deltatee.com>, Allen Hubbe <allenbh@gmail.com>, linux@yadro.com
List-ID: <linux-ntb.googlegroups.com>

On switchtec_ntb_mw_set_trans() call, when (only) address == 0, it acts as
ntb_mw_clear_trans(). Fix this, since address == 0 and size != 0 is valid
combination for setting translation.

Signed-off-by: Alexander Fomichev <fomichev.ru@gmail.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index db49677..45b9513 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -305,7 +305,7 @@ static int switchtec_ntb_mw_set_trans(struct ntb_dev *ntb, int pidx, int widx,
 	if (rc)
 		return rc;
 
-	if (addr == 0 || size == 0) {
+	if (size == 0) {
 		if (widx < nr_direct_mw)
 			switchtec_ntb_mw_clr_direct(sndev, widx);
 		else
-- 
2.7.4
