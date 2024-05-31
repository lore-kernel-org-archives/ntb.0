Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAE11CD11
	for <ntb@lists.linux.dev>; Fri, 31 May 2024 07:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717140092; cv=none; b=a71QIv4ol0CVKU+H/AB6QgcVujC3BtB26vK88+P8Nf2xY9fgxeAj2niNanZ68gf08l3NKW6SXt3pVZnSRqW+d/96tWBJK0zjSll8FziuDv629wkDFpZqasH+uDv8IzSq2L9tXOne8l7qB3lfM0hSG3jnDE1b2SHZ7aGO87zmf1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717140092; c=relaxed/simple;
	bh=LDE8YRBxlSxOgZ6jcZUK+SvtohVTgLX/oJvE1MKf410=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Bn+rKTbLFzoPdmV5dpgzviirCriA7zqjF4xlwRgJReSRbseoXCPjevkBPIR681ezlkqxEWZ7tAeXTXDjN4wDMRw+8fztscIvYyon7XcoeEvwsrwdSdq4GDtOoZMvn2XpE+RmwR2Y4BI+k7VHdqtu/1L2MH01vPdlqic4ZyCSlYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=CbhylTno; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="CbhylTno"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717140086; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=K5oeXEXSVyaAY2t3+I789HO5yOIeItkWYp4h2MgBgf4=;
	b=CbhylTnozX6o5a8Qm1YqsgviQm7K0oUMtz/63omUsFLG0iH9KfkqdNTj6xyOlfUMRWylH4mMK0Ec+1fHuxDB03NyL71yEiHZ+UKKtDl53jM8I3msSWv9HgmHJpF0np+XymDl3YLKichxnop7BuYdD/43thXzYUku42VMgqJxMfY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W7ZAtHt_1717140085;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W7ZAtHt_1717140085)
          by smtp.aliyun-inc.com;
          Fri, 31 May 2024 15:21:26 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: jdmason@kudzu.us,
	dave.jiang@intel.com,
	allenbh@gmail.com
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next] ntb: Fix kernel-doc param for ntb_transport_create_queue
Date: Fri, 31 May 2024 15:21:24 +0800
Message-Id: <20240531072124.64352-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch updates the function documentation comment for
ntb_transport_create_queue to adhere to the kernel-doc specification.

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 drivers/ntb/ntb_transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index f9e7847a378e..5d466a3f117b 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1966,9 +1966,10 @@ static bool ntb_dma_filter_fn(struct dma_chan *chan, void *node)
 
 /**
  * ntb_transport_create_queue - Create a new NTB transport layer queue
- * @rx_handler: receive callback function
- * @tx_handler: transmit callback function
- * @event_handler: event callback function
+ * @data: user-defined data to associate with the queue
+ * @client_dev: the device structure of the NTB client
+ * @handlers: structure containing receive, transmit, and event callback
+ *	      functions
  *
  * Create a new NTB transport layer queue and provide the queue with a callback
  * routine for both transmit and receive.  The receive callback routine will be
-- 
2.20.1.7.g153144c

