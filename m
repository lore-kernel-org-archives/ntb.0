Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDF215ADA7
	for <ntb@lists.linux.dev>; Fri,  7 Jun 2024 07:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717747048; cv=none; b=Hcr/D+fW1jnDo8sqgHhiFnLgqAPzNwomn+eMi0XCOTG2Vh3BLSIldEZ8vfX0bTrNtcMEVQQiZzWIlNcbaEBYkAcvHtzaWFNOCqqDRLZU9daT6EpxKCM4+yOKYytkljotFKgYhATW2qEmy4/qcq9m8AwEUT8a4KN8jri58Rp75/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717747048; c=relaxed/simple;
	bh=FpuvL4593qRHlpmjQ1YfxZrUGHYKS16ufcV/X677aEk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B8XITYVdBRWMJYiMLLP3lQGMTcJ16sqQAXpEG7efscXdPiBhMTIkpOOX2AvwCCVS+OKCDj6f8A23pJx7T1RpS2ygvzbWPiwrvRfyWI4bMeM7H6YWNXaKKcrPmQNoR6tKBDWNP7JAaOv2cpuuZv6RFewgAN1zbR4vedTLVk0yjKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=tHm8i6C9; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="tHm8i6C9"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717747042; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=LGPDSuEWYQNsSeMeTMESqBCmFs0R73CKvSwzI1HJPxw=;
	b=tHm8i6C9rYGeoA8m7W7ZoA8ll4YNwS2xxfBmya/R819cuKF7sluM3EdNnd5JJdFdE/IHHqZNkv5FXFClVu81omwso4FDdn59dHffJAv9xzgxlEMByL9o4Drst91unMK7z+1GUUAvuwSxea6Dtq/lJu21uTlm1BvioEfkohjHCR4=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045046011;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0W8-TjpP_1717747041;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8-TjpP_1717747041)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 15:57:22 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: dave.jiang@intel.com,
	jdmason@kudzu.us,
	allenbh@gmail.com
Cc: ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>
Subject: [PATCH -next v2] ntb: Fix kernel-doc param for ntb_transport_create_queue
Date: Fri,  7 Jun 2024 15:57:20 +0800
Message-Id: <20240607075720.77136-1-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The patch updates ntb_transport_create_queue() kdoc header to specify the
correct input parameters used by the function.

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

