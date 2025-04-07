Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2D61F8BBC
	for <ntb@lists.linux.dev>; Mon,  7 Apr 2025 14:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036771; cv=none; b=lytlXWZX06IhFWF5ZihGxRbFqzGfLyeXRRVQZH5bwPC/J5jYCRXQRnWTtclhbhGAfMn2qQUV0Kl4izQQYekaORWiFxqI9gmeL/tV2rzWFbUC/9+8BCKvWer5X5qQGT/5fen/eU5esWcOkCrDHMdx3eWmcp1AVn5ONesQBtiF/LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036771; c=relaxed/simple;
	bh=gpdenQ1KTwrhqtRAGsdUtxPDX/0ZTIXJDe/D+TKenF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HKjLiunk31/Nkvt2ns/9V7wOJPVRd++DcG7tFNrt0Y2OgDai/OSHJXhx8Q+yqnVrzKes+3OHyuTdNitdV7ErkUXz6DSYDGsiiVejviEz/3AUywsVKvJSZhn2LfNRhbONwE3HtAG84qhj+Hm0sih51fFO17QqHqf76lxsX1cv47A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=VDekrka3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="VDekrka3"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3995ff6b066so2403638f8f.3
        for <ntb@lists.linux.dev>; Mon, 07 Apr 2025 07:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1744036767; x=1744641567; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=;
        b=VDekrka3ch+EpnJG4UJoCjQM0ApgOcoWNoNP7h4DnMSP+1yOOT5HYM0Ue2ScjZVj/J
         Vp7JoGHr+s1rE2ncPgJ7/24zQQnWwHXAv/YhT1GowQs9apOvyKeQ/tE9yVyBcCFMtJTf
         g6jY+E5YdS0nQ0Ig0QyiHVB3BtTptVrjrVAAFa6bq9gHmPitEcN2MPQiXyNI4DbXLgJ9
         bHHFw9dRZnCEv16c2gsoIIBfYIipVTdd7jb3hQuFgLg6OrqnuZHKQ2MeEYYuWH6WNOl9
         ssI/KcxrRPKPXarnL+ooy1WABNdwTsXCzAP6JGHWqrWA+PmCsPxyeBMBM6dxUxxnx+aL
         nKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036767; x=1744641567;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CAkSoBab2mcjkSikNieA7Mms82PLhiuTw+xHOZIjvOM=;
        b=DZSMJbwUghvmNr866WpqRhlvJv9Jnhxo5lniEe8t/m04BdI2aZLqS80MM/Oc1pTgJr
         vXQpdkN+xJK+EE0lr1pm7zJcB2H1EpdRGcYRD2z5Ele9tdch30MyMtN7KPzD5p+ZvDx4
         HuAKBmNglMIhgTCT/RqyVI14knC/NzKKef5Hdp5b9M4C6qErb4HEJeyC9nlaWeBBDS2q
         Z1xgH8shu5ZWilj0XkoKDcmWiJLbK5glMb8ZUkpNkbcWwtAeitk1a3vM+q4KcOkV411V
         MdKPSGnWhsNMra0eL4xFvoeaRbjKB2/1YU4dcZXjF8IW2PUbgBpf/3zYkwsB91nlaNaA
         uByw==
X-Forwarded-Encrypted: i=1; AJvYcCU1Ivt1m9L/OdX6SwbllCkCsM6PTe6WsozVPG0E0Igy7E47avhDb1IrmkaeWPholcSUYiM=@lists.linux.dev
X-Gm-Message-State: AOJu0YwGvfQF/rjvtK5ZC1DOEt3Ev0FliJDJwu56WbCTTrKFBl5ci5XD
	L3NpSdF3BmQqH8aPK6pEgbnqQwmmUtm6LoAJfhSQFBi3lf8EKf6CNWqZy2hBg50=
X-Gm-Gg: ASbGncvJxtV+h9ZpQqw5TaR/Ajw+hbnFXYyF69PufKmiDnk3RJAzwY9Ek+4itw49tXN
	b+1TNcZpe6KJhwqQQH7vPae6p9vhL6IvZMMXPopRSvSqHzhliFmbFVh/nPHbExRcHb71Q+MqkjE
	Yx4+uyg9ug/oFOjBNqdB6ZQzpkwx639VVUwljKa0j5o3UJxhqofSyqDbNTJr6q2zeO8m+e+1XrA
	D4YwhfLNh0U3+rsMZ1cVBJS2HFzAl4hhe6D2x28IzEufi2Mm78x3ArO1NsYBHfBuwL8zG2hRVxB
	5hrbftDPrmD65XplcQdOMqxaJy0gI5V/nKSYxH1rV70kuADhOqPM3mLo0oQ=
X-Google-Smtp-Source: AGHT+IHYNuBw7pt0b3N9Uj+WvpJtruSG0l3vb5tTFAlq3DYP7AsQp5Q6OxMd7vtr6bLEUuW77X9vqQ==
X-Received: by 2002:a05:6000:2509:b0:390:d6ab:6c49 with SMTP id ffacd0b85a97d-39cb35b1a8cmr12446064f8f.35.1744036766921;
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:1122:cb29:d776:d906])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43ec16602bbsm135003705e9.9.2025.04.07.07.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 07:39:26 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Mon, 07 Apr 2025 16:39:07 +0200
Subject: [PATCH v3 1/3] PCI: endpoint: add epc_feature argument for
 pci_epf_free_space()
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250407-pci-ep-size-alignment-v3-1-865878e68cc8@baylibre.com>
References: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
In-Reply-To: <20250407-pci-ep-size-alignment-v3-0-865878e68cc8@baylibre.com>
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
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6049; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=gpdenQ1KTwrhqtRAGsdUtxPDX/0ZTIXJDe/D+TKenF4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8+OauAXNd7kCvh8ELhw9UoQ+j9kAT8RJ+NjMp
 oe5ssp0vg+JAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/PjmgAKCRDm/A8cN/La
 hX83D/sHZNFS59gQ+4tjHanyRU0075HG7FzCjsrOpcn4tmq1hn+jgn6dhWO8oxjMBDCbTextQIf
 XRhqEc8ne7LwhSCmO6VJffo+woIG1kNyvVmHcnUoacePg95tTePNuTrs9K2dLUe9JTvZwwJiKuc
 zvQCcBgslxS3wyCeZrO57mYiNHr5R/6kNvQ2G7t/to2FiXiQTduj+CVkiKvG+7JX/W7FA8C9MtU
 mj61PY4DqWpdNGt5ssMYq3mkwbLpEdWoOdgz/h9iLLqHyUeLv3So091p137zgvTx7BbPm2ePh0P
 QRfjqrhJFfkGb9453ayLp+zPjxUKwAkA653DtSQJTz6pp7FTYJnHYVWqjk/lM6cEci3zKZfgU2j
 p5BMXYjoL0kO5A6/nhlMm11Qatd1scLJloJBeYmShCQSaglvY9XXMSqtsI1Xe35rklbdDlL+a2M
 7yJSGuy/qDj1MhcMcX2lM0ac4KdD40GfPY5AcwzRhZCo2eNxIRAmn/s9g0DvK05fdaBxRtjHNxC
 ouUQ9p2HWbLG+c52gHmU5kfTqYipAZMdnsN1+i9UJVyADq9UGL4MRiL4KdwEn96dANHkP/ObHKU
 I4Wj+6VnOjKQQM2sun9xo8gAfcAW3nFfH9w7cCMkhAdraLlVc5tl87BfSr5Vm5UFBY6H4qpdAAF
 c3hpgbSWFd/jwTA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add epc_feature argument for pci_epf_free_space(), same as
pci_epf_alloc_space(). Doing so will allow to better handle
the iATU alignment requirements.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/nvme/target/pci-epf.c                 |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 16 +++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           |  2 ++
 include/linux/pci-epf.h                       |  1 +
 6 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 51c27b32248d0137fd3a557728eaab72fc7fca0c..2bbc41f8400837bcb83463b436598b16070e11f5 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -2174,7 +2174,8 @@ static void nvmet_pci_epf_free_bar(struct nvmet_pci_epf *nvme_epf)
 	if (!nvme_epf->reg_bar)
 		return;
 
-	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0, PRIMARY_INTERFACE);
+	pci_epf_free_space(epf, nvme_epf->reg_bar, BAR_0,
+			   nvme_epf->epc_features, PRIMARY_INTERFACE);
 	nvme_epf->reg_bar = NULL;
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-ntb.c b/drivers/pci/endpoint/functions/pci-epf-ntb.c
index e01a98e74d211174db3075c20457a3183f37e0a5..44775c41c10b90a56b1167f3f3869a60c686cf9e 100644
--- a/drivers/pci/endpoint/functions/pci-epf-ntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-ntb.c
@@ -957,7 +957,8 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 		ntb_epc = ntb->epc[type];
 		barno = ntb_epc->epf_ntb_bar[BAR_CONFIG];
 		if (ntb_epc->reg)
-			pci_epf_free_space(epf, ntb_epc->reg, barno, type);
+			pci_epf_free_space(epf, ntb_epc->reg, barno,
+					   ntb_epc->epc_features, type);
 	}
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 50eb4106369f41afa00ed3ae58c84922e0a49e51..8d5df47967226e1f02444e8d45f7aad1394afd04 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -740,6 +740,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
 				      &epf->bar[bar]);
 		if (ret) {
 			pci_epf_free_space(epf, epf_test->reg[bar], bar,
+					   epf_test->epc_features,
 					   PRIMARY_INTERFACE);
 			epf_test->reg[bar] = NULL;
 			dev_err(dev, "Failed to set BAR%d\n", bar);
@@ -941,6 +942,7 @@ static void pci_epf_test_free_space(struct pci_epf *epf)
 			continue;
 
 		pci_epf_free_space(epf, epf_test->reg[bar], bar,
+				   epf_test->epc_features,
 				   PRIMARY_INTERFACE);
 		epf_test->reg[bar] = NULL;
 	}
diff --git a/drivers/pci/endpoint/functions/pci-epf-vntb.c b/drivers/pci/endpoint/functions/pci-epf-vntb.c
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..8f59a5b9b7adec2c05eebae71c6a246bc5a8e88c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -389,10 +389,15 @@ static int epf_ntb_config_sspad_bar_set(struct epf_ntb *ntb)
  */
 static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
 {
+	const struct pci_epc_features *epc_features;
 	enum pci_barno barno;
 
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+
 	barno = ntb->epf_ntb_bar[BAR_CONFIG];
-	pci_epf_free_space(ntb->epf, ntb->reg, barno, 0);
+	pci_epf_free_space(ntb->epf, ntb->reg, barno, epc_features, 0);
 }
 
 /**
@@ -557,7 +562,7 @@ static int epf_ntb_db_bar_init(struct epf_ntb *ntb)
 	return ret;
 
 err_alloc_peer_mem:
-	pci_epf_free_space(ntb->epf, mw_addr, barno, 0);
+	pci_epf_free_space(ntb->epf, mw_addr, barno, epc_features, 0);
 	return -1;
 }
 
@@ -570,10 +575,15 @@ static void epf_ntb_mw_bar_clear(struct epf_ntb *ntb, int num_mws);
  */
 static void epf_ntb_db_bar_clear(struct epf_ntb *ntb)
 {
+	const struct pci_epc_features *epc_features;
 	enum pci_barno barno;
 
+	epc_features = pci_epc_get_features(ntb->epf->epc,
+					    ntb->epf->func_no,
+					    ntb->epf->vfunc_no);
+
 	barno = ntb->epf_ntb_bar[BAR_DB];
-	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, 0);
+	pci_epf_free_space(ntb->epf, ntb->epf_db, barno, epc_features, 0);
 	pci_epc_clear_bar(ntb->epf->epc,
 			  ntb->epf->func_no,
 			  ntb->epf->vfunc_no,
diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..b7deb0ee1760b23a24f49abf3baf53ea2f273476 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -213,11 +213,13 @@ EXPORT_SYMBOL_GPL(pci_epf_remove_vepf);
  * @epf: the EPF device from whom to free the memory
  * @addr: the virtual address of the PCI EPF register space
  * @bar: the BAR number corresponding to the register space
+ * @epc_features: the features provided by the EPC specific to this EPF
  * @type: Identifies if the allocated space is for primary EPC or secondary EPC
  *
  * Invoke to free the allocated PCI EPF register space.
  */
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			const struct pci_epc_features *epc_features,
 			enum pci_epc_interface_type type)
 {
 	struct device *dev;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..d2d1c60fd5e0487b25aad51fee1b30554f630557 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -222,6 +222,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  const struct pci_epc_features *epc_features,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
+			const struct pci_epc_features *epc_features,
 			enum pci_epc_interface_type type);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);

-- 
2.47.2

