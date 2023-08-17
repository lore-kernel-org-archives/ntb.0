Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7267F9
	for <ntb@lists.linux.dev>; Thu, 17 Aug 2023 06:32:49 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.53])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRFWw34DZzrShM;
	Thu, 17 Aug 2023 14:31:24 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 17 Aug
 2023 14:32:46 +0800
From: Ruan Jinjie <ruanjinjie@huawei.com>
To: <ntb@lists.linux.dev>, Sanjay R Mehta <sanju.mehta@amd.com>, Shyam Sundar
 S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
	<dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH -next] ntb: amd: Drop unnecessary error check for debugfs_create_dir
Date: Thu, 17 Aug 2023 14:32:19 +0800
Message-ID: <20230817063219.279315-1-ruanjinjie@huawei.com>
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

This patch removes the error checking for debugfs_create_dir in
ntb_hw_amd.c. This is because the DebugFS kernel API is developed
in a way that the caller can safely ignore the errors that
occur during the creation of DebugFS nodes. The debugfs APIs have
a IS_ERR() judge in start_creating() which can handle it
gracefully. so these checks are unnecessary.

Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 4940b6301d83..d687e8c2cc78 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -941,13 +941,10 @@ static void ndev_init_debugfs(struct amd_ntb_dev *ndev)
 		ndev->debugfs_dir =
 			debugfs_create_dir(pci_name(ndev->ntb.pdev),
 					   debugfs_dir);
-		if (IS_ERR(ndev->debugfs_dir))
-			ndev->debugfs_info = NULL;
-		else
-			ndev->debugfs_info =
-				debugfs_create_file("info", S_IRUSR,
-						    ndev->debugfs_dir, ndev,
-						    &amd_ntb_debugfs_info);
+		ndev->debugfs_info =
+			debugfs_create_file("info", S_IRUSR,
+					    ndev->debugfs_dir, ndev,
+					    &amd_ntb_debugfs_info);
 	}
 }
 
-- 
2.34.1

