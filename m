Received: from mail.tkos.co.il (guitar.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D80A2BE63A
	for <ntb@lists.linux.dev>; Mon,  3 Nov 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762155923; cv=none; b=hJcVncIJMCfNNkm5dc2jNOP3KxnLmbQ2i4Z1euGRoU7VKmXqsht46uFA9R+aO5rRnLY3R6TYU3BhVxLIOSqwlFf0lQcy2cvDspU3Gbkknw5PXDh1EtzO2q+ADPlouO3LK8/jUsshwD5INFmF5VNy63LfTd4h7eVC6NRFlyhw6gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762155923; c=relaxed/simple;
	bh=WN3XM1IqSMBLFAW4B0wIfhGc+jipKWuvmVHo10mu5D0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNom8hHbn4K8e3JGnM/KFQVutG0RNGVMEYex+eZWeKwYw/by3ff70HOsKnphMbbohtdhWifxnuylycSQ9BG9AYuX0QVRBjSBp+4Cum32Ck8wy++fjU9BBiJTamIcQSEjq/gmqwgsaBPIBF3aC0oEUf2BuUrTAlv88Y3JCe+40Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=BltxVg70; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="BltxVg70"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id 0BB69440F4B;
	Mon,  3 Nov 2025 09:43:48 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762155828;
	bh=WN3XM1IqSMBLFAW4B0wIfhGc+jipKWuvmVHo10mu5D0=;
	h=From:To:Cc:Subject:Date:From;
	b=BltxVg70Xn9Ixm/vmCBY14zy8KNVpBmphLrfqpNYdPP/fYH8SZ/nsL1bECGo1RWYE
	 sK+XH3fhJlCkp/C9MTZjRMLCvpKU9+9RN6fgKT8/Ku/qgOnHkKqlKCRaufoNoTRunE
	 XF60cGIg4OFxj9x3zMUE4a7UYxNOpn2HVu4ZflbYVXAH+2WJUIpIQ9BlKSutq11j5d
	 13qx+FQmOWOPF1deRnGkVFzxQs8nUolTNeyWzqGi2QXmq3BK5LS3orvnxnpX42/734
	 /2kv5F9SurwgQNpmaObYqYS45q0XBLujbQJ98RDIZ+hD9PBKxldmjadCrc1iJXECAA
	 TcIGAn5Gz4YEg==
From: Baruch Siach <baruch@tkos.co.il>
To: Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH] NTB: epf: allow built-in build
Date: Mon,  3 Nov 2025 09:44:55 +0200
Message-ID: <514bd0fb18e83026af0a3e90683f8a2469564e06.1762155895.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ntb_hw_epf works just as well when built into the kernel image. Don't
force module build.

Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 drivers/ntb/hw/epf/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
index 6197d1aab344..314485574bf8 100644
--- a/drivers/ntb/hw/epf/Kconfig
+++ b/drivers/ntb/hw/epf/Kconfig
@@ -1,6 +1,5 @@
 config NTB_EPF
 	tristate "Generic EPF Non-Transparent Bridge support"
-	depends on m
 	help
 	  This driver supports EPF NTB on configurable endpoint.
 	  If unsure, say N.
-- 
2.51.0

