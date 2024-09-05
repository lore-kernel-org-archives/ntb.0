Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC74186E40
	for <ntb@lists.linux.dev>; Thu,  5 Sep 2024 21:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725571363; cv=none; b=XgbRpwcUSCLmARH7+e5wZXpKHAlcj98BIWyPwC4bF1wzW8ZvhkiO2zr7vfsqXPf9Ezrtylfk5iYuWPceabVB99kbG4VnmimZwJF8DeiCior5TxU+7xwaVEnzXU8gVFM0Gii53Ox9nmoLZeMectTSdp9X7amyrJSQmZTNsEK9ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725571363; c=relaxed/simple;
	bh=YGhPNJL4iiPpm4RThzyvyAvkPkqxviwyIHzfty6FW/Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CIspsNgGO7N1KW7/AeeV0UxEPOnaFvnH0UhY4gvIcaDXdIi1DnbuK5OLHYyGl+x+woDz5YYxYqH1ZZfdwJWrreCsczzPUoMAlVQHT9ydrYQGcKmFBUPfzn2Ls0v1bwxLf7lBMdLyQXfkCA1+H1FxBcdQ80YjJDHd//CHH1Knchg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 890FDC4CEC3;
	Thu,  5 Sep 2024 21:22:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: ntb@lists.linux.dev
Cc: jdmason@kudzu.us,
	allenbh@gmail.com,
	jerry.dai@intel.com,
	baolu.lu@intel.com,
	fenghua.yu@intel.com
Subject: [PATCH] ntb: Force physically contiguous allocation of rx ring buffers
Date: Thu,  5 Sep 2024 14:22:07 -0700
Message-ID: <20240905212207.1914693-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Physical addresses under IOVA on x86 platform are mapped contiguously
as a side effect before the patch that removed CONFIG_DMA_REMAP. The
NTB rx buffer ring is a single chunk DMA buffer that is allocated
against the NTB PCI device. If the receive side is using a DMA device,
then the buffers are remapped against the DMA device before being
submitted via the dmaengine API. This scheme becomes a problem when
the physical memory is discontiguous. When dma_map_page() is called
on the kernel virtual address from the dma_alloc_coherent() call, the
new IOVA mapping no longer points to all the physical memory allocated
due to being discontiguous. Change dma_alloc_coherent() to dma_alloc_attrs()
in order to force DMA_ATTR_FORCE_CONTIGUOUS attribute. This is the best
fix for the circumstance. A potential future solution may be having the DMA
mapping API providing a way to alias an existing IOVA mapping to a new
device perhaps.

This fix is not to fix the patch pointed to by the fixes tag, but to fix
the issue arised in the ntb_transport driver on x86 platforms after the
said patch is applied.

Reported-by: Jerry Dai <jerry.dai@intel.com>
Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
Tested-by: Jerry Dai <jerry.dai@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..a121f360e93b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -807,14 +807,27 @@ static void ntb_free_mw(struct ntb_transport_ctx *nt, int num_mw)
 }
 
 static int ntb_alloc_mw_buffer(struct ntb_transport_mw *mw,
-			       struct device *dma_dev, size_t align)
+			       struct device *ntb_dev, size_t align)
 {
 	dma_addr_t dma_addr;
 	void *alloc_addr, *virt_addr;
 	int rc;
 
-	alloc_addr = dma_alloc_coherent(dma_dev, mw->alloc_size,
-					&dma_addr, GFP_KERNEL);
+	/*
+	 * The buffer here is allocated against the NTB device. The reason to
+	 * use dma_alloc_*() call is to allocate a large IOVA contiguous buffer
+	 * backing the NTB BAR for the remote host to write to. During receive
+	 * processing, the data is being copied out of the receive buffer to
+	 * the kernel skbuff. When a DMA device is being used, dma_map_page()
+	 * is called on the kvaddr of the receive buffer (from dma_alloc_*())
+	 * and remapped against the DMA device. It appears to be a double
+	 * DMA mapping of buffers, but first is mapped to the NTB device and
+	 * second is to the DMA device. DMA_ATTR_FORCE_CONTIGUOUS is necessary
+	 * in order for the later dma_map_page() to not fail.
+	 */
+	alloc_addr = dma_alloc_attrs(ntb_dev, mw->alloc_size,
+				     &dma_addr, GFP_KERNEL,
+				     DMA_ATTR_FORCE_CONTIGUOUS);
 	if (!alloc_addr) {
 		dev_err(dma_dev, "Unable to alloc MW buff of size %zu\n",
 			mw->alloc_size);
-- 
2.46.0

