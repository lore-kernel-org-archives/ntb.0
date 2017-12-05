Return-Path: <fancer.lancer@gmail.com>
Received: from mail-lf0-x243.google.com (mail-lf0-x243.google.com. [2a00:1450:4010:c07::243])
        by gmr-mx.google.com with ESMTPS id w21si240447edl.5.2017.12.05.14.39.29
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2017 14:39:29 -0800 (PST)
Received: by mail-lf0-x243.google.com with SMTP id l81so2130659lfl.6
        for <linux-ntb@googlegroups.com>; Tue, 05 Dec 2017 14:39:29 -0800 (PST)
Return-Path: <fancer.lancer@gmail.com>
From: Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v3 03/15] NTB: Fix UB/bug in ntb_mw_get_align()
Date: Wed,  6 Dec 2017 01:39:06 +0300
Message-Id: <20171205223918.28727-4-fancer.lancer@gmail.com>
In-Reply-To: <20171205223918.28727-1-fancer.lancer@gmail.com>
References: <20171203191736.3399-1-fancer.lancer@gmail.com>
 <20171205223918.28727-1-fancer.lancer@gmail.com>
To: jdmason@kudzu.us, dave.jiang@intel.com, Allen.Hubbe@emc.com, Shyam-sundar.S-k@amd.com, Xiangliang.Yu@amd.com, gary.hook@amd.com
Cc: Sergey.Semin@t-platforms.ru, linux-ntb@googlegroups.com, linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>
List-ID: <linux-ntb.googlegroups.com>

Simple (1 << pidx) operation causes undefined behaviour when
pidx >= 32. It must be casted to u64 to match the actual return
value of ntb_link_is_up() method, so to have all the possible
peer indexes covered and to get rid of undefined behaviour.
Additionally there are special macros in "linux/bitops.h" to perform
the bit-set-shift operations, so it's recommended to have them used
for proper bit setting.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 include/linux/ntb.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index c1646f2c6344..488e586fb76c 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -764,7 +764,7 @@ static inline int ntb_mw_get_align(struct ntb_dev *ntb, int pidx, int widx,
 				   resource_size_t *size_align,
 				   resource_size_t *size_max)
 {
-	if (!(ntb_link_is_up(ntb, NULL, NULL) & (1 << pidx)))
+	if (!(ntb_link_is_up(ntb, NULL, NULL) & BIT_ULL(pidx)))
 		return -ENOTCONN;
 
 	return ntb->ops->mw_get_align(ntb, pidx, widx, addr_align, size_align,
-- 
2.12.0

