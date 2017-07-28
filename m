Return-Path: <dave.jiang@intel.com>
Received: from mga09.intel.com (mga09.intel.com. [134.134.136.24])
        by gmr-mx.google.com with ESMTPS id g67si2850148pfj.6.2017.07.28.15.16.05
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Jul 2017 15:16:05 -0700 (PDT)
Subject: [PATCH] ntb: update maintainer list for Intel NTB driver
From: Dave Jiang <dave.jiang@intel.com>
Date: Fri, 28 Jul 2017 15:16:04 -0700
Message-ID: <150128016434.49155.11346214975331646100.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: jdmason@kudzu.us
Cc: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Removing Jon since he no longer works at Intel.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f66488d..7a634fb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9397,12 +9397,11 @@ S:	Supported
 F:	drivers/ntb/hw/idt/
 
 NTB INTEL DRIVER
-M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
 L:	linux-ntb@googlegroups.com
 S:	Supported
-W:	https://github.com/jonmason/ntb/wiki
-T:	git git://github.com/jonmason/ntb.git
+W:	https://github.com/davejiang/linux/wiki
+T:	git https://github.com/davejiang/linux.git
 F:	drivers/ntb/hw/intel/
 
 NTFS FILESYSTEM

