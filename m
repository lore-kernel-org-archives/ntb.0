Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8747639060B
	for <ntb@lists.linux.dev>; Thu,  2 Jul 2026 07:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782976011; cv=none; b=TMlrqDd0I9SRAnCY25RqU9KeEK4orl6F11aTO61aT6DDaiXm/GX0JTP1XBibt+AVSHmfoD7Ggfq7F4w22DSETueZoa7Ayfin7FRE46n47RN45tlLZPNP7lJwbSpvBVQ+Hc9Nt0cQgSSPRXO+FnVEPdfH0DQJ06w2xUhYAlLdDwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782976011; c=relaxed/simple;
	bh=otYkIS6X79fDslkgyR7H3hBYPvqPq4mREpeQi0rEZbs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ONAdQB1JNkT5vRERe2CIBbaHOdNtRQYx4AL88+xAKAHakYQf55dhGazBlQgTTQJrJiRgQaWLtX2eE+lD6p5kEUG2/hcNYaSHQHuQNEKtnO78YwQ3OnVj7PMOx3hhVunJXdfE5S2MBph41ly4vRQlmlOXH0nZRJ41OfKf4NDjiOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oJUOXAMN; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oJUOXAMN"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-37fdee9276fso1529110a91.3
        for <ntb@lists.linux.dev>; Thu, 02 Jul 2026 00:06:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782976007; x=1783580807; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dXfBWtr/AcYLoYlgWEsf/V02rNW0imAizzGEHx4fml8=;
        b=oJUOXAMNHfG1HPkK1OEA9QkJLTgzLQCPhDMw6tLAEZMY9NBZuRyz260uom2gDU8mFr
         WF5K0UG8JwrO4KfnMVfgxFGoU7VhggCcej9SVdgZbPIKT3qc8xBejNzBAqAcZhrybEd3
         ZBvKcRDB5mlD918DdHh36cmWrgGVQYzdTA5s/jnHf8Vc9DfYWqzUagmcQ191NuzxCu9s
         SQZ5aDXJxvmfeHneARIlsKa+X9cOztjOWUnzIaaYEN3rmbU8ews8gBFFzG0mGDaG/sIX
         NKlMvXgmtQKAI33sGK1prCiZedag7Nf5ULevcY8xtHynJEWKJP6GAUEi4+Jktfw0vr2u
         HNRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782976007; x=1783580807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dXfBWtr/AcYLoYlgWEsf/V02rNW0imAizzGEHx4fml8=;
        b=j10gf5WPhZ6kjyO8HScla4H/a+fVq0WhSJd20mHr7/qTWZFPu78Tz53lI7DW7FU1QV
         sXMo8F809weLin1nFQqIA4hzszATqnz4uHdyFQRTrXGX+A8W2uB6KVY7/zf9+os0vbAC
         k/GfxYOgS5HFPI0kT8qS+7ZIHMT7rOJvxfscP/cEf979q9C/W9TOnrHDTlbVzcr/zqOF
         TjsMVWWHvlQMOPyu90Bm6RkZSBPs/rvO8R8Xg+VjYE4uU7nG1Ho7L4Ug3kKbkxUeRZEs
         w4063OoBtbP8sFQjjAPaamanxz4uvCUgko2fcnCjRoAuaqiV8U0c6DQcdKa76PtCMaNR
         jSEA==
X-Forwarded-Encrypted: i=1; AHgh+Rp9Yj0aMl/zqDHgBt6sDB/FcjDC4v6T7dX/6swf8RkC9HL3D3h9uJfPCfsGOFA2hos5hoY=@lists.linux.dev
X-Gm-Message-State: AOJu0YxJJ3wzQI4jG7avMpBOrgxwTarVzAO3YwDvZ8O2YxUePZQNtuMn
	XeTJ/oPldThOhqO5zte/hAxqwUdIz+i08kjd1dn6XmlFSHRqUlfTarcV
X-Gm-Gg: AfdE7clFGVa+mTdCypWyM62+l8m/6zTlVKhqipREU6mm/Pai4UU1hOjZLCB7y0fMgoA
	XxD8dq89WVxRM+zfejTigBty/BZbcn6WHPdScScInzp/cUXC37t4vwvMkcixexrDPiU8jUGs7D8
	SLS3FT0nlq6Le00k8OwTdwPg45XxEjgAgPQUA4Ta0CduSPolaFOK/6cX8AAoQJ/qte8zjveaAwl
	sms6mB+jJBq/9HvHgbKXVYAjfL2eybP8HwomMWa5LrAshXStjdp1LSMMYTu691nNiVaSft4pD7y
	NzOdv5DKYFTuBPNGaEO3H7zdzIaSqhu3KHk+BUxkL2etGJ7yojc1DmYJbyPz1zIs7+tNmoi+b8T
	woEAtMqsymFOZd0J6tDaMwWA79KMe+FJqJwzuGTSJgHJmcGHnbn3BSeJoUslQlDRBT8uLBMemfZ
	zjUcMIDicBtuR1Rvhu0xtOLiZIb77LaXY+4d9SY6WZA6qt
X-Received: by 2002:a17:90b:57e8:b0:37f:caeb:69df with SMTP id 98e67ed59e1d1-380ba94f8a0mr4758996a91.22.1782976007213;
        Thu, 02 Jul 2026 00:06:47 -0700 (PDT)
Received: from archlap.tail6abcb.ts.net ([2409:40c2:7406:d8e5:89bc:557c:b1df:117a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30f0b7b8e48sm6226162eec.5.2026.07.02.00.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:06:46 -0700 (PDT)
From: Shashwat Agrawal <shashwatagrawal473@gmail.com>
To: Jon Mason <jdmason@kudzu.us>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	ntb@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Shashwat Agrawal <shashwatagrawal473@gmail.com>
Subject: [PATCH] ntb: epf: fix PCI resource cleanup on init error path
Date: Thu,  2 Jul 2026 12:36:28 +0530
Message-ID: <20260702070628.19840-1-shashwatagrawal473@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After pci_request_regions() succeeds, failures from setting the DMA
mask or mapping BARs jumped to a path that only called
pci_disable_device(). PCI regions were left claimed, and any BARs
already mapped with pci_iomap() were not unmapped.

Release regions on those failures and unwind iomaps in reverse order.
When peer scratchpads share the config BAR, do not pci_iounmap() the
offset pointer, consistent with ntb_epf_deinit_pci().

Signed-off-by: Shashwat Agrawal <shashwatagrawal473@gmail.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index c47607d4f8a7..b42fb5f9fa75 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -683,7 +683,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(32));
 		if (ret) {
 			dev_err(dev, "Cannot set DMA mask\n");
-			goto err_pci_regions;
+			goto err_dma_mask;
 		}
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
@@ -691,7 +691,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno_map[BAR_CONFIG], 0);
 	if (!ndev->ctrl_reg) {
 		ret = -EIO;
-		goto err_pci_regions;
+		goto err_dma_mask;
 	}
 
 	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG]) {
@@ -699,7 +699,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 						ndev->barno_map[BAR_PEER_SPAD], 0);
 		if (!ndev->peer_spad_reg) {
 			ret = -EIO;
-			goto err_pci_regions;
+			goto err_ctrl_map;
 		}
 	} else {
 		spad_sz = 4 * readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
@@ -710,14 +710,20 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 	ndev->db_reg = pci_iomap(pdev, ndev->barno_map[BAR_DB], 0);
 	if (!ndev->db_reg) {
 		ret = -EIO;
-		goto err_pci_regions;
+		goto err_peer_map;
 	}
 
 	return 0;
 
+err_peer_map:
+	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG])
+		pci_iounmap(pdev, ndev->peer_spad_reg);
+err_ctrl_map:
+	pci_iounmap(pdev, ndev->ctrl_reg);
+err_dma_mask:
+	pci_release_regions(pdev);
 err_pci_regions:
 	pci_disable_device(pdev);
-
 err_pci_enable:
 	pci_set_drvdata(pdev, NULL);
 
-- 
2.54.0

