Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601EC2C08A2
	for <ntb@lists.linux.dev>; Mon,  3 Nov 2025 17:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762190611; cv=none; b=dAXSk9J0e2+szddj1ae0f0PPLBFHvkUN8fAo7vebVqTHnqf9zHb3VoPgL70uzhV+AjEvpkQwLBvhhsDtNlfAkNDaEhkNEeBXL4kEGm8754WbH0A4wwGVO2w4S1KiJQxBePcjpyXNkhg+OYSOQPB54ELaEeu6xhta3AGshMYj8yY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762190611; c=relaxed/simple;
	bh=Ikhpow263l57gpAxqoMYUAgO/+cjrmuDad5LnnkAedU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OF0Q/8m9Zi70757E4qxKEH7Hb6ZRS9FpcKveoQuwcqr/syGMSlZ1OnrML+i2dyA5G3LsT/99mJyPKY+Dfe1fKFDBWlAFv0iga0KRPbKw4pT86WwX+jzIw58CN8BmpUTu/zE2PUjZhrJWSI9rLAmOPoSLeCYF/rcg2/FP02oRHY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=mHj4uUkM; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="mHj4uUkM"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id C0AB0440E97;
	Mon,  3 Nov 2025 19:21:52 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762190512;
	bh=Ikhpow263l57gpAxqoMYUAgO/+cjrmuDad5LnnkAedU=;
	h=From:To:Cc:Subject:Date:From;
	b=mHj4uUkM7l4TIfWOa3Q9IKF6hv/pWs1Z1maSKVn14jowCnsL/QgOQ8LY38OlmPz+a
	 O8V2dt5orPPeoD6FZ9bLymGUzwxqip0xpCV367IlZpYlLlROIyNFsDRJa8gV4UXDZZ
	 ef76LVuhPvN2T8RMAQQZd/CzqFdcibhyiQMLmh7+v1DpTJfwr18n3md3szc2YZEwtd
	 AnRUyMKAyew5biAB5Sv4LYX6xV1Tn/wAHNsjKYknK/Y6F0BxHcDi4aRx849maAYdOV
	 xyiKdk14h0dum5Qnbg2vujMHLnu30zViOSsFgTe3zp2TNiHV1BMZVjcsxHe1AvUshB
	 XdqVUStgd9Lmg==
From: Baruch Siach <baruch@tkos.co.il>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: Koichiro Den <den@valinux.co.jp>,
	ntb@lists.linux.dev,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] NTB: ntb_transport: fix use after free
Date: Mon,  3 Nov 2025 19:23:19 +0200
Message-ID: <c4727cd0bdeb8385b893da59c5eb97a189bf4282.1762190599.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Don't call dmaengine_unmap_put() twice for the same pointer. This
results in mempool_free() being called on a freed element.

Fixes: 6f57fd0578df ("NTB: convert to dmaengine_unmap_data")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/ntb/ntb_transport.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..809fb09658b4 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1573,14 +1573,14 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(offset),
 				      pay_off, len, DMA_TO_DEVICE);
 	if (dma_mapping_error(device->dev, unmap->addr[0]))
-		goto err_get_unmap;
+		goto err_unmap;
 
 	unmap->to_cnt = 1;
 
 	unmap->addr[1] = dma_map_page(device->dev, virt_to_page(buf),
 				      buff_off, len, DMA_FROM_DEVICE);
 	if (dma_mapping_error(device->dev, unmap->addr[1]))
-		goto err_get_unmap;
+		goto err_unmap;
 
 	unmap->from_cnt = 1;
 
@@ -1588,7 +1588,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 					     unmap->addr[0], len,
 					     DMA_PREP_INTERRUPT);
 	if (!txd)
-		goto err_get_unmap;
+		goto err_unmap;
 
 	txd->callback_result = ntb_rx_copy_callback;
 	txd->callback_param = entry;
@@ -1596,7 +1596,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 
 	cookie = dmaengine_submit(txd);
 	if (dma_submit_error(cookie))
-		goto err_set_unmap;
+		goto err_unmap;
 
 	dmaengine_unmap_put(unmap);
 
@@ -1606,9 +1606,7 @@ static int ntb_async_rx_submit(struct ntb_queue_entry *entry, void *offset)
 
 	return 0;
 
-err_set_unmap:
-	dmaengine_unmap_put(unmap);
-err_get_unmap:
+err_unmap:
 	dmaengine_unmap_put(unmap);
 err:
 	return -ENXIO;
@@ -1854,14 +1852,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 	unmap->addr[0] = dma_map_page(device->dev, virt_to_page(buf),
 				      buff_off, len, DMA_TO_DEVICE);
 	if (dma_mapping_error(device->dev, unmap->addr[0]))
-		goto err_get_unmap;
+		goto err_unmap;
 
 	unmap->to_cnt = 1;
 
 	txd = device->device_prep_dma_memcpy(chan, dest, unmap->addr[0], len,
 					     DMA_PREP_INTERRUPT);
 	if (!txd)
-		goto err_get_unmap;
+		goto err_unmap;
 
 	txd->callback_result = ntb_tx_copy_callback;
 	txd->callback_param = entry;
@@ -1869,16 +1867,14 @@ static int ntb_async_tx_submit(struct ntb_transport_qp *qp,
 
 	cookie = dmaengine_submit(txd);
 	if (dma_submit_error(cookie))
-		goto err_set_unmap;
+		goto err_unmap;
 
 	dmaengine_unmap_put(unmap);
 
 	dma_async_issue_pending(chan);
 
 	return 0;
-err_set_unmap:
-	dmaengine_unmap_put(unmap);
-err_get_unmap:
+err_unmap:
 	dmaengine_unmap_put(unmap);
 err:
 	return -ENXIO;
-- 
2.51.0

