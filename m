Received: from out-1.mta1.migadu.com (out-1.mta1.migadu.com [95.215.58.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6193119F
	for <ntb@lists.linux.dev>; Thu, 23 Mar 2023 11:53:43 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1679572421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=e28/Aphzssb7x3wtsuVlhO9EMFot1z8DPyozyjw+aCs=;
	b=TuLVwMlPfRTu/gRt3GON+vXtXxPXWLk3U7HM1L2Aw4Q7lzZJ2A/xGInpNXmkW4T3vHvMC4
	2j5LSzHo2XPKRipGBtjKRFmWmD3GYH1+9XEOADOXkBBUxC8JfbxXvxbDAAviO686tyejSX
	94ket3Yl5552HzttE+aQ4IG845aaR9k=
From: Cai Huoqing <cai.huoqing@linux.dev>
To: cai.huoqing@linux.dev
Cc: Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ntb_hw_amd: Remove redundant pci_clear_master
Date: Thu, 23 Mar 2023 19:53:33 +0800
Message-Id: <20230323115336.12986-1-cai.huoqing@linux.dev>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Remove pci_clear_master to simplify the code,
the bus-mastering is also cleared in do_pci_disable_device,
like this:
./drivers/pci/pci.c:2197
static void do_pci_disable_device(struct pci_dev *dev)
{
	u16 pci_command;

	pci_read_config_word(dev, PCI_COMMAND, &pci_command);
	if (pci_command & PCI_COMMAND_MASTER) {
		pci_command &= ~PCI_COMMAND_MASTER;
		pci_write_config_word(dev, PCI_COMMAND, pci_command);
	}

	pcibios_disable_device(dev);
}.
And dev->is_busmaster is set to 0 in pci_disable_device.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/ntb/hw/amd/ntb_hw_amd.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/amd/ntb_hw_amd.c b/drivers/ntb/hw/amd/ntb_hw_amd.c
index 730f2103b91d..855ff65f64a5 100644
--- a/drivers/ntb/hw/amd/ntb_hw_amd.c
+++ b/drivers/ntb/hw/amd/ntb_hw_amd.c
@@ -1194,7 +1194,6 @@ static int amd_ntb_init_pci(struct amd_ntb_dev *ndev,
 	return 0;
 
 err_dma_mask:
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 err_pci_regions:
 	pci_disable_device(pdev);
@@ -1209,7 +1208,6 @@ static void amd_ntb_deinit_pci(struct amd_ntb_dev *ndev)
 
 	pci_iounmap(pdev, ndev->self_mmio);
 
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-- 
2.34.1

