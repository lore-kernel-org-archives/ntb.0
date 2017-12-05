Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x244.google.com (mail-lf0-x244.google.com. [2a00:1450:4010:c07::244])
        by gmr-mx.google.com with ESMTPS id c69si138192ljd.4.2017.12.05.14.39.39
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 14:39:39 -0800 (PST)
Received: by mail-lf0-x244.google.com with SMTP id r143so2108170lfe.13
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 14:39:39 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 10/15] NTB: ntb_test: Update ntb_tool DB tests
Date: Wed,  6 Dec 2017 01:39:13 +0300
Message-Id: <20171205223918.28727-11-fancer.lancer@gmail.com>
In-Reply-To: <20171205223918.28727-1-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

DB interface of ntb_tool driver hasn't been changed much, but
db_valid_mask DebugFS file has still been added. In this case
it's much better to test all valid DB bits instead of using
the predefined mask, which may be incorrect in general.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index a3942f31c057..ec2e51183f8d 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -18,7 +18,6 @@ LIST_DEVS=FALSE
 
 DEBUGFS=${DEBUGFS-/sys/kernel/debug}
 
-DB_BITMASK=0x7FFF
 PERF_RUN_ORDER=32
 MAX_MW_SIZE=0
 RUN_DMA_TESTS=
@@ -39,7 +38,6 @@ function show_help()
 	echo "be highly recommended."
 	echo
 	echo "Options:"
-	echo "  -b BITMASK      doorbell clear bitmask for ntb_tool"
 	echo "  -C              don't cleanup ntb modules on exit"
 	echo "  -d              run dma tests"
 	echo "  -h              show this help message"
@@ -56,7 +54,6 @@ function parse_args()
 	OPTIND=0
 	while getopts "b:Cdhlm:r:p:w:" opt; do
 		case "$opt" in
-		b)  DB_BITMASK=${OPTARG} ;;
 		C)  DONT_CLEANUP=1 ;;
 		d)  RUN_DMA_TESTS=1 ;;
 		h)  show_help; exit 0 ;;
@@ -215,21 +212,30 @@ function doorbell_test()
 
 	echo "Running db tests on: $(basename $LOC) / $(basename $REM)"
 
-	write_file "c $DB_BITMASK" "$REM/db"
+	DB_VALID_MASK=$(read_file "$LOC/db_valid_mask")
 
-	for ((i=1; i <= 8; i++)); do
-		let DB=$(read_file "$REM/db") || true
-		if [[ "$DB" != "$EXP" ]]; then
+	write_file "c $DB_VALID_MASK" "$REM/db"
+
+	for ((i = 0; i < 64; i++)); do
+		DB=$(read_file "$REM/db")
+		if [[ "$DB" -ne "$EXP" ]]; then
 			echo "Doorbell doesn't match expected value $EXP " \
 			     "in $REM/db" >&2
 			exit -1
 		fi
 
-		let "MASK=1 << ($i-1)" || true
-		let "EXP=$EXP | $MASK" || true
+		let "MASK = (1 << $i) & $DB_VALID_MASK" || true
+		let "EXP = $EXP | $MASK" || true
+
 		write_file "s $MASK" "$LOC/peer_db"
 	done
 
+	write_file "c $DB_VALID_MASK" "$REM/db_mask"
+	write_file $DB_VALID_MASK "$REM/db_event"
+	write_file "s $DB_VALID_MASK" "$REM/db_mask"
+
+	write_file "c $DB_VALID_MASK" "$REM/db"
+
 	echo "  Passed"
 }
 
@@ -393,14 +399,15 @@ function ntb_tool_tests()
 	write_file "Y" "$LOCAL_PEER_TOOL/link_event"
 	write_file "Y" "$REMOTE_PEER_TOOL/link_event"
 
+	doorbell_test "$LOCAL_TOOL" "$REMOTE_TOOL"
+	doorbell_test "$REMOTE_TOOL" "$LOCAL_TOOL"
+
 	for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
 		PT=$(basename $PEER_TRANS)
 		write_file $MW_SIZE "$LOCAL_TOOL/$PT"
 		write_file $MW_SIZE "$REMOTE_TOOL/$PT"
 	done
 
-	doorbell_test "$LOCAL_TOOL" "$REMOTE_TOOL"
-	doorbell_test "$REMOTE_TOOL" "$LOCAL_TOOL"
 	scratchpad_test "$LOCAL_TOOL" "$REMOTE_TOOL"
 	scratchpad_test "$REMOTE_TOOL" "$LOCAL_TOOL"
 
-- 
2.12.0

