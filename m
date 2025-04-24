Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33620C488
	for <ntb@lists.linux.dev>; Thu, 24 Apr 2025 08:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745483668; cv=none; b=n3VKleJsWnoDSMxGjn5qLLJOUUmu6TFXTRLQKJWlrfS/h7OM2iRonXFpbCqXtbmBcaiT9doMlSRnKCxZaIGdkR1LyqsSByHKFMlqHThbjx+2BD4/Ngmn6PWakIMe4H7SNOXnL5/JiuD/NSLGXm3GDDIHACIC6W9L4mj6bCAzzwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745483668; c=relaxed/simple;
	bh=K1O/ZXnuPZvlJKjkZceWhCJx16Ps0pz6fRC0LfxqGpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UnNNmz8NorA1yygaCi84lj+U8vkOeqhFsUqw0r4b0cyPFClQs+Npr0BOXRpU4wWpS1AuE0ogP/eRwb7umTOZFVhlTalKaDIIwuGtxZPVuJdprVdYTzJ72dw7qPnj26nxBivdmSDDWIfW9HaXKk4DWuCsX4l+RZ3Tkp2alS1RLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=I96IVPFM; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="I96IVPFM"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-39c266c1389so456735f8f.1
        for <ntb@lists.linux.dev>; Thu, 24 Apr 2025 01:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745483664; x=1746088464; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=;
        b=I96IVPFMQWwuP1dncFiZb9xEVIvApaRKu9w7H51OL+O1YY6mU8w9v58J9fBG4+JPuo
         Y6A002UkdmtTsFFw5gpJlKOBTjzYU5sZENVOWkmahG00/2gGYXVE6JLOY8UBoS6te4xX
         nBVLk/6ycEKrweu96PfXUGfGFuqLIEERrma8XARmzV2VOkAOvYd5JNHpikIqKrDt1dJW
         E7GeqoJDjAJEJP8+dK0ao29b35VIDKcZI9IHYaMDWeC+y18D7gTsS3THHYOuMsZqGzk4
         ipylrG+ECI64cjdUsjMGf9ejfSEPMN3pVZ0uKtahxRl3L+1Xok/9v48eHJFN/i4m8zfO
         AAMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745483664; x=1746088464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DTdAIP1mKg4CjTYlY4/zlF2CtboYkKhoA+PQ2jqYOBk=;
        b=EwIYIJEgXSjIL3uDLJymjVmW9qPWeentPIHTBBOYaAuVvXV4zNAGpgDTOrCu3wxDbm
         zoIBZVuW5ZjTongnHMdW4UXWk3pzwT3rwSk6Fu3KG3A0DfRSXOEUjKxOMBMcK3k2pCN7
         Ozh7XPs0qq7LzQM5fFWTdERikjN/YH8GCPYioR4FXDxBMwxIZM8qVGiIGB2mLoCO3Ryh
         Bi9W0LYI1w94SsrxLlucz5TZ+MG6x5RxoWy5crZDDRxNM0TbBhdU8WRimvs0nM5egOJg
         0axWOmjC5JQgapB/OJPopoGMuK4jAo1hVp9+gbamojDZUA5/0h6Q8OP2GklCD+AmM+bV
         nacQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFt/sZCKj8zNsl4Kebl76ld3tP4QGLXmIEzmbVLH/g2bpj/ci7lty6UtLGVacAJ8zqcro=@lists.linux.dev
X-Gm-Message-State: AOJu0Yz1eA9TRc3BggEWmsL2XPDSld5aqQ+VtFr2IsoDgrPQUwXpLkgp
	ebQvIxBiHXivtyDLggWoF3lNjnEBRwhbSqFMOmMcphiqblZJSRZAh1wFp2nWHlo=
X-Gm-Gg: ASbGncsflu4M9GeCw1Q6OHKjuGEsrvpraL0hAzG5Mch7xufudAFoB9tVJWs3mrS4gUb
	Ck13eEYE4wIXhqCqZhk9Nzr+Yn8R2w0QRResqyD8+esh88mbsZ5OtP+cQ0gWR9LHHQxh9SXSO+C
	jGea23RShMqglUTRgOWUISgR0kBHL7AgEHAVHl0XlYrBj749yhumYCbO5QUxI93VWREtZVo+z46
	9i6jqnIPnoYj+kGVkcX9Px8jh4j7Ma5se2mMdtxNglBB5v2IuLdz3w3gDcmkLbPk0hTIEHe1ZRy
	otoZfaZjpWjgfdhJVzF6ptDMJcspwhwRXESn1fUP90khQVg7phBwvA==
X-Google-Smtp-Source: AGHT+IHCyKzJ42aHroSUm8dSFe+zZZelO2D51+fPKE0kfSithPmCpekbPV1qFCzXw6Neqmf+66ygKw==
X-Received: by 2002:a05:6000:402a:b0:39a:ca40:7bfb with SMTP id ffacd0b85a97d-3a06cfc603cmr1159155f8f.54.1745483664218;
        Thu, 24 Apr 2025 01:34:24 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:f74:6a9a:365b:4453])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a06d4c6c56sm1323881f8f.60.2025.04.24.01.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Apr 2025 01:34:23 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 24 Apr 2025 10:34:04 +0200
Subject: [PATCH v5 1/2] PCI: endpoint: improve fixed_size bar handling when
 allocating space
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250424-pci-ep-size-alignment-v5-1-2d4ec2af23f5@baylibre.com>
References: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
In-Reply-To: <20250424-pci-ep-size-alignment-v5-0-2d4ec2af23f5@baylibre.com>
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
 linux-nvme@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>, 
 Niklas Cassel <cassel@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4296; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=K1O/ZXnuPZvlJKjkZceWhCJx16Ps0pz6fRC0LfxqGpc=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoCfeM6J6+pCgmEwgvc/aDPPGIR4Mg3nyBaNxNK
 M9t502XUfKJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAn3jAAKCRDm/A8cN/La
 hauFEACy9VCXN23DaPGmIJvmbM9qPENNPeRyGmzMlpjo9DyMfrnp/xORgiKYBJ/WDqk2ZCTuzb5
 LVUqVG9RH5jxpaeKqIrotYbDMNSlgLhWOuaBQP1T8a+JDJLM4rtQ/0lnJ8yZvdgRKogdt5WwE7+
 zmcccvWz6URwDuAoSOkmv1W0HGXru4wb25nksRsusTUX8d5ysjesdqnKgTraDayvGYPBuSVi2Oq
 ztUkpECUs/l+jC1EvmEqpzGo+VsHdjlCqVbSBJVp5jHPNAAihAuzmZMjTgpW3j/DJqHZ0+pu2We
 SEigB2bd8LKgw8zfgaHExZvR/KG/7I+Ifm+JNn8bLsi3Ed8WKC/MB/pmwZlnLHtoyyXMmiHkjnd
 lS2fcH+Oit21Z5RWOLEcwl6YB00c4HxgCOe0NtL1pomY/L2dcu+jBDMjEJl0yWtdARoNyeDlICw
 f9/m9I7PT9XtYDe+2/xoG7gzFS6FIq4scZJLRqkySW86rzOp6x48T/nPDbVHNmTScIw5nT/6SH3
 Zx/eGdmu+lte3XBuO9UoLGpgSJ/n71ZSROD3IO2/3RlCIKnWqcxALEnRrAGPGqq0m9NyCa4fgXJ
 f2QbU7wciMaErvjDakmZi/IYHo0aq03r4CrlEizF8oh0vB9ggQwsvDOeNLrqFXzP651wIhJNN6p
 42/4zS67gD2wWxg==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When trying to allocate space for an endpoint function on a BAR with a
fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
size. This is expected by pci_epc_set_bar().

However, if the fixed_size is smaller that the alignment, the size saved
in the 'struct pci_epf_bar' matches the alignment and it is a problem for
pci_epc_set_bar().

To solve this, continue to allocate space that match the iATU alignment
requirement, saving it as .aligned_size, then save the size that matches
what is present in the BAR.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 21 ++++++++++++++-------
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 394395c7f8decfa2010469655a4bd58a002993fd..982db6c1fbe77653f6a74a31df5c4e997507d2d8 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -236,12 +236,13 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
+	dma_free_coherent(dev, epf_bar[bar].aligned_size, addr,
 			  epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
 	epf_bar[bar].size = 0;
+	epf_bar[bar].aligned_size = 0;
 	epf_bar[bar].barno = 0;
 	epf_bar[bar].flags = 0;
 }
@@ -264,7 +265,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -285,12 +286,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			return NULL;
 		}
 		size = bar_fixed_size;
+	} else {
+		/* BAR size must be power of two */
+		size = roundup_pow_of_two(size);
 	}
 
-	if (align)
-		size = ALIGN(size, align);
-	else
-		size = roundup_pow_of_two(size);
+	/*
+	 * Allocate enough memory to accommodate the iATU alignment requirement.
+	 * In most cases, this will be the same as .size but it might be different
+	 * if, for example, the fixed size of a BAR is smaller than align.
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -301,7 +307,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;
@@ -310,6 +316,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	epf_bar[bar].phys_addr = phys_addr;
 	epf_bar[bar].addr = space;
 	epf_bar[bar].size = size;
+	epf_bar[bar].aligned_size = aligned_size;
 	epf_bar[bar].barno = bar;
 	if (upper_32_bits(size) || epc_features->bar[bar].only_64bit)
 		epf_bar[bar].flags |= PCI_BASE_ADDRESS_MEM_TYPE_64;
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..749cee0bcf2cc0600ad3be1582b0c497c5a21bed 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -114,6 +114,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @aligned_size: the size actually allocated to accommodate the iATU alignment
+ *                requirement
  * @barno: BAR number
  * @flags: flags that are set for the BAR
  */
@@ -121,6 +123,7 @@ struct pci_epf_bar {
 	dma_addr_t	phys_addr;
 	void		*addr;
 	size_t		size;
+	size_t		aligned_size;
 	enum pci_barno	barno;
 	int		flags;
 };

-- 
2.47.2

