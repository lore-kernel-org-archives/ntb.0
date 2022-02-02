Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 429542F28
	for <ntb@lists.linux.dev>; Wed,  2 Feb 2022 21:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643836767; x=1675372767;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sotrY4FhW6ke8sdAst8k44NdYmWl1BF59hzmhmWMRXM=;
  b=cBsPBCx2d8TN7scG9E7hbumJKW0aZYxPEtaMLjJKZv3f8W3uHl1NHg7y
   LRrsIiPWA1uppLddURYcpiWKSz55QqmwZYyqmjeGkhfEKPOyGt1R75EEY
   8ibCwQTh227D7o/19qM3C2+xvN81gugeO1gjxUs+k/zW5ZnkjNev9lffv
   0itreAf9IzV0BJzLmYxa/xgpZOxmznwHtEWFGomfB3zVKByIuMFLAvTlF
   Qpi4TCcKOSw8dSr7VU3aacJa56yIXaMqukatODrruykmaHPrrjISBDCKX
   QILN9l7uSSLeum+EJz7C50T/YUv6eYnhm7VnVtc1djKqppSqVR8MfOIx2
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10246"; a="272511254"
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="272511254"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:19:26 -0800
X-IronPort-AV: E=Sophos;i="5.88,337,1635231600"; 
   d="scan'208";a="534997964"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 13:19:25 -0800
Subject: [PATCH] MAINTAINERS: update mailing list address for NTB subsystem
From: Dave Jiang <dave.jiang@intel.com>
To: jdmason@kudzu.us
Cc: ntb@lists.linux.dev, allenbh@gmail.com, linux-ntb@googlegroups.com
Date: Wed, 02 Feb 2022 14:19:25 -0700
Message-ID: 
 <164383676553.1275889.5218150049158331919.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.1
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

NTB mailing list is moving from linux-ntb@googlegroups.com to
ntb@lists.linux.dev in order to get better archive and lore support.
Update all entries in MAINTAINERS.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..cb118eccab20 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13679,7 +13679,7 @@ F:	scripts/nsdeps
 NTB AMD DRIVER
 M:	Sanjay R Mehta <sanju.mehta@amd.com>
 M:	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
-L:	linux-ntb@googlegroups.com
+L:	ntb@lists.linux.dev
 S:	Supported
 F:	drivers/ntb/hw/amd/
 
@@ -13687,7 +13687,7 @@ NTB DRIVER CORE
 M:	Jon Mason <jdmason@kudzu.us>
 M:	Dave Jiang <dave.jiang@intel.com>
 M:	Allen Hubbe <allenbh@gmail.com>
-L:	linux-ntb@googlegroups.com
+L:	ntb@lists.linux.dev
 S:	Supported
 W:	https://github.com/jonmason/ntb/wiki
 T:	git git://github.com/jonmason/ntb.git
@@ -13699,13 +13699,13 @@ F:	tools/testing/selftests/ntb/
 
 NTB IDT DRIVER
 M:	Serge Semin <fancer.lancer@gmail.com>
-L:	linux-ntb@googlegroups.com
+L:	ntb@lists.linux.dev
 S:	Supported
 F:	drivers/ntb/hw/idt/
 
 NTB INTEL DRIVER
 M:	Dave Jiang <dave.jiang@intel.com>
-L:	linux-ntb@googlegroups.com
+L:	ntb@lists.linux.dev
 S:	Supported
 W:	https://github.com/davejiang/linux/wiki
 T:	git https://github.com/davejiang/linux.git


