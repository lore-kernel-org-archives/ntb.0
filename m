Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FFF214A8B
	for <ntb@lists.linux.dev>; Fri,  4 Apr 2025 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788799; cv=none; b=D7FimZFil18oHz2QVyn2Lk7WPZoLuWBr6oH3542G0BzUMSQnPsCxr96uz+e27vakqF9ORoK13O1ukcY2ZAwUQVsWqqsHn1h+l+3wuUnWkI49OSdxIBo29m8kQ5RXyFwyqJnRzAPuXobCsat6I3yb060FjwFl4MkH/InXzU8NXoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788799; c=relaxed/simple;
	bh=n0KkujYCmFsi6TCmOtVdMu0bbfrL6UkgnMn4aw3JxJA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Glmzhn8VpbR36pNqwUAtaUYMi41cF97HuLZ1r46x6YGCs99qKr+PWhMI9KYYc98qlQjk+xPodSnhe0LUdWreUhGyH2Gz1XBW4r1YUButMyhmzz1OwFHcgfqVrUvtD1qgmwAod42b23E2A+nyRYn+pRgIxV7fLWFo8pdUhOYaWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=WgLu8qZS; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="WgLu8qZS"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3912d2c89ecso2041460f8f.2
        for <ntb@lists.linux.dev>; Fri, 04 Apr 2025 10:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1743788794; x=1744393594; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=;
        b=WgLu8qZS8euReipRW9SGedfQpA/LXUOuE051dXZSRyeV4aOJ450f5zceB/a4vHLtPz
         7CURJH7sH1urN27/mIIDNJRu1Sf9KqOYOxIJQzsnIJy/hZN0ub97ex8cfpHfHmVS42dd
         UT09/IPRvSnd6UsrSKyMbJFCCKGQc6SLNXImTnh8aOZsJAz0Y2gYmiKzlTBfEJ2s1AMp
         T5VFTgnXPeToK+6orVRP1c1X2O0e4DU1TXt2dE6z7X6gemDCuUpfWh/EHlz9ahU/6j6H
         QjAaXnaXOo0Iiyw4fZZ2jlV/TnXrRDGCv4NxO6FCSiDHTJsJKKboRc8VcPqBno5l2J8A
         CarQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743788794; x=1744393594;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7eFcTw1BBmLsXfJBPUwIPNdKPEmqoZIDDhrBsVYvns=;
        b=pM4k1rWUyQez7/tEW864OZq1K+1BjbQs+UTD+8LnrNSMzzHuMCO5nRcvgXcljxsl/W
         oQvSFiHq5uy0OfsFy1hkES8ULg3ufSkH44agV0LwOiYwTGjcgX+IRpSae5Y8l8yr1h6n
         l5wA7MBW7ezjleFP6s7E7I0/wDwVAbm/M5/vIUjvjaPU9Npa3o7mr0U/HaYuKkURo6qG
         gBCDtitvU2udFIx6pFWFtwLHFuCpDhswI5xRA77v8/yb/OqY84qDVSvCv69JNpp7nd3d
         pGtQluIXo5j2ZHsIx7Ru8Uc0h/ulKsojBqUJ393Z5yK1/Yw6G1QF+oidwr2r3CvOTWVG
         8MWg==
X-Forwarded-Encrypted: i=1; AJvYcCXNyiVQLlJb7n1V8vcaq3MGRpWUYGoLaWRUiPplsPDqdHHyQEB+VH/CuBRX9QtLI+Gc7r8=@lists.linux.dev
X-Gm-Message-State: AOJu0YzE0lv4zgjNG00c1y8q7+jSwUI2XJwCJTvAqQaMPoB9GdsBW4vo
	E6Gl9ywdEhA9wb3Wk43ujcdF3Ivn60r7cF8rTeaHJoDHjyhiXLbfgYwCCJTD4jA=
X-Gm-Gg: ASbGnct+hTGLF9V9+qdig+mRyKYQovAIbeG/Sc7avg6Fe8GesElnoe24AC2cktVoPQY
	kCRLiSD0S5EYf5t8rlLUCedAppipLrF0tTz2bJA/hYqHxAz701kmgOqHAbnzknx3CL9uvUbSnjQ
	pGkfrTtVAtxXIZzOX9GyR4eCPjspMNKlLBpU6aasweqX2gK7nr1nqv7ZG7uyfXfhR6AxxV8y77q
	zmcJ2yI1+aMJU9+As0Dhpiu/jf8Zui5/3ZwiQwUD8XuNP6qDYhue/RZ59Pb9qygVuKWgZzGdDG6
	rN7/71IaGn+3OWHDOGxuCmmpC3h0C2DGW2RPUi8rhomAcFr4/6kTIEin4w==
X-Google-Smtp-Source: AGHT+IEmApi11yA6tOT0eemVOGBTN2LnrWT3UdKLD1oWXnbRDDDJhQjzlClW4YROw282/g4Zg8Ot9A==
X-Received: by 2002:a05:6000:290a:b0:391:41c9:7a87 with SMTP id ffacd0b85a97d-39d14662e92mr3389503f8f.51.1743788794420;
        Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:331:144d:74c3:a7a4])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39c30226dfesm4939535f8f.97.2025.04.04.10.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Apr 2025 10:46:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Fri, 04 Apr 2025 19:46:21 +0200
Subject: [PATCH v2 2/3] PCI: endpoint: improve fixed_size bar handling when
 allocating space
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250404-pci-ep-size-alignment-v2-2-c3a0db4cfc57@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3212; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=n0KkujYCmFsi6TCmOtVdMu0bbfrL6UkgnMn4aw3JxJA=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBn8Br1H2IfezMlXrBbIxRkNQ3j+kTXSTGIJoiCl
 BJLVqqhDXiJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCZ/Aa9QAKCRDm/A8cN/La
 hbZnEACJzgxE9lKIX+NE+nV0iDTm/dKMyc9oMEMR7lXtubsne2ToqmweqeTyZ9sN7Ce+uRFA8SO
 b+32pA6IRIM3ZjjUcmYhG7ampJT3NowyeJUYVwHaAxUOuX3fPbPL5e28cRYLmMuucKj5O7QNwbI
 4dsui7riQUQMOD+zEYSTK3q0HTOc/VVFqSiDosRLVFit8fLfj42jbslafJuqP5DW0514nU1T1b5
 Z3fo4UB35RDZv3wRh3SzclMAzDs9cWD6XZSNOtctlN8uGx4wMMD1MD4R0Wnb+nqBlH04awxi4Xs
 j7PhQHtzCB38TvCJWiXb7BDHCg/H6stmAuTl4I7lmqUyI7YN71yC6kYD8UTpq3qPQl3GgEgChPN
 bdWlJQiid0+nH87x2lTEOeQWqI6pXFMyYu/Y/LiXLYNLxWcN/XxG6YvRy+y78TRY3XRzLHKkFw2
 HbwUX4KhLgmgnLKZYK3jft6zqDJHvpX5Zc/rk73yCo2iPCSQNpM4FjQvJ5WhcHlbMwhCDP90I4/
 HjFhT6t3ynCFcCfWG5h6xEILzloLvfAxALfIdT1u4YLGW+AVBbBYkfbhQUDXBKpJtVEbPKZVMPE
 DJnct5Ml6aKHyxZQA9+yw9e0nbae2XNd13vVFAQuByhwx/BLljKLlcTFp370RVzlcbC7DIbC9WG
 Q85YLg7u/YS3QiA==
X-Developer-Key: i=jbrunet@baylibre.com; a=openpgp;
 fpr=F29F26CF27BAE1A9719AE6BDC3C92AAF3E60AED9

When trying to allocate space for an endpoint function on a BAR with a
fixed size, the size saved in the 'struct pci_epf_bar' should be the fixed
size. This is expected by pci_epc_set_bar().

However, if the fixed_size is smaller that the alignment, the size saved
in the 'struct pci_epf_bar' matches the alignment and it is a problem for
pci_epc_set_bar().

To solve this, continue to allocate space that match the iATU alignment
requirement but save the size that matches what is present in the BAR.

Fixes: 2a9a801620ef ("PCI: endpoint: Add support to specify alignment for buffers allocated to BARs")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/pci/endpoint/pci-epf-core.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index b7deb0ee1760b23a24f49abf3baf53ea2f273476..fb902b751e1c965c902c5199d57969ae0a757c2e 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -225,6 +225,7 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 	struct device *dev;
 	struct pci_epf_bar *epf_bar;
 	struct pci_epc *epc;
+	size_t size;
 
 	if (!addr)
 		return;
@@ -237,9 +238,12 @@ void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 		epf_bar = epf->sec_epc_bar;
 	}
 
+	size = epf_bar[bar].size;
+	if (epc_features->align)
+		size = ALIGN(size, epc_features->align);
+
 	dev = epc->dev.parent;
-	dma_free_coherent(dev, epf_bar[bar].size, addr,
-			  epf_bar[bar].phys_addr);
+	dma_free_coherent(dev, size, addr, epf_bar[bar].phys_addr);
 
 	epf_bar[bar].phys_addr = 0;
 	epf_bar[bar].addr = NULL;
@@ -266,7 +270,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type)
 {
 	u64 bar_fixed_size = epc_features->bar[bar].fixed_size;
-	size_t align = epc_features->align;
+	size_t aligned_size, align = epc_features->align;
 	struct pci_epf_bar *epf_bar;
 	dma_addr_t phys_addr;
 	struct pci_epc *epc;
@@ -287,12 +291,17 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
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
+	 * if, for example, the fixed size of a BAR is smaller than align
+	 */
+	aligned_size = align ? ALIGN(size, align) : size;
 
 	if (type == PRIMARY_INTERFACE) {
 		epc = epf->epc;
@@ -303,7 +312,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 	}
 
 	dev = epc->dev.parent;
-	space = dma_alloc_coherent(dev, size, &phys_addr, GFP_KERNEL);
+	space = dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KERNEL);
 	if (!space) {
 		dev_err(dev, "failed to allocate mem space\n");
 		return NULL;

-- 
2.47.2

