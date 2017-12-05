Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id n75si151017ljb.0.2017.12.05.14.39.43
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 14:39:43 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id a12so2131185lfe.4
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 14:39:43 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 14/15] NTB: ntb_test: Update ntb_perf tests
Date: Wed,  6 Dec 2017 01:39:17 +0300
Message-Id: <20171205223918.28727-15-fancer.lancer@gmail.com>
In-Reply-To: <20171205223918.28727-1-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

ntb_perf driver has been also updated so to have the multi-port
interface support. User now must specify what peer port is going
to be used to perform the test.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 2dea126c85eb..08cbfbbc7029 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -39,15 +39,16 @@ function show_help()
 	echo
 	echo "Options:"
 	echo "  -C              don't cleanup ntb modules on exit"
-	echo "  -d              run dma tests"
 	echo "  -h              show this help message"
 	echo "  -l              list available local and remote PCI ids"
 	echo "  -r REMOTE_HOST  specify the remote's hostname to connect"
 	echo "                  to for the test (using ssh)"
 	echo "  -m MW_SIZE      memory window size for ntb_tool"
 	echo "                  (default: $MW_SIZE)"
-	echo "  -p NUM          ntb_perf run order (default: $PERF_RUN_ORDER)"
-	echo "  -w max_mw_size  maxmium memory window size"
+	echo "  -d              run dma tests for ntb_perf"
+	echo "  -p ORDER        total data order for ntb_perf"
+	echo "                  (default: $PERF_RUN_ORDER)"
+	echo "  -w MAX_MW_SIZE  maxmium memory window size for ntb_perf"
 	echo
 }
 
@@ -460,17 +461,17 @@ function perf_test()
 		WITH="without"
 	fi
 
-	_modprobe ntb_perf run_order=$PERF_RUN_ORDER \
+	_modprobe ntb_perf total_order=$PERF_RUN_ORDER \
 		max_mw_size=$MAX_MW_SIZE use_dma=$USE_DMA
 
 	echo "Running local perf test $WITH DMA"
-	write_file "" "$LOCAL_PERF/run"
+	write_file "$LOCAL_PIDX" "$LOCAL_PERF/run"
 	echo -n "  "
 	read_file "$LOCAL_PERF/run"
 	echo "  Passed"
 
 	echo "Running remote perf test $WITH DMA"
-	write_file "" "$REMOTE_PERF/run"
+	write_file "$REMOTE_PIDX" "$REMOTE_PERF/run"
 	echo -n "  "
 	read_file "$REMOTE_PERF/run"
 	echo "  Passed"
-- 
2.12.0

