Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C95826E16F
	for <ntb@lists.linux.dev>; Mon,  5 May 2025 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746466933; cv=none; b=MV8l00lRjJdUgm49Ojbk2p91+kVVkxYkf2rjf5LDqJN2KxKDtsIUeQduEUdoYJMYjn9dhz3laqXXngN5RY4LReDzlWzNaaHkbj+8Efd3vGULhzc2EkWqGG3xfAzytuu/vcaohURql+JRSy8X9W2I0dI2DPTGGTWEfhRiLk+9oxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746466933; c=relaxed/simple;
	bh=B+qwCUY3eq14vw47Zfe4vuilfWwGDTVLmI1jZLIuLsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GQ+bVvGs/aMW6o3kznpPnwl/JRYb/P5fwLG39F6bN/cOwQiZL7kypLCbj5n85Z9ymqDXBg9f9FGjRD/JdqOrPbpVk0DFS6XH0HDuEm7LJ+01PCqng6OI7gPHAif/46fyQgyxNdGP/lH7GwBsddiump+J9BSVp1812b/M06R0KdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ogSvJiFf; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ogSvJiFf"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39c0e0bc733so4510746f8f.1
        for <ntb@lists.linux.dev>; Mon, 05 May 2025 10:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746466928; x=1747071728; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vGqWxZm/m2TQpVxIBgE41j6Cssz2HeDjBc3cPlm+w3E=;
        b=ogSvJiFf6BX4yUvzqWsuWZemprFF86MIGbInXjqHK1C/qAZpT3/osOhKc6kuVzCICq
         X4e3Vd6gQwC5Z+af2+STbrkiTvyOe7Awlh/nHnCjWCwxWdUAOobXH35SorHqVUC5jjlQ
         K3M/vnDZgkx4AMnc289SHMxTujjMGMfn7vK/xaTUrIP6+37P0RbRRmpOtTvKAT3QyuaH
         foUMr01dbCiDtKIIeMEM+Mc9a8L+9U3yv4qJ3B6/tgQv++DD1hgQCY+51HlbUkZwDakX
         ORMsz/lo86dYKvPjl5KdeChX8067Xm54ZxcyWrAA3nyLkHLf4oUuki/szSlQ29wrkC+n
         Wu6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746466928; x=1747071728;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vGqWxZm/m2TQpVxIBgE41j6Cssz2HeDjBc3cPlm+w3E=;
        b=kBbr2i4D8qcykJXCr+fD196sz2WHbk417ieXboGwdHmtmiRZlrvylMabSycu/HDCHd
         3RhtiKr+VdyYR9qy9NksO+SRL80ZJDEvxSXITrgaCk8sKjirOu8tHcqzjYzUY97fmWJH
         9X0IjPSRaUordz5NOKJ2x4bxnzB+mqCIbTnpifq+DblwiZQcaICWQHl87SIWmJkvUEZV
         2yIRCob/uHvBw3BM/VU0q7AQG2RDtXhBzUK/6EcUGAMvY/09RpYWhzBTAQgPT00/mcGI
         OkcH6w1Tfk9zf59EztEr2fAcuHU4x8XsxEdismSaT8KSiFQvmLrfBuixi1SGn/lElo3s
         vlXw==
X-Gm-Message-State: AOJu0Yw23khllaGyz9ybbHvgXt28Ceq7YIitxNg15WNSKkIjQei2DHFH
	ottMh9zs86zAyTq1PNI3QwnKN/w9p5ZBW3HKtH7CQiMTxDrwgKMyhdtUBmXpyOs=
X-Gm-Gg: ASbGncvdub2wxUe9dB7AFSWqcTCLq9Exws4/AVRg+a6lmIHTEwHbQ/XtaJvhUURki1l
	agM0ly0sM+n+TZOvxDhw5mk/5IUkIasxQyD0VDLvdA1Ey+CbQpQDdwLlKbVoMOmtyM49EC1g7Z+
	wUa///fHUNkRIJY+ZcppycmA7ZFtHX8b3WHv2gkl6tsUJc9jTyR2vDXoS03/waUxTp3UY6doHjf
	BCaJUaTvs3VDZfOfOPqlw7kyJzoXjT6Z2ukjgxP3GWx2YzV8PpuW/n5rmIDsyarbmdaUO/5twuM
	TZTNwzCUSTQSn2SE6oUr5c0pAPXV7exqybmV1XxDEjMyq0at6dr0/g==
X-Google-Smtp-Source: AGHT+IFO5ZOl3WbSVm06FVhgd/i3dra5ZvGLeZpLS1wCgTAqjLTG4sEOT/fzcnQ6TFzk2Xp7wmzK2w==
X-Received: by 2002:a05:6000:18ab:b0:391:3049:d58d with SMTP id ffacd0b85a97d-3a09fd11b24mr5996162f8f.0.1746466928504;
        Mon, 05 May 2025 10:42:08 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:dc81:e7a:3a49:7a3b])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a099b0efbfsm11345829f8f.69.2025.05.05.10.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 10:42:08 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 05 May 2025 19:41:50 +0200
Subject: [PATCH 4/4] NTB: epf: Allow arbitrary BAR mapping
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250505-pci-vntb-bar-mapping-v1-4-0e0d12b2fa71@baylibre.com>
References: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
In-Reply-To: <20250505-pci-vntb-bar-mapping-v1-0-0e0d12b2fa71@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=7212; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=B+qwCUY3eq14vw47Zfe4vuilfWwGDTVLmI1jZLIuLsY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoGPhr38FAeaNtY9Pmu/YdTa9ik8dKaILGYk8oq
 Xel3jbhWmqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaBj4awAKCRDm/A8cN/La
 hfhHD/90J4gK6A31RqSKPgeIQXRjUH9eyvbVh4A/PuFXF1XX4TQCotey6uRmw4Aplx3+5V3fatO
 b1V4nFxskxpg3nb+ECjODvnssQIIMBXB73EHUCL5/Vg+xbQ89xP5UkvZ86eggE5Z3TN0YuXKUhU
 v/o/us4hQNtIkjw3e3i1tYGr6z8M1ULHyZCjSc9WHm27iNhvYR4vo3I7Q3bkYKc6Qp0ZtF7RpkG
 FvXdjg6UO0LQeJ9TMKxwt08eF80IGAhYyFPhdBnyvNwecATg4JWnZcj9DVme2CerMivw41FWbyW
 gheWZHhL6P6RGmZqK/iGLdOyAuqJbKkPolo/k5/iXCYbiIXxRjIgLCF/D+5ROloKx5FetEOCMVg
 nlb8wbe3AqdI92LC+ynKxF5bwUyQMmjfvPmsGKXDSXffJ/+KrEXrJPyM0cAAY2FSb9m1UU4QVgr
 Ccv5clQm2PHESZCDmeNb7PW7d/KxLwRFxzKVXfzmSN6iOL3zQL9Xl7d9r6QobmFrJsKmam/p5kc
 JOWGylE38kUJUJoK9IqWp3+YfwE3sVyDBHDTExMe2HvV+RVFlKri6T6ZQslkq5AzVYsNeA9Nzcc
 RAjG3iWfl1v2jc7iVy2TNyGfz3J1LdAp/IjrUMj1oeKb0LF3oAF2NsLvjCoZ8du/6u70MF7QDFv
 M1jf4inORmEjvOg==
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
 drivers/ntb/hw/epf/ntb_hw_epf.c | 108 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 53 deletions(-)

diff --git a/drivers/ntb/hw/epf/ntb_hw_epf.c b/drivers/ntb/hw/epf/ntb_hw_epf.c
index 00f0e78f685bf7917b02dd8a52b5b35f68d5bb64..9539cdcd0f8fa4b5c5e66477672f8f97d5ec4e52 100644
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
+	const enum pci_barno *barno;
 
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
+	return ndev->barno[BAR_MW1 + idx];
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
@@ -596,14 +605,14 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		dev_warn(&pdev->dev, "Cannot DMA highmem\n");
 	}
 
-	ndev->ctrl_reg = pci_iomap(pdev, ndev->ctrl_reg_bar, 0);
+	ndev->ctrl_reg = pci_iomap(pdev, ndev->barno[BAR_CONFIG], 0);
 	if (!ndev->ctrl_reg) {
 		ret = -EIO;
 		goto err_pci_regions;
 	}
 
-	if (ndev->peer_spad_reg_bar) {
-		ndev->peer_spad_reg = pci_iomap(pdev, ndev->peer_spad_reg_bar, 0);
+	if (ndev->barno[BAR_PEER_SPAD] != ndev->barno[BAR_CONFIG]) {
+		ndev->peer_spad_reg = pci_iomap(pdev, ndev->barno[BAR_PEER_SPAD], 0);
 		if (!ndev->peer_spad_reg) {
 			ret = -EIO;
 			goto err_pci_regions;
@@ -614,7 +623,7 @@ static int ntb_epf_init_pci(struct ntb_epf_dev *ndev,
 		ndev->peer_spad_reg = ndev->ctrl_reg + spad_off  + spad_sz;
 	}
 
-	ndev->db_reg = pci_iomap(pdev, ndev->db_reg_bar, 0);
+	ndev->db_reg = pci_iomap(pdev, ndev->barno[BAR_DB], 0);
 	if (!ndev->db_reg) {
 		ret = -EIO;
 		goto err_pci_regions;
@@ -656,15 +665,20 @@ static void ntb_epf_cleanup_isr(struct ntb_epf_dev *ndev)
 	pci_free_irq_vectors(pdev);
 }
 
+static const enum pci_barno ntb_epf_default_barno[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_1,
+	[BAR_DB]	= BAR_2,
+	[BAR_MW1]	= BAR_2,
+	[BAR_MW2]	= BAR_3,
+	[BAR_MW3]	= BAR_4,
+	[BAR_MW4]	= BAR_5
+};
+
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
 
@@ -675,18 +689,10 @@ static int ntb_epf_pci_probe(struct pci_dev *pdev,
 	if (!ndev)
 		return -ENOMEM;
 
-	data = (struct ntb_epf_data *)id->driver_data;
-	if (data) {
-		peer_spad_reg_bar = data->peer_spad_reg_bar;
-		ctrl_reg_bar = data->ctrl_reg_bar;
-		db_reg_bar = data->db_reg_bar;
-		mw_bar = data->mw_bar;
-	}
+	ndev->barno = (const enum pci_barno *)id->driver_data;
+	if (!ndev->barno)
+		ndev->barno = ntb_epf_default_barno;
 
-	ndev->peer_spad_reg_bar = peer_spad_reg_bar;
-	ndev->ctrl_reg_bar = ctrl_reg_bar;
-	ndev->db_reg_bar = db_reg_bar;
-	ndev->mw_bar = mw_bar;
 	ndev->dev = dev;
 
 	ntb_epf_init_struct(ndev, pdev);
@@ -730,30 +736,26 @@ static void ntb_epf_pci_remove(struct pci_dev *pdev)
 	ntb_epf_deinit_pci(ndev);
 }
 
-static const struct ntb_epf_data j721e_data = {
-	.ctrl_reg_bar = BAR_0,
-	.peer_spad_reg_bar = BAR_1,
-	.db_reg_bar = BAR_2,
-	.mw_bar = BAR_2,
-};
-
-static const struct ntb_epf_data mx8_data = {
-	.ctrl_reg_bar = BAR_0,
-	.peer_spad_reg_bar = BAR_0,
-	.db_reg_bar = BAR_2,
-	.mw_bar = BAR_4,
+static const enum pci_barno mx8_barno[NTB_BAR_NUM] = {
+	[BAR_CONFIG]	= BAR_0,
+	[BAR_PEER_SPAD]	= BAR_0,
+	[BAR_DB]	= BAR_2,
+	[BAR_MW1]	= BAR_4,
+	[BAR_MW2]	= BAR_5,
+	[BAR_MW3]	= NO_BAR,
+	[BAR_MW4]	= NO_BAR,
 };
 
 static const struct pci_device_id ntb_epf_pci_tbl[] = {
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_J721E),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)&j721e_data,
+		.driver_data = (kernel_ulong_t)ntb_epf_default_barno,
 	},
 	{
 		PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x0809),
 		.class = PCI_CLASS_MEMORY_RAM << 8, .class_mask = 0xffff00,
-		.driver_data = (kernel_ulong_t)&mx8_data,
+		.driver_data = (kernel_ulong_t)mx8_barno,
 	},
 	{ },
 };

-- 
2.47.2

