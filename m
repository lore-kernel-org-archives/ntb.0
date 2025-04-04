Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B20C219306
	for <ntb@lists.linux.dev>; Fri,  4 Apr 2025 17:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788799; cv=none; b=FYNzh/qleuNr6s3/vfinAcDUz2srmIznQ/tpG5GGkbAdozfj5YbwJGnEUOcux4I364liGPJYPW7OWq5DSGLiraroTA5i08up/cNOqnPcN6KB/Kw+YYwCR2g1hO4/5TtAUuxcmFldZnNB938vfGU6NY1/oWDDeDyu0EOTDG7m0jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788799; c=relaxed/simple;
	bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WbcH1FS+Z+lX3r4pFoFfxKk0xj9vwhLXZOp1VEfBg+dtu1mTgdC8FUqqSVKagPlrtH1vBs1G5RHQzzqE2paj1L+jkOEIhRvOYIsl58dcSi9dK8zSlO946sAzlXOYKMnkUj7K8ks+F1BLqMoqESvKu1Z2m6Cn1MRktH0UbdyuyZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ibBHaXhH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ibBHaXhH"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c13fa05ebso1421496f8f.0
        for <ntb@lists.linux.dev>; Fri, 04 Apr 2025 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788795; x=1744393595; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=ibBHaXhHePSZTcIfwRDsmIwRnW7+cmcMjd4pAU0dBCbS7sJRcyZA4KTOJ6UuQQ1X7Z
         hPtVcKdEJH9CIP5G3Spa3E0ZiySfEWeWiJfRz1v+xlGOghgXhDUxz8RJ3VZvnpkS5XNr
         f80XQSJoyRMMhgdQDRmB4p/BV4zDPjA73a7PkC49URMxxMUoOlr/zIGpD8THAGjrqeZA
         CKZtqvwGlJLJvuu46mXqr3Z2EMLmZTl/ssBBr3nUoW+jRlyLhK8r9Conk6FE89UW+hpt
         CtwYCki9TbcrhqfbLiHzx+iSqduSYBfSz6Q0yuxJpFdCUXGXbH4Mfr8Wbfa71J4bxfJA
         iZfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788795; x=1744393595;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxPRinaB0R9MRMHkqtzs6Jksu6ZEexxFz8Cu5WJ1Zw0=;
        b=lJ1nqWVI3xJZyrOvX/a/EbEHg/xwaHu0QNd9yBPOUihHZ0y5R6J5wBb+FmpN/2eHI8
         LSz+E4FHe984SCTwIsKSbOdjHqyBFZb7gVfoeUpb5kwZbQ/b1pK1Q36HhZYQIpWNMGUP
         aAFseC/+eohnHGBUlAbiN4j9wnBvNsS9d7YwO56y9iERB4cBEd2O6UVZ53S58eUNBR57
         XcIxh/xnydL3SjreaZ/B8o4sqvLjp14g9tlokR5mXYL2FAW1vfwogOFMsgjYjn7KihWT
         YXgN255tt3213X79W3rAiwz5qcOJd2+qr4gaqbSgEAZyNKlw2sEG3SxUpVzQcLG6cNoi
         pCMg==
X-Forwarded-Encrypted: i=1; AJvYcCX7zz/cDlJ68o2c59CGs33WXFxm/m9xjI+4e0YHhJSm6LftfNPyo+gsJoGxScGU7NT7xFI=@lists.linux.dev
X-Gm-Message-State: AOJu0YxnuVqR3rg2qPHVB2nI6d0DLqsNzlUnaoSvwuhvCljDT6dt9mnc
	LFpDsgikHbK+a4OOCcM6C9aVtOGOA2V1r+WY4Yani+3C15vJpxXCB7SBUs9Ijnk=
X-Gm-Gg: ASbGncvMoEjSceor6rvQ9JoDseoothJ63VuZ92IXulPToBRjFxx8zLixzsr2vLLJP1l
	dsA+z020Rend2ZEo8jH2iT0R5Uc31IQRFeGl6xM6fyFkiYGBnyqZ4cSx9i2cralUSP6KzhnUp2j
	O6oZmQ0L3DipIPqXtTNH0T32ekpFF0IzYqEHuu6PX9jJjpfsZZjs0BIdlMm5uRoK1vV3TxZQ1ZN
	ZZ3CO9IJVbkAzw00KuGuymGSlliPCa2+OneZRj/QoqO9ef1DCrq0onbBaAWEE4AWqxalsROtHsS
	+27HCbREyWDQ1lJmx5SWnBQ9ywDwe06EbUbAbSTitXs7Bs4joswdx+0wtfHV+mxiNpXH
X-Google-Smtp-Source: AGHT+IGJK67GjTDKDpj5bH038uXsv6Y5SZCtrTzwfFsjB58QOdWQqxfjOKhYa5MkwP/MU+TWVGqe2w==
X-Received: by 2002:a05:6000:270e:b0:39c:1257:c96c with SMTP id ffacd0b85a97d-39cba93f966mr3020079f8f.56.1743788795236;
        Fri, 04 Apr 2025 10:46:35 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 04 Apr 2025 19:46:22 +0200
Subject: [PATCH v2 3/3] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pci-ep-size-alignment-v2-3-c3a0db4cfc57@baylibre.com>
References: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
In-Reply-To: <20250404-pci-ep-size-alignment-v2-0-c3a0db4cfc57@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=VMQRvj8CO60hVIlMMgdkTE1dtBACF+fNeO1bhBVnQsU=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br21+RpEyu7VflBJ+7DQPDTHDsNR/iu152/c
 AfIb7ODPZ2JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9gAKCRDm/A8cN/La
 haVOD/94gKh4Rwrb9XZS7wgvtm4xpuUyG+eCwYuUMEyNfOou0meG7+SOlSJhtvZ1NsV6kD7V4HB
 ngGvBJwsU0P8WC5cRU9CLVrc8i3A61jPsLvNnhVrJ77uvSg2C0HRqgHw15xyRsvIZArIb8CU040
 A5JupzLwaZDYkREjQjLEBNqAuUVCwD1MT3sm61cZFKdXJoxqRr67QoUoZ10GzQTv/X28JQL5WeD
 1IAy6A3fkHtphYdtl1vFCY5PDeijD0KzoIycqy3dDl0gFiMFKYCVBCIsOXI8ms25+GlwwlR7jmr
 KmXHh8zMIoCtoVTRXR5zeCq1lqvi/V4m7MFSpW7uC9iaTFfFYEmPDFxK2xDemp8L4++PHROmJ5u
 7CPXSakNhZVd9WGCVQEZkifF5j1ciFeaeBmWbCoBFtVHjzioGu0Ss+9cTluMndT1YxZwhHJF9cr
 oHScr42ldiZkUIDW1DkshspaPEpv3+Y1TSIsPrvN+hztJzk+OcKTp9RlR3Y4X6f2JlAk7gBPUml
 wkrZh30XKCKDfZAQ8DYmIRGV34JTkX7GOPSSsQrfp5SOLZJ7XvcIEqTbdf+kX/GD6lHLtTfiTzN
 ZmBFc5ZcRokYQuO2ciUIO9fsoRZpg+CGU25E0E+08pGb9b45MlAvo8mc3JWcE6ql2TykQ9kl+PZ
 G6+yE31B/oorRXg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When allocating the shared ctrl/spad space, epf_ntb_config_spad_bar_alloc()
should not try to handle the size quirks for underlying BAR, whether it is
fixed size or alignment. This is already handled by pci_epf_alloc_space().

Also, when handling the alignment, this allocate more space than necessary.
For example, with a spad size of 1024B and a ctrl size of 308B, the space
necessary is 1332B. If the alignment is 1MB,
epf_ntb_config_spad_bar_alloc() tries to allocate 2MB where 1MB would have
been more than enough.

Drop the handling of the BAR size quirks and let
pci_epf_alloc_space() handle that. Just make sure the 32bits SPAD register
are aligned on 32bits.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 26 +++-----------------------
 1 file changed, 3 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c..bc4a9c7c4338db6cc89fa47de89dc704d0a03806 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -413,11 +413,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
  */
 static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 {
-	size_t align;
 	enum pci_barno barno;
 	struct epf_ntb_ctrl *ctrl;
 	u32 spad_size, ctrl_size;
-	u64 size;
 	struct pci_epf *epf = ntb->epf;
 	struct device *dev = &epf->dev;
 	u32 spad_count;
@@ -427,31 +425,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
 								epf->func_no,
 								epf->vfunc_no);
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	size = epc_features->bar[barno].fixed_size;
-	align = epc_features->align;
-
-	if ((!IS_ALIGNED(size, align)))
-		return -EINVAL;
-
 	spad_count = ntb->spad_count;
 
-	ctrl_size = sizeof(struct epf_ntb_ctrl);
+	ctrl_size = ALIGN(sizeof(struct epf_ntb_ctrl), sizeof(u32));
 	spad_size = 2 * spad_count * sizeof(u32);
 
-	if (!align) {
-		ctrl_size = roundup_pow_of_two(ctrl_size);
-		spad_size = roundup_pow_of_two(spad_size);
-	} else {
-		ctrl_size = ALIGN(ctrl_size, align);
-		spad_size = ALIGN(spad_size, align);
-	}
-
-	if (!size)
-		size = ctrl_size + spad_size;
-	else if (size < ctrl_size + spad_size)
-		return -EINVAL;
-
-	base = pci_epf_alloc_space(epf, size, barno, epc_features, 0);
+	base = pci_epf_alloc_space(epf, ctrl_size + spad_size,
+				   barno, epc_features, 0);
 	if (!base) {
 		dev_err(dev, "Config/Status/SPAD alloc region fail\n");
 		return -ENOMEM;

-- 
2.47.2

