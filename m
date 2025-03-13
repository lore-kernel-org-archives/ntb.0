Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D27A267B6A
	for <ntb@lists.linux.dev>; Thu, 13 Mar 2025 13:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741871026; cv=none; b=cznNw2NtFkQPlRGDjwTCkbQud8zoTK9QCK0BSEeFoklV9VVPXIWwta8sWd9mrvv8vdP4zfO7OmavcLMez43gz7nL+6BvFu1GbhV+k5y2a3IQEAD9gtS/8Q8iJ3JRwnIQnKdU9eAYWn3KuqxV3+ypQLQfgVxgArTMVjHcCjDiNoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741871026; c=relaxed/simple;
	bh=qVLn6ogbWidzSjCJP5XFPquGm5LxCS8oOzQG4fE1OLI=;
	h=Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Date; b=lWFxW3D6S3k9yYhaTReVXFFBDzK2AG2t4OA/C5H7yWEFjSpDHzOHUuGEq9SZ/Ez9HbonXL4UEnmNVk38+nUyLVEVdNzmVBIYtHhN56zEGjZNWTbS1szBN1YMw4P9uQLNEFdhTmAlrepsjk48ePm9I/2aND1egTwJXCv94078tD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x8loAjsn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYAEDkqy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x8loAjsn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYAEDkqy"
Message-ID: <20250313130321.631772601@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741871023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0CMM5PtULSzUKaKYGBG7pUG78FCDwJRzCxffhXq5CuA=;
	b=x8loAjsnVC4+kX/UBoY+UQCY47KTWtRjKwJNd74if6qE+aEmn3tRBBLFYou/gQCtAP77uq
	hLAs+ZEudkMZ1MaP+LF211snLK7ppIm6IAeSxp7qq9OO3ACtLT3+0SZ+xeVUubcQhgqpER
	fVbloaXfjAE3w40Rzq68bcHe4vXmERWth5cBp2x5SmDxWvXvzIFmVejGbkGF177T7gFh0M
	hkJN5wED0wl6PK1r3qcvGq6nJKNXBFY7NAmBQJpxQ4IuZ/ySHYbQGZJXxGx8rVWYZLRlhu
	B4smMLz15X5Q8j2rH5CO33RFm3E9i4hg8NwuuKMGTJ3pXRcxUZ5Z/aTZUyqaRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741871023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=0CMM5PtULSzUKaKYGBG7pUG78FCDwJRzCxffhXq5CuA=;
	b=TYAEDkqytacLpGKxYUYm7ZAusYiccvMKB5B6P75fO7P5fmzI6qkr7Z47WRlzKaCYeTqbPD
	wSqJvYCamb/whtAg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@kernel.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Logan Gunthorpe <logang@deltatee.com>,
 Dave Jiang <dave.jiang@intel.com>,
 Jon Mason <jdmason@kudzu.us>,
 Allen Hubbe <allenbh@gmail.com>,
 ntb@lists.linux.dev,
 Peter Zijlstra <peterz@infradead.org>,
 Nishanth Menon <nm@ti.com>,
 Dhruva Gole <d-gole@ti.com>,
 Tero Kristo <kristo@kernel.org>,
 Santosh Shilimkar <ssantosh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org,
 Michael Kelley <mhklinux@outlook.com>,
 Wei Liu <wei.liu@kernel.org>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 linux-hyperv@vger.kernel.org,
 Wei Huang <wei.huang2@amd.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-scsi@vger.kernel.org,
 Jonathan Cameron <Jonathan.Cameron@huwei.com>
Subject: [patch V2 04/10] NTB/msi: Switch MSI descriptor locking to lock
 guard()
References: <20250313130212.450198939@linutronix.de>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Thu, 13 Mar 2025 14:03:43 +0100 (CET)

Convert the code to use the new guard(msi_descs_lock).

No functional change intended.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Acked-by: Dave Jiang <dave.jiang@intel.com>
Cc: Jon Mason <jdmason@kudzu.us>
Cc: Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev

---
 drivers/ntb/msi.c |   22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

--- a/drivers/ntb/msi.c
+++ b/drivers/ntb/msi.c
@@ -106,10 +106,10 @@ int ntb_msi_setup_mws(struct ntb_dev *nt
 	if (!ntb->msi)
 		return -EINVAL;
 
-	msi_lock_descs(&ntb->pdev->dev);
-	desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
-	addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
-	msi_unlock_descs(&ntb->pdev->dev);
+	scoped_guard (msi_descs_lock, &ntb->pdev->dev) {
+		desc = msi_first_desc(&ntb->pdev->dev, MSI_DESC_ASSOCIATED);
+		addr = desc->msg.address_lo + ((uint64_t)desc->msg.address_hi << 32);
+	}
 
 	for (peer = 0; peer < ntb_peer_port_count(ntb); peer++) {
 		peer_widx = ntb_peer_highest_mw_idx(ntb, peer);
@@ -289,7 +289,7 @@ int ntbm_msi_request_threaded_irq(struct
 	if (!ntb->msi)
 		return -EINVAL;
 
-	msi_lock_descs(dev);
+	guard(msi_descs_lock)(dev);
 	msi_for_each_desc(entry, dev, MSI_DESC_ASSOCIATED) {
 		if (irq_has_action(entry->irq))
 			continue;
@@ -307,17 +307,11 @@ int ntbm_msi_request_threaded_irq(struct
 		ret = ntbm_msi_setup_callback(ntb, entry, msi_desc);
 		if (ret) {
 			devm_free_irq(&ntb->dev, entry->irq, dev_id);
-			goto unlock;
+			return ret;
 		}
-
-		ret = entry->irq;
-		goto unlock;
+		return entry->irq;
 	}
-	ret = -ENODEV;
-
-unlock:
-	msi_unlock_descs(dev);
-	return ret;
+	return -ENODEV;
 }
 EXPORT_SYMBOL(ntbm_msi_request_threaded_irq);
 



