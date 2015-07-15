Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwhop.emc.com (mailuogwhop.emc.com. [168.159.213.141])
        by gmr-mx.google.com with ESMTPS id xz5si565140pac.1.2015.07.15.14.43.25
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2015 14:43:26 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Fix documentation for ntb_peer_db_clear.
Date: Wed, 15 Jul 2015 12:43:21 -0400
Message-Id: <7669634df8063eac10b779e0793741265da5331b.1436978546.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

The documentation should say "peer" not "local" when referring to the
peer doorbell register.

Reported-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 include/linux/ntb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index e3d3299c6052..f798e2afba88 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -794,7 +794,7 @@ static inline int ntb_peer_db_set(struct ntb_dev *ntb, u64 db_bits)
 }
 
 /**
- * ntb_peer_db_clear() - clear bits in the local doorbell register
+ * ntb_peer_db_clear() - clear bits in the peer doorbell register
  * @ntb:	NTB device context.
  * @db_bits:	Doorbell bits to clear.
  *
-- 
2.5.0.rc1

