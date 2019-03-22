Return-Path: <gunthorp@deltatee.com>
Received: from ale.deltatee.com (ale.deltatee.com. [207.54.116.67])
        by gmr-mx.google.com with ESMTPS id l23si344168ioc.2.2019.03.21.17.06.52
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Mar 2019 17:06:52 -0700 (PDT)
From: Logan Gunthorpe <logang@deltatee.com>
Date: Thu, 21 Mar 2019 18:06:37 -0600
Message-Id: <20190322000645.15580-3-logang@deltatee.com>
In-Reply-To: <20190322000645.15580-1-logang@deltatee.com>
References: <20190322000645.15580-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [PATCH v3 02/10] PCI/switchtec: Add module parameter to request more interrupts
To: linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com, linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org, linux-kselftest@vger.kernel.org, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Allen Hubbe <allenbh@gmail.com>, Dave Jiang <dave.jiang@intel.com>, Serge Semin <fancer.lancer@gmail.com>, Eric Pilmore <epilmore@gigaio.com>, Logan Gunthorpe <logang@deltatee.com>
List-ID: <linux-ntb.googlegroups.com>

Seeing the we want to use more interrupts in the NTB MSI code
we need to be able allocate more (sometimes virtual) interrupts
in the switchtec driver. Therefore add a module parameter to
request to allocate additional interrupts.

This puts virtually no limit on the number of MSI interrupts available
to NTB clients.

Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/switch/switchtec.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e22766c79fe9..8b1db78197d9 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -30,6 +30,10 @@ module_param(use_dma_mrpc, bool, 0644);
 MODULE_PARM_DESC(use_dma_mrpc,
 		 "Enable the use of the DMA MRPC feature");
 
+static int nirqs = 32;
+module_param(nirqs, int, 0644);
+MODULE_PARM_DESC(nirqs, "number of interrupts to allocate (more may be useful for NTB applications)");
+
 static dev_t switchtec_devt;
 static DEFINE_IDA(switchtec_minor_ida);
 
@@ -1247,8 +1251,12 @@ static int switchtec_init_isr(struct switchtec_dev *stdev)
 	int dma_mrpc_irq;
 	int rc;
 
-	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, 4,
-				      PCI_IRQ_MSIX | PCI_IRQ_MSI);
+	if (nirqs < 4)
+		nirqs = 4;
+
+	nvecs = pci_alloc_irq_vectors(stdev->pdev, 1, nirqs,
+				      PCI_IRQ_MSIX | PCI_IRQ_MSI |
+				      PCI_IRQ_VIRTUAL);
 	if (nvecs < 0)
 		return nvecs;
 
-- 
2.20.1

