Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id i11si373705wmh.2.2017.12.06.06.32.31
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:31 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id i2so4447127lfe.9
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:31 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 13/15] NTB: ntb_test: Update ntb_tool MW tests
Date: Wed,  6 Dec 2017 17:32:04 +0300
Message-Id: <20171206143206.14665-14-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

There are devices (like IDT PCIe switches), which outbound MWs xlat address
is setup on peer side. In this case local side is supposed to allocate
a memory buffer and somehow deliver the xlat DMA address to peer so one
could set the outbound MW up. The MW test is altered so to support both
previous Intel/AMD and new IDT-like devices.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 89 +++++++++++++++++++++++++--------
 1 file changed, 68 insertions(+), 21 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 849191fd2308..2dea126c85eb 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -43,7 +43,9 @@ function show_help()
 	echo "  -h              show this help message"
 	echo "  -l              list available local and remote PCI ids"
 	echo "  -r REMOTE_HOST  specify the remote's hostname to connect"
-        echo "                  to for the test (using ssh)"
+	echo "                  to for the test (using ssh)"
+	echo "  -m MW_SIZE      memory window size for ntb_tool"
+	echo "                  (default: $MW_SIZE)"
 	echo "  -p NUM          ntb_perf run order (default: $PERF_RUN_ORDER)"
 	echo "  -w max_mw_size  maxmium memory window size"
 	echo
@@ -316,6 +318,32 @@ function message_test()
 	echo "  Passed"
 }
 
+function get_number()
+{
+	KEY=$1
+
+	sed -n "s/^\(${KEY}\)[ \t]*\(0x[0-9a-fA-F]*\)\(\[p\]\)\?$/\2/p"
+}
+
+function mw_alloc()
+{
+	IDX=$1
+	LOC=$2
+	REM=$3
+
+	write_file $MW_SIZE "$LOC/mw_trans$IDX"
+
+	INB_MW=$(read_file "$LOC/mw_trans$IDX")
+	MW_ALIGNED_SIZE=$(echo "$INB_MW" | get_number "Window Size")
+	MW_DMA_ADDR=$(echo "$INB_MW" | get_number "DMA Address")
+
+	write_file "$MW_DMA_ADDR:$(($MW_ALIGNED_SIZE))" "$REM/peer_mw_trans$IDX"
+
+	if [[ $MW_SIZE -ne $MW_ALIGNED_SIZE ]]; then
+		echo "MW $IDX size aligned to $MW_ALIGNED_SIZE"
+	fi
+}
+
 function write_mw()
 {
 	split_remote $2
@@ -328,17 +356,15 @@ function write_mw()
 	fi
 }
 
-function mw_test()
+function mw_check()
 {
 	IDX=$1
 	LOC=$2
 	REM=$3
 
-	echo "Running $IDX tests on: $(basename $LOC) / $(basename $REM)"
-
-	write_mw "$LOC/$IDX"
+	write_mw "$LOC/mw$IDX"
 
-	split_remote "$LOC/$IDX"
+	split_remote "$LOC/mw$IDX"
 	if [[ "$REMOTE" == "" ]]; then
 		A=$VPATH
 	else
@@ -346,7 +372,7 @@ function mw_test()
 		ssh "$REMOTE" cat "$VPATH" > "$A"
 	fi
 
-	split_remote "$REM/peer_$IDX"
+	split_remote "$REM/peer_mw$IDX"
 	if [[ "$REMOTE" == "" ]]; then
 		B=$VPATH
 	else
@@ -354,7 +380,7 @@ function mw_test()
 		ssh "$REMOTE" cat "$VPATH" > "$B"
 	fi
 
-	cmp -n $MW_SIZE "$A" "$B"
+	cmp -n $MW_ALIGNED_SIZE "$A" "$B"
 	if [[ $? != 0 ]]; then
 		echo "Memory window $MW did not match!" >&2
 	fi
@@ -366,8 +392,39 @@ function mw_test()
 	if [[ "$B" == "/tmp/*" ]]; then
 		rm "$B"
 	fi
+}
+
+function mw_free()
+{
+	IDX=$1
+	LOC=$2
+	REM=$3
+
+	write_file "$MW_DMA_ADDR:0" "$REM/peer_mw_trans$IDX"
+
+	write_file 0 "$LOC/mw_trans$IDX"
+}
+
+function mw_test()
+{
+	LOC=$1
+	REM=$2
+
+	CNT=$(get_files_count "mw_trans" "$LOC")
+
+	for ((i = 0; i < $CNT; i++)); do
+		echo "Running mw$i tests on: $(subdirname $LOC) / " \
+		     "$(subdirname $REM)"
+
+		mw_alloc $i $LOC $REM
+
+		mw_check $i $LOC $REM
+
+		mw_free $i $LOC  $REM
+
+		echo "  Passed"
+	done
 
-	echo "  Passed"
 }
 
 function pingpong_test()
@@ -451,18 +508,8 @@ function ntb_tool_tests()
 	message_test "$LOCAL_PEER_TOOL" "$REMOTE_PEER_TOOL"
 	message_test "$REMOTE_PEER_TOOL" "$LOCAL_PEER_TOOL"
 
-	for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
-		PT=$(basename $PEER_TRANS)
-		write_file $MW_SIZE "$LOCAL_TOOL/$PT"
-		write_file $MW_SIZE "$REMOTE_TOOL/$PT"
-	done
-
-	for MW in $(ls "$LOCAL_TOOL"/mw*); do
-		MW=$(basename $MW)
-
-		mw_test $MW "$LOCAL_TOOL" "$REMOTE_TOOL"
-		mw_test $MW "$REMOTE_TOOL" "$LOCAL_TOOL"
-	done
+	mw_test "$LOCAL_PEER_TOOL" "$REMOTE_PEER_TOOL"
+	mw_test "$REMOTE_PEER_TOOL" "$LOCAL_PEER_TOOL"
 
 	_modprobe -r ntb_tool
 }
-- 
2.12.0

