Return-Path: <jdmason@kudzu.us>
Received: from mail-yk0-f169.google.com (mail-yk0-f169.google.com. [209.85.160.169])
        by gmr-mx.google.com with ESMTPS id x125si1406784ywb.0.2015.07.04.11.59.06
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2015 11:59:06 -0700 (PDT)
Received: by ykfy125 with SMTP id y125so119047211ykf.1
        for <linux-ntb@googlegroups.com>; Sat, 04 Jul 2015 11:59:06 -0700 (PDT)
Return-Path: <jdmason@kudzu.us>
Received: from nas (107-223-188-137.lightspeed.rlghnc.sbcglobal.net. [107.223.188.137])
        by mx.google.com with ESMTPSA id v64sm13295426ywa.20.2015.07.04.11.59.05
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Jul 2015 11:59:06 -0700 (PDT)
From: Jon Mason <jdmason@kudzu.us>
Subject: [PATCH] NTB: Add list to MAINTAINERS
Date: Sat,  4 Jul 2015 14:59:03 -0400
Message-Id: <1436036343-951-1-git-send-email-jdmason@kudzu.us>
To: linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

Add the new NTB mailing list to MAINTAINERS

Signed-off-by: Jon Mason <jdmason@kudzu.us>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a682805..d048f59 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6999,6 +6999,7 @@ NTB DRIVER CORE
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Allen Hubbe <Allen.Hubbe@emc.com>
+L:	linux-ntb@googlegroups.com
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
@@ -7010,6 +7011,7 @@ F:	include/linux/ntb_transport.h
 NTB INTEL DRIVER
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
+L:	linux-ntb@googlegroups.com
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
-- 
2.4.5

