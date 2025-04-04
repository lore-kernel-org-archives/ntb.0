Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69145214230
	for <ntb@lists.linux.dev>; Fri,  4 Apr 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788798; cv=none; b=msa3N7nu1/5RM21pn6bu+T/zQx0KGDD3wukIhkm65fDdd6/XUeF8XatjGyO8wY90E/QrB3PevaWw0MtdMycfMlOtNVh+JFam2oMrAXLE0RHZpYkS72xiHSBOPpsdl1lBKNfoDgUinOhWIIvfSv6WhIZu3d6uSWKtZyDcPw5aXPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788798; c=relaxed/simple;
	bh=4uieBqT7gmN5Utt0O/2pT4/9I2ULrrNvfRrwQOFLCm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uWAeA4GlkbPozgBX0A9u4v4rVmZWPJMlceFfOWQCVdUKX3I9CjGDkr8BGoUEeDOrSn5PO4j9/cTCWWF5XAhYLiX/pScnZz+eepKdvhhqOlUpcXozLov2uhvUkISbyNxO+fUSHn2T1l2sugtlmourZFd+xXiQZr8639YVh0rpoBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=a5sTcPLB; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="a5sTcPLB"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-39bf44be22fso1640892f8f.0
        for <ntb@lists.linux.dev>; Fri, 04 Apr 2025 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788794; x=1744393594; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=60FugxO6v0YRFtzoey5lDeif30RhYzbYmC0Dvosg4Ck=;
        b=a5sTcPLBj6aEfQeSE1x9vw6CcCT42uf2bDVCqET/PDz5fvTEaKiAKc/St5lPvc/S53
         ySVNueGT0xdH8nzVhjFpXCQzUMkrZo/QQV2fw/gGICwi+ENNV9D9/EwC3OMKzKFS1SJm
         2rYYwHpsbiAoYkvUiR/I6XT5a7YLy7aDOo5l9qgxPI3Z8G81ykfLbTi0Ka66rkr4HdxU
         4v7ZK43ykEtQyutoZT3k3HunvbX0Or4j02/KjmgDbFLl/pbHfu61uxz9F+1FzB2p3S0t
         i/IpK0fr9uq4T0Yu9b69roDkBMAclp97iqJiaFam3TnKOQFAjJANPEYJFPdhQI8+agtu
         b/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788794; x=1744393594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60FugxO6v0YRFtzoey5lDeif30RhYzbYmC0Dvosg4Ck=;
        b=EtykJluhquHMzAwwY6LwMdmiAaTv8OKz7fA08YPpLToBYV3JdfMUL/HedavevwxM2o
         3selAXW+tgpLnUS/bhv5lfZQxp0iE70fpCzm9q/vizSICgDnUw9OFORjqOD3m60BorIy
         HIQuFF+WuDoA3Z8LFITChSlU11dQvaMDDnEd2RuFn4TvVCCSfgr6X56t1LeMxqNX/nG/
         lvvspTScD25CUC2/j3I1/cXqC/JrvDDmOjwayNJMauYuGXBhd1q6x6qy/CI3MatZzzqp
         xHXfBqZsK5bilEfgaIU6lSuQXdPDv+Jg4tQR04kR1Y666HWOaV5UDEzO3epq07C7z7Ku
         ae+w==
X-Forwarded-Encrypted: i=1; AJvYcCXdnH/av1H8cZvmuKjB0nDuLESdo2GP7k74odJJyJ3Gp9iLq/RY0Ski/piH978kawDFneM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzIaixrL3JZlkkt/hswlXppzaygiPGJDpLesZ+9h0vjag+MxE0E
	IyjggmoK2LGe/xtVU3g3ms6WY4utrHRPxAJCa0+ZsZmSnykT+KP8aJFqe6p4jaA=
X-Gm-Gg: ASbGncu7tTtcZxb6HbmfPh7FFBFizeaExy5mz+O3Xvop5fyyI1W4A5nV/3ZWn1KOOHM
	v6mm8WapikUZDD3bQ5naKR23e63GOLHBj+IO7P/zDMSCJ3wmYhatu4eo0tOfqXRU4EkKuGq83Hp
	UMpx/YImlW5Ppr5cY+RfrGtidLo0hPrAEiyoye7aIFbUkTAWHjz5b5BZqdngCLfccmqATTMeaRD
	I5NXob7kJyM1+uGxvdIKX13QUDjDHKdq21749WssOyyWpXLZobVGuFdpKCmXCPBhvr5sR/XxBFH
	V9y3KvBZes2rwoxjd/LLOVuXa3z0+L4Jzk+f6QD4z3S6DDoXwVcRhV8zkw==
X-Google-Smtp-Source: AGHT+IFceB1324JoXOWMIqxbwKQDL3IqddpAqcTL7wFdsVu4aneHN/xUo6VXTYzYA5DUcd8e7Y74kQ==
X-Received: by 2002:a5d:5f8a:0:b0:399:7f2b:8531 with SMTP id ffacd0b85a97d-39d6fce113emr185504f8f.38.1743788793428;
        Fri, 04 Apr 2025 10:46:33 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:33 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 04 Apr 2025 19:46:20 +0200
Subject: [PATCH v2 1/3] PCI: endpoint: add epc_feature argument for
 pci_epf_free_space()
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pci-ep-size-alignment-v2-1-c3a0db4cfc57@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=5399; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=4uieBqT7gmN5Utt0O/2pT4/9I2ULrrNvfRrwQOFLCm4=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br1Q6kEuYoAQE/bmEcnQHkFE2CYtfsAuAcca
 fK2YBNaIfKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9QAKCRDm/A8cN/La
 hYt9EACfZPJwbj3KH7gUvv+4V+47BZs/0lx6Idi+Pq0fdQy+NK0N16UVt3VfRIAeTxI9GAx99d9
 dbZ0NR9HrfWiM31VeFXKUDGmT610XOmyc6uyR01lERr+6ubO09bNNf/k+6AT5i1wxDSS/jNAXCj
 Jc6ZsCfNNCzLjNpmTsb6HJx6WraeKMQTYmDx85FwC4ylh1tmw9Gsmfc8USnKvJAT0qeUcqLCDaf
 MIX8rm3pHX+94ugr2aNKNmRRhMnYXMJGkk8uzGVBdKgUt1pnz+VGjnsZKlVYcZj4iaQGLcrs7V6
 aMVzJYhC+4JU1xhcSQTmHV4wZtf8UG4VR4NBNLJzJtvrdsyVMEm8WiDZvbABWygjh5sfKiHNhyZ
 Ah61cPG6xTfQvVC223MopGaXlaRTomeCr4asErOFDzedE2IMyIIlG2Kt7Lqe2u3dCNgOb6lUZaD
 ghUUXbmqJTGYiGzlOHaH6Wy3hhwwz3GSQS1TlHmAnDe3LaXxaM7gMqgekdUUbcQIVdqUJqZFnoL
 E6tKOYSn15e5XWs6wCtVDt+gxgCxixkB3CQPY8FLI5c0BeLIjAHPRKXavNEShvKtzg0XgfP6T3O
 GgeQck/qdD3auhtDM+mYZkB8unVYkPt0tBBlY96abvrHCxhBsdKc3Jkzje4vlw4gzhGcE+jCqyN
 0GBxYDbFx6Wm4cA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

Add epc_feature argument for pci_epf_free_space(), same as
pci_epf_alloc_space(). Doing so will allow to better handle
the iATU alignment requirements.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/functions/pci-epf-ntb.c  |  3 ++-
 drivers/pci/endpoint/functions/pci-epf-test.c |  2 ++
 drivers/pci/endpoint/functions/pci-epf-vntb.c | 16 +++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           |  2 ++
 include/linux/pci-epf.h                       |  1 +
 5 files changed, 20 insertions(+), 4 deletions(-)

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

