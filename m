Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF9C320766C
	for <ntb@lists.linux.dev>; Tue,  8 Jul 2025 14:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751986216; cv=none; b=BQ9IWW+/3+r+xgII8uzmMfnJZxEmpG/oRpFgwJ6/QfpHr4DBJfCyvWEpdw/L6D+wEOIbmV3KQ3OopvIITq+fd9J6T2uLr8UEVTpxfN7EN4CKuwIVHkaS0SEGF38r2NmAD34RcSQNQA+iZH9GNJLfk/wESzGlG4hsHdNguChvgcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751986216; c=relaxed/simple;
	bh=HEgvTY7DvqUTASXbAkoz2Cq2W+UACAG7D0XiharOkiI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=BHvVzABIDcs1zInRpzGX0h1bVFbkf2HVMQV2zw7scPuZCo3Xzc64NOp0zYOKCcxZPz+2pce90hnnU7btmhDVy0KuUGj4bcST7iJ25KH2PN0DvGDRHYAnBZWqb0hncwinx6IZuLQOvWvMzpTUCnOVaKb0+7bWQ8KBeZ/Wv1fULbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=1d8POkiu; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="1d8POkiu"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-453066fad06so31649635e9.2
        for <ntb@lists.linux.dev>; Tue, 08 Jul 2025 07:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751986211; x=1752591011; darn=lists.linux.dev;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+mcJ7ZL40yfdI/6L1U2sq8kmJCRggUCq7uPF858vik=;
        b=1d8POkiumho2WlLNndth8h4pMvU0JywEX83mt9rxx7FA+t4mlR09mbWkI4Veiit1f6
         Bv1IfZJq+1PO+/OWRO2AW8IEhY+gkPcmEfRogujGa020k7i2D0lo1cD4dGyn7NoZonDK
         XG8s83B8NsCstNjJBvQZas4VzWEIqXNd697cJb+RTwJO6OPl8M7o7/9BMg6LBEy1MwJu
         6BHS9XzKTcdaU8+NZWN27Q43OWgZ5muVFKSKP6LbNUAsv7LNxhYYMtVdoBYPllLyLjqC
         Cfh+rMdgQuMFtgqCVNzpbqbO0kS+Ku8yrhDyX1ri3CaYzhqA+mr3qwun55Q8Xtj/PllA
         s8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751986211; x=1752591011;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p+mcJ7ZL40yfdI/6L1U2sq8kmJCRggUCq7uPF858vik=;
        b=OPmFmqiv16tUZN4p8nnJGDzvLsvS40n7OOBFWuhQzZyxqBgyw6WHMXUIo+8zZ8tT/n
         2Z+onUmf89yUHuAiyn0lMUhEjUoh7nXDAePrvsJiRtZkUeRqmxoePSPycsRhp1muTXIf
         J3KDCsItEgsdhkIQw2CW0pvDdnirDZcmHRsnGx6oeX+BY2jt0DTGRbWXJt8Le9kXg8pn
         Thypx7w1ntCEIjnvEEdyMZQHwE+x6DDymBHpUvXCRBcTz+ak9aHSjKcBnnZHGJxwuIPq
         0PhkUrx9utT8fmpegvlopO4qDIa8CHtMIrwNjXrNLJghqrp3RdblT9Sfehrw0+bDP3Sj
         3SUg==
X-Gm-Message-State: AOJu0YyKq4mKmyiCrJtCzvFU92dNvtpciX4PAxoRE+LvGaBygieSmAsO
	I4xGIAz4qQbpjXVmxVpNCHrXC1e2TBKxbQdcstYZ+mVZckiNYiUhCMjivZBdvtiEWL4=
X-Gm-Gg: ASbGncsWYq1qEzOB3LhB4+NV6zpi/KXytABO9ylDtomY7yjJat79wL746QKEEZwkeP/
	njIpSXtE9qasXTxHVnJZ8xmPCGlOOfVMFH5ro8kbzUtmBTBjWU8Po62stUPDwsiFY/o5NOCX8P3
	YR/YdsJUX1Rwcoi4MRtlsrnerrcCkVk1kV7URT5WQvJrIHU4M1Tl1zk0Q5Cl40Pk7ZNI7uym8nk
	URYhEsmgPSWLITNV1WLD3mQi89GgYGimXgQhmR0i5jC6X0X8lxgc5J1il7S4/wvBGmlmAJVFi7B
	ZLxojnsEpKSmWG1L5dQRbwUwxtxn9ME6bpplMhFxM+GLidC7D9tTg0msftvueR4GEtXK2VMMtK+
	0
X-Google-Smtp-Source: AGHT+IH2G2zx5csQczqgTBlBit9l6rKgdpM4AL2R7/oW/cCxn22xdVAIxyhu7QXZ0RNJGTHll7v0Sw==
X-Received: by 2002:a05:600c:8b0d:b0:43c:fe5e:f040 with SMTP id 5b1f17b1804b1-454cd5234b7mr32681735e9.23.1751986211084;
        Tue, 08 Jul 2025 07:50:11 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dfdf:dfe3:8269:12e7])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3b47030cdf5sm12988879f8f.1.2025.07.08.07.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 07:50:10 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 08 Jul 2025 16:49:57 +0200
Subject: [PATCH] PCI: endpoint: pci-epf-vntb: fix MW2 configfs id
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250708-vntb-mw-fixup-v1-1-22da511247ed@baylibre.com>
X-B4-Tracking: v=1; b=H4sIABQwbWgC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1MDcwML3bK8kiTd3HLdtMyK0gLdpGRjg0TjVCNLAzNDJaCegqJUoATYvOj
 Y2loA1x0n8F8AAAA=
X-Change-ID: 20250708-vntb-mw-fixup-bc30a3e29061
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1285; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=HEgvTY7DvqUTASXbAkoz2Cq2W+UACAG7D0XiharOkiI=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBobTAdm1+n8PQLlMWBQtM3sujQ9VlXuPytqjO/b
 RX4fjO7geCJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaG0wHQAKCRDm/A8cN/La
 hbW9EACZxPPbx9A9N7wzBBwK+X69FdGNxhFWZa4r0v2iig7LecShid9JdCCgxxpoMTiJ4Y7h/WD
 iepvHs56AKjPYLS3TQ1QSc0bhbHJco0KzUCQn+zJq153Oz9QNAYjSAYTXDblnUxvBHUE2TIT0nP
 UKcKt1RKzVpbMNSoNEuONomEejyFT35evSOKpyVwRiBENRx/IJipuJu3unfu6AzvVPsTRFsVaL0
 Lmc8lU+DFtm9eeA91jTOsStJBhdrz6ROjci+1WTlq6zdhJox60lw0FndiXEGAEI59CYsqSttzCL
 V7e8bZcPiJ4jeqt/FhpTO9dLn6gN42Xs6u/sOBxIKp1YHhME+zTphrFXptfSJUl3qa3PJRcW0Id
 Rz/y6L+YqCuAj3I12VWuJPloVzQZ30Iv/nQxk+zMICLF5ktrtpKQt7w7DPRbFnqR7NYF4xlIeox
 qFgBgTF5DPamsFhI2Rb0tYLY8LnmyYK6NYOri3ZUnibpXG6D0Q7s9rteRkbyT7ZyNZWZpQSN4nV
 3EnS5022AvlTmNfq3FqWqmGJphqMc+udewNL1w7PZbhlCpqF+zzQ4zE2og0wHhz+HNRyaNGDC3t
 IWg3bFShM8KgULCpQXVoiodbPpMix9DlvXjZiRvCme3UokWoxG1wc3WmNDxkNv909JVLYjrhDEi
 oG1fcYX8ebohO8g==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The id associated with MW2 configfs entry is wrong.
Trying to use MW2 will overwrite the existing BAR setup associated with
MW1.

Just put the correct id for MW2 to fix the situation

Fixes: 4eacb24f6fa3 ("PCI: endpoint: pci-epf-vntb: Allow BAR assignment via configfs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
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

