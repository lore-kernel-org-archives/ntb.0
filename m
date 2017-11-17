Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org. [140.211.169.12])
        by gmr-mx.google.com with ESMTPS id i76si326295wmd.0.2017.11.17.06.20.34
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Nov 2017 06:20:34 -0800 (PST)
Date: Fri, 17 Nov 2017 15:20:38 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH] ntb: remove unneeded DRIVER_LICENSE #defines
Message-ID: <20171117142038.GE17880@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Gary R Hook <gary.hook@amd.com>, Serge Semin <fancer.lancer@gmail.com>
Cc: linux-kernel@vger.kernel.org, Philippe Ombredanne <pombredanne@nexb.com>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

There is no need to #define the license of the driver, just put it in
the MODULE_LICENSE() line directly as a text string.

This allows tools that check that the module license matches the source
code license to work properly, as there is no need to unwind the
unneeded dereference, especially when the string is defined just a few
lines above the usage of it.

Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Gary R Hook <gary.hook@amd.com>
Cc: Serge Semin <fancer.lancer@gmail.com>
Reported-by: Philippe Ombredanne <pombredanne@nexb.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/ntb/ntb.c               | 3 +--
 drivers/ntb/test/ntb_perf.c     | 3 +--
 drivers/ntb/test/ntb_pingpong.c | 3 +--
 drivers/ntb/test/ntb_tool.c     | 3 +--
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/ntb/ntb.c b/drivers/ntb/ntb.c
index 03b80d89b980..bdcd59b13c1f 100644
--- a/drivers/ntb/ntb.c
+++ b/drivers/ntb/ntb.c
@@ -63,12 +63,11 @@
 #define DRIVER_NAME			"ntb"
 #define DRIVER_DESCRIPTION		"PCIe NTB Driver Framework"
 
-#define DRIVER_LICENSE			"Dual BSD/GPL"
 #define DRIVER_VERSION			"1.0"
 #define DRIVER_RELDATE			"24 March 2015"
 #define DRIVER_AUTHOR			"Allen Hubbe <Allen.Hubbe@emc.com>"
 
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 759f772fa00c..d2b2e5958540 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -63,7 +63,6 @@
 #define DRIVER_NAME		"ntb_perf"
 #define DRIVER_DESCRIPTION	"PCIe NTB Performance Measurement Tool"
 
-#define DRIVER_LICENSE		"Dual BSD/GPL"
 #define DRIVER_VERSION		"1.0"
 #define DRIVER_AUTHOR		"Dave Jiang <dave.jiang@intel.com>"
 
@@ -78,7 +77,7 @@
 #define MAX_SEG_ORDER		20 /* no larger than 1M for kmalloc buffer */
 #define PIDX			NTB_DEF_PEER_IDX
 
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
diff --git a/drivers/ntb/test/ntb_pingpong.c b/drivers/ntb/test/ntb_pingpong.c
index 938a18bcfc3f..250cc286b768 100644
--- a/drivers/ntb/test/ntb_pingpong.c
+++ b/drivers/ntb/test/ntb_pingpong.c
@@ -68,12 +68,11 @@
 #define DRIVER_NAME			"ntb_pingpong"
 #define DRIVER_DESCRIPTION		"PCIe NTB Simple Pingpong Client"
 
-#define DRIVER_LICENSE			"Dual BSD/GPL"
 #define DRIVER_VERSION			"1.0"
 #define DRIVER_RELDATE			"24 March 2015"
 #define DRIVER_AUTHOR			"Allen Hubbe <Allen.Hubbe@emc.com>"
 
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index a69815c45ce6..c45b8f798f7b 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -109,12 +109,11 @@
 #define DRIVER_NAME			"ntb_tool"
 #define DRIVER_DESCRIPTION		"PCIe NTB Debugging Tool"
 
-#define DRIVER_LICENSE			"Dual BSD/GPL"
 #define DRIVER_VERSION			"1.0"
 #define DRIVER_RELDATE			"22 April 2015"
 #define DRIVER_AUTHOR			"Allen Hubbe <Allen.Hubbe@emc.com>"
 
-MODULE_LICENSE(DRIVER_LICENSE);
+MODULE_LICENSE("Dual BSD/GPL");
 MODULE_VERSION(DRIVER_VERSION);
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESCRIPTION);
-- 
2.15.0

