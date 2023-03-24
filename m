Received: from out-21.mta0.migadu.com (out-21.mta0.migadu.com [91.218.175.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC5615A7
	for <ntb@lists.linux.dev>; Fri, 24 Mar 2023 01:32:44 +0000 (UTC)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1679621563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M70XsVdJtUL81tuo2OKkYLLlk8pQMU03G6wBmbDiO64=;
	b=lV3kZeBrOOcFCbH1tQshhiHqpu5Z4QEJXzp9hx5KbtNMKoGZi/Dvw0G2zEPF+QC/y86Wy4
	2rhYCkfdwv1CtazOnV2bOPZjMNVZ3bI+JO3R8w9fbgW7tA5MUkxF2bls339hOwWbJSjaZR
	7Cl6cwRZpO6VRMlanzxxMRjXFEsSYyc=
From: Cai Huoqing <cai.huoqing@linux.dev>
To: cai.huoqing@linux.dev
Cc: Dave Jiang <dave.jiang@intel.com>,
	Sanjay R Mehta <sanju.mehta@amd.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Jon Mason <jdmason@kudzu.us>,
	Allen Hubbe <allenbh@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] ntb: intel: Remove redundant pci_clear_master
Date: Fri, 24 Mar 2023 09:32:20 +0800
Message-Id: <20230324013224.5963-3-cai.huoqing@linux.dev>
In-Reply-To: <20230324013224.5963-1-cai.huoqing@linux.dev>
References: <20230324013224.5963-1-cai.huoqing@linux.dev>
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
Acked-by: Dave Jiang <dave.jiang@intel.com>
---
v1->v2: No change
v1 link:
	https://lore.kernel.org/lkml/20230323115336.12986-3-cai.huoqing@linux.dev/

 drivers/ntb/hw/intel/ntb_hw_gen1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/ntb/hw/intel/ntb_hw_gen1.c b/drivers/ntb/hw/intel/ntb_hw_gen1.c
index 60a4ebc7bf35..9ab836d0d4f1 100644
--- a/drivers/ntb/hw/intel/ntb_hw_gen1.c
+++ b/drivers/ntb/hw/intel/ntb_hw_gen1.c
@@ -1791,7 +1791,6 @@ static int intel_ntb_init_pci(struct intel_ntb_dev *ndev, struct pci_dev *pdev)
 
 err_mmio:
 err_dma_mask:
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 err_pci_regions:
 	pci_disable_device(pdev);
@@ -1808,7 +1807,6 @@ static void intel_ntb_deinit_pci(struct intel_ntb_dev *ndev)
 		pci_iounmap(pdev, ndev->peer_mmio);
 	pci_iounmap(pdev, ndev->self_mmio);
 
-	pci_clear_master(pdev);
 	pci_release_regions(pdev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
-- 
2.34.1

