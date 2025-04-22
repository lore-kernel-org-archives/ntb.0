Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C27AB28EA67
	for <ntb@lists.linux.dev>; Tue, 22 Apr 2025 14:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745333680; cv=none; b=ndzN7iJbQAy3A6kHcOKS7BPdoMZNhNEBMv39P1dZIXJRjK573NuSQh6BqN7BU5/PWNYTxS/D2KgcB7+tWnp+6GiDjaBkdsL5oUiIS//jx5CS6x/1fbZXYFU3gDOAjJ1+qDrCrONdPdYMw+F60+jQLDYSx1FhPq4HY0huPsHViQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745333680; c=relaxed/simple;
	bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nggpm889M0DYz5GwQLujqPcgbjoa3lKNkGebA0tZKRIRb1SFEftMEKr8cyv7pzZhhq68e4aSvvAfXeDmKUlEvHMjsILEUKj3UGfgVoZa0YAg8cbw8vVBHRCa/2Mnrxwjh7f/gx2vOPJNEijCekakTz/BWc0SDB7ZKtzc6e/ulnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bjxr86Gn; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bjxr86Gn"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso44143605e9.3
        for <ntb@lists.linux.dev>; Tue, 22 Apr 2025 07:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745333676; x=1745938476; darn=lists.linux.dev;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=bjxr86Gn5VZu+XcizsLnK7PBrjx9RZ0J8pkegDs2j50w11m6kqXrEPdvGgcB57vMje
         +2m+L+zymLqfdHMh8CAa5P9bwzoD8Zkwx0WP12gkHOxI3tU03IjqZQ3Cmgn5/xMMyEX5
         zlfAvut6IYE7LGaiLs8eEWFuxx8/i+KsNlwpTTamicLXRh0ZLl+rkxYHhYwshfDTHBr3
         iNe0q0I3qsKSWHYylz7ATR95ebufHIp9MEQM+sec8Nkub/6UzRxB3Z4o7twsrVouWQli
         7XHJZvGDcGmY5AKPuHYYq0gSJvnRP99Z5wD8rIE/iubSnyGfpu1KW0dblW/2wAkIwe+f
         5UHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745333676; x=1745938476;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3rDEe0RbbOdS/AATPa77SHHta5wsKCuUdsdnept9/i0=;
        b=SJqbbDOdBwL2ZkwjI7GaZ59mUB52Db3HHphmu38SEuMWI/gnq2KA9M6pLOinV4T8JT
         QIXvareyp5jibKuohF9aIHv10ngH93gmnlCn1TX69ssfEAVfN77mzAeims3rAa+EJOLK
         3wht1j2o4MuV8VPPCU8vEb9ylNSXNOyD7vgWGu23thBbqX/V80++2t2NjvVfPJyPSB7o
         6k/EBRHVI8ErNF+324dhB4G/KqMJ8EcUs9a6M+AFcTlhjn5uaZuGAK5Ga0Sk9sqYgey1
         0ogrSfsgIXUtCx0Mgq/bUQKJfiGEdhZmoV/fNY+s/KWkJCpHG89uP6IYf+NFsADpT0sN
         Nkzg==
X-Forwarded-Encrypted: i=1; AJvYcCV8dbAPlgqFsyASZtd1uiLDgIAtUpPDuLRi46uyDottqTaoNYDz8Uj/hndgtAn4b1I1MZ8=@lists.linux.dev
X-Gm-Message-State: AOJu0YxFIo4x5+7EZDIcrGGMotgfPDfGaeAFKCMmKoXkg8klDW0N4VWR
	LE+6zrACMBt06f3rex9fUDf8DomHpmJdri5fxS92Ad65pEmRHY4x1PFOD6uWRaQ=
X-Gm-Gg: ASbGncvCfQuod7F+BcXcJsFxOpFcLePnv5TXIc9Gjt/r28SjFGHXV8Iw1V9jmJqaVPk
	JPUpIqIxFJXJ9siG3GQ7lM4OiFJq1/AHbhkQ95R8sqgRwP1QfLAX6e5iUEqKR/SwhjZR/2B3/2B
	FCOdiXp6dfELXNlrwd6NruslGY5uY1RHPCvJkM+L1/FzTXlahJDzGCY3ZyXmTwfil6jcOt2Q/fE
	/mq5ai8/P5dBKg6ilnss9a/R6IoTOjsj0mUOV2fmd0iar1j7dpBxxpTnJmAVUkoQ5+4RqqFLiCR
	s56HY5xN+3pgydKt9yM7HGYxHrCTPhFb+zlg4E245WBLgqnTJsNwBdw=
X-Google-Smtp-Source: AGHT+IEHe9ogthRxFY7pkZ9zNymwt1Ec/5ZjUlqRd9V4GcqMYQk4PWKK1SwQmMeK1MT1bv8SF2U33w==
X-Received: by 2002:a05:600c:cc4:b0:43b:d0fe:b8ac with SMTP id 5b1f17b1804b1-4406ac0fcd2mr156057715e9.30.1745333675957;
        Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
Received: from toaster.baylibre.com ([2a01:e0a:3c5:5fb1:5f77:7d42:6228:3358])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4406d5a9de9sm177304635e9.6.2025.04.22.07.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 07:54:35 -0700 (PDT)
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 22 Apr 2025 16:54:20 +0200
Subject: [PATCH v4 2/2] PCI: endpoint: pci-epf-vntb: simplify ctrl/spad
 space allocation
Precedence: bulk
X-Mailing-List: ntb@lists.linux.dev
List-Id: <ntb.lists.linux.dev>
List-Subscribe: <mailto:ntb+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:ntb+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250422-pci-ep-size-alignment-v4-2-6bd58443fee9@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2649; i=jbrunet@baylibre.com;
 h=from:subject:message-id; bh=vNv6q0bb1dhXpfiDx4lYdoPPd0v2qIBg86Rmq+6QIeY=;
 b=owEBbQKS/ZANAwAKAeb8Dxw38tqFAcsmYgBoB62oAlm5zh6kLkXaBtIcf8aDVYddmeLBSWeQi
 XhVglIZiCmJAjMEAAEKAB0WIQT04VmuGPP1bV8btxvm/A8cN/LahQUCaAetqAAKCRDm/A8cN/La
 hSkCD/wNWHhJ4cR/8B3D/R49ys+RdE4Bbqm+jlq1I1CdaFEvLvfu7zqcK2uUCJgEHB/iD/wAKW4
 QGXnhdnuRp6wbcUyqTwLQ/Sph5gS16lt4f0Mni38YYbG/dszfdh75UG42nC6cMc3ygrbCgIzmuG
 lNNawfVSwxxU+D8jPu2Snhi0V4NvlAimuTUvhDkcJfzupu6EoFb9dteMt24N77VXLZG9hP0J26+
 ncsj+RGbYB5clw4CHgk1LgF7BHcHZ/QYRHAfuFqqOcRSrbIQtWsGwPFge8FxvkoJ5pulSf6gtEL
 mWmuOlrToxDkaDqiNTHUDrT/GvKUiSMsfA+zTlbv1oW2bQ015APm0g21MAucgoFLwYX0YXjO7Jy
 MNu1zDU0m+7fg1f09LfG8uubUEn+Dv8Dpp/yYH8v2x5Pfi0ZPFqlXhk35ynAj2G9YbrqarOS5XT
 ykQasjDllM+ulO0ZEQNPZjRKPIa52MWyjOFPloc1ylwcohyQdtUg3VgEmZuSnGvpJmQtOlrJjD5
 +eEMrTMDgaancCIC3bb6CYWs8bzq+/ogx40Ki6dU+9B8Q2YdeYdchCXR/Huo1mXmf3/nNzMEY2F
 6eO1HQ+BhCB95bGVdzq8Wt7N4mjHvC0RkvtCqEBoMq0Vyi+4Hvpw8NROfWKnlVrndqFQFmXBo0S
 CqNTm9baZl4Azzw==
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
index 874cb097b093ae645bbc4bf3c9d28ca812d7689d..e4da3fdb000723e3adad01f0ddf230ecc0e572a7 100644
--- a/drivers/pci/endpoint/functions/pci-epf-vntb.c
+++ b/drivers/pci/endpoint/functions/pci-epf-vntb.c
@@ -408,11 +408,9 @@ static void epf_ntb_config_spad_bar_free(struct epf_ntb *ntb)
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
@@ -422,31 +420,13 @@ static int epf_ntb_config_spad_bar_alloc(struct epf_ntb *ntb)
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

