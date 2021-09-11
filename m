Return-Path: <sashal@kernel.org>
Received: from mail.kernel.org (mail.kernel.org. [198.145.29.99])
        by gmr-mx.google.com with ESMTPS id h4si60928vkf.1.2021.09.11.06.14.15
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 11 Sep 2021 06:14:15 -0700 (PDT)
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 7/7] NTB: perf: Fix an error code in perf_setup_inbuf()
Date: Sat, 11 Sep 2021 09:14:04 -0400
Message-Id: <20210911131404.286005-7-sashal@kernel.org>
In-Reply-To: <20210911131404.286005-1-sashal@kernel.org>
References: <20210911131404.286005-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Yang Li <yang.lee@linux.alibaba.com>, Abaci Robot <abaci@linux.alibaba.com>, Serge Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Sasha Levin <sashal@kernel.org>, linux-ntb@googlegroups.com
List-ID: <linux-ntb.googlegroups.com>

From: Yang Li <yang.lee@linux.alibaba.com>

[ Upstream commit 0097ae5f7af5684f961a5f803ff7ad3e6f933668 ]

When the function IS_ALIGNED() returns false, the value of ret is 0.
So, we set ret to -EINVAL to indicate this error.

Clean up smatch warning:
drivers/ntb/test/ntb_perf.c:602 perf_setup_inbuf() warn: missing error
code 'ret'.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/ntb/test/ntb_perf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index ad5d3919435c..87a41d0ededc 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -600,6 +600,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 		return -ENOMEM;
 	}
 	if (!IS_ALIGNED(peer->inbuf_xlat, xlat_align)) {
+		ret = -EINVAL;
 		dev_err(&perf->ntb->dev, "Unaligned inbuf allocated\n");
 		goto err_free_inbuf;
 	}
-- 
2.30.2

