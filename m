Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id c6si1092960ybo.0.2019.02.13.09.55.03
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 09:55:03 -0800 (PST)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 13 Feb 2019 10:54:53 -0700
Message-Id: <20190213175454.7506-12-logang@deltatee.com>
In-Reply-To: <20190213175454.7506-1-logang@deltatee.com>
References: <20190213175454.7506-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v2 11/12] NTB: Add ntb_msi_test support to ntb_test
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Bjorn Helgaas <bhelgaas@google.com>, Joerg Roedel <joro@8bytes.org>
Cc: Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

When the ntb_msi_test module is available, the test code will trigger
each of the interrupts and ensure the corresponding occurrences files
gets incremented.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Allen Hubbe <allenbh@gmail.com>
---
 tools/testing/selftests/ntb/ntb_test.sh | 54 ++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/ntb/ntb_test.sh b/tools/testing/selftests/ntb/ntb_test.sh
index 17ca36403d04..1a10b8f67727 100755
--- a/tools/testing/selftests/ntb/ntb_test.sh
+++ b/tools/testing/selftests/ntb/ntb_test.sh
@@ -87,10 +87,10 @@ set -e
 
 function _modprobe()
 {
-	modprobe "$@"
+	modprobe "$@" || return 1
 
 	if [[ "$REMOTE_HOST" != "" ]]; then
-		ssh "$REMOTE_HOST" modprobe "$@"
+		ssh "$REMOTE_HOST" modprobe "$@" || return 1
 	fi
 }
 
@@ -451,6 +451,30 @@ function pingpong_test()
 	echo "  Passed"
 }
 
+function msi_test()
+{
+	LOC=$1
+	REM=$2
+
+	write_file 1 $LOC/ready
+
+	echo "Running MSI interrupt tests on: $(subdirname $LOC) / $(subdirname $REM)"
+
+	CNT=$(read_file "$LOC/count")
+	for ((i = 0; i < $CNT; i++)); do
+		START=$(read_file $REM/../irq${i}_occurrences)
+		write_file $i $LOC/trigger
+		END=$(read_file $REM/../irq${i}_occurrences)
+
+		if [[ $(($END - $START)) != 1 ]]; then
+			echo "MSI did not trigger the interrupt on the remote side!" >&2
+			exit 1
+		fi
+	done
+
+	echo "  Passed"
+}
+
 function perf_test()
 {
 	USE_DMA=$1
@@ -529,6 +553,29 @@ function ntb_pingpong_tests()
 	_modprobe -r ntb_pingpong
 }
 
+function ntb_msi_tests()
+{
+	LOCAL_MSI="$DEBUGFS/ntb_msi_test/$LOCAL_DEV"
+	REMOTE_MSI="$REMOTE_HOST:$DEBUGFS/ntb_msi_test/$REMOTE_DEV"
+
+	echo "Starting ntb_msi_test tests..."
+
+	if ! _modprobe ntb_msi_test 2> /dev/null; then
+		echo "  Not doing MSI tests seeing the module is not available."
+		return
+	fi
+
+	port_test $LOCAL_MSI $REMOTE_MSI
+
+	LOCAL_PEER="$LOCAL_MSI/peer$LOCAL_PIDX"
+	REMOTE_PEER="$REMOTE_MSI/peer$REMOTE_PIDX"
+
+	msi_test $LOCAL_PEER $REMOTE_PEER
+	msi_test $REMOTE_PEER $LOCAL_PEER
+
+	_modprobe -r ntb_msi_test
+}
+
 function ntb_perf_tests()
 {
 	LOCAL_PERF="$DEBUGFS/ntb_perf/$LOCAL_DEV"
@@ -550,6 +597,7 @@ function cleanup()
 	_modprobe -r ntb_perf 2> /dev/null
 	_modprobe -r ntb_pingpong 2> /dev/null
 	_modprobe -r ntb_transport 2> /dev/null
+	_modprobe -r ntb_msi_test 2> /dev/null
 	set -e
 }
 
@@ -586,5 +634,7 @@ ntb_tool_tests
 echo
 ntb_pingpong_tests
 echo
+ntb_msi_tests
+echo
 ntb_perf_tests
 echo
-- 
2.19.0

