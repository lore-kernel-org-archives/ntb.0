Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DBF2BE62B
	for <ntb@lists.linux.dev>; Mon, 25 Aug 2025 09:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756113324; cv=none; b=gkW2pVe1xd9M8iNGefUDX05aUPGx27vLZ4U3MX1W8yPwD8FIesxz+ahmLS0ybPxgSNb4rj1UQzS/pWXPd3DsEew21D/M9cYFgexeIRAOHKm8ezGSp9ZpiRz1hXiVy5+MafBN4mNZPXUmeeCpORV/r8GxdgsJxnFubaczvoCKQwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756113324; c=relaxed/simple;
	bh=frWilHKtOC7ibOioFIhO93e3vGAB4SI1rbdEQyYyVJ4=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=rpDVz5jFrzWBxbuRIUJAAtkJrRqcgPTt8kgecptWpTSLCC6JFwyZF33SML1592eZjwViW1iL2yYXMZWmFE6Upa6cD02/gH7mL1JYGzmozk0Og5A0+WrTkcxrWsqmvIjwoOf7ZA59sbFwP/O0qfWzvz1Z8y49jsUr86WkCUr5cDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PYoODs7a; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PYoODs7a"
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b4c21867cceso373911a12.1
        for <ntb@lists.linux.dev>; Mon, 25 Aug 2025 02:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756113322; x=1756718122; darn=lists.linux.dev;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1EfPpvJ6+WhTEmPpSG5PEfw+gk8iXNJsS1zHeL+VA0I=;
        b=PYoODs7asIQf6ZeK4/MRK9kUFGBmYysDuxyT+4FmAjB+h19hV/bw6zaMQJJ2/fYf6I
         4cCLPa6C/hn66f6QMIVIEY8tvWg0mHW7DHKJL5bdYKO0vC24ARQTajuo/GVatb3Uon/G
         FFBGKRR3IYmG3xU+uQIwxEkqkNSrmIpmXx378CfxMGMyQqfpMWzVo3pPG0BsgjowjRQL
         fsfwb9lixhSB3vTlv3Vj6ExzRkzI+iJIAPonRGm3hyPNkbNz1V+ENG51rP+hwTrMUVna
         oz5dlloUiGZrepWI+Pl/JJV3UkGBweYrZBkDf/x6GIYmPsB3W6bkMbPHd7jBEdHXOeT8
         SzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756113322; x=1756718122;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1EfPpvJ6+WhTEmPpSG5PEfw+gk8iXNJsS1zHeL+VA0I=;
        b=TTeWsAG1wSeCSUkz/xhQl1gWkZFRDkxa0cxEuEOBLstq9jw7W/pcMqlwgD9LqL+oBF
         vX7PxNy+j8026SPIl29bP2xMbKAx8V8/aPZd1jMBAc6if9Q6ATFPaU/37MYYbZ5ad6DE
         QbVeEBsKMr3HJYZhK7pjeXMikXI7iCjrpxRLBrW509vFXXaCgfkJTih76gSjjK6WTehX
         zk0RQcNOvyiDIQmwKozUiRiGSMHnFc9QlPqfAhd7X/bgA92mAo2+6xehR/6syVoS3JgY
         fv6FqdhAW8cQY+vs2YS5JBUce5dQxT1Vhr+5gYFfyd7pn2bsTTvLlc0RWKEEOVdZBysM
         OgPw==
X-Gm-Message-State: AOJu0YxeiP54N0mNJZMvJNed5fSSg8DqPSotSjxTw9UyeJMySeCN3M68
	C+BTBW1in0xq6XRb2MboIH2van1kvAGyBDFFQb01/0nVNcu0hZCj4Hc=
X-Gm-Gg: ASbGncttjtdzU2H7UbQpRCxY/GR4epS1rPZ7cfT/BuQYp3/7ZkZ/pHTEhdoXnffszQ5
	8ZkGZuMRs6fVrwvy1DrCLcTKues1j1wAqCEUkqMz/HTqiHzhMmZNAEAwWI7PsDbgPkQ/tUeTUqR
	GmjOOpmsjPDLEbcz6UIIcwA9dJEvtOEy+WaFjzapbLMwMvBUaznPXD30qzMmk8oq7iWHAMRLYk5
	9Q7Drq8RSTviaGCTF1OHW6ntnbdBIdJCnNG8gQ2jthci9vlu6Tdyi5Ggn41ht8P5OnOSl4/q0q2
	nxre+vk5QaxGJhbV3+NvDfXOdJyu4R5qS1zjUG422xc2sQLdLQzoWhT+RrMpk9E3R0KHMlbuCxW
	Uqlu93iUNkUCiv1srNoFDqKBTwVVcffBLpxUTi4kHFUcLrHrG2yS5gFPXXOo=
X-Google-Smtp-Source: AGHT+IGM+hvjIncidO6+06hwgjNzVfwutWvQvN1StGNPqmAytpX8YR1SEbFsIYGuWTIGKBQS+eJdCA==
X-Received: by 2002:a17:902:d486:b0:246:b46b:1b09 with SMTP id d9443c01a7336-246b46b2296mr52545635ad.30.1756113321877;
        Mon, 25 Aug 2025 02:15:21 -0700 (PDT)
Received: from didi-ThinkCentre-M930t-N000 ([46.232.49.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2466877a04dsm63318855ad.21.2025.08.25.02.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 02:15:20 -0700 (PDT)
From: fuyuanli <fuyuanli0722@gmail.com>
X-Google-Original-From: fuyuanli <fuyuanli@didiglobal.com>
Date: Mon, 25 Aug 2025 17:15:08 +0800
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
	fuyuanli0722@gmail.com
Subject: [PATCH v2] ntb: Add mutex to make link_event_callback executed
 linearly.
Message-ID: <aKwpnFtdtBlDv69O@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org,
	fuyuanli0722@gmail.com
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since the CPU selected by schedule_work is uncertain, multiple link_event
callbacks may be executed at same time. For example, after peer's link is
up, it is down quickly before local link_work completed. If link_cleanup
is added to the workqueue of another CPU, then link_work and link_cleanup
may be executed at the same time. So add a mutex to prevent them from being
executed concurrently.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
v2:
1) use guard() instead of lock & unlock functions.

v1:
Link: https://lore.kernel.org/all/aKiBi4ZDlbgzed%2Fz@didi-ThinkCentre-M930t-N000/
---
 drivers/ntb/ntb_transport.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4f775c3e218f..eb875e3db2e3 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -59,6 +59,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 #include <linux/uaccess.h>
+#include <linux/mutex.h>
 #include "linux/ntb.h"
 #include "linux/ntb_transport.h"
 
@@ -241,6 +242,9 @@ struct ntb_transport_ctx {
 	struct work_struct link_cleanup;
 
 	struct dentry *debugfs_node_dir;
+
+	/* Make sure workq of link event be executed serially */
+	struct mutex link_event_lock;
 };
 
 enum {
@@ -1024,6 +1028,7 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
+	guard(mutex)(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
 }
 
@@ -1047,6 +1052,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 	u32 val;
 	int rc = 0, i, spad;
 
+	guard(mutex)(&nt->link_event_lock);
+
 	/* send the local info, in the opposite order of the way we read it */
 
 	if (nt->use_msi) {
-- 
2.34.1

