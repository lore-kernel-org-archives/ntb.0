Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914C5309DAA
	for <ntb@lists.linux.dev>; Fri, 22 Aug 2025 14:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755873684; cv=none; b=USWbVOYHFaGE3OID+9KIRop4Vt9CI9+44TcYsWs44wqDedjyZGFF72ziyV3yo1dii+Me/2WKcjRu5e4Ej+AqHx8fToyKvLI+t/NIxaOZJBDogqxR2mSHrGQrtqqvhpxVHB8q6rEyPC7aNXCzmeTytoRnkrYjyEHODazmO/Tpdao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755873684; c=relaxed/simple;
	bh=cOKiNR1OqsXvaoXMGRfm/iAMpfIw5WeEz8zS1By03+4=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=odxUcTL9uHwSuY2Tl2ZBBicD7vivKIb13sXhqkxLyjjLpZgHZ/724kOpClAh36/M4aoSuTxk4oGWL7KeP9pMX4tHw2cSwOmN7lQJFQvRLLp1csRk/8CDMst6viS2PVBwkpcWYDJ3wzR1a8Gah5TAqrES15J4FNA3zAiJoHUejmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvuVo6Ml; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvuVo6Ml"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-32326e2f0b3so1742155a91.2
        for <ntb@lists.linux.dev>; Fri, 22 Aug 2025 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755873682; x=1756478482; darn=lists.linux.dev;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m2a0v5c2RPOmVHPi5zsER9bdyoW9/sdLoaF8GR0neeg=;
        b=GvuVo6MlkzzHvPXMJZEXb2vmtwboqW5s7XBrB2mNLbuMFAn0Oyw8bH0AnGHJ0VYkaJ
         sZeIIQD+znG9TdJnCvLr8UsIKUTuOzWMYzHMpeXsbdEKu2ouRgudcCK/cJ3cuauFIy03
         jBv5HyP30p3MVDkeLeKN2fyFz01zLqcfReNEYfo7cfKlcowwXWt88IUexI1u0E2L93IF
         SOktAaddbs5lM2u/7kTBFi40NBwC24Iu/uyDgdlKeRvN6C4CBqq2wUGXl6GY0AHnvMyH
         CCFqWgjal/cFrZUHMFBL0c3ouYRUHVvhMXchpwnvbPdkDUXO6xhlrX+pm3ZnO/5mLR9K
         I+aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755873682; x=1756478482;
        h=content-disposition:mime-version:mail-followup-to:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m2a0v5c2RPOmVHPi5zsER9bdyoW9/sdLoaF8GR0neeg=;
        b=ecfiwyzTWdVYMnPkHABvaDHdBhG0VaxOHM5hpLmoApvV+EW/B3HeJ5E+JdPY/0nLDI
         Qog8IUM9FEHdGKQLD0OqnY8zaZavCRlW4z068q3ftIZkwbnK82ZTYmarGDqb6F9XSRYr
         sMMvdqO2vO6XDYmPFmi190ChnBEb/yAV86K0hfk1nxsaDqfym55fTPh2M7aH2pjTCsw1
         SeQAmVvmtmtZIKUfInGfb++5W4bkHO1Dg5b/G/hRlTEAqivwvAYigidxecqTLcYfajOm
         Uqe1Pf45dEYCAPnoIJsKy50wXQ7pclprcTUSgBH0sqgB20b0YruiOG167jPt5FV/cZk9
         Q8FQ==
X-Gm-Message-State: AOJu0YwAaMmA4frLtqvFQT0b+isyKQZuC98vWlH225gRHAYms1JPM9sw
	HZWzv2WwUZu4lypBd+drLv9bMVh6VEerYQHq0vRYiNQ2XRDrB0TtyVk=
X-Gm-Gg: ASbGncslEoixzW3qX1qXytCVNs/TEfadhN7QzAOuZMyHk/kr2fOOkeSssVvVKvZC/a5
	pytyT4GNlC3xZYBTAyxq1m6z/3jL2Sucf2vAyNMpfr+A1XM9i/AnR7GE7Z+cbmTI7ZldVa6g4Yb
	zw6twAp8KWKpDPtEhuSwgIma0I6rnlEpvfkPqpZAnyYrzttT7AkGIEzEoXZCBMRQGd2u1hiBdak
	touXoryfDADRdC2e+2zFXJGphL1IjwC9IU5Rbsa0f8v+D4Hu6LdAS7Y0NnIOno7Fos8pXWh0EwG
	C3QBHHhyh9jjpSAuj0FwrepJ8bzIb537adJIO/q+OWefYRciteUrndEa77xNoCGJTzq9RF67l/6
	blAIiaSlo1ZntBhl7FUmoh3xb4tCjKHcnIVmwFyvtnNmyCErc6EegyjUv+A==
X-Google-Smtp-Source: AGHT+IFeJtTGj9VnBxoCmZ9HVU5zPX7E4u9a+qqxknNSnaMRNipL0qy+Y0d766tnO8d0BcnPkem+Gw==
X-Received: by 2002:a17:90b:4d89:b0:325:3937:ef93 with SMTP id 98e67ed59e1d1-3253937f1bfmr1656210a91.20.1755873681603;
        Fri, 22 Aug 2025 07:41:21 -0700 (PDT)
Received: from didi-ThinkCentre-M930t-N000 ([210.12.148.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-770401ead28sm112089b3a.77.2025.08.22.07.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Aug 2025 07:41:20 -0700 (PDT)
From: fuyuanli <fuyuanli0722@gmail.com>
X-Google-Original-From: fuyuanli <fuyuanli@didiglobal.com>
Date: Fri, 22 Aug 2025 22:41:15 +0800
To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ntb: Add mutex to make link_event_callback executed linearly.
Message-ID: <aKiBi4ZDlbgzed/z@didi-ThinkCentre-M930t-N000>
Mail-Followup-To: jdmason@kudzu.us, dave.jiang@intel.com, allenbh@gmail.com,
	ntb@lists.linux.dev, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since the CPU selected by schedule_work is uncertain, multiple link_event
callbacks may be executed at same time. For example, after peer's link
is up, it is down quickly before local link_work completed. If link_cleanup
is added to the workqueue of another CPU, then link_work and link_cleanup
may be executed at the same time. So add a mutex to prevent them from being
executed concurrently.

Signed-off-by: fuyuanli <fuyuanli@didiglobal.com>
---
 drivers/ntb/ntb_transport.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index 4f775c3e218f..902968e24c7a 100644
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
@@ -1024,7 +1028,9 @@ static void ntb_transport_link_cleanup_work(struct work_struct *work)
 	struct ntb_transport_ctx *nt =
 		container_of(work, struct ntb_transport_ctx, link_cleanup);
 
+	mutex_lock(&nt->link_event_lock);
 	ntb_transport_link_cleanup(nt);
+	mutex_unlock(&nt->link_event_lock);
 }
 
 static void ntb_transport_event_callback(void *data)
@@ -1047,6 +1053,8 @@ static void ntb_transport_link_work(struct work_struct *work)
 	u32 val;
 	int rc = 0, i, spad;
 
+	mutex_lock(&nt->link_event_lock);
+
 	/* send the local info, in the opposite order of the way we read it */
 
 	if (nt->use_msi) {
@@ -1125,6 +1133,7 @@ static void ntb_transport_link_work(struct work_struct *work)
 			schedule_delayed_work(&qp->link_work, 0);
 	}
 
+	mutex_unlock(&nt->link_event_lock);
 	return;
 
 out1:
@@ -1132,10 +1141,13 @@ static void ntb_transport_link_work(struct work_struct *work)
 		ntb_free_mw(nt, i);
 
 	/* if there's an actual failure, we should just bail */
-	if (rc < 0)
+	if (rc < 0) {
+		mutex_unlock(&nt->link_event_lock);
 		return;
+	}
 
 out:
+	mutex_unlock(&nt->link_event_lock);
 	if (ntb_link_is_up(ndev, NULL, NULL) == 1)
 		schedule_delayed_work(&nt->link_work,
 				      msecs_to_jiffies(NTB_LINK_DOWN_TIMEOUT));
-- 
2.34.1

