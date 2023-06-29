Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4587B846B
	for <ntb@lists.linux.dev>; Thu, 29 Jun 2023 20:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Date:To:Subject:From:Message-Id:Sender
	:Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=G4ZHAI+QmNu+IZXPpNjJ+F+CjhMChjo+hfrgaqwIbGg=; b=iCTeHLMFSIVetq0KfT7Vzzhl5l
	F4lPTCjaeBfX5WE9dUblxpgSmcenm4jGFGPdoRKyA+/eWpyp1aOesxSZiMzRJ7fg/w2C0TXBh/V5k
	efo+Jkdov8I4aSxjJ7Q5RNBjTGep969nEq171d1Shw6Dbxd22iPlfXle2dfyKbrG8Kh8EgtAC7flA
	AH9KbqB+WlN6M+ntiG2J3X1t71a7cXO8nL+I8LHj6yFrnnxVr4MthlP+59i4X7lyj8p1NuI23SN5i
	KlA7cqhWRjB8O9tld/wcuHAs5NCcilYdQK/BphqwpWEZItApcOUSEu+2p7cRyO+M7s2OReQFgb0Q+
	mb4qzNZg==;
Received: from merlin.infradead.org ([2001:8b0:10b:1234::107])
	by desiato.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEyfu-006qPb-0M
	for ntb@lists.linux.dev;
	Thu, 29 Jun 2023 20:55:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=merlin.20170209; h=Date:To:Subject:From:Message-Id:Sender:
	Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=G4ZHAI+QmNu+IZXPpNjJ+F+CjhMChjo+hfrgaqwIbGg=; b=MolaWHs3QqIkQCtfpHSKPnSCtW
	Nu0lDb+ei1xUZPH46pjEDrU7+5UI2HpXljc+0SRSdio4wBbORLUtPfJ+nf8knqO/M6nBsXjxXXRys
	VTHGSEMeWTSfF8KUP7RVzaojWPWq831Z7Cg442Su9FCtU/85SfDFASA/l/nwX0aBO1la4cNi0sdk1
	W8bVulJUEOUhj3rdcim0hvaDGGP/ZR6zO3ly3Y34ThS5rp0PVWwghd0D0/NXUUKyUGcc/kSQLewBO
	n3DOI1lrX3tAy7AcyTxDSWSV90PPTfTi/qmX99QOwb8wTxeGBkhxTfV6ZWI4N5N1Lr8+rOyy1Ax1a
	K0/TbFdg==;
Received: from geoff by merlin.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qEycL-00AwLQ-1Q; Thu, 29 Jun 2023 20:54:58 +0000
Message-Id: <3102d6f5287c58ca417c616b5631a343b62dfe74.1688071716.git.geoff@infradead.org>
From: Geoff Levand <geoff@infradead.org>
Patch-Date: Thu, 29 Jun 2023 08:04:00 -0700
Subject: [PATCH v1 1/1] ntb.rst: Fix copy and paste error
To: ntb@lists.linux.dev,
    Jon Mason <jdmason@kudzu.us>,
    Dave Jiang <dave.jiang@intel.com>,
    Allen Hubbe <allenbh@gmail.com>
Date: Thu, 29 Jun 2023 20:51:53 +0000
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>

It seems the text for the NTB MSI Test Client section was copied from the
NTB Tool Test Client, but was not updated for the new section.  Corrects
the NTB MSI Test Client section text.

Fixes: bec5545edef6 ("Merge tag 'ntb-5.3' of git://github.com/jonmason/ntb")
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

