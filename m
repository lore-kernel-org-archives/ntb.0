Return-Path: <Allen.Hubbe@dell.com>
Received: from esa5.dell-outbound.iphmx.com (esa5.dell-outbound.iphmx.com. [68.232.153.95])
        by gmr-mx.google.com with ESMTPS id x138si3676665ywx.6.2016.12.27.16.13.28
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 16:13:28 -0800 (PST)
From: Allen Hubbe <Allen.Hubbe@dell.com>
Subject: [PATCH 1/2] NTB: ntb_test: modprobe on remote host
Date: Tue, 27 Dec 2016 19:12:27 -0500
Message-Id: <6a532e4dff499983cd96bc9a4653686a88d9cb08.1482883799.git.Allen.Hubbe@dell.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Logan Gunthorpe <logang@deltatee.com>, Allen Hubbe <Allen.Hubbe@dell.com>
List-ID: <linux-ntb.googlegroups.com>

Signed-off-by: Allen Hubbe <Allen.Hubbe@dell.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index a676d3eefefb..4e70e19255bc 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -85,6 +85,10 @@ set -e
 function _modprobe()
 {
         modprobe "$@"
+
+	if [[ "$REMOTE_HOST" != "" ]]; then
+		ssh "$REMOTE_HOST" modprobe "$@"
+	fi
 }
 
 function split_remote()
-- 
2.9.1

