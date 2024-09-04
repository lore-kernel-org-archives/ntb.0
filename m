Received: from cmccmta1.chinamobile.com (cmccmta4.chinamobile.com [111.22.67.137])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB421C871A
	for <ntb@lists.linux.dev>; Wed,  4 Sep 2024 08:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725438905; cv=none; b=cvo0eWsZMVCANgJiDsoqnuCsYplvaSAIPKmtNPO44FgmJ8KgYwE9qzXkHo3DAAIcwCr6MESsHJ8YfTqBXOO2TVxzaUARhosyqoZs3v3sdtLnATf/vMB38SyBxceBKRsYu6042ECOCNOqDTzG9OZPNRFkAEWwIq7gQqrjgkWqegM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725438905; c=relaxed/simple;
	bh=Fb+HAj/0/rc13Oz+/lwCLpb0c6ipSymkclzff49pYsQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dYwlt20UUsxywgyUYfoBXLwZFCuWPLUhTCbHvaCIGhV7fDQopkUwkvx715Dqnn4gdTg8FMCR0bqvECRH0xgmIE8YHvI2a4Y3V6ofD/r/OxC60Rs6pBuRwmgv82phIuTypN768aQ2X4fFIvL9AmdVTLYhPt59i37r5OoSHjmvyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app04-12004 (RichMail) with SMTP id 2ee466d81bb24e7-b4ddb;
	Wed, 04 Sep 2024 16:34:58 +0800 (CST)
X-RM-TRANSID:2ee466d81bb24e7-b4ddb
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.97])
	by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea66d81bb249d-1db7d;
	Wed, 04 Sep 2024 16:34:58 +0800 (CST)
X-RM-TRANSID:2eea66d81bb249d-1db7d
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: fancer.lancer@gmail.com
Cc: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] ntb: idt: Fix the cacography in ntb_hw_idt.c
Date: Wed,  4 Sep 2024 14:54:42 +0800
Message-Id: <20240904065442.102889-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

The word 'swtich' is wrong, so fix it.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/ntb/hw/idt/ntb_hw_idt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/ntb/hw/idt/ntb_hw_idt.c b/drivers/ntb/hw/idt/ntb_hw_idt.c
index 48dfb1a69a77..6fc9dfe82474 100644
--- a/drivers/ntb/hw/idt/ntb_hw_idt.c
+++ b/drivers/ntb/hw/idt/ntb_hw_idt.c
@@ -2547,7 +2547,7 @@ static void idt_deinit_dbgfs(struct idt_ntb_dev *ndev)
  */
 
 /*
- * idt_check_setup() - Check whether the IDT PCIe-swtich is properly
+ * idt_check_setup() - Check whether the IDT PCIe-switch is properly
  *		       pre-initialized
  * @pdev:	Pointer to the PCI device descriptor
  *
-- 
2.33.0



