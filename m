Return-Path: <wsa+renesas@sang-engineering.com>
Received: from pokefinder.org (sauhun.de. [88.99.104.3])
        by gmr-mx.google.com with ESMTP id g12-v6si46794wrm.4.2018.05.06.04.24.22
        for <linux-ntb@googlegroups.com>;
        Sun, 06 May 2018 04:24:22 -0700 (PDT)
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [PATCH 6/9] NTB: ntb_hw_idt: fix typo 'can by' to 'can be'
Date: Sun,  6 May 2018 13:23:50 +0200
Message-Id: <20180506112404.24872-7-wsa+renesas@sang-engineering.com>
In-Reply-To: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
References: <20180506112404.24872-1-wsa+renesas@sang-engineering.com>
To: trivial@kernel.org
Cc: linux-renesas-soc@vger.kernel.org, Wolfram Sang <wsa+renesas@sang-engineering.com>, Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 8d98872d0983b7..dbe72f116017ab 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -1401,7 +1401,7 @@ static int idt_ntb_peer_mw_clear_trans(struct ntb_dev *ntb, int pidx,
  *                          5. Doorbell operations
  *
  *    Doorbell functionality of IDT PCIe-switches is pretty unusual. First of
- * all there is global doorbell register which state can by changed by any
+ * all there is global doorbell register which state can be changed by any
  * NT-function of the IDT device in accordance with global permissions. These
  * permissions configs are not supported by NTB API, so it must be done by
  * either BIOS or EEPROM settings. In the same way the state of the global
-- 
2.11.0

