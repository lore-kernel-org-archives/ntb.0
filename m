Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com. [2a00:1450:4010:c07::241])
        by gmr-mx.google.com with ESMTPS id q27si343566lfd.0.2017.12.06.06.32.30
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Dec 2017 06:32:30 -0800 (PST)
Received: by mail-lf0-x241.google.com with SMTP id l81so4462287lfl.6
        for <linux-ntb@googlegroups.com>; Wed, 06 Dec 2017 06:32:30 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v4 12/15] NTB: ntb_test: Add ntb_tool Message tests
Date: Wed,  6 Dec 2017 17:32:03 +0300
Message-Id: <20171206143206.14665-13-fancer.lancer@gmail.com>
In-Reply-To: <20171206143206.14665-1-fancer.lancer@gmail.com>
References: <20171205223918.28727-1-fancer.lancer@gmail.com>
 <20171206143206.14665-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Messages NTB API is now available. ntb_tool driver has been altered
to perform messages send and receive operation. The test of messages
read/write to/from peer device has been added to the script.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 37 +++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 06b9b156a6fc..849191fd2308 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -282,6 +282,40 @@ function scratchpad_test()
 	echo "  Passed"
 }
 
+function message_test()
+{
+	LOC=$1
+	REM=$2
+
+	echo "Running msg tests on: $(subdirname $LOC) / $(subdirname $REM)"
+
+	CNT=$(get_files_count "msg" "$LOC")
+
+	if [[ $CNT -eq 0 ]]; then
+		echo "  Unsupported"
+		return
+	fi
+
+	MSG_OUTBITS_MASK=$(read_file "$LOC/../msg_inbits")
+	MSG_INBITS_MASK=$(read_file "$REM/../msg_inbits")
+
+	write_file "c $MSG_OUTBITS_MASK" "$LOC/../msg_sts"
+	write_file "c $MSG_INBITS_MASK" "$REM/../msg_sts"
+
+	for ((i = 0; i < $CNT; i++)); do
+		VAL=$RANDOM
+		write_file "$VAL" "$LOC/msg$i"
+		RVAL=$(read_file "$REM/../msg$i")
+
+		if [[ "$VAL" -ne "${RVAL%%<-*}" ]]; then
+			echo "Message $i value $RVAL doesn't match $VAL" >&2
+			exit -1
+		fi
+	done
+
+	echo "  Passed"
+}
+
 function write_mw()
 {
 	split_remote $2
@@ -414,6 +448,9 @@ function ntb_tool_tests()
 	scratchpad_test "$LOCAL_PEER_TOOL" "$REMOTE_PEER_TOOL"
 	scratchpad_test "$REMOTE_PEER_TOOL" "$LOCAL_PEER_TOOL"
 
+	message_test "$LOCAL_PEER_TOOL" "$REMOTE_PEER_TOOL"
+	message_test "$REMOTE_PEER_TOOL" "$LOCAL_PEER_TOOL"
+
 	for PEER_TRANS in $(ls "$LOCAL_TOOL"/peer_trans*); do
 		PT=$(basename $PEER_TRANS)
 		write_file $MW_SIZE "$LOCAL_TOOL/$PT"
-- 
2.12.0

