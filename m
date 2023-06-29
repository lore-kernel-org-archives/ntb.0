Received: from merlin.infradead.org (merlin.infradead.org [178.238.156.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F2B10784
	for <ntb@lists.linux.dev>; Thu, 29 Jun 2023 23:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Date:To:Subject:From:References:
	In-Reply-To:Message-Id:Sender:Reply-To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bgKFBns66fV33JQmWtO/TMSTDqHBQ3UU6fJ1AAyDoKE=; b=IiHiQ0GU5Xxv5ThAAyozBbJoFX
	mDZ2wE8kEPuoKOUr/HkrMWCTCaj2JBwgH2A/R2yed4P29jEmesnIudkwoc5wKH0YHwaiYUvV9s/aX
	oRuDZ6v+O16pawRDKlX5hHPeolAVIKAdv2srZ+i/8xaxwTi84cu5fCZT/wcJ65uuPR0m0KiJrgxen
	GquoKbgG/Gv4ZAPv8i92nSur+OQN6jZAdyR3TIX1sEvAv0sJzaDBT32M3aMrSBWA2OoaGMBMrjXe5
	ZtlP8sL4jBUop1iccQDjM6cz7QPbvYcMFhpnbnUE73MbcfcnbkmWH+5LVUWs6IOiQeKCmJPbDeXij
	9XHfEZzg==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qF180-00AyHY-0W; Thu, 29 Jun 2023 23:32:44 +0000
Message-Id: <fd364f1f5928c1960447e057f02b425ae361f5ae.1688081423.git.geoff@infradead.org>
In-Reply-To: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
References: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Thu, 29 Jun 2023 08:04:00 -0700
Subject: [PATCH v2 1/1] ntb.rst: Fix copy and paste error
To: ntb@lists.linux.dev,
    Jon Mason <jdmason@kudzu.us>,
    Dave Jiang <dave.jiang@intel.com>,
    Allen Hubbe <allenbh@gmail.com>
Date: Thu, 29 Jun 2023 23:32:44 +0000
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

It seems the text for the NTB MSI Test Client section was copied from the
NTB Tool Test Client, but was not updated for the new section.  Corrects
the NTB MSI Test Client section text.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Geoff Levand <geoff@infradead.org> for Sony Interactive Entertainment
---
 Documentation/driver-api/ntb.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/driver-api/ntb.rst b/Documentation/driver-api/ntb.rst
index 11577c2105c5..e991d92b8b1d 100644
--- a/Documentation/driver-api/ntb.rst
+++ b/Documentation/driver-api/ntb.rst
@@ -207,9 +207,9 @@ The MSI test client serves to test and debug the MSI library which
 allows for passing MSI interrupts across NTB memory windows. The
 test client is interacted with through the debugfs filesystem:
 
-* *debugfs*/ntb\_tool/*hw*/
+* *debugfs*/ntb\_msi\_test/*hw*/
 	A directory in debugfs will be created for each
-	NTB device probed by the tool.  This directory is shortened to *hw*
+	NTB device probed by the msi test.  This directory is shortened to *hw*
 	below.
 * *hw*/port
 	This file describes the local port number
-- 
2.34.1

