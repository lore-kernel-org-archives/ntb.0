Return-Path: <wesley.sheng@microchip.com>
Received: from esa5.microchip.iphmx.com (esa5.microchip.iphmx.com. [216.71.150.166])
        by gmr-mx.google.com with ESMTPS id d2si1157383otb.1.2019.04.29.19.06.00
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Apr 2019 19:06:01 -0700 (PDT)
From: Wesley Sheng <wesley.sheng@microchip.com>
Subject: [PATCH] NTB: correct ntb_dev_ops and ntb_dev comment typos
Date: Tue, 30 Apr 2019 18:04:29 +0800
Message-ID: <1556618669-2434-1-git-send-email-wesley.sheng@microchip.com>
Return-Path: wesley.sheng@microchip.com
MIME-Version: 1.0
Content-Type: text/plain
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, logang@deltatee.com, Wesley Sheng <wesley.sheng@microchip.com>
List-ID: <linux-ntb.googlegroups.com>

The comment for ntb_dev_ops and ntb_dev incorrectly referred to
ntb_ctx_ops and ntb_device.

Signed-off-by: Wesley Sheng <wesley.sheng@microchip.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 include/linux/ntb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 56a92e3..604abc8 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -205,7 +205,7 @@ static inline int ntb_ctx_ops_is_valid(const struct ntb_ctx_ops *ops)
 }
 
 /**
- * struct ntb_ctx_ops - ntb device operations
+ * struct ntb_dev_ops - ntb device operations
  * @port_number:	See ntb_port_number().
  * @peer_port_count:	See ntb_peer_port_count().
  * @peer_port_number:	See ntb_peer_port_number().
@@ -404,7 +404,7 @@ struct ntb_client {
 #define drv_ntb_client(__drv) container_of((__drv), struct ntb_client, drv)
 
 /**
- * struct ntb_device - ntb device
+ * struct ntb_dev - ntb device
  * @dev:		Linux device object.
  * @pdev:		PCI device entry of the ntb.
  * @topo:		Detected topology of the ntb.
-- 
2.7.4

