Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id 62si3246038pfx.1.2016.06.14.10.02.38
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Jun 2016 10:02:38 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Tue, 14 Jun 2016 11:02:21 -0600
Message-Id: <2b42e0663ff7d04f01de7b904e37492a80796cea.1465919683.git.logang@deltatee.com>
In-Reply-To: <cover.1465919682.git.logang@deltatee.com>
References: <cover.1465919682.git.logang@deltatee.com>
In-Reply-To: <cover.1465919682.git.logang@deltatee.com>
References: <cover.1465919682.git.logang@deltatee.com>
Subject: [PATCH v2 1/8] ntb_perf: Schedule based on time not on performance
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

When debugging performance problems, if some issue causes the ntb
hardware to be significantly slower than expected, ntb_perf will
hang requiring a reboot because it only schedules once every 4GB.

Instead, schedule based on jiffies so it will not hang the CPU if
the transfer is slow.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/test/ntb_perf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 4368519..5008ccf 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -273,6 +273,7 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 	char __iomem *tmp = dst;
 	u64 perf, diff_us;
 	ktime_t kstart, kstop, kdiff;
+	unsigned long last_sleep = jiffies;
 
 	chunks = div64_u64(win_size, buf_size);
 	total_chunks = div64_u64(total, buf_size);
@@ -288,8 +289,9 @@ static int perf_move_data(struct pthr_ctx *pctx, char __iomem *dst, char *src,
 		} else
 			tmp += buf_size;
 
-		/* Probably should schedule every 4GB to prevent soft hang. */
-		if (((copied % SZ_4G) == 0) && !use_dma) {
+		/* Probably should schedule every 5s to prevent soft hang. */
+		if (unlikely((jiffies - last_sleep) > 5 * HZ)) {
+			last_sleep = jiffies;
 			set_current_state(TASK_INTERRUPTIBLE);
 			schedule_timeout(1);
 		}
-- 
2.1.4

