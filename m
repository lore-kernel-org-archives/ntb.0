Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC3C2F5091
	for <ntb@lists.linux.dev>; Wed,  2 Jul 2025 16:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751474930; cv=none; b=hgNplksrWeU6bIzymuUyoGr0OUzrf8KpasCYaZLAfpmnRSRsuzmXcVX5Sli2Fcl/KCKfiZgpYyDf7qleUGG7XWAlDMY9MmwbYbK3eNk/+5c1tvcMuC9b9KqdfuJrYYoFewCsMG8DuhcHKWrElkPWGG2tOqkalb2frL1o3IeYWXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751474930; c=relaxed/simple;
	bh=3NNDUeuHsvo2VX6nwrGAtLPPIQB8S69YI6TjV7kH6Xo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O8KHhv6QDsLtnqF8z0Ji+R0ZzWMFQZ5zxaLN/Xf8xnobwwJmtUq5c9CwicdhsVU7q5t6gLwomvGnLVLa4Lzj5n34hlQSpxqbx/E75XWxkv9u2j3l68jEfMOz+TIzzD3Zd2ReTq32mQPenNdLo1h1Hl5FXLIOBcnrekW1/0GkXKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GPUfAZM1; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GPUfAZM1"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538bc1cffdso44921995e9.0
        for <ntb@lists.linux.dev>; Wed, 02 Jul 2025 09:48:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1751474925; x=1752079725; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wQYTPO1XpKJCQcWh+sfxZYptd6FBAp1btwUGf5q+fT0=;
        b=GPUfAZM1H9VpdQZsiOvz2tMBBqI8C9Alc0n7bA/TRpvWSWy2+rh/irQmk5CuaLxtEN
         L5CcO1uGyx0XgAYDaIypaC+LO0QWiYpNm4/Gs1C2Ea1eBXcqNUeV9Mk72oxLecfcxK0Q
         bTt++MNlBrPtPShpwoMtFHJmGoekuMP4H/2EyXItDqqoBeMpEkZ4CEMx5oVk7lXLKROE
         QQxZ0OQmtolTEOtA6IdAWqKb2NsNFLmxdnWbGabnjtM3od5XZ+biKbkZlUS1n7Oj8JUm
         Xz6xuzOwvAXYJxjPdqEwG0tne5LBmkfwmMQ7P/aIYdfHsLJd18DpDDAe869x+WuHjSfp
         SPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751474925; x=1752079725;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wQYTPO1XpKJCQcWh+sfxZYptd6FBAp1btwUGf5q+fT0=;
        b=oc0vajFKWYH1NjkDM/h4Snyva+b3Rl0brGHnyNpqsoSaezZ7CXan/vajGbwSSPHVSE
         W+oSSiA9Ue1xsDfkfFZM5JXD+cEr1lA8wPQDIoxXPQjLMhviSgayHk32+WjjmHKQKFMd
         xYISUy5cJvWedo83NC9ccdkSvRQjS8eq0xtoJzigQBQhxyK568VUVukGOROQdP3sKs8s
         4EJHi/sgsRWAtg1Uea22/hLC1tvK1R/gkmND1w5UBfin/lFnSaKfqYNmeAmg947y1igx
         PHjWZKrSeNvuc+UOFcvPzkonRN4tOBeZqj/wn7s0deFFJ5ho5V5QAdGyVyQGuAK8Ys8f
         oCSg==
X-Gm-Message-State: AOJu0YwnwA93Qw3eMdMgHvzt/FgeSNVpcFdNmdBodeYeN9lDQDMfB2bO
	jQvnAYlnNoj4bwvVu23zO8aeDUGWh7PbxjAodRbwChPAqWt4pgLsAcYO1rmNx8+5gbs=
X-Gm-Gg: ASbGncvxqUesYsp9MkBk9pXMLjE/yYu2oBJ22UgYS3yuFCsY04CFpO9QU2U1gj+IfG1
	l8qwtP0U08o8KX0jdwqzx0v8Rur0LHbBo3HXCy1IKVllEcuwJkz2es9gxcC8o6CcpQF6M0+8IWR
	x5M5MH65Op9mXRI9tBGTDUVqES3s7/+4zj8IQ+Zs1bjcJOahMzgZetnCgd5cZ1MDe2Io2HthpBp
	QNhracw4faFxVfClqehpwBiRDq0uY87/tPHFZXE0oSL7ca8nHaTKh8mucjPvw25yPFD9zbRTdew
	+9pSroWGy6UX5BPc4IPD+PxuQt7nl8gozSyDuwrheC3EQN85Yk38W5+zTFpmZNxV4EVTpFvhlOq
	E
X-Google-Smtp-Source: AGHT+IEPJ3J0rEglf3oRey19XgMB/CO1+HMV7zcZXiSO8hUTEF7svDZo9kfDS9gTj/hL3PROF/qvPw==
X-Received: by 2002:a05:600c:138c:b0:43d:ac5:11e8 with SMTP id 5b1f17b1804b1-454a37030a9mr35785855e9.21.1751474925290;
        Wed, 02 Jul 2025 09:48:45 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5542:4bad:e07b:9489])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-454a9bac51bsm2871155e9.39.2025.07.02.09.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 09:48:44 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Wed, 02 Jul 2025 18:48:33 +0200
Subject: [PATCH v3 1/2] NTB: epf: Allow arbitrary BAR mapping
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-ntb-rcar-support-v3-1-4268d9c85eb7@baylibre.com>
References: <20250702-ntb-rcar-support-v3-0-4268d9c85eb7@baylibre.com>
In-Reply-To: <20250702-ntb-rcar-support-v3-0-4268d9c85eb7@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7038; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=3NNDUeuHsvo2VX6nwrGAtLPPIQB8S69YI6TjV7kH6Xo=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoZWLq4jf9IHzmy8o9jT+bID9kK6LiS7h9DfG9m
 lk4fM25b5+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaGVi6gAKCRDm/A8cN/La
 hbJBD/4w0rnGn+LFyUs7FufUN9eRBCGjVuT4+6lnVtibIcv+PiiNCRgUnr6Pu/uFIPQXj1q4pNI
 rv56iocDz84MXwDZVSxx6ppA/3NzYDN3ZUIznMvLoWAP4lE3vpe9c4L1ywwtdyOcbx98osCsxU9
 3Y4zcujnKdqAVcr2NYs7kGw5nBXwGDMn7yAUZMtr0xju4J6rFz6XahqcGDMEyeOXcSanPNwsgga
 iGCUS1n93xUUTU+O15LI24Ar0LASWtLw9WVs/wdwP1IFGSzAqQUlmk5Mt23/8j1mvELzpFvqj6A
 sYc2NLy4V1Q2SenLghs43ADk/sRA5NAdqAqdfGOEvFqa2aypfZlXDF05s8FllMdtTseZB6RZSk3
 EjPQL7mLN7BsNw2ISfs24HvOxaKXSHf4WPT+sjcd5J32BRt1pyXW0gxRnKMn0PWWhr/ww/mAd20
 lLtMjNPk+eG4+Tg+O0A4Tord8oLafjOK/1dcojHVGB9+Zkf5sD5sBkAoL0MjRx6EaBXabzURF9H
 ZCUQXcOtxMIdG2WCPAd5SRmM5OvXjcNtouB9cbUMOoBuLtbHzuolRLhU6s+kja3dTqLFytbWLq1
 E8VFL3ER92LPUIL+7rTAkOit4fE5468zsEKA9Hrcq3qenqGHFKQua9+v5wvOxN7Xt38oFmY5uBd
 s1SE+X++DTOLiQA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The NTB epf host driver assumes the BAR number associated with a memory
window is just incremented from the BAR number associated with MW1. This
seems to have been enough so far but this is not really how the endpoint
side work and the two could easily become mis-aligned.

ntb_epf_mw_to_bar() even assumes that the BAR number is the memory window
index + 2, which means the function only returns a proper result if BAR_2
is associated with MW1.

Instead, fully describe and allow arbitrary NTB BAR mapping.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/ntb/hw/epf/ntb_hw_epf.c | 103 +++++++++++++++++++++-------------------
 1 file changed, 53 insertions(+), 50 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..2b51156e01b0f22ef282d80c08c22af92f49307b 100644
--- a/drivers/ntb/hw/epf/ntb_hw_epf.c
+++ b/drivers/ntb/hw/epf/ntb_hw_epf.c
@@ -49,6 +49,7 @@
 #define NTB_EPF_COMMAND_TIMEOUT	1000 /* 1 Sec */
 
 enum pci_barno {
+	NO_BAR = -1,
 	BAR_0,
 	BAR_1,
 	BAR_2,
@@ -57,16 +58,26 @@ enum pci_barno {
 	BAR_5,
 };
 
+enum epf_ntb_bar {
+	BAR_CONFIG,
+	BAR_PEER_SPAD,
+	BAR_DB,
+	BAR_MW1,
+	BAR_MW2,
+	BAR_MW3,
+	BAR_MW4,
+	NTB_BAR_NUM,
+};
+
+#define NTB_EPF_MAX_MW_COUNT	(NTB_BAR_NUM - BAR_MW1)
+
 struct ntb_epf_dev {
 	struct ntb_dev ntb;
 	struct device *dev;
 	/* Mutex to protect providing commands to NTB EPF */
 	struct mutex cmd_lock;
 
-	enum pci_barno ctrl_reg_bar;
-	enum pci_barno peer_spad_reg_bar;
-	enum pci_barno db_reg_bar;
-	enum pci_barno mw_bar;
+	const enum pci_barno *barno_map;
 
 	unsigned int mw_count;
 	unsigned int spad_count;
@@ -85,17 +96,6 @@ struct ntb_epf_dev {
 
 #define ntb_ndev(__ntb) container_of(__ntb, struct ntb_epf_dev, ntb)
 
-struct ntb_epf_data {
-	/* BAR that contains both control region and self spad region */
-	enum pci_barno ctrl_reg_bar;
-	/* BAR that contains peer spad region */
-	enum pci_barno peer_spad_reg_bar;
-	/* BAR that contains Doorbell region and Memory window '1' */
-	enum pci_barno db_reg_bar;
-	/* BAR that contains memory windows*/
-	enum pci_barno mw_bar;
-};
-
 static int ntb_epf_send_command(struct ntb_epf_dev *ndev, u32 command,
 				u32 argument)
 {
@@ -144,7 +144,7 @@ static int ntb_epf_mw_to_bar(struct ntb_epf_dev *ndev, int idx)
 		return -EINVAL;
 	}
 
-	return idx + 2;
+	return ndev->barno_map[BAR_MW1 + idx];
 }
 
 static int ntb_epf_mw_count(struct ntb_dev *ntb, int pidx)
@@ -413,7 +413,9 @@ static int ntb_epf_mw_set_trans(struct ntb_dev *ntb, int pidx, int idx,
 		return -EINVAL;
 	}
 
-	bar = idx + ndev->mw_bar;
+	bar = ntb_epf_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
 
 	mw_size = pci_resource_len(ntb->pdev, bar);
 
@@ -455,7 +457,9 @@ static int ntb_epf_peer_mw_get_addr(struct ntb_dev *ntb, int idx,
 	if (idx == 0)
 		offset = readl(ndev->ctrl_reg + NTB_EPF_MW1_OFFSET);
 
-	bar = idx + ndev->mw_bar;
+	bar = ntb_epf_mw_to_bar(ndev, idx);
+	if (bar < 0)
+		return bar;
 
 	if (base)
 		*base = pci_resource_start(ndev->ntb.pdev, bar) + offset;
@@ -560,6 +564,11 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
 
+	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
+		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -596,14 +605,15 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
-	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
+	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno_map[BAR_CONFIG], 0);
 	if (!ndev->ctrl_reg) {
 		ret = -EIO;
 		goto err_pci_regions;
 	}
 
-	if (ndev->peer_spad_reg_bar) {
-		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
+	if (ndev->barno_map[BAR_PEER_SPAD] != ndev->barno_map[BAR_CONFIG]) {
+		ndev->peer_spad_reg = pci_iomap(pdev,
+						ndev->barno_map[BAR_PEER_SPAD], 0);
 		if (!ndev->peer_spad_reg) {
 			ret = -EIO;
 			goto err_pci_regions;
@@ -614,7 +624,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
 	}
 
-	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
+	ndev->db_reg = pci_iomap(pdev, ndev->barno_map[BAR_DB], 0);
 	if (!ndev->db_reg) {
 		ret = -EIO;
 		goto err_pci_regions;
@@ -659,12 +669,7 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 static int ntb_epf_pci_probe(struct pci_dev *pdev,
 			     const struct pci_device_id *id)
 {
-	enum pci_barno peer_spad_reg_bar = BAR_1;
-	enum pci_barno ctrl_reg_bar = BAR_0;
-	enum pci_barno db_reg_bar = BAR_2;
-	enum pci_barno mw_bar = BAR_2;
 	struct device *dev = &pdev->dev;
-	struct ntb_epf_data *data;
 	struct ntb_epf_dev *ndev;
 	int ret;
 
@@ -675,18 +680,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	if (!ndev)
 		return -ENOMEM;
 
-	data = (struct ntb_epf_data *)id->driver_data;
-	if (data) {
-		peer_spad_reg_bar = data->peer_spad_reg_bar;
-		ctrl_reg_bar = data->ctrl_reg_bar;
-		db_reg_bar = data->db_reg_bar;
-		mw_bar = data->mw_bar;
-	}
+	ndev->barno_map = (const enum pci_barno *)id->driver_data;
+	if (!ndev->barno_map)
+		return -EINVAL;
 
-	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
-	ndev->ctrl_reg_bar = ctrl_reg_bar;
-	ndev->db_reg_bar = db_reg_bar;
-	ndev->mw_bar = mw_bar;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
@@ -730,30 +727,36 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	ntb_epf_deinit_pci(ndev);
 }
 
-static const struct ntb_epf_data j721e_data = {
-	.ctrl_reg_bar = BAR_0,
-	.peer_spad_reg_bar = BAR_1,
-	.db_reg_bar = BAR_2,
-	.mw_bar = BAR_2,
+static const enum pci_barno j721e_map[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_1,
+	[BAR_DB]	= BAR_2,
+	[BAR_MW1]	= BAR_2,
+	[BAR_MW2]	= BAR_3,
+	[BAR_MW3]	= BAR_4,
+	[BAR_MW4]	= BAR_5
 };
 
-static const struct ntb_epf_data mx8_data = {
-	.ctrl_reg_bar = BAR_0,
-	.peer_spad_reg_bar = BAR_0,
-	.db_reg_bar = BAR_2,
-	.mw_bar = BAR_4,
+static const enum pci_barno mx8_map[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_0,
+	[BAR_DB]	= BAR_2,
+	[BAR_MW1]	= BAR_4,
+	[BAR_MW2]	= BAR_5,
+	[BAR_MW3]	= NO_BAR,
+	[BAR_MW4]	= NO_BAR
 };
 
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)&j721e_data,
+		.driver_data = (kernel_ulong_t)j721e_map,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)&mx8_data,
+		.driver_data = (kernel_ulong_t)mx8_map,
 	},
 	{ },
 };

-- 
2.47.2

