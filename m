Received: from merlin.infradead.org (merlin.infradead.org [178.238.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3579B174F0
	for <ntb@lists.linux.dev>; Fri, 30 Jun 2023 21:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Date:To:Subject:From:Message-Id:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=Qm/5TSAa2OgCGfMc2YPp1irzhW3yAouLNYXFS8nOtiM=; b=dsVhqdjZGH1o1HD7f8X0vIzIsy
	MTcoCPuWPb+yZfKZZn2aaADZfT6iXXUWA3MgjDQC/Iro//AejK9BNBmc/QkjJ2nxcymvevmyS8JSq
	gf2b8FGH5BtgmLIJ2Y9/maF0vM2iY/xs4qNrJC3CygJuYtgfdHGdjuCX6DBoXZrITN2SEIMwKOJvh
	aptmNtQiqCiCuIdvT/W0Zqga5VKDdQ9MMqfLam3mUJwa2Ty3HWed7PUU0ntOVDMDjHdeH1bUdo4Zd
	AWcE+SZ5kv+pjUlnk7fka91T4Al++T1FcZyOjXjzJ5/y9MTqewCLThq6fEiE3FAqe8qOkJLrlyVus
	UWMTc/hA==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qFM8c-00B9nz-Uc; Fri, 30 Jun 2023 21:58:47 +0000
Message-Id: <824a68d53214fa7a9e061176c05e9ce8ad5d850a.1688151221.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Fri, 30 Jun 2023 09:17:00 -0700
Subject: [PATCH v1 1/1] ntb_netdev: Fix module_init problem
To: ntb@lists.linux.dev,
    Jon Mason <jdmason@kudzu.us>,
    Dave Jiang <dave.jiang@intel.com>,
    Allen Hubbe <allenbh@gmail.com>
Date: Fri, 30 Jun 2023 21:58:46 +0000
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

With both the ntb_transport_init and the ntb_netdev_init_module routines in the
module_init init group, the ntb_netdev_init_module routine can be called before
the ntb_transport_init routine that it depends on is called.  To assure the
proper initialization order put ntb_netdev_init_module in the late_initcall
group.

Fixes runtime errors where the ntb_netdev_init_module call fails with ENODEV.

Signed-off-by: Geoff Levand <geoff@infradead.org> for Sony Interactive Entertainment
---
 drivers/net/ntb_netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ntb_netdev.c b/drivers/net/ntb_netdev.c
index 85dbe7f73e31..536bd6564f8b 100644
--- a/drivers/net/ntb_netdev.c
+++ b/drivers/net/ntb_netdev.c
@@ -493,7 +493,7 @@ static int __init ntb_netdev_init_module(void)
 
 	return 0;
 }
-module_init(ntb_netdev_init_module);
+late_initcall(ntb_netdev_init_module);
 
 static void __exit ntb_netdev_exit_module(void)
 {
-- 
2.34.1

