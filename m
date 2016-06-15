Return-Path: <gunthorp@cgy1-donard.priv.deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id tp10si4432253pac.2.2016.06.15.14.26.53
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Jun 2016 14:26:54 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Wed, 15 Jun 2016 15:26:39 -0600
Message-Id: <b1aa9e9977b992621452812f744ff7827ca4f28c.1466025130.git.logang@deltatee.com>
In-Reply-To: <cover.1466025130.git.logang@deltatee.com>
References: <cover.1466025130.git.logang@deltatee.com>
In-Reply-To: <cover.1466025130.git.logang@deltatee.com>
References: <cover.1466025130.git.logang@deltatee.com>
Subject: [PATCH v3 10/10] ntb_perf: clear link_is_up flag when the link goes down.
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <Allen.Hubbe@emc.com>
Cc: Shuah Khan <shuahkh@osg.samsung.com>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-kselftest@vger.kernel.org, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

When the link goes down, the link_is_up flag did not return to
false. This could have caused some subtle corner case bugs
when the link goes up and down quickly.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/ntb/test/ntb_perf.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index f0784e5..ae9d1b2 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -557,6 +557,8 @@ static void perf_link_cleanup(struct work_struct *work)
 
 	if (!perf->link_is_up)
 		cancel_delayed_work_sync(&perf->link_work);
+
+	perf->link_is_up = false;
 }
 
 static int perf_setup_mw(struct ntb_dev *ntb, struct perf_ctx *perf)
-- 
2.1.4

