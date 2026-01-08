Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB3450097C
	for <ntb@lists.linux.dev>; Thu,  8 Jan 2026 21:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767906584; cv=none; b=rp0vzl3KdvzstcJfht+pF18/6bsSd5Lyl0axHNr9m2aEev+RGFw+2YICEs+GPBj/y4hccXO21EECZ5L66IepOaAjmjCMoXJ/Q7JnobGFPQ5291StSFDUNGzOReEHfO6Glhm+nlH1r8yL1hYnofEF6/f7VAqzpxXjG7XOA3erZL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767906584; c=relaxed/simple;
	bh=VnYOeCtBhDJp2xFwmsUTfbnvlDiwZ8445y/jeMW/U0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bF6JXCLQBv63KZQeU4OPobuLUE22pOcXCzUi5GiCLx8PkKBQKg4dRcXOA8vahtjmwR1+RXHEEk2QeSqejRFQgWK7PKZmLuTTj6TieB7SY8+p1TFffM6fqk/gQWDFZYqVllEnrYeuoO8wpTRhp1b+uNFAhT1iMmCT6ibSArmSJS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7440C116C6;
	Thu,  8 Jan 2026 21:09:43 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: ntb@lists.linux.dev,
	jdmason@kudzu.us
Cc: fuyuanli0722@gmail.com
Subject: [PATCH] ntb: transport: Fix uninitialized mutex
Date: Thu,  8 Jan 2026 14:09:33 -0700
Message-ID: <20260108210933.885257-1-dave.jiang@intel.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the mutex 'link_event_lock' was introduced, it was never
initialized and it triggers kernel warnings when used with locking
debug turned on. Add initialization for the mutex.

Fixes: 3db835dd8f9a ("ntb: Add mutex to make link_event_callback executed linearly.")
Cc: fuyuanli <fuyuanli0722@gmail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/ntb/ntb_transport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ntb/ntb_transport.c b/drivers/ntb/ntb_transport.c
index eb875e3db2e3..71d4bb25f7fd 100644
--- a/drivers/ntb/ntb_transport.c
+++ b/drivers/ntb/ntb_transport.c
@@ -1394,6 +1394,7 @@ static int ntb_transport_probe(struct ntb_client *self, struct ntb_dev *ndev)
 			goto err2;
 	}
 
+	mutex_init(&nt->link_event_lock);
 	INIT_DELAYED_WORK(&nt->link_work, ntb_transport_link_work);
 	INIT_WORK(&nt->link_cleanup, ntb_transport_link_cleanup_work);
 

base-commit: 7d0a66e4bb9081d75c82ec4957c50034cb0ea449
-- 
2.52.0

