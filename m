Return-Path: <Sanju.Mehta@amd.com>
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com. [40.107.223.57])
        by gmr-mx.google.com with ESMTPS id v22si87449vsl.1.2020.05.05.21.22.45
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 May 2020 21:22:45 -0700 (PDT)
From: Sanjay R Mehta <sanju.mehta@amd.com>
Subject: [PATCH v3 4/5] ntb_perf: increase sleep time from one milli sec to one sec
Date: Tue,  5 May 2020 23:21:51 -0500
Message-Id: <1588738912-24827-5-git-send-email-sanju.mehta@amd.com>
In-Reply-To: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
References: <1588738912-24827-1-git-send-email-sanju.mehta@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-Path: sanju.mehta@amd.com
MIME-Version: 1.0
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, arindam.nath@amd.com, logang@deltatee.com, Shyam-sundar.S-k@amd.com
Cc: linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Sanjay R Mehta <sanju.mehta@amd.com>
List-ID: <linux-ntb.googlegroups.com>

After trying to send commands for a maximum of MSG_TRIES
re-tries, link-up fails due to short sleep time(1ms) between
re-tries. Hence increasing the sleep time to one second providing
sufficient time for perf link-up.

Signed-off-by: Sanjay R Mehta <sanju.mehta@amd.com>
Signed-off-by: Arindam Nath <arindam.nath@amd.com>
---
 drivers/ntb/test/ntb_perf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 1c93b9f..dbcfdaa 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -101,8 +101,8 @@ MODULE_DESCRIPTION("PCIe NTB Performance Measurement Tool");
 #define DMA_MDELAY		10
 
 #define MSG_TRIES		1000
-#define MSG_UDELAY_LOW		1000
-#define MSG_UDELAY_HIGH		2000
+#define MSG_UDELAY_LOW		1000000
+#define MSG_UDELAY_HIGH		2000000
 
 #define PERF_BUF_LEN 1024
 
-- 
2.7.4

