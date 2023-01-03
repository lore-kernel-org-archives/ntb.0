Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD2E7E
	for <ntb@lists.linux.dev>; Tue,  3 Jan 2023 02:30:36 +0000 (UTC)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.55])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4NmGrb0LwbznTVw;
	Tue,  3 Jan 2023 10:29:03 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 3 Jan
 2023 10:30:27 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ntb@lists.linux.dev>
CC: <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <mani@kernel.org>,
	<kishon@kernel.org>, <bhelgaas@google.com>, <helgaas@kernel.org>
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: add kernel-doc for num_mws on epf_ntb_mw_bar_clear()
Date: Tue, 3 Jan 2023 10:49:07 +0800
Message-ID: <20230103024907.293853-1-yangyingliang@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.103.91]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Commit 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle
in epf_ntb_mw_bar_init()") added a "num_mws" parameter to
epf_ntb_mw_bar_clear() but failed to add kernel-doc for num_mws.

This patch adds kernel-doc for num_mws on epf_ntb_mw_bar_clear().

Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 04698e7995a5..b7c7a8af99f4 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -652,6 +652,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 /**
  * epf_ntb_mw_bar_clear() - Clear Memory window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @num_mws: the number of Memory window BARs that to be cleared
  */
 static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 {
-- 
2.25.1

