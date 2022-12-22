Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E717C1
	for <ntb@lists.linux.dev>; Thu, 22 Dec 2022 04:02:19 +0000 (UTC)
Received: from dggpemm500007.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Ncx381tGRzJpRt;
	Thu, 22 Dec 2022 11:42:44 +0800 (CST)
Received: from huawei.com (10.175.103.91) by dggpemm500007.china.huawei.com
 (7.185.36.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 22 Dec
 2022 11:46:07 +0800
From: Yang Yingliang <yangyingliang@huawei.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<ntb@lists.linux.dev>
CC: <jdmason@kudzu.us>, <dave.jiang@intel.com>, <allenbh@gmail.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <mani@kernel.org>,
	<kishon@kernel.org>, <bhelgaas@google.com>, <helgaas@kernel.org>
Subject: [PATCH v2] PCI: endpoint: pci-epf-vntb: fix doc warning in pci-epf-vntb.c
Date: Thu, 22 Dec 2022 11:43:24 +0800
Message-ID: <20221222034324.3294639-1-yangyingliang@huawei.com>
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
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemm500007.china.huawei.com (7.185.36.183)
X-CFilter-Loop: Reflected

Fix the following make W=1 warning:

  drivers/pci/endpoint/functions/pci-epf-vntb.c:645: warning: Function parameter or member 'num_mws' not described in 'epf_ntb_mw_bar_clear'

Fixes: 8e4bfbe644a6 ("PCI: endpoint: pci-epf-vntb: fix error handle in epf_ntb_mw_bar_init()")
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
---
v1 -> v2:
  Based on latest commit.
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 04698e7995a5..37134aead77c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -594,6 +594,7 @@ static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 /**
  * epf_ntb_mw_bar_init() - Configure Memory window BARs
  * @ntb: NTB device that facilitates communication between HOST and VHOST
+ * @num_mws: the number of Memory window BARs that to be cleared
  *
  * Returns: Zero for success, or an error code in case of failure
  */
-- 
2.25.1

