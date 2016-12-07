Return-Path: <asierra@xes-inc.com>
Received: from xes-mad.com (xes-mad.com. [216.165.139.218])
        by gmr-mx.google.com with ESMTPS id n126si815150ita.1.2016.12.06.17.09.18
        for <linux-ntb@googlegroups.com>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 06 Dec 2016 17:09:18 -0800 (PST)
Date: Tue, 6 Dec 2016 19:09:16 -0600 (CST)
From: Aaron Sierra <asierra@xes-inc.com>
Message-ID: <1503156503.754106.1481072956836.JavaMail.zimbra@xes-inc.com>
Subject: [PATCH] NTB: correct ntb_spad_count comment typo
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: linux-ntb@googlegroups.com, Jiri Kosina <trivial@kernel.org>
List-ID: <linux-ntb.googlegroups.com>

The comment for ntb_spad_count incorrectly referred to ntb_mw_count.

Signed-off-by: Aaron Sierra <asierra@xes-inc.com>
---
 include/linux/ntb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 6f47562..50a7dbe 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -892,15 +892,15 @@ static inline int ntb_spad_is_unsafe(struct ntb_dev *ntb)
 	if (!ntb->ops->spad_is_unsafe)
 		return 0;
 
 	return ntb->ops->spad_is_unsafe(ntb);
 }
 
 /**
- * ntb_mw_count() - get the number of scratchpads
+ * ntb_spad_count() - get the number of scratchpads
  * @ntb:	NTB device context.
  *
  * Hardware and topology may support a different number of scratchpads.
  *
  * Return: the number of scratchpads.
  */
 static inline int ntb_spad_count(struct ntb_dev *ntb)
-- 
1.9.1

