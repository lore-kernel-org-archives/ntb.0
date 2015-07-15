Return-Path: <Allen.Hubbe@emc.com>
Received: from mailuogwdur.emc.com (mailuogwdur.emc.com. [128.221.224.79])
        by gmr-mx.google.com with ESMTPS id x125si453966ywb.0.2015.07.15.06.15.46
        for <linux-ntb@googlegroups.com>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jul 2015 06:15:47 -0700 (PDT)
From: Allen Hubbe <Allen.Hubbe@emc.com>
Subject: [PATCH] NTB: Fix documentation for ntb_link_is_up
Date: Wed, 15 Jul 2015 04:15:28 -0400
Message-Id: <6777f5c65cc5609fb57e4ef1841a517c26e48931.1436948037.git.Allen.Hubbe@emc.com>
To: linux-ntb@googlegroups.com
Cc: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
List-ID: <linux-ntb.googlegroups.com>

There was a copy and paste error in the documentation for
ntb_link_is_up.  The long description was mistakenly copied from
ntb_link_set_trans.

This adds the appropriate long description for ntb_link_is_up.

Reported-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Allen Hubbe <Allen.Hubbe@emc.com>
---
 include/linux/ntb.h | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index b02f72bb8e32..e3d3299c6052 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -522,10 +522,9 @@ static inline int ntb_mw_clear_trans(struct ntb_dev *ntb, int idx)
  * @speed:	OUT - The link speed expressed as PCIe generation number.
  * @width:	OUT - The link width expressed as the number of PCIe lanes.
  *
- * Set the translation of a memory window.  The peer may access local memory
- * through the window starting at the address, up to the size.  The address
- * must be aligned to the alignment specified by ntb_mw_get_range().  The size
- * must be aligned to the size alignment specified by ntb_mw_get_range().
+ * Get the current state of the ntb link.  It is recommended to query the link
+ * state once after every link event.  It is safe to query the link state in
+ * the context of the link event callback.
  *
  * Return: One if the link is up, zero if the link is down, otherwise a
  *		negative value indicating the error number.
-- 
2.5.0.rc1

