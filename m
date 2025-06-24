Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 892A42E1727
	for <ntb@lists.linux.dev>; Tue, 24 Jun 2025 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750781190; cv=none; b=ejzZ2ZtByppZWjza7MlwOce7lzQcD2uhq/VSH87ghs6cXqyrtW90zzKbZGl1FQpQ35Bbr8QmOSPKUL4GpswpER+e+zYBiJqwbLipcgHcMeQV93m4SfEne77rzUDGgJTlpEaA5CYwFPwrj70TWaZdeInLEy1SRP2OOtqNHLBPGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750781190; c=relaxed/simple;
	bh=9PcNes5B6piaX5VkQSR5V6Qj9BTL+m3+0ajl77HS/74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZZJxIIQZzIh37XXZnyJOchfzi2KW4QoCnn5opYgO4Ij+b647f7KR2xifZ3wW9NREpm532dgPTqV4rzbtV/vPPe/tiHp/itAyFu89wRo0iEXOLdTEoXsONJORfty1wiy22ABTv3/yhgjEpKd/5+3ZDUL2XvRACxWzR/1PkBGLTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=edbfWXw3; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="edbfWXw3"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-453608ed113so49135875e9.0
        for <ntb@lists.linux.dev>; Tue, 24 Jun 2025 09:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750781185; x=1751385985; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h88eiLfYYU1OgQWMhdV6nMQpvNno7CSmnesz09wYA/k=;
        b=edbfWXw3FuietS1DR4x13GFyTlJxERmsL7Lj4z+L7z6HnPNaRSXyhWyovS6SOzj4hP
         fb5Be5IDugxVUSop+7y2HsY8ETIbZ1nzqShHMOvN/U9bLfO4zofPGOXL3b4H+wG9EH9h
         QyAcqJnjvLAtajiAMppGkr0ipm92P7kuaC/2PG1ePYcwJ1ZE+EOGVvFlNsrSI5cT+IaA
         1mBVt7JJQaDW9AW9F0iTZ+Pca+PEpqp5l1AcwX11YEmFTD7ergYZfHSmNRut3tK33BSv
         Uc3NPmEVohOPvxgzFRAO+UwZzBMAl9gRAhig6mK78F3cF1IVUfsX1AJcx8pRqKRK5nDU
         RzOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750781185; x=1751385985;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h88eiLfYYU1OgQWMhdV6nMQpvNno7CSmnesz09wYA/k=;
        b=TU7hk8/QB4+J/UdcrylUUXjtH702uww/cjZTU9CcESGrLfI7v1AgO0v0cB6sSnhJlV
         2v9cU0Tkrb7WCJHrtnzQB4jfIRKcJqnL6sB7cOb+KiRrVFnO7SpNRFRnLvrqPlJ4sMpj
         5GrGf3qrikFcAZXXhR4KMlDCgzJyeasQ3+nCHx3WBrD6EcPlY9z/YqOtALUCHNnqPuHj
         uy0z2TIrl7q46okSVYv2nbmiSs0hz3oGhZ3hnnBabkJh335wz1/s3ZYsdwmK5oHpTPbb
         VgPm4ScWcIonPYj4N/r85ma/1YqSqEMrLLL4CTDillfuvhkt5Why3MIfgEOQCDA9sMFd
         bX9A==
X-Gm-Message-State: AOJu0Yxs5RBe1EsYUaclJq60Q6CeqIba+O+VTNSDJoqGs9Q0u+8Q3iry
	v1Zx6UywfjHZ9+A0eBrRYM5SCxCGptIEPx0/HoiBHXVGAvxnum0cQEhMTlF+FeMH1xKnBb57Zib
	3QvGa
X-Gm-Gg: ASbGnctY9mhT351fvVQIUhr8W/TwFHZBLolrvmt8Msmo72hggP0zh7EGFKddpsvvJzJ
	wxW7UW+wYxcm1q6E6/O1k/+MhUwofPATNwenysToWT8jUPDnf1ille0oOld6BkIJ8hShYQZn+0l
	2K9oyjS6AOMvkgsP2NIZwRGWlAOTEcmTHTlNfDzh7hc3P9TnBISlDEnpcCwvMtIvMozrXSqRfCz
	TET3B454qMko87WS4M82f0Qxo6aWcIP8s6xlbcpabhV5nk4rgjAoYuFF4ysqQW7doCJPdYDqfTD
	810KZy01O3BMj6wXaz6DVOhOD1T5d49lybrACKP4SZ67EpQtnrATjd7prWCnjII/oBbV+YSX9sp
	V+IOcMDfujLE=
X-Google-Smtp-Source: AGHT+IGqKYF+M9/TfVbGoU6jqLL7+tFSEQLGret6uxHsQFr3zQmjAEeKmdhCiDxYysWGgPtd1Vrxww==
X-Received: by 2002:a05:600c:6206:b0:453:dbe:7574 with SMTP id 5b1f17b1804b1-453659caa7dmr157817775e9.12.1750781184727;
        Tue, 24 Jun 2025 09:06:24 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:9dad:c694:2b52:ea7d])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-453646cb64csm151933805e9.4.2025.06.24.09.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Jun 2025 09:06:24 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 24 Jun 2025 18:06:16 +0200
Subject: [PATCH v2 1/2] NTB: epf: Allow arbitrary BAR mapping
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-ntb-rcar-support-v2-1-8c0e5cf69c4d@baylibre.com>
References: <20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com>
In-Reply-To: <20250624-ntb-rcar-support-v2-0-8c0e5cf69c4d@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>
Cc: ntb@lists.linux.dev, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7159; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=9PcNes5B6piaX5VkQSR5V6Qj9BTL+m3+0ajl77HS/74=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoWsz9SH3HrLSnat521IBToyZ0P3IO1IPCrPgWB
 tmt+5d07DeJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaFrM/QAKCRDm/A8cN/La
 henuD/9LUxgtf06zkB4YtbxzCJ0bDp+Myofe2zygpJuPK2Ho1b8CgMloN4NA8ydK/E6yRLAw/ZD
 6xB89kSpDUMElDnHB77CZjY6/S4taSBjG6dG4jUGzntNFU/gmIReQS+jRrJTidcTQWLj/YA4fKy
 uzUYM5jF8oHfUXcJjNaQJjAN5ebt5fo8wKcl/VwX8S+2zrR95mI+It8rdTSbyC7lsZOss9g48xu
 586/K83nvBxucTNvxlZ+qqK3R9edezCrXs2qcQ+4ujbOgVWeWk/ngIlhc87KTtdRKRu3kVKnv/M
 Ev7s3BIpU/Cj9aL06qpvukaZM0NHXdKNFS3np/l/fqw2w3fBWI1ou5lhTANw+DSpJOP49OFSmag
 xCiblr2vfrdWQb1AC9qmK/iJ9o4t52oimM/CwQjlB9koltZngOyTavyTcQOadFEdriNhKIVcgcn
 5cdCsKVWJsX85YxQfGFLDbVjEbb2c6qVBzHLBpTANt4hyVd6YGyAtcxPdO420juFLeVFwybE/SQ
 tSYj1gkw6A7Fbr14UGkjD9w3DNVjL9bUVUzX2AkqJiv9EoXFL60JNgr68BI7+TIfKuU9RmBURJ4
 7DcibnpBrOeSVTf7sFVVY56R/+NeN7PKWTcqA6NUZeksjk6Pwc82dPPkhaz1ob3IedTJVcGvSyW
 TpZqOiWeLkRXTDg==
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
 drivers/ntb/hw/epf/ntb_hw_epf.c | 105 +++++++++++++++++++++-------------------
 1 file changed, 54 insertions(+), 51 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..e8eb3adc6cecd2d52235a3f0b6b5a59ec58f1d73 100644
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
@@ -557,8 +561,13 @@ static int ntb_epf_init_dev(struct ntb_epf_dev *ndev)
 	}
 
 	ndev->db_valid_mask = BIT_ULL(ndev->db_count) - 1;
-	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
 	ndev->spad_count = readl(ndev->ctrl_reg + NTB_EPF_SPAD_COUNT);
+	ndev->mw_count = readl(ndev->ctrl_reg + NTB_EPF_MW_COUNT);
+
+	if (ndev->mw_count > NTB_EPF_MAX_MW_COUNT) {
+		dev_err(dev, "Unsupported MW count: %u\n", ndev->mw_count);
+		return -EINVAL;
+	}
 
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

