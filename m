Return-Path: <yang.lee@linux.alibaba.com>
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com. [115.124.30.56])
        by gmr-mx.google.com with ESMTPS id k10si143046qko.0.2021.12.21.17.55.24
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 17:55:27 -0800 (PST)
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH next] NTB/msi: Fix ntbm_msi_request_threaded_irq() kernel-doc comment
Date: Wed, 22 Dec 2021 09:55:13 +0800
Message-Id: <20211222015513.23106-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>
List-ID: <linux-ntb.googlegroups.com>

Add the description of @msi_desc and change the @devname to @name
in ntbm_msi_request_threaded_irq() kernel-doc comment to remove
some warnings found by running scripts/kernel-doc, which is caused
by using 'make W=1'.
drivers/ntb/msi.c:285: warning: Function parameter or member 'name' not
described in 'ntbm_msi_request_threaded_irq'
drivers/ntb/msi.c:285: warning: Function parameter or member 'msi_desc'
not described in 'ntbm_msi_request_threaded_irq'
drivers/ntb/msi.c:285: warning: Excess function parameter 'devname'
description in 'ntbm_msi_request_threaded_irq'

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/msi.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 2818bfcf4031..dd683cb58d09 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -262,8 +262,9 @@ static int ntbm_msi_setup_callback(struct ntb_dev *ntb, struct msi_desc *entry,
  * @handler:	Function to be called when the IRQ occurs
  * @thread_fn:  Function to be called in a threaded interrupt context. NULL
  *              for clients which handle everything in @handler
- * @devname:    An ascii name for the claiming device, dev_name(dev) if NULL
+ * @name:    An ascii name for the claiming device, dev_name(dev) if NULL
  * @dev_id:     A cookie passed back to the handler function
+ * @msi_desc:	MSI descriptor data which triggers the interrupt
  *
  * This function assigns an interrupt handler to an unused
  * MSI interrupt and returns the descriptor used to trigger
-- 
2.20.1.7.g153144c

