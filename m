Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800951A3172
	for <ntb@lists.linux.dev>; Tue,  3 Jun 2025 17:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748970248; cv=none; b=rargKTS915Akuz865hOKKucDQkvlI+ZcYl1nIIsFPDEArXLz5VwN9GBjwazVVFD0O3F8fBssx/MTAjdqssxEfFAhJ5E3AM2SFfN1wspsn8iR19l25nrRU3bkyhteCdkrdxsAggk7rxcQwfUZ2zlAlkwyitEzh+jQctknukkDmWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748970248; c=relaxed/simple;
	bh=o5elYaZvS8wbMI7TEu2FQ0/cKa3utfUsILwG/lu1jg0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nej1qqZcrpQNEHC87P+cXjkMRIk582qzuGl/POyaN0HYP0Ta9+h3/s4WMlggLOzWRDrF8xCEF5L4EUomKTg1Z5amsz7tTkrbPevKG4KJ5d2Hz+lwzVMilZ+sTcfF2o6kJiKQxgcjBzhUx8r3fIpA9uq8DZLw37h3o61261673Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2ugndUiU; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2ugndUiU"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-450ccda1a6eso53527375e9.2
        for <ntb@lists.linux.dev>; Tue, 03 Jun 2025 10:04:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1748970245; x=1749575045; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/M2rtMrLUp1znoFQ7fmm+p8Omluvozwl8sFwFwa3e+U=;
        b=2ugndUiUC5HurteASzDRsIEm+DZDJqXbb//W0K+Pw0T9Z008ycskj9HG4nJVIEyP7Z
         Pm0nlZyMNzrO4gjTFdPas+JdnSxrHjkmcdHvJgqY/at01rZuKvb1BfQyvYg/aBfKcMWh
         PkBLon1v01VjZMl0/+DkurU3qaSwkkurQzPcYBECQ64kfhRJ52Nk+Xvp7BclH3Q1z7LQ
         8qqzhm/140tPCkJX6atRWmlx0gysaQdgzLTdaL3NPbT/oE/jLyqJf88uQwsVxONqO5wP
         y5t8C43K2/9aQsRxrLIixa+jIOIh8dmytqVqp+RxVT/OjelfRTk2eoOaStKCy88H4aph
         f2wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748970245; x=1749575045;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/M2rtMrLUp1znoFQ7fmm+p8Omluvozwl8sFwFwa3e+U=;
        b=vJA0zQAP3nqKxl9iEhvhW1EceiTEXf84DybIPILE0LAsIM6cU6Z6bkntts57B9RC6S
         F3wbHfHDLKUW0g6RCvAPiWFms7xUSminsaWNihpvQY5fFou8EIa/lHL6Q9pc/voZmpB0
         0kBBrmad842uv7QoPNFuV6jLLV3ZVaMnW609h/S52Bx7oUNgdEvqv5Qa1OVLMw7ydns/
         X5tLMWeTce2NqOb7s2Me8il1RC0+LndB8Ubj7YeIpgACR5jiB0Eg+4WKaeOmDgYXBGdH
         1bMDmys+YgeLSoa1UmuHu6uihhoYq+pPgNOeNPuLSdE9Hd+FJPiaJdfNmeyvmOv9DMb4
         YPgw==
X-Gm-Message-State: AOJu0YwDHigCyWNU7L1WlmnRfJWlgoWCvRgI1j56q1g2S5w/UNGon4p8
	3578nWpsCZTj9S48jFw8i+1kxH51JhPhK7td6iFXWF7SDcOM47am6iVmaIinL5Bp3GQ=
X-Gm-Gg: ASbGnct1tlpy1ey7vHFKAbbHHeQZc58BQCmPTgQqm4gNMBSSXgyKfXoKSWrqRO6KqWX
	E3N8rZnPX2m0C8xrwq0GHJGoHphVGngdQLdi6KMhki7rCGK351Z5KmsdKeDlP7E4CHcJNF4E8P9
	SXFv+RMHia2YMM5L5rrcWmXZzfVc5EACfpEY1ajxV3FH4dKvIWOpa+l05Fo8/XluDYIzlI8ZoGT
	r3bqTQ8tYvP/f9MXq/r3W5sz+7wdUaStZf3RMSwsheJ54ZUTEyhk8EKB7wlNtFUQbTFvmKSF1Xe
	hZpRon0p2pUpQXqYtrB33kJu+ceBzemENAnEFW+FPTmudaiFvWDmryKnSuz2+pA4txrf8+YyVWp
	3
X-Google-Smtp-Source: AGHT+IEoenzqKEQuINiY64yrGWyrdaVaIcGaeVKG2UkL9DTmm9pcDBekWoRxeOOfpXVr7/oDe0au6A==
X-Received: by 2002:a05:600c:a51:b0:442:f485:6fa4 with SMTP id 5b1f17b1804b1-450d8871448mr182944585e9.31.1748970244569;
        Tue, 03 Jun 2025 10:04:04 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:ce70:8503:aea6:a8ed])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a4f00972f3sm19165796f8f.69.2025.06.03.10.04.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jun 2025 10:04:04 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 03 Jun 2025 19:03:39 +0200
Subject: [PATCH v2 2/3] PCI: endpoint: pci-epf-vntb: Align mw naming with
 config names
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-pci-vntb-bar-mapping-v2-2-fc685a22ad28@baylibre.com>
References: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
In-Reply-To: <20250603-pci-vntb-bar-mapping-v2-0-fc685a22ad28@baylibre.com>
To: Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>, 
 Allen Hubbe <allenbh@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Frank Li <Frank.Li@nxp.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>
Cc: ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2559; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=o5elYaZvS8wbMI7TEu2FQ0/cKa3utfUsILwG/lu1jg0=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoPysAmNdY3L3Sx78z2vvbh/WQc4IMEoBC/bPXW
 vk8+PspXkWJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaD8rAAAKCRDm/A8cN/La
 hV3NEACTtimKhQfTMZzspVbi0CI9sKwDERzuHOBEmAytqOAZDm1Uqm0X1ykPRJvmL0ig6Dd8ZPB
 k4rNVU/qpXnb9vcNmFPad/DVPVxGZvEpM5s3gw6TkngFr88EfBGXbokRrgb8f+0i2QcgvAc9ZiS
 iiQJprUFLNaS4xIKb0ch/bvs+mL4xK9duMp0d69RJaXFTwKYnsXIqYnETZPE5a1niYAa8qBaKe4
 0+K/k8pfUjrvk5Ui0YFt2+dI1qPwUB0KGo2N5GVqWCCR+eyhs/B8rRJO5qUUZ1iRfB0g5LkRHiC
 Xl5AKisqFutIcv7GSp/r8XCC4sLCc5CUw5jOurQjg+lCavWWA/Lv3ueGCfMGvvxzeeCd5IK1/NM
 WhhVtg0fOE1Gz+uTayQ/cjvmYnYtnbUoWwdzDH0iXdRzEZb+Y3NBkaze12zuL8SL8UC6w2sUDFr
 oRTXZCVBFOvadQ4gngpM9qkHMVAdXLYCQRVKbhDLop7HhAxzj2DxaLg/QbHkvr4IsKC17ywYJrk
 nkDPZ20bLnF4/dCnVhTHzg61vTS7MVx5uiuKehGAQzbsCMHVz4VbWBK6Mw2iV8tWeu0NLwC03aL
 UsLC2aLVVzuZ5ovOo3StWw4n0qP4IMl5ha2fDWPvIVVyUdc2ZAiELx8l3VUBSDSdxZpu28xJeVu
 qTIIajQwq7fR6Tw==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

The config file related to the memory windows start the numbering of
the MW from 1. The other NTB function does the same, yet the enumeration
defining the BARs of the vNTB function starts numbering the MW from 0.

Both numbering are fine I suppose but mixing the two is a bit confusing.
The configfs file being the interface with userspace, lets keep that stable
and consistently start the numbering of the MW from 1.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 35fa0a21fc91100a5539bff775e7ebc25e1fb9c1..2198282a80a40774047502a37f0288ca396bdb0e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -70,9 +70,9 @@ static struct workqueue_struct *kpcintb_workqueue;
 enum epf_ntb_bar {
 	BAR_CONFIG,
 	BAR_DB,
-	BAR_MW0,
 	BAR_MW1,
 	BAR_MW2,
+	BAR_MW3,
 };
 
 /*
@@ -576,7 +576,7 @@ static int epf_ntb_mw_bar_init(struct epf_ntb *ntb)
 
 	for (i = 0; i < ntb->num_mws; i++) {
 		size = ntb->mws_size[i];
-		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 
 		ntb->epf->bar[barno].barno = barno;
 		ntb->epf->bar[barno].size = size;
@@ -629,7 +629,7 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws)
 	int i;
 
 	for (i = 0; i < num_mws; i++) {
-		barno = ntb->epf_ntb_bar[BAR_MW0 + i];
+		barno = ntb->epf_ntb_bar[BAR_MW1 + i];
 		pci_epc_clear_bar(ntb->epf->epc,
 				  ntb->epf->func_no,
 				  ntb->epf->vfunc_no,
@@ -676,7 +676,7 @@ static int epf_ntb_init_epc_bar(struct epf_ntb *ntb)
 	epc_features = pci_epc_get_features(ntb->epf->epc, ntb->epf->func_no, ntb->epf->vfunc_no);
 
 	/* These are required BARs which are mandatory for NTB functionality */
-	for (bar = BAR_CONFIG; bar <= BAR_MW0; bar++, barno++) {
+	for (bar = BAR_CONFIG; bar <= BAR_MW1; bar++, barno++) {
 		barno = pci_epc_get_next_free_bar(epc_features, barno);
 		if (barno < 0) {
 			dev_err(dev, "Fail to get NTB function BAR\n");
@@ -1048,7 +1048,7 @@ static int vntb_epf_mw_set_trans(struct ntb_dev *ndev, int pidx, int idx,
 	struct device *dev;
 
 	dev = &ntb->ntb.dev;
-	barno = ntb->epf_ntb_bar[BAR_MW0 + idx];
+	barno = ntb->epf_ntb_bar[BAR_MW1 + idx];
 	epf_bar = &ntb->epf->bar[barno];
 	epf_bar->phys_addr = addr;
 	epf_bar->barno = barno;

-- 
2.47.2

