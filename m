Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org. [62.245.132.105])
        by gmr-mx.google.com with ESMTPS id w64si932990wmf.3.2016.08.22.09.49.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Mon, 22 Aug 2016 09:49:19 -0700 (PDT)
From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 1/2] ntb_transport: make DMA_OUT_RESOURCE_TO HZ independent
Date: Mon, 22 Aug 2016 18:51:35 +0200
Message-Id: <1471884696-25558-1-git-send-email-hofrat@osadl.org>
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
the driver and can confirm that 50ms is reasonable to wait on retries.

Patch was compile tested with: x86_64_defconfig + CONFIG_NTB=m, 
CONFIG_NTB_TRANSPORT=m

Patch is against 4.8.0-rc2 (localversion-next is -next-20160822)

 drivers/ntb/ntb_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 8601c10..4eb8adb 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -257,7 +257,7 @@ enum {
 #define NTB_QP_DEF_NUM_ENTRIES	100
 #define NTB_LINK_DOWN_TIMEOUT	10
 #define DMA_RETRIES		20
-#define DMA_OUT_RESOURCE_TO	50
+#define DMA_OUT_RESOURCE_TO	msecs_to_jiffies(50)
 
 static void ntb_transport_rxc_db(unsigned long data);
 static const struct ntb_ctx_ops ntb_transport_ops;
-- 
2.1.4

