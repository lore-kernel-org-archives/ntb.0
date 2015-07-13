Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id s127si1875965ywc.6.2015.07.13.10.07.40
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Jul 2015 10:07:40 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH v2 08/14] NTB: Add list to MAINTAINERS
Date: Mon, 13 Jul 2015 08:07:16 -0400
Message-Id: <e538ec8bcba349c2fa0a1669153623e5f5f98666.1436788771.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788051.git.Allen.Hubbe@emc.com>
References: <cover.1436788051.git.Allen.Hubbe@emc.com>
In-Reply-To: <cover.1436788771.git.Allen.Hubbe@emc.com>
References: <cover.1436788771.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>
List-ID: <linux-ntb.googlegroups.com>

From: Jon Mason <jdmason@kudzu.us>

Add the new NTB mailing list to MAINTAINERS

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8133cefb6b6e..6a634882b420 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7223,6 +7223,7 @@ NTB DRIVER CORE
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Allen Hubbe <Allen.Hubbe@emc.com>
+L:	linux-ntb@googlegroups.com
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
@@ -7234,6 +7235,7 @@ F:	include/linux/ntb_transport.h
 NTB INTEL DRIVER
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
+L:	linux-ntb@googlegroups.com
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
-- 
2.5.0.rc1

