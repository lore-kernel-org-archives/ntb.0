Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 539E84438B
	for <ntb@lists.linux.dev>; Wed,  9 Jul 2025 08:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752049254; cv=none; b=m2TrVfXHvtbkhp/t4nTLKL3BQcGcabVPdh+owW0lyk97c4zI5D4hmuaYTjxU57G2yi+3qKRplFCVZ+SC3rWJTnzKUaSFEmv3nyoJnFSdWQsRorzgPK1z9KVCmg2749hLH8wk3wGDSFnopqgpb21RWlNF0TrV85UcZTm+cymxkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752049254; c=relaxed/simple;
	bh=EHXyuAgrfEFtwOLv535hfHlLjgXTXtcDgMefdBRIoPk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=bbGCK3Nx7aJp+Q3pWyBhkjEHSOEiTPajepMbMWXc0lZ/w8TWTiM252ZutlHnxB5glEcMVQ2j0qNvGCRZHRKIaQWoLN0WMpnZLsOKn7g+Geg1JgZj7nctIvOaGDjXgO9VhB9vSzKzraQdsxmiV+e0+E6VZcW+RlUHOZVDezdfhAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ZaSE2jPW; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ZaSE2jPW"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-451d41e1ad1so37929005e9.1
        for <ntb@lists.linux.dev>; Wed, 09 Jul 2025 01:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1752049251; x=1752654051; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7B3VRXc09cS8APvBj52bRVQerXwb1XuAJdQMIRIyeh0=;
        b=ZaSE2jPWaJjz2b1hnYsYTj925but5uMkNubzlOqOj7iyZFal4fnKl46nrf/ihvm7yQ
         Rhk/qLIi4WHd+AuwQ3Xe9jb3ZTJg38xiuYv7ltXV+YemlGJYaj9LU3H1L+MpG3MzqvtU
         ZpMPdPjg5MmRo18NfZ+6qoM1f3OVhuo4a4OfkTCe4BiQdYmg4b/fxN8r2EV/fB8bVMlE
         5J907q+KmlDevaubNz49L7zY9yOMrEbBsoc+JxJZ6ZXWQ9XqHzuyDT0TBgXhfSJPKCUG
         hR6ODEaoB/o0yeUNd15d5r4qAZkxyHvsdVIovSkJh5PCQXLmzWfgmPK8z7xf7gih+ZIY
         XfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752049251; x=1752654051;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7B3VRXc09cS8APvBj52bRVQerXwb1XuAJdQMIRIyeh0=;
        b=mdzmRn91mClsoFt/HObWYxiJ/eAaVLVHhaqSlfD+7+8AjHW29gngzIeh6UqBJFtd0r
         oQGjIEqS432aal2tf87uibrl1PC1aBqto+UlCeNV0FF/1ohrZQauPyvj/KZ/KBZzhH3J
         egUwsAJ7O+vhCSrigwfc1whbhPUJmH8DnIr04uDFLCofLrE1t7/hg3cbW6NPK1pgiQG9
         WcSE1kueCJ5R8pOxqE/j2HMb7k12yB0IX/ytpk1xoQXoBowvFHh/rEHx4jkMtP2qdllA
         zGBaJ6F7Vso/YyZ2ErnJlWK9D/UuxWHU4Qkfpr4loB+6CUwbO6wjuguyDnRMh++HJt6Z
         fsvA==
X-Gm-Message-State: AOJu0YwzZu2m29urQelIWVIadkXZbscvVTc8O4HI0oUVJ+kiN3KFVgQF
	P5BKtWbdYPoU5tp2XDuqhNvYhyj2aIDPtDGXj+55yX1IBqrbMmFfNElz05eOrG+rgGE=
X-Gm-Gg: ASbGncsUgLcd3t8H66bMvpuh/P5o3HAyl1UyfIrvoePwBd+4p6rUAMpKETLhtGTQxNc
	bELuCXj2iqqq3Ca7/m1+8fn6qhRcWPZwN9OKbA5njL3JxhpykuPQf23mHE5Q2CNV+Zj6TiuL+La
	ta6ADYB3zXMxPE7/GE3zLaX/toJcOj1mNPkxrn/q0/qsRQ7czFW8CR8Ad+GQ1ZbyRnU2rVSX3w8
	2d5JEEjlZE311PnviEJjm9OsEdvUx4VS5l+wE3JL1SkSwf+klVSjUNdi+iLtM4Ql9SJOWcMo7qB
	EiV5AtYHadAMviUipR3MOScq+Z1y50G1jcydbakp6MeHJriGlRyhjtYw55SG/ypdPBmxyOB1avG
	j
X-Google-Smtp-Source: AGHT+IEYNIjq5nVtF5eCRGm3USKuYX5yMn/POeyEHko97pwQhmn9XFmaUb7lW9CY6jfvANHnKvBFuA==
X-Received: by 2002:a05:600c:8207:b0:445:1984:2479 with SMTP id 5b1f17b1804b1-454d52db33bmr12806645e9.5.1752049250612;
        Wed, 09 Jul 2025 01:20:50 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:6015:b265:edf6:227e])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454d50527acsm14451965e9.14.2025.07.09.01.20.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jul 2025 01:20:50 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 09 Jul 2025 10:20:39 +0200
Subject: [PATCH v2] PCI: endpoint: pci-epf-vntb: fix MW2 configfs ID
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250709-vntb-mw-fixup-v2-1-27c14df6ed5b@baylibre.com>
X-B4-Tracking: v=1; b=H4sIAFYmbmgC/3WMyw6CMBBFf4XM2jHtIKKu/A/DoqWjTCKPtFglp
 P9uZe/y3JtzVgjshQNcihU8RwkyDhloV0DbmeHBKC4zkKJK1eqEcZgt9m+8y+c1oW1LZUqmszp
 qyM7kOR9b79Zk7iTMo1+2fNS/9V8patRI5EylNR1qdldrlqdYz/t27KFJKX0BM1iVQq0AAAA=
X-Change-ID: 20250708-vntb-mw-fixup-bc30a3e29061
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1443; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=EHXyuAgrfEFtwOLv535hfHlLjgXTXtcDgMefdBRIoPk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBobiZgAHnLRl3ismay6Ijxwcw0NreYakccQ7CuM
 G8WL55cG12JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaG4mYAAKCRDm/A8cN/La
 hdQcD/4+7GOPlvQ76ACj1f381w9IvlRgSLLe23LmFHIojk/yzji+2mVS4UgXKKuCVJcI912W2t9
 j1rvTxqb8Ss4o/cc3yv2VN5GjuyMdGvKVnrrueGZc2Gt5/8SKmbpW+JAx9dSRDxUGCQwa9Q3Lju
 QmyRKT4LulS9ciV3sTr2yw4GAcsCQH+qxWVHWASl82uVPtP3yporWKaBDbMljrgXeum+P8rLo8N
 zYfW4P9TR/Or2RzxBhwJlmouxQP2X+v84BvCC7V/01W24J0OigOu1eCgoAeaSiLnmjDBsVOkdjK
 YXM5R5vB4bv33RDY3cbPRKtpPcEePz8Pr6Pk+cfO7Mvr7TUJ0sLJoK2dRlF4NcXH4S3xwLEqdg6
 70U3m7STxKnWVEeinuCP7vUNfKovh2txQcC5OQmdnwOi3kE3vwkfakpEesnSqA91viLUASY2iwv
 UaQdOisDcNO3WaCwD22f/mM/NVGKSZIv4B5ja25cqmhIZHDdNcR5IYDAvoHpmkVBL5NW5lLHHFv
 HC9N95EbjXtdri83ib4Iz3pRo18GUYeLYMFnrmxRaTZJEJ+JvO0n9RVTxxI7v+g7OTaOLlrlb1O
 qmBHWgQEqgjrl9uhrxGiIB4ntwvG/GB0w+T6jVt8OlLAvmyFEEtdDNZeiQNmtz9Hperk6JkTIqf
 b63n2sQ/LYoKrOQ==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The ID associated with MW2 configfs entry is wrong.

Trying to use MW2 will overwrite the existing BAR setup associated with
MW1.

Just put the correct ID for MW2 to fix the situation

Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Changes in v2:
- Minor edit to the change description
- Link to v1: https://lore.kernel.org/r/20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 41b297b16574558e7ab99fb047204ac29f6f3391..ac83a6dc6116be190f955adc46a30d065d3724fd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -993,8 +993,8 @@ EPF_NTB_BAR_R(db_bar, BAR_DB)
 EPF_NTB_BAR_W(db_bar, BAR_DB)
 EPF_NTB_BAR_R(mw1_bar, BAR_MW1)
 EPF_NTB_BAR_W(mw1_bar, BAR_MW1)
-EPF_NTB_BAR_R(mw2_bar, BAR_MW1)
-EPF_NTB_BAR_W(mw2_bar, BAR_MW1)
+EPF_NTB_BAR_R(mw2_bar, BAR_MW2)
+EPF_NTB_BAR_W(mw2_bar, BAR_MW2)
 EPF_NTB_BAR_R(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_W(mw3_bar, BAR_MW3)
 EPF_NTB_BAR_R(mw4_bar, BAR_MW4)

---
base-commit: 38be2ac97d2df0c248b57e19b9a35b30d1388852
change-id: 20250708-vntb-mw-fixup-bc30a3e29061

Best regards,
-- 
Jerome

