Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EF91DDF0
	for <ntb@lists.linux.dev>; Thu, 10 Aug 2023 11:31:18 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.56])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RM46N50hgzkX9D;
	Thu, 10 Aug 2023 19:13:16 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 10 Aug
 2023 19:14:29 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
	<dan.carpenter@linaro.org>, <fancer.lancer@gmail.com>, <machel@vivo.com>,
	<jiasheng@iscas.ac.cn>, <ntb@lists.linux.dev>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] NTB: ntb_tool: Switch to memdup_user_nul() helper
Date: Thu, 10 Aug 2023 19:14:02 +0800
Message-ID: <20230810111402.1923113-1-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.53.73]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected

Use memdup_user_nul() helper instead of open-coding to simplify the code.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/ntb/test/ntb_tool.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index e0acc11d29ba..641cb7e05a47 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -370,16 +370,9 @@ static ssize_t tool_fn_write(struct tool_ctx *tc,
 	if (*offp)
 		return 0;
 
-	buf = kmalloc(size + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, size)) {
-		kfree(buf);
-		return -EFAULT;
-	}
-
-	buf[size] = 0;
+	buf = memdup_user_nul(ubuf, size);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	n = sscanf(buf, "%c %lli", &cmd, &bits);
 
-- 
2.34.1

