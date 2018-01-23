Return-Path: <weiyongjun1@huawei.com>
Received: from huawei.com (szxga04-in.huawei.com. [45.249.212.190])
        by gmr-mx.google.com with ESMTPS id a13si515609ybk.2.2018.01.22.18.03.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jan 2018 18:03:00 -0800 (PST)
From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] ntb_hw_switchtec: Make function switchtec_ntb_remove() static
Date: Tue, 23 Jan 2018 02:09:21 +0000
Message-ID: <1516673361-170397-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
To: Kurt Schwemmer <kurt.schwemmer@microsemi.com>, Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, linux-pci@vger.kernel.org, linux-ntb@googlegroups.com, kernel-janitors@vger.kernel.org
List-ID: <linux-ntb.googlegroups.com>

Fixes the following sparse warnings:

drivers/ntb/hw/mscc/ntb_hw_switchtec.c:1552:6: warning:
 symbol 'switchtec_ntb_remove' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/ntb/hw/mscc/ntb_hw_switchtec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
index a1d547b6..f624ae2 100644
--- a/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
+++ b/drivers/ntb/hw/mscc/ntb_hw_switchtec.c
@@ -1549,8 +1549,8 @@ static int switchtec_ntb_add(struct device *dev,
 	return rc;
 }
 
-void switchtec_ntb_remove(struct device *dev,
-			  struct class_interface *class_intf)
+static void switchtec_ntb_remove(struct device *dev,
+				 struct class_interface *class_intf)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 	struct switchtec_ntb *sndev = stdev->sndev;

