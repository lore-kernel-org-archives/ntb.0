Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id j81si181528wmd.1.2017.12.03.11.17.59
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 03 Dec 2017 11:17:59 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id 94so16786957lfy.10
        for <linux-ntb@googlegroups.com>; Sun, 03 Dec 2017 11:17:59 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 08/15] NTB: ntb_test: Add ntb_tool port tests
Date: Sun,  3 Dec 2017 22:17:29 +0300
Message-Id: <20171203191736.3399-9-fancer.lancer@gmail.com>
In-Reply-To: <20171203191736.3399-1-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Multi-port interface is now available in ntb_tool driver. According
to the new NTB API, there might be more than two devices connected
over NTB. It means that each device can have multiple freely
enumerated ports. Each port got index assigned by the NTB hardware
driver. This test is performed to determine the local and peer ports
as well as their indexes.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 52 +++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index a8647ad891eb..541ba70ad640 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -127,6 +127,56 @@ function write_file()
 	fi
 }
 
+function check_file()
+{
+	split_remote $1
+
+	if [[ "$REMOTE" != "" ]]; then
+		ssh "$REMOTE" "[[ -e ${VPATH} ]]"
+	else
+		[[ -e ${VPATH} ]]
+	fi
+}
+
+function find_pidx()
+{
+	PORT=$1
+	PPATH=$2
+
+	for ((i = 0; i < 64; i++)); do
+		PEER_DIR="$PPATH/peer$i"
+
+		check_file ${PEER_DIR} || break
+
+		PEER_PORT=$(read_file "${PEER_DIR}/port")
+		if [[ ${PORT} -eq $PEER_PORT ]]; then
+			echo $i
+			return 0
+		fi
+	done
+
+	return 1
+}
+
+function port_test()
+{
+	LOC=$1
+	REM=$2
+
+	echo "Running port tests on: $(basename $LOC) / $(basename $REM)"
+
+	LOCAL_PORT=$(read_file "$LOC/port")
+	REMOTE_PORT=$(read_file "$REM/port")
+
+	LOCAL_PIDX=$(find_pidx ${REMOTE_PORT} "$LOC")
+	REMOTE_PIDX=$(find_pidx ${LOCAL_PORT} "$REM")
+
+	echo "Local port ${LOCAL_PORT} with index ${REMOTE_PIDX} on remote host"
+	echo "Peer port ${REMOTE_PORT} with index ${LOCAL_PIDX} on local host"
+
+	echo "  Passed"
+}
+
 function link_test()
 {
 	LOC=$1
@@ -327,6 +377,8 @@ function ntb_tool_tests()
 
 	_modprobe ntb_tool
 
+	port_test "$LOCAL_TOOL" "$REMOTE_TOOL"
+
 	write_file "Y" "$LOCAL_TOOL/link_event"
 	write_file "Y" "$REMOTE_TOOL/link_event"
 
-- 
2.12.0

