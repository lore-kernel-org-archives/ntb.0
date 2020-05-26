Return-Path: <bounces+SRS=2l6qk=7I@amdcloud.onmicrosoft.com>
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2072.outbound.protection.outlook.com. [40.107.92.72])
        by gmr-mx.google.com with ESMTPS id w190si1127139ybe.2.2020.05.26.01.00.37
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2020 01:00:37 -0700 (PDT)
From: Wesley Sheng <wesley.sheng@amd.com>
Subject: [PATCH] NTB: correct ntb_peer_spad_addr and ntb_peer_spad_read comment typos
Date: Tue, 26 May 2020 15:59:43 +0800
Message-ID: <20200526075943.20756-1-wesley.sheng@amd.com>
Return-Path: weisheng@srdcmail.amd.com
MIME-Version: 1.0
Content-Type: text/plain
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org
Cc: wesleyshenggit@sina.com, wesley.sheng@amd.com
List-ID: <linux-ntb.googlegroups.com>

The comment for ntb_peer_spad_addr and ntb_peer_spad_read
incorrectly referred to peer doorbell register and local
scratchpad register.

Signed-off-by: Wesley Sheng <wesley.sheng@amd.com>
---
 include/linux/ntb.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 8c13538aeffe..b9b0d805d0f9 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1351,7 +1351,7 @@ static inline int ntb_spad_write(struct ntb_dev *ntb, int sidx, u32 val)
  * @sidx:	Scratchpad index.
  * @spad_addr:	OUT - The address of the peer scratchpad register.
  *
- * Return the address of the peer doorbell register.  This may be used, for
+ * Return the address of the peer scratchpad register.  This may be used, for
  * example, by drivers that offload memory copy operations to a dma engine.
  *
  * Return: Zero on success, otherwise an error number.
@@ -1373,7 +1373,7 @@ static inline int ntb_peer_spad_addr(struct ntb_dev *ntb, int pidx, int sidx,
  *
  * Read the peer scratchpad register, and return the value.
  *
- * Return: The value of the local scratchpad register.
+ * Return: The value of the peer scratchpad register.
  */
 static inline u32 ntb_peer_spad_read(struct ntb_dev *ntb, int pidx, int sidx)
 {
-- 
2.16.2

