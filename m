Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x236.google.com (mail-lf0-x236.google.com. [2a00:1450:4010:c07::236])
        by gmr-mx.google.com with ESMTPS id i88si340198lfh.4.2017.12.06.06.32.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:29 -0800 (PST)
Received: by mail-lf0-x236.google.com with SMTP id f18so4452354lfg.8
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:29 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 11/15] NTB: ntb_test: Update ntb_tool Scratchpad tests
Date: Wed,  6 Dec 2017 17:32:02 +0300
Message-Id: <20171206143206.14665-12-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Scratchpad NTB API has changed so has the ntb_tool driver. Outbound
Scratchpad DebugFS files have been moved to peer specific directories.
Each scratchpad is now available via separate file. The test code
has been accordingly altered.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 43 ++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index ec2e51183f8d..06b9b156a6fc 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -239,35 +239,44 @@ function doorbell_test()
 	echo "  Passed"
 }
 
-function read_spad()
+function get_files_count()
 {
-       VPATH=$1
-       IDX=$2
+	NAME=$1
+	LOC=$2
+
+	split_remote $LOC
 
-       ROW=($(read_file "$VPATH" | grep -e "^$IDX"))
-       let VAL=${ROW[1]} || true
-       echo $VAL
+	if [[ "$REMOTE" == "" ]]; then
+		echo $(ls -1 "$LOC"/${NAME}* 2>/dev/null | wc -l)
+	else
+		echo $(ssh "$REMOTE" "ls -1 \"$VPATH\"/${NAME}* | \
+		       wc -l" 2> /dev/null)
+	fi
 }
 
 function scratchpad_test()
 {
 	LOC=$1
 	REM=$2
-	CNT=$(read_file "$LOC/spad" | wc -l)
 
-	echo "Running spad tests on: $(basename $LOC) / $(basename $REM)"
+	echo "Running spad tests on: $(subdirname $LOC) / $(subdirname $REM)"
+
+	CNT=$(get_files_count "spad" "$LOC")
+
+	if [[ $CNT -eq 0 ]]; then
+		echo "  Unsupported"
+		return
+	fi
 
 	for ((i = 0; i < $CNT; i++)); do
 		VAL=$RANDOM
-		write_file "$i $VAL" "$LOC/peer_spad"
-		RVAL=$(read_spad "$REM/spad" $i)
+		write_file "$VAL" "$LOC/spad$i"
+		RVAL=$(read_file "$REM/../spad$i")
 
-		if [[ "$VAL" != "$RVAL" ]]; then
-			echo "Scratchpad doesn't match expected value $VAL " \
-			     "in $REM/spad, got $RVAL" >&2
+		if [[ "$VAL" -ne "$RVAL" ]]; then
+			echo "Scratchpad $i value $RVAL doesn't match $VAL" >&2
 			exit -1
 		fi
-
 	done
 
 	echo "  Passed"
@@ -402,15 +411,15 @@ function ntb_tool_tests()
 	doorbell_test "$LOCAL_TOOL" "$REMOTE_TOOL"
 	doorbell_test "$REMOTE_TOOL" "$LOCAL_TOOL"
 
+	scratchpad_test "$LOCAL_PEER_TOOL" "$REMOTE_PEER_TOOL"
+	scratchpad_test "$REMOTE_PEER_TOOL" "$LOCAL_PEER_TOOL"
+
 	for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
 		PT=$(basename $PEER_TRANS)
 		write_file $MW_SIZE "$LOCAL_TOOL/$PT"
 		write_file $MW_SIZE "$REMOTE_TOOL/$PT"
 	done
 
-	scratchpad_test "$LOCAL_TOOL" "$REMOTE_TOOL"
-	scratchpad_test "$REMOTE_TOOL" "$LOCAL_TOOL"
-
 	for MW in $(ls "$LOCAL_TOOL"/mw*); do
 		MW=$(basename $MW)
 
-- 
2.12.0

