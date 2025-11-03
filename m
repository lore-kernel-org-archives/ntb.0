Received: from mail.tkos.co.il (golan.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AFB2153BED
	for <ntb@lists.linux.dev>; Mon,  3 Nov 2025 07:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762154927; cv=none; b=qbt344eyKKBbMmYnjB7pytSoZ9tPkagwuizGqh0DpNKeX8KF9grNyZL00kzEIGWWyT0wpPJQJ7BWbwwnLNAk4LSBzhfYcw2W6+Gz7ABzMocsWcqsDs+aQlaTxlmNyEUKk1H8uE7mT0AlDhkor5Wi+rfhSIEfn/v6FRAtPbm/Fco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762154927; c=relaxed/simple;
	bh=iiSmqBqZEjWrhMASO/DIZ7jn0XsxbybKLsoTvoB2su0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ifEKlQq/a7YhSaFE4Wan7pYabPf4m1gqAk/DF1N5fqR23XnFIK8FGQsSen8HQWwNI76YxhPeHiULNM8Va7EJciYMkRSCJ5ik4QpGlTuMnkVTs0AjRcJo/cfwjPU6PKvRy5RZQxfxe5WhdSG/HeglC3bVBN63rbu3tD3OFT2sc30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=koK5E6k3; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="koK5E6k3"
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.tkos.co.il (Postfix) with ESMTPS id D59FF440F3C;
	Mon,  3 Nov 2025 09:27:04 +0200 (IST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1762154825;
	bh=iiSmqBqZEjWrhMASO/DIZ7jn0XsxbybKLsoTvoB2su0=;
	h=From:To:Cc:Subject:Date:From;
	b=koK5E6k3tyxvv8b5rPLILhx+Zz1+ETxN1/ChrvFQaIKwXVrJ11yE+l/TXr35HFnAH
	 UrbRvoPIiHyAa1N1xg8lCNTYv6CZXn3OQpDm0RxXsqs9j4UW8AC4GWdAo2zzW5j6GG
	 SxhPgP9tWv/yvR3XkUXUQ77WcCQp2MDxi2L3iPKVR1GsMTiWMYcymjxcH7kntw/W1G
	 jS/uQ+OYEH/YcB4H8w1hn84jYa8XtqPIk22Lri0K1z1vMl0gv5a61NPHZYSntoeyjY
	 zMIAHCAeJeqOxz7YTh29kyJQk4lPOhN4AfOz1U8jGXk6IT4hTSiO3CBLfYzs+kMG6N
	 3sNgfeHGOLsYw==
From: Baruch Siach <baruch@tkos.co.il>
To: Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org,
	ntb@lists.linux.dev,
	Frank Li <Frank.Li@nxp.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Baruch Siach <baruch@tkos.co.il>
Subject: [PATCH 1/2] Documentation: PCI: endpoint: fix vNTB bind command
Date: Mon,  3 Nov 2025 09:28:30 +0200
Message-ID: <b51c2a69ffdbfa2c359f5cf33f3ad2acc3db87e4.1762154911.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

EP function directory is named pci_epf_vntb as mentioned throughout this
document.

Fixes: 4ac8c8e52cd9 ("Documentation: PCI: Add specification for the PCI vNTB function device")
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 Documentation/PCI/endpoint/pci-vntb-howto.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/PCI/endpoint/pci-vntb-howto.rst b/Documentation/PCI/endpoint/pci-vntb-howto.rst
index 9a7a2f0a6849..72b7a71b2e64 100644
--- a/Documentation/PCI/endpoint/pci-vntb-howto.rst
+++ b/Documentation/PCI/endpoint/pci-vntb-howto.rst
@@ -117,7 +117,7 @@ Binding pci-epf-ntb Device to EP Controller
 NTB function device should be attached to PCI endpoint controllers
 connected to the host.
 
-	# ln -s controllers/5f010000.pcie_ep functions/pci-epf-ntb/func1/primary
+	# ln -s controllers/5f010000.pcie_ep functions/pci_epf_vntb/func1/primary
 
 Once the above step is completed, the PCI endpoint controllers are ready to
 establish a link with the host.
-- 
2.51.0

