Return-Path: <yang.lee@linux.alibaba.com>
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com. [115.124.30.133])
        by gmr-mx.google.com with ESMTPS id w7si401881plp.5.2021.06.04.03.21.26
        for <linux-ntb@googlegroups.com>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 03:21:27 -0700 (PDT)
From: Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH 2/2] NTB: Fix an error code in ntb_msit_probe()
Date: Fri,  4 Jun 2021 18:20:51 +0800
Message-Id: <1622802051-43464-2-git-send-email-yang.lee@linux.alibaba.com>
In-Reply-To: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
References: <1622802051-43464-1-git-send-email-yang.lee@linux.alibaba.com>
To: jdmason@kudzu.us
Cc: dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Yang Li <yang.lee@linux.alibaba.com>
List-ID: <linux-ntb.googlegroups.com>

When the value of nm->isr_ctx is false, the value of ret is 0.
So, we set ret to -ENOMEM to indicate this error.

Clean up smatch warning:
drivers/ntb/test/ntb_msi_test.c:373 ntb_msit_probe() warn: missing error
code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/test/ntb_msi_test.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_msi_test.c b/drivers/ntb/test/ntb_msi_test.c
index 7095ecd..5f9e0be 100644
--- a/drivers/ntb/test/ntb_msi_test.c
+++ b/drivers/ntb/test/ntb_msi_test.c
@@ -369,8 +369,10 @@ static int ntb_msit_probe(struct ntb_client *client, struct ntb_dev *ntb)
 	if (ret)
 		goto remove_dbgfs;
 
-	if (!nm->isr_ctx)
+	if (!nm->isr_ctx) {
+		return -ENOMEM;
 		goto remove_dbgfs;
+	}
 
 	ntb_link_enable(ntb, NTB_SPEED_AUTO, NTB_WIDTH_AUTO);
 
-- 
1.8.3.1

