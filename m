Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928A8149E00
	for <ntb@lists.linux.dev>; Fri,  4 Apr 2025 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788797; cv=none; b=n11kJTZS8GQ70C2yODm2k2NJubyCBBl7U64HIJYwerrhWmEgLirSRG9dVTgWMRfanEDx1M74+p4i7vOUTsoHzKyx3j7/SiBFQ5VIfy7K3BIP/FRmaTJ6QYbaNkiWZTVzpB/ORmsKvArfkZ1X8oKXD+YwsIupmema0KLjSpSNBjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788797; c=relaxed/simple;
	bh=HnIKeuPS9ScxVqrmLvwEy/zskUnDiOArxioE4fgpNKo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=E7k2On5zLJgpEGSXRGP9sPoxcKd52d+HUftu/Qr5xtDX9sEly6l3Jnj4+HfMLvSps+XOmPeT8llXK8g/W5VdvqiTlbtke2p4TEZocqQfNUZioJcVQQdVWUq/NluHFf1YBTNmDuduKqlBj/j5XCxYO6zfUj5DaIcDvw3CBPAliu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0fV5NsJ2; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0fV5NsJ2"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3914bc3e01aso1506080f8f.2
        for <ntb@lists.linux.dev>; Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788793; x=1744393593; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X9P/EfEIlZAESjSXhp9OseFFolhRdBBkLN0jHHdJSb0=;
        b=0fV5NsJ2wNa9iPwDnE1KqpUYXOmi5RNGet0J0uua66DeliZTH+XWtdlwsap9ylmgEA
         gtDsIiEWx/EHPMlM6ym5MDJxDHVzJjeEt21mqA41ezEUay/2bSJqdsLK7MoLrwsCVqzI
         4AN+539KQQXOPUWqD8Mphi1sZAufbjCBRHb3xqZd1GvETHOMT7cH6wi+XuPjphx/5aXR
         4pbA0lX31ayjNFnjYTHxyznkR6TeYfIqBkJ67u4wffvjAx36K9w2nDeJtpYdR2dHD2Fl
         qFk2nqb4bawtHGnL2mUAbr+BXtcdBip7FWr54b4oVizmD8sYr5nI78qOw5utOdEe0SJn
         Jthg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788793; x=1744393593;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X9P/EfEIlZAESjSXhp9OseFFolhRdBBkLN0jHHdJSb0=;
        b=FPTHLlv1PBYZKtQEHPgiSwqJH9Co/aulTiC7KrdwdVRK7gmUJC+4NSKn5V2ommFM03
         EbJWlfJJVjLayZaXMs/0t0l8HwLmA1IxW7lQdos/uPVvkDaQ03vC8y9Uifc6GhCGL9+H
         8M+x9tlrDHeop5M9e2h3fhFdxC+IPK6VXJNZa772fAOsbQsvkUCoKJl74vpIuGiN2a2y
         PncsUpcx8cirko4e5SyNn2MZaCodDr5AdN4BdLPw66RvuxZ1LqDuoF8e/1zwsg3krR3p
         gol5Akz94QrBJQ1BAWZZct0/OXIOXxrxhfnMPSLNyAC2JBxfiyVX9/VHeRnr3pFBbu7E
         NiOA==
X-Forwarded-Encrypted: i=1; AJvYcCXXhVpxoCJsR1BlKG5kS3Y0zdtQVrT5DFkF1cL9dr267LmfvqLVeE3RbqCQMzBqXv4I5E8=@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3FjqUzO9LXXHo7K3Kg0P2M6IeJQqAFew8I89vv1ZMzBQnDC0C
	OUPUM75/C2CziMPmZPYlgPPIGQavaccARhmrgyf3rca6le08oRedPNTf8sf43lE=
X-Gm-Gg: ASbGnctr7Atopi9q1X5mYln6l6qsq756lRjIlvcE9v/7SYBPcpUKv8Yr9trng8QDcGz
	ccjlu3BCRygk8OkWZyKccGcFxDttEixAf66+HRbPv0ZgWSk/6EvFcQYxRl4Pm77fuIK/+Oi4fcp
	6IJJhEsMIDEBIcGFB1U9aCZiEJTAcsuonUJ62XNZsv/rBvoxuh0pRKqI56Zh8CsYVueSzgAsMoZ
	MUp70fZHKLlCTy0sxHGv/pwZNwpKJzYWm/sX0A28TEhPi/dQAwWISA65J5198ZQaHUjYzWQHiVD
	JR52B2ovBIW5l5T5zeLv0CdJoYD7tKsM3gcwyeNhPvWC3Acovd88HdO64w==
X-Google-Smtp-Source: AGHT+IGswdimuWy71mElHnsix4QxjHQgPPPL6pnV5SEEI7VP4vSW+eIfVbl+qVp3zMV1Qro4ys96Qg==
X-Received: by 2002:a05:6000:4304:b0:39c:12ce:1052 with SMTP id ffacd0b85a97d-39d07bcd00dmr3359518f8f.7.1743788792654;
        Fri, 04 Apr 2025 10:46:32 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:32 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH v2 0/3] PCI: endpoint: space allocation fixups
Date: Fri, 04 Apr 2025 19:46:19 +0200
Message-Id: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAOsa8GcC/4WNQQqDMBBFryKz7pSYEhq76j3ERaJTHdAkJBJqx
 bs39QJdvgf//R0SRaYEj2qHSJkTe1dAXiroJ+NGQh4KgxRSiZvUGHpGCpj4Q2hmHt1CbsVm0Mp
 KbbVQAso2RHrx++y2XeGJ0+rjdt7k+mf/FXONAomUvWtbK9OYpzXbzDbStfcLdMdxfAEsqBEIv
 QAAAA==
X-Change-ID: 20250328-pci-ep-size-alignment-9d85b28b8050
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ntb@lists.linux.dev, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1811; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=HnIKeuPS9ScxVqrmLvwEy/zskUnDiOArxioE4fgpNKo=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br0GcS36RFMmRwE/Qtn26ZHmwW0s83GBeg7y
 773n9yVaTGJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9AAKCRDm/A8cN/La
 hfvAEACA0VtF3NMnYIFrqEUkjvSb46Wkq2f7q2zeUzwCnDEAkjmm5h6qGhYVIehmnD1/clPJrU3
 5ijoeFmk2YGiozkRlrVfP9CIHbnbt2J0XDnpImDVPRsXmM0+lE8BLGYx4F/zR3ClRfMykKjThy5
 MpwKJP1Pql+X4z1okaSp5kxHPiWz0EYdSEwaG7hXvlY1fUeUD2H0WmR7E8q/zHygnBVBAV2VnUs
 c/NL+8wGvxfMmYI9CbK+Y8sTBvoZP73yt7ZyygSAS+Xef6pm4kEXCd5rh36aZKcKauJoK9uRNe/
 blZiSOqCYREwN9a8w4lImfVuvMwZWeW3bYeABAjrLHjgJPRykGlEAoh3MxNW33SrITwPbjd5BiY
 6r8ieK3B5GnXTCWljHKymVLFYis89YjSOYf7HIvLO3L0HQIiXbMgh8tpHh7EIDavIvuCb/lQ4nf
 AmGKNIeNmvkk67kIXxodz5CVYBoMIi+SXuZfHbnHvltLoxFVybDM6y940lUzp/tegXVQpm21uBn
 +T4Nl1XsOW8+84QljYj6HUatBhxoZ11FX9pninfWRWDKmDU3XMr1OxWUH3d85boNMcipoKtb8fA
 qMe+9GF5j5FLgjbr0jwZleVpuQkpNRoQs46Bdu4MloDosRGiWIFfXe82VzfcgvGkInT88Zsbb3X
 crvrJtyRCZ0TwyA==
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

Changes in v2:
- Allocate space that match the iATU alignment requirement, as previously
  done.
- Chose not to add a new member in struct pci_epf_bar, as initially
  discussed. After reworking the code, that did not seem necessary.
- Make sure SPAD registers are 4 bytes aligned in the vNTB endpoint function
- Link to v1: https://lore.kernel.org/r/20250328-pci-ep-size-alignment-v1-0-ee5b78b15a9a@baylibre.com

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (3):
      PCI: endpoint: add epc_feature argument for pci_epf_free_space()
      PCI: endpoint: improve fixed_size bar handling when allocating space
      PCI: endpoint: pci-epf-vntb: simplify ctrl/spad space allocation

 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 +-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 42 ++++++++++-----------------
 drivers/pci/endpoint/pci-epf-core.c           | 27 ++++++++++++-----
 include/linux/pci-epf.h                       |  1 +
 5 files changed, 40 insertions(+), 35 deletions(-)
---
base-commit: dea140198b846f7432d78566b7b0b83979c72c2b
change-id: 20250328-pci-ep-size-alignment-9d85b28b8050

Best regards,
-- 
Jerome

