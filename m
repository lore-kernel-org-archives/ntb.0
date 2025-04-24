Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021A020C004
	for <ntb@lists.linux.dev>; Thu, 24 Apr 2025 08:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483667; cv=none; b=QGrDqNtmLVRACJrmbtoLrOGn6itv95P4bt53DbbjckyT8lUW2voa+Aw7U6+RZ6UUPdkvFYvnQiGHRv4cHUHlmJ88butVunFSMylJrqeKFtlf/aJWLH3//ZmDCmurkSNRJLo9ZhkYWPs+3fjHOekxi0i6AsrMrfofOuOvpC3iuuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483667; c=relaxed/simple;
	bh=fyPcyt5tsx33zLc81Kw1P3Mee50TZQ013vRkVqNuYWA=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=FokaUD6+kRmdA6hE7A4MQLu0n9pIKs4xRuminACuDvOwyCGaY9JebJ+fF4Y5oIkmkNOYu9oGRf3iU8+UkKSPo3Y7SKQb/eXvchxnuvJXCGuIAgjlbH0844Ssc+yw6kjx4hEksKDcFWZNRveQC0k+e5ew44UlpVld1TMF/i3r5Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p8Z4oYcW; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p8Z4oYcW"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-39c266c2dd5so762343f8f.3
        for <ntb@lists.linux.dev>; Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483663; x=1746088463; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=C8tGWCdB1F+2LTmhAkX22ynJIxbqoFIVMbky72nwvho=;
        b=p8Z4oYcWSXvmiQN/qR/oeEWUpvbV4ABP+teuWIIedyQJnwX62z6sTc1QBJ3PWT5MBa
         LzFiIBGep0LPaLVM1kU48I8siuiOcuGgl0Fe79tA3YYI4yzvev90+JtGRTu2dsDEPCqV
         Vja0o7UV8W/4Q5kcvQFNsV96jUA1uZCXTjaWuLt4XMdS/eREcMCv1av78lYlg5ysQl1S
         wWCJ54HbTbl2t3pgd2auVOPiGvm2cFsJl2m3X3j+CR45fb0BX4VX11owih6tnHf9QRPE
         Xwy5+S1iPMVIOWfK3kScC5PH6qgKVxQVm06YI/s8ybLDEahS0+jZtQeXyOqAMUl2Zbnq
         +xzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483663; x=1746088463;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C8tGWCdB1F+2LTmhAkX22ynJIxbqoFIVMbky72nwvho=;
        b=cD4v9DRIAsSMlVxjdCxAKVuyCBsZKgs5svEqUT1sZrSd3YmF4Ei2z2P9SaLCt18JWV
         msoIVlvYil/g+1HUDxrvzeQ7p1Z2nbWfMqGFlu40BD8c8lUbCnqblLz4CyR8+ealodFm
         yTqPOdNzjRp8FH3H2ImM78i7MEjJ3NlK5iAcoutEa8nsfoupWISOvip+qOPK1gs+zJbW
         dE1z+m2RZs7g0z7dTUTMCmOZfr4CMrozm3BWvkQmRqTyfyVnZX241bN9ZkD4Rq8NxWiZ
         k24+9Hwcp1Vgb8AJMT3eRdrsj3Mw48TB9dsaGV/t70TGqMm0In441prWPGpfpe5xP+SL
         Y5tw==
X-Forwarded-Encrypted: i=1; AJvYcCWrq/ZDGx3YQiLBdMccBsKEotlXlhw77TwvKZnPgVFA1jj5doIcP8sHQK9vqRWT7bGj7zg=@lists.linux.dev
X-Gm-Message-State: AOJu0YzArt06of4b3ql2c/SL08q7bf65Neh4MKKUMi3thpZMNgz2l8Qo
	Pa+N8cRxscVEoWjlpIwtJgkfICMVZnaqboK+g2ufP5Qou+8u4WTI7uIjpcqMcBE=
X-Gm-Gg: ASbGncv7JGwVeBEX73YnoTxCpT7D7Jrt5j8s0HdScqhsRfhZ8N3r2/7LH2Go2osUNFp
	xzD00HcKm+e/VHxvAdCyODWYM2FMOnLnHfaHn9PjzA8kXczBv7yQ3sNb++vbRVW40kdwA7OqfvB
	XbKM/UiERcW/Xcd2/baAsBffnYXyfVLjJbOfzKK2pWEdpM+z771k1gzmYlrDFEyVddsoqOi3ldz
	BQXRLbnGllilaf5OURyuFVpIH1yYlUxBFGW/Cvo4nFuxvhiq7YImDkhiw7PYd91QzZQhL2E8x9K
	G8GFTckiYS6u6Bvz+XfqZE8Bal3H6au1eoraya0qsFGrMRnZskefyw==
X-Google-Smtp-Source: AGHT+IFVQQq6l1DulQrKW6deJu7Kbn7RZmVVR447idMPpE+uOzGwM7yCKCZrv8fEuvw9xqkYlMZ8QA==
X-Received: by 2002:a5d:5f87:0:b0:391:3f4f:a17f with SMTP id ffacd0b85a97d-3a06cfa3157mr1117016f8f.42.1745483663218;
        Thu, 24 Apr 2025 01:34:23 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:22 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v5 0/2] PCI: endpoint: space allocation fixups
Date: Thu, 24 Apr 2025 10:34:03 +0200
Message-Id: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAHv3CWgC/4XNTQrCMBCG4atI1kbSJNNOXXkPcZGkUx3QtiRS/
 KF3N7pRxOLy/WCeuYtEkSmJ9eIuIo2cuO9ywHIhwsF1e5Lc5BZaaVBGoxwCSxpk4htJd+R9d6L
 uLOsGwWv0qECJfDtEavnycre73AdO5z5eX2/G4rn+E8dCKkkEvkJfgKvdxrvrkX2kVehP4omO+
 g1ZZecgnaFgnGq8DW2A6gdkPqFqDjIZwhKwQioxBPwB2Q9I6znIZqj0DaC1piWqv6Bpmh57SL2
 9mAEAAA==
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <kch@nvidia.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2285; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=fyPcyt5tsx33zLc81Kw1P3Mee50TZQ013vRkVqNuYWA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeLltdBGrihKLgdra13UYvpXsgJ+UUry4H7F
 Hc94NUoWA+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3iwAKCRDm/A8cN/La
 hfXLD/91NjpsftPFNZcFoUD/luoLQAcGz3A2OFoThdNs3G2BGT3FZhX/f2aXzeLQjeaxdBngIdi
 2GmeLpbiNqTW8mQtRAIxJdIZNzDS7igdAXLbIz+bJON8TIZ4FjZmBkrzfPzWONU/MNnRy1uMgZD
 Vs0X0Q7yXaXq/u6PY3+b3Xh3JW9FyPr2SNevGbok3WHdty4dY0HAneF6qfaXp+91puUgQgwHa9Z
 f//y8K5tghzW6O4EEEecu+Baf1odyBbPBOK9YlAsshznXqRwm+I1TTGoO5Fyfg9solmmtONAItW
 1D3jiJlEQFdv06qPSWKFR23skq89u9HM6Df4oCc39QNVOA67l47Lzu7nDcaUfRjafa/VjGa4RkP
 mmm5bSFBwRgMKdRyt7FZa4PuQ0jc7EOXEJrrAXPLCbUth21t2A9QRGPkcb1uCwPeI36zikqFEMX
 zL10wNPQPlE9wxhNMzQw8QOBUVejrkSH2OkH3yVIkuB9aDtdOZ3/Vfl4c/4X8wSrE6h7MBhD9Xt
 4RMptgpbYbZJ2s1r85CBzIjDWwKJHwAtkByOEN91LJWTmom+Jy/cYrDX0R8N1H8i0P7twDDxy4S
 4gjxf2M8EvX/SDppQ8oC99pU6gv8vgzELc+rmoxja7Ht3OKxjT80Cf0eKdCP1Q6fplqbIBqgzs8
 bovfcXTnwJwwypA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

This patchset fixes problems while trying to allocate space for PCI
endpoint function.

The problems, and related fixups, have been found while trying to link two
renesas rcar-gen4 r8a779f0-spider devices with the vNTB endpoint
function. This platform has 2 configurable BAR0 and BAR2, with an alignment
of 1MB, and fairly small fixed BAR4 of 256B.

This was tested with
 * BAR0 (1MB):  CTRL+SPAD
 * BAR2 (1MB):  MW0
 * BAR4 (256B): Doorbell

This setup is currently not supported by the vNTB EP driver and requires a
small hack. I'm working on that too.

Changes in v5:
- Collect Reviewed-by trailer
- Fix nit full stop comment
- Link to v4: https://lore.kernel.org/r/20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com

Changes in v4:
- Drop patch 1 of v3 and add new .aligned_size in struct pci_epf_bar
  instead re-computing the aligned size on the path freeing the memory
- Link to v3: https://lore.kernel.org/r/20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com

Changes in v3:
- Rebased on v6.15-rc1
- Fix build issue with newly introduced nvme endpoint function
- Link to v2: https://lore.kernel.org/r/20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com

Changes in v2:
- Allocate space that match the iATU alignment requirement, as previously
  done.
- Chose not to add a new member in struct pci_epf_bar, as initially
  discussed. After reworking the code, that did not seem necessary.
- Make sure SPAD registers are 4 bytes aligned in the vNTB endpoint function
- Link to v1: https://lore.kernel.org/r/20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (2):
      PCI: endpoint: improve fixed_size bar handling when allocating space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 drivers/pci/endpoint/pci-epf-core.c           | 21 ++++++++++++++-------
 include/linux/pci-epf.h                       |  3 +++
 3 files changed, 20 insertions(+), 30 deletions(-)
---
base-commit: 92713f0ea620bbe923eb4e7bda408e5c79597cd4
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome

