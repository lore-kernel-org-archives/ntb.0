Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19AF1EEC3
	for <ntb@lists.linux.dev>; Mon,  5 May 2025 17:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466929; cv=none; b=AuuItomD8dAEKLa24qXt6aI8/+dhRZWUtxyYVXYWRzDGJiuQQHDHDxIsZCgHHa8hjdKYPFu3Zkw3XFvbbp5RyfaSpw3uzYh7s9Ga0f47QfaChVI24dEtq2A6DrCizTP4NmdUaTmR+gT7lw/U19md6RncJYPEOjUsm3DIxzJG4XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466929; c=relaxed/simple;
	bh=AsnF99CU35lEfuVMfrn7Lp4KdhCC232j/sCNefqZr3k=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=dd0NSqKJ71Y8cU3v/sE0sqzT91EKqmQGRbUDF4gOPlMUFETGYQQn0MeleZ/2D0UvMei892qE0XSa3GaUllTsT4l5DESHwxS0iLHopR+elhVRDl/wJBVSQCn82Kde9RkgYs8KD7i+hIYUZeuLJ0xKgq7Nl789ZzU9TO/gHXj5EYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=t2TQxGVw; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="t2TQxGVw"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-39141ffa9fcso5057727f8f.0
        for <ntb@lists.linux.dev>; Mon, 05 May 2025 10:42:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466925; x=1747071725; darn=lists.linux.dev;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a8lN06DriQHOm0MH+gzUsFuR9Qtpx1gu9egDvR4xGbA=;
        b=t2TQxGVwr47+71xTjcy/2Fxlxnmxpb+7G8SkTaqnXSLW8m2nQfFMr6H1RxHCQbifK4
         X4gay87aTnFvcl1HOB+m0NLflnVk9qsDpxdXzerqBTi8O4m1rYSiC3zxNELpK1MkU+ls
         XFrO/3XC/FUMAD/S4Hdhy5jdh8An4xaRtEjTbJ0FdsVHNNWj6vInfYMuuORyt4jXZZQc
         EeJqlHQmsj0XdA5muip7+WaTWgF1+zhHPPSGijFvlvrH91am0Ayrn69YXOSsvrV3WKB/
         RXhReWNqkS7FvQCh5Mdc4SL3QtGXtf91quLCPWsNd8uwzLwxBA7vXYHRX9PA13MoFw8A
         +i/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466925; x=1747071725;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a8lN06DriQHOm0MH+gzUsFuR9Qtpx1gu9egDvR4xGbA=;
        b=dIFY7PYbIMLSyt1/Wt78UXYxTIzxHSdTSBFdnKJ+m+xflSzkoN9H9d7c31JpNbbQXx
         HF+I9hRzM0x+e0MpR9EcUs1qhPd8hl/Dyhm3yruH/bjIcvX1NqA0/DKafo+7gJ2pzPs7
         dz64vWW6iF3MCyVKDpK4+JPlSa2cd9Ln1PfpbU1yT9QAW3jCMBP7oMxACQv4kUM/jp2D
         jIsmHxEtWn0W4CYmlMXVDv+4+8jDceaTZYROTTpTT5sA3iCH7EFbNmC6fsX1ifHPDILN
         CKRj8tYtvehF2646IrOqjc9+82ohDGYIDJsUwbJrzi9jknIVIOtOaC9DhmEHt9JJ9fqh
         M98w==
X-Gm-Message-State: AOJu0YwaCn0TbJhT0iRo/pCpYIaQjzihYRvPnNuI8ynfB/RFqlTDPOne
	sUOMsJMCw8ycyZImaECmoOcNx7Pgkh0VAr4rbHkp6JC71tQ5OlWYrdxNzjAB2cs=
X-Gm-Gg: ASbGncvKBp5ipX2sKkIZ/bUtAJX2HRZdUBI7RNN71rRab8Nw235dvndQCL+P2rcXpNk
	PYtZFPEgQShm0CrFGMlEUoJNENB5e8pAsWfgKzkkwNWdQVrGKOvoBGlPmxVTcyBhW50P0yQ34W1
	cY/Vvhsl09SxV04z+QR7dCnHVd0yYPp7QUzOTEL6VpJ0KjY6OofaVaG0ayiumPP2UYeJGDsttAL
	6S6RRT+lHq6p1RaLisEXFo6djSAwgbtddjujwaXwDmfqJWKPYwVsg/fBHhxlrK3oMClq5l7Ug+Y
	r9dek4Wr/ldWqBg4TRtSN8XbRcG5pQQ13P75sXMzrikBHCAu/sKAjg==
X-Google-Smtp-Source: AGHT+IGZTv4ioURW03KoxJEJiMQI2V2RSz7/MViAATIEMWP7dqmwgv1DmXDoWV1GLXdDM837hIaNZg==
X-Received: by 2002:a05:6000:552:b0:39f:4d62:c5fc with SMTP id ffacd0b85a97d-3a09cec0d32mr6471699f8f.35.1746466925370;
        Mon, 05 May 2025 10:42:05 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Subject: [PATCH 0/4] PCI: endpoint: pci-epf-vntb: allow arbitrary BAR
 mapping
Date: Mon, 05 May 2025 19:41:46 +0200
Message-Id: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFr4GGgC/x2MywqAIBAAf0X23IJpD+hXooPZWnvIRCMC8d+Tm
 NMcZjIkikwJJpEh0sOJL1+lbQTYw/idkLfqoKTqZQWDZXz8veJqIp4mBPY7amu1c4PqaBygpiG
 S4/ffzkspH5fOc81mAAAA
X-Change-ID: 20250505-pci-vntb-bar-mapping-3cc3ff624e76
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1677; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=AsnF99CU35lEfuVMfrn7Lp4KdhCC232j/sCNefqZr3k=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhnjMJJUFbkNyE+Myn4/5qoh0JDrCSI4U1Yb
 3C1VImsl9uJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4ZwAKCRDm/A8cN/La
 hZaxD/4gzoR3ebjbcFwNjqhGZIEm0jjPTXFv7MhwqYvOV2CzJZZVy9j2vRZs93xpUdbll2xCn+4
 b5WEEKmzG6Tfi5LPSEoI6rz1bAiLp4yAq83TfH326Dwj1WCSDRqnb3/aoL6vtpep30/Q06RIxHE
 Mky/g6K5BKCg3cJiQeBLw0ezY1uD4W2c+zwrfYF3btL25ujhBx7MaEG8AWjTmBcEqCyL8kna8YK
 EyTGRigGB3V+HdJ0ovYj1p1H54X0Iyv3mLYc25bkDyNnuVOtEz2Sg/6fbbd02icglmO/i1/Bz4Z
 gJYRDd//eGpinDRylsYw97YOTGHtG4f2MiHurzVJCEGcUWdEKghLN/0w8yihFCxyJ+WStP8dtGL
 Dxl/G7EcFcuKS6zr+QE44MXwuTcTaccT5VKkEDDmFonCpxJnh4fBuiw0H+5qxxSG6ak4wZznLGq
 8aVjkMGQQPpTP8/Ka4+BPe58FduvGxOVL3qMFS591lg+sOhpnUGfgy37Z+NccCU6QWXJWi/Gs54
 sy7A8MtT//QNQ72VqMo+8dUCZD6YTnzpLtWq87/mc31cGh9BTnLg5X31bLaDDMYhnCEYtq5eZpT
 jZb1e7S/CFqzYhFy/yfeOi5XWSv6Lit+DzwQxEwmo137avHgg/sO7zUvSnrVl6qtAM5aTMQXQHH
 MR4Gn+bgf22HGdg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The patchset allows arbitrary BAR mapping for vNTB PCI endpoint function.

This was developed for the Renesas platform with requires a mapping that
was not possible before:
* BAR0 (1MB):  CTRL+SPAD
* BAR2 (1MB):  MW0
* BAR4 (256B): Doorbell

It is possible to setup the host side driver with mapping above without any
functional change but it makes to also arbitrary mapping there.

The patchset should not change anything for existing users.

Possible next steps:
- Align the NTB endpoint function: I'd be happy to propose something there
  but I would only be able to compile test it since I do not have the HW
  to test it.
- Expose BAR configuration in the CTRL registers: I've been doodling with
  the idea to add a few extra registers in the CTRL region to describe
  the BAR mapping of the other regions. That way, there would less chance
  for the 2 sides to become mis-aligned. I'm not certain it makes sense and
  would welcome others opinion on this :)

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
Jerome Brunet (4):
      PCI: endpoint: pci-epf-vntb: return an error code on bar init
      PCI: endpoint: pci-epf-vntb: align mw naming with config names
      PCI: endpoint: pci-epf-vntb: allow arbitrary BAR configuration
      NTB: epf: Allow arbitrary BAR mapping

 drivers/ntb/hw/epf/ntb_hw_epf.c               | 108 ++++++++++----------
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 138 +++++++++++++++++++++++---
 2 files changed, 181 insertions(+), 65 deletions(-)
---
base-commit: 1fa7eab22df331bcc7942a9c0b4569bebc11593b
change-id: 20250505-pci-vntb-bar-mapping-3cc3ff624e76

Best regards,
-- 
Jerome

