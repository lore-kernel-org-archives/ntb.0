Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E028228EA59
	for <ntb@lists.linux.dev>; Tue, 22 Apr 2025 14:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333679; cv=none; b=SkDCSqI9iQ9+bAIKFn0oOqYypIiXoDdTuLLRX2bR1Gvb2cM6INqW7dwRsNvUcDH67NsNyfN7J/ISnW4g5dP+SfUyYWc1tftBcVKQyvtsqcoyLQdQPB0Ha+s5NiAyEW+21vgwy1Py48i0jIk/Q7ZR+DM5x0y9pSnppd4ODsDfA3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333679; c=relaxed/simple;
	bh=OeAjeCW91zOMarXM0kb3jzoSPAPF26xRkDPsEfYcHsk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h0xj6nhRFGChJM/0SsG5WuaWPjJaWKB2kOrw2x0DSP4Re7kfZozhLwo9o7CEOFnjIE7yilZ8eHwm4HJoi5hwBkdEvbTpANd1sVGGXunoH5+VwV5lnodvh0YpxnuICU5c6+SQlkZ40+kCCi0681eyHEgNmI2Uqc0Q5zax8cfKbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=RSK5wQ1/; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="RSK5wQ1/"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43cf628cb14so46578765e9.1
        for <ntb@lists.linux.dev>; Tue, 22 Apr 2025 07:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745333675; x=1745938475; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ExdkWFS3PjXe/Dbc/bXhKvoVp3dzgWOeR9qxYAnKhmY=;
        b=RSK5wQ1/nr4HnYRsT7bPzXoboKQ+fopnIG7PTZbvLRiU+5W9B8m8WPHi7voWSNr7Iq
         nA2zZsz0miClH4NlVVf6Q5HrnYDvxiOUkrsTXuuOOEm/PTOXHxrxF0GzJOQY5kUbkn6S
         3pxrfqMXAnm/ou0a13jHwuXASqJBEWPw8BLetaO5Cl3O5e5CyOm0cNqEQgApSkoo+tPm
         IRTbS7S45WeuUGvx7GGSdPr0LA51KVu0Bf/vMrZQ7qXmPFzoUdEQ/ymabgbUO39GEZbt
         8g2nvHC5TLsZlG3E/hzDMf/HV0TybbuRJNHbJbkTYkw8qZlLiWyYD3hNmClQ/VcBC9vH
         78WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333675; x=1745938475;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ExdkWFS3PjXe/Dbc/bXhKvoVp3dzgWOeR9qxYAnKhmY=;
        b=eFk6Y2QvYab0o8kpp8D7xXuTPzs+ehi4hxLXWkhdgclBslggBgr1LI20eOI/2IDz+X
         wrAp/CygERMqeBj5vvqrUpRYnSu1bGabD/20ddDtelx9TpzrhcZxF2UNT4iinxK+P11M
         3RxHr0F+hpYQRxak6TfnLWpPDUUNZ+l7PuhIfM9vJ/lzmTJKdSn3UJo+QIouI/dhm9wl
         vdu34COvqX1ZPuoJqbwXUhqMJjet/GOk757VAhJKeXSCgqHx0NxgG9a77xFVMVyWGeTw
         dnywSOuQRrzi4Y4gLDhfWImiAQ8ApTLDWf/nfdJh5dhRuiQ2xlQgJxjF8DtEUKnapiVR
         tPWg==
X-Forwarded-Encrypted: i=1; AJvYcCUrfWbNGMeWIcmHI8LdA4lL3eVFld5h0kMszWyTOL+5f5oceUbTLTLUKANh1g0mPYEqj0U=@lists.linux.dev
X-Gm-Message-State: AOJu0YxTzAsoNVZRrlGFj+mv7zmzunA4DJNAinY62nnQvdRyWnqWjcTP
	NccckrP6oWP/uWXrMLZMwQiIenG39jogjxcGHNn/QDvtGlkI3jdejB6EiXgEYo8t+sR/f0zFk70
	S
X-Gm-Gg: ASbGncsX876qP8iyajF9wG71IK8o3KhWE3Fe6TKVQsp/iz882X+08KHstNlIs83Ezw2
	2XV8lSFML/JEqlj/YFC9PcWeKx0x4nU21X0kqXBkB9MXJzkH2BNx8Yeb86mycLx9coO3XLsWyn6
	0rKJWLwtxNO2Gsk4TubvqdemErplFVzYbOxrAWIwc5LQiplsR1WKELLj9vE++IjlGDcTyce8VBB
	U8yxi+9CXWm6I0gByRbKXsKRD5pJaySkGy4dVc+eBkjkYCQo9TlEz7YRhXFbRF0O5EHspeTlLM3
	aYSDIlqEuvZNQoofmi8Izz4cuQGfpZtLvIZwjeSKUQIBQpqNMuuOH7g=
X-Google-Smtp-Source: AGHT+IEETbq5XFAfg5FeeK1CWsmUukRX4l/5LgF2s+uEV4e4L2MV/SS+HmQwhOulznZpXEph1AgW5g==
X-Received: by 2002:a05:6000:2510:b0:39c:12ce:1112 with SMTP id ffacd0b85a97d-39ef90916b5mr14296744f8f.21.1745333675135;
        Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5f77:7d42:6228:3358])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9de9sm177304635e9.6.2025.04.22.07.54.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:34 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 22 Apr 2025 16:54:19 +0200
Subject: [PATCH v4 1/2] PCI: endpoint: improve fixed_size bar handling when
 allocating space
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pci-ep-size-alignment-v4-1-6bd58443fee9@baylibre.com>
References: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
In-Reply-To: <20250422-pci-ep-size-alignment-v4-0-6bd58443fee9@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4249; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=OeAjeCW91zOMarXM0kb3jzoSPAPF26xRkDPsEfYcHsk=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoB62neNdYS0rNPcjwIqteNfi5mysq9qc+xVwMk
 VScu+42jpqJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAetpwAKCRDm/A8cN/La
 hQMuD/94sBI1ts5f3oxCtZsY9RoXDtXYwn3cTiRTEDYF7fL8Op98EiGWcTYhB4dutn7hTR2d40g
 cXo+mc7XIljWXLXpETSXbyLwK78PqdA868JyvhPAiQOvjjlncWuU6UAhgNM9eJDjVDdagpC9Dqa
 6evRYZS2SBMqfrEXmUDJx4ElUwI8Em2XEAJWCMiSEjzIqqvTtizlKQGRcTGi4AAOdIUcNa9jsr5
 GCR7RXVOkTlo5FEUsh1zmKQcAd0RGnOxL5csgDfmCCRixRzuR+jXWYingmMIscd2d83l5Yk95jt
 WIpZ4Nl6yfQ45BG080rQMK+NwmPedlOByTsUceehldOGPaRn1rYYgZALkrTogPDpZCxzwTa5iLf
 0x9aSfAH9Fcr2sH9YtZcUtnGGQ6+dR6Ta6tczKD8z9NdvUBlqfgM/v2XWi+U4ETMw48xWW8Q4P5
 2d5l1eDB33gO059069B27rorvqYrc2ch6VA6cwIuY1/uJo2AjqLYRaxU7y5gflP/aOGEWZ4a317
 hHX9bRQwouG/qElI3eGPtxQwYeouwFFklJ2n6vdeQmcEvlElMSooKPE3aHO/HKZIvOymUHHw/3J
 xBxL0tAgXRKzZAB5xC1EtcZe53WHlIPCvK9bvr2Pfvcc0AOGfMFJIkD0A+romszh+CWo2Jk/Jwb
 CFFGTHItAq5LAJA==
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
index 879d19cebd4fc6d8df9d724e3a52fa7fbd61e535..23b0878c2665db1c21e6e83543c33149ab1e0009 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -114,6 +114,8 @@ struct pci_epf_driver {
  * @phys_addr: physical address that should be mapped to the BAR
  * @addr: virtual address corresponding to the @phys_addr
  * @size: the size of the address space present in BAR
+ * @aligned_size: the size actually allocated to accommodate the iATU alignment
+ *                requirement.
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

