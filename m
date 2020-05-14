Return-Path: <kishon@ti.com>
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com. [198.47.23.248])
        by gmr-mx.google.com with ESMTPS id a65si208622vki.2.2020.05.14.08.02.12
        for <linux-ntb@googlegroups.com>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2020 08:02:12 -0700 (PDT)
From: Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH 19/19] NTB: ntb_perf/ntb_tool: Use PCI device for dma_alloc_coherent()
Date: Thu, 14 May 2020 20:29:27 +0530
Message-ID: <20200514145927.17555-20-kishon@ti.com>
In-Reply-To: <20200514145927.17555-1-kishon@ti.com>
References: <20200514145927.17555-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Tom Joseph <tjoseph@cadence.com>, Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh+dt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-ntb@googlegroups.com, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <linux-ntb.googlegroups.com>

NTB device is not a real device and the piece of hardware actually
doing the DMA is the PCI device itself. Fix ntb_perf.c and ntb_tool.c
to use PCI device for dma_alloc_coherent() instead of NTB device.
ntb_transport.c already uses PCI device for dma_alloc_coherent().

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/ntb/test/ntb_perf.c | 3 ++-
 drivers/ntb/test/ntb_tool.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/ntb/test/ntb_perf.c b/drivers/ntb/test/ntb_perf.c
index 972f6d984f6d..7f830a3e5b14 100644
--- a/drivers/ntb/test/ntb_perf.c
+++ b/drivers/ntb/test/ntb_perf.c
@@ -566,6 +566,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 {
 	resource_size_t xlat_align, size_align, size_max;
 	struct perf_ctx *perf = peer->perf;
+	struct pci_dev *pdev = perf->ntb->pdev;
 	int ret;
 
 	/* Get inbound MW parameters */
@@ -586,7 +587,7 @@ static int perf_setup_inbuf(struct perf_peer *peer)
 
 	perf_free_inbuf(peer);
 
-	peer->inbuf = dma_alloc_coherent(&perf->ntb->dev, peer->inbuf_size,
+	peer->inbuf = dma_alloc_coherent(&pdev->dev, peer->inbuf_size,
 					 &peer->inbuf_xlat, GFP_KERNEL);
 	if (!peer->inbuf) {
 		dev_err(&perf->ntb->dev, "Failed to alloc inbuf of %pa\n",
diff --git a/drivers/ntb/test/ntb_tool.c b/drivers/ntb/test/ntb_tool.c
index 4b4f9e2a2c43..5c9f034122b7 100644
--- a/drivers/ntb/test/ntb_tool.c
+++ b/drivers/ntb/test/ntb_tool.c
@@ -576,6 +576,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 {
 	resource_size_t size, addr_align, size_align;
 	struct tool_mw *inmw = &tc->peers[pidx].inmws[widx];
+	struct pci_dev *pdev = tc->ntb->pdev;
 	char buf[TOOL_BUF_LEN];
 	int ret;
 
@@ -590,7 +591,7 @@ static int tool_setup_mw(struct tool_ctx *tc, int pidx, int widx,
 	inmw->size = min_t(resource_size_t, req_size, size);
 	inmw->size = round_up(inmw->size, addr_align);
 	inmw->size = round_up(inmw->size, size_align);
-	inmw->mm_base = dma_alloc_coherent(&tc->ntb->dev, inmw->size,
+	inmw->mm_base = dma_alloc_coherent(&pdev->dev, inmw->size,
 					   &inmw->dma_base, GFP_KERNEL);
 	if (!inmw->mm_base)
 		return -ENOMEM;
-- 
2.17.1

