Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id j11si1074052itb.3.2017.06.05.09.13.33
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jun 2017 09:13:33 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Mon,  5 Jun 2017 10:13:24 -0600
Message-Id: <20170605161324.11696-1-logang@deltatee.com>
Subject: [PATCH] NTB: ntb_test: fix bug printing ntb_perf results
To: linux-ntb@googlegroups.com
Cc: Logan Gunthorpe <logang@deltatee.com>, Jon Mason <jdmason@kudzu.us>, Allen Hubbe <Allen.Hubbe@dell.com>
List-ID: <linux-ntb.googlegroups.com>

The code mistakenly prints the local perf results for the remote test
so the script reports identical results for both directions. Fix this
by ensuring we print the remote result.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <Allen.Hubbe@dell.com>
---

 Oops, this was my own bug.

 tools/testing/selftests/ntb/ntb_test.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index a676d3eefefb..13f5198ba0ee 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -305,7 +305,7 @@ function perf_test()
 	echo "Running remote perf test $WITH DMA"
 	write_file "" $REMOTE_PERF/run
 	echo -n "  "
-	read_file $LOCAL_PERF/run
+	read_file $REMOTE_PERF/run
 	echo "  Passed"

 	_modprobe -r ntb_perf
--
2.11.0
