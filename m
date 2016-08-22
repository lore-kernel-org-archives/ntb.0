Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org. [62.245.132.105])
        by gmr-mx.google.com with ESMTPS id o10si846238wme.0.2016.08.22.09.49.25
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Aug 2016 09:49:25 -0700 (PDT)
From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] ntb: make DMA_OUT_RESOURCE_TO HZ independent
Date: Mon, 22 Aug 2016 18:51:36 +0200
Message-Id: <1471884696-25558-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1471884696-25558-1-git-send-email-hofrat@osadl.org>
References: <1471884696-25558-1-git-send-email-hofrat@osadl.org>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>, Logan Gunthorpe <logang@deltatee.com>, Arnd Bergmann <arnd@arndb.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-ID: <linux-ntb.googlegroups.com>

schedule_timeout_* takes a timeout in jiffies but the code currently is
passing in a constant which makes this timeout HZ dependent, so pass it
through msecs_to_jiffies() to fix this up.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---

Problem found by coccinelle script

The below patch sets the timeout to 50ms - not clear what HZ setting was
assumed during design/testing, so this needs an ack by someone who knows
the driver and can confirm that 50ms is reasonable to wait on DMA retries.

Patch was compile tested with: x86_64_defconfig + CONFIG_NTB=m,
CONFIG_NTB_PERF=m

Patch is against 4.8.0-rc2 (localversion-next is -next-20160822)

 drivers/ntb/test/ntb_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 6a50f20..e065b69 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -72,7 +72,7 @@
 #define MAX_THREADS		32
 #define MAX_TEST_SIZE		SZ_1M
 #define MAX_SRCS		32
-#define DMA_OUT_RESOURCE_TO	50
+#define DMA_OUT_RESOURCE_TO	msecs_to_jiffies(50)
 #define DMA_RETRIES		20
 #define SZ_4G			(1ULL << 32)
 #define MAX_SEG_ORDER		20 /* no larger than 1M for kmalloc buffer */
-- 
2.1.4

