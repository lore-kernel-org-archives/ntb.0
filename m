Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2A8C13
	for <ntb@lists.linux.dev>; Thu, 31 Aug 2023 12:39:34 +0000 (UTC)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.54])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Rc10J5xFwz1L9Fs
	for <ntb@lists.linux.dev>; Thu, 31 Aug 2023 20:37:52 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi500008.china.huawei.com
 (7.221.188.139) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Thu, 31 Aug
 2023 20:39:32 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <ntb@lists.linux.dev>, Dave Jiang <dave.jiang@intel.com>, Jon Mason
	<jdmason@kudzu.us>, Allen Hubbe <allenbh@gmail.com>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH] ntb: intel: Fix the NULL vs IS_ERR() bug for debugfs_create_dir()
Date: Thu, 31 Aug 2023 20:39:27 +0800
Message-ID: <20230831123927.3137364-1-ruanjinjie@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)
X-CFilter-Loop: Reflected

The debugfs_create_dir() function returns error pointers.
It never returns NULL. So use IS_ERR() to check it.

Fixes: e26a5843f7f5 ("NTB: Split ntb_hw_intel and ntb_transport drivers")
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 9ab836d0d4f1..079b8cd79785 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -778,7 +778,7 @@ static void ndev_init_debugfs(struct intel_ntb_dev *ndev)
 		ndev->debugfs_dir =
 			debugfs_create_dir(pci_name(ndev->ntb.pdev),
 					   debugfs_dir);
-		if (!ndev->debugfs_dir)
+		if (IS_ERR(ndev->debugfs_dir))
 			ndev->debugfs_info = NULL;
 		else
 			ndev->debugfs_info =
-- 
2.34.1

