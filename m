Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE0B2862B7;
	Thu, 20 Feb 2025 02:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740017046; cv=none; b=J5xv6EKZSVcwrWJAIefPMe8oYlvRnexAc/xKlj8kxqLHfkHmKtqCbTDgzOvTVBqNKPRZeD/kH+Nj6d8xDdZFF0viXWlk+M0CaCKtYvBDUpZDaUURibvk/Hz+O/vcpWcInyHnwZ6sgQ0nvMIW2FFUs0sFmzSImes0CCvzNx+TQa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740017046; c=relaxed/simple;
	bh=x5cjDMDsv7w85Yapce22+pZzXw+ddrsPkbcqrguWU9E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m3CzwAiG7HbySWppnK2/fNXQlCf/mSe+K3+nBeQZKxibvdJjY8sw+JhIxy6rryrPIBrrPksMRwPlW8y51KTXuR+eU+XXo7zyrL9fSvIoJzWuA8ZlZhce73CJaTjnR3n4H67+sJHK3AIrKooCRc0gIRcwfxHAhM+PPlJFx3tZ7wI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=E6wGL2zM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="E6wGL2zM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=61OljuFLi7l3nQhb+KjzkmEHrgBFPI8Hr7sRlq6rWZc=; b=E6wGL2zMpuMApSOS
	5JL6u4TUBxWezXwjUp0eWrvq3CPF05dtqOkp7BppMHGvlWhMrL+CkCUv6ycEPScES0K5ATcCdavh3
	ifFLSd/p/S4SAMxTX0whh7+pMacFysf9UfYbVhAoDeCKP/g9YYq18ePSQfqYz4eCPr2LARpfbCQ/V
	yutZu//hGVWm3F32ypI0bqJBUQpHfqGmrlqNPrvlNtBUyn01oecKSAffXXeMLnzqOp6necBdHFQ5P
	6gAGtAWzkqh9RkAREzuSV4f2ctwUciuxdFozHPTWdaJ5+Tm51/59lm0w5t4kD1EbrT5++CNAwwTzR
	I6vCRG427UrSNXZgMQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tkvuw-00H3Zg-1m;
	Thu, 20 Feb 2025 02:03:58 +0000
From: linux@treblig.org
To: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] NTB/msi: Remove unused functions
Date: Thu, 20 Feb 2025 02:03:57 +0000
Message-ID: <20250220020357.122973-1-linux@treblig.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

ntbm_msi_free_irq() and ntb_msi_peer_addr() were both added in 2019's
commit 26b3a37b9284 ("NTB: Introduce MSI library")
but have remained unused.

Remove them, and the ntbm_msi_callback_match() helper that
was used by ntbm_msi_free_irq().

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/ntb/msi.c   | 64 ---------------------------------------------
 include/linux/ntb.h | 14 ----------
 2 files changed, 78 deletions(-)

diff --git a/drivers/ntb/msi.c b/drivers/ntb/msi.c
index 6295e55ef85e..8ad9be95518f 100644
--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -321,37 +321,6 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
 
-static int ntbm_msi_callback_match(struct device *dev, void *res, void *data)
-{
-	struct ntb_dev *ntb = dev_ntb(dev);
-	struct ntb_msi_devres *dr = res;
-
-	return dr->ntb == ntb && dr->entry == data;
-}
-
-/**
- * ntbm_msi_free_irq() - free an interrupt
- * @ntb:	NTB device context
- * @irq:	Interrupt line to free
- * @dev_id:	Device identity to free
- *
- * This function should be used to manually free IRQs allocated with
- * ntbm_request_[threaded_]irq().
- */
-void ntbm_msi_free_irq(struct ntb_dev *ntb, unsigned int irq, void *dev_id)
-{
-	struct msi_desc *entry = irq_get_msi_desc(irq);
-
-	entry->write_msi_msg = NULL;
-	entry->write_msi_msg_data = NULL;
-
-	WARN_ON(devres_destroy(&ntb->dev, ntbm_msi_callback_release,
-			       ntbm_msi_callback_match, entry));
-
-	devm_free_irq(&ntb->dev, irq, dev_id);
-}
-EXPORT_SYMBOL(ntbm_msi_free_irq);
-
 /**
  * ntb_msi_peer_trigger() - Trigger an interrupt handler on a peer
  * @ntb:	NTB device context
@@ -379,36 +348,3 @@ int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
 	return 0;
 }
 EXPORT_SYMBOL(ntb_msi_peer_trigger);
-
-/**
- * ntb_msi_peer_addr() - Get the DMA address to trigger a peer's MSI interrupt
- * @ntb:	NTB device context
- * @peer:	Peer index
- * @desc:	MSI descriptor data which triggers the interrupt
- * @msi_addr:   Physical address to trigger the interrupt
- *
- * This function allows using DMA engines to trigger an interrupt
- * (for example, trigger an interrupt to process the data after
- * sending it). To trigger the interrupt, write @desc.data to the address
- * returned in @msi_addr
- *
- * Return: Zero on success, otherwise a negative error number.
- */
-int ntb_msi_peer_addr(struct ntb_dev *ntb, int peer,
-		      struct ntb_msi_desc *desc,
-		      phys_addr_t *msi_addr)
-{
-	int peer_widx = ntb_peer_mw_count(ntb) - 1 - peer;
-	phys_addr_t mw_phys_addr;
-	int ret;
-
-	ret = ntb_peer_mw_get_addr(ntb, peer_widx, &mw_phys_addr, NULL);
-	if (ret)
-		return ret;
-
-	if (msi_addr)
-		*msi_addr = mw_phys_addr + desc->addr_offset;
-
-	return 0;
-}
-EXPORT_SYMBOL(ntb_msi_peer_addr);
diff --git a/include/linux/ntb.h b/include/linux/ntb.h
index 191b524e5c0d..8ff9d663096b 100644
--- a/include/linux/ntb.h
+++ b/include/linux/ntb.h
@@ -1647,12 +1647,8 @@ int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb, irq_handler_t handler,
 				  irq_handler_t thread_fn,
 				  const char *name, void *dev_id,
 				  struct ntb_msi_desc *msi_desc);
-void ntbm_msi_free_irq(struct ntb_dev *ntb, unsigned int irq, void *dev_id);
 int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
 			 struct ntb_msi_desc *desc);
-int ntb_msi_peer_addr(struct ntb_dev *ntb, int peer,
-		      struct ntb_msi_desc *desc,
-		      phys_addr_t *msi_addr);
 
 #else /* not CONFIG_NTB_MSI */
 
@@ -1674,21 +1670,11 @@ static inline int ntbm_msi_request_threaded_irq(struct ntb_dev *ntb,
 {
 	return -EOPNOTSUPP;
 }
-static inline void ntbm_msi_free_irq(struct ntb_dev *ntb, unsigned int irq,
-				     void *dev_id) {}
 static inline int ntb_msi_peer_trigger(struct ntb_dev *ntb, int peer,
 				       struct ntb_msi_desc *desc)
 {
 	return -EOPNOTSUPP;
 }
-static inline int ntb_msi_peer_addr(struct ntb_dev *ntb, int peer,
-				    struct ntb_msi_desc *desc,
-				    phys_addr_t *msi_addr)
-{
-	return -EOPNOTSUPP;
-
-}
-
 #endif /* CONFIG_NTB_MSI */
 
 static inline int ntbm_msi_request_irq(struct ntb_dev *ntb,
-- 
2.48.1

