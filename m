Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43175256C98
	for <ntb@lists.linux.dev>; Wed, 19 Mar 2025 10:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742381825; cv=none; b=CmgZDCCZK61DRDkYnC44tgHbcNjEuvffOjMw5BDMAvtjzj6bjaWtuBUMwAxEpiCKAx0n8kXUUmidfcLEXWhzG7qUx6fC5oBeLfvMRrRc7+xMpVNwg+oRcN/wTK/v/BqOu+CgSHWLhThUVp1yVta2I97d1hlKJHPOvzAwV+V6ZGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742381825; c=relaxed/simple;
	bh=ssriv9UH6GIB/QKdfAdOk80drmt5lDBuDkd1XkOsiE0=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=ih8GrusaruqxjFHHzFQSZVz5EtP8vWY6dd2rH0yDS/ABO4doB5xsZ/K1hBcIB5QCclq/BN/mtgFZTclumGAEcedtKtNRHig1cljAM33/W7BX0kxOqsQv43MA/XmxKpHoYes4Pznp//quLsnYjdxd19F+lLgKukRmJ3pC3jfjgB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UpGxDyVF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1phf6hT4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UpGxDyVF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1phf6hT4"
Message-ID: <20250319105506.864699741@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742381822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DJS/MIuQIZyuzMhWo7bDK73OC9n1sTuX5FBXKqqm6mY=;
	b=UpGxDyVF0R1wBUxx66iI7swqRGmg9632kkYAxPyZAPgM4xJ27/xpYxecVg22I1J0eqdkil
	nAWOENQ+xaUKbQMhrd2UtL6sN+WLifNNgK0iAMAJL2yQGt6tyCrSdWBk4aUujiEWQ+1jAZ
	FSuoiAwlgAhLKVGCGFvEw9oe3pbN38pFIHbxf/t3TNpX7kyWQ4yGXe3BnIzN17ihzvhxNT
	B/0JeJbruwoEJzxNALqlHemGsXUlDZ81avSmgWqAjIrdFYzFPDTJBKX7YVXyfhLCLyV5X/
	7uMD8TC/EGrxQx8y5lpETp+uU/HCQkgF9JXZhNhGAp1Xu/nnSWW7f9yv5s7BiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742381822;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=DJS/MIuQIZyuzMhWo7bDK73OC9n1sTuX5FBXKqqm6mY=;
	b=1phf6hT4SmXq+7Lh4D3JcBX7vfH4Rn2FSaEHLGg7yTbiCEULM2yawtTU3jI9pqeWFsKdp/
	kKfaHAr2lfc8xPBw==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org
Subject: [patch V4 14/14] genirq/msi: Rename msi_[un]lock_descs()
References: <20250319104921.201434198@linutronix.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Mar 2025 11:57:01 +0100 (CET)

Now that all abuse is gone and the legit users are converted to
guard(msi_descs_lock), rename the lock functions and document them as
internal.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com>


---
 include/linux/msi.h |    8 ++++----
 kernel/irq/msi.c    |   16 ++++++++++------
 2 files changed, 14 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -224,11 +224,11 @@ struct msi_dev_domain {
 
 int msi_setup_device_data(struct device *dev);
 
-void msi_lock_descs(struct device *dev);
-void msi_unlock_descs(struct device *dev);
+void __msi_lock_descs(struct device *dev);
+void __msi_unlock_descs(struct device *dev);
 
-DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, msi_lock_descs(_T->lock),
-		    msi_unlock_descs(_T->lock));
+DEFINE_LOCK_GUARD_1(msi_descs_lock, struct device, __msi_lock_descs(_T->lock),
+		    __msi_unlock_descs(_T->lock));
 
 struct msi_desc *msi_domain_first_desc(struct device *dev, unsigned int domid,
 				       enum msi_desc_filter filter);
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -338,26 +338,30 @@ int msi_setup_device_data(struct device
 }
 
 /**
- * msi_lock_descs - Lock the MSI descriptor storage of a device
+ * __msi_lock_descs - Lock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_lock_descs(struct device *dev)
+void __msi_lock_descs(struct device *dev)
 {
 	mutex_lock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_lock_descs);
+EXPORT_SYMBOL_GPL(__msi_lock_descs);
 
 /**
- * msi_unlock_descs - Unlock the MSI descriptor storage of a device
+ * __msi_unlock_descs - Unlock the MSI descriptor storage of a device
  * @dev:	Device to operate on
+ *
+ * Internal function for guard(msi_descs_lock). Don't use in code.
  */
-void msi_unlock_descs(struct device *dev)
+void __msi_unlock_descs(struct device *dev)
 {
 	/* Invalidate the index which was cached by the iterator */
 	dev->msi.data->__iter_idx = MSI_XA_MAX_INDEX;
 	mutex_unlock(&dev->msi.data->mutex);
 }
-EXPORT_SYMBOL_GPL(msi_unlock_descs);
+EXPORT_SYMBOL_GPL(__msi_unlock_descs);
 
 static struct msi_desc *msi_find_desc(struct msi_device_data *md, unsigned int domid,
 				      enum msi_desc_filter filter)

